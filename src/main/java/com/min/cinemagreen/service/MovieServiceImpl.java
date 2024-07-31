package com.min.cinemagreen.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import com.min.cinemagreen.dto.ActorDTO;
import com.min.cinemagreen.dto.DirectorDTO;
import com.min.cinemagreen.dto.MovieDTO;
import com.min.cinemagreen.api.DailyBoxOffice;
import com.min.cinemagreen.api.DailyBoxOfficeApiResponse;
import com.min.cinemagreen.mapper.IMovieMapper;

import lombok.RequiredArgsConstructor;

@Transactional
@RequiredArgsConstructor
@Service
public class MovieServiceImpl implements IMovieService {

  @Qualifier("movieApiRestTemplate")
  private final RestTemplate movieApiRestTemplate;
  private final IMovieMapper movieMapper;
  
  @Transactional(readOnly = true)
  @Override
  public ResponseEntity<List<MovieDTO>> getBoxOfficeList() {

    // API Keys
    String kobisApiKey = "e246df0435b84d071abad3ce5355e26e";
    String kmdbApiKey = "9P1ZGYEJN835397J1D6X";

    // 일일박스오피스 url
    StringBuilder dailyBoxOfficeUrl = new StringBuilder("http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json");
    dailyBoxOfficeUrl.append("?key=").append(kobisApiKey);
    dailyBoxOfficeUrl.append("&targetDt=").append(DateTimeFormatter.ofPattern("yyyyMMdd").format(LocalDate.now().minusDays(2)));  // 현재 날짜 2일 전으로 박스오피스 정보 조회
    
    // 일일박스오피스 요청 및 응답
    DailyBoxOfficeApiResponse dailyBoxOfficeApiResponse = movieApiRestTemplate.getForObject(dailyBoxOfficeUrl.toString(), DailyBoxOfficeApiResponse.class);
    
    // 일일박스오피스 영화 목록 확인을 위한 영화번호 List
    List<Integer> movieNoList = new ArrayList<>();
    
    for(DailyBoxOffice dailyBoxOffice : dailyBoxOfficeApiResponse.getBoxOfficeResult().getDailyBoxOfficeList()) {
    
      // 일일박스오피스 영화 정보
      String movieCd = dailyBoxOffice.getMovieCd();    // 영화코드
      String movieNm = dailyBoxOffice.getMovieNm();    // 영화명
      String openDt = dailyBoxOffice.getOpenDt().replace("-", "");  // 개봉일
      String audiAcc = dailyBoxOffice.getAudiAcc();    //누적관객수
      String salesAcc = dailyBoxOffice.getSalesAcc();  //누적매출액
      
      MovieDTO movie = MovieDTO.builder()
          .movieCd(movieCd)
          .movieNm(movieNm)
          .openDt(openDt)
          .audiAcc(Long.parseLong(audiAcc))
          .salesAcc(Long.parseLong(salesAcc))
          .build();
      
      try {
        // kobis-api 정보 -> movie_t insert 성공( movieNo, movieCd, movieNm, openDt, salesAcc, audiAcc)
        movieMapper.insertMovie(movie);
      } catch (Exception e) {
        // kobis-api 정보 -> movie_t insert 실패 (이미 등록된 영화) -> movie_t update (audiAcc, salesAcc)
        movieMapper.updateMovieAcc(movie);
        continue;  // 이미 등록된 영화라면 kmdb-api 로 요청하지 않는다.
      }

      // movie_t insert 또는 update 된 영화번호
      int movieNo = movie.getMovieNo();
      movieNoList.add(movieNo);
      
      // kmdb-api 요청 주소
      StringBuilder kmdbUrl = new StringBuilder("http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp");
      kmdbUrl.append("?collection=").append("kmdb_new2");
      kmdbUrl.append("&releaseDts=").append(openDt);
      kmdbUrl.append("&title=").append(movieNm);
      kmdbUrl.append("&ServiceKey=").append(kmdbApiKey);
      
      // kmdb-api 요청 및 응답(JSON 형식의 String 반환)
      String strKmdbApiResponse = movieApiRestTemplate.getForObject(kmdbUrl.toString(), String.class);
      
      // JSON 형식의 String 을 JSONObject로 반환 후 처리함 (org.json.JSONObject)
      JSONObject kmdbApiResponse = new JSONObject(strKmdbApiResponse);
      
      // kmdb-api 정보 -> movie_t update (titleEng, titleOrg, plot, runtime, rating, genre, keywords, posterUrl, stillUrl)
      JSONObject result = kmdbApiResponse.getJSONArray("Data").getJSONObject(0).getJSONArray("Result").getJSONObject(0);
      movie.setTitleEng(result.getString("titleEng"));
      movie.setTitleOrg(result.getString("titleOrg"));
      movie.setPlot(result.getJSONObject("plots").getJSONArray("plot").getJSONObject(0).getString("plotText"));
      movie.setRuntime(Integer.parseInt(result.getString("runtime")));
      movie.setRating(result.getString("rating"));
      movie.setGenres(result.getString("genre"));
      movie.setKeywords(result.getString("keywords"));
      movie.setStillUrls(result.getString("stlls"));
      movie.setPosterUrls(result.getString("posters"));
      movieMapper.updateMovieInfo(movie);
      
      // director_t 및 movie_director_match_t
      for(Object object : result.getJSONObject("directors").getJSONArray("director")) {
        JSONObject obj = (JSONObject)object;
        String directorId = obj.getString("directorId");
        if(directorId == null || directorId.isEmpty()) {
          continue;  // director_id 가 없으면 DB 에 저장하지 않는다.
        }
        DirectorDTO director = DirectorDTO.builder()
            .directorId(directorId)
            .directorNm(obj.getString("directorNm"))
            .directorEnNm(obj.getString("directorEnNm"))
            .build();
        try {
          // kmdb-api 정보 -> director_t insert 성공 (directorId, directorNm, directorEnNm)
          movieMapper.insertDirector(director);
        } catch(Exception e) {
          // kmdb-api 정보 -> director_t insert 실패 (이미 등록된 감독) -> 할 일 없음
        }
        movieMapper.insertMovieDirector(Map.of("movieNo", movieNo, "directorId", directorId));
      }
      
      // actor_t 및 movie_actor_match_t
      for(Object object : result.getJSONObject("actors").getJSONArray("actor")) {
        JSONObject obj = (JSONObject)object;
        String actorId = obj.getString("actorId");
        if(actorId == null || actorId.isEmpty()) {
          continue;  // actor_id 가 없으면 DB 에 저장하지 않는다.
        }
        ActorDTO actor = ActorDTO.builder()
            .actorId(actorId)
            .actorNm(obj.getString("actorNm"))
            .actorEnNm(obj.getString("actorEnNm"))
            .build();
        try {
          // kmdb-api 정보 -> actor_t insert 성공 (actorId, actorNm, actorEnNm)
          movieMapper.insertActor(actor);
        } catch(Exception e) {
          // kmdb-api 정보 -> actor_t insert 실패 (이미 등록된 배우)
        }
        movieMapper.insertMovieActor(Map.of("movieNo", movieNo, "actorId", actorId));
      }
      
    }

    return ResponseEntity.ok(movieMapper.getBoxOfficeList(movieNoList));
    
  }
  
  @Transactional(readOnly = true)
  @Override
  public MovieDTO getMovieByNo(int movieNo) {
    return movieMapper.getMovieByNo(movieNo);
  }

}

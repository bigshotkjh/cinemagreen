package com.min.cinemagreen.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.min.cinemagreen.dto.MovieDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MovieAPI {

    private final String REQUEST_URL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";
    private final String AUTH_KEY = "2bc2cd3f6f1740efebb92fe39b0074c3";

    public String makeQueryString(Map<String, String> paramMap) {
        final StringBuilder sb = new StringBuilder();
        paramMap.entrySet().forEach((entry) -> {
            if (sb.length() > 0) {
                sb.append('&');
            }
            sb.append(entry.getKey()).append('=').append(entry.getValue());
        });
        return sb.toString();
    }

    public List<Map<String, String>> requestAPI() {
        Map<String, String> paramMap = new HashMap<>();
        paramMap.put("key", AUTH_KEY);
        paramMap.put("targetDt", "20240717");
        paramMap.put("itemPerPage", "10");
        paramMap.put("multiMovieYn", "Y");
        paramMap.put("repNationCd", "K");

        try {
            URL requestURL = new URL(REQUEST_URL + "?" + makeQueryString(paramMap));
            HttpURLConnection conn = (HttpURLConnection) requestURL.openConnection();
            conn.setRequestMethod("GET");
            conn.setDoInput(true);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            String readline;
            StringBuffer response = new StringBuffer();
            while ((readline = br.readLine()) != null) {
                response.append(readline);
            }
            br.close();

            String responseString = response.toString();
            // responseString : { }
            return parseJsonToDto(responseString);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return new ArrayList<>(); // Return an empty list in case of an error
    }

    private List<Map<String, String>> parseJsonToDto(String jsonString) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            Map<String, Object> map = mapper.readValue(jsonString, Map.class);
            List<Map<String, String>> list = (List<Map<String, String>>) ((Map<String, Object>) map.get("boxOfficeResult")).get("dailyBoxOfficeList");
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @GetMapping("/movies")
    public String getMovies(Model model) {
      List<Map<String, String>> movies = requestAPI();
      for(Map<String, String> movie : movies) {
        System.out.println(movie);
      }
      model.addAttribute("movies", movies);
      return "views/movies"; // main.jsp로 설정
    }
}

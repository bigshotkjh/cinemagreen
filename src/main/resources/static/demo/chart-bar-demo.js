// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

var labels = [];
var data = [];
var topMovies = [
  { movieNm: "-", totalAmount: 0 },
  { movieNm: "-", totalAmount: 0 },
  { movieNm: "-", totalAmount: 0 },
  { movieNm: "-", totalAmount: 0 },
  { movieNm: "-", totalAmount: 0 }
];

fetch('/admin/getDailyAmount.do', {
  method: 'GET',
}).then(response => response.json())
  .then(resData => {
    resData.forEach(movie => {
      const movieIndex = topMovies.findIndex(topMovie => topMovie.movieNm === movie.movieNm);
      if (movieIndex !== -1) {
        topMovies[movieIndex].totalAmount = movie.totalAmount; // 매출 업데이트
      }
    });

    // labels와 data 배열 생성
    topMovies.forEach(movie => {
      labels.push(movie.movieNm ? movie.movieNm : "-"); // 영화 제목이 없으면 "-"로 설정
      data.push(movie.totalAmount || 0); // 매출이 없으면 0으로 설정
    });

    // 일일 매출
    var ctx = document.getElementById("myBarChart");
    var myBarChart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [{
          label: "Revenue",
          backgroundColor: "rgba(30,110,75,1)",
          borderColor: "rgba(70,170,80,1)",
          data: data,
        }],
      },
      options: {
        scales: {
          xAxes: [{
            gridLines: {
              display: false
            },
            ticks: {
              maxTicksLimit: 6
            }
          }],
          yAxes: [{
            ticks: {
              min: 0,
              max: 100000,
              maxTicksLimit: 5
            },
            gridLines: {
              display: true
            }
          }],
        },
        legend: {
          display: false
        }
      }
    });
  })
  .catch(error => {
    console.error("API 호출 중 오류 발생:", error);
  });

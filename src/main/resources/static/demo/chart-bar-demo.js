// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

const labels = [];
const data = [];

// 미리 틀을 만들기
const topMovies = [
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
    resData.forEach((movie, index) => {
      if (index < topMovies.length) {
        topMovies[index].movieNm = movie.movieNm || "-"; // 영화 제목
        topMovies[index].totalAmount = movie.totalAmount || 0; // 매출
      }
    });

    topMovies.forEach(movie => {
      labels.push(movie.movieNm);
      data.push(movie.totalAmount);
    });

    // 일일 매출
    const ctx = document.getElementById("myBarChart");
    const myBarChart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [{
          label: "Revenue",
          backgroundColor: "#95B3A9",
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
              max: 15000,
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
    console.log("API 호출 중 오류 발생:", error);
  });

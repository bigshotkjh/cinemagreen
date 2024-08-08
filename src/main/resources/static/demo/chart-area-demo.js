// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

var weeklabels = [];
var weekdata = [];

// 최근 일주일의 날짜 생성
const today = new Date();
for (let i = 6; i >= 0; i--) {
  const date = new Date(today);
  date.setDate(today.getDate() - i);
  weeklabels.push(date.toISOString().split('T')[0]); // YYYY-MM-DD 형식으로 추가
  weekdata.push(0); // 초기값 0으로 설정
}

fetch('/admin/getWeeklyAmount.do', {
  method: 'GET',
}).then(response => response.json())
  .then(resData => {
    resData.forEach(movie => {
      const payDate = movie.payDate; // YYYY-MM-DD 형식
      const amount = movie.totalAmount;

      // 해당 날짜에 매출 금액을 업데이트
      const index = weeklabels.indexOf(payDate);
      if (index !== -1) {
        weekdata[index] = amount; // 해당 날짜의 매출 금액 업데이트
      }
    });

    // 데이터 확인
    console.log("주간 매출 데이터:");
    console.log("날짜:", weeklabels);
    console.log("총 매출:", weekdata);

    // 데이터가 정상적으로 로드되었는지 확인
    if (weeklabels.length === 0 || weekdata.length === 0) {
      console.error("데이터가 없습니다. 차트를 생성할 수 없습니다.");
      return; // 데이터가 없으면 차트 생성을 중단
    }

    // 주간 매출 추이
    var ctx = document.getElementById("myAreaChart");
    var myLineChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: weeklabels, // 수정
        datasets: [{
          label: "총 매출",
          lineTension: 0.3,
          backgroundColor: "rgba(150,250,85,0.2)",
          borderColor: "rgba(30,110,75,1)",
          pointRadius: 5,
          pointBackgroundColor: "rgba(200,20,20,1)",
          pointBorderColor: "rgba(255,255,255,0.8)",
          pointHoverRadius: 5,
          pointHoverBackgroundColor: "rgba(100,10,10,1)",
          pointHitRadius: 50,
          pointBorderWidth: 2,
          data: weekdata, // 각 날짜에 맞게 들어갈 데이터 값
        }],
      },
      options: {
        scales: {
          xAxes: [{
            time: {
              unit: 'date'
            },
            gridLines: {
              display: false
            },
            ticks: {
              maxTicksLimit: 7
            }
          }],
          yAxes: [{
            ticks: {
              min: 0,
              max: 200000,
              maxTicksLimit: 10
            },
            gridLines: {
              color: "rgba(0, 0, 0, .125)",
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

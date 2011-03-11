$(document).ready(function(){
  
  chart = new Highcharts.Chart({
    chart: {
       width: 900,
       height: 400,
       renderTo: 'chartcontainer',
       defaultSeriesType: 'line',
    },
    title: {
       text: '#{@sprint.name}',
       x: -20 //center
    },
    subtitle: {
       text: '#{@sprint.start_date}',
       x: -20
    },
    xAxis: {
       categories: #{@sprint.days.to_json}
    },
    yAxis: {
       title: {
          text: 'Points'
       },
       plotLines: [{
          value: 0,
          width: 1,
          color: '#808080'
       }],
       max: #{@sprint.total_points},
       min: 0
    },
    tooltip: {
      formatter: function() {
        var completed = #{@sprint.total_points} - this.y;
        var message = '<b>' + this.x + '</b><br/><br/> Completed ' + completed + ' points, still ' + this.y + ' points left.';
        message += '<br />';
        
        return message;
      }
    },
    legend: {
       layout: 'vertical',
       align: 'right',
       verticalAlign: 'top',
       x: -10,
       y: 100,
       borderWidth: 0
    },
    plotOptions: {
      area: {
        fillColor: {
          linearGradient: [0, 0, 0, 300],
          stops: [
            [0, Highcharts.theme.colors[0]],
            [1, 'rgba(2,0,0,0)']
          ]
        },
        lineWidth: 1,
        marker: {
          enabled: false,
          states: {
            hover: {
              enabled: true,
              radius: 5
            }
          }
        },
        shadow: false,
        states: {
          hover: {
            lineWidth: 1            
          }
        }
      }
    },
    series: [
      { name: 'Current progress', data: #{@sprint.points.to_json} },
      { name: 'test 123', data: #{@sprint.correlated_points.to_json} }
      ]
  });
});
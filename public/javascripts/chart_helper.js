/*
  name: 
  width:
  height:
  start_date,
  days,
  total_points
  points
  correlated_points
* 
* */
function buildChart(options){
    chart = new Highcharts.Chart({
    chart: {
       width: options.width,
       height: options.height,
       renderTo: this.attr('id'),
       defaultSeriesType: 'line',
    },
    title: {
       text: options.name,
       x: -20 //center
    },
    subtitle: {
       text: options.start_date,
       x: -20
    },
    xAxis: {
       categories: options.days
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
       max: options.total_points,
       min: 0
    },
    tooltip: {
      formatter: function() {
        var completed = options.total_points - this.y;
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
    series: 
    [
      { name: 'Current progress', data: points },
      { name: 'test 123', data: correlated_points }
    ]
  }); 
}

$.fn.extend({ buildChart: buildChart });


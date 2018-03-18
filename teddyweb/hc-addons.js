$(function () {

    $('#compass').highcharts({
	    chart: {
	        type: 'gauge',
            width: 200,
            height: 200,
            backgroundColor: '#000000',
	        plotBackgroundColor: null,
            plotBackgroundImage: 'compassrose.jpg',
	        plotShadow: false
	    },
	    tooltip: { enabled: false },
	    title: { text: null },
    	credits: { enabled: false },
	    pane: {
	        startAngle: 0,
	        endAngle: 359,
            background: [{ backgroundColor:'rgba(255, 255, 255, 0.1)' }]
	    },
	    plotOptions: {
		    gauge: {
		         dataLabels: { color: '#FF0000', borderWidth: 0, x: 70, y: 60 },
		         dial: { backgroundColor: '#FF8000', baseWidth: 6 },
		         pivot: { backgroundColor: '#EE8000', radius: 7 },
		         enableMouseTracking: false,
		         }
        },
	    // the value axis
	    yAxis: {
	        min: 0,
	        max: 359.99,
	        tickInterval: 45,
	        labels: {
	            step: 1, rotation: 'auto'
	        },
	        title: { text: null },
	        lineColor: '#FFFF00',
			tickColor: '#FFFF00',
            minorTickColor: '#FF8000',
	    },
	    series: [{ data: [20] }]
	},
	function (chart) {
		if (!chart.renderer.forExport) {
		    setInterval(function () {
		        var point = chart.series[0].points[0],
		            newVal,
		            inc = Math.floor(window.steering.value)+180;
		        newVal = inc;
		        point.update(newVal);
		    }, 3000);
		}
	});

    $(document).ready(function() {
        Highcharts.setOptions({
            global: {
                useUTC: false
            }
        });

        var chart;
        $('#powerchart').highcharts({
            chart: {
                width: 200,
                height: 200,
                backgroundColor: '#000000',
                type: 'spline',
                animation: Highcharts.svg, // don't animate in old IE
                marginRight: 10,
                events: {
                    load: function() {

                        // set up the updating of the chart each second
                        var series = this.series[0];
                        setInterval(function() {
                            var x = (new Date()).getTime(), // current time
                                y = Math.random()*800;
                            series.addPoint([x, y], true, true);
                        }, 1000);
                    }
                }
            },
            title: { text: null },
			credits: { enabled: false },
       		legend: { enabled: false },
            xAxis: {
                type: 'datetime',
                tickPixelInterval: 150
            },
            yAxis: {
				min: 0,
                title: {
                    text: 'mAmps'
                },
                plotLines: [{
                    value: 0,
                    width: 1,
                    color: '#808080'
                }]
            },
            plotOptions: {
				    spline: { enableMouseTracking: false }
        	},
            tooltip: { enabled: false },
            legend: {
                enabled: false
            },
            exporting: {
                enabled: false
            },
            series: [{
                name: 'Random data',
                data: (function() {
                    // generate an array of random data
                    var data = [],
                        time = (new Date()).getTime(),
                        i;

                    for (i = -19; i <= 0; i++) {
                        data.push({
                            x: time + i * 1000,
                            y: Math.random()*800
                        });
                    }
                    return data;
                })()
            }]
        });
    });

        $('#irfloor').highcharts({
            chart: { type: 'column', width: 50, height: 200, backgroundColor: '#000000' },
   		    title: { text: null },
   		    credits: { enabled: false },
   		    legend: { enabled: false },
   		    tooltip: { enabled: false },
            xAxis: {
                categories: [ 'Floor' ]
            },
            yAxis: {
                min: 0,
                max: 80,
                opposite: true,
                reversed: true,
                title: { text: null },
				labels: { enabled: false },
            },
            plotOptions: {
                column: {
                    pointPadding: 0.2,
                    borderWidth: 0,
                    enableMouseTracking: false,
                }
            },
            series: [{
            		data: [28],
                    dataLabels: {
                    	enabled: true,
                  	 	color: '#666666',
                 	    align: 'right',
                  	 	x: 2,
                  	 	y: 5,
                  	 	style: {
                        fontSize: '10px',
                        fontFamily: 'Verdana, bold, sans-serif'
                    	}
                    }
                	}]
        });

    $('#sonar').highcharts({
	    chart: { polar: true, type: 'line', width: 230, height: 200, backgroundColor: '#000000',
	             animation: {
                	duration: 330,
                	easing: 'easeInOutSine'
            }
        },
        title: { text: null },
        credits: { enabled: false },
        legend: { enabled: false },
        tooltip: { enabled: false },
	    pane:  { startAngle: 0, endAngle: 360, background: [{ backgroundColor:'#000000' }] },
	    xAxis: {
            tickInterval: 45,
            min: 0,
	        max: 360,
            labels: {
                	style: {
			        fontSize: '9px',
			        fontFamily: 'Verdana, bold, sans-serif',
			        color: '#EEEE00'
                },
                formatter: function () {
	        		return this.value + '\'';
	        	}
            }
	    },
	    yAxis: {
	        min: 0,
            max: 200,
            type: 'linear',
            minorTickInterval: 'auto',
            labels: { enabled: false }
        },
	    plotOptions: {
	        animation: true,
            series: {
                marker: {
                    enabled: false
                }
            },
	        column: {
	            pointPadding: 0,
	            groupPadding: 0
	        },
	    	line: {
		         enableMouseTracking: false
		    }
	    },
        series: [{
	        type: 'spline',
            data: [ [0,20],[45,15],[180,16],[315,15] ],
            color: '#80FF80'
	    },{
	        type: 'area',
            data: [ [5,20],[45,15],[135,16],[225,16],[315,15],[355,20] ],
            color: '#FF8040'
	    }],
	   },

    		    function (chart) {
			if (!chart.renderer.forExport) {
			    setInterval(function () {
				   chart.series[0].data[0].update(Math.random()*(200-20)+20,0);
				   chart.series[0].data[1].update(Math.random()*(200-15)+15,0);
				   chart.series[0].data[2].update(Math.random()*(200-16)+16,0);
				   chart.series[0].data[3].update(Math.random()*(200-15)+15,0);
				   chart.redraw();
			    }, 1000);
			}
	});

});

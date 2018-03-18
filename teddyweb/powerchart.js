	var xValues = [], yValues = [];
	var randomDataValuesCount = 10;
	var duration = 3000;
	var idx = 0;
	var intervalRadomData = null;

	$(document).ready(function () {
	    for (idx = 0; idx < randomDataValuesCount; idx++) {
		xValues.push(idx);
		yValues.push(createRandomValue());
	    }

            //powerchart
	    $("#powerchart").wijlinechart({
		showChartLabels: true,
		chartLabelStyle: { fill: "#DDDDDD" },
		width: 320,
		height: 240,
		shadow: true,
		animation: {
		    enabled: false
		},
		seriesTransition: {
		    enabled: false
		},
		legend: { visible: false },
		hint: { enable: false },
		header: { text: "Power Current (mA)",
			  textStyle: {
				fill: "#EEEEEE"
				  }
		},
		axis:
		{
		    x: { textVisible: false, labels: { style: { fill: "#AAAAAA" } } },
		    y: { labels: { style: { fill: "#AAAAAA" } },  min: 0, max: 12500, autoMin: true, autoMax: true, textStyle: { fill: "#AAAAAA" } }
		},
		seriesList: [
		    {
			data: {
			    x: xValues,
			    y: yValues
			},
			markers: {
			    visible: true,
			    type: "circle"
			}
		    }
		],
		seriesStyles: [{ "stroke-width": "3", stroke: "#00a6dd"}],
		seriesHoverStyles: [{ "stroke-width": "4"}]

	    });

	    animateChart();

	    intervalRadomData = setInterval(function () {
		$("#powerchart").wijlinechart("addSeriesPoint", 0, { x: idx++, y: createRandomValue() }, true);
		animateChart();
	    }, duration);




	   //compass 
	   $("#compass").wijradialgauge({ 
		value: 55,
		radius: 360,
		sweepAngle: 360,
		width: 120,
		height: 120,
		startAngle: 90,
		min: 0,
		max: 359,
		pointer: {
                    length: 0.12,
                    offset: 0,
                    shape: "tri",
                    width: 8,
                    style: {
                        fill: "#FF8000",
                        stroke: "#FFEE00"
                    }
                },
                cap: { 
		     radius: 5, 
		     style: {fill: "red", stroke: "red"}, 
		     behindPointer: false
 		},
		face: {
		    style: { },
		    template: function (ui) {
			var url = "compassrose.jpg";
			return ui.canvas.image(url, ui.origin.x - ui.r, ui.origin.y - ui.r, ui.r * 2, ui.r * 2);
		    }
		}
	    }); 

	    
	   //ptzpose1 
	   $("#ptzpose1").wijradialgauge({ 
		value: 90,
		startAngle: 0,
		sweepAngle: 180,
		labels: {visible: false},
		tickMajor: {visible: false},
		tickMinor: {visible: false},
		origin: { x: 0.5, y: 1 },
		width: 120,
		height:120,
		startAngle: 0,
		min: 0,
		max: 180
  	    }); 
  	    
	    //ptzpose2
	    $("#ptzpose2").wijlineargauge({ 
                value: 180,
		width: 40,
		height:120,
		marginLeft: 0,
		marginRight: 0,
		labels: {visible: false},
		tickMajor: {visible: false},
		tickMinor: {visible: false},
                orientation: "vertical",
                min: 0,
		max: 359
            });   	    
	    

	   //headpose1 
	   $("#headpose1").wijradialgauge({ 
		value: 513,
		startAngle: 0,
		sweepAngle: 180,
		labels: {visible: false},
		tickMajor: {visible: false},
		tickMinor: {visible: false},
		marginLeft: 0,
		marginRight: 0,
		origin: { x: 0.5, y: 1 },
		width: 120,
		height:120,
		startAngle: 0,
		min: 0,
		max: 1023
  	    }); 	    
	    
	    //headpose2
	    $("#headpose2").wijlineargauge({ 
                value: 513,
		width: 40,
		height:120,
		marginLeft: 0,
		marginRight: 0,
		labels: {visible: false},
		tickMajor: {visible: false},
		tickMinor: {visible: false},
                orientation: "vertical",
                min: 0,
		max: 1023
            }); 
   
   	    $("#ptzzoom").wijslider({
                   orientation: "horizontal",
                   min: 0,
                   max: 255,
                   step: 5,
                   value: 0                
            });
   
	});

	function animateChart() {
	    var path = $("#powerchart").wijlinechart("getLinePath", 0);
	    var markers = $("#powerchart").wijlinechart("getLineMarkers", 0);
	    var box = path.getBBox();
	    var width = $("#powerchart").wijlinechart("option", "width") / 10;
	    path.animate({ translation: -width + ", 0" }, duration);
	    if (path.shadow) {
		var pathShadow = path.shadow;
		pathShadow.animate({ translation: -width + ", 0" }, duration);
	    }
	    markers.animate({ translation: -width + ", 0" }, duration);
	    var rect = box.x + " " + (box.y - 5) + " " + box.width + " " + (box.height + 10);
	    path.wijAttr("clip-rect", rect);
	    markers.attr("clip-rect", rect);
	}

	function createRandomValue() {
	    var val = Math.round(Math.random() * 1000);
	    return val;
	}

	function dispose() {
	    if (intervalRadomData) {
		clearInterval(intervalRadomData);
		intervalRadomData = null;
	    }
	}
	
	function doCompass(num) {
	    $("#compass").wijradialgauge({value: num});
	    animateChart();
	}

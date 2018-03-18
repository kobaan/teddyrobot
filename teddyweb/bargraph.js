(function () {

	function createCanvas(divName) {

		var div = document.getElementById(divName);
		var canvas = document.createElement('canvas');
		div.appendChild(canvas);
		if (typeof G_vmlCanvasManager != 'undefined') {
			canvas = G_vmlCanvasManager.initElement(canvas);
		}
		var ctx = canvas.getContext("2d");
		return ctx;
	}

	var ctx1 = createCanvas("sonarfront");
	var graph1 = new BarGraph(ctx1);
	graph1.maxValue = 200;
	graph1.margin = 0;
	graph1.height = 60;
	graph1.width = 60;
	graph1.colors = ["#E0E040"];
	graph1.backgroundColor = "#000";
	setInterval(function () {
		graph1.update([Math.random() * 180]);
	}, 1000);
	var ctx2 = createCanvas("sonarleft");
	var graph2 = new BarGraph(ctx2);
	graph2.maxValue = 200;
	graph2.margin = 0;
	graph2.height = 60;
	graph2.width = 60;
	graph2.colors = ["#FF0000"];
	graph2.backgroundColor = "#000";
	setInterval(function () {
		graph2.update([Math.random() * 110]);
	}, 1000);
	var ctx3 = createCanvas("sonarright");
	var graph3 = new BarGraph(ctx3);
	graph3.maxValue = 200;
	graph3.margin = 0;
	graph3.height = 60;
	graph3.width = 60;
	graph3.colors = ["#00FF00"];
	graph3.backgroundColor = "#000";
	setInterval(function () {
		graph3.update([Math.random() * 110]);
	}, 1000);
	var ctx4 = createCanvas("sonarrear");
	var graph4 = new BarGraph(ctx4);
	graph4.maxValue = 200;
	graph4.margin = 0;
	graph4.height = 60;
	graph4.width = 60;
	graph4.colors = ["#8080FF"];
	graph4.backgroundColor = "#000";
	setInterval(function () {
		graph4.update([Math.random() * 200]);
	}, 1000);

	var ctx5= createCanvas("irfloor");

	var graph5 = new BarGraph(ctx5);
	graph5.maxValue = 80;
	graph5.margin = 0;
	graph5.height = 160;
	graph5.width = 30;
	graph5.colors = ["#E08020"];
	graph5.backgroundColor = "#000";
	setInterval(function () {
		graph5.update([Math.random() * 80]);
	}, 1000);

	var c2 = createCanvas("robotsvg");
	c2.canvas.width=60;
	c2.canvas.height=80;
	var x_off = 10;
	var y_off = 15;
	c2.fillStyle = '#f00';
	c2.beginPath();
	c2.moveTo(15+x_off,5+y_off);
	c2.lineTo(0+x_off,20+y_off);
	c2.lineTo(0+x_off,60+y_off);
	c2.lineTo(40+x_off,60+y_off);
	c2.lineTo(40+x_off,20+y_off);
	c2.lineTo(25+x_off,5+y_off);
	c2.lineTo(20+x_off,5+y_off);
	c2.closePath();
	c2.fill();
	
}());

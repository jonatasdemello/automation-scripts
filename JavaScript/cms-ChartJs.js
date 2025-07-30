
https://stackoverflow.com/questions/6857468/converting-a-js-object-to-an-array-using-jquery
https://stackoverflow.com/questions/19590865/from-an-array-of-objects-extract-value-of-a-property-as-array


If you are looking for a functional approach:

var obj = {1: 11, 2: 22};
var arr = Object.keys(obj).map(function (key) { return obj[key]; });

Results in:

[11, 22]

The same with an ES6 arrow function:

Object.keys(obj).map(key => obj[key])

With ES7 you will be able to use Object.values instead (more information):

var arr = Object.values(obj);

Or if you are already using Underscore/Lo-Dash:

var arr = _.values(obj)



var myObj = {
    1: [1, 2, 3],
    2: [4, 5, 6]
};

var array = $.map(myObj, function(value, index) {
    return [value];
});

console.log(array);


Yes, but it relies on an ES5 feature of JavaScript. This means it will not work in IE8 or older.

var result = objArray.map(function(a) {return a.foo;});

On ES6 compatible JS interpreters you can use an arrow function for brevity:

var result = objArray.map(a => a.foo);




-------------------------------------------------------------------------------------------------------------------------------

I have JavaScript object array with the following structure:

objArray = [ { foo: 1, bar: 2}, { foo: 3, bar: 4}, { foo: 5, bar: 6} ];

I want to extract a field from each object, and get an array containing the values, for example field foo would give array [ 1, 3, 5 ].

I can do this with this trivial approach:

function getFields(input, field) {
    var output = [];
    for (var i=0; i < input.length ; ++i)
        output.push(input[i][field]);
    return output;
}

var result = getFields(objArray, "foo"); // returns [ 1, 3, 5 ]


Here is a shorter way of achieving it:

let result = objArray.map(a => a.foo);

OR

let result = objArray.map(({ foo }) => foo)

//-------------------------------------------------------------------------------------------------------------------------------

https://github.com/chartjs/Chart.js/blob/master/docs/scripts/utils.js


https://github.com/kurkle/color/tree/main/src

https://github.com/chartjs/Chart.js/blob/master/docs/samples/bar/horizontal.md

https://chartjs-plugin-datalabels.netlify.app/guide/

https://chartjs-plugin-datalabels.netlify.app/guide/getting-started.html#registration
https://chartjs-plugin-datalabels.netlify.app/guide/positioning.html#alignment-and-offset

https://www.chartjs.org/docs/latest/samples/bar/horizontal.html


https://www.chartjs.org/docs/latest/developers/plugins.html

// Register the plugin to all charts:
Chart.register(ChartDataLabels);

// OR only to specific charts:
var chart = new Chart(ctx, {
  plugins: [ChartDataLabels],
  options: {
    // ...
  }
})


		const DATA_COUNT = 7;
		const NUMBER_CFG = { count: DATA_COUNT, min: -100, max: 100 };
		const labels = Utils.months({ count: 7 });
		const data = {
			labels: labels,
			datasets: [
				{
					label: 'Dataset 1',
					data: Utils.numbers(NUMBER_CFG),
					borderColor: Utils.CHART_COLORS.red,
					backgroundColor: Utils.transparentize(Utils.CHART_COLORS.red, 0.5),
				},
				{
					label: 'Dataset 2',
					data: Utils.numbers(NUMBER_CFG),
					borderColor: Utils.CHART_COLORS.blue,
					backgroundColor: Utils.transparentize(Utils.CHART_COLORS.blue, 0.5),
				}
			]
		};

		const config = {
			type: 'bar',
			data: data,
			options: {
				indexAxis: 'y',
				// Elements options apply to all of the options unless overridden in a dataset
				// In this case, we are setting the border of each horizontal bar to be 2px wide
				elements: {
					bar: {
						borderWidth: 2,
					}
				},
				responsive: true,
				plugins: {
					legend: {
						position: 'right',
					},
					title: {
						display: true,
						text: 'Chart.js Horizontal Bar Chart'
					}
				}
			},
		};
		const ctx = document.getElementById('myChart');
		new Chart(ctx, config);

		//new Chart(ctx, {
		//	type: 'bar',
		//	data: {
		//		labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
		//		datasets: [{
		//			label: '# of Votes',
		//			data: [12, 19, 3, 5, 2, 3],
		//			borderWidth: 1
		//		}]
		//	},
		//	options: {
		//		scales: {
		//			y: {
		//				beginAtZero: true
		//			}
		//		}
		//	}
		//});


// -------------------------------------------------------------------------------------------------------------------------------
// older

	<script type="text/javascript" src="~/Chart.js/chart.umd.js"></script>
	<script type="text/javascript" src="~/chartjs-plugin-datalabels/chartjs-plugin-datalabels.js"></script>
	<script>
		// Register the plugin to all charts:
		Chart.register(ChartDataLabels);

		const COLORS = [
			'#4dc9f6',
			'#f67019',
			'#f53794',
			'#537bc4',
			'#acc236',
			'#166a8f',
			'#00a950',
			'#58595b',
			'#8549ba'
		];
		const CHART_COLORS = {
			red: 'rgb(255, 99, 132)',
			orange: 'rgb(255, 159, 64)',
			yellow: 'rgb(255, 205, 86)',
			green: 'rgb(75, 192, 192)',
			blue: 'rgb(54, 162, 235)',
			purple: 'rgb(153, 102, 255)',
			grey: 'rgb(201, 203, 207)',
			black: 'rgb(0, 0, 0)',
		};
		const NAMED_COLORS = [
			CHART_COLORS.red,
			CHART_COLORS.orange,
			CHART_COLORS.yellow,
			CHART_COLORS.green,
			CHART_COLORS.blue,
			CHART_COLORS.purple,
			CHART_COLORS.grey,
		];
		const CHART_BG_COLORS = {
			red: 'rgba(255, 99, 132, 0.2)',
			orange: 'rgba(255, 159, 64, 0.2)',
			yellow: 'rgba(255, 205, 86, 0.2)',
			green: 'rgba(75, 192, 192, 0.2)',
			blue: 'rgba(54, 162, 235, 0.2)',
			purple: 'rgba(153, 102, 255, 0.2)',
			grey: 'rgba(201, 203, 207, 0.2)',
			black: 'rgba(0, 0, 0, 0.2)'
		};

		function DrawChartJs(ChartType, ChartTitle, ChartObjectId) {

			// 1. define columns
			var ApiData = {};

			// 2. allback that creates and populates a data table
			function drawSchoolChart() {

				let labelUserName = ApiData.map(a => a.workflowUserName);
				let ds1 = ApiData.map(a => a.assigned);
				let ds2 = ApiData.map(a => a.workInProgress);
				let ds3 = ApiData.map(a => a.completed);

				const data = {
					labels: labelUserName,
					datasets: [
						{
							label: 'Assigned',
							data: ds1,
							backgroundColor: CHART_COLORS.orange,
						},
						{
							label: 'WorkInProgress',
							data: ds2,
							backgroundColor: CHART_COLORS.blue,
						},
						{
							label: 'Completed',
							data: ds3,
							backgroundColor: CHART_COLORS.green,
						}
					]
				};
				const config = {
					type: 'bar',
					data: data,
					options: {
						indexAxis: 'y',
						elements: {
							bar: {
								borderWidth: 2,
								borderColor: CHART_BG_COLORS.black
							}
						},
						responsive: true,
						plugins: {
							title: {
								display: true,
								text: ChartTitle
							},
							datalabels: {
								anchor: 'end',
								align: 'end',
								offset: '10'
							}
						}
					},
				};

				const ctx = document.getElementById(ChartObjectId);
				new Chart(ctx, config);
			}

			// 3. pull data from API
			$.ajax({
				url: BASE_URL + "/GetChartData/",
				data: { profileTypeId: ChartType },
				dataType: "json",
				type: "GET",
				contentType: "application/json; chartset=utf-8",
				success: function (data) {
					console.log(data);
					ApiData = data;
				},
				error: function () {
					$(ChartObjectId).remove();
				}
			}).done(function () {
				// Set a callback to run when data is ready.
				drawSchoolChart();
			});
		}
		$(document).ready(function () {
			BASE_URL = location.protocol + "//" + location.host + "/report";

			let ChartType = 2; // School
			let ChartTitle = 'School Progress';
			let ChartObjectId = 'schoolChart';

			DrawChartJs(ChartType, ChartTitle, ChartObjectId);

			let ChartType = 3; // Program
			let ChartTitle = 'Program Progress';
			let ChartObjectId = 'programChart';

			DrawChartJs(ChartType, ChartTitle, ChartObjectId);
		});
	</script>

	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script>

		// Load the Visualization API and the corechart package.
		google.charts.load('current', { 'packages': ['corechart'] });

		// only run after the page is loaded
		$(document).ready(function () {

			BASE_URL = location.protocol + "//" + location.host + "/report";

			// 1. define columns
			var schoolPieChartData = [['WorkflowStepName', 'WorkflowStepCount']];
			// 2. callback that creates and populates a data table
			function drawSchoolPieChart() {
				var data = google.visualization.arrayToDataTable(schoolPieChartData);
				var view = new google.visualization.DataView(data);
				var options = {
					title: "School Progress",
					sliceVisibilityThreshold: 0,
					pieSliceText: "value",
					legend: {
						position: 'left'
					},
					titleTextStyle: {
						fontSize: 24
					}
				};
				// Instantiate and draw our chart
				var chart = new google.visualization.PieChart(document.getElementById("school_piechart_div"));
				chart.draw(view, options);
			}
			// 3. pull data from API
			$.ajax({
				url: BASE_URL + "/GetPieChartData/",
				data: { profileTypeId: 2 },
				dataType: "json",
				type: "GET",
				contentType: "application/json; chartset=utf-8",
				success: function (data) {
					for (var prop in data) {
						var arr = [
							data[prop].workflowStepName,
							data[prop].workflowStepCount
						];
						schoolPieChartData.push(arr);
					}
				},
				error: function () {
					$('school_piechart_div').remove();
				}
			}).done(function () {
				// Set a callback to run when the Google Visualization API is loaded.
				google.charts.setOnLoadCallback(drawSchoolPieChart);
			});

			// 1. define columns
			var schoolChartData = [['WorkflowUserName', 'Assigned', 'WorkInProgress', 'Completed']];
			// 2. allback that creates and populates a data table
			function drawSchoolChart() {
				var data = google.visualization.arrayToDataTable(schoolChartData);
				var view = new google.visualization.DataView(data);
				view.setColumns([0,
					1, { calc: "stringify", sourceColumn: 1, type: "string", role: "annotation" },
					2, { calc: "stringify", sourceColumn: 2, type: "string", role: "annotation" },
					3, { calc: "stringify", sourceColumn: 3, type: "string", role: "annotation" }
				]);
				var options = {
					title: "School Update Status"
				};
				var chart = new google.visualization.BarChart(document.getElementById("school_chart_div"));
				chart.draw(view, options);
			}
			// 3. pull data from API
			$.ajax({
				url: BASE_URL + "/GetChartData/",
				data: { profileTypeId: 2 },
				dataType: "json",
				type: "GET",
				contentType: "application/json; chartset=utf-8",
				success: function (data) {
					for (var prop in data) {
						var arr = [
							data[prop].workflowUserName,
							data[prop].assigned,
							data[prop].workInProgress,
							data[prop].completed
						];
						schoolChartData.push(arr);
					}
				},
				error: function () {
					$('program_chart_div').remove();
				}
			}).done(function () {
				// Set a callback to run when the Google Visualization API is loaded.
				google.charts.setOnLoadCallback(drawSchoolChart);
			});

			// 1. define columns
			var programChartData = [['UserName', 'Assigned', 'WorkInProgress', 'Completed']];
			// 2. callback that creates and populates a data table
			function drawProgramChart() {
				var data = google.visualization.arrayToDataTable(programChartData);
				var view = new google.visualization.DataView(data);
				view.setColumns([0,
					1, { calc: "stringify", sourceColumn: 1, type: "string", role: "annotation" },
					2, { calc: "stringify", sourceColumn: 2, type: "string", role: "annotation" },
					3, { calc: "stringify", sourceColumn: 3, type: "string", role: "annotation" }
				]);
				var options = {
					title: "Program Update Status"
				};
				var chart = new google.visualization.BarChart(document.getElementById("program_chart_div"));
				chart.draw(view, options);
			}
			// 3 .pull data from API
			$.ajax({
				url: BASE_URL + "/GetChartData/",
				data: { profileTypeId: 3 },
				dataType: "json",
				type: "GET",
				contentType: "application/json; chartset=utf-8",
				success: function (data) {
					for (var prop in data) {
						var arr = [
							data[prop].workflowUserName,
							data[prop].assigned,
							data[prop].workInProgress,
							data[prop].completed
						];
						programChartData.push(arr);
					}
				},
				error: function () {
					$('program_chart_div').remove();
				}
			}).done(function () {
				// Set a callback to run when the Google Visualization API is loaded.
				google.charts.setOnLoadCallback(drawProgramChart);
			});

		});
	</script>
}

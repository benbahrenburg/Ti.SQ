var sq = require('ti.sq');
Ti.API.info("module is => " + sq);

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'#fff'
});

var calendarView = sq.createView({
	height:Ti.UI.FILL,
	width:Ti.UI.FILL,
	value:{
		month:1,day:1,year:2014
	},		
	min:{
		month:1,day:11,year:2014
	},
	max:{
		month:10,day:15,year:2014
	},
	selectedDates: [
		{month:2,day:17,year:2014},
		{month:4,day:21,year:2014},
		{month:4,day:26,year:2014},
		{month:6,day:1,year:2014}
	]
});
win.add(calendarView);		
calendarView.addEventListener('dateChanged',function(d){
	Ti.API.info(JSON.stringify(d.dateValue));
	Ti.API.info(JSON.stringify(d.value));
	Ti.API.info(JSON.stringify(calendarView.value));
});
	
win.open();

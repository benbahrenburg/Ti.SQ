var sq = require('ti.sq');
Ti.API.info("module is => " + sq);

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'#fff'
});

var calendarView = sq.createView({
	height:Ti.UI.FILL,
	width:Ti.UI.FILL,
	pagingEnabled:true,
	value:{
		month:4,day:15,year:2014
	},		
	min:{
		month:1,day:15,year:2014
	},
	max:{
		month:10,day:15,year:2014
	}
});
win.add(calendarView);		
calendarView.addEventListener('dateChanged',function(d){
	Ti.API.info(JSON.stringify(d.dateValue));
	Ti.API.info(JSON.stringify(d.value));
	Ti.API.info(JSON.stringify(calendarView.value));
});
	
win.open();

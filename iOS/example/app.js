var sq = require('ti.sq');
Ti.API.info("module is => " + TiSQ);

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white'
});

var calendarView = sq.createView({
	height:Ti.UI.FILL,
	width:Ti.UI.FILL
});

win.add(calendarView);

win.open({modal:true});

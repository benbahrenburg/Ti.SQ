var sq = require('ti.sq');
Ti.API.info("module is => " + sq);

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'#fff'
});

var calendarView = sq.createView({
	height:Ti.UI.FILL,
	top:0, bottom:'40dp',
	pagingEnabled:true,
	value:{
		month:6,day:10,year:2013
	},		
	min:{
		month:2,day:15,year:2013
	},
	max:{
		month:10,day:15,year:2013
	}
});
win.add(calendarView);

calendarView.addEventListener('dateChanged',function(d){
	Ti.API.info(JSON.stringify(d));
	Ti.API.info(JSON.stringify(d.dateValue));
	Ti.API.info(JSON.stringify(d.value));
	Ti.API.info(JSON.stringify(calendarView.value));	
})	

var button = Ti.UI.createButton({
	title:'Click to get selected value',
	height:'40dp', width:Ti.UI.FILL, bottom:0
});		
win.add(button);

button.addEventListener('click',function(d){
	Ti.API.info(JSON.stringify(calendarView.value));
	alert(String.formatDate(calendarView.value,"long"));
})	
	
win.open();

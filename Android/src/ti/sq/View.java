package ti.sq;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import org.appcelerator.titanium.view.TiUIView;
import org.appcelerator.kroll.KrollDict;
import org.appcelerator.titanium.proxy.TiViewProxy;
import org.appcelerator.kroll.common.Log;
import com.squareup.timessquare.CalendarPickerView;
import com.squareup.timessquare.CalendarPickerView.OnDateSelectedListener;
import com.squareup.timessquare.CalendarPickerView.SelectionMode;

public class View  extends TiUIView  
{
		private static final String PROPERTY_VALUE = "value";
		private static final String PROPERTY_MIN = "min";
		private static final String PROPERTY_MAX = "max";
		private onClickListener clickListener = null;
		public View(TiViewProxy proxy) 
		{

			super(proxy);

			 Calendar start = Calendar.getInstance();
			 // add year to current date
			 start.add(Calendar.YEAR, -1);
			 //Log.d(TisqModule.MODULE_SHORT_NAME,"[$DEBUG$] start date = " + start.getTime().toString());
			 
			 // add minus value
			 Calendar end = Calendar.getInstance();
			 end.add(Calendar.YEAR, 1);
			 //Log.d(TisqModule.MODULE_SHORT_NAME,"[$DEBUG$] end date = " + end.getTime().toString());
			
			 //Create an instance of the CalendarPickerView
			 CalendarPickerView calendar = 
					new CalendarPickerView(proxy.getActivity(),null);
			 
			 //Initialize the picker with our initial values
			 calendar.init(start.getTime(), end.getTime()) 
		        .inMode(SelectionMode.SINGLE) 
		        .withSelectedDate(new Date());

			// Set the view as the native view. You must set the native view
			// for your view to be rendered correctly.
			setNativeView(calendar);
		}
		
		@Override
		public void processProperties(KrollDict props) 
		{
			super.processProperties(props);

			// Check if the color is specified when the view was created
			if ((props.containsKey(PROPERTY_VALUE)) &&
					(props.containsKey(PROPERTY_MAX)) &&
					(props.containsKey(PROPERTY_MIN))){	
					
				Date minValue  = convertHMtoDate(props.getKrollDict(PROPERTY_MIN));				
				//Log.d(TisqModule.MODULE_SHORT_NAME,"[$DEBUG$] INIT minValue" + minValue);

				Date maxValue  = convertHMtoDate(props.getKrollDict(PROPERTY_MAX));				
				//Log.d(TisqModule.MODULE_SHORT_NAME,"[$DEBUG$] INIT maxValue" + maxValue);
			
				Date newValue  = convertHMtoDate(props.getKrollDict(PROPERTY_VALUE));				
				//Log.d(TisqModule.MODULE_SHORT_NAME,"[$DEBUG$] INIT newValue" + newValue);
	
			      if (newValue.before(minValue) || newValue.after(maxValue)) {
			    	  Log.d(TisqModule.MODULE_SHORT_NAME,"value:" +  newValue + " must be between min " 
			    			  	+ minValue + " and max " + maxValue);
			    	  Log.d(TisqModule.MODULE_SHORT_NAME,"min value used instead");
			    	  newValue = minValue;
			      }
			      
				CalendarPickerView square = (CalendarPickerView)getNativeView();
				
				square.init(minValue, maxValue) 
							.inMode(SelectionMode.SINGLE) 
							.withSelectedDate(newValue);
				
				square.invalidate();
			}
			if(clickListener==null){
				clickListener= new onClickListener();
			}			
			CalendarPickerView square = (CalendarPickerView)getNativeView();
			square.setOnDateSelectedListener(clickListener);
			
		}
		private Date convertKDtoDate(KrollDict args)
		{
			int month = args.optInt("month", 1);
			int day = args.optInt("day", 1);
			int year = args.optInt("year", 2000);

			Calendar calendar = Calendar.getInstance();
			calendar.set(Calendar.YEAR, year);
			// Note: Month is zero-based
			calendar.set(Calendar.MONTH, month - 1);
			calendar.set(Calendar.DAY_OF_MONTH, day);
			return calendar.getTime();
		}
		@SuppressWarnings({ "rawtypes", "unchecked" })
		private Date convertHMtoDate(HashMap hm)
		{
			KrollDict args = new KrollDict(hm);
			return convertKDtoDate(args);
		}

		@SuppressWarnings({ "rawtypes" })
		public void setValue(HashMap hm)
		{
			Date newValue = convertHMtoDate(hm);
			CalendarPickerView square = (CalendarPickerView)getNativeView();
			square.selectDate(newValue);
		}
		
		public Date getValue(){
			CalendarPickerView square = (CalendarPickerView)getNativeView();
			return square.getSelectedDate();
		}		
		
		public Date getMin(){
			CalendarPickerView square = (CalendarPickerView)getNativeView();
			return square.getMinCalendar().getTime();
		}
		
		public Date getMax(){
			CalendarPickerView square = (CalendarPickerView)getNativeView();
			return square.getMaxCalendar().getTime();
		}
		
		private HashMap<String, Object> formatEventDate(Date date)
		{
			Calendar cal = Util.DateToCalendar(date);
			HashMap<String, Object> results = new HashMap<String, Object>();
			results.put("year",cal.get(Calendar.YEAR));
			results.put("month",(cal.get(Calendar.MONTH)-1));
			results.put("day",cal.get(Calendar.DAY_OF_MONTH));
			return results;
		}
		private void doFireClicked(Date date){
			
			if (proxy.hasListeners("dateChanged")) {						
				//Build our event payload
				HashMap<String, Object> event = new HashMap<String, Object>();
				event.put("value",formatEventDate(date));
				event.put("dateValue",date);
				proxy.fireEvent("dateChanged", event);
			}else{
				Util.LogDebug("dateChange listener not found");
			}
		};
		//Create a callback call so we can fire a listener
		private class onClickListener implements OnDateSelectedListener {
			@Override
			public void onDateSelected(Date date) {
				doFireClicked(date);				
			}
		}
}

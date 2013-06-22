package ti.sq;

import java.util.Calendar;
import java.util.Date;

import org.appcelerator.kroll.common.Log;

public class Util {

	public static void LogInfo(String message)
	{
		Log.i(TisqModule.MODULE_SHORT_NAME,message);			
	}
	public static void LogError(String message)
	{
		Log.e(TisqModule.MODULE_SHORT_NAME,message);			
	}
	public static void LogDebug(String message)
	{
		if(TisqModule.DEBUG){
			Log.d(TisqModule.MODULE_SHORT_NAME,message);
		}				
	}
	public static Calendar DateToCalendar(Date date)
	{ 
	  Calendar cal = Calendar.getInstance();
	  cal.setTime(date);
	  return cal;
	}
	
}

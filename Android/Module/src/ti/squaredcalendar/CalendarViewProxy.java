package ti.squaredcalendar;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.titanium.view.TiUIView;
import org.appcelerator.titanium.proxy.TiViewProxy;

import android.app.Activity;
@Kroll.proxy(creatableInModule = CalendarviewModule.class)
public class CalendarViewProxy  extends TiViewProxy {


	public CalendarViewProxy() {
		super();
	}

	public TiUIView createView(Activity activity) 
	{
		// This method is called when the view needs to be created. This is
		// a required method for a TiViewProxy subclass.

		CalendarView view = new CalendarView(this);
		view.getLayoutParams().autoFillsHeight = true;
		view.getLayoutParams().autoFillsWidth = true;

		return view;

	}

}

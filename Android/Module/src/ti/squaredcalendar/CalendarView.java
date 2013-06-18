package ti.squaredcalendar;

import java.util.Date;

import com.squareup.timessquare.CalendarPickerView;
import com.squareup.timessquare.CalendarPickerView.SelectionMode;

import org.appcelerator.titanium.view.TiUIView;
import org.appcelerator.titanium.proxy.TiViewProxy;

public class CalendarView extends TiUIView {
	public CalendarView(TiViewProxy proxy) 
	{
		super(proxy);

		final CalendarPickerView calendar = 
				new CalendarPickerView(proxy.getActivity(),null);
		calendar.init(new Date(), new Date()) //
	        .inMode(SelectionMode.SINGLE) //
	        .withSelectedDate(new Date());

		// Set the view as the native view. You must set the native view
		// for your view to be rendered correctly.
		setNativeView(calendar);
	}
}

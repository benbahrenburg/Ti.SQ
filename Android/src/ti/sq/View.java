package ti.sq;

import java.util.Date;

import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.titanium.proxy.TiViewProxy;
import org.appcelerator.titanium.view.TiUIView;

import com.squareup.timessquare.CalendarPickerView;
import com.squareup.timessquare.CalendarPickerView.SelectionMode;


@Kroll.proxy(creatableInModule = TisqModule.class)
public class View extends TiUIView {

	public View(TiViewProxy proxy) 
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

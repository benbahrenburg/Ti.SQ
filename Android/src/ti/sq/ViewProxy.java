package ti.sq;

import java.util.Date;
import java.util.HashMap;
import org.appcelerator.kroll.annotations.Kroll;
import org.appcelerator.kroll.common.AsyncResult;
import org.appcelerator.kroll.common.Log;
import org.appcelerator.kroll.common.TiMessenger;
import org.appcelerator.titanium.TiApplication;
import org.appcelerator.titanium.view.TiUIView;
import org.appcelerator.titanium.proxy.TiViewProxy;
import android.app.Activity;
import android.os.Handler;
import android.os.Message;

@Kroll.proxy(creatableInModule = TisqModule.class)
public class ViewProxy  extends TiViewProxy  
{
	private static final int MSG_SET_VALUE = 700001;
	
	public ViewProxy() {
		super();
	}

	@Override
	public TiUIView createView(Activity activity) 
	{
		// This method is called when the view needs to be created. This is
		// a required method for a TiViewProxy subclass.
		ti.sq.View view = new ti.sq.View(this);
		view.getLayoutParams().autoFillsHeight = true;
		view.getLayoutParams().autoFillsWidth = true;

		return view;
	}



	@Kroll.getProperty()
	public boolean getPagingEnabled(){
		Log.d(TisqModule.MODULE_SHORT_NAME,"pagingEnabled is an iOS only parameter and always enabled on Android");
		return true;
	}
	@Kroll.setProperty()
	public void setPagingEnabled(final boolean value){
		Log.d(TisqModule.MODULE_SHORT_NAME,"pagingEnabled is an iOS only parameter and always enabled on Android");
	}
	
	@Kroll.getProperty()
	public Date getMin(){
		ti.sq.View demoView = (ti.sq.View)view;
		return demoView.getValue();
	}
	
	@Kroll.getProperty()
	public Date getMax(){
		ti.sq.View demoView = (ti.sq.View)view;
		return demoView.getValue();
	}
	
	@Kroll.getProperty()
	public Date getValue(){
		ti.sq.View demoView = (ti.sq.View)view;
		return demoView.getValue();
	}
	
	@SuppressWarnings("rawtypes")
	@Kroll.setProperty(retain=false)
	public void setValue(final HashMap hm) 
	{
		//Log.d(TisqModule.MODULE_SHORT_NAME,"[$DEBUG$] Property Set: setValue");

		if (view != null) {
			if (!TiApplication.isUIThread()) {
				TiMessenger.sendBlockingMainMessage(new Handler(TiMessenger.getMainMessenger().getLooper(), new Handler.Callback() {
					public boolean handleMessage(Message msg) {
						switch (msg.what) {
							case MSG_SET_VALUE: {
								AsyncResult result = (AsyncResult) msg.obj;
								ti.sq.View demoView = (ti.sq.View)view;
								demoView.setValue(hm);
								result.setResult(null);
								return true;
							}
						}
						return false;
					}
				}).obtainMessage(MSG_SET_VALUE), hm);
			} else {
				ti.sq.View demoView = (ti.sq.View)view;
				demoView.setValue(hm);
			}
		}			
	}		
}

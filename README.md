<h1>Ti.SQ</h1>

The TiSQ project allows you to use [Square's](http://square.github.io) open source TimeSquare calendar picker in your Titanium app.

[![ScreenShot](https://raw.github.com/benbahrenburg/Ti.SQ/master/Screenshots/ios_youtube.png)](http://www.youtube.com/watch?v=HKy7pTjiRx8)	[![ScreenShot](https://raw.github.com/benbahrenburg/Ti.SQ/master/Screenshots/android_youtube.png)](http://www.youtube.com/watch?v=TjwuddPEzN8)


<h2>Before you start</h2>
* These are iOS and Android native modules designed to work with Titanium SDK 3.1.1.GA
* Before using this module you first need to install the package. If you need instructions on how to install a 3rd party module please read this installation guide.

<h2>Download the compiled release</h2>

Download the platform you wish to use:

* [iOS Dist](https://github.com/benbahrenburg/Ti.SQ/tree/master/iOS/dist)
* [Android Dist] (https://github.com/benbahrenburg/Ti.SQ/tree/master/Android/dist)

<h2>Building from source?</h2>

If you are building from source you will need to do the following:

Import the project into Xcode:

* Modify the titanium.xcconfig file with the path to your Titanium installation

Import the project into Eclipse:

* Update the .classpath
* Update the build properties

<h2>Setup</h2>

* Download the latest release from the releases folder ( or you can build it yourself )
* Install the ti.sq module. If you need help here is a "How To" [guide](https://wiki.appcelerator.org/display/guides/Configuring+Apps+to+Use+Modules). 
* You can now use the module via the commonJS require method, example shown below.

<h2>Importing the module using require</h2>
<pre><code>
var square = require('ti.sq');
</code></pre>

<h2>Creating the View Object</h2>
The Ti.SQ view supports a majority of the standard [Ti.UI.View](http://docs.appcelerator.com/titanium/latest/#!/api/Titanium.UI.View) properties.  The below listed properties are specific to the Ti.SQ calendar view.

<b>Parameters</b>

<b>value</b> : Dictionary

The selection value on the Ti.SQ calendar View

<b>min</b> : Dictionary

The minimum date that will be shown and allowed to be selected on the Ti.SQ calendar view. 

* On Android this is a creation time only property. You will always be able to read this value, but on Android you can only set property this on creation.

<b>max</b> : Dictionary

The maximum date that will be shown and allowed to be selected on the Ti.SQ calendar view. 

* On Android this is a creation time only property. You will always be able to read this value, but on Android you can only set property this on creation.

<b>PagingEnabled</b> : Boolean

Enabled by default, this property determines if the Ti.SQ calendar view allows for scrolling

* On Android this property will always be true.

<b>BackgroundColor</b> : String/Color

The color of the calendar view month headings


<b>Additional Properties</b>

<b>dateValue</b> : Date

Once the Calendar View has been created and added to your Ti.UI.Window, the dateValue property can be used to obtain a JavaScript date object with the selected date of the Calendar View.

<b>Example</b>
<pre><code>
//Require the square module into your project
var square = require('ti.sq');

var calendarView = square.createView({
  height:Ti.UI.FILL,
	width:Ti.UI.FILL,
	pagingEnabled:true,
	value:{
		month:4,day:15,year:2013
	},		
	min:{
		month:2,day:15,year:2013
	},
	max:{
		month:10,day:15,year:2013
	}
});


</code></pre>


<h2>Events</h2>

<b>dateChanged</b>

This event is called when a date is selected by the user.

<b>Callback Property Values</b>

<b>dateValue</b> : Date

A JavaScript date object with the selected date of the Calendar View

<b>value</b> : Dictionary

A dictionary object with the day, month, and year of the selected date of the Calendar View. 

For exampe:

<pre><code>
{
	month:4,day:15,year:2013
}
</code></pre>


<b>Example</b>
<pre><code>
calendarView.addEventListener('dateChanged',function(d){
	Ti.API.info(JSON.stringify(d));
	Ti.API.info(JSON.stringify(d.dateValue));
	Ti.API.info(JSON.stringify(d.value));
	Ti.API.info(JSON.stringify(calendarView.value));
});
</code></pre>

<h2>Learn More</h2>

<h3>Examples</h3>
Please check the module's example folder or 


* [iOS](https://github.com/benbahrenburg/Ti.SQ/tree/master/iOS/example) 
* [Android](https://github.com/benbahrenburg/Ti.SQ/tree/master/Android/Module/example)

for samples on how to use this project.

<h3>Twitter</h3>

Please consider following the [@benCoding Twitter](http://www.twitter.com/benCoding) for updates 
and more about Titanium.

<h3>Blog</h3>

For module updates, Titanium tutorials and more please check out my blog at [benCoding.Com](http://benCoding.com).

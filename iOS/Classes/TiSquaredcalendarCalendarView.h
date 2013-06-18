/**
 * benCoding.CalendarView
 * Copyright (c) 2010-2014 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
#import "TimesSquare.h"



@interface TiSquaredcalendarCalendarView : TiUIView<TSQCalendarViewDelegate> {
@private
	TSQCalendarView *square;
}
-(void) showToday;
@end

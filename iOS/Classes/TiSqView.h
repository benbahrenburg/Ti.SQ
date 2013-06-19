/**
 * Ti.SQ
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiUIView.h"
#import "TimesSquare.h"
@interface TiSqView : TiUIView<TSQCalendarViewDelegate> {
@private
	TSQCalendarView *square;
}
-(void) showToday;
@end

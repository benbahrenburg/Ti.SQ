/**
 * benCoding.CalendarView
 * Copyright (c) 2010-2014 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiSquaredcalendarCalendarViewProxy.h"
#import "TiUtils.h"
#import "TiSquaredcalendarCalendarView.h"
@implementation TiSquaredcalendarCalendarViewProxy

-(void)viewDidAttach
{
	ENSURE_UI_THREAD_0_ARGS;
	TiSquaredcalendarCalendarView * ourView = (TiSquaredcalendarCalendarView *)[self view];
    [ourView showToday];
	[super viewDidAttach];
}


@end

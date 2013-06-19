/**
 * Ti.SQ
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiSqViewProxy.h"
#import "TiUtils.h"
#import "TiSqView.h"
@implementation TiSqViewProxy

-(void)viewDidAttach
{
	ENSURE_UI_THREAD_0_ARGS;
	TiSqView * ourView = (TiSqView *)[self view];
    [ourView showToday];
	[super viewDidAttach];
}


@end

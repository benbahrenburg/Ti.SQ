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

-(NSArray *)keySequence
{
    return [NSArray arrayWithObjects:
            @"min",
            @"max",
            @"value",
            nil];
}

-(void)viewDidAttach
{
    if ([NSThread isMainThread]) {
        TiSqView * ourView = (TiSqView *)[self view];
        [ourView render];
    }
    
	[super viewDidAttach];
}

@end

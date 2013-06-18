/**
 * benCoding.CalendarView
 * Copyright (c) 2010-2014 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiSquaredcalendarModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiSquaredcalendarModule

#pragma mark Internal

NSString *const _moduleId = @"ti.squaredcalendar";

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"2353b3f4-ecd8-42cc-b698-ffbba0de7ebe";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return _moduleId;
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}
+(NSString*)getPathToModuleAsset:(NSString*) fileName
{
	// The module assets are copied to the application bundle into the folder pattern
	// "module/<moduleid>". One way to access these assets is to build a path from the
	// mainBundle of the application.
    
	NSString *pathComponent = [NSString stringWithFormat:@"modules/%@/%@", _moduleId, fileName];
	NSString *result = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:pathComponent];
    
	return result;
}
@end

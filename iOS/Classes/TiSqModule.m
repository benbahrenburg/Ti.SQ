/**
 * Ti.SQ
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiSqModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation TiSqModule

#pragma mark Internal


// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"496bcf20-7426-452d-b76f-8ed999d90785";
}

+(NSString*) findModuleId
{
    return [[TiSqModule alloc] init].moduleId;
}
// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"ti.sq";
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


#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

-(id)debug
{
	return NUMBOOL(NO);
}

-(void)setDebug:(id)value
{
}

@end

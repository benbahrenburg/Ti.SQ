/**
 * benCoding.CalendarView
 * Copyright (c) 2010-2014 by Ben Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiSquaredcalendarCalendarView.h"
#import "TiUtils.h"
#import "TSQTACalendarRowCell.h"

@interface TSQCalendarView (AccessingPrivateStuff)

@property (nonatomic, readonly) UITableView *tableView;

@end

@implementation TiSquaredcalendarCalendarView

-(TSQCalendarView*)square
{
	// Return the square view. If this is the first time then allocate and
	// initialize it.
	if (square == nil) {
		NSLog(@"[CALENDARVIEW] square");

        square = [[TSQCalendarView alloc] initWithFrame:[self frame]];
        square.rowCellClass = [TSQTACalendarRowCell class];
        square.firstDate = [NSDate dateWithTimeIntervalSinceNow:-60 * 60 * 24 * 365 * 1];
        square.lastDate = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 365 * 5];
        square.backgroundColor = [UIColor colorWithRed:0.84f green:0.85f blue:0.86f alpha:1.0f];
        square.pagingEnabled = YES;
        CGFloat onePixel = 1.0f / [UIScreen mainScreen].scale;
        square.contentInset = UIEdgeInsetsMake(0.0f, onePixel, 0.0f, onePixel);
        square.delegate = self;
        
		[self addSubview:square];
        
	}
    
	return square;
}

-(void) showToday
{
    // Set the calendar view to show today date on start
    [square scrollToDate:[NSDate date] animated:NO];
}
-(BOOL)hasTouchableListener
{
	// since this guy only works with touch events, we always want them
	// just always return YES no matter what listeners we have registered
	return YES;
}

#pragma mark View controller stuff

-(void)setBackgroundColor_:(id)value
{
    NSLog(@"[CALENDARVIEW] Property Set: setBackgroundColor_");
    
	// Use the TiUtils methods to get the values from the arguments
	TiColor *newColor = [TiUtils colorValue:value];
	UIColor *clr = [newColor _color];
	UIView *sq = [self square];
	sq.backgroundColor = clr;
}
-(void)setPagingEnabled_:(id)value
{
    
	[[self square] setPagingEnabled:[TiUtils boolValue:value]];
}
-(NSDate*) getSelectedDate
{
    return [[self square] selectedDate];
}
-(void)setSelectedDate_:(id)args
{
    ENSURE_SINGLE_ARG(args,NSDictionary);
    NSInteger month = [TiUtils intValue:@"month" properties:args def:1];
    NSInteger day = [TiUtils intValue:@"day" properties:args def:1];
    NSInteger year = [TiUtils intValue:@"year" properties:args def:2000];
        
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    [comps setDay:day];
    [comps setYear:year];
        
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [[self square] setSelectedDate:[gregorian dateFromComponents:comps]];
    
    [comps release];
    [gregorian release];
}
     
-(void)setFirstDate_:(id)args
{
    ENSURE_SINGLE_ARG(args,NSDictionary);
    NSInteger month = [TiUtils intValue:@"month" properties:args def:1];
	NSInteger day = [TiUtils intValue:@"day" properties:args def:1];
	NSInteger year = [TiUtils intValue:@"year" properties:args def:2000];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setMonth:month];
	[comps setDay:day];
	[comps setYear:year];
    
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [[self square] setFirstDate:[gregorian dateFromComponents:comps]];
	
    [comps release];
	[gregorian release];
}


-(void)setLastDate_:(id)args
{
    ENSURE_SINGLE_ARG(args,NSDictionary);
    NSInteger month = [TiUtils intValue:@"month" properties:args def:1];
	NSInteger day = [TiUtils intValue:@"day" properties:args def:1];
	NSInteger year = [TiUtils intValue:@"year" properties:args def:2000];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setMonth:month];
	[comps setDay:day];
	[comps setYear:year];
    
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
	[[self square] setLastDate:[gregorian dateFromComponents:comps]];
	
    [comps release];
	[gregorian release];
}

- (BOOL)calendarView:(TSQCalendarView *)calendarView shouldSelectDate:(NSDate *)date
{

}
- (void)calendarView:(TSQCalendarView *)calendarView didSelectDate:(NSDate *)date
{
    //Add listener callout
}
@end

/**
 * Ti.SQ
 * Copyright (c) 2009-2013 by Benjamin Bahrenburg All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiSqView.h"
#import "TiUtils.h"
#import "TSQTACalendarRowCell.h"

@interface TSQCalendarView (AccessingPrivateStuff)

@property (nonatomic, readonly) UITableView *tableView;

@end

@implementation TiSqView

-(BOOL)dateIsInRage:(NSDate*)date isBetweenDate:(NSDate*)beginDate andDate:(NSDate*)endDate
{
    if ([date compare:beginDate] == NSOrderedAscending)
    	return NO;
    
    if ([date compare:endDate] == NSOrderedDescending)
    	return NO;
    
    return YES;
}

-(TSQCalendarView*)square
{
	// Return the square view. If this is the first time then allocate and
	// initialize it.
	if (square == nil) {
        
        square = [[TSQCalendarView alloc] init];
        square.rowCellClass = [TSQTACalendarRowCell class];
        NSDate* now = [NSDate date];
        
        NSCalendar *startCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *startComp = [startCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:now];
        [startComp setDay:1];
        [startComp setMonth:1];

        NSDate *firstDayOfYear = [startCalendar dateFromComponents:startComp];
        
        //Set default start date
        square.firstDate = firstDayOfYear;

        NSCalendar *endCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *endComp = [startCalendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:now];
        [endComp setDay:31];
        [endComp setMonth:12];
        
        NSDate *lastDayOfYear = [endCalendar dateFromComponents:endComp];
        
        //Set default end date
        square.lastDate = lastDayOfYear;
                
        //Set default backgroundColor
        square.backgroundColor = [UIColor colorWithRed:0.84f green:0.85f blue:0.86f alpha:1.0f];
        
        //Enable paging by default
        square.pagingEnabled = YES;
        
        //Add an offset
        CGFloat onePixel = 1.0f / [UIScreen mainScreen].scale;
        square.contentInset = UIEdgeInsetsMake(0.0f, onePixel, 0.0f, onePixel);
        
        square.selectedDate =[NSDate date];
        square.delegate = self;
        
        //Add to Ti master view
        [self addSubview:square];
	}
    
	return square;
}

-(void) render
{
    if([self square] ==nil)
    {
        NSLog(@"[DEBUG] render called to initialize calendar");
    }
}
-(void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
	// You must implement this method for your view to be sized correctly.
	// This method is called each time the frame / bounds / center changes
	// within Titanium.
    
	if (square != nil) {
        
        //Add an offset
        CGFloat onePixel = 1.0f / [UIScreen mainScreen].scale;
        square.contentInset = UIEdgeInsetsMake(0.0f, onePixel, 0.0f, onePixel);
        //Adjust size to match new container width
		[TiUtils setView:square positionRect:bounds];
        
        
        //If no date is setup, add today as the default
        if([[self square] selectedDate] == nil)
        {
            if([self dateIsInRage:[NSDate date] isBetweenDate:[[self square] firstDate] andDate:[[self square] lastDate]]){
                [(TSQCalendarView *)self.square scrollToDate:[NSDate date] animated:NO];
            }else{
                [(TSQCalendarView *)self.square scrollToDate:[[self square] firstDate] animated:NO];
            }
        
        }else{
            [(TSQCalendarView *)self.square scrollToDate:[[self square] selectedDate] animated:NO];
        }
	}
}

-(NSDictionary*) formatValueResults:(NSDate*) date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];

    NSDictionary *valueResult = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInteger:[components month]],@"month",
                                 [NSNumber numberWithInteger:[components day]],@"day",
                                 [NSNumber numberWithInteger:[components year]],@"year",
                                 nil
                                 ];
    return valueResult;
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

-(void)setValue_:(id)args
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
    NSDate *userProvidedDateValue = [gregorian dateFromComponents:comps];
    
    if(![self dateIsInRage:userProvidedDateValue
             isBetweenDate:[[self square] firstDate] andDate:[[self square] lastDate]]){
        NSLog(@"[DEBUG] Value is not within the min and max values provided. Using min value instead");
        
        [[self square] setSelectedDate:[[self square] firstDate]];
        [(TSQCalendarView *)self.square scrollToDate:[[self square] firstDate] animated:NO];
        
    }else{
        [[self square] setSelectedDate:userProvidedDateValue];        
        [(TSQCalendarView *)self.square scrollToDate:userProvidedDateValue animated:NO];
    }
    
}

-(void)setMin_:(id)args
{
    ENSURE_SINGLE_ARG(args,NSDictionary);
    NSInteger month = [TiUtils intValue:@"month" properties:args def:1];
	NSInteger day = [TiUtils intValue:@"day" properties:args def:1];
	NSInteger year = [TiUtils intValue:@"year" properties:args def:2000];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setMonth:month];
	[comps setDay:day];
	[comps setYear:year];
    
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [[self square] setFirstDate:[calendar dateFromComponents:comps]];
	
}

-(void)setMax_:(id)args
{
    ENSURE_SINGLE_ARG(args,NSDictionary);
    NSInteger month = [TiUtils intValue:@"month" properties:args def:1];
	NSInteger day = [TiUtils intValue:@"day" properties:args def:1];
	NSInteger year = [TiUtils intValue:@"year" properties:args def:2000];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
	[comps setMonth:month];
	[comps setDay:day];
	[comps setYear:year];
    
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
	[[self square] setLastDate:[calendar dateFromComponents:comps]];
	
}

- (void)scroll;
{
    static BOOL atTop = YES;
    TSQCalendarView *calendarView = (TSQCalendarView *)self.square;
    UITableView *tableView = calendarView.tableView;
    
    [tableView setContentOffset:CGPointMake(0.f, atTop ? 10000.f : 0.f) animated:YES];
    atTop = !atTop;
}

- (void)calendarView:(TSQCalendarView *)calendarView didSelectDate:(NSDate *)date
{
    [[self proxy] replaceValue:[self formatValueResults:[[self square] selectedDate]] forKey:@"value" notification:NO];
    [[self proxy] replaceValue:[[self square] selectedDate] forKey:@"dateValue" notification:NO];
    
    BOOL reproxying = [self.proxy inReproxy];
    if ((reproxying == NO) && configurationSet && [self.proxy _hasListeners:@"dateChanged"]) {
            NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [self formatValueResults:date],@"value",
                                   date,@"dateValue",
                                   nil
                                   ];
            [self.proxy fireEvent:@"dateChanged" withObject:event];
    }
}
@end

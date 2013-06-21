//
//  TSQTACalendarRowCell.m
//  TimesSquare
//
//  Created by Jim Puls on 12/5/12.
//  Licensed to Square, Inc. under one or more contributor license agreements.
//  See the LICENSE file distributed with this work for the terms under
//  which Square, Inc. licenses this file to you.

#import "TSQTACalendarRowCell.h"
#import "TiSqModule.h"
@implementation TSQTACalendarRowCell


-(NSString*)getPathToModuleAsset:(NSString*) fileName
{
	// The module assets are copied to the application bundle into the folder pattern
	// "module/<moduleid>". One way to access these assets is to build a path from the
	// mainBundle of the application.
    
	NSString *pathComponent = [NSString stringWithFormat:@"modules/%@/%@", [TiSqModule findModuleId], fileName];
	NSString *result = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:pathComponent];
    
	return result;
}

- (void)layoutViewsForColumnAtIndex:(NSUInteger)index inRect:(CGRect)rect;
{
    // Move down for the row at the top
    rect.origin.y += self.columnSpacing;
    rect.size.height -= (self.bottomRow ? 2.0f : 1.0f) * self.columnSpacing;
    [super layoutViewsForColumnAtIndex:index inRect:rect];
}

- (UIImage *)todayBackgroundImage;
{
    NSString *imagePath = [self getPathToModuleAsset:@"CalendarTodaysDate.png"];
	UIImage *image = [[UIImage imageWithContentsOfFile:imagePath]  stretchableImageWithLeftCapWidth:4 topCapHeight:4];
	if (image == nil) {
		return nil;
	}
    return image;
}

- (UIImage *)selectedBackgroundImage;
{
    NSString *imagePath = [self getPathToModuleAsset:@"CalendarSelectedDate.png"];
	UIImage *image = [[UIImage imageWithContentsOfFile:imagePath]  stretchableImageWithLeftCapWidth:4 topCapHeight:4];
	if (image == nil) {
		return nil;
	}
    return image;
}

- (UIImage *)notThisMonthBackgroundImage;
{
    NSString *imagePath = [self getPathToModuleAsset:@"CalendarPreviousMonth.png"];
	UIImage *image = [[UIImage imageWithContentsOfFile:imagePath]  stretchableImageWithLeftCapWidth:0 topCapHeight:0];
	if (image == nil) {
		return nil;
	}
    return image;
}

- (UIImage *)backgroundImage;
{
    NSString *imagePath = [self getPathToModuleAsset:
                           [NSString stringWithFormat:@"CalendarRow%@.png", self.bottomRow ? @"Bottom" : @""]];
	UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
	if (image == nil) {
		return nil;
	}
    return image;
}

@end

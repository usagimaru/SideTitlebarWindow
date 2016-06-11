//
//  Controller.m
//  testSideTitlebarWindow
//
//  Created by usagimaru on 09/11/09.
//  Copyright 2009 usagimaru.
//

#import "Controller.h"
#import <Carbon/Carbon.h>


@implementation Controller

- (void)awakeFromNib
{
	//[self __carbonWindowWithOldStyle];
	[self __carbonWindowWithHIToolbox];
}

- (void)__carbonWindowWithOldStyle
{
	WindowRef window;
	Rect bounds = {22, 0, 300, 500};
	
	WindowAttributes attributes =
	kWindowSideTitlebarAttribute |
	kWindowStandardHandlerAttribute |
	kWindowStandardDocumentAttributes |
	kWindowLiveResizeAttribute |
	kWindowMetalAttribute |
	kWindowTexturedSquareCornersAttribute |
	kWindowHasRoundBottomBarCornersAttribute |
	
	// High Resolution Capability with NSHighResolutionCapable=YES in Info.plist
	kWindowHighResolutionCapableAttribute |
	kWindowCompositingAttribute;
	
	OSStatus status = CreateNewWindow(kUtilityWindowClass, attributes, &bounds, &window);
	
	if (status == noErr) {
		SetThemeWindowBackground(window, kThemeTextColorWindowHeaderActive, true);
		SetWindowTitleWithCFString(window, CFSTR("縦向きウインドウをCarbonで作ったぜ"));
		RepositionWindow(window, NULL, kWindowCascadeOnMainScreen);
		
		// WindowRef -> NSWindow
		win = [[NSWindow alloc] initWithWindowRef:window];
		[win makeKeyAndOrderFront:nil];
	}
	else {
		NSLog(@"error: %d", (int)status);
	}
}

- (void)__carbonWindowWithHIToolbox
{
	WindowRef window;
	HIRect bounds = (HIRect)CGRectMake(22, 0, 500, 300);
	
	int attributes[] = {
		kHIWindowBitSideTitlebar,
		kHIWindowBitStandardHandler,
		kHIWindowBitCloseBox,
		kHIWindowBitCollapseBox,
		kHIWindowBitZoomBox,
		kHIWindowBitResizable,
		kHIWindowBitLiveResize,
		kHIWindowBitTextured,
		kHIWindowBitTexturedSquareCorners,
		kHIWindowBitRoundBottomBarCorners,
		
		// High Resolution Capability with NSHighResolutionCapable=YES in Info.plist
		kHIWindowBitHighResolutionCapable,
		kHIWindowBitCompositing,
		0};
	
	OSStatus status = HIWindowCreate(kUtilityWindowClass, attributes, NULL, kHICoordSpaceScreenPixel, &bounds, &window);
	
	if (status == noErr) {
		SetThemeWindowBackground(window, kThemeTextColorWindowHeaderActive, true);
		SetWindowTitleWithCFString(window, CFSTR("縦向きウインドウをCarbonで作ったぜ"));
		RepositionWindow(window, NULL, kWindowCascadeOnMainScreen);
		
		// WindowRef -> NSWindow
		win = [[NSWindow alloc] initWithWindowRef:window];
		[win makeKeyAndOrderFront:self];
	}
	else {
		NSLog(@"error: %d", (int)status);
	}
}

@end

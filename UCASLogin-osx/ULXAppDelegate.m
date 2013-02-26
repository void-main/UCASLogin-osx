//
//  ULXAppDelegate.m
//  UCASLogin-osx
//
//  Created by Sun Peng on 2/26/13.
//  Copyright (c) 2013 Void Main Studio. All rights reserved.
//

#import "ULXAppDelegate.h"

@implementation ULXAppDelegate

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (void) awakeFromNib
{
    [self setupStatusMenu];
}

- (void) setupStatusMenu
{
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    [statusItem setMenu:statusMenu];
    NSString* imageName = [[NSBundle mainBundle] pathForResource:@"status_icon" ofType:@"png"];
    NSImage* imageObj = [[NSImage alloc] initWithContentsOfFile:imageName];
    [statusItem setImage:imageObj];
    [statusItem setHighlightMode:YES];
}

@end

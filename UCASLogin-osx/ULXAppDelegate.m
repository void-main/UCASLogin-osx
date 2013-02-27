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
    if(_wrapper == NULL) { // only load keys once
        _wrapper = [ULXLoginKeyWrapper loadKeysFromKeyChain];
    }
    
    if(![_wrapper isValidKey]) {
        [self openSettingsWindow];
    }
}

- (void) setupStatusMenu
{
    _statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    [_statusItem setMenu:statusMenu];
    NSString* imageName = [[NSBundle mainBundle] pathForResource:@"status_icon" ofType:@"png"];
    NSImage* imageObj = [[NSImage alloc] initWithContentsOfFile:imageName];
    [_statusItem setImage:imageObj];
    [_statusItem setHighlightMode:YES];
}

- (IBAction)quitTheProgram:(id)sender
{
    exit(0);
}

- (IBAction)showOpenDialog:(id)sender
{
    [self openSettingsWindow];
}

- (void) openSettingsWindow
{
    ULXSettingsWindowController* controller = [[ULXSettingsWindowController alloc] initWithWindowNibName:@"ULXSettingsWindowController"];
    [controller showWindow:nil];
}

@end

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
    [self setNetworkOffIcon];
    [_statusItem setHighlightMode:YES];
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


// For Status Bar item animation
- (void)startAnimation
{
    currentFrame = 0;
    animTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/20.0 target:self selector:@selector(updateImage:) userInfo:nil repeats:YES];
}

- (void)stopAnimation
{
    [animTimer invalidate];
}

- (void)updateImage:(NSTimer*)timer
{
    currentFrame++;
    currentFrame = currentFrame % 8;
    [self setStatusItemIconWithPostfix:[NSString stringWithFormat:@"%ld", (long)currentFrame]];
}

- (void)setStatusItemIconWithPostfix:(NSString *)postfix
{
    NSString* imageName = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat: @"status_icon_%@", postfix] ofType:@"png"];
    NSImage* imageObj = [[NSImage alloc] initWithContentsOfFile:imageName];
    [_statusItem setImage:imageObj];
}

- (void) setNetworkOffIcon
{
    [self setStatusItemIconWithPostfix:@"off"];
}

- (void) setNetworkOnIcon
{
    [self setStatusItemIconWithPostfix:@"0"];
}

@end

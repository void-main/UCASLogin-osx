//
//  ULXSettingsWindowController.m
//  UCASLogin-osx
//
//  Created by Sun Peng on 2/26/13.
//  Copyright (c) 2013 Void Main Studio. All rights reserved.
//

#import "ULXSettingsWindowController.h"

@interface ULXSettingsWindowController ()

@end

@implementation ULXSettingsWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    ULXAppDelegate* mainApp = (ULXAppDelegate *)[NSApplication sharedApplication].delegate;
    ULXLoginKeyWrapper* wrapper = [mainApp wrapper];
    [studentIDField setStringValue:[wrapper studentID]];
    [passwordField setStringValue:[wrapper password]];
}

- (IBAction)saveStudentIdAndPassword:(id)sender
{
    ULXLoginKeyWrapper* wrapper = [[ULXLoginKeyWrapper alloc] init];
    [wrapper setStudentID:[studentIDField stringValue]];
    [wrapper setPassword:[passwordField stringValue]];
    if([wrapper saveToKeychain]) {
        ULXAppDelegate* mainApp = (ULXAppDelegate *)[NSApplication sharedApplication].delegate;
        
        [statusHint setStringValue:@"保存成功"];
        [mainApp setWrapper:wrapper];
    } else {
        // TODO alert to say failed...
        [statusHint setStringValue:@"保存失败"];
    }
}

@end

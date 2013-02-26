//
//  ULXSettingsWindowController.h
//  UCASLogin-osx
//
//  Created by Sun Peng on 2/26/13.
//  Copyright (c) 2013 Void Main Studio. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ULXAppDelegate.h"

@interface ULXSettingsWindowController : NSWindowController {
    IBOutlet NSTextField* studentIDField;
    IBOutlet NSSecureTextField* passwordField;
}

- (IBAction)saveStudentIdAndPassword:(id)sender;

@end

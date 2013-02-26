//
//  ULXAppDelegate.h
//  UCASLogin-osx
//
//  Created by Sun Peng on 2/26/13.
//  Copyright (c) 2013 Void Main Studio. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ULXLoginKeyWrapper.h"
#import "ULXSettingsWindowController.h"

@interface ULXAppDelegate : NSObject <NSApplicationDelegate> {
    NSStatusItem* statusItem;
    IBOutlet NSMenu* statusMenu;
    ULXLoginKeyWrapper *wrapper;
}

- (IBAction) showOpenDialog:(id)sender;
- (IBAction) quitTheProgram:(id)sender;

- (void) openSettingsWindow;

@end

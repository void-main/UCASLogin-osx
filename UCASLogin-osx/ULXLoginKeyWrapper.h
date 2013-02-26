//
//  ULXLoginKeyWrapper.h
//  UCASLogin-osx
//
//  Created by Sun Peng on 2/26/13.
//  Copyright (c) 2013 Void Main Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ULXLoginKeyWrapper : NSObject {
    const char* WEBSITE_KEYCHAIN_ACCOUNT;
}

@property (retain) NSString* studentID;
@property (retain) NSString* password;

+ (ULXLoginKeyWrapper *)loadKeysFromKeyChain;
- (BOOL)saveToKeychain;

- (BOOL) isValidKey;
+ (void) fillItem: (ULXLoginKeyWrapper *) wrapper with:(SecKeychainItemRef) item;

@end

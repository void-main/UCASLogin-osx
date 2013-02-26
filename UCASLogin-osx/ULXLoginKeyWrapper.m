//
//  ULXLoginKeyWrapper.m
//  UCASLogin-osx
//
//  Created by Sun Peng on 2/26/13.
//  Copyright (c) 2013 Void Main Studio. All rights reserved.
//

#import "ULXLoginKeyWrapper.h"

char* ULX_KEYCHAIN_SERVICE_NAME = "UCAS网络登陆密钥";

@implementation ULXLoginKeyWrapper

- (BOOL)saveToKeychain
{
    SecKeychainItemRef itemRef;
    
    // Always deletes the existsing keychain
    OSStatus loadStatus = SecKeychainFindGenericPassword(NULL, strlen(ULX_KEYCHAIN_SERVICE_NAME), ULX_KEYCHAIN_SERVICE_NAME, 0, NULL, 0, NULL, &itemRef);
    if(loadStatus == noErr) { // if the item with the same name exists, delete it first!
        SecKeychainItemDelete(itemRef);
    }
    
    const char* utf8StudentID = [_studentID UTF8String];
    const char* utf8Password = [_password UTF8String];
    OSStatus saveStatus = SecKeychainAddGenericPassword(NULL, strlen(ULX_KEYCHAIN_SERVICE_NAME), ULX_KEYCHAIN_SERVICE_NAME, strlen(utf8StudentID), utf8StudentID, strlen(utf8Password), utf8Password, NULL);
    
    if(saveStatus == noErr)
    {
        return YES;
    } else {
        return NO;
    }
}

+ (ULXLoginKeyWrapper *)loadKeysFromKeyChain
{
    ULXLoginKeyWrapper* wrapper = [[ULXLoginKeyWrapper alloc] init];
 
    SecKeychainItemRef itemRef;
    OSStatus loadStatus = SecKeychainFindGenericPassword(NULL, strlen(ULX_KEYCHAIN_SERVICE_NAME), ULX_KEYCHAIN_SERVICE_NAME, 0, NULL, 0, NULL, &itemRef);
    if(loadStatus == noErr) { // fill the fields if we have already saved them
        [ULXLoginKeyWrapper fillItem:wrapper with:itemRef];
    }
    
    return wrapper;
}

+ (void) fillItem: (ULXLoginKeyWrapper *) wrapper with:(SecKeychainItemRef) item {
    // Build the attributes we're interested in examining.
    SecKeychainAttribute attributes[1];
    attributes[0].tag = kSecAccountItemAttr;
    SecKeychainAttributeList list;
    list.count = 1;
    list.attr = attributes;
    // Get the item's information, including the password.
    UInt32 length = 0;
    char *password = NULL;
    OSErr result;
        result = SecKeychainItemCopyContent (item, NULL, &list, &length,
                                             (void **)&password);
    if (result != noErr) {
        NSLog(@"Error!");
    }
    
    if (password != NULL) {
        // Copy the password into a buffer and attach a trailing zero
        // byte so we can print it out with printf.
        char *passwordBuffer = malloc(length + 1);
        strncpy (passwordBuffer, password, length);
        passwordBuffer[length] = '\0';
        [wrapper setPassword:[[NSString alloc] initWithCString:passwordBuffer encoding:NSUTF8StringEncoding]];
        free (passwordBuffer);
    } else {
        [wrapper setPassword:@""];
    }
    
    SecKeychainAttribute attr = list.attr[0];
    char buffer[2048];
    strncpy (buffer, attr.data, attr.length);
    buffer[attr.length] = '\0';
    printf ("'%d' = \"%s\"\n", attr.tag, buffer);
    [wrapper setStudentID:[[NSString alloc] initWithCString:buffer encoding:NSUTF8StringEncoding]];
    
    SecKeychainItemFreeContent (&list, password);
}

- (BOOL)isValidKey
{
    return (_studentID != nil) & (_password != nil);
}

@end

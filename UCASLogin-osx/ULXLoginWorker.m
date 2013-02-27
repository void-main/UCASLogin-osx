//
//  ULXLoginWorker.m
//  UCASLogin-osx
//
//  Created by Sun Peng on 2/26/13.
//  Copyright (c) 2013 Void Main Studio. All rights reserved.
//

#import "ULXLoginWorker.h"

@implementation ULXLoginWorker

- (IBAction)login:(id)sender
{
    NSLog(@"Login %@", sender);
}

- (IBAction)logout:(id)sender
{
    NSArray* array = [NSArray arrayWithObject:@"-logout"];
    [self executeHelper:array];
}

- (void) executeHelper:(NSArray *)arguments
{
    [self executeScript:@"ulx_helper" withArguments:arguments];
}

- (void)executeScript:(NSString *)scriptName withArguments:(NSArray *)arguments
{
    NSString *scriptPath = [[NSBundle mainBundle] pathForResource:scriptName ofType:@"py" inDirectory:@"scripts"];
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath:@"/usr/bin/"];
    NSMutableArray* array = [NSMutableArray arrayWithArray:arguments];
    [array insertObject:@"python" atIndex:0];
    [array insertObject:scriptPath atIndex:1];
    [task setArguments:array];
    
    NSPipe *pipe;
    pipe = [NSPipe pipe];
    [task setStandardOutput: pipe];
    [task setStandardError:pipe];
    [task setStandardInput:[NSPipe pipe]];
    
    
    NSFileHandle *file;
    file = [pipe fileHandleForReading];
    
    [task launch];
    NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
    
    [task waitUntilExit];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", result);
}

@end

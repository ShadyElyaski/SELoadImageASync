//
//  FileDownloadOperation.m
//  SELoadImageASync_Demo
//
//  V 1.0
//
//  Created by Shady Elyaski on 8/3/11.
//  Copyright 2011 Sarmady - A Vodafone Company. All rights reserved.
//

#import "FileDownloadOperation.h"

@implementation FileDownloadOperation
@synthesize error = error_, image = image_, MyImageViewsDic = myImageViewsDic_, Photo_ID = photo_id_;

- (id)initWithURL:(NSURL*)url FilePath:(NSString*)filePath ImageView:(UIImageView*)imgVu DefaultImage:(UIImage*) img FileTMPpath:(NSString*)tmpPath ID:(NSString*)photo_id delagate:(id)sender {
    if (self = [super init]) {
        connectionURL_ = [url retain];
        filePath_ = [filePath retain];
        myImageViewsDic_ = [NSMutableDictionary new];
        [myImageViewsDic_ setValue:imgVu forKey:[NSString stringWithFormat:@"%p", imgVu]];
        defaultImg_ = [img retain];
        tmpPath_ = [tmpPath retain];
        photo_id_ = [photo_id retain];
        delegate = [sender retain];
    }
    
    return self;
}

-(void) AddUIImageViewDependency:(UIImageView*) imgVu{
    NSString* key = [NSString stringWithFormat:@"%p", imgVu];
    UIImageView* oldImgVu = [myImageViewsDic_ valueForKey:key];
    if (!oldImgVu) {
        [myImageViewsDic_ setValue:imgVu forKey:key];
    }
}

- (void)dealloc
{
    if(connection_) { [connection_ cancel]; [connection_ autorelease]; }
    [connectionURL_ release];
    [error_ release];
    [data_ release];
    [image_ release];
    [delegate release];
    [filePath_ release];
    [myImageViewsDic_ release];
    [defaultImg_ release];
    [tmpPath_ release];
    [photo_id_ release];
    [super dealloc];
}

-(void)main {
    [self willChangeValueForKey:@"isExecuting"];
    executing_ = YES;
    [self didChangeValueForKey:@"isExecuting"];

    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    [fileManager createFileAtPath:[NSString stringWithFormat:@"%@_0", tmpPath_] contents:nil attributes:nil]; //Set Downloading FLAG
    
    data_ = [[NSData dataWithContentsOfURL:connectionURL_ options:NSDataReadingUncached error:&error_] retain];
    
    [fileManager removeItemAtPath:[NSString stringWithFormat:@"%@_0", tmpPath_] error:nil];	//Remove Downloading FLAG
    
    // If we have data, try and make an image
    if(data_){
        
       image_ = [[UIImage alloc] initWithData:data_];
        
        // Set error if no image was created
        if(!image_){
            NSDictionary* userInfo = [NSDictionary dictionaryWithObject:NSLocalizedString(@"Could not create image from data.", nil)
                                                                 forKey:NSLocalizedDescriptionKey];
            error_ = [[NSError alloc] initWithDomain:@"ExampleOperationDomain"
                                                code:-1000
                                            userInfo:userInfo];
        }
    }else{
        NSDictionary* userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Could not read file from URL: %@", connectionURL_]
                                                             forKey:NSLocalizedDescriptionKey];
        error_ = [[NSError alloc] initWithDomain:@"ExampleOperationDomain"
                                            code:-1000
                                        userInfo:userInfo];
    }
    
    if (error_) {
        image_ = [UIImage new];
        [fileManager createFileAtPath:[NSString stringWithFormat:@"%@_1", tmpPath_] contents:nil attributes:nil]; //Add Not Found FLAG
    }else{
        [data_ writeToFile:filePath_ options:NSDataWritingFileProtectionNone error:&error_];    //Cache image into disk
    }
    
    [delegate performSelector:@selector(doneOperation:) withObject:self];
    
    // Alert anyone that we are finished
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    executing_ = NO;
    finished_  = YES;
    [self didChangeValueForKey:@"isFinished"];
    [self didChangeValueForKey:@"isExecuting"];
}

#pragma mark -
#pragma mark Overrides

- (BOOL)isConcurrent
{
    return NO;
}

- (BOOL)isExecuting
{
    return executing_;
}

- (BOOL)isFinished
{
    return finished_;
}

- (void)cancel
{
    [super cancel];
}


@end
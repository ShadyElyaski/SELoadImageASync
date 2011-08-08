//
//  FileDownloadOperation.h
//  SELoadImageASync_Demo
//
//  V 1.0
//
//  Created by Shady Elyaski on 8/3/11.
//  Copyright 2011 Sarmady - A Vodafone Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileDownloadOperation : NSOperation{
    NSError*  error_;
    UIImage*  image_;
    
    // In concurrent operations, we have to manage the operation's state
    BOOL      executing_;
    BOOL      finished_;
    
    // The actual NSURLConnection management
    NSURL*                  connectionURL_;
    NSString*               filePath_;
    NSMutableDictionary*    myImageViewsDic_;
    UIImage*                defaultImg_;
    NSString*               tmpPath_;
    NSString*               photo_id_;
    
    NSURLConnection*  connection_;
    NSData*    data_;
    
    id          delegate;
}

@property(nonatomic,readonly) NSError* error;
@property(nonatomic,readonly) UIImage* image;
@property(nonatomic,readonly) NSMutableDictionary*    MyImageViewsDic;
@property(nonatomic,readonly) NSString* Photo_ID;

- (id)initWithURL:(NSURL*)url FilePath:(NSString*)filePath ImageView:(UIImageView*)imgVu DefaultImage:(UIImage*) img FileTMPpath:(NSString*)tmpPath ID:(NSString*)photo_id delagate:(id)sender;
-(void) AddUIImageViewDependency:(UIImageView*) imgVu;

@end

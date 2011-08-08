//
//  SELoadImageASync.h
//  SELoadImageASync_Demo
//
//  V 1.0
//
//  Created by Shady Elyaski on 7/30/11.
//

#import <Foundation/Foundation.h>
#import "FileDownloadOperation.h"

@interface  SELoadImageASync : NSObject{
    NSString*               documentDirectoryRoot;
    NSMutableDictionary*    downloadIDs;
    NSOperationQueue*       networkQueue;
}

+(void) LoadImageASync:(NSString*) Path ID:(NSString*)ImgID ImageURL: (NSURL*)ImgURL ImageView: (UIImageView*) ImgVu DefaultImage: (UIImage*) defaultImg ShowActivity:(BOOL) showAct ActivityIndicatorStyle: (UIActivityIndicatorViewStyle)actStyle;
+(NSString*) GetPath: (NSString*) path;

@property(nonatomic, readonly) NSString*                documentDirectoryRoot;
@property(nonatomic, readonly) NSMutableDictionary*     downloadIDs;
@property(nonatomic, readonly) NSOperationQueue*        networkQueue;

@end

SELoadImageASync* singleton;
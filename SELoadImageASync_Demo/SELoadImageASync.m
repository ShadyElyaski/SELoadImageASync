//
//  SELoadImageASync.m
//  SELoadImageASync_Demo
//
//  V 1.0
//
//  Created by Shady Elyaski on 7/30/11.
//

#import "SELoadImageASync.h"
#include <stdlib.h>

@implementation SELoadImageASync
@synthesize documentDirectoryRoot;
@synthesize downloadIDs;
@synthesize networkQueue;

-(id)init{
    if (self = [super init]) {
        //Get Documents Directory
        NSFileManager* fileManager = [NSFileManager defaultManager];
        
        documentDirectoryRoot = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory
                                                                      , NSUserDomainMask
                                                                      , YES) objectAtIndex:0] retain];
        downloadIDs = [NSMutableDictionary new];
        
        NSString* tmpFolderPath = [NSString stringWithFormat:@"%@/tmp", documentDirectoryRoot];
        
        if([fileManager fileExistsAtPath:tmpFolderPath isDirectory:nil])
            [fileManager removeItemAtPath:tmpFolderPath error:nil];
        
        networkQueue = [[NSOperationQueue alloc] init];
        [networkQueue setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    }
    
    return self;
}

-(void)dealloc{
    [documentDirectoryRoot release];
    [downloadIDs release];
    [networkQueue release];
    [super dealloc];
}

+(SELoadImageASync* ) getSELoadImageASyncInstance{
    if (!singleton) {
        singleton = [[SELoadImageASync new] retain];
    }
    return singleton;
}

+(void) LoadImageASync:(NSString*) Path ID:(NSString*)ImgID ImageURL: (NSURL*)ImgURL ImageView: (UIImageView*) ImgVu DefaultImage: (UIImage*) defaultImg ShowActivity:(BOOL) showAct ActivityIndicatorStyle: (UIActivityIndicatorViewStyle)actStyle{
    
    SELoadImageASync* loadImageASync = [SELoadImageASync getSELoadImageASyncInstance];
    NSMutableDictionary* downloadIDs = [SELoadImageASync getSELoadImageASyncInstance].downloadIDs;
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    NSString* FileTMPFolder = [self GetPath:[NSString stringWithFormat:@"tmp/%@", Path]];
	NSString* FileTMPPath = [NSString stringWithFormat:@"%@/%@.png", FileTMPFolder, ImgID];
    NSString* Directory = [self GetPath:Path];
    NSString* FilePath = [NSString stringWithFormat:@"%@/%@.png", Directory, ImgID];
    

    
	if (!defaultImg) {                                              //To prevent crash in arrays
		defaultImg = [[UIImage new] autorelease];
	}
	
    
	if(![fileManager fileExistsAtPath:Directory isDirectory:nil])
		[fileManager createDirectoryAtPath:Directory withIntermediateDirectories:YES attributes:nil error:nil];
    
    if(![fileManager fileExistsAtPath:FileTMPFolder isDirectory:nil])
		[fileManager createDirectoryAtPath:FileTMPFolder withIntermediateDirectories:YES attributes:nil error:nil];
	
    
    NSString* value = [NSString stringWithFormat:@"%@-%@", ImgID, Path];//[NSString stringWithFormat:@"%d", rand() % 1000];
    NSString* key = [NSString stringWithFormat:@"%p", ImgVu];
    
    if ([downloadIDs valueForKey:key])                              //Remove old entry from Dic
        [downloadIDs removeObjectForKey:key];
    
    [downloadIDs setValue:value forKey:key];                        //Add new download key
    
    //NSLog(@"Start: %@ (%@)", value, key);
    
	if([fileManager fileExistsAtPath:FilePath]){												//Image Exists on NAND
        
        [downloadIDs removeObjectForKey:key];
        //NSLog(@"Exists: %@ (%@)", value, key);
		[ImgVu setImage:[UIImage imageWithContentsOfFile:FilePath]];
		id ldingVu = [ImgVu viewWithTag:3344];
		if (ldingVu) {
			[ldingVu stopAnimating];
			[ldingVu removeFromSuperview];
		}
	}
	else if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@_0", FileTMPPath]]) {	//Downloading
		
        FileDownloadOperation* operation;
        for (int i = 0; i < [loadImageASync.networkQueue.operations count]; i++) {   //Downloading same image twice but for different UIImageViews
            operation = [loadImageASync.networkQueue.operations objectAtIndex:i];
            if ([operation.Photo_ID isEqualToString:value]) {           
                [operation AddUIImageViewDependency:ImgVu];
                //NSLog(@"Add UIImageView: %p", ImgVu);
                break;
            }
        }
        
        //Do Nothing
		[ImgVu setImage:defaultImg];
		
		id ldingVu = [ImgVu viewWithTag:3344];
		
		if (showAct && !ldingVu) {
			UIActivityIndicatorView* act = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:actStyle];
			[act setCenter:CGPointMake(ImgVu.frame.size.width/2, ImgVu.frame.size.height/2)];
			[act setTag:3344];
			[act startAnimating];
			[ImgVu addSubview:act];
            
			[act release];
			[ImgVu setNeedsDisplay];
		}
	}else if ([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@_1", FileTMPPath]]) {	//Not Found On Server
		[ImgVu setImage:defaultImg];
		
        [downloadIDs removeObjectForKey:key];
        //NSLog(@"Not found: %@ (%@)", value, key);
		id ldingVu = [ImgVu viewWithTag:3344];
		if (ldingVu) {
			[ldingVu stopAnimating];
			[ldingVu removeFromSuperview];
		}
	}else{                                                                                      //Get it to download
        //NSLog(@"Started: %@", downloadIDs);
        
		[ImgVu setImage:defaultImg];
        
		if(showAct){
			id ldingVu = [ImgVu viewWithTag:3344];
			if (!ldingVu) {
				UIActivityIndicatorView* act = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:actStyle];
				[act setCenter:CGPointMake(ImgVu.frame.size.width/2, ImgVu.frame.size.height/2)];
				[act setTag:3344];
				[act startAnimating];
				[ImgVu addSubview:act];
				[act release];
				[ImgVu setNeedsDisplay];
			}
		}
        
        FileDownloadOperation* fileDownloader = [[FileDownloadOperation alloc] initWithURL:ImgURL FilePath:FilePath ImageView:ImgVu DefaultImage:defaultImg FileTMPpath:FileTMPPath ID:value delagate:loadImageASync];
        [loadImageASync.networkQueue addOperation:fileDownloader];
        [fileManager release];
        
        //NSLog(@"Start %d - %@", loadImageASync.networkQueue.operationCount, loadImageASync.networkQueue.operations);
        //NSLog(@"Add: %@ (%@)", value, key);
	}
	[ImgVu setNeedsDisplay];
}

-(void)doneOperation:(FileDownloadOperation*) op {
    
    if([op error]){
        NSLog(@"%@", op.error.userInfo);
    }
    
    UIImage* Img = op.image;
	NSDictionary* ImgViews = op.MyImageViewsDic;
    NSString* currentDownloadID = op.Photo_ID;
    
    
    NSString* key; UIImageView* value; NSString* storedID;
    
    for (int i = 0; i < ImgViews.allKeys.count; i++) {          //Updating All ImageViews Dependencies
        key = [ImgViews.allKeys objectAtIndex:i];
        storedID = [downloadIDs valueForKey:key];
        if ([storedID isEqualToString:currentDownloadID]) {     //UIImageView is assigned to download this image
            value = [ImgViews valueForKey:key];
            if (value) {
                
                UIActivityIndicatorView* act = (UIActivityIndicatorView*)[value viewWithTag:3344];
                if(act){
                    [act stopAnimating];
                    [act removeFromSuperview];
                }
                
                [value performSelectorOnMainThread:@selector(setImage:) withObject: Img waitUntilDone:YES];
                [value performSelectorOnMainThread:@selector(setNeedsDisplay) withObject:nil waitUntilDone:YES];
                [value performSelectorOnMainThread:@selector(setNeedsLayout) withObject:nil waitUntilDone:YES];
                
                [downloadIDs removeObjectForKey:[NSString stringWithFormat:@"%p", value]]; 
                //NSLog(@"Done: %@ (%p)", currentDownloadID, value);  
            }
        }
    }
    
    //NSLog(@"Finished: %@", downloadIDs);
    //[op release];
    //op = nil;
    //NSLog(@"Finish %d - %@", networkQueue.operationCount, networkQueue.operations);
}


+(NSString*) GetPath: (NSString*) path{	
	return [NSString stringWithFormat:@"%@/%@", [SELoadImageASync getSELoadImageASyncInstance].documentDirectoryRoot, path];
}

@end
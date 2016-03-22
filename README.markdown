# SELoadImageASync - Image Caching was never that easy!

## What is SELoadImageASync?

SELoadImageASync is a simple handy Obj-C method used to load image from URL into a UIImageView ASynchronously and cache it on device forever, all that with just one line of code!

**It has more features including:**

1. Loads photos from URL asynchronously.
2. Automatically detects whether image is already cached.
3. Shows an UIActivityIndicatorView until image is loaded.
4. User may select a default photo that is displayed until image is loaded.
5. Handles multiple function calls for downloading same file many times (i.e. when used under UITableView).
6. Built to deal with many-to-many relationship between UIImageViews and Images that are downloaded.

## How to use it in your iOS applications 

1. Simply add both
`SELoadImageASync.h`
and
`SELoadImageASync.m` into your project.

2. Add  `#import "SELoadImageASync.h"`.

## Documentation

`SELoadImageASync.h`
    +(void) LoadImageASync:(NSString*) Path ID:(NSString*)ImgID ImageURL: (NSURL*)ImgURL ImageView: (UIImageView*) ImgVu DefaultImage: (UIImage*) defaultImg ShowActivity:(BOOL) showAct ActivityIndicatorStyle: (UIActivityIndicatorViewStyle)actStyle;

* Path: Folder Path in which all cached images will be places
     eg. @"GalleryPhotos" or @"News"

* ID: A unique ID of the photo (could be images name)
	eg. @"flower.png" or @"1.png"

* ImageURL: URL of the Image
	eg. [NSURL URLWithString:@"http://www.touregypt.net/images/touregypt/masks2.jpg"]
	
* ImageView: The UIImageView where image should be placed
	
* DefaultImage: UIImage which will be shown until requested image is downloaded, nil for no Image
	
* ShowActivity: Whether to show a UIActivityIndicatorView or not

* ActivityIndicatorStyle: The style of the UIActivityIndicatorView if it is shown
	eg.     UIActivityIndicatorViewStyleWhiteLarge or UIActivityIndicatorViewStyleWhite or UIActivityIndicatorViewStyleGray

## NBs

* None

## Contributions 

1. ShadyElyaski <shady@elyaski.com>

## References 

1. Ahmed Essam <http://www.ahmed-essam.com/>
	* Essam taught me Obj-C from A to Z, he was very keen to let me know all things related to this technology, he helped me too on many other projects including this one, thank you MASTER! =)
2. Jason <http://9mmedia.com/blog/?p=549>
	* His NSOperation tutorial really helped me.

## Licence 

Copyright (c) 2011 Elyaski

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Contact

* Twitter: http://twitter.com/ShadyElyaski
* Email: shady@elyaski.com
* Website: http://elyaski.com

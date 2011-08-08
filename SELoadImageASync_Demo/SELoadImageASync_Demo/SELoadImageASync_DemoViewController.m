//
//  SELoadImageASync_DemoViewController.m
//  SELoadImageASync_Demo
//
//  Created by Shady Elyaski on 7/30/11.
//

#import "SELoadImageASync_DemoViewController.h"
#import "SELoadImageASync.h"

@implementation SELoadImageASync_DemoViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 13;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    UIImageView* imgVu = (UIImageView*)[cell viewWithTag:1122];
    if (!imgVu) {
        imgVu = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)] autorelease];
        [imgVu setTag:1122];
        [imgVu setContentMode:UIViewContentModeScaleAspectFit];
        [cell addSubview:imgVu];
    }
    
    UILabel* lbl = (UILabel*)[cell viewWithTag:1133];
    if (!lbl) {
        lbl = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)] autorelease];
        [lbl setTag:1133];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:lbl];
    }
    
    [lbl setText:[NSString stringWithFormat:@"%p", imgVu]];
    
    // Configure
	switch (indexPath.row) {
		case 0: [SELoadImageASync LoadImageASync:@"Demo" ID:@"0" ImageURL:[NSURL URLWithString:@"http://www.destination360.com/africa/egypt/images/s/pyramids.jpg"] ImageView:imgVu DefaultImage:nil ShowActivity:YES ActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; break;
		case 1: [SELoadImageASync LoadImageASync:@"Demo" ID:@"1" ImageURL:[NSURL URLWithString:@"http://chalk.richmond.edu/education/projects/webunits/egypt/mask.jpg"] ImageView:imgVu DefaultImage:nil ShowActivity:YES ActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; break;
		case 2: [SELoadImageASync LoadImageASync:@"Demo" ID:@"2" ImageURL:[NSURL URLWithString:@"http://rlv.zcache.com/pharaohs_of_egypt_tshirt-p235532220582083015ybth_400.jpg"] ImageView:imgVu DefaultImage:nil ShowActivity:YES ActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; break;
        case 3: [SELoadImageASync LoadImageASync:@"Demo" ID:@"3" ImageURL:[NSURL URLWithString:@"http://www.climtechsolutions.com/wp-content/uploads/2010/01/pharaoh.jpg"] ImageView:imgVu DefaultImage:nil ShowActivity:YES ActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; break;
        case 4: [SELoadImageASync LoadImageASync:@"Demo" ID:@"4" ImageURL:[NSURL URLWithString:@"http://www.touregypt.net/images/touregypt/pharaohs.jpg"] ImageView:imgVu DefaultImage:nil ShowActivity:YES ActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; break;
        case 5: [SELoadImageASync LoadImageASync:@"Demo" ID:@"5" ImageURL:[NSURL URLWithString:@"http://www.themysticcorner.com/images/Pharaoh_Throne.jpg"] ImageView:imgVu DefaultImage:nil ShowActivity:YES ActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; break;
        case 6: [SELoadImageASync LoadImageASync:@"Demo" ID:@"6" ImageURL:[NSURL URLWithString:@"http://covers.openlibrary.org/b/id/309753-L.jpg"] ImageView:imgVu DefaultImage:nil ShowActivity:YES ActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; break;
        case 7: [SELoadImageASync LoadImageASync:@"Demo" ID:@"7" ImageURL:[NSURL URLWithString:@"http://media.nowpublic.net/images//d7/1/d71d2cfa182c2eeb3d273b2f23abe6da.jpg"] ImageView:imgVu DefaultImage:nil ShowActivity:YES ActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; break;
        case 8: [SELoadImageASync LoadImageASync:@"Demo" ID:@"8" ImageURL:[NSURL URLWithString:@"http://members.ozemail.com.au/~slacey/images/vizier.jpg"] ImageView:imgVu DefaultImage:nil ShowActivity:YES ActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; break;
        case 9: [SELoadImageASync LoadImageASync:@"Demo" ID:@"9" ImageURL:[NSURL URLWithString:@"http://static.newworldencyclopedia.org/thumb/4/43/Pharaoh.svg/308px-Pharaoh.svg.png"] ImageView:imgVu DefaultImage:nil ShowActivity:YES ActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; break;
        case 10: [SELoadImageASync LoadImageASync:@"Demo" ID:@"10" ImageURL:[NSURL URLWithString:@"http://www.bee-hexagon.net/files/image/AncientEgyptianLovers.jpg"] ImageView:imgVu DefaultImage:nil ShowActivity:YES ActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; break;
        case 11: [SELoadImageASync LoadImageASync:@"Demo" ID:@"11" ImageURL:[NSURL URLWithString:@"http://cache2.allpostersimages.com/p/LRG/26/2681/SXIUD00Z/posters/ball-david-nile-and-old-cataract-hotel-aswan-egypt.jpg"] ImageView:imgVu DefaultImage:nil ShowActivity:YES ActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; break;
        case 12: [SELoadImageASync LoadImageASync:@"Demo" ID:@"12" ImageURL:[NSURL URLWithString:@"http://historystuff.net/wp-content/uploads/2009/08/nm_ancient_Egyptians_080328_ms.jpg"] ImageView:imgVu DefaultImage:nil ShowActivity:YES ActivityIndicatorStyle:UIActivityIndicatorViewStyleGray]; break;
		default: break;
	}
    return cell;
	
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Deselect
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

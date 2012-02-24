//
//  CustomCellsWithTableViewBannerDataSource.m
//  CustomCellsWithTableBanner
//
//  Created by Bhavin Dutia on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomCellsWithTableViewBannerDataSource.h"
#import "CustomStyleSheet.h"


@implementation CustomCellsWithTableViewBannerModel
@synthesize queryString = _queryString;

- (id)initWithSearchQuery:(NSString*)queryString{
    if ((self = [super init])) {
        self.queryString = queryString;
        [TTStyleSheet setGlobalStyleSheet:[[[CustomStyleSheet alloc] init] autorelease]];
    }
    return self;
}


- (void) dealloc {
    TT_RELEASE_SAFELY(_queryString);
    [super dealloc];
}



///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
    if (!self.isLoading) {
        
    }
}

- (void)requestDidFinishLoad:(TTURLRequest*)request {
       
    [super requestDidFinishLoad:request];
}


- (BOOL)isLoadingMore {
    return YES;
}

- (BOOL)isOutdated {
    return NO;
}

- (BOOL)isEmpty {
    return NO;
}

- (BOOL)isLoaded{
    return YES;
}
@end

@implementation CustomCellsWithTableViewBannerDataSource

- (id)initWithSearchQuery:(NSString*)queryString{
    if ((self = [super init])) {
        cellBannerModel = [[CustomCellsWithTableViewBannerModel alloc] initWithSearchQuery:queryString];    
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
	return cellBannerModel;
}



- (void)tableViewDidLoadModel:(UITableView*)tableView {
    
    NSMutableArray* items = [[NSMutableArray alloc] init];
    
    
    
    [items addObject:[TTTableImageItem itemWithText:@"This is first Left Side Text" imageURL:@"bundle://tableIcon.png"]];
    
    [items addObject:[TTTableRightImageItem itemWithText:@"I wanted to demonstrate apple SMS type look and feel using three20. This is not a complete implementation" imageURL:@"bundle://defaultPerson.png" defaultImage:nil imageStyle:TTSTYLE(rounded) URL:nil]];

     
   
    [items addObject:[TTTableImageItem itemWithText:@"To view complete implementation checkout my app on appstore" imageURL:@"bundle://tableIcon.png"]];
    

     [items addObject:[TTTableImageItem itemWithText:@"This has custom cell with variable height,table bannerView. This should be suffecient for anyone wants to get started" imageURL:@"bundle://tableIcon.png"]];
    
    
     
     
    [items addObject:[TTTableRightImageItem itemWithText:@"If you have any suggestion or improvements to my code please let me know" imageURL:@"bundle://defaultPerson.png" defaultImage:nil imageStyle:TTSTYLE(rounded) URL:nil]];
    

     
    
    [items addObject:[TTTableRightImageItem itemWithText:@"Some more text.Just to add more cells.You can add more by typing on textbox and clicking send" imageURL:@"bundle://defaultPerson.png" defaultImage:nil imageStyle:TTSTYLE(rounded) URL:nil]];

    
   
     
     
    
    self.items = items;
    TT_RELEASE_SAFELY(items);
    
    
}



- (Class)tableView:(UITableView*)tableView cellClassForObject:(id) object { 
    

        return [super tableView:tableView cellClassForObject:object];	

}


- (NSString*)titleForLoading:(BOOL)reloading {
    return @"Searching...";
}

- (NSString*)titleForNoData {
    return @"No names found";
}


- (NSIndexPath*)tableView:(UITableView*)tableView willInsertObject:(id)object atIndexPath:(NSIndexPath*)indexPath
{

    
    NSLog(@"Inserting at %d %d item count %d %@", indexPath.section, indexPath.row, [self.items count], (NSString*) object);
    
	[self.items addObject:object];
	
	return [self tableView:tableView indexPathForObject:object];
    
	
}

@end

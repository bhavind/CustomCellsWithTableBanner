//
//  CustomCellsWithTableViewBannerDataSource.h
//  CustomCellsWithTableBanner
//
//  Created by Bhavin Dutia on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>

@interface CustomCellsWithTableViewBannerModel : TTURLRequestModel{
    NSString *_queryString;
}
@property (nonatomic, retain)     NSString* queryString;


- (id)initWithSearchQuery:(NSString*)queryString;
@end


@interface CustomCellsWithTableViewBannerDataSource : TTListDataSource{
    CustomCellsWithTableViewBannerModel* cellBannerModel;
}


- (id)initWithSearchQuery:(NSString*)queryString;
@end

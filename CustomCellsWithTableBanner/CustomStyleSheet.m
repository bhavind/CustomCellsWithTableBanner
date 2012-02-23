//
//  CustomStyleSheet.m
//  CustomCellsWithTableBanner
//
//  Created by Bhavin Dutia on 2/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomStyleSheet.h"

@implementation CustomStyleSheet

- (CGFloat) tableBannerViewHeight {
    return 44;
}

- (UIColor*)chatTextColor {
    return RGBCOLOR(112, 87, 65);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIColor*)textColor {
    return RGBCOLOR (112, 87, 65);
}

- (UIFont*)font {
    return [UIFont fontWithName:@"Helvetica" size:12];
}

@end

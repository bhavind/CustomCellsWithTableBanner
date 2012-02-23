//
//  CustomCellsWithTableViewBanner.h
//  CustomCellsWithTableBanner
//
//  Created by Bhavin Dutia on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Three20/Three20.h>
#import "HPGrowingTextView.h"


@interface CustomCellsWithTableViewBanner : TTTableViewController<HPGrowingTextViewDelegate>{
    UIButton* sendButton;
    TTButton *footerButton;
    HPGrowingTextView *textView;
    UIView *containerView;
    BOOL didShowModelFlag;
    int count;
}

//-(void)resignTextView;


@end

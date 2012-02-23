//
//  CustomCellsWithTableViewBanner.m
//  CustomCellsWithTableBanner
//
//  Created by Bhavin Dutia on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomCellsWithTableViewBanner.h"
#import "CustomCellsWithTableViewBannerDataSource.h"
#import "Three20UI/UITableViewAdditions.h"
#import "Three20UICommon/UIViewControllerAdditions.h"
#import "CustomStyleSheet.h"


@implementation CustomCellsWithTableViewBanner

- (id) initWithNavigatorURL:(NSURL*)URL query:(NSDictionary*)query {
    self = [super init];
    if (self != nil) {
        self.title = @"SMS Like Interface";
          [TTStyleSheet setGlobalStyleSheet:[[[CustomStyleSheet alloc] init] autorelease]];
        [[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardWillShow:) 
													 name:UIKeyboardWillShowNotification 
												   object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(keyboardWillHide:) 
													 name:UIKeyboardWillHideNotification 
												   object:nil];		
        count = 11;

    }
    return self;
}

- (void) viewWillAppear:(BOOL) animated {
    [super viewWillAppear:animated];
    }

- (void) didReceiveMemoryWarning {
    /*
     * Do Something
     */
    
    [super didReceiveMemoryWarning];
}

- (void) viewWillDisappear:(BOOL) animated {
    
    [super viewWillDisappear:animated];
}


- (void)sendButtonTapped {
    
    if(![textView.text isEqualToString:@""]){
        
        NSLog(@"TextView text is %@",textView.text);

        
        [self.model didInsertObject:[TTTableImageItem itemWithText:textView.text imageURL:@"bundle://NoImageIcon@2x.png"] atIndexPath:[NSIndexPath indexPathForRow:count inSection:0]];
               
        count=count++;
        if (self.tableOverlayView) {
            [self showLoading:YES];
        }
        sendButton.enabled = FALSE;
        textView.text = nil;
                  
        [self.tableView scrollToBottom:NO];

    }
}
- (void) loadView {
	[super loadView];
        
    self.tableViewStyle = UITableViewStylePlain;
    self.variableHeightRows = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 440, 320, 40)];
    
    textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(6, 3, 240, 40)];
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    
    textView.minNumberOfLines = 1;
    textView.maxNumberOfLines = 3;
    textView.returnKeyType = UIReturnKeyDefault; //just as an example
    textView.font = [UIFont systemFontOfSize:15.0f];
    textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [UIColor whiteColor ];

    UIImage *rawEntryBackground = [UIImage imageNamed:@"chatCircle.png"];
    UIImage *entryBackground = [rawEntryBackground stretchableImageWithLeftCapWidth:16 topCapHeight:19];
    UIImageView *entryImageView = [[[UIImageView alloc] initWithImage:entryBackground] autorelease];
    entryImageView.frame = CGRectMake(5, 0, 248, 40);
    entryImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    UIImage *rawBackground = [UIImage imageNamed:@"chatBackground.png"];
    UIImage *background = [rawBackground stretchableImageWithLeftCapWidth:16 topCapHeight:19];
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:background] autorelease];
    imageView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [containerView addSubview:imageView];
    [containerView addSubview:textView];
    [containerView addSubview:entryImageView];

    UIImage* imageNormal = [UIImage imageNamed:@"SendButtonEnabled.png"];
    UIImage* imageHighlighted = [UIImage imageNamed:@"SendButtonOnPress.png"];
	UIImage* imageDisabled = [UIImage imageNamed:@"SendButtonDisabled.png"];
    
	CGRect sendButtonFrame = CGRectMake(260, 3.5, 50, 30);
    
    sendButton = [[UIButton alloc]initWithFrame:sendButtonFrame];
    [sendButton setBackgroundImage:imageNormal  forState:UIControlStateNormal];
    [sendButton setBackgroundImage:imageHighlighted forState:UIControlStateHighlighted];
    [sendButton setBackgroundImage:imageDisabled forState:UIControlStateDisabled];
    sendButton.userInteractionEnabled =YES;
    sendButton.enabled = NO;
    sendButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
	[sendButton addTarget:self action:@selector(sendButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [containerView addSubview:sendButton];
    
    [self setTableBannerView: containerView];
    
    self.tableBannerView.userInteractionEnabled = YES;

    
    self.dataSource = [[[CustomCellsWithTableViewBannerDataSource alloc]initWithSearchQuery:@"Search"]autorelease];
    
}




-(void) keyboardWillShow:(NSNotification *)note{
    
    // get keyboard size and loctaion
    sendButton.enabled = NO;
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
	
	// get the height since this is the main value that we need.
	NSInteger kbSizeH = keyboardBounds.size.height;
    
	// get a rect for the textView frame
	CGRect containerFrame = containerView.frame;
    	containerFrame.origin.y -= kbSizeH;
    //rect for tableView
    CGRect tableViewFrame = self.tableView.frame;
    
    
    //tableViewFrame = CGRectMake(0, 0, 320, 150);
    NSInteger containerViewHeight = containerFrame.size.height;
    //    tableViewFrame.origin.y = tableViewFrame.origin.y-containerViewHeight-keyboardBounds.size.height;
    //tableViewFrame.size.height = tableViewFrame.size.height-containerViewHeight-keyboardBounds.size.height+25;
    tableViewFrame.size.height = self.view.bounds.size.height-containerViewHeight-keyboardBounds.size.height+44 ;  //44 height of navigation bar 
    
    
    
  	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.25f];
	
	// set views with new info
	containerView.frame = containerFrame;
    self.tableView.frame = tableViewFrame;
    _tableOverlayView.frame = CGRectMake(0, 0, 320, 156);
    [self.tableView scrollToBottom:NO];
    
    
	
	// commit animations
	[UIView commitAnimations];
}

-(void) keyboardWillHide:(NSNotification *)note{
    // get keyboard size and location
	CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
	
	// get the height since this is the main value that we need.
	NSInteger kbSizeH = keyboardBounds.size.height;
	
	// get a rect for the textView frame
	CGRect containerFrame = containerView.frame;
	containerFrame.origin.y += kbSizeH;
	
	// animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.25f];
    [self.tableView scrollToBottom:NO];
	
	// set views with new info
	containerView.frame = containerFrame;
    //self.tableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height-containerFrame.size.height);
    self.tableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height-containerFrame.size.height+44); //44 navigation bar height
	// commit animations
	[UIView commitAnimations];
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    float diff = (growingTextView.frame.size.height - height);
    
	CGRect r = containerView.frame;
    r.size.height -= diff;
    r.origin.y += diff;
	containerView.frame = r;
    
    
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.10f];
    /*
     * Adjust the height of table view accordingly
     */
    CGRect tableViewFrame = self.tableView.frame;
    //    NSInteger containerViewHeight = containerView.frame.size.height;
    tableViewFrame.size.height = tableViewFrame.size.height - (-diff);
    self.tableView.frame = tableViewFrame;
    [self.tableView scrollToBottom:NO];
    
    [UIView commitAnimations];
    
    
}

- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *newText = [growingTextView.text stringByReplacingCharactersInRange:range withString:text]; 
    BOOL isFieldEmpty = [newText isEqualToString:@""];
    if(didShowModelFlag){
        sendButton.enabled = !isFieldEmpty;
    }
    //sendButton.enabled = !isFieldEmpty;
    else{
        sendButton.enabled = NO;
    }
    
    sendButton.enabled = YES;
    return YES;
}


- (void)dealloc {    
    [super dealloc];
}





@end

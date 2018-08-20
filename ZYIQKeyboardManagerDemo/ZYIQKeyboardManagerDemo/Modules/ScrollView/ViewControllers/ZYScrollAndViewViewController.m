//
//  ZYScrollAndViewViewController.m
//  ZYIQKeyboardManagerDemo
//
//  Created by 郑奕 on 2018/8/19.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ZYScrollAndViewViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface ZYScrollAndViewViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation ZYScrollAndViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"scroll+view";
    self.contentView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height+100);
    self.scrollView.contentSize = self.contentView.bounds.size;
    [self.scrollView addSubview:self.contentView];
}



@end

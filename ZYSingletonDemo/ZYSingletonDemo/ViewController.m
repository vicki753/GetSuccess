//
//  ViewController.m
//  ZYSingletonDemo
//
//  Created by 郑奕 on 2018/10/15.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ViewController.h"
#import "ZYSingleTonClass.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *firstCountShowLabel;

@property (weak, nonatomic) IBOutlet UILabel *secondCountShowLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
}

#pragma mark - Custom Method
- (void)showCountOnLabel {
   self.firstCountShowLabel.text = [NSString stringWithFormat:@"%zd",[ZYSingleTonClass fisrtSharenIncetance].count];
    self.secondCountShowLabel.text = [NSString stringWithFormat:@"%zd",[ZYSingleTonClass secondSharenInstance].count];
}



#pragma mark - Event
- (IBAction)createSingletonButtonAction:(UIButton *)sender {
    NSLog(@"[ZYSingleTonClass fisrtSharenIncetance] == %@", [ZYSingleTonClass fisrtSharenIncetance]);
    NSLog(@"[ZYSingleTonClass secondSharenInstance] == %@", [ZYSingleTonClass secondSharenInstance]);
    
// 这两个单例 创建的对象地址不一样，所以是分别创建的。
    [self showCountOnLabel];
}



- (IBAction)increaseButtonAction:(UIButton *)sender {
    [ZYSingleTonClass fisrtSharenIncetance].count++;
     [ZYSingleTonClass secondSharenInstance].count++;
    NSLog(@" [ZYSingleTonClass fisrtSharenIncetance].count== %zd",  [ZYSingleTonClass fisrtSharenIncetance].count);
    
    
    [self showCountOnLabel];
}

- (IBAction)reduceButtonAction:(UIButton *)sender {
     [ZYSingleTonClass fisrtSharenIncetance].count--;
      [ZYSingleTonClass secondSharenInstance].count--;
    NSLog(@" [ZYSingleTonClass fisrtSharenIncetance].count== %zd",  [ZYSingleTonClass fisrtSharenIncetance].count);
    [self showCountOnLabel];
}



@end

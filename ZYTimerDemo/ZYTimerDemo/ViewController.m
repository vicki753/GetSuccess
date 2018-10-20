//
//  ViewController.m
//  ZYTimerDemo
//
//  Created by 郑奕 on 2018/10/15.
//  Copyright © 2018 郑奕. All rights reserved.
//

#import "ViewController.h"
#import "NSTimer+ZY.h"

static NSInteger count = 0;
@interface ViewController ()

@property (nonatomic, strong) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UILabel *timerCountLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)dealloc {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

#pragma mark - Event

- (IBAction)startCountTimeAction:(UIButton *)sender {
 self.timer.fireDate = [NSDate distantPast]; //开启定时器
}

- (IBAction)stopCountTimeAction:(UIButton *)sender {
self.timer.fireDate = [NSDate distantFuture]; //停止定时器
}



#pragma mark - Custom Method
- (void)showTheTimerCount {
    count ++;
    self.timerCountLabel.text = [NSString stringWithFormat:@"%zd", count];
    
}


#pragma mark - Getter
-(NSTimer *)timer {
    if (!_timer ) {
        __weak typeof(self) weakSelf = self;
        _timer = [NSTimer zy_scheduledTimerWithTimeInterval:1.0 repeats:YES block:^{
            [weakSelf showTheTimerCount];
        }];
    }
    return _timer;
}

@end

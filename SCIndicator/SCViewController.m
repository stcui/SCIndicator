//
//  SCViewController.m
//  SCIndicator
//
//  Created by cui on 13-3-20.
//  Copyright (c) 2013年 stcui.me. All rights reserved.
//

#import "SCViewController.h"
#import "SCIndicator.h"

@interface SCViewController ()
@property (strong, nonatomic) SCIndicator *indicator;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) float progress;
@end

@implementation SCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.indicator = [[SCIndicator alloc] initWithImage:[UIImage imageNamed:@"apple_rainbow_logo"]];
    self.indicator.center = CGPointMake(CGRectGetMidX(self.view.bounds), 200);
    [self.view addSubview:self.indicator];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(update:) userInfo:nil repeats:YES];
}

- (void)update:(NSTimer *)timer
{
    if (self.progress >= 1) self.progress = 0;
    self.progress += 0.1;
    self.indicator.progress = self.progress;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

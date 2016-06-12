//
//  ViewController.m
//  BKSafeKitDemo
//
//  Created by BestKai on 16/5/30.
//  Copyright © 2016年 BestKai. All rights reserved.
//

#import "ViewController.h"
#import "BKSafeKit.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *aaa = [[NSMutableArray alloc] initWithObjects:@[],@[], nil];
    
    NSLog(@"%@",aaa[3]);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

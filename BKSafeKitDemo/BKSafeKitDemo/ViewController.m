//
//  ViewController.m
//  BKSafeKitDemo
//
//  Created by BestKai on 16/5/30.
//  Copyright © 2016年 BestKai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *aaa = [NSMutableArray arrayWithObjects:[[NSArray alloc] init],[[NSMutableArray alloc] init], nil];
    
    [aaa[1] addObject:@"123"];
    
    [aaa[0] addObjectsFromArray:aaa[1]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

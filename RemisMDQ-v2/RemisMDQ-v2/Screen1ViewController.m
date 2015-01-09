//
//  Screen1ViewController.m
//  RemisMDQ-v2
//
//  Created by Lucas on 1/9/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "Screen1ViewController.h"

@interface Screen1ViewController ()

@end

@implementation Screen1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)testMe:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Well, it works" delegate:self cancelButtonTitle:@"hurray!" otherButtonTitles:nil];
    [alert show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

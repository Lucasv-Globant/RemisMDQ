//
//  ViewControllerCurrentRequestDisplay.m
//  RemisMDQ-v2
//
//  Created by Lucas on 1/15/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "ViewControllerCurrentRequestDisplay.h"
#import "ViewControllerAgencySelection.h"

@interface ViewControllerCurrentRequestDisplay ()
@property (strong, nonatomic) IBOutlet UIButton *buttonCancel;

@end

@implementation ViewControllerCurrentRequestDisplay

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITabBarItem *)tabBarItem
{
    return [[UITabBarItem alloc] initWithTitle:@"Pedido" image:[UIImage imageNamed:@"TimerTabBarIcon.png"] tag:0];
}
- (IBAction)cancelRequest:(id)sender {
    ViewControllerAgencySelection * nextScreen = [[ViewControllerAgencySelection alloc] initWithNibName:@"ViewControllerAgencySelection" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:nextScreen];
    [self presentViewController:navController animated:YES completion:nil];
         
}



@end

//
//  Screen1ViewController.m
//  RemisMDQ-v2
//
//  Created by Lucas on 1/9/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "Screen1ViewController.h"
#import <Parse/Parse.h>
#import "NSString+CustonString.h"
#import "Facade.h"

@interface Screen1ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *textFieldNameAgency;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedModel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedColor;
@property (strong, nonatomic) IBOutlet UITextField *textFieldLicense;
@property (strong, nonatomic) IBOutlet UIButton *buttonAddVehicle;
@property (strong, nonatomic) IBOutlet UIButton *buttonAddAgency;

@property (assign, nonatomic)   NSInteger selectedSegmentModel;
@property (assign, nonatomic)   NSInteger selectedSegmentColor ;
@property (strong, nonatomic)   PFObject * vehicle;
@end

@implementation Screen1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedSegmentColor=0;
    self.selectedSegmentModel=0;
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)segmentColor:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    self.selectedSegmentColor = segmentedControl.selectedSegmentIndex;
    NSLog(@"%ld",(long)self.selectedSegmentColor);
}

- (IBAction)segmentModel:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    self.selectedSegmentModel = segmentedControl.selectedSegmentIndex;
    NSLog(@"%ld",(long)self.selectedSegmentModel);
}
- (IBAction)AddVehicle:(id)sender {
     [Facade sharedInstance];
    NSDictionary * dic =[[Facade sharedInstance] findInParseWith:@"name" value:self.textFieldNameAgency.text in:@"Agency"];
    NSString * licencia = [[NSString alloc]initWithString:self.textFieldLicense.text];
    if ([[self.textFieldLicense text] EsVacio] && [[self.textFieldNameAgency text] EsVacio] ) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No ingresaste ninguna campo" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil] show];
        
    }
  
    
    if ([self.textFieldNameAgency.text isEqualToString:[dic valueForKey:@"name" ]]) {
        
        
        
        self.vehicle =[PFObject objectWithClassName:@"Vehicle"];
        [self.vehicle setObject:[NSNumber numberWithInteger:self.selectedSegmentModel]forKey:@"model"];
        [self.vehicle setObject:[NSNumber numberWithInteger:self.selectedSegmentColor] forKey:@"color"];
        [self.vehicle setObject:licencia forKey:@"licensePlate"];
        self.vehicle[@"agency"]= [dic valueForKey:@"objectId"];
        [self.vehicle saveInBackground];
    }

    else
    {
    NSString * nameagency = [[NSString alloc] initWithString:self.textFieldNameAgency.text];
    
    PFObject * agency = [PFObject objectWithClassName:@"Agency"];
    [agency setObject:nameagency forKey:@"name"];
   
    self.vehicle =[PFObject objectWithClassName:@"Vehicle"];
    [self.vehicle setObject:[NSNumber numberWithInteger:self.selectedSegmentModel]forKey:@"model"];
    [self.vehicle setObject:[NSNumber numberWithInteger:self.selectedSegmentColor] forKey:@"color"];
    [self.vehicle setObject:licencia forKey:@"licensePlate"];
     self.vehicle[@"agency"]= agency;
    [self.vehicle saveInBackground];
    }
    NSLog(@"%@",self.vehicle);

}

- (IBAction)addAgency:(id)sender {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end

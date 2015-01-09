//
//  ViewController.m
//  RemisMDQ
//
//  Created by Analia on 1/8/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "ViewControllerAgency.h"
#import <Parse/Parse.h>
#import "Vehicle.h"
#import "NSString+CustonString.h"


@interface ViewControllerAgency ()

@property (weak, nonatomic) IBOutlet UITextField *textFieldNameAgency;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedModel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedColor;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLicense;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddVehicle;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddAgency;



@property (assign, nonatomic)   NSInteger selectedSegmentModel ;
@property (assign, nonatomic)   NSInteger selectedSegmentColor ;


@end

@implementation ViewControllerAgency

//Sacar el teclado cuanto apretas Return o cualquier parte de la pantalla
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(bool) textFieldShouldReturn:(UITextField *)textField
{
    BOOL retorno = [self.view endEditing:YES];
    return retorno;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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


- (IBAction)addVehicle:(id)sender {
    NSString * licencia = [[NSString alloc]initWithString:self.textFieldLicense.text];
    NSString * nameagency = [[NSString alloc] initWithString:self.textFieldNameAgency.text];
    
    if ([[self.textFieldLicense text] EsVacio] && [[self.textFieldNameAgency text] EsVacio] ) {
        UIAlertView * alerta = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No ingresaste ninguna campo" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil];
        [alerta show];
    }
    PFObject * vehicle =[PFObject objectWithClassName:@"vechicle"];
    [vehicle setObject:[NSString stringWithFormat:@"%ld",(long)self.selectedSegmentModel]forKey:@"model"];
    [vehicle setObject:[NSString stringWithFormat:@"%ld",(long)self.selectedSegmentColor] forKey:@"color"];
    [vehicle setObject:licencia forKey:@"licensePlate"];
    PFObject * agency = [PFObject objectWithClassName:@"agency"];
    [agency setObject:nameagency forKey:@"name"];
    [vehicle setObject:agency forKey:@"agency"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

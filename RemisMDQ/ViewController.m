//
//  ViewController.m
//  RemisMDQ
//
//  Created by Analia on 1/8/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import "Vehicle.h"
#import "NSString+CustonString.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelAgencia;
@property (weak, nonatomic) IBOutlet UITextField *textFieldname;
@property (weak, nonatomic) IBOutlet UILabel *labelAuto;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedModelo;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedColor;
@property (weak, nonatomic) IBOutlet UITableView *tableAgencia;
@property (weak, nonatomic) IBOutlet UIButton *buttonFinalizar;
@property (weak, nonatomic) IBOutlet UIButton *buttonAgregar;

@property (assign, nonatomic)   NSInteger selectedSegmentModel ;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLicense;

@property (assign, nonatomic)   NSInteger selectedSegmentColor ;
@end

@implementation ViewController

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
    NSString * nameagency = [[NSString alloc] initWithString:self.textFieldname.text];
    
    if ([[self.textFieldLicense text] EsVacio] && [[self.textFieldname text] EsVacio] ) {
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

//
//  CellCustomVehicle.m
//  RemisMDQ-v2
//
//  Created by Analia on 1/13/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "CellCustomVehicle.h"
#import <Parse/Parse.h>
#import "Facade.h"
#import "Vehicle.h"


@interface CellCustomVehicle ()
@property (strong, nonatomic) IBOutlet UILabel *labelAgency;
@property (strong, nonatomic) IBOutlet UILabel *labelModel;
@property (strong, nonatomic) IBOutlet UILabel *labelColor;
@property (strong, nonatomic) IBOutlet UILabel *labelLicense;

@property (strong, nonatomic) NSMutableArray * listAgency;


@end

@implementation CellCustomVehicle

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configurarCelda:( NSMutableArray * )vehicle {
    
   //Configurar Modelo
    VehicleModel model = [[vehicle valueForKey:@"model"] intValue];
   [self.labelModel setText:[NSString stringWithFormat:@"Modelo: %@",[Vehicle stringForVehicleModelCode:model]]];
    
    //Configuarar Color
    VehicleColor color = [[vehicle valueForKey:@"color"] intValue];
    [self.labelColor setText:[NSString stringWithFormat:@"Color: %@",[Vehicle stringForVehicleColorCode:color]]];
    
    //Configurar Licencia
    [self.labelLicense setText:[NSString stringWithFormat:@"Licencia: %@",[vehicle valueForKey:@"licensePlate"]]];
    
    //Configurar Agencia
    PFObject * agency = [vehicle valueForKey:@"agency"];
    PFQuery *query = [PFQuery queryWithClassName:@"Agency"];
    [query whereKey:@"objectId" equalTo:[agency valueForKey:@"objectId"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
           [self.labelAgency setText:[NSString stringWithFormat:@"Agencia: %@",[[objects objectAtIndex:0] valueForKey:@"name"]]];
        }];
}


@end

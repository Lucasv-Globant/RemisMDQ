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
@property (assign, nonatomic) VehicleModel model;

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
    
    PFObject * agency = [vehicle valueForKey:@"agency"];
    NSNumber * modelVehicle = [vehicle valueForKey:@"model"];
    self.model= [modelVehicle intValue];
        NSLog(@"%d",self.model );
    PFQuery *query = [PFQuery queryWithClassName:@"Agency"];
    [query whereKey:@"objectId" equalTo:[agency valueForKey:@"objectId"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
   //     NSLog(@"%@",objects);
        [self.labelAgency setText:[[objects objectAtIndex:0] valueForKey:@"name"]];
        

    }];
    
   }


@end

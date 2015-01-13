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
@interface CellCustomVehicle ()
@property (strong, nonatomic) IBOutlet UILabel *labelAgency;
@property (strong, nonatomic) IBOutlet UILabel *labelModel;
@property (strong, nonatomic) IBOutlet UILabel *labelColor;
@property (strong, nonatomic) IBOutlet UILabel *labelLicense;

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
    
      // NSLog(@"%@",[agency valueForKey:@"objectId"]);
    NSDictionary * dic = [[NSDictionary alloc] initWithDictionary:[[Facade sharedInstance] findInParseWith:@"objectId" value:[agency valueForKey:@"objectId"] in:@"Agency"]];
    for (PFObject * object in dic) {
        NSLog(@"%@",[object valueForKey:@"name"]);
    }
    
    //[self.labelAgency setText:[agency valueForKey:@"name"]];
    //[self.labelModel setText:[vehicle valueForKey:@"model"]];
    //[self.labelColor setText:[vehicle valueForKey:@"color"]];
   // [self.labelLicense setText:[vehicle valueForKey:@"license"]];
}


@end

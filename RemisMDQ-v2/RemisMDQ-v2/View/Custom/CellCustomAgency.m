//
//  CellCustomAgency.m
//  RemisMDQ-v2
//
//  Created by Analia on 1/12/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "CellCustomAgency.h"

@implementation CellCustomAgency

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configurarCelda:( NSArray * )agency {
   
    [self.labelNameAgency setText:[agency valueForKey:@"name"] ];
    [self.labelObjectId setText:[agency valueForKey:@"objectId"]];
}

@end

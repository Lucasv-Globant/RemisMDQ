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

-(void)configurarCelda:( NSMutableArray * )agency {
   
    [self.labelNameAgency setText:[agency valueForKey:@"name"] ];
}
- (IBAction)next:(id)sender {
    [self.delegate next];
}

@end

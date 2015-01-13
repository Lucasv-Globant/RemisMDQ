//
//  CellCustomAgency.h
//  RemisMDQ-v2
//
//  Created by Analia on 1/12/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellCustomAgency : UITableViewCell
//IBOutlet
@property (strong, nonatomic) IBOutlet UILabel *labelNameAgency;

//Method
-(void)configurarCelda:( NSMutableArray * )agency;
@end

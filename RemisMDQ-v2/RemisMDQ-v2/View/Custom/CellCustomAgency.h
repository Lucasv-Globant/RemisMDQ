//
//  CellCustomAgency.h
//  RemisMDQ-v2
//
//  Created by Analia on 1/12/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyCustomCellDelegate <NSObject>
- (void)next;

@end


@interface CellCustomAgency : UITableViewCell
//IBOutlet
@property (strong, nonatomic) IBOutlet UILabel *labelNameAgency;
@property (strong, nonatomic) IBOutlet UIButton *buttonNext;
@property (nonatomic, assign) id<MyCustomCellDelegate> delegate;
//Method
-(void)configurarCelda:( NSMutableArray * )agency;
@end

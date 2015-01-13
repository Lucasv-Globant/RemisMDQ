//
//  ViewControllerVehicle.m
//  RemisMDQ-v2
//
//  Created by Analia on 1/13/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "ViewControllerVehicle.h"
#import "Facade.h"
#import "CellCustomVehicle.h"

@interface ViewControllerVehicle ()
@property (assign, nonatomic) NSInteger cantVehicle;
@property (strong, nonatomic) NSMutableArray * findObject;
@property (strong, nonatomic) IBOutlet UITableView *tabla;
@end

@implementation ViewControllerVehicle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.findObject = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tabla registerNib:[UINib nibWithNibName:@"CellCustomVehicle"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:@"CellCustomVehicle"] ;
    [self findAgency];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark findAgency
-(void)findAgency
{
    [[Facade sharedInstance] getInParse:[self getSucces] failure:[self getFailure] from:@"Vehicle"];
}

-(Success)getSucces
{
    return ^(NSArray * array) {
        __weak typeof(self) weakself = self;
        weakself.cantVehicle = array.count;
        [weakself.findObject addObjectsFromArray:array];
        //NSLog(@"%@",weakself.findObject);
        [_tabla reloadData];
        
    };
}

-(Failure)getFailure
{
    return ^(NSError *error) {
        NSLog(@"error");
    };
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.cantVehicle;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"CellCustomVehicle";
    //Intentamos recuperar una celda ya creada.
    CellCustomVehicle * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell) {
        //Si la celda no existe, la creamos.
        cell=[[CellCustomVehicle alloc]init];
    }
    
    [cell configurarCelda:[self.findObject objectAtIndex:indexPath.row]];
    return cell;
}
@end


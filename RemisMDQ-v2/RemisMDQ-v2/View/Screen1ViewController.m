//
//  Screen1ViewController.m
//  RemisMDQ-v2
//
//  Created by Lucas on 1/9/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "Screen1ViewController.h"
#import <Parse/Parse.h>
#import "NSString+CustonString.h"
#import "Facade.h"
#import "CellCustomAgency.h"

@interface Screen1ViewController ()
//IBOutlet
@property (strong, nonatomic) IBOutlet UITextField *textFieldNameAgency;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedModel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedColor;
@property (strong, nonatomic) IBOutlet UITextField *textFieldLicense;
@property (strong, nonatomic) IBOutlet UIButton *buttonAddVehicle;
@property (strong, nonatomic) IBOutlet UIButton *buttonAddAgency;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//var
@property (assign, nonatomic)   NSInteger selectedSegmentModel;
@property (assign, nonatomic)   NSInteger selectedSegmentColor ;
@property (strong, nonatomic)   PFObject * vehicle;
@property (strong, nonatomic)   NSMutableArray * findObject;
@property (assign, nonatomic)   NSInteger cantidadAgency;
@property (strong, nonatomic)   NSString * agency;
@property (strong, nonatomic)   UIRefreshControl * refreshControl;
@end

@implementation Screen1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.findObject = [[NSMutableArray alloc] init];
    self.selectedSegmentColor=0;
    self.selectedSegmentModel=0;
    [self.tableView registerNib:[UINib nibWithNibName:@"CellCustomAgency"
                                           bundle:[NSBundle mainBundle]]
                                forCellReuseIdentifier:@"CellCustomAgency"] ;
    

    [self findAgency];
    // Initialize Refresh Control
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    
    // Configure Refresh Control
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    // Configure View Controller
    [self setRefreshControl:refreshControl];
}

- (void)refresh:(id)sender {
    NSLog(@"Refreshing");
    
    [self findAgency];
    // End Refreshing
    [(UIRefreshControl *)sender endRefreshing];
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

- (IBAction)addAgency:(id)sender {
    
    if ([[self.textFieldNameAgency text] EsVacio]) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No ingresaste ninguna campo" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil] show];}
 
     [Facade sharedInstance];
     NSString * nameagency = [[NSString alloc] initWithString:self.textFieldNameAgency.text];
     PFObject * agency = [PFObject objectWithClassName:@"Agency"];
     [agency setObject:nameagency forKey:@"name"];
     [agency save];
    [self findAgency];
    
    
}


- (IBAction)AddVehicle:(id)sender {
     [Facade sharedInstance];
    NSString * licencia = [[NSString alloc]initWithString:self.textFieldLicense.text];
    if ([[self.textFieldLicense text] EsVacio] ) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No ingresaste ninguna campo" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil] show];
        
    }
       self.vehicle =[PFObject objectWithClassName:@"Vehicle"];
       [self.vehicle setObject:[NSNumber numberWithInteger:self.selectedSegmentModel]forKey:@"model"];
       [self.vehicle setObject:[NSNumber numberWithInteger:self.selectedSegmentColor] forKey:@"color"];
       [self.vehicle setObject:licencia forKey:@"licensePlate"];
       [self.vehicle setValue:self.agency forKey:@"agency"];
       [self.vehicle saveInBackground];
       NSLog(@"%@",self.vehicle);
    
}

-(void)findAgency
{
    [[Facade sharedInstance] getInParse:[self getSucces] failure:[self getFailure] from:@"Agency"];
    
}

-(Success)getSucces
{
    return ^(NSArray * array) {
          __weak typeof(self) weakself = self;
        weakself.cantidadAgency = array.count;
        [weakself.findObject addObjectsFromArray:array];
        NSLog(@"%@",weakself.findObject);
        [_tableView reloadData];
    };
}

-(Failure)getFailure
{
    return ^(NSError *error) {
        NSLog(@"error");
    };
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.cantidadAgency;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CellCustomAgency";
    //Intentamos recuperar una celda ya creada.
    CellCustomAgency * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell) {
        //Si la celda no existe, la creamos.
        cell=[[CellCustomAgency alloc]init];
    }
    
    [cell configurarCelda:[self.findObject objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark-UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.agency=[[self.findObject valueForKey:@"objectId"] objectAtIndex:indexPath.row];
    
}





@end

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
#import "ViewControllerVehicle.h"

@interface Screen1ViewController ()
//IBOutlet
@property (strong, nonatomic) IBOutlet UITextField *textFieldNameAgency;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedModel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedColor;
@property (strong, nonatomic) IBOutlet UITextField *textFieldLicense;
@property (strong, nonatomic) IBOutlet UIButton *buttonAddVehicle;
@property (strong, nonatomic) IBOutlet UIButton *buttonAddAgency;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *buttonVehicle;
//var
@property (assign, nonatomic)   NSInteger selectedSegmentModel;
@property (assign, nonatomic)   NSInteger selectedSegmentColor ;
@property (strong, nonatomic)   PFObject * vehicle;
@property (strong, nonatomic)   NSMutableArray * findObject;
@property (assign, nonatomic)   NSInteger cantidadAgency;
@property (strong, nonatomic)   PFObject * agency;
@property (strong, nonatomic)   UIRefreshControl * refresh;
@end

@implementation Screen1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Inicializacion
    self.findObject = [[NSMutableArray alloc] init];
    self.selectedSegmentColor=0;
    self.selectedSegmentModel=0;
    [self.tableView registerNib:[UINib nibWithNibName:@"CellCustomAgency"
                                           bundle:[NSBundle mainBundle]]
                                forCellReuseIdentifier:@"CellCustomAgency"] ;
    //Cargar Tabla
    [self findAgency];
    
    //UIRefreshView
    self.refresh = [[UIRefreshControl alloc] init];
    self.refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [self.refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refresh];
      self.title = @"Remiserias";
    
}
//Metodo donde se van a recargar los datos
-(void)refreshView:(UIRefreshControl *)refresh
{
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data...."];
    NSLog(@"Refreshing data");
    [self.tableView reloadData];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString * lastUpdated = [NSString stringWithFormat:@"Last Updated on %@",[formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    
}
//Metodos para UISegmented Color
- (IBAction)segmentColor:(id)sender {
    //Me permite guardar el index de cada objecto en una variable y traducirlo al enum
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    self.selectedSegmentColor = segmentedControl.selectedSegmentIndex;
    NSLog(@"%ld",(long)self.selectedSegmentColor);
}
//Metodos para UISegmented Model
- (IBAction)segmentModel:(id)sender {
    //Me permite guardar el index de cada objecto en una variable y traducirlo al enum
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    self.selectedSegmentModel = segmentedControl.selectedSegmentIndex;
    NSLog(@"%ld",(long)self.selectedSegmentModel);
}

- (IBAction)addAgency:(id)sender {
    //Button de agregar
    if ([[self.textFieldNameAgency text] EsVacio]) {
        //Verifico campo vacio
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No ingresaste ninguna campo" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil] show];}
    else{
    //Guardo en Parse
     [Facade sharedInstance];
     NSString * nameagency = [[NSString alloc] initWithString:self.textFieldNameAgency.text];
     PFObject * agency = [PFObject objectWithClassName:@"Agency"];
     [agency setObject:nameagency forKey:@"name"];
     [agency saveInBackground];
     [self.tableView reloadData];
    }
}


- (IBAction)AddVehicle:(id)sender {
    //Guardo en Parse Vehiculo
    [Facade sharedInstance];
    NSString * licencia = [[NSString alloc]initWithString:self.textFieldLicense.text];
    if ([[self.textFieldLicense text] EsVacio] ) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"No ingresaste ninguna campo" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:@"Cancelar", nil] show];
        
    }
    else{
       self.vehicle =[PFObject objectWithClassName:@"Vehicle"];
       [self.vehicle setObject:[NSNumber numberWithInteger:self.selectedSegmentModel]forKey:@"model"];
       [self.vehicle setObject:[NSNumber numberWithInteger:self.selectedSegmentColor] forKey:@"color"];
       [self.vehicle setObject:licencia forKey:@"licensePlate"];
       [self.vehicle setValue:self.agency forKey:@"agency"];
       [self.vehicle saveInBackground];
       NSLog(@"%@",self.vehicle);
    }
}
- (IBAction)listVehicle:(id)sender {
    ViewControllerVehicle * control = [[ViewControllerVehicle alloc]initWithNibName:@"ViewControllerVehicle" bundle:[NSBundle mainBundle] ];
    [self.navigationController pushViewController:control animated:YES];
}
#pragma mark findAgency
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
       // NSLog(@"%@",weakself.findObject);
        [self.tableView reloadData];
        [self.refresh endRefreshing];
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
    self.agency=[self.findObject objectAtIndex:indexPath.row];
    NSLog(@"%@",self.agency);
    
}





@end

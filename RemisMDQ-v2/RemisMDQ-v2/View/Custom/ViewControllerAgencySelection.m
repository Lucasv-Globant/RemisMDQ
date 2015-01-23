//
//  ViewControllerAgencySelection.m
//  RemisMDQ-v2
//
//  Created by Lucas on 1/14/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "ViewControllerAgencySelection.h"


@interface ViewControllerAgencySelection ()

@property (assign, nonatomic)   NSInteger cantidadAgency;
@property (strong, nonatomic)   PFObject * agency;
@property (strong, nonatomic)   IBOutlet UITableView *tableView;
@property (strong, nonatomic)   UIRefreshControl * refresh;
@property (strong, nonatomic)   NSMutableArray * arrayOfAgencies;

@end

@implementation ViewControllerAgencySelection

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Inicializacion
    self.arrayOfAgencies = [[NSMutableArray alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"CellCustomAgency"
                                               bundle:[NSBundle mainBundle]]
                               forCellReuseIdentifier:@"CellCustomAgency"] ;
    
    //Cargar Tabla
    [self populateArrayOfAgencies];
    
    //UIRefreshView
    self.refresh = [[UIRefreshControl alloc] init];
    self.refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Pull to refresh"];
    [self.refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refresh];
    self.title = @"Seleccione Agencia";
}

-(Success)getAgencySuccessBlock {
    return ^(NSArray * array) {
        __weak typeof(self) weakself = self;
        weakself.cantidadAgency = array.count;
        [weakself.arrayOfAgencies addObjectsFromArray:array];
        // NSLog(@"%@",weakself.findObject);
        [self.tableView reloadData];
        [self.refresh endRefreshing];
    };
}

-(Failure)getAgencyFailureBlock {
    return ^(NSError *error) {
        NSLog(@"error");
    };
}

#pragma mark Refresh View method(s)
//Metodo donde se van a recargar los datos
-(void)refreshView:(UIRefreshControl *)refresh {
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing data...."];
    NSLog(@"Refreshing data");
    [self.tableView reloadData];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString * lastUpdated = [NSString stringWithFormat:@"Last Updated on %@",[formatter stringFromDate:[NSDate date]]];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:lastUpdated];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cantidadAgency;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"CellCustomAgency";
    //Intentamos recuperar una celda ya creada.
    CellCustomAgency * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (!cell) {
        //Si la celda no existe, la creamos.
        cell=[[CellCustomAgency alloc]init];
    }
       cell.delegate = self;
    [cell configurarCelda:[self.arrayOfAgencies objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark-UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.agency=[self.arrayOfAgencies objectAtIndex:indexPath.row];
    MobileApplication *mainApp = [MobileApplication sharedInstance];
    Facade *facade = [Facade sharedInstance];
    Agency *selectedAgency = [[Agency alloc]initFromDictionary:[facade convertPFObjectToDictionary:self.agency]];
    [mainApp setAgencyOfCurrentRequest:selectedAgency];
    
    NSLog(@"%@",self.agency);
    NSLog(@"%@",[[MobileApplication sharedInstance] agencyOfCurrentRequest]);
    [self next];
}

-(void)next
{
    ViewControllerOriginLocationSelection *nextScreen = [[ViewControllerOriginLocationSelection alloc] initWithNibName:@"ViewControllerOriginLocationSelection" bundle:nil];
    [self.navigationController pushViewController:nextScreen animated:YES];
}

#pragma mark Download of arrayOfAgencies
-(void)populateArrayOfAgencies {
    [[Facade sharedInstance] getInParse:[self getAgencySuccessBlock] failure:[self getAgencyFailureBlock] from:@"Agency"];
}

@end

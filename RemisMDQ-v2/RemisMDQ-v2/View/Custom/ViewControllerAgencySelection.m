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
@property (strong, nonatomic) IBOutlet UITableView *tableView;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(Success)getAgencySuccessBlock
{
    return ^(NSArray * array) {
        __weak typeof(self) weakself = self;
        weakself.cantidadAgency = array.count;
        [weakself.arrayOfAgencies addObjectsFromArray:array];
        // NSLog(@"%@",weakself.findObject);
        [self.tableView reloadData];
        [self.refresh endRefreshing];
    };
}

-(Failure)getAgencyFailureBlock
{
    return ^(NSError *error) {
        NSLog(@"error");
    };
}

#pragma mark Refresh View method(s)
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
    
    [cell configurarCelda:[self.arrayOfAgencies objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark-UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.agency=[self.arrayOfAgencies objectAtIndex:indexPath.row];
    NSLog(@"%@",self.agency);
    
}


#pragma mark Download of arrayOfAgencies
-(void)populateArrayOfAgencies
{
    [[Facade sharedInstance] getInParse:[self getAgencySuccessBlock] failure:[self getAgencyFailureBlock] from:@"Agency"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

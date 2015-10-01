//
//  HopTableViewController.m
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import "HopTableViewController.h"
#import "HopTableViewCell.h"
#import "Hop.h"
#import "ProductTableViewController.h"

@interface HopTableViewController ()

@property (nonatomic) NSMutableArray* products;
@property (nonatomic) NSInteger selectedIndex;
@end

@implementation HopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(hopsChanged:)
                                                 name:@"HopsChanged"
                                               object:nil];
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"Recipe" style:UIBarButtonItemStyleBordered target:self action:@selector(home:)];
    self.navigationItem.leftBarButtonItem=newBackButton;
    
}

-(void)home:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSString *) viewName {
    return @"HopTableViewController";
}

-(void) setRecipe:(Recipe *)recipe {
    _recipe = recipe;
    NSMutableArray* products = [Hop hopsForRecipe:recipe.code InDataBase:[DBModel database]];
    
    
    for(int i = 0; i < self.recipe.hops.count; i++){
        Hop * hop = [self.recipe.hops objectAtIndex:i];
        NSInteger index = [products indexOfObject:hop];
        if (index >= 0){
            [products replaceObjectAtIndex:index withObject:hop];
        }
    }
    
    
    _products = [[NSMutableArray alloc] initWithArray:products];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _products.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[HopTableViewCell viewName] forIndexPath:indexPath];
    
    Hop* hop = [_products objectAtIndex:indexPath.row];
    
    cell.title_label.text = hop.name;
    cell.AA_label.text = [NSString stringWithFormat:@"AA: %.02f %",  hop.AA];
    cell.IBUS_label.text = [NSString stringWithFormat:@"IBUS: %d", 10];
    
    cell.textField.delegate = self;
    
    if (hop.amount > 0){
        cell.textField.text = [NSString stringWithFormat:@"%.02f g",   hop.amount];
        cell.addButton.hidden = true;
        cell.textField.hidden = false;
        
    } else {
        cell.addButton.hidden = false;
        cell.textField.hidden = true;
    }
    
    
    cell.hop = hop;
    
    cell.textField.delegate = self;
    
    // Configure the cell...
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedIndex = indexPath.row;
    
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    [self selectItemAtIndex: self.selectedIndex];
    
    return YES;
    
}

-(void) selectItemAtIndex: (NSInteger) index{
    
    
    
}

- (IBAction)addItem:(UIBarButtonItem *)sender {
   
    ProductTableViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:[ProductTableViewController viewName]];
    [vc setProducts:[Hop hopsInDataBase:[DBModel database]]];
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)hopsChanged:(NSNotification *)note {
    double count = 0;
    
    NSMutableArray * hops = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.products.count; i++){
        Hop * hop = [self.products objectAtIndex:i];
        count+= hop.amount;
        if (hop.amount > 0){
            [hops addObject:hop];
        }
    }
    
    self.recipe.hops = hops;
    
    self.totalQTY.text = [NSString stringWithFormat:@"%.03f", count];
    
    [self.tableView reloadData];
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  GrainTableViewController.m
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import "GrainTableViewController.h"
#import "GrainTableViewCell.h"
#import "ProductTableViewController.h"
#import "Grain.h"

@interface GrainTableViewController ()

@property (nonatomic) NSMutableArray* products;
@property (nonatomic) NSInteger selectedIndex;
@end

@implementation GrainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(grainsChanged:)
                                                 name:@"GrainsChanged"
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
    return @"GrainTableViewController";
}

-(void) setRecipe:(Recipe *)recipe {
    _recipe = recipe;
    NSMutableArray* products = [Grain grainsForRecipe:recipe.code InDataBase:[DBModel database]];
    
    
    for(int i = 0; i < self.recipe.grains.count; i++){
        Grain * grain = [self.recipe.grains objectAtIndex:i];
        NSInteger index = [products indexOfObject:grain];
        if (index >= 0){
            [products replaceObjectAtIndex:index withObject:grain];
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
    // Return the number of rows in the section.
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GrainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[GrainTableViewCell viewName] forIndexPath:indexPath];
    
    // Configure the cell...
    
    Grain * grain = [_products objectAtIndex:indexPath.row];
    
    cell.Title_label.text = grain.name;
    if (grain.amount > 0){
        cell.textField.text = [NSString stringWithFormat:@"%.02f kg",   grain.amount];
        cell.addButton.hidden = true;
        cell.textField.hidden = false;
        
        double percent = (grain.amount * 100) / self.totalQTY.text.doubleValue;
        cell.percent_label.text = [NSString stringWithFormat:@"%0.0f%%",percent];
        
        cell.percent_label.hidden = false;
        
        
    } else {
        cell.addButton.hidden = false;
        cell.textField.hidden = true;
        cell.percent_label.hidden = true;
    }
    
    
    cell.grain = grain;
    
    cell.textField.delegate = self;
    
    
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
    [vc setProducts:[Grain grainsInDataBase:[DBModel database]]];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)grainsChanged:(NSNotification *)note {
    double count = 0;
    
    NSMutableArray * grains = [[NSMutableArray alloc] init];
    for(int i = 0; i < self.products.count; i++){
        Grain * grain = [self.products objectAtIndex:i];
        count+= grain.amount;
        if (grain.amount > 0){
            [grains addObject:grain];
        }
    }
    
    self.recipe.grains = grains;
    
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

//
//  RecipeViewController.m
//  Homebrewer
//
//  Created by Juanx Ane on 9/10/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import "RecipeViewController.h"
#import "GrainTableViewController.h"
#import "HopTableViewController.h"
#import "ProductTableViewController.h"
#import "Grain.h"
#import "Recipe.h"
#import "Hop.h"
#import "HeaderTableViewCell.h"

@interface RecipeViewController ()


@property (nonatomic) NSArray* sectionsKeys;
@property (nonatomic) NSMutableArray* booleanRows;
@property (nonatomic) Recipe* recipe;


@end

@implementation RecipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _sectionsKeys = @[@"Granos",@"Lúpulos",@"Leveduras"];
    NSArray * procesos = @[@"Macerado",@"Hervido",@"Fermentación"];
    
    _booleanRows = [[NSMutableArray alloc] initWithArray:@[[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES],[NSNumber numberWithBool:YES]]];
    
    _recipe = [[Recipe alloc] init];
    
    
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.estimatedSectionHeaderHeight = 40;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    

}

- (void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (NSString *) viewName {
    return @"RecipeViewController";
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([_booleanRows[section] boolValue] == YES){
        if (section == 0){
            return self.recipe.grains.count;
        } else if (section ==1){
            return self.recipe.hops.count;
        } else if (section ==2){
            return 1;
        }
    }
    return 0;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_sectionsKeys count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recipeItemsCell" forIndexPath:indexPath];
    
    id<ProductTableProtocol> product;
    
    
    if (indexPath.section == 0){
        product = [self.recipe.grains objectAtIndex:indexPath.row];
    } else if (indexPath.section ==1){
        product = [self.recipe.hops objectAtIndex:indexPath.row];
    } else if (indexPath.section ==2){
       
    }

    cell.textLabel.text = [product getTitle];
    cell.detailTextLabel.text = [product getDetail];

    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    HeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    
    if ( cell != nil) {
        cell.textLabel.text = [_sectionsKeys objectAtIndex:section];
        UIButton* btnAdd = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [btnAdd addTarget:self action:@selector(addTouch:) forControlEvents:UIControlEventTouchUpInside];
        [btnAdd setTintColor:[UIColor whiteColor]];
        [btnAdd setTag:section];
        [cell setTag:section];
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionTouch:)];
        
        [cell addGestureRecognizer:tapGesture];
        cell.accessoryView = btnAdd;
    }
    
    return cell;
}
    
-(void) addTouch: (UIButton*) item {
    
    NSInteger section = item.tag;
    
    if ([[_sectionsKeys objectAtIndex:section] isEqual:@"Granos"]){
        GrainTableViewController * vc = (GrainTableViewController*)[self.storyboard instantiateViewControllerWithIdentifier:[GrainTableViewController viewName]];
        vc.recipe = self.recipe;
        
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([[_sectionsKeys objectAtIndex:section] isEqual:@"Lúpulos"]) {
        HopTableViewController * vc = (HopTableViewController*)[self.storyboard instantiateViewControllerWithIdentifier:[HopTableViewController viewName]];
        vc.recipe = self.recipe;
        
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([[_sectionsKeys objectAtIndex:   section] isEqual:@"Levaduras"]) {
        
    }
    
    
}


-(void) sectionTouch: (UIGestureRecognizer*) item {
    
    NSInteger section = item.view.tag;
    
    BOOL result = ![_booleanRows[section] boolValue];
    
    [_booleanRows setObject:[NSNumber numberWithBool:result] atIndexedSubscript:section];
    
    
    
    [CATransaction begin];
    
    [CATransaction setCompletionBlock:^{
        [self.tableView reloadData];
    }];
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [CATransaction commit];
    
    
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    NSString * title = [((NSArray*)[_data objectForKey:((NSString*)[_sectionsKeys objectAtIndex:indexPath.section])]) objectAtIndex:indexPath.row];
//    
//    if ([title isEqualToString:@"Granos"]){
//        GrainTableViewController * vc = (GrainTableViewController*)[self.storyboard instantiateViewControllerWithIdentifier:[GrainTableViewController viewName]];
//        [vc setProducts:[Grain grainsForRecipe:self.recipe.code InDataBase:[DBModel database]]];
//        
//        [self.navigationController pushViewController:vc animated:YES];
//    } else if ([title isEqualToString:@"Lúpulos"]){
//        HopTableViewController * vc = [self.storyboard instantiateViewControllerWithIdentifier:[HopTableViewController viewName]];
//        [vc setProducts:[Hop hopsForRecipe:self.recipe.code InDataBase:[DBModel database]]];
//        
//        [self.navigationController pushViewController:vc animated:YES];
//    } else if ([title isEqualToString:@"Leveduras"]){
//      
//    } else if ([title isEqualToString:@"Macerado"]){
//        
//    } else if ([title isEqualToString:@"Hervido"]){
//        
//    } else if ([title isEqualToString:@"Fermentación"]){
//        
//    }
//    
//    
    
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

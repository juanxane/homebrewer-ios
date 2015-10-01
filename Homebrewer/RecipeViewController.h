//
//  RecipeViewController.h
//  Homebrewer
//
//  Created by Juanx Ane on 9/10/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

+(NSString *) viewName;

@end

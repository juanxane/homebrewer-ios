//
//  HopTableViewController.h
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface HopTableViewController : UITableViewController  <UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UILabel *totalQTY;
@property (strong, nonatomic)  Recipe *recipe;

+(NSString *) viewName;
-(void) setRecipe:(Recipe*)recipe;
@end

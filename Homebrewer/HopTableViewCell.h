//
//  HopTableViewCell.h
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hop.h"

@interface HopTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *title_label;
@property (strong, nonatomic) IBOutlet UILabel *IBUS_label;
@property (strong, nonatomic) IBOutlet UILabel *AA_label;

@property (strong, nonatomic) IBOutlet UIButton* addButton;
@property (strong, nonatomic) IBOutlet UITextField* textField;

@property (strong, nonatomic) Hop* hop;
+(NSString *) viewName;

@end

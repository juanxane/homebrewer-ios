//
//  GrainTableViewCell.h
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Grain.h"

@interface GrainTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel *Title_label;
@property (strong, nonatomic) IBOutlet UILabel *percent_label;
@property (strong, nonatomic) IBOutlet UILabel *amount_label;

@property (strong, nonatomic) IBOutlet UITextField* textField;
@property (strong, nonatomic) IBOutlet UIButton* addButton;


@property (strong, nonatomic) Grain* grain;


+(NSString *) viewName;

@end

//
//  HopTableViewCell.m
//  Homebrewer
//
//  Created by Juanx Ane on 9/11/15.
//  Copyright (c) 2015 JuanxAne. All rights reserved.
//

#import "HopTableViewCell.h"

@implementation HopTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *) viewName {
    return @"HopTableViewCell";
}

- (IBAction)touchAdd:(UIButton *)sender {
    self.addButton.hidden = true;
    self.textField.hidden = false;
    self.textField.enabled = true;
    self.textField.delegate = self;
    
    [self.textField becomeFirstResponder];
    
    
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *newStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSString *expression = @"^([0-9]*)(\\.([0-9]+)?)?$";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSUInteger noOfMatches = [regex numberOfMatchesInString:newStr
                                                    options:0
                                                      range:NSMakeRange(0, [newStr length])];
    
    
    if (noOfMatches==0){
        return NO;
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    self.hop.amount = textField.text.doubleValue;
    [self updateFields];
    
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    
    return YES;
    
}

-(void) updateFields {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"HopsChanged" object:nil];
    
}


@end

//
//  MyCell.h
//  SaveMyConfiguration
//
//  Created by Владимир on 30.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UISwitch *turnSwitch;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageBox;


@end

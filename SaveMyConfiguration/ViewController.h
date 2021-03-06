//
//  ViewController.h
//  SaveMyConfiguration
//
//  Created by Владимир on 29.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> 

@property (nonatomic, weak) IBOutlet UIImageView *showImage;
@property (weak, nonatomic) IBOutlet UILabel *showName;
@property (weak, nonatomic) IBOutlet UILabel *showDescription;
@property (nonatomic, retain) IBOutlet UITableView *addTable;
- (NSArray *)curentImages:(NSInteger)index;
- (NSMutableArray *) makeArrayOfImagesFromFiles: (NSArray *) array;
@end

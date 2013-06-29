//
//  ViewController.m
//  SaveMyConfiguration
//
//  Created by Владимир on 29.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import "ViewController.h"
#import "CreateObjectWithImage.h"

@interface ViewController ()
@property (nonatomic, strong) CreateObjectWithImage *object1;
@property (nonatomic) NSUserDefaults *userDefaults;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _object1 = [[CreateObjectWithImage alloc] init];
    _userDefaults = [NSUserDefaults standardUserDefaults];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createObject:(id)sender
{
    
//    _object1.nameOfObject = @"Straus";
//    _object1.descriptionOfObject = @"eto straus";
//    _object1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"straus.png" ofType:nil]];
    
    _object1.nameOfObject = @"Belka";
    _object1.descriptionOfObject = @"eto belka";
    _object1.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"belka.png" ofType:nil]];
    
}

- (void)saveObject:(id)sender
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_object1];
    NSLog(@"%@", data);
    
    [_userDefaults setObject: data forKey:@"object"];
    [_userDefaults synchronize];
    
}

- (void)showSavedObject:(id)sender
{
    CreateObjectWithImage *savedObject = [NSKeyedUnarchiver unarchiveObjectWithData:[_userDefaults objectForKey:@"object"]];
    _showName.text = [@"Name: " stringByAppendingString:savedObject.nameOfObject];
    _showDescription.text = [@"Description: " stringByAppendingString: savedObject.descriptionOfObject];
    _showImage.image = savedObject.image;
    
    
    
    
}





@end

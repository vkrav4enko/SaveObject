//
//  ViewController.m
//  SaveMyConfiguration
//
//  Created by Владимир on 29.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import "ViewController.h"
#import "ImageWithOptions.h"


@interface ViewController ()
@property (nonatomic, strong) ImageWithOptions *object1;
@property (nonatomic, strong) ImageWithOptions *object2;
@property (nonatomic, strong) ImageWithOptions *object3;
@property (nonatomic, strong) ImageWithOptions *object4;
@property (nonatomic, strong) ImageWithOptions *object5;
@property (nonatomic, strong) ImageWithOptions *object6;
@property (nonatomic, strong) ImageWithOptions *object7;
@property (nonatomic, strong) ImageWithOptions *object8;
@property (nonatomic, strong) ImageWithOptions *object9;
@property (nonatomic, strong) ImageWithOptions *object10;
@property (nonatomic, strong) NSDictionary *dictionaryWithObjects;

@property (nonatomic) NSUserDefaults *userDefaults;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	    
    _userDefaults = [NSUserDefaults standardUserDefaults];
    _object1 = [ImageWithOptions alloc];
    _object2 = [ImageWithOptions alloc];
    _object3 = [ImageWithOptions alloc];
    _object4 = [ImageWithOptions alloc];
    _object5 = [ImageWithOptions alloc];
    _object6 = [ImageWithOptions alloc];
    _object7 = [ImageWithOptions alloc];
    _object8 = [ImageWithOptions alloc];
    _object9 = [ImageWithOptions alloc];
    _object10 = [ImageWithOptions alloc];
           
    _dictionaryWithObjects = [NSDictionary dictionaryWithObjectsAndKeys:_object1, @"belka", _object2, @"straus", _object3, @"kot", _object4, @"osel", _object5, @"panda", _object6, @"pes", _object7, @"shimpanze", _object8, @"slon", _object9, @"sova", _object10, @"tulen", nil];
    NSArray *keys = [_dictionaryWithObjects allKeys];
    for(NSString *key in keys)
    {
        [[_dictionaryWithObjects objectForKey:key]  initWithName:key andDescription:[@"eto " stringByAppendingString:key] andImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[key stringByAppendingString:@".png"] ofType:nil]]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)saveObject:(id)sender
{
    int i = 0;
    
    NSArray *keys = [_dictionaryWithObjects allKeys];
    for (NSString *key in keys)
    {
        i++;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[_dictionaryWithObjects objectForKey:key]];
        [_userDefaults setObject:data forKey:[NSString stringWithFormat:@"object%i",i]];
    }
    
    [_userDefaults synchronize];
    
}

- (void)showSavedObject:(id)sender
{
    ImageWithOptions *savedObject = [NSKeyedUnarchiver unarchiveObjectWithData:[_userDefaults objectForKey:@"object5"]];
    _showName.text = [@"Name: " stringByAppendingString:savedObject.nameOfObject];
    _showDescription.text = [@"Description: " stringByAppendingString: savedObject.descriptionOfObject];
    _showImage.image = savedObject.image;
    
    for (int i = 1; i<11; i++)
    {
        NSLog (@"%@", [NSKeyedUnarchiver unarchiveObjectWithData:[_userDefaults objectForKey:[@"object" stringByAppendingString: [NSString stringWithFormat:@"%i", i]] ]]);
    
    }
    
    
}





@end

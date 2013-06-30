//
//  ViewController.m
//  SaveMyConfiguration
//
//  Created by Владимир on 29.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import "ViewController.h"
#import "ImageWithOptions.h"
#define object(n) _object##n

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
@property (nonatomic, strong) NSDictionary *objects;

@property (nonatomic) NSUserDefaults *userDefaults;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	    
    _userDefaults = [NSUserDefaults standardUserDefaults];
   
       
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createObject:(id)sender
{
   
    
    object(1) = [[ImageWithOptions alloc] initWithName:@"belka" andDescription:@"eto belka" andImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"belka.png" ofType:nil]]];
    object(2)= [[ImageWithOptions alloc] initWithName:@"straus" andDescription:@"eto straus" andImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"straus.png" ofType:nil]]];
    object(3)= [[ImageWithOptions alloc] initWithName:@"kot" andDescription:@"eto kot" andImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"kot.png" ofType:nil]]];
    object(4)= [[ImageWithOptions alloc] initWithName:@"osel" andDescription:@"eto osel" andImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"osel.png" ofType:nil]]];
    object(5)= [[ImageWithOptions alloc] initWithName:@"panda" andDescription:@"eto panda" andImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"panda.png" ofType:nil]]];
    object(6)= [[ImageWithOptions alloc] initWithName:@"pes" andDescription:@"eto pes" andImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pes.png" ofType:nil]]];
    object(7)= [[ImageWithOptions alloc] initWithName:@"shimpanze" andDescription:@"eto shimpanze" andImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shimpanze.png" ofType:nil]]];
    object(8)= [[ImageWithOptions alloc] initWithName:@"slon" andDescription:@"eto slon" andImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"slon.png" ofType:nil]]];
    object(9)= [[ImageWithOptions alloc] initWithName:@"sova" andDescription:@"eto sova" andImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sova.png" ofType:nil]]];
    object(10)= [[ImageWithOptions alloc] initWithName:@"tulen" andDescription:@"eto tulen" andImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tulen.png" ofType:nil]]];

    
}

- (void)saveObject:(id)sender
{
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_object1];
    NSLog(@"%@", data);
    [_userDefaults setObject: data forKey:@"object1"];
    data = [NSKeyedArchiver archivedDataWithRootObject:_object2];
    [_userDefaults setObject: data forKey:@"object2"];
    data = [NSKeyedArchiver archivedDataWithRootObject:_object3];
    [_userDefaults setObject: data forKey:@"object3"];
    data = [NSKeyedArchiver archivedDataWithRootObject:_object4];
    [_userDefaults setObject: data forKey:@"object4"];
    data = [NSKeyedArchiver archivedDataWithRootObject:_object5];
    [_userDefaults setObject: data forKey:@"object5"];
    data = [NSKeyedArchiver archivedDataWithRootObject:_object6];
    [_userDefaults setObject: data forKey:@"object6"];
    data = [NSKeyedArchiver archivedDataWithRootObject:_object7];
    [_userDefaults setObject: data forKey:@"object7"];
    data = [NSKeyedArchiver archivedDataWithRootObject:_object8];
    [_userDefaults setObject: data forKey:@"object8"];
    data = [NSKeyedArchiver archivedDataWithRootObject:_object9];
    [_userDefaults setObject: data forKey:@"object9"];
    data = [NSKeyedArchiver archivedDataWithRootObject:_object10];
    [_userDefaults setObject: data forKey:@"object10"];
    
    
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

//
//  ViewController.m
//  SaveMyConfiguration
//
//  Created by Владимир on 29.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import "ViewController.h"
#import "MyImage.h"
#import "MyCell.h"

/*
    Такие ключи лучше выносить в константы, поскольку использовать их можно будет из разных точек программы, 
    а опечатка в этом случае не сразу будет заметна
*/
NSString *const ImagesKey = @"images"; 

@interface ViewController ()

/*
    Сразу отталкивайся от того, что изображений несколько(это значит что N), значит что есть какой-то список
*/
@property (nonatomic, strong) NSMutableDictionary *dictionaryOfImages;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /* 
        NSUserDefaults необязательно выводить ее в переменную, совсем не обязательно
        Всегда можно работать с ней так:
     
        NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
        
        или
     
        [[NSUserDefaults standardUserDefaults] setFloat:0.25 forKey:@"floatKey"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    */
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *dataOfKey = [defaults objectForKey:ImagesKey];
    
    
    if (YES) {
               
        NSBundle *mainBundle = [NSBundle mainBundle]; 

        NSArray *pngFileList = [mainBundle pathsForResourcesOfType:@".png" inDirectory:@"Images"];
                
        NSMutableArray* arrayOfPNG = [self makeArrayOfImagesFromFiles:pngFileList];
        
                
        NSArray *jpegFileList = [mainBundle pathsForResourcesOfType:@".jpg" inDirectory:@"Images"];
        
        NSMutableArray* arrayOfJPEG = [self makeArrayOfImagesFromFiles:jpegFileList];
        
                
        _dictionaryOfImages = [NSMutableDictionary dictionaryWithObjectsAndKeys:arrayOfPNG, @"png", arrayOfJPEG, @"jpg", nil];
        
        
        NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:_dictionaryOfImages];
        
        [defaults setObject:arrayData forKey:ImagesKey];
        [defaults synchronize];
    } else {
        // Если уже есть массив картинок
        NSMutableDictionary *oldDictionary = [NSKeyedUnarchiver unarchiveObjectWithData:dataOfKey];
        _dictionaryOfImages = [[NSMutableDictionary alloc] initWithDictionary:oldDictionary];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dictionaryOfImages.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *curentImages = [self curentImages:section];
    return [curentImages count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[_dictionaryOfImages allKeys] objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell2";
    
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *curentImages = [self curentImages:indexPath.section];
    MyImage *currentImage = [curentImages objectAtIndex:indexPath.row];
    
    
  
    cell.title.text = currentImage.name;
    cell.subtitle.text = currentImage.detail;
    cell.imageBox.image = currentImage.image;
    cell.turnSwitch.on = currentImage.someSwitch;
    
    
    
    
    return cell;
}

- (NSArray *)curentImages:(NSInteger)index {
    NSArray *keys = [_dictionaryOfImages allKeys];
    NSString *curentKey = [keys objectAtIndex:index];
    NSArray *curentImages = [_dictionaryOfImages objectForKey:curentKey];
    return curentImages;
}

- (NSMutableArray *) makeArrayOfImagesFromFiles: (NSArray *) array
{
    NSMutableArray* arrayOfImages = [[NSMutableArray alloc] initWithCapacity:array.count];
    
    for (NSString *filePath in array) {
        
        NSString *fileName = [[filePath lastPathComponent] stringByDeletingPathExtension];
        
        UIImage *imageForPath = [[UIImage alloc] initWithContentsOfFile:filePath];
        
        MyImage *imageObject = [[MyImage alloc] initWithName:fileName
                                                      detail:[filePath lastPathComponent]
                                                  someSwitch:YES
                                                    andImage:imageForPath];
        [arrayOfImages addObject:imageObject];
    }
    return arrayOfImages;

}

@end

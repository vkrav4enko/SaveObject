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
@property (nonatomic, strong) NSMutableArray *sectionIsOpen;


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
    
    
    if (!dataOfKey) {
               
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
    
    _sectionIsOpen = [NSMutableArray array];
    for (int i = 0; i<= _dictionaryOfImages.count; i++)
    {
       [_sectionIsOpen setObject:[NSNumber numberWithBool:NO] atIndexedSubscript:i];
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
   
    if([[_sectionIsOpen objectAtIndex:section] boolValue])
    {
        NSArray *curentImages = [self curentImages:section];
        return [curentImages count];
    }
    else
        return 0;
            
    
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
    
    [cell.turnSwitch addTarget:self action:@selector(turnSwitchChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *sectionTitle = [[_dictionaryOfImages allKeys] objectAtIndex:section];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, 320.0f, 50.0f);
    button.tag = section;
    button.backgroundColor = [UIColor grayColor];
    [[button layer] setBorderWidth:2.0f];
    [[button layer] setBorderColor: [UIColor blackColor].CGColor];
    [button setTitle:sectionTitle forState:UIControlStateNormal];
    [button addTarget:self action:@selector(selectSection:)
     forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void) selectSection: (UIButton *) sender
{
    //Получение текущей секции
    NSArray *currentSection = [self curentImages: sender.tag];
    
    
    
    //Создание массива индексов
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (int i=0; i<currentSection.count; i++) {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:sender.tag]];
    }
    
    //Получение состояния секции
    BOOL isOpen = [[_sectionIsOpen objectAtIndex:sender.tag] boolValue];
    [_sectionIsOpen setObject:[NSNumber numberWithBool:!isOpen] atIndexedSubscript:sender.tag];
    
    
    //Анимированное добавление или удаление ячеек секции
    if (isOpen) {
        [self.addTable deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    } else {
        [self.addTable insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
    }

}

- (void)turnSwitchChanged:(UISwitch *)cellSwitch {

    NSIndexPath *indexPath = [_addTable indexPathForCell:(UITableViewCell *)cellSwitch.superview.superview];
    NSString *key = [[_dictionaryOfImages allKeys] objectAtIndex:indexPath.section];
    NSArray *imagesInSection = _dictionaryOfImages[key];
    MyImage *imageObject = [imagesInSection objectAtIndex:indexPath.row];
    imageObject.someSwitch = cellSwitch.on;
  
    [[_dictionaryOfImages objectForKey:[[_dictionaryOfImages allKeys] objectAtIndex:indexPath.section]] setObject:imageObject atIndex:indexPath.row];
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:_dictionaryOfImages];
    
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:arrayData forKey:ImagesKey];
    [defaults synchronize];

}

- (NSArray *)curentImages:(NSInteger)index {
    NSArray *keys = [[NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:ImagesKey]] allKeys];
    NSString *curentKey = [keys objectAtIndex:index];
    NSArray *curentImages = [[NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:ImagesKey]] objectForKey:curentKey];
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

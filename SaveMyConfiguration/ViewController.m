//
//  ViewController.m
//  SaveMyConfiguration
//
//  Created by Владимир on 29.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import "ViewController.h"
#import "MyImage.h"

/*
    Такие ключи лучше выносить в константы, поскольку использовать их можно будет из разных точек программы, 
    а опечатка в этом случае не сразу будет заметна
*/
NSString *const ImagesKey = @"images"; 

@interface ViewController ()

/*
    Сразу отталкивайся от того, что изображений несколько(это значит что N), значит что есть какой-то список
*/
@property (nonatomic, strong) NSMutableArray *arrayOfImages;

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
    
    // проверили есть ли какое-то значение для нашего ключа(может мы уже однажды выполняли это действие)
    if (!dataOfKey) {
        // Ни разу не выполняли
        
        NSBundle *mainBundle = [NSBundle mainBundle]; 

        // Получаем имена файлов в папке
        NSArray *fileList = [mainBundle pathsForResourcesOfType:@".png" inDirectory:@"Images"];
        
        _arrayOfImages = [[NSMutableArray alloc] initWithCapacity:fileList.count];
        
        for (NSString *filePath in fileList) {
            // Берем последний компонент в адресе (это значит последний после символа "/") и удаляем расширение ".png"
            NSString *fileName = [[filePath lastPathComponent] stringByDeletingPathExtension];
            
            // Получаем картинку
            UIImage *imageForPath = [[UIImage alloc] initWithContentsOfFile:filePath];
            
            MyImage *imageObject = [[MyImage alloc] initWithName:fileName
                                                          detail:filePath
                                                        andImage:imageForPath];
            [_arrayOfImages addObject:imageObject];
        }
        
        // Теперь у нас есть массив из наших объектов
        // И можно сохранить этот результат
        
        NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:_arrayOfImages];
        
        [defaults setObject:arrayData forKey:ImagesKey];
        [defaults synchronize];
    } else {
        // Если уже есть массив картинок
        NSArray *oldArray = [NSKeyedUnarchiver unarchiveObjectWithData:dataOfKey];
        _arrayOfImages = [[NSMutableArray alloc] initWithArray:oldArray];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

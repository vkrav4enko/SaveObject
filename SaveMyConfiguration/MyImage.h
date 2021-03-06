//
//  MyImage.h
//  SaveMyConfiguration
//
//  Created by Владимир on 29.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyImage : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic) BOOL someSwitch;

- (MyImage *)initWithName:(NSString *)name detail:(NSString *)detail someSwitch: (BOOL) sw andImage:(UIImage *)image;


@end

//
//  CreateObjectWithImage.h
//  SaveMyConfiguration
//
//  Created by Владимир on 29.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreateObjectWithImage : NSObject <NSCoding>
@property (nonatomic) NSString *nameOfObject;
@property (nonatomic) NSString *descriptionOfObject;
@property (nonatomic) UIImage *image;


@end

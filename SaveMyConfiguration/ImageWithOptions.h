//
//  CreateObjectWithImage.h
//  SaveMyConfiguration
//
//  Created by Владимир on 29.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageWithOptions : NSObject <NSCoding>
@property (nonatomic, copy) NSString *nameOfObject;
@property (nonatomic, copy) NSString *descriptionOfObject;
@property (nonatomic, strong) UIImage *image;

- (ImageWithOptions *) initWithName: (NSString*) name andDescription: (NSString *) description andImage: (UIImage *) image;


@end

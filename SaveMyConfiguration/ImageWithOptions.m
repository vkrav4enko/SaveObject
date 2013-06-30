//
//  CreateObjectWithImage.m
//  SaveMyConfiguration
//
//  Created by Владимир on 29.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import "ImageWithOptions.h"

@implementation ImageWithOptions


- (ImageWithOptions *)initWithName:(NSString *)name andDescription:(NSString *)description andImage:(UIImage *)image
{
    self = [super init];
    if (self)
    {
        _nameOfObject = name;
        _descriptionOfObject = description;
        _image = image;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Name :%@.  Description: %@.  ImageSize: %f x %f", _nameOfObject, _descriptionOfObject, _image.size.width, _image.size.height];
    
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_nameOfObject forKey:@"name"];
    [encoder encodeObject:_descriptionOfObject forKey:@"description"];
    NSData *imageData = UIImagePNGRepresentation(_image);
    [encoder encodeObject:imageData forKey:@"image"];
    

    
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self)
    {
        _nameOfObject = [decoder decodeObjectForKey:@"name"];
        _descriptionOfObject = [decoder decodeObjectForKey:@"description"];
        _image = [[UIImage alloc] initWithData:[decoder decodeObjectForKey:@"image"]];
                
    }
    return self;
}



@end

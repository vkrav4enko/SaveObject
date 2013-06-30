//
//  MyImage.m
//  SaveMyConfiguration
//
//  Created by Владимир on 29.06.13.
//  Copyright (c) 2013 Владимир. All rights reserved.
//

#import "MyImage.h"

@implementation MyImage


- (MyImage *)initWithName:(NSString *)name detail:(NSString *)detail andImage:(UIImage *)image
{
    self = [super init];
    if (self)
    {
        _name = name;
        _detail = detail;
        _image = image;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Name :%@. \\nDescription: %@.  \\nImageSize: %f x %f", self.name, self.detail, self.image.size.width, self.image.size.height];
    
}

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_detail forKey:@"detail"];
    NSData *imageData = UIImagePNGRepresentation(_image);
    [encoder encodeObject:imageData forKey:@"image"];

}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self)
    {
        _name = [decoder decodeObjectForKey:@"name"];
        _detail = [decoder decodeObjectForKey:@"detail"];
        _image = [[UIImage alloc] initWithData:[decoder decodeObjectForKey:@"image"]];
                
    }
    return self;
}



@end

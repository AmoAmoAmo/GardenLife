//
//  UIImage+Size.h
//  Weekend
//
//  Created by Jane on 16/4/15.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Size)

/** 修改image的大小 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

@end

//
//  ProductViewController.h
//  GardenLife
//
//  Created by Jane on 16/5/3.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ProductViewControllerDelegate <NSObject>

-(void)changeHeadViewOffsetWhenCollectionViewScrolledWithOffset:(CGFloat)offsetY;

@end


@interface ProductViewController : UIViewController

@property (nonatomic,assign) id<ProductViewControllerDelegate> delegate;
@property (nonatomic,strong) UICollectionView *collection;

@end

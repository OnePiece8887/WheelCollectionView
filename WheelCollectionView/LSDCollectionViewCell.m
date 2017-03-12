//
//  LSDCollectionViewCell.m
//  WheelCollectionView
//
//  Created by ls on 2017/3/11.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDCollectionViewCell.h"
#import "LSDWheelCollectionLayoutAttributes.h"
@implementation LSDCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return  self;
}

-(void)setupUI
{

    UIImageView *imageview= [[UIImageView alloc]init];
    
    [self.contentView addSubview:imageview];
    self.imageView = imageview;
    
}

-(void)layoutSubviews
{

    [super layoutSubviews];
    
    self.imageView.frame = self.contentView.frame;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    [super applyLayoutAttributes:layoutAttributes];
    
    LSDWheelCollectionLayoutAttributes *attributes = (LSDWheelCollectionLayoutAttributes *)layoutAttributes;
    
    self.layer.anchorPoint = attributes.anchorPoint;
    
    CGFloat centerY = (attributes.anchorPoint.y - 0.5) *CGRectGetHeight(self.bounds);
    
    CGPoint center = self.center;
    
    center.y += centerY;
    
    self.center = center;
}


@end

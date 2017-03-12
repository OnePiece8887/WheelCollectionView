//
//  LSDWheelCollectionLayoutAttributes.m
//  WheelCollectionView
//
//  Created by ls on 2017/3/11.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDWheelCollectionLayoutAttributes.h"

@interface LSDWheelCollectionLayoutAttributes ()<NSCopying>

@end

@implementation LSDWheelCollectionLayoutAttributes
-(void)setAngle:(CGFloat)angle
{

    _angle = angle;
    
    self.zIndex = (int)(angle * 1000000);
    self.transform = CGAffineTransformMakeRotation(angle);
}

-(id)copyWithZone:(NSZone *)zone
{

    LSDWheelCollectionLayoutAttributes *attributes =  [super copyWithZone:zone];
    attributes.anchorPoint = self.anchorPoint;
    attributes.angle = self.angle;
    return attributes;
}

@end

//
//  LSDCollectionViewLayout.h
//  WheelCollectionView
//
//  Created by ls on 2017/3/11.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSDWheelCollectionView.h"
@interface LSDCollectionViewLayout : UICollectionViewLayout

///item尺寸
@property(assign,nonatomic)CGSize itemSize;

///圆弧半径
@property(assign,nonatomic)CGFloat radius;

///每个item之间的角度
@property(assign,nonatomic)CGFloat anglePerItem;

///最后的角度
@property(assign,nonatomic)CGFloat angleAtExtreme;

///当前的角度
@property(assign,nonatomic)CGFloat angle;

@end

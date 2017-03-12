//
//  LSDCollectionViewLayout.m
//  WheelCollectionView
//
//  Created by ls on 2017/3/11.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDCollectionViewLayout.h"
#import "LSDWheelCollectionLayoutAttributes.h"
@interface LSDCollectionViewLayout ()

/**
 *  存放所有显示item属性的数组
 */
@property(nonatomic,strong)NSMutableArray *attributesArray;

@end

@implementation LSDCollectionViewLayout

-(void)prepareLayout
{
//    NSLog(@"prepare");
    [super prepareLayout];
    //注意 这两个清空操作很重要 初始化为空的时候可以进行懒加载加载数据
    self.attributesArray = nil;

    ///偏移量加collectionview宽的一半，让item在collectionview的中心位置
    CGFloat centerX = self.collectionView.contentOffset.x  + (CGRectGetWidth(self.collectionView.bounds)/2.0);
    ///锚点Y值
    CGFloat anchorPointY = (self.radius + self.itemSize.height * 0.5)/self.itemSize.height;
    
    ///可视角度
    CGFloat visualAngle = atan2(CGRectGetWidth(self.collectionView.bounds)/2.0, self.radius -(CGRectGetHeight(self.collectionView.bounds)/2.0) - self.itemSize.height/2.0);
    
    NSInteger startIndex = 0;
    NSInteger endIndex = [self.collectionView numberOfItemsInSection:0] - 1;
    
//    round 如果参数是小数，则求本身的四舍五入.
//    ceil 如果参数是小数，则求最小的整数但不小于本身.
//    floor 如果参数是小数，则求最大的整数但不大于本身.
    
    if (self.angle < -visualAngle) {
        startIndex = (int)(floor(-visualAngle -self.angle)/self.anglePerItem);
    }
    
    endIndex = MIN(endIndex, (int)(ceil(visualAngle - self.angle)/self.anglePerItem));

//    NSLog(@"visualAngle = %f",visualAngle);
//    
//    NSLog(@"self.angle = %f",self.angle);
//    
//    NSLog(@"-visualAngle - self.angle = %f",-visualAngle -self.angle);
//    
//    NSLog(@"visualAngle - self.angle = %f",visualAngle - self.angle);
//    
//    NSLog(@"startIndex = %zd,endIndex = %zd",startIndex,endIndex);
    
    
    if (endIndex < startIndex) {
        endIndex = 0;
        startIndex = 0;
    }
    
    ///只获取可视界面item的属性
    for (NSInteger i = startIndex; i<= endIndex; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        //获取每一个item
        LSDWheelCollectionLayoutAttributes *attributes =   (LSDWheelCollectionLayoutAttributes *)[LSDWheelCollectionLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.size = self.itemSize;
        ///每个item都在collectionview的正中间
        attributes.center = CGPointMake(centerX, CGRectGetMidY(self.collectionView.bounds));
        ///每个item 都transform旋转angle
        attributes.angle = self.angle + self.anglePerItem * (CGFloat)i;
        ///锚点
        CGPoint anchorPoint = CGPointMake(0.5, anchorPointY);
        ///设置锚点
        attributes.anchorPoint = anchorPoint;
        
        //将每一个item属性添加到展示item的数组中
        [self.attributesArray addObject:attributes];
    }

}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    
//     NSLog(@"%@",[NSValue valueWithCGRect:rect]);
   
    //返回改变后的item
    return self.attributesArray;

}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return self.attributesArray[indexPath.item];
}


-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{


    
    CGPoint finalContentOffset = proposedContentOffset;
    ///最大的偏移量X
    CGFloat maxOffsetX = [self collectionViewContentSize].width - CGRectGetWidth(self.collectionView.bounds);

    CGFloat proposedAngle = -self.angleAtExtreme* (proposedContentOffset.x/maxOffsetX);
   
    CGFloat ratio = proposedAngle/self.anglePerItem;
    
    NSLog(@"velocity.x = %f",velocity.x);
    NSLog(@"ratio = %f",ratio);
    
    CGFloat multiplier = 0.0;
    if (velocity.x > 0) {
        multiplier = ceil(ratio);
    } else if (velocity.x < 0) {
        multiplier = floor(ratio);
    } else {
        multiplier = round(ratio);
    }
    
    finalContentOffset.x = multiplier * self.anglePerItem *maxOffsetX /(-self.angleAtExtreme);
    
    return finalContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{

    return YES;
}


-(CGSize)collectionViewContentSize{
 
    return CGSizeMake(self.itemSize.width * [self.collectionView numberOfItemsInSection:0],200);
}

///返回LSDWheelCollectionLayoutAttributes
+(Class)layoutAttributesClass
{

    return [LSDWheelCollectionLayoutAttributes class];
}

//初始化属性数组
-(NSMutableArray *)attributesArray{
    if (_attributesArray == nil) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

-(void)setRadius:(CGFloat)radius
{

    _radius = radius;
    
    [self invalidateLayout];
}

-(CGFloat)anglePerItem
{
    return atan(self.itemSize.width / self.radius);
}

-(CGFloat)angleAtExtreme
{
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    return count > 0? -(CGFloat)((count - 1)*self.anglePerItem):0;
}

-(CGFloat)angle
{

    return self.angleAtExtreme * self.collectionView.contentOffset.x/([self collectionViewContentSize].width - CGRectGetWidth(self.collectionView.bounds));
}

@end

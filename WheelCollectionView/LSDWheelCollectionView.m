
//
//  LSDWheelCollectionView.m
//  WheelCollectionView
//
//  Created by ls on 2017/3/11.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "LSDWheelCollectionView.h"
#import "LSDCollectionViewCell.h"

@interface LSDWheelCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end

@implementation LSDWheelCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{

    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self configure];
    }
    
    return self;
}

-(void)configure
{
    self.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
    self.delegate = self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return self.dataArray.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    LSDCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[LSDCollectionViewCell alloc]initWithFrame:CGRectZero];
    }
    cell.imageView.image = [self.dataArray objectAtIndex:indexPath.item];
    return  cell;
}


@end

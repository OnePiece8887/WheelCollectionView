//
//  ViewController.m
//  WheelCollectionView
//
//  Created by ls on 2017/3/11.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "ViewController.h"
#import "LSDWheelCollectionView.h"
#import "LSDCollectionViewLayout.h"
#import "LSDCollectionViewCell.h"
@interface ViewController ()

///
@property(weak,nonatomic)LSDWheelCollectionView *collectionview;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor blackColor];
    LSDCollectionViewLayout *layout = [[LSDCollectionViewLayout alloc]init];
  
    layout.itemSize = CGSizeMake(133, 173);
    layout.radius = 500;
    
    LSDWheelCollectionView *wheelView = [[LSDWheelCollectionView alloc]initWithFrame:CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200) collectionViewLayout:layout];
    
    self.collectionview = wheelView;
    
    
    [wheelView registerClass:[LSDCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:wheelView];
    
    NSMutableArray *muarray = [NSMutableArray array];
    
    for (int j = 0; j < 3 ; j ++) {
        for (int i = 0; i < 7 ; i ++) {
            UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%zd.jpg",i+1] ofType:nil]];
            [muarray addObject:image];
        }
    }
 
    self.collectionview.dataArray = muarray;

    [self.collectionview reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

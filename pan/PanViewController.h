//
//  PanViewController.h
//  pan
//
//  Created by lina on 2021/4/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class PanCollectionView;
@interface PanViewController : UIViewController
@property (nonatomic, strong) UIScrollView *scrolView;

@property (nonatomic, strong) NSMutableArray <PanCollectionView *> *collectionViews;

@property (nonatomic, assign) NSInteger index;

@end

NS_ASSUME_NONNULL_END

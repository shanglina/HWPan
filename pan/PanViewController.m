//
//  PanViewController.m
//  pan
//
//  Created by lina on 2021/4/23.
//

#import "PanViewController.h"
#import <HWPanModal.h>
#import "pan-Swift.h"
@interface PanViewController ()<HWPanModalPresentable,UIScrollViewDelegate>


@end

@implementation PanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViews];
}

- (void)setupViews{
    
    self.index = 0;
    
    CGFloat width = self.view.bounds.size.width;
    
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollview.backgroundColor = [UIColor whiteColor];
    scrollview.contentSize = CGSizeMake(width * 2, 0);
    [self.view addSubview:scrollview];
    self.scrolView = scrollview;
    self.scrolView.delegate = self;
    self.collectionViews = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        PanCollectionView *collection = [[PanCollectionView alloc] initWithFrame:CGRectMake(width * i, 0, width, scrollview.bounds.size.height)];
        [scrollview addSubview:collection];
        [self.collectionViews addObject:collection];
    }
}



- (PanModalHeight)longFormHeight{
    return PanModalHeightMake(PanModalHeightTypeMax, 100);
}

- (UIScrollView *)panScrollable{
    return self.collectionViews[self.index].collectionView;
}

- (BOOL)shouldRespondToPanModalGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    CGPoint _point = [panGestureRecognizer locationInView:self.scrolView];
    if (CGRectContainsPoint(self.scrolView.frame, _point)) {
        return NO;
    }

    
    CGPoint point = [panGestureRecognizer locationInView:self.collectionViews[self.index]];
    if (CGRectContainsPoint(self.collectionViews[self.index].frame, point)) {
        return NO;
    }
    return YES;
    
}

#pragma mark - UIScrollViewDelegate


@end


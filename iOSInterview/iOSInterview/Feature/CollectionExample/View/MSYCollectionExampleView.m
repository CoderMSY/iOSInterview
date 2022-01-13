//
//  MSYCollectionExampleView.m
//  iOSInterview
//
//  Created by Simon Miao on 2021/10/15.
//

#import "MSYCollectionExampleView.h"
#import <Masonry/Masonry.h>

#import "MSYCollectionItemCell.h"

@interface MSYCollectionExampleView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MSYCollectionExampleView

#pragma mark - lifecycle methods

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.collectionView];
        [self initConstraints];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        [self.collectionView addGestureRecognizer:longPress];
    }
    return self;
}

#pragma mark - public methods

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    
    [self.collectionView reloadData];
}

#pragma mark - private methods

- (void)initConstraints {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}

- (void)handlelongGesture:(UILongPressGestureRecognizer *)longPress {
    [self action:longPress];
}

- (void)action:(UILongPressGestureRecognizer *)longPress {
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
        {
            //手势开始
            //判断手势落点位置是否在row上
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
            if (indexPath == nil) {
                break;
            }
//            NSString *text = self.dataSource[indexPath.row];
//            if ([text isEqualToString:@"last"]) {
//                NSLog(@"Began取消移动");
//                break;
//            }
            
            MSYCollectionItemCell *cell = (MSYCollectionItemCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            [self bringSubviewToFront:cell];
            //iOS9 方法 移动cell
            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
//            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
//            NSString *text = self.dataSource[indexPath.row];
//            if ([text isEqualToString:@"last"]) {
//                NSLog(@"Changed取消移动,%@", text);
//
//                return;
//            }
            
            //iOS9 方法 移动过程中随时更新cell位置
            [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:self.collectionView]];
//            NSLog(@"Changed移动,%@", text);
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            //手势结束
            //iOS9方法 移动结束后关闭cell移动
            [self.collectionView endInteractiveMovement];
        }
            break;
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MSYCollectionItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[MSYCollectionItemCell cellReuseId] forIndexPath:indexPath];
    cell.name = self.dataSource[indexPath.row];
    
    return cell;
}

- (NSIndexPath *)collectionView:(UICollectionView *)collectionView targetIndexPathForMoveFromItemAtIndexPath:(NSIndexPath *)originalIndexPath toProposedIndexPath:(NSIndexPath *)proposedIndexPath{
    if([self checkEditableOfIndexPath:proposedIndexPath]){
        return proposedIndexPath;
    }
    return originalIndexPath;
}

- (BOOL)checkEditableOfIndexPath:(NSIndexPath *)proposedIndexPath {
    NSString *text = self.dataSource[proposedIndexPath.row];
    if ([text isEqualToString:@"last"]) {
//        NSLog(@"Changed取消移动,%@", text);
        
        return NO;
    }
    return YES;
}

//开启collectionView可以移动
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *text = self.dataSource[indexPath.row];
    if ([text isEqualToString:@"last"]) {
        return NO;
    }
    return YES;
}

//处理collectionView移动过程中的数据操作
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //取出移动row 数据
    NSObject *item = self.dataSource[sourceIndexPath.row];
    //从数据源中移除该数据
    [self.dataSource removeObject:item];
    //将数据插入到数据源中目标位置
    [self.dataSource insertObject:item atIndex:destinationIndexPath.row];
    
//    NSLog(@"%@", self.dataSource);
}

#pragma mark - getter && setter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width-50.0)/4, 85);
        flowLayout.minimumLineSpacing = 0.1;
        flowLayout.minimumInteritemSpacing = 0.1;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        _collectionView = collectionView;
        
        [collectionView registerClass:[MSYCollectionItemCell class] forCellWithReuseIdentifier:[MSYCollectionItemCell cellReuseId]];
    }
    return _collectionView;
}



@end

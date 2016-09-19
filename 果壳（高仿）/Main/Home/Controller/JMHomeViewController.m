//
//  JMHomeViewController.m
//  果壳（高仿）
//
//  Created by 张碧辉 on 16/9/17.
//  Copyright © 2016年 张碧辉. All rights reserved.
//

#import "JMHomeViewController.h"
#import "SDCycleScrollView.h"
#import "FCXRefreshFooterView.h"
#import "FCXRefreshHeaderView.h"
#import "UIScrollView+FCXRefresh.h"
#import "HomeTableViewCell.h"
#import "NetworkService.h"
#import "JMPresentedViewController.h"

@interface JMHomeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>{

    FCXRefreshHeaderView *headerView;

}

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *sdTitles;
@property (nonatomic,strong) NSMutableArray *sdImageUrls;
@property (nonatomic,strong) NSMutableArray *titles;
@property (nonatomic,strong) NSMutableArray *imageUrls;
@property (nonatomic,strong) NSMutableArray *links;
@property (nonatomic,strong) NSMutableArray *summary;
@property (nonatomic, strong)NSMutableArray *headerViews;
@property (nonatomic,strong)NSMutableArray *authors;



@property (nonatomic,strong) NSMutableArray *models; /**< models */


@end

@implementation JMHomeViewController

static NSString * const PCArticleId = @"article";

static NSString *identifer = @"HomeCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.models = [[NSMutableArray alloc]init];
    _sdTitles = [[NSMutableArray alloc]init];
    _sdImageUrls = [[NSMutableArray alloc]init];
    _titles = [[NSMutableArray alloc]init];
    _imageUrls = [[NSMutableArray alloc]init];
    _links = [[NSMutableArray alloc]init];
    _summary = [[NSMutableArray alloc]init];
    _headerViews = [[NSMutableArray alloc]init];
    _authors = [[NSMutableArray alloc]init];
    [self requestData];
    
    
    [self createSubviews];
    
    __weak __typeof(self)weakSelf = self;
    headerView = [_tableView addHeaderWithRefreshHandler:^(FCXRefreshBaseView *refreshView) {
        [weakSelf requestData];
    }];
}


- (void)requestData{
    
   [NetworkService requestWithURL:adUrl params:nil success:^(id result) {
       NSArray *imageArray = result[@"result"];
       for (NSDictionary *dic in imageArray) {
           if (![dic[@"custom_title"]isEqualToString:@""]) {
               [_sdTitles addObject:dic[@"custom_title"]];
               [_sdImageUrls addObject:dic[@"picture"]];
           }
       }
       _cycleScrollView.titlesGroup = self.sdTitles;
       _cycleScrollView.imageURLStringsGroup = self.sdImageUrls;
       [headerView endRefresh];
   } failure:^(NSError *error) {
       NSLog(@"----%@",error);
       [headerView endRefresh];
   }];
    
    
    NSDictionary *paramDic = @{@"category":@"all",
                               @"since":@1469519796,
                               @"ad":@1,
                               @"orientation":@"before",
                               @"limit":@20,
                               @"retrieve_type":@"by_since"};
    
    [NetworkService requestWithURL:homeUrl params:paramDic success:^(id result) {
        [headerView endRefresh];
        [_models removeAllObjects];
        NSArray *array = result[@"result"];
        NSLog(@"%@",array);
        for (NSDictionary *dic in array) {
            
            [_titles addObject:dic[@"title"]];
            [_imageUrls addObject:dic[@"headline_img"]];
            [_links addObject:dic[@"link"]];
            [_summary addObject:dic[@"summary"]];
            [_authors addObject:dic[@"author"]];
            [_headerViews addObject:dic[@"source_data"][@"image"]];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [headerView endRefresh];
        NSLog(@"----%@",error);
    }];


}



- (void)createSubviews{
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH,
                                                                              kSCREEN_WIDTH * 300 / 640)
                                                          delegate:self
                                                  placeholderImage:[UIImage imageNamed:@"image-holder"]];
    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    _cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
    _cycleScrollView.autoScrollTimeInterval = 3;
    _cycleScrollView.titlesGroup = nil;
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.tableHeaderView = _cycleScrollView;
    [self.view addSubview:_tableView];
    [_tableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:identifer];


}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    
    [cell.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(cell.contentView.mas_left);
        make.top.equalTo(cell.contentView.mas_top);
        make.width.equalTo(cell.contentView.mas_width);
        make.height.offset(10);
        
    }];
    cell.contentLabel.text = _titles[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:_imageUrls[indexPath.row]] placeholderImage:nil];
    cell.summaryLabel.text = _summary[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.headerView sd_setImageWithURL:[NSURL URLWithString:_headerViews[indexPath.row]]];
    cell.author.text = _authors[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect rect = [keyWindow convertRect:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height) fromView:cell];
    
    JMPresentedViewController *presentedVC = [[JMPresentedViewController alloc]init];
    presentedVC.link = _links[indexPath.row];
    presentedVC.textTitle = _titles[indexPath.row];
    [self animationTo:presentedVC from:rect];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 135;
}



/**
 *  扩展展示
 *
 *  @param viewController 要展示的VC
 *  @param frame          白色展开条的初始位置
 */
-(void)animationTo:(UIViewController*)viewController from:(CGRect)frame{
    UIWindow *keyWindow = [[UIApplication sharedApplication]keyWindow];
    
    //黑色遮罩
    UIView *backgroudView = [[UIView alloc]initWithFrame:keyWindow.bounds];
    backgroudView.backgroundColor = [UIColor blackColor];
    backgroudView.alpha = 0.7;
    [keyWindow addSubview:backgroudView];
    
    //白色展开块
    UIView *whiteView = [[UIView alloc]initWithFrame:frame];
    whiteView.backgroundColor = [UIColor whiteColor];
    [keyWindow addSubview:whiteView];
    
    NSTimeInterval timeInterval = 0.5;
    
    [UIView animateWithDuration:timeInterval animations:^{
        whiteView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT);
    } completion:^(BOOL finished) {
        UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:viewController];
        //这两句可以保证，下一个视图覆盖了当前视图的时候，当前视图依然在渲染
        viewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        nav.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        
        [self presentViewController:nav animated:NO completion:^{
            [whiteView removeFromSuperview];
            [backgroudView removeFromSuperview];
        }];
    }];
    
    [UIView animateWithDuration:timeInterval animations:^{
        self.navigationController.view.transform = CGAffineTransformMakeScale(0.85, 0.85);
    } completion:^(BOOL finished) {
        self.navigationController.view.transform = CGAffineTransformIdentity;
    }];
    
}



@end

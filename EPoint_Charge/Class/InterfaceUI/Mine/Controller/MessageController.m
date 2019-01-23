//
//  MessageController.m
//  EPoint_Charge
//
//  Created by 王雷 on 2018/8/25.
//  Copyright © 2018年 dddgong. All rights reserved.
//

#import "MessageController.h"
#import "DefaultView.h"
#import "MessageModel.h"
#import "MessageCell.h"
#import "MessageDetailController.h"

NSString *const MessageDefaultImage = @"default_message";

@interface MessageController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *messageTableView;

@property(nonatomic,strong)NSMutableArray *messages;

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self startRequestNerwork];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [super setNavigationBarOpaqueStyle];
    [self.messageTableView reloadData];
    self.tabBarController.tabBar.hidden = YES;
}

#pragma mark - private method
-(void)startRequestNerwork
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixMessage];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    
    __weak typeof(self) weakSelf = self;
    [CustomAlertView show];
    [[DDNetworkRequest shareInstance] requestGETWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:NULL successful:^(NSDictionary *resultDictionary) {
       
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        NSArray *data = resultDictionary[@"data"];
        if ([code integerValue] == RequestNetworkTokenLose) {
            [super presentLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        if (data.count == 0) {
            [[DefaultView shareInstance] setSuperView:weakSelf.view withDefaultImageNamed:MessageDefaultImage withTitle:@"亲，您还没有消息哦"];
            return;
        }
        for (NSDictionary *dictionary in data) {
            MessageModel *model = [MessageModel modelWithDictionary:dictionary];
            [weakSelf.messages addObject:model];
        }
        
        [weakSelf.messageTableView reloadData];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
        if (weakSelf.messages.count == 0) {
            [[DefaultView shareInstance] setSuperView:weakSelf.view withDefaultImageNamed:MessageDefaultImage withTitle:@"亲，您还没有消息哦"];
        }
    }];
}

-(void)setMessageStatusNetwork:(MessageModel *)model
{
    NSString *requestURL = [NSString stringWithFormat:@"%@/%@",BaseURLPrefix,URLSuffixSetMessageStatus];
    NSString *accessToken = [[UserInfoManager shareInstance] achiveUserInfoAccessToken];
    NSNumber *ID = [NSNumber numberWithInteger:[model.mID integerValue]];
    
    NSDictionary *headerParam = @{@"access_token" : accessToken};
    NSDictionary *bodyParam = @{@"id" : ID};
    
    __weak typeof(self) weakSelf = self;
    [CustomAlertView show];
    [[DDNetworkRequest shareInstance] requestGETWithURLString:requestURL WithHTTPHeaderFieldDictionary:headerParam withParamDictionary:bodyParam successful:^(NSDictionary *resultDictionary) {
        
        [CustomAlertView hide];
        NSString *code = resultDictionary[@"code"];
        NSString *msg = resultDictionary[@"msg"];
        
        if ([code integerValue] == RequestNetworkTokenLose) {
            [super presentLoginController];
            return ;
        }
        if ([code integerValue] != RequestNetworkSuccess) {
            [CustomAlertView showWithFailureMessage:msg];
            return;
        }
        
        [model setMessageStatus]; // 设置为已读
        // 然后跳转
        [weakSelf redirectDetailController:model];
        
    } failure:^(NSError *error) {
        [CustomAlertView hide];
        [CustomAlertView showWithWarnMessage:NetworkingError];
    }];
}

#pragma mark - lazy load
-(NSArray *)messages
{
    if (!_messages) {
        _messages = [[NSMutableArray alloc] init];
    }
    return _messages;
}

-(UITableView *)messageTableView
{
    if (!_messageTableView) {
        CGFloat x = 0.0f;
        CGFloat y = [GeneralSize getStatusBarHeight] + NavigationBarHeight + 12.0f;
        CGFloat width = [GeneralSize getMainScreenWidth];
        CGFloat height = [GeneralSize getMainScreenHeight] - y;
        
        _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        _messageTableView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        // 补全分割线
        if ([_messageTableView respondsToSelector:@selector(setSeparatorInset:)]) {
            _messageTableView.separatorInset = UIEdgeInsetsZero;
        }
        _messageTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_messageTableView];
    }
    return _messageTableView;
}

-(void)redirectDetailController:(MessageModel *)model
{
    UIStoryboard *mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    MessageDetailController *detailVC = [mineSB instantiateViewControllerWithIdentifier:@"MessageDetailController"];
    detailVC.messageTitle = [model.title copy];
    detailVC.content = [model.content copy];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - initUI
-(void)initUI
{
    [super setNavigationBarBackItem];
    [super setNavigationTitle:@"我的消息"];
    [super setNavigationBarTitleFontSize:18.0f andFontColor:@"#333333"];
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F0F0F5"];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageModel *model = self.messages[indexPath.row];
    return model.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageModel *model = self.messages[indexPath.row];
    if (model.status == 1) {
        [self setMessageStatusNetwork:model];
    } else {
        [self redirectDetailController:model];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MessageCellIdentifier = @"MessageCellIdentifier";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:MessageCellIdentifier];
    if (cell == nil) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MessageCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = self.messages[indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

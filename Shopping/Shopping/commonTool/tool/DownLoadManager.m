//
//  DownLoadManager.m
//  Shopping
//
//  Created by qianfeng on 16/1/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "DownLoadManager.h"
#import "DownLoad.h"

#import "InterfaceHeader.h"

#import "IndexFirstModel.h"
#import "IuxuryModel.h"

@interface DownLoadManager()<DownLoadDelegate>

/** 数据缓存队列 */
@property(nonatomic,strong) NSMutableDictionary * dataSourceDict;
/** 下载任务队列 */
@property(nonatomic,strong) NSMutableDictionary * taskDataSource;

@end

@implementation DownLoadManager
+ (DownLoadManager *)sharedDownLoadManager
{
    
    static DownLoadManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DownLoadManager alloc] init];
        });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSourceDict = [[NSMutableDictionary alloc] init];
        self.taskDataSource = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)addDownLoadMessageWithRUL:(NSString *)downLoadURL andType:(NSString *)downLoadType
{
    if([_dataSourceDict objectForKey:downLoadURL])
    {
        //有缓存直接读取
        [[NSNotificationCenter defaultCenter] postNotificationName:downLoadURL object:nil];
    }
    else
    {
        if([_taskDataSource objectForKey:downLoadURL])
        {
            NSLog(@"正在下载");
        }
        else
        {
            DownLoad * downLoad = [[DownLoad alloc] init];
            downLoad.downLoadURL = downLoadURL;
            downLoad.downLoadType = downLoadURL;
            downLoad.delegate = self;
            [downLoad downLoadRequest];
            [_taskDataSource setObject:downLoad forKey:downLoadURL];
            
        }
    }
}

-(NSString *)getSysDate
{
    NSDateFormatter * dataFormetter = [[NSDateFormatter alloc] init];
    [dataFormetter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSDate * date = [NSDate date];
    NSString * dateStr = [dataFormetter stringFromDate:date];
    return [dateStr componentsSeparatedByString:@" "].firstObject;
}

-(void)downLoadFinishWithDownLoad:(DownLoad *)downLoad
{
    //从下载队列中移除
    [_taskDataSource removeObjectForKey:downLoad.downLoadURL];
    //转载数据
    NSMutableArray * dataSource = [[NSMutableArray alloc] init];
    NSDictionary * JSONDict = [NSJSONSerialization JSONObjectWithData:downLoad.downLoadData options:NSJSONReadingMutableContainers error:nil];
    if([downLoad.downLoadType isEqualToString:Index_Search_URL])
    {
        NSDictionary * res = JSONDict[@"rp_result"];
        NSArray * hotkeys = res[@"hotKeys"];
        for (NSDictionary * key in hotkeys) {
            NSString * str = key[@"key"];
            [dataSource addObject:str];
        }
        
    }
    else if ([downLoad.downLoadType isEqualToString:Index_Message_URL])
    {
        NSArray * temData = JSONDict[@"temData"];
        for (NSDictionary * temDict in temData) {
            NSArray * listArr = temDict[@"list"];
            NSMutableArray * modelArr = [NSMutableArray array];
            for (NSDictionary * listDict in listArr) {
                IndexFirstModel * model = [[IndexFirstModel alloc] init];
                [model setValuesForKeysWithDictionary:listDict];
                
                if([model.mytitle isEqualToString:@""]||[model.imgUrl isEqualToString:@"无图片"]) continue;
                
                [modelArr addObject:model];
            }
            if(modelArr.count == 0) continue;
            [dataSource addObject:modelArr];
        }
    }
    else if ([downLoad.downLoadType isEqualToString:[NSString stringWithFormat:Index_Iuxury_URL,[self getSysDate]]])
    {
        NSDictionary * res = JSONDict[@"rp_result"];
        NSArray * rushArr = res[@"rush_rob_list"];
        for (NSDictionary * dict in rushArr) {
            IuxuryModel * model = [[IuxuryModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [dataSource addObject:model];
        }
    }
    
    
    
    
    //缓存
    [_dataSourceDict setObject:dataSource forKey:downLoad.downLoadURL];
    //通知界面下载完成
    [[NSNotificationCenter defaultCenter] postNotificationName:downLoad.downLoadURL object:nil];
}

-(NSMutableArray *)getDownLoadData:(NSString *)downLoadURL
{
    return [_dataSourceDict objectForKey:downLoadURL];
}

@end

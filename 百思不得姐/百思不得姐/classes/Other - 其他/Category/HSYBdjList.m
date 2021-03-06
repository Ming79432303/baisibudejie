//
//  HSYBdjList.m
//  百思不得姐
//
//  Created by ming on 16/11/7.
//  Copyright © 2016年 Apple_Lzzy27. All rights reserved.
//

#import "HSYBdjList.h"
#import "NSCalendar+Calendar.h"
#import "NSDate+myDate.h"
@implementation HSYBdjList
//时间日期格式不要每一次都要创建
static NSDateFormatter *fmt_;
static  NSCalendar *canlendar_;
/**
 *  在第一次使用XMGTopic类时调用1次
 */
+ (void)initialize{
        fmt_ = [[NSDateFormatter alloc] init];
    canlendar_ = [NSCalendar calendar];

}

- (NSString *)created_at{
    //时间的转换
    //2016-11-08 10:08:02
 
   
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  NSDate *date = [fmt_ dateFromString:_created_at];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;

//    //进行适配
//    if ( [NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {//ios7后的
//        canlendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
//    }else{//ios7前的
//        canlendar = [NSCalendar currentCalendar];
//    }
    //获取传入时间的年月日小时
    // NSDateComponents  *compsonest = [canlendar components:unit fromDate:date];
    //获取当前时与传入时间的时间差值
    NSDateComponents *comps = [canlendar_ components:unit fromDate:date toDate:[NSDate date] options:0];
    //ios8的方法低版本无法运行
    
    //所以需要自己写
    
    NSString *dateStr;
    
    if (date.isThisYear) {
        if (date.isToday) {
            if (comps.hour > 1) {
                dateStr = [NSString stringWithFormat:@"%zd小时前",comps.hour];
            }else if (comps.minute > 1){
                dateStr = [NSString stringWithFormat:@"%zd分钟前",comps.minute];
            }else if (comps.second > 1){
                dateStr = @"刚刚";
            }
        }else if (date.isYesterday){
            fmt_.dateFormat = @"昨天hh:mm";
            dateStr = [fmt_ stringFromDate:date];
            
        }else if (date.isTomorrow){
            fmt_.dateFormat = @"明天hh:mm";
            dateStr = [NSString stringWithFormat:@"%@",[fmt_ stringFromDate:date]];
        }else{
            
            fmt_.dateFormat = @"MM-dd hh:mm";
            dateStr = [NSString stringWithFormat:@"%@",[fmt_ stringFromDate:date]];
        }
    }else{
        
        fmt_.dateFormat = @"yyyy-MM-dd-hh:mm";
    }

    return dateStr.length > 0 ? dateStr:@"";
}


@end

//
//  ShopListCell.m
//  PRJ_NiceFoodModule
//
//  Created by 刘雅楠 on 15/6/29.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import "ShopListCell.h"
#import "ShopListModel.h"
#import "UIImageView+WebCache.h"

#define LabelIndexW 20

@implementation ShopListCell


- (ShopListCell *)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        商户图片
        _image = [[UIImageView alloc] initWithFrame:CGRectMake(8, 10, 90, 72)];
        _image.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
//        _image.backgroundColor = [UIColor lightGrayColor];
        _image.layer.cornerRadius = 3;
        _image.layer.masksToBounds = YES;
        [self.contentView addSubview:_image];
        
//        订座标记
        _order = [[UIImageView alloc] init];
        //        _order.backgroundColor = [UIColor greenColor];
        [_order setImage:[UIImage imageNamed:@"meishi_list_icon_ding@2x"]];
        [self.contentView addSubview:_order];
        
//        外卖标记
        _takeout = [[UIImageView alloc] init];
        //        _takeout.backgroundColor = [UIColor redColor];
        [_takeout setImage:[UIImage imageNamed:@"meishi_list_icon_wai@2x"]];
        [self.contentView addSubview:_takeout];
        
//        优惠标记
        _coupon = [[UIImageView alloc] init];
        //        _coupon.backgroundColor = [UIColor orangeColor];
        [_coupon setImage:[UIImage imageNamed:@"meishi_list_icon_hui@2x"]];
        [self.contentView addSubview:_coupon];
        
//        商户名称
        _name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_image.frame)+15, 10, SCREEN_WIDTH - (CGRectGetMaxX(_image.frame)+15) - ((LabelIndexW + 8) * 3 +7 +10), 20)];
//        _name.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_name];
        
//        评分
        _score = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_image.frame)+15, CGRectGetMaxY(_name.frame)+ 10, 94, 15)];
//        _score.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_score];
        
        
//        人均消费
        _consume = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - ((LabelIndexW + 10) * 2 +15)-20, LabelIndexW + 20, 70, 15)];
//        _consume.backgroundColor = [UIColor redColor];
        _consume.textColor = [UIColor grayColor];
        _consume.textAlignment = NSTextAlignmentRight;
        _consume.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_consume];
        
//        距离
        _distance = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - ((LabelIndexW + 10) * 2 +15)-20, CGRectGetMaxY(_consume.frame)+10, 70, 15)];
//        _distance.backgroundColor = [UIColor redColor];
        _distance.textColor = [UIColor grayColor];
        _distance.textAlignment = NSTextAlignmentRight;
        _distance.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_distance];
        
//        商区和行业
        _shopArea = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_image.frame)+15, CGRectGetMaxY(_score.frame)+10, SCREEN_WIDTH - (CGRectGetMaxX(_image.frame)+15) - ((LabelIndexW + 8) * 3 +7 + 10), 15)];
//        _shopArea.backgroundColor = [UIColor redColor];
        _shopArea.textColor = [UIColor grayColor];
        _shopArea.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_shopArea];
        
        
        
    }
    return self;
}



+ (ShopListCell *)cellWithTableView:(UITableView *)tabelView{

    static NSString * ident = @"shopListCell";
    
    ShopListCell *cell = [tabelView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        
        cell = [[ShopListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
        
    }
    return cell;
}

- (void)setModel:(ShopListModel *)Model{
    _model          = Model;
    
    _takeout.hidden = YES;
    _order.hidden = YES;
    _coupon.hidden = YES;
    
    
//    商户图片
    [_image setImageWithURL:[NSURL URLWithString:Model.shopImageUrl] placeholderImage:[UIImage imageNamed:@"morenshop"]];
    
//    商户名称
    _name.text = Model.name;
    

    
//    商圈和行业
    _shopArea.text = [NSString stringWithFormat:@"%@ %@", Model.shopareaName, Model.industryClassifyIdChildName];
  
//    人均消费
    NSString *str = Model.perConsumption;
    int per = [str intValue];
    _consume.text = [NSString stringWithFormat:@"人均%d元", per];
    
//    距离
    if (Model.distance == 0) {
        _distance.text = [NSString stringWithFormat:@""];
    } else if (Model.distance <= 100) {
        _distance.text = [NSString stringWithFormat:@"<100米"];
    } else if (Model.distance > 100 && Model.distance < 1000 ) {
        _distance.text = [NSString stringWithFormat:@"%ld米", Model.distance];
    } else if (Model.distance > 1000) {
        _distance.text = [NSString stringWithFormat:@">1000米"];
    }
    
    
    int index = 1;
//        外卖标记
    if (Model.provideServiceTakeout) {

        _takeout.frame = CGRectMake(SCREEN_WIDTH - (LabelIndexW + 8) * index - 7, 10, LabelIndexW, LabelIndexW);
        _takeout.hidden = NO;
        
        index ++;
    }
    
//       订座标记
    if (Model.provideServiceOrder) {

        _order.frame = CGRectMake(SCREEN_WIDTH - (LabelIndexW + 8) * index - 7, 10, LabelIndexW, LabelIndexW);
        _order.hidden = NO;
        
        index++;
    }
    
//      优惠券标记
    if (Model.provideServiceDiscount) {

        _coupon.frame = CGRectMake(SCREEN_WIDTH - (LabelIndexW + 8) * index - 7, 10, LabelIndexW, LabelIndexW);
        _coupon.hidden = NO;
        

    }
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

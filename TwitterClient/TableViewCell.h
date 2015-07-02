//
//  TableViewCell.h
//  TwitterClient
//
//  Created by Brian Huang on 7/2/15.
//  Copyright (c) 2015 EC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thumb;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *retweet;
@property (weak, nonatomic) IBOutlet UIImageView *fav;

@property (weak, nonatomic) IBOutlet UIImageView *reply;
@property (weak, nonatomic) IBOutlet UILabel *time;
- (void)setTweet:(Tweet *)tweet;

@end

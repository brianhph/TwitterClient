//
//  TweetDetailsViewController.h
//  twitter
//
//  Created by GD Huang on 7/1/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"


@protocol TweetDetailsViewControllerDelegate <NSObject>
- (void)getTweets;
@end


@interface TweetDetailsViewController : UIViewController

@property (nonatomic, weak) id<TweetDetailsViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *timestamp;
@property (weak, nonatomic) IBOutlet UILabel *numRetweets;
@property (weak, nonatomic) IBOutlet UILabel *numFavorites;

@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
@property (weak, nonatomic) IBOutlet UIButton *retweetBtn;
@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;

@property (strong, nonatomic) Tweet* tweet;


@end

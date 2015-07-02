//
//  TweetDetailsViewController.m
//  twitter
//
//  Created by GD Huang on 7/1/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import <UIImageView+AFNetworking.h>
#import "TwitterClient.h"
#import "NewTweetViewController.h"

@interface TweetDetailsViewController ()

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Home" style:UIBarButtonItemStylePlain target: self action:@selector(onHomeButton)];
    
    
    self.text.text = _tweet.text;
    self.name.text = _tweet.user.name;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    self.timestamp.text = [dateFormatter stringFromDate:_tweet.createAt];
    [self.avatarImage setImageWithURL: [NSURL URLWithString:_tweet.user.profileImageUrl]];
    self.numRetweets.text = [NSString stringWithFormat:@"%@ RETWEETS", _tweet.retweetCount];
    self.numFavorites.text = [NSString stringWithFormat:@"%@ FAVORITES", _tweet.favoriteCount];
    
    
    if(_tweet.retweeted) {
        [self.retweetBtn setImage:[UIImage imageNamed:@"retweet_on.png"] forState:UIControlStateNormal];
    }
    if(_tweet.favorited) {
        [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite_on.png"] forState:UIControlStateNormal];
    }
    
}


- (void) onHomeButton {
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.delegate getTweets];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onReplyBtn:(id)sender {
    
    NewTweetViewController *vc = [[NewTweetViewController alloc
                                   ] initWithReply:_tweet.tweetID];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (IBAction)onRetweetButton:(id)sender {
    
    [[TwitterClient sharedInstance] retweet:_tweet.tweetID success:^(Tweet *tweet) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate getTweets];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
}

- (IBAction)onFavoriteBtn:(id)sender {
    NSLog(@"%@", _tweet);
    [[TwitterClient sharedInstance] favorite:_tweet.tweetID success:^(id responseObject) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate getTweets];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
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

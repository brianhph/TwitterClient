//
//  TableViewCell.m
//  TwitterClient
//
//  Created by Brian Huang on 7/2/15.
//  Copyright (c) 2015 EC. All rights reserved.
//

#import "TableViewCell.h"
#import <UIImageView+AFNetworking.h>


@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
    self.name.text = [NSString stringWithFormat:@"%@", tweet.user.name];
    self.content.text = tweet.text;
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:tweet.user.profileImageUrl]];
    [self.thumb setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [UIView transitionWithView:self.thumb duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.thumb.image = image;
        } completion:nil];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
    }];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    self.time.text = [dateFormatter stringFromDate:tweet.createAt];

    if(tweet.retweeted) {
        [self.retweet setImage:[UIImage imageNamed:@"retweet_on.png"]];
    }
    if(tweet.favorited) {
        [self.fav setImage:[UIImage imageNamed:@"favorite_on.png"]];
    }
}

/*
- (void)prepareForReuse {
    [self.retweet setImage:[UIImage imageNamed:@"retweet.png"] forState:UIControlStateNormal];
    [self.fav setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
}
 */

@end

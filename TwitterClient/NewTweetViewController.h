//
//  NewTweetViewController.h
//  twitter
//
//  Created by GD Huang on 7/1/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol NewTweetViewControllerDelegate <NSObject>
- (void)getTweets;
@end


@interface NewTweetViewController : UIViewController

@property (nonatomic, weak) id<NewTweetViewControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSString *replyID;

- (id) initWithReply:(NSString *)replyID;

@end

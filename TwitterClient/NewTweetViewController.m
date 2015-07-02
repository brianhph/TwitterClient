//
//  NewTweetViewController.m
//  twitter
//
//  Created by GD Huang on 7/1/15.
//  Copyright (c) 2015 gdhuang. All rights reserved.
//

#import "NewTweetViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import <UIImageView+AFNetworking.h>

@interface NewTweetViewController ()

@end

@implementation NewTweetViewController

- (id) initWithReply:(NSString *)replyID {
    self = [super init];
    self.replyID = replyID;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target: self action:@selector(onCancelButton)];
    
    
    if(self.replyID) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reply" style:UIBarButtonItemStylePlain target: self action:@selector(onReplyButton)];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target: self action:@selector(onTweetButton)];
    }
    
    
    [self.textView becomeFirstResponder];
    
    self.name.text = [User currentUser].name;
    [self.avatarImage setImageWithURL: [NSURL URLWithString:[User currentUser].profileImageUrl]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) onCancelButton {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) onTweetButton {
    [self.view endEditing:YES];
    [[TwitterClient sharedInstance] postTweet:self.textView.text success:^(Tweet *tweet) {
        [self dismissViewControllerAnimated:YES completion:nil];
        [self.delegate getTweets];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];
    
    
}

- (void) onReplyButton {
    [self.view endEditing:YES];
    [[TwitterClient sharedInstance] reply:self.textView.text replyTo:self.replyID success:^(Tweet *tweet) {
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

//
//  ViewController.m
//  FacebookSDKFriendsListTest
//
//  Created by Jinho Son on 2014. 1. 21..
//  Copyright (c) 2014년 STD1. All rights reserved.
//

#import <FacebookSDK/FacebookSDK.h>
#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController
{
    NSArray *friends;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return friends.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FRIEND_CELL"];
    NSDictionary<FBGraphUser> *friendList;
    friendList = friends[indexPath.row];
    
    cell.textLabel.text = friendList.name;
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    friends = [[NSArray alloc] init];
    FBLoginView *loginView = [[FBLoginView alloc] init];
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 5);
    [self.view addSubview:loginView];
    
    FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
        friends = [result objectForKey:@"data"];
        NSLog(@"Found: %d friends", (int)friends.count);
        for (NSDictionary<FBGraphUser>* friend in friends) {
            NSLog(@"Friend Name: %@, ID: %@", friend.name, friend.id);
        }
        [self.table reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

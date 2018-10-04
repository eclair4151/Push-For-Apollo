#import <UserNotifications/UserNotifications.h>

@interface BBBulletinRequest
@property (nonatomic,copy) NSString * title; 
@property (nonatomic,copy) NSString * subtitle; 
@property (nonatomic,copy) NSString * message;
@end

@interface ApolloNavigationController: UINavigationController
@end

@interface BBServer
-(void)_publishBulletinRequest:(id)arg1 forSectionID:(id)arg2 forDestinations:(unsigned long long)arg3 alwaysToLockScreen:(BOOL)arg4 ;
@end

%hook BBServer

-(void)_publishBulletinRequest:(id)arg1 forSectionID:(id)arg2 forDestinations:(unsigned long long)arg3 alwaysToLockScreen:(BOOL)arg4 {
	if ([((NSString *)arg2) isEqualToString:@"com.reddit.Reddit"]) {
		%orig(arg1,@"com.christianselig.Apollo",arg3,arg4);
	} else {
	 	%orig;
	}
}

%end


%hook ApolloNavigationController
	- (void)viewDidAppear:(BOOL)animated {
		UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
		[center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
   			completionHandler:^(BOOL granted, NSError * _Nullable error) {
			}];
		%orig;

	}
%end


%ctor {
    %init(ApolloNavigationController=objc_getClass("Apollo.ApolloNavigationController"));
}

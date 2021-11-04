//
//  Todo.h
//  QuickAndNimble
//
//  Created by New Account on 11/4/21.
//

#ifndef Todo_h
#define Todo_h


#endif /* Todo_h */
#import <Foundation/Foundation.h>
@interface Todo : NSObject

/*
 "userId": 1,
 "id": 1,
 "title": "delectus aut autem",
 "completed": false
 */
@property (strong, nonatomic) NSNumber *userId;
@property (strong, nonatomic) NSNumber *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *completed;

@end

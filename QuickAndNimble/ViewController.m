//
//  ViewController.m
//  QuickAndNimble
//
//  Created by New Account on 11/4/21.
//

#import "ViewController.h"
#import "Todo.h"
#import "QuickAndNimble-Swift.h"

@interface ViewController ()


@property (nonatomic, weak) IBOutlet UITableView *myTableView;

@property (strong, nonatomic) NSArray<Todo *> *todoArray;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpItem];
    [self fetchTodos];
}

-(void) setUpItem{
    self.todoArray = NSMutableArray.new;
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

-(void)fetchTodos {
    NSLog(@"Fetching Todos");
    NSString *urlString = @"https://jsonplaceholder.typicode.com/todos";
    NSURL *url = [NSURL URLWithString:urlString];
    //
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            NSLog(@"Finished fetching todo.....");
        
       /* NSString *itemString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Item string: %@", itemString); */
        
        NSError *fileError;
       NSArray *todoJSON = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error: &fileError];
        if(fileError){
            NSLog(@"Failed to serialize: @", fileError);
            return;
        }
        
        NSMutableArray<Todo *> *todoList = NSMutableArray.new;
        
        for (NSDictionary *todoItem in todoJSON){
            NSNumber *userId = todoItem[@"userId"];
            NSNumber *id = todoItem[@"id"];
            NSString *title = todoItem[@"title"];
            NSString *completed = todoItem[@"completed"];
            Todo *todo = Todo.new;
            todo.userId = userId;
            todo.id = id;
            todo.title = title;
            todo.completed = completed;
            
            [todoList addObject:todo];
        }
        self.todoArray = todoList;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView reloadData];
        });
        }] resume];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *myCell = [[UITableViewCell alloc]
                               initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contentCell"];
    if(myCell == nil){
        myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"contentCell"];
    }
    Todo *todoOperation = self.todoArray[indexPath.row];
    myCell.textLabel.text = todoOperation.title;
    myCell.textLabel.numberOfLines = 0;
    myCell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    return myCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todoArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Todo *todoOperation = self.todoArray[indexPath.row];
    SecondView *nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondViewController"];
   
    nextView.titleItem = todoOperation.title;
    nextView.userId = [todoOperation.id stringValue];
    [self presentViewController: nextView animated:true completion:nil];

}
@end

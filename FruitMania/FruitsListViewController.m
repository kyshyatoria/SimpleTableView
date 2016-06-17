//
//  FruitsListViewController.m
//  FruitMania
//
//  Created by Kanchan Yadav on 17/06/16.
//  Copyright © 2016 Kanchan Yadav. All rights reserved.
//

#import "FruitsListViewController.h"

@interface FruitsListViewController ()<UITableViewDelegate, UITableViewDataSource>   //class extension
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *fruitsList;  //by default strong, atomic,
@property NSMutableDictionary *sortedFruitsdictionary;

@end

@implementation FruitsListViewController

//declared static so that compiler uses only copy of this string everytime cellForRowAtIndexPath method is called.
static NSString *cellIdentifier = @"fruit cell identifier";
int num = 423;


- (void)viewDidLoad {
    [super viewDidLoad];
    _fruitsList = @[@"Apple", @"Mango", @"Peach", @"BlackBerry", @"Pomogranet",@"Orange", @"Guava",@"Banana",@"lime",@"Kiwi", @"Pear", @"Strawberry",@"PassionFruit",@"Sun Melon", @"Water Melon"];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];

}

/*
 Descritiption: returns no. of sections in table view.
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

/*
 Description: returns no. of rows in a given section. @required method of UITableViewDataSource protocol.
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    NSUInteger fruitsCount = [self.fruitsList count];
    return fruitsCount;
}

/*
 Description: @required method of UiTableViewDataSource protocol, app will crash if this is not implemented. returns cell to be used for a given row of a given section. this info is extracted fron indexPath.
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *fruitsCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSString *fruitName = [_fruitsList objectAtIndex:indexPath.row];
    [fruitsCell.textLabel setText:fruitName];
    return fruitsCell;
}

/*
 /Dispose of any resources that can be recreated.
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

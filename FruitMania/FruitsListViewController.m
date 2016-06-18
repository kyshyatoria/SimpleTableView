//
//  FruitsListViewController.m
//  FruitMania
//
//  Created by Kanchan Yadav on 17/06/16.
//  Copyright © 2016 Kanchan Yadav. All rights reserved.
//

#import "FruitsListViewController.h"
#import "Constants.h"
#import "FruitsListViewController+Helper.h"

@interface FruitsListViewController ()<UITableViewDelegate, UITableViewDataSource>   //class extension
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *fruitsList;  //by default strong, atomic,
@property NSDictionary *sortedFruitsdictionary;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerLabelHeightConstraint;

@end

@implementation FruitsListViewController{

    NSInteger previousSection;
    UIColor *previousCellColor;
}

//declared static so that compiler uses only copy of this string everytime cellForRowAtIndexPath method is called.
static NSString *cellIdentifier = @"fruit cell identifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    _fruitsList = @[@"Apple",@"Acai",@"Ackee",@"Cantaloupes",@"Chocolate-Fruit",@"Cherries",@"Cranberries",@"Cucumbers",@"Currants", @"Peach", @"BlackBerry", @"Pomogranet",@"Orange",@"Banana",@"Kiwi", @"Pear", @"Strawberry",@"Apricots",@"Avocado",@"PassionFruit",@"Sun Melon"];
    _sortedFruitsdictionary = [self sortFruitsArrayAlphabatically:self.fruitsList];
    
    [self.headerLabel setAttributedText:[self setHeaderLabelText]];
    
    [self.headerLabelHeightConstraint setConstant:[self getStringSize:[self setHeaderLabelText]]];
    
    [self.view layoutIfNeeded];

   // [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];

}

#pragma mark - Table view Delegate method.
/*
 Descritiption: returns no. of sections in table view.
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return [_sortedFruitsdictionary count];
}

/*
 Description: returns no. of rows in a given section. @required method of UITableViewDataSource protocol.
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *allKeys = [[_sortedFruitsdictionary allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSString *currentKey = [allKeys objectAtIndex:section];
    NSInteger rowsInSection = [[_sortedFruitsdictionary objectForKey:currentKey]count ];
    
    return rowsInSection;
}


/*
 Description: @required method of UiTableViewDataSource protocol, app will crash if this is not implemented. returns cell to be used for a given row of a given section. this info is extracted fron indexPath.
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *fruitsCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    UITableViewCell *fruitsCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(fruitsCell == nil){
        
        fruitsCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    NSArray *allKeys  = [[_sortedFruitsdictionary allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSString *currentKey = [allKeys objectAtIndex:indexPath.section];
    NSArray *fruitsInGivenSection = [_sortedFruitsdictionary objectForKey:currentKey];
    
    [fruitsCell.textLabel setText:[fruitsInGivenSection objectAtIndex:indexPath.row]];
    [fruitsCell.textLabel setFont:GEORGIA_FONT_FOR_NORMAL_TEXT];
    [fruitsCell.imageView setImage:APPLE_ICON];
    [fruitsCell setBackgroundColor:[UIColor greenColor]];
    
    if(previousSection == indexPath.section && previousCellColor){
        
        [fruitsCell setBackgroundColor:previousCellColor];
    }else{
        
        previousCellColor = [self generateRandomColorForSectionBackground];
        [fruitsCell setBackgroundColor:previousCellColor];
    }
    previousSection = indexPath.section;
    
    return fruitsCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 5.0f; //0.0 doesn't work :(
}


-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 0.0000001;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [_tableView reloadData];
}


-(NSAttributedString *)setHeaderLabelText{
    
    NSString *labelString =  @"Here i have implemented Table using default UITableView in UIViewController.";
    NSString *headerText = @"-- Table View --";
    
   return [self generateAttributedString:labelString andHeaderText:headerText];
}

/*
 /Dispose of any resources that can be recreated.
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

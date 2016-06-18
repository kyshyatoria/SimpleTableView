//
//  FruitsListViewController.m
//  FruitMania
//
//  Created by Kanchan Yadav on 17/06/16.
//  Copyright © 2016 Kanchan Yadav. All rights reserved.
//


/***
 
 there is one issue with the color: ideally what i have tried to do is all the fuits with the same first letter should have same color. Initially when table view is created
 
 **/
#import "FruitsListViewController.h"

@interface FruitsListViewController ()<UITableViewDelegate, UITableViewDataSource>   //class extension
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *fruitsList;  //by default strong, atomic,
@property NSDictionary *sortedFruitsdictionary;

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
        
        fruitsCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
    }
    NSArray *allKeys  = [[_sortedFruitsdictionary allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSString *currentKey = [allKeys objectAtIndex:indexPath.section];
    NSArray *fruitsInGivenSection = [_sortedFruitsdictionary objectForKey:currentKey];
    
    [fruitsCell.textLabel setText:[fruitsInGivenSection objectAtIndex:indexPath.row]];
    [fruitsCell.textLabel setFont:[UIFont fontWithName:@"Georgia" size:16.0]];
    [fruitsCell.detailTextLabel setText:@"blahbhjahjf"];
    [fruitsCell.imageView setImage:[UIImage imageNamed:@"Apple"]];
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


#pragma mark - Helper Methods
/*
 Descritpion: used to generate random color.
 */
-(UIColor *)generateRandomColorForSectionBackground{

    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.2;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.8;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:0.2];
    
    return color;
}

/*
 Description: it is used to sort fruits alphabatically.
 */
-(NSDictionary *)sortFruitsArrayAlphabatically:(NSArray *)fruitsArray{
    
    NSMutableDictionary *sortedFruitsdict = [[NSMutableDictionary alloc] init];
    
    for(NSString *fruit in fruitsArray){
        
        NSString *firstLetter = [fruit substringToIndex:1];
        NSMutableArray *sortedFruitsSubArray;
        if([sortedFruitsdict objectForKey:firstLetter]){
            
            sortedFruitsSubArray = [sortedFruitsdict objectForKey:firstLetter];
            [sortedFruitsSubArray addObject:fruit];
            
        }else{
            
            sortedFruitsSubArray= [[NSMutableArray alloc] init];
            [sortedFruitsSubArray addObject:fruit];
        }
        [sortedFruitsdict setObject:sortedFruitsSubArray forKey:firstLetter];
    }
    
    //now sort the keys in dictionary.
    NSArray *allKeys = [sortedFruitsdict allKeys];
    for(NSString *fruitFirstLetter in allKeys){
        
        [[sortedFruitsdict objectForKey:fruitFirstLetter] sortUsingSelector:@selector(caseInsensitiveCompare:)];
        
    }
    
    return sortedFruitsdict;;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    [_tableView reloadData];
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

//
//  FruitsListViewController+Helper.m
//  FruitMania
//
//  Created by Kanchan Yadav on 18/06/16.
//  Copyright © 2016 Kanchan Yadav. All rights reserved.
//

/**
 Category.
 **/
#import "FruitsListViewController+Helper.h"
#import "Constants.h"
@implementation FruitsListViewController (Helper)

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

/*
 Description: returns NSAttributed String.
 
 */
-(NSAttributedString *)generateAttributedString:(NSString *)text andHeaderText:(NSString *)headerText{
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]
                                             initWithString:text
                                             attributes:@{
                                                          NSFontAttributeName: GEORGIA_FONT_FOR_NORMAL_TEXT,
                                                          NSForegroundColorAttributeName:BLUE_COLOR
                                                          }
                                             ];
    
    NSMutableAttributedString *headerString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",headerText]];
    [headerString addAttributes:@{  NSFontAttributeName: GEORGIA_FONT_FOR_HEADER_TEXT,
                                    NSForegroundColorAttributeName:RED_COLOR
                                    } range:NSMakeRange(0, headerString.length)];
    
//    [attrString appendAttributedString:headerString];
    [attrString insertAttributedString:headerString atIndex:0];
    return attrString;
    
}

-(CGFloat)getStringSize:(NSAttributedString *)attrString{

    CGRect stringSizeRect = [attrString boundingRectWithSize:CGSizeMake(240, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil];
    return stringSizeRect.size.height;
}

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


@end

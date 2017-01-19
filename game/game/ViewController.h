//
//  ViewController.h
//  game
//
//  Created by Tang Hana on 2017/1/18.
//  Copyright © 2017年 Tang Hana. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    
    NSMutableArray *bulletRArray;
    NSMutableArray *bulletRCenter;
    NSMutableArray *bulletBArray;
    NSMutableArray *bulletBCenter;
    NSMutableArray *enemy1Array;
    NSMutableArray *enemy1Life;
    NSMutableArray *enemy2Array;
    NSMutableArray *enemy2Life;
    
    int enemyLife1;
    int enemyLife2;
    
    
    UIView* start;
    UIButton* sBtn;
    UILabel* countDown;
    int count;
    int enemyKilled;
    
    UIImageView *ufo;
    
    UIImageView *hero;
    
    
    NSTimer *countStart;
    NSTimer *enemy1Move;
    NSTimer * heroMove;
    NSTimer * bullter1Move;
    int heros; //animation of hero
    int heroLife;//life of hero
    int bulletC;  //red or blue bullet
    NSTimer* bulletRecover;
    
    UIButton* pause;
    UILabel*score;
}


@end


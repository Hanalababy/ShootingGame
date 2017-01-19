//
//  ViewController.m
//  game
//
//  Created by Tang Hana on 2017/1/18.
//  Copyright © 2017年 Tang Hana. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@end

@implementation ViewController

-(void) setting{
    /*hero*/
    UIImage*image=[UIImage imageNamed:@"hero1.png"];
    hero.frame=CGRectMake(self.view.frame.size.width/2-image.size.width/2,self.view.frame.size.height-image.size.height,image.size.width,image.size.height);
    hero.image=image;
    heros=0;
    heroLife=1;
    
    /*bulllets*/
    bulletC=0;//bullet color = red
    for(int i=0;i!=5;i++)
    {
        UIImageView* bullet=[bulletRArray objectAtIndex:i];
        UIImage*imageBR=[UIImage imageNamed:@"bullet1.png"];
        bullet.frame=CGRectMake(self.view.frame.size.width/2-imageBR.size.width/2,self.view.frame.size.height-image.size.height-imageBR.size.height-120*i,imageBR.size.width,imageBR.size.height);
        bullet.image=imageBR;
        bullet.hidden=NO;
        [bulletRArray  replaceObjectAtIndex:i withObject:bullet];
        [bulletRCenter replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:bullet.center.y+120*i-600]];
        
        UIImageView* bullet1=[bulletBArray objectAtIndex:2*i];
        UIImage*imageBB=[UIImage imageNamed:@"bullet2.png"];
        bullet1.frame=bullet.frame;
        bullet1.image=imageBB;
        bullet1.center=CGPointMake(bullet.center.x-30,bullet.center.y);
        bullet1.hidden=YES;
        [bulletBArray replaceObjectAtIndex:2*i withObject:bullet1];
        
        
        UIImageView* bullet2=[bulletBArray objectAtIndex:2*i+1];
        bullet2.frame=bullet.frame;
        bullet2.image=imageBB;
        bullet2.center=CGPointMake(bullet.center.x+30,bullet.center.y);
        bullet2.hidden=YES;
        [bulletBArray replaceObjectAtIndex:2*i+1 withObject:bullet2];
        
        [bulletBCenter replaceObjectAtIndex:2*i withObject:[NSNumber numberWithInt:bullet.center.y+120*i-600]];
        [bulletBCenter replaceObjectAtIndex:2*i+1 withObject:[NSNumber numberWithInt:bullet.center.y+120*i-600]];
    }
    /*enemy I*/
    enemyKilled=0;
    for(int i=0;i!=2;i++)
    {
        UIImage*imageE1=[UIImage imageNamed:@"enemy1.png"];
        UIImageView* enemy=[enemy1Array objectAtIndex:i];
        enemy.frame=CGRectMake(50+150*i,-imageE1.size.height-150*i,imageE1.size.width,imageE1.size.height);
        enemy.image=imageE1;
        [enemy1Array replaceObjectAtIndex:i withObject:enemy];
        [enemy1Life replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:enemyLife1]];
    }
    /*enemy II*/
    for(int i=0;i!=2;i++)
    {
        UIImage*imageE2=[UIImage imageNamed:@"enemy2.png"];
        UIImageView* enemy=[enemy2Array objectAtIndex:i];
        enemy.frame=CGRectMake(150+150*i,-imageE2.size.height-150-150*i,imageE2.size.width,imageE2.size.height);
        enemy.image=imageE2;
        [enemy2Array replaceObjectAtIndex:i withObject:enemy];
        [enemy2Life replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:enemyLife2]];
    }
    
    /*ufo*/
    UIImage*imageBC=[UIImage imageNamed:@"ufo1.png"];
    ufo.image=imageBC;
    ufo.frame=CGRectMake(arc4random()%250+ufo.frame.size.width,-imageBC.size.height,imageBC.size.width,imageBC.size.height);
    
    /*score*/
    score.text=[NSString stringWithFormat:@"%d",enemyKilled];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    enemyLife1=1;
    enemyLife2=4;
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    
    /*add hero*/
    hero=[[UIImageView alloc] init];
    [self.view addSubview:hero];
    //add guesture to hero
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [hero addGestureRecognizer:panGestureRecognizer];
    hero.userInteractionEnabled = YES;
    
    
    /*add bullets*/
    bulletRArray=[[NSMutableArray alloc] init];
    bulletRCenter=[[NSMutableArray alloc] init];
    bulletBArray=[[NSMutableArray alloc] init];
    bulletBCenter=[[NSMutableArray alloc] init];
    for(int i=0;i!=5;i++)
    {
        
        UIImageView *tempView = [[UIImageView alloc] init];
        [bulletRArray addObject:tempView];
        [self.view addSubview:tempView];
        [bulletRCenter addObject:[NSNumber numberWithInt:0]];
        
        
        UIImageView *tempView2=[[UIImageView alloc]init];
        [bulletBArray addObject:tempView2];
        [self.view addSubview:tempView2];
        
        UIImageView *tempView3=[[UIImageView alloc]init];
        [bulletBArray addObject:tempView3];
        [self.view addSubview:tempView3];
        
        [bulletBCenter addObject:[NSNumber numberWithInt:0]];
        [bulletBCenter addObject:[NSNumber numberWithInt:0]];
    }
    
    /*add enemies I*/
    enemy1Array=[[NSMutableArray alloc] init];
    enemy1Life=[[NSMutableArray alloc] init];
    for(int i=0;i!=2;i++)
    {
        
        UIImageView *enemy=[[UIImageView alloc] init];
        [enemy1Array addObject:enemy];
        [self.view addSubview:enemy];
        [enemy1Life addObject:[NSNumber numberWithInt:0]];
    }
    
    /*add enemies II*/
    enemy2Array=[[NSMutableArray alloc] init];
    enemy2Life=[[NSMutableArray alloc] init];
    for(int i=0;i!=2;i++)
    {
        
        UIImageView *enemy=[[UIImageView alloc] init];
        [enemy2Array addObject:enemy];
        [self.view addSubview:enemy];
        [enemy2Life addObject:[NSNumber numberWithInt:0]];
    }
    
    /*add ufo*/
    ufo=[[UIImageView alloc]init];
    [self.view addSubview:ufo];
    
    /*pause & restart*/
    pause=[[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-50, 30,30,20)];
    [pause setBackgroundImage:[UIImage imageNamed:@"game_pause_pressed.png"] forState:UIControlStateNormal];
    [pause addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pause];
    
    /*score*/
    score=[[UILabel alloc]initWithFrame:CGRectMake(20, 30, 100, 20)];
    [self.view addSubview:score];
    
    
    /*start view*/
    //button
    sBtn=[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-20, 100, 40)];
    [sBtn setTitle: @"START" forState: UIControlStateNormal];
    [sBtn addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    //label
    countDown=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-20, self.view.frame.size.height/2-20, 40, 40)];
    countDown.hidden=YES;
    count=3;
    countDown.text=[NSString stringWithFormat:@"%d",count];
    countDown.textAlignment=NSTextAlignmentCenter;
    countDown.font=[UIFont boldSystemFontOfSize:30.0];
    
    start=[[UIView alloc]init];
    start.frame=self.view.frame;
    start.backgroundColor=[UIColor colorWithWhite:0 alpha:0.5];
    [start addSubview:sBtn];
    [start addSubview: countDown];
    [self.view addSubview:start];
    
    
    
    /*pause when enter background*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pause) name: UIApplicationDidEnterBackgroundNotification object:nil];
}


-(void)enemy1_recover:(NSTimer*) timer
{
    
    NSNumber* index=[[timer userInfo] objectForKey:@"index"];
    enemyKilled++;
    score.text=[NSString stringWithFormat:@"%d",enemyKilled];
    int j= index.intValue;
    UIImageView*enemy=[enemy1Array objectAtIndex:j];
    enemy.center=CGPointMake(50+150*j,-enemy.image.size.height-150*j);
    enemy.image=[UIImage imageNamed:@"enemy1.png"];
    [enemy1Array replaceObjectAtIndex:j withObject:enemy];
    [enemy1Life replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:enemyLife1]];
}

-(void)enemy2_recover:(NSTimer*) timer
{
    
    NSNumber* index=[[timer userInfo] objectForKey:@"index"];
    enemyKilled++;
    score.text=[NSString stringWithFormat:@"%d",enemyKilled];
    int j= index.intValue;
    UIImageView*enemy=[enemy2Array objectAtIndex:j];
    enemy.center=CGPointMake(150+150*j,-enemy.image.size.height-150*j-150);
    enemy.image=[UIImage imageNamed:@"enemy2.png"];
    [enemy2Array replaceObjectAtIndex:j withObject:enemy];
    [enemy2Life replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:enemyLife2]];
}


-(void) counting{
    count--;
    if(count==0)
    {
        [countStart invalidate];
        [self setting];
        [start removeFromSuperview];
        sBtn.hidden=NO;
        countDown.hidden=YES;
        count=3;
        countDown.text=[NSString stringWithFormat:@"%d",count];
        bullter1Move= [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(move) userInfo:nil repeats:YES];
        return;
    }
    countDown.text=[NSString stringWithFormat:@"%d",count];
}

-(void) start{
    NSLog(@"start");
    hero.userInteractionEnabled = YES;
    sBtn.hidden=YES;
    countDown.hidden=NO;
    count=3;
    countStart= [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(counting) userInfo:nil repeats:YES];
    
}
-(void) reStart{
    NSLog(@"restart");
    hero.userInteractionEnabled = YES;
    sBtn.hidden=YES;
    countDown.hidden=NO;
    count=3;
    countStart= [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(counting) userInfo:nil repeats:YES];
}

-(void)fail
{
    hero.userInteractionEnabled = NO;
    [bullter1Move setFireDate:[NSDate distantFuture]];
    [sBtn setTitle: @"RESTART" forState: UIControlStateNormal];
    [sBtn removeTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [sBtn addTarget:self action:@selector(reStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
}


-(void) resume
{
    hero.userInteractionEnabled = YES;
    hero.image=[UIImage imageNamed:@"hero1.png"];
    [bullter1Move setFireDate:[NSDate date]];
    [pause setBackgroundImage:[UIImage imageNamed:@"game_pause_pressed.png"] forState:UIControlStateNormal];
    [pause removeTarget:self action:@selector(resume) forControlEvents:UIControlEventTouchUpInside];
    [pause addTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"resume");
    
}

-(void) pause
{
    hero.userInteractionEnabled = NO;
    [bullter1Move setFireDate:[NSDate distantFuture]];
    [pause setBackgroundImage:[UIImage imageNamed:@"game_resume_pressed.png"] forState:UIControlStateNormal];
    [pause removeTarget:self action:@selector(pause) forControlEvents:UIControlEventTouchUpInside];
    [pause addTarget:self action:@selector(resume) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"pause");
    
    
}
// 处理拖拉手势
- (void) panView:(UIPanGestureRecognizer *)panGestureRecognizer
{
    UIView *view = panGestureRecognizer.view;
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan || panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        if(hero.userInteractionEnabled == YES)
        {
            CGPoint translation = [panGestureRecognizer translationInView:view.superview];
            
            CGFloat x = view.center.x;
            CGFloat y = view.center.y;
            if(translation.x>0){
                x= fmin(view.center.x + translation.x,self.view.frame.size.width-view.frame.size.width/2);
            }
            else if(translation.x<0){
                x= fmax(view.center.x + translation.x,view.frame.size.width/2);
            }
            if(translation.y>0){
                y= fmin(view.center.y + translation.y,self.view.frame.size.height-view.frame.size.height/2);
            }
            else if(translation.y<0){
                y= fmax(view.center.y + translation.y,view.frame.size.height/2);
            }
            
            [view setCenter:(CGPoint){x,y}];
            [panGestureRecognizer setTranslation:CGPointZero inView:view.superview];
        }
        
    }
}

-(void) bullet_r{
    bulletC=0;
}

-(void) move{
    
    //hero animation
    heros++;
    if(heros%2==0) hero.image=[UIImage imageNamed:@"hero1.png"];
    else hero.image=[UIImage imageNamed:@"hero2.png"];
    
    //red bullet
    for(int i=0;i!=5;i++)
    {
        UIImageView* bullet=[bulletRArray objectAtIndex:i];
        NSNumber*n=[bulletRCenter objectAtIndex:i];
        bullet.center=CGPointMake(bullet.center.x, bullet.center.y-10);
        if(bullet.center.y<=n.floatValue)
        {
            if(bulletC==0) bullet.hidden=NO;
            else bullet.hidden=YES;
            bullet.center=CGPointMake(hero.center.x,hero.center.y-hero.frame.size.height/2-bullet.frame.size.height/2);
            n=[NSNumber numberWithInt:bullet.center.y-600];
            
        }
        [bulletRArray replaceObjectAtIndex:i withObject:bullet];
        [bulletRCenter replaceObjectAtIndex:i withObject:n];
        //bullet change to blue
        if(CGRectIntersectsRect(bullet.frame,ufo.frame))
        {
            ufo.center=CGPointMake(arc4random()%250+ufo.frame.size.width,-ufo.frame.size.height);
            bulletC=1;
            [bulletRecover invalidate];
            bulletRecover=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(bullet_r) userInfo:nil repeats:NO];
        }
        
    }
    //blue bullet
    for(int i=0;i!=10;i++)
    {
        UIImageView* bullet=[bulletBArray objectAtIndex:i];
        NSNumber*n=[bulletBCenter objectAtIndex:i];
        bullet.center=CGPointMake(bullet.center.x, bullet.center.y-10);
        if(bullet.center.y<=n.floatValue)
        {
            if(bulletC==1) bullet.hidden=NO;
            else bullet.hidden=YES;
            bullet.center=CGPointMake(hero.center.x,hero.center.y-hero.frame.size.height/2-bullet.frame.size.height/2);
            if(i%2==0)
            {
                bullet.center=CGPointMake(bullet.center.x-30,bullet.center.y);
            }
            else bullet.center=CGPointMake(bullet.center.x+30,bullet.center.y);
            n=[NSNumber numberWithInt:bullet.center.y-600];
        }
        [bulletBArray replaceObjectAtIndex:i withObject:bullet];
        [bulletBCenter replaceObjectAtIndex:i withObject:n];
        //bullet change to blue
        if(ufo.center.y>0&&CGRectIntersectsRect(bullet.frame,ufo.frame))
        {
            ufo.center=CGPointMake(arc4random()%250+ufo.frame.size.width,-ufo.image.size.height);
            bulletC=1;
            [bulletRecover invalidate];
            bulletRecover=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(bullet_r) userInfo:nil repeats:NO];
        }
    }
    
    //ufo
    ufo.center=CGPointMake(ufo.center.x,ufo.center.y+3);
    if(ufo.center.y>self.view.frame.size.height)
        ufo.center=CGPointMake(arc4random()%250+ufo.frame.size.width,-ufo.image.size.height);
    
    //enemyI
    for(int j=0;j!=2;j++)
    {
        UIImageView*enemy=[enemy1Array objectAtIndex:j];
        enemy.center=CGPointMake(enemy.center.x, enemy.center.y+5);
        NSNumber*life=[enemy1Life objectAtIndex:j];
        int n=life.intValue;
        if(enemy.center.y>self.view.frame.size.height)
        {
            enemy.center=CGPointMake(50+150*j,-enemy.image.size.height);
            n=enemyLife1;
        }
        
        /*******/
        UIImageView* temp=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50,50)];
        temp.center=hero.center;
        /*******/
        
        if(heroLife==1&&CGRectIntersectsRect(enemy.frame, temp.frame))
        {
            heroLife=0;
            hero.animationImages=[NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"hero_blowup_n1.png"],
                                  [UIImage imageNamed:@"hero_blowup_n2.png"],
                                  [UIImage imageNamed:@"hero_blowup_n3.png"],
                                  [UIImage imageNamed:@"hero_blowup_n4.png"],
                                  nil];
            hero.image=[UIImage imageNamed:@"hero_blowup_n4.png"];
            [hero setAnimationRepeatCount:1];
            hero.animationDuration=0.3;
            [hero startAnimating];
            [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(fail) userInfo:nil repeats:NO];
            
        }
        
        else if(enemy.center.y>0&&n>0)
        {
            for(int i=0;i!=5;i++)
            {
                UIImageView*bullet=[bulletRArray objectAtIndex:i];
                UIImageView*bullet1=[bulletBArray objectAtIndex:i*2];
                UIImageView*bullet2=[bulletBArray objectAtIndex:i*2+1];
                if(bullet.hidden==NO&&CGRectIntersectsRect(bullet.frame,enemy.frame))
                {
                    bullet.hidden=YES;
                    n--;
                    
                    if(n<=0)
                    {
                        enemy.animationImages=[NSArray arrayWithObjects:
                                               [UIImage imageNamed:@"enemy1_down"],
                                               nil];
                        [enemy setAnimationRepeatCount:1];
                        enemy.animationDuration=0.18;
                        [enemy startAnimating];
                        
                        
                        NSNumber* k=[NSNumber numberWithInt:j];
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        [dict setObject:k forKey:@"index"];
                        [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(enemy1_recover:) userInfo:dict repeats:NO];
                        
                        break;
                    }
                }
                
                else if((bullet1.hidden==NO&&CGRectIntersectsRect(bullet1.frame,enemy.frame))||(bullet2.hidden==NO&&CGRectIntersectsRect(bullet2.frame,enemy.frame)))
                {
                    bullet1.hidden=YES;
                    bullet2.hidden=YES;
                    n--;
                    n--;
                    if(n<=0)
                    {
                        enemy.animationImages=[NSArray arrayWithObjects:
                                               [UIImage imageNamed:@"enemy1_down"],
                                               nil];
                        [enemy setAnimationRepeatCount:1];
                        enemy.animationDuration=0.18;
                        [enemy startAnimating];
                        
                        NSNumber* k=[NSNumber numberWithInt:j];
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        [dict setObject:k forKey:@"index"];
                        [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(enemy1_recover:) userInfo:dict repeats:NO];
                        break;
                        
                    }
                }
                
            }
        }
        [enemy1Array replaceObjectAtIndex:j withObject:enemy];
        [enemy1Life replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:n]];
    }
    //enemyII
    for(int j=0;j!=2;j++)
    {
        UIImageView*enemy=[enemy2Array objectAtIndex:j];
        enemy.center=CGPointMake(enemy.center.x, enemy.center.y+5);
        NSNumber*life=[enemy2Life objectAtIndex:j];
        int n=life.intValue;
        if(enemy.center.y>self.view.frame.size.height)
        {
            enemy.center=CGPointMake(150+150*j,-enemy.image.size.height);
            n=enemyLife2;
        }
        
        /*******/
        UIImageView* temp=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50,50)];
        temp.center=hero.center;
        /*******/
        
        if(heroLife==1&&CGRectIntersectsRect(enemy.frame,temp.frame))
        {
            heroLife=0;
            hero.animationImages=[NSArray arrayWithObjects:
                                  [UIImage imageNamed:@"hero_blowup_n1.png"],
                                  [UIImage imageNamed:@"hero_blowup_n2.png"],
                                  [UIImage imageNamed:@"hero_blowup_n3.png"],
                                  [UIImage imageNamed:@"hero_blowup_n4.png"],
                                  nil];
            hero.image=[UIImage imageNamed:@"hero_blowup_n4.png"];
            [hero setAnimationRepeatCount:1];
            hero.animationDuration=0.3;
            [hero startAnimating];
            [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(fail) userInfo:nil repeats:NO];
            
        }
        
        else if(enemy.center.y>0&&n>0)
        {
            for(int i=0;i!=5;i++)
            {
                UIImageView*bullet=[bulletRArray objectAtIndex:i];
                UIImageView*bullet1=[bulletBArray objectAtIndex:i*2];
                UIImageView*bullet2=[bulletBArray objectAtIndex:i*2+1];
                if(bullet.hidden==NO&&CGRectIntersectsRect(bullet.frame,enemy.frame))
                {
                    bullet.hidden=YES;
                    n--;
                    
                    if(n<=0)
                    {
                        enemy.animationImages=[NSArray arrayWithObjects:
                                               [UIImage imageNamed:@"enemy2_down1"],
                                               [UIImage imageNamed:@"enemy2_down2"],
                                               [UIImage imageNamed:@"enemy2_down3"],
                                               nil];
                        [enemy setAnimationRepeatCount:1];
                        enemy.animationDuration=0.18;
                        [enemy startAnimating];
                        
                        
                        NSNumber* k=[NSNumber numberWithInt:j];
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        [dict setObject:k forKey:@"index"];
                        [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(enemy2_recover:) userInfo:dict repeats:NO];
                        
                        break;
                    }
                }
                
                else if((bullet1.hidden==NO&&CGRectIntersectsRect(bullet1.frame,enemy.frame))||(bullet2.hidden==NO&&CGRectIntersectsRect(bullet2.frame,enemy.frame)))
                {
                    bullet1.hidden=YES;
                    bullet2.hidden=YES;
                    n--;
                    n--;
                    if(n<=0)
                    {
                        enemy.animationImages=[NSArray arrayWithObjects:
                                               [UIImage imageNamed:@"enemy2_down1"],
                                               [UIImage imageNamed:@"enemy2_down2"],
                                               [UIImage imageNamed:@"enemy2_down3"],
                                               nil];
                        [enemy setAnimationRepeatCount:1];
                        enemy.animationDuration=0.18;
                        [enemy startAnimating];
                        
                        NSNumber* k=[NSNumber numberWithInt:j];
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                        [dict setObject:k forKey:@"index"];
                        [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(enemy2_recover:) userInfo:dict repeats:NO];
                        break;
                        
                    }
                }
                
            }
        }
        [enemy2Array replaceObjectAtIndex:j withObject:enemy];
        [enemy2Life replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:n]];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

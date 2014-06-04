//
//  MyScene.m
//  SnakeGame
//
//  Created by Jierong Luo on 6/4/2014.
//  Copyright (c) 2014 Jierong Luo. All rights reserved.
//

#import "MyScene.h"

@implementation MyScene{
    NSMutableArray* Body;
    SKSpriteNode* Food;
    BOOL isUpdatingBody;
    BOOL isGameOver;
    int direction;
    int score;
    int height;
    int width;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        NSLog(@"****** initWithSize ****** %@ ****** \n", NSStringFromCGSize(size));
        
        height = size.height / 10;
        width = size.width / 10;
        //NSLog(@"%d %d",height,width);
        
        if([self children] != nil){
            [self removeAllChildren];
        }
        [self startGame];
    }
    return self;
}

-(void)startGame{
    NSLog(@"***** startGame ****** \n");
    
    // create snake.
    Body = [[NSMutableArray alloc]init];
    
    for(int i = 0; i < 3; i++){
        SKSpriteNode* node = [[SKSpriteNode alloc] initWithImageNamed:@"body.png"];
        [node setSize:CGSizeMake(10, 10)];
        [node setPosition:CGPointMake(40-10*i,40)];
        [self addChild:node];
        [Body addObject:node];
    }
    
    [self addFood];
    isGameOver = NO;
    isUpdatingBody = NO;
    direction = up;
    score = 0;
    
}

-(void)addFood{
    Food = [[SKSpriteNode alloc] initWithImageNamed:@"food.png"];
    [Food setSize:CGSizeMake(10, 10)];
    int x = arc4random()%width;
    int y = arc4random()%height;
     NSLog(@"x = %d y = %d",x,y);
    [Food setPosition:CGPointMake(10*x, 10*y)];
    [self addChild:Food];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    /*
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
     */
}

-(void)update:(CFTimeInterval)currentTime {
    [self move];
}

-(void)move{
    SKSpriteNode* head = [Body firstObject];
    SKSpriteNode* tail = [Body lastObject];
    CGPoint headPosition = [head position];
    switch (direction) {
        case right:
            headPosition.x += 10;
            if(headPosition.x >= width*10){
                headPosition.x = 0;
            }
            break;
        case left:
            headPosition.x -= 10;
            if(headPosition.x <= -10){
                headPosition.x = (width-1)*10;
            }
            break;
        case up:
            headPosition.y += 10;
            if(headPosition.y >= height*10){
                headPosition.y = 0;
            }
            break;
        case down:
            headPosition.y -= 10;
            if(headPosition.y <= -10){
                headPosition.y = (height-1)*10;
            }
            break;
        default:
            break;
    }
    tail.position = headPosition;
    [self adjustBody];
}

-(void)adjustBody{
    isUpdatingBody = YES;
    
    SKSpriteNode * tail = [Body lastObject];
    [Body removeLastObject];
    [Body insertObject:tail atIndex:0];
    
    isUpdatingBody = NO;
}

@end

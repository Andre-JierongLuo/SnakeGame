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
    SKLabelNode* myLabel;
    SKSpriteNode *upButton;
    SKSpriteNode *downButton;
    SKSpriteNode *rightButton;
    SKSpriteNode *leftButton;
    BOOL isUpdatingBody;
    BOOL isGameOver;
    Direction direction;
    int score;
    int height;
    int width;
    int speed;
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        NSLog(@"****** initWithSize ****** %@ ****** \n", NSStringFromCGSize(size));
        height = size.height / 10;
        width = size.width / 10;
        //NSLog(@"%d %d",height,width);
        myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        myLabel.text = @"Click to Start";
        myLabel.fontSize = 20;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        
        upButton = [[SKSpriteNode alloc] initWithImageNamed:@"food.png"];
        [upButton setSize:CGSizeMake(40, 40)];
        [upButton setPosition:CGPointMake(160, 140)];
        [upButton setName:@"upButton"];
        
        downButton = [[SKSpriteNode alloc] initWithImageNamed:@"food.png"];
        [downButton setSize:CGSizeMake(40, 40)];
        [downButton setPosition:CGPointMake(160, 50)];
        [downButton setName:@"downButton"];
        
        rightButton = [[SKSpriteNode alloc] initWithImageNamed:@"food.png"];
        [rightButton setSize:CGSizeMake(40, 40)];
        [rightButton setPosition:CGPointMake(230, 100)];
        [rightButton setName:@"rightButton"];
        
        leftButton = [[SKSpriteNode alloc] initWithImageNamed:@"food.png"];
        [leftButton setSize:CGSizeMake(40, 40)];
        [leftButton setPosition:CGPointMake(90, 100)];
        [leftButton setName:@"leftButton"];
        
        Food = [[SKSpriteNode alloc] initWithImageNamed:@"Spaceship.png"];
        
        [self startGame];
    }
    return self;
}

-(void)startGame{
    
    if([self children] != nil){
        [self removeAllChildren];
    }
    [self addChild:myLabel];
    [self addChild:upButton];
    [self addChild:downButton];
    [self addChild:rightButton];
    [self addChild:leftButton];
    
    NSLog(@"***** startGame ****** \n");
    
    // create snake.
    Body = [[NSMutableArray alloc]init];
    
    for(int i = 0; i < 3; i++){
        SKSpriteNode* node = [[SKSpriteNode alloc] initWithImageNamed:@"body.png"];
        [node setSize:CGSizeMake(10, 10)];
        [node setPosition:CGPointMake(40-10*i,210)];
        [self addChild:node];
        [Body addObject:node];
    }
    
    [self addFood];
    isGameOver = NO;
    isUpdatingBody = NO;
    direction = right;
    score = 0;
    speed = 15;
    
}

-(void)addFood{
    [Food setSize:CGSizeMake(10, 10)];
    int x = arc4random()%width;
    int y = arc4random()%height;
     NSLog(@"x = %d y = %d",x,y);
    [Food setPosition:CGPointMake(10*x, 10*y)];
    [self addChild:Food];
}
/*
-(void)changeFood{
    int x = arc4random()%width;
    int y = arc4random()%height;
    [Food setPosition:CGPointMake(10*x, 10*y)];
}
 */

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    [myLabel setText:[NSString stringWithFormat:@""]];
    if(isGameOver){
        [self startGame];
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    if ([node.name isEqualToString:@"upButton"]) {
        [self changeDirectionToUp];
    }
    else if ([node.name isEqualToString:@"downButton"]) {
        [self changeDirectionToDown];
    }
    else if ([node.name isEqualToString:@"rightButton"]) {
        [self changeDirectionToRight];
    }
    else if ([node.name isEqualToString:@"leftButton"]) {
        [self changeDirectionToLeft];
    }
    else{}
    
}

-(void)changeDirectionToUp{
    if(direction == down){}
    else {
        direction = up;
    }
}

-(void)changeDirectionToDown{
    if(direction == up){}
    else {
        direction = down;
    }
}

-(void)changeDirectionToRight{
    if(direction == left){}
    else {
        direction = right;
    }
}

-(void)changeDirectionToLeft{
    if(direction == right){}
    else {
        direction = left;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    if(isGameOver){
        return;
    }
    static int count = 0;
    if(score <= 10){
        speed = 15;
    }
    else if(score <= 20){
        speed = 10;
    }
    else if(score <= 30){
        speed = 5;
    }
    else if(score > 30){
        speed = 0;
    }
    else {}
    
    count++;
    if(count >= speed && !isUpdatingBody){
        [self move];
        count = 0;
    }
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
    [self State];
    [self didSnakeEat];
}

-(void)adjustBody{
    isUpdatingBody = YES;
    
    SKSpriteNode* tail = [Body lastObject];
    [Body removeLastObject];
    [Body insertObject:tail atIndex:0];
    
    isUpdatingBody = NO;
}

-(void)State{
    SKSpriteNode* head = [Body firstObject];
    for (int i = 1; i < [Body count]; i++) {
        SKSpriteNode* node = [Body objectAtIndex:i];
        if (CGRectIntersectsRect(head.frame, node.frame)) {
            [myLabel setText:[NSString stringWithFormat:@"Click to Start again."]];
            isGameOver = YES;
        }
    }
}

-(void)didSnakeEat{
    SKSpriteNode* head = [Body firstObject];
    if(CGRectIntersectsRect(head.frame, Food.frame)){
        [Food removeFromParent];
        SKSpriteNode* tail = [Body lastObject];
        CGPoint tailPosition = [tail position];
        switch (direction) {
            case right:
                tailPosition.x -= 10;
                break;
            case left:
                tailPosition.x += 10;
                break;
            case up:
                tailPosition.y -= 10;
                break;
            case down:
                tailPosition.y += 10;
                break;
            default:
                break;
        }
        [self addNode:tailPosition];
        [self addFood];
    }
}

-(void)addNode:(CGPoint)point{
    SKSpriteNode* node = [[SKSpriteNode alloc] initWithImageNamed:@"body.png"];
    [node setSize:CGSizeMake(10, 10)];
    [node setPosition:point];
    [self addChild:node];
    [Body addObject:node];
}

@end

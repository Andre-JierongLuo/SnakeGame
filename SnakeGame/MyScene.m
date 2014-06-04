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
}

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        /*
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Hello, World!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        [self addChild:myLabel];
        */
        NSLog(@"****** initWithSize ****** %@ ****** \n", NSStringFromCGSize(size));
        
        if([self children] != nil){
            [self removeAllChildren];
        }
        [self startGame];
    }
    return self;
}

-(void)startGame{
    NSLog(@"***** startGame ****** \n");
    
    // initialized snake
    Body = [[NSMutableArray alloc]init];
    
    for(int i = 0; i < 3; i++){
        SKSpriteNode* node = [[SKSpriteNode alloc] initWithImageNamed:@"body.png"];
        [node setSize:CGSizeMake(10, 10)];
        [node setPosition:CGPointMake(5, 12*i+30)];
        [self addChild:node];
        [Body addObject:node];
    }
    
    Food = [[SKSpriteNode alloc] initWithImageNamed:@"food.png"];
    [Food setSize:CGSizeMake(10, 10)];
    [Food setPosition:CGPointMake(100, 200)];
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
    /* Called before each frame is rendered */
}

@end

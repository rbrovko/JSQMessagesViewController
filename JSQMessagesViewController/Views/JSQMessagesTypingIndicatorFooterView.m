//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://cocoadocs.org/docsets/JSQMessagesViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQMessagesViewController
//
//
//  License
//  Copyright (c) 2014 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

#import "JSQMessagesCollectionViewDataSource.h"

#import "JSQMessagesTypingIndicatorFooterView.h"

#import "JSQMessageAvatarImageDataSource.h"

#import "JSQMessagesBubbleImageFactory.h"

#import "UIImage+JSQMessages.h"

const CGFloat kJSQMessagesTypingIndicatorFooterViewHeight = 46.0f;


@interface JSQMessagesTypingIndicatorFooterView ()

@property (weak, nonatomic) IBOutlet UIImageView *bubbleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end



@implementation JSQMessagesTypingIndicatorFooterView

#pragma mark - Class methods

+ (UINib *)nib
{
    return [UINib nibWithNibName:NSStringFromClass([JSQMessagesTypingIndicatorFooterView class])
                          bundle:[NSBundle bundleForClass:[JSQMessagesTypingIndicatorFooterView class]]];
}

+ (NSString *)footerReuseIdentifier
{
    return NSStringFromClass([JSQMessagesTypingIndicatorFooterView class]);
}

#pragma mark - Initialization

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = NO;
}

#pragma mark - Reusable view

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.bubbleImageView.backgroundColor = backgroundColor;
}

#pragma mark - Typing indicator

- (void)configureWithEllipsisColor:(UIColor *)ellipsisColor
                messageBubbleColor:(UIColor *)messageBubbleColor
               shouldDisplayOnLeft:(BOOL)shouldDisplayOnLeft
                 forCollectionView:(UICollectionView *)collectionView
{
    NSParameterAssert(ellipsisColor != nil);
    NSParameterAssert(messageBubbleColor != nil);
    NSParameterAssert(collectionView != nil);
    
    id<JSQMessagesCollectionViewDataSource> dataSource = (id<JSQMessagesCollectionViewDataSource>)collectionView.dataSource;
    id<JSQMessageAvatarImageDataSource> avatarDataSource = [dataSource collectionViewAvatarImageDataForTypingIndicator:collectionView];
    self.avatarImageView.image = [avatarDataSource avatarImage];
    
    if (shouldDisplayOnLeft) {
        id<JSQMessageBubbleImageDataSource> bubbleImageDataSource = [dataSource collectionViewMessageBubbleImageDataForTypingIndicator:collectionView];
        self.bubbleImageView.image = [bubbleImageDataSource messageBubbleImage];
    }
    else {
        JSQMessagesBubbleImageFactory *bubbleImageFactory = [[JSQMessagesBubbleImageFactory alloc] init];
        self.bubbleImageView.image = [bubbleImageFactory outgoingMessagesBubbleImageWithColor:messageBubbleColor].messageBubbleImage;
    }
}

@end

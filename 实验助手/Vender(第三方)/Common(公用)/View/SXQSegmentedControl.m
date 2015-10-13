//
//  SXQSegmentedControl.m
//  实验助手
//
//  Created by SXQ on 15/8/31.
//  Copyright (c) 2015年 SXQ. All rights reserved.
//

#import "SXQSegmentedControl.h"
static CGFloat const kButtonSlotWidth =
    64; // Also distance between button centers
static CGFloat const kButtonSlotHeight = 44;
static CGFloat const kBottomLineHeight = 3;

@interface SXQSegmentedControl ()
@property(nonatomic, strong) NSMutableArray *buttons;
@property(nonatomic, weak) UIView *privateButtonsView;
@property(nonatomic, weak) UIView *bottomLine;
@property(nonatomic, strong) NSArray *items;
@property(nonatomic, strong) NSLayoutConstraint *bottomLeadingConstraint;
@end
@implementation SXQSegmentedControl
- (NSMutableArray *)buttons {
  if (!_buttons) {
    _buttons = [@[] mutableCopy];
  }
  return _buttons;
}
- (instancetype)initWithItems:(NSArray *)items {
  if (self = [super init]) {
    _items = items;

    UIView *privateButtonsView = [[UIView alloc] init];
    privateButtonsView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:privateButtonsView];
    _privateButtonsView = privateButtonsView;
    self.backgroundColor = [UIColor whiteColor];
    _privateButtonsView.backgroundColor = [UIColor whiteColor];

    [self addConstraint:[NSLayoutConstraint
                            constraintWithItem:_privateButtonsView
                                     attribute:NSLayoutAttributeCenterX
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeCenterX
                                    multiplier:1.0
                                      constant:0]];
    [self
        addConstraint:[NSLayoutConstraint
                          constraintWithItem:_privateButtonsView
                                   attribute:NSLayoutAttributeWidth
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:nil
                                   attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:1.0
                                    constant:_items.count * kButtonSlotWidth]];
    [self addConstraint:[NSLayoutConstraint
                            constraintWithItem:_privateButtonsView
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1.0
                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint
                            constraintWithItem:_privateButtonsView
                                     attribute:NSLayoutAttributeHeight
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self
                                     attribute:NSLayoutAttributeHeight
                                    multiplier:1.0
                                      constant:0]];
    [self addChildViewControllerButtons];
    self.selectedSegmentIndex = 0;

    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.translatesAutoresizingMaskIntoConstraints = NO;
    bottomLine.backgroundColor =
        [UIColor colorWithRed:0.0 green:122 / 255.0 blue:255 / 255.0 alpha:1.0];
    [_privateButtonsView addSubview:bottomLine];
    _bottomLine = bottomLine;
    [self setupBottomLine];
  }
  return self;
}
- (void)setupBottomLine {
  UIButton *firstBtn = [self.buttons firstObject];
  NSLayoutConstraint *bottomLeadingConstraint =
      [NSLayoutConstraint constraintWithItem:_bottomLine
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:firstBtn
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1.0
                                    constant:0];
  _bottomLeadingConstraint = bottomLeadingConstraint;
  [_privateButtonsView addConstraint:_bottomLeadingConstraint];
  [_privateButtonsView
      addConstraint:[NSLayoutConstraint
                        constraintWithItem:_bottomLine
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:firstBtn
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0]];
  [_privateButtonsView
      addConstraint:[NSLayoutConstraint
                        constraintWithItem:_bottomLine
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:firstBtn
                                 attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                  constant:0]];
  [_privateButtonsView
      addConstraint:[NSLayoutConstraint
                        constraintWithItem:_bottomLine
                                 attribute:NSLayoutAttributeHeight
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1.0
                                  constant:kBottomLineHeight]];
}
- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
  NSAssert(selectedSegmentIndex < _privateButtonsView.subviews.count, @"");
  UIButton *currentBtn = _privateButtonsView.subviews[_selectedSegmentIndex];
  UIButton *selectedBtn = _privateButtonsView.subviews[selectedSegmentIndex];

  currentBtn.selected = NO;
  selectedBtn.selected = YES;

  if (_selectedSegmentIndex == selectedSegmentIndex) {
    return;
  }
  _selectedSegmentIndex = selectedSegmentIndex;
  [self layoutIfNeeded];
  [self.privateButtonsView setNeedsUpdateConstraints];
  [self.privateButtonsView updateConstraintsIfNeeded];
  [UIView animateWithDuration:0.5
                        delay:0.0f
                      options:UIViewAnimationOptionLayoutSubviews
                   animations:^{
                     [self updateConstraints];
                     [self layoutIfNeeded];
                   }
                   completion:nil];
}
- (void)updateConstraints {
  CGFloat travelDistance = _selectedSegmentIndex * kButtonSlotWidth;
  UIButton *button = self.buttons[_selectedSegmentIndex];
  CGFloat width = button.frame.size.width;
  _bottomLeadingConstraint.constant = travelDistance;
  [super updateConstraints];
}
- (void)addChildViewControllerButtons {
  [self.items enumerateObjectsUsingBlock:^(NSString *item, NSUInteger idx,
                                           BOOL *stop) {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:14];

    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    [button setTitle:item forState:UIControlStateNormal];
    button.tag = idx;
    [button addTarget:self
                  action:@selector(p_buttonTapped:)
        forControlEvents:UIControlEventTouchUpInside];

    [_privateButtonsView addSubview:button];
    [self.buttons addObject:button];

    button.translatesAutoresizingMaskIntoConstraints = NO;

    [_privateButtonsView
        addConstraint:[NSLayoutConstraint
                          constraintWithItem:button
                                   attribute:NSLayoutAttributeCenterX
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_privateButtonsView
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1.0
                                    constant:(idx + 0.5f) * kButtonSlotWidth]];
    [_privateButtonsView
        addConstraint:[NSLayoutConstraint
                          constraintWithItem:button
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_privateButtonsView
                                   attribute:NSLayoutAttributeTop
                                  multiplier:1.0
                                    constant:0]];
    [_privateButtonsView
        addConstraint:[NSLayoutConstraint
                          constraintWithItem:button
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_privateButtonsView
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1.0
                                    constant:-kBottomLineHeight]];
    [_privateButtonsView
        addConstraint:[NSLayoutConstraint
                          constraintWithItem:button
                                   attribute:NSLayoutAttributeWidth
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:nil
                                   attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:1.0
                                    constant:kButtonSlotWidth]];
  }];
}
- (void)p_buttonTapped:(UIButton *)button {
  [self setSelectedSegmentIndex:button.tag];
}
- (void)layoutSubviews {
  [super layoutSubviews];
}
@end

//
//  ViewController.m
//  wave
//
//  Created by Yvan Scher on 9/19/14.
//  Copyright (c) 2014 Yvan Scher. All rights reserved.
//

#import "ViewSearchController.h"
@import MultipeerConnectivity;

@interface ViewController () <MCSessionDelegate, MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate>

@property (nonatomic) MCNearbyServiceAdvertiser *autoadvertiser;
@property (nonatomic) MCNearbyServiceBrowser *autobrowser;
@property (nonatomic) MCPeerID *localpeerID;
@property (nonatomic) MCSession *session;
@property (nonatomic) UIDevice *device;
@property (nonatomic) NSString *uniqueIdentifier;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //START ADVERTISING OUR PRESENCE TO PEERS (handleStartAdvertisingButtonPressed)
    //START SEARCHING FOR PEERS (handleFindPeersButton), SOON AS WE FIND ONE CONNECT.
    //CAN WE DO BOTH AT THE SAME TIME??
    //WE DO ALL THIS IN THE viewDidLoad bec. we want it to be automatic on view load.
    
    //THIS NEXT PART STARTS ADVERTISING
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *displayName = [NSString stringWithFormat: @"Wave-Device-%@", uniqueIdentifier];
    _localpeerID = [[MCPeerID alloc] initWithDisplayName:displayName];
    _session = [[MCSession alloc] initWithPeer:_localpeerID];
    _session.delegate = self;
    
    //WHAT IS DISCOVERY INFO???
    _autoadvertiser = [[MCNearbyServiceAdvertiser alloc] initWithPeer:_localpeerID discoveryInfo:nil serviceType:@"wave-msg"];
    _autoadvertiser.delegate = self;
    [_autoadvertiser startAdvertisingPeer];
    
    //THIS NEXT PART SEARCHES FOR OTHER PEERS WHO ARE ADVERTISING THEMSELVES.
    _autobrowser = [[MCNearbyServiceBrowser alloc] initWithPeer:_localpeerID serviceType:@"wave-msg"];
    _autobrowser.delegate = self;
    [_autobrowser startBrowsingForPeers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//BROWSER DELEGATE METHOD THAT IDENTIFIES WHEN WE HAVE FOUND A PEER
- (void)browser:(MCNearbyServiceBrowser *)browser
      foundPeer:(MCPeerID *)peerID
withDiscoveryInfo:(NSDictionary *)info{
    
    
}
//BROWSER DELEGATE METHOD THAT IDENTIFIES WHEN WE HAVE LOST OUR CONNECTION TO THE PEER
- (void)browser:(MCNearbyServiceBrowser *)browser
       lostPeer:(MCPeerID *)peerID{
    
}
//ADVERTISING DELEGATE METHOD THAT IDENTIFIES WHEN WE RECEIVE AND INVITE FROM A PEER
- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser
didReceiveInvitationFromPeer:(MCPeerID *)peerID
       withContext:(NSData *)context
 invitationHandler:(void (^)(BOOL accept,
                             MCSession *session))invitationHandler{
    
    
}

//NEXT THREE METHODS ARE EMPTY SESSION DELEGATE METHODS
//WE IMPLEMENT THEM EMPTY JUST CUZ WE HAVE NO USE FOR THEM AS IS.
// Remote peer changed state
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state
{
    
}

// Received data from remote peer
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID
{
    
    
}

// Received a byte stream from remote peer
- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID
{
    
}

// Start receiving a resource from remote peer
- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress
{
    
}


// Finished receiving a resource from remote peer and saved the content in a temporary location - the app is responsible for moving the file to a permanent location within its sandbox
- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error
{
    
}

@end

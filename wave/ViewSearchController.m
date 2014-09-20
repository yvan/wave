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

//SEEDER AND LEECHER FOR ADVERTISER/SEARCHER
@property (nonatomic) MCNearbyServiceAdvertiser *autoadvertiser;
@property (nonatomic) MCNearbyServiceBrowser *autobrowser;
@property (nonatomic) MCPeerID *localpeerID;
@property (nonatomic) MCSession *session;
@property (nonatomic) NSMutableArray *connectedpeersArray;
@property (nonatomic) NSInteger peerArrayIndex;

@end

@implementation ViewController

//ADVERTISE AND CONNECT TO PEERS AUTOMATICALLY
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //WE WANT TO START FILLING IN OUR PEER ARRAY AT THE 0th INDEX
    _peerArrayIndex = 0;
    
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
    
    /*//THIS NEXT PART SEARCHES FOR OTHER PEERS WHO ARE ADVERTISING THEMSELVES.
    _autobrowser = [[MCNearbyServiceBrowser alloc] initWithPeer:_localpeerID serviceType:@"wave-msg"];
    _autobrowser.delegate = self;
    [_autobrowser startBrowsingForPeers];*/
    
    _textDisplayField.text = @"VIEW DID LOAD";
}

//BROWSER DELEGATE METHOD THAT IDENTIFIES WHEN WE HAVE FOUND A PEER, GETS CALLED WHEN PEER IS FODUN BY AUTOBROWSER OBJECT
- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info{
    
    //CONNECT TO THE PEER AND INVITE TO SESSION
    NSString *contextString = @"wave-msg";
    NSData *context = [contextString dataUsingEncoding:NSUTF8StringEncoding]; //ARBITRARY CONTEXT (EXTRA DATA PASSED TO USER) here = to serviceType
    [_autobrowser invitePeer:peerID toSession:_session withContext:context timeout:30];
    
    //ADD A PEER TO THE ARRAY OF PEERS WE ARE CONNECTED TO
    _peerArrayIndex++;
    _connectedpeersArray[_peerArrayIndex] = peerID;
    
    _textDisplayField.text = @"FOUND PEER";
    
}








//ADVERTISING DELEGATE METHOD THAT IDENTIFIES WHEN WE RECEIVE AND INVITE FROM A PEER
- (void)advertiser:(MCNearbyServiceAdvertiser *)advertiser didReceiveInvitationFromPeer:(MCPeerID *)peerID withContext:(NSData *)context

 invitationHandler:(void (^)(BOOL accept, MCSession *session))invitationHandler{
    

    
    
    
    
    
    
    
    
    
    
    
}

// RECEIVED DATA FROM REMOTE PEER - GONNA DISPLAY DATA IN OUR TEXTFIELD HERE
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
    
    NSString *message =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    _textDisplayField.text = [NSString stringWithFormat:@"RECIVED MESSAGE ON THIS PHONE: %@",message];
}

//SENDS
-(void)handleSearchButtonPressed:(id)sender{
    
    NSString *searchText = _searchBar.text;
    NSData *data = [searchText dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    
    if([_session sendData:data toPeers:_connectedpeersArray withMode:MCSessionSendDataReliable error:&error]){
        
        _textDisplayField.text = @"DATA SEND FROM THIS PHONE";
    }
    else{
        
        _textDisplayField.text = [NSString stringWithFormat:@"%@", error];
    }
}

//BROWSER DELEGATE METHOD THAT IDENTIFIES WHEN WE CAN NO LONGER LOCATE A PEER
- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID{
    
}

/******
 UNUSED/UNIMPLEMENTED SECTION
 ******
 NEXT THREE METHODS ARE EMPTY SESSION DELEGATE METHODS
 WE IMPLEMENT THEM EMPTY JUST CUZ WE HAVE NO USE FOR THEM AS IS.
 WE IMPLEMENT didReceiveData BEC. DUH
 
******/

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//REMOTE PEER HAS ALTERED ITS STATE SOMEHOW
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    
}

// RECEIVED BYTE STREAM FROM REMOTE PEER
- (void)session:(MCSession *)session didReceiveStream:(NSInputStream *)stream withName:(NSString *)streamName fromPeer:(MCPeerID *)peerID{
    
    
}

// STARTED RECEIVING RESOURCE FROM REMOTE PEER
- (void)session:(MCSession *)session didStartReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID withProgress:(NSProgress *)progress{
    
    
}

// FINISHED RECEIVING A RESOURCE FROM REMOTE PEER
- (void)session:(MCSession *)session didFinishReceivingResourceWithName:(NSString *)resourceName fromPeer:(MCPeerID *)peerID atURL:(NSURL *)localURL withError:(NSError *)error{
    
    
}
@end

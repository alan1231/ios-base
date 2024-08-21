import WebRTC

class WebRTCPullClient: NSObject {
    private var peerConnection: RTCPeerConnection?
    private var videoTrack: RTCVideoTrack?
    private var remoteVideoView: RTCMTLVideoView
    
    init(remoteVideoView: RTCMTLVideoView) {
        self.remoteVideoView = remoteVideoView
        super.init()
        setupPeerConnection()
    }
    
    private func setupPeerConnection() {
        let config = RTCConfiguration()
        config.iceServers = [RTCIceServer(urlStrings: ["stun:stun.l.google.com:19302"])]
        
        let constraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
        let factory = RTCPeerConnectionFactory()
        
        self.peerConnection = factory.peerConnection(with: config, constraints: constraints, delegate: self)
    }
    
    func handleRemoteSDP(_ sdp: RTCSessionDescription) {
        peerConnection?.setRemoteDescription(sdp, completionHandler: { [weak self] error in
            if let error = error {
                print("Failed to set remote SDP: \(error)")
                return
            }
            self?.createAnswer()
        })
    }
    
    private func createAnswer() {
        let constraints = RTCMediaConstraints(mandatoryConstraints: nil, optionalConstraints: nil)
        
        peerConnection?.answer(for: constraints, completionHandler: { [weak self] sdp, error in
            if let error = error {
                print("Failed to create answer: \(error)")
                return
            }
            
            guard let sdp = sdp else { return }
            
            self?.peerConnection?.setLocalDescription(sdp, completionHandler: { error in
                if let error = error {
                    print("Failed to set local SDP: \(error)")
                }
                // 發送 answer SDP 給對方
            })
        })
    }
    
    func handleRemoteCandidate(_ candidate: RTCIceCandidate) {
        peerConnection?.add(candidate)
    }
}

extension WebRTCPullClient: RTCPeerConnectionDelegate {
    func peerConnection(_ peerConnection: RTCPeerConnection, didOpen dataChannel: RTCDataChannel) {
        print("Signaling state changed: \(dataChannel)")

    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange stateChanged: RTCSignalingState) {
        print("Signaling state changed: \(stateChanged.rawValue)")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didAdd stream: RTCMediaStream) {
        if let track = stream.videoTracks.first {
            self.videoTrack = track
            DispatchQueue.main.async { [weak self] in
                track.add(self!.remoteVideoView)
            }
        }
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove stream: RTCMediaStream) {
        if let track = stream.videoTracks.first {
            track.remove(remoteVideoView)
        }
    }
    
    func peerConnectionShouldNegotiate(_ peerConnection: RTCPeerConnection) {
        print("Should negotiate")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceConnectionState) {
        print("ICE connection state changed: \(newState.rawValue)")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didChange newState: RTCIceGatheringState) {
        print("ICE gathering state changed: \(newState.rawValue)")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didGenerate candidate: RTCIceCandidate) {
        // 發送 ICE Candidate 給對方
        print("Generated new ICE candidate: \(candidate.sdp)")
    }
    
    func peerConnection(_ peerConnection: RTCPeerConnection, didRemove candidates: [RTCIceCandidate]) {
        print("Removed ICE candidates")
    }
}

// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/

import AVFoundation
import CAudioKit

/// This node outputs a version of the audio source, amplitude-modified so
/// that its rms power is equal to that of the comparator audio source. Thus a
/// signal that has suffered loss of power (eg., in passing through a filter
/// bank) can be restored by matching it with, for instance, its own source. It
/// should be noted that this modifies amplitude only; output signal is not
/// altered in any other respect.
///
public class Balancer: Node, AudioUnitContainer, Toggleable {

    /// Unique four-letter identifier "blnc"
    public static let ComponentDescription = AudioComponentDescription(mixer: "blnc")

    /// Internal type of audio unit for this node
    public typealias AudioUnitType = AudioUnitBase

    /// Internal audio unit
    public private(set) var internalAU: AudioUnitType?

    // MARK: - Initialization

    /// Initialize this balance node
    ///
    /// - Parameters:
    ///   - input: Input node to process
    ///   - comparator: Audio to match power with
    ///
    public init(_ input: Node, comparator: Node) {
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit2 { avAudioUnit in
            self.avAudioUnit = avAudioUnit
            self.avAudioNode = avAudioUnit
            self.internalAU = avAudioUnit.auAudioUnit as? AudioUnitType
        }

        connections.append(input)
        connections.append(comparator)
    }
}


import Cocoa
import AVFoundation

// Keep playground running
import XCPlayground
XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)

// Setup engine and node instances
var engine = AVAudioEngine()
var mixer = engine.mainMixerNode
var output = engine.outputNode
var player = AVAudioPlayerNode()
var delay = AVAudioUnitDelay()
var reverb = AVAudioUnitReverb()

var error:NSError?

engine.attachNode(player)

engine.connect(player, to: mixer, format: mixer.outputFormatForBus(0))

// Start engine
engine.startAndReturnError(&error)


// load snare
let snareURL = NSBundle.mainBundle().URLForResource("snare", withExtension: "wav")
let snare = AVAudioFile(forReading: snareURL, error: &error)

let kickURL = NSBundle.mainBundle().URLForResource("kick", withExtension: "wav")
let kick = AVAudioFile(forReading: kickURL, error: &error)


for _ in 1...4 {
    
    player.scheduleFile(kick, atTime:nil, completionHandler:nil)
    
    player.scheduleFile(snare, atTime:nil, completionHandler:nil)
}

player.play()




/*

var mixer = engine.mainMixerNode
var input = engine.inputNode
var output = engine.outputNode



// Attach FX nodes to engine
engine.attachNode(delay)
engine.attachNode(reverb)

// Connect nodes
engine.connect(input, to: delay, format: format)
engine.connect(delay, to: reverb, format: format)
engine.connect(reverb, to: output, format: format)

// Start engine
engine.startAndReturnError(&error)

// Change FX parameters
delay.delayTime = 0.3
delay.feedback = 80




// Keep playground running
import XCPlayground
XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)

*/




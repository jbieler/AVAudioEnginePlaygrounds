
import Cocoa
import AVFoundation

// Keep playground running
import XCPlayground
//XCPSetExecutionShouldContinueIndefinitely(continueIndefinitely: true)

// Setup engine and node instances
var engine = AVAudioEngine()
var mixer = engine.mainMixerNode
var output = engine.outputNode
var player = AVAudioPlayerNode()
var delay = AVAudioUnitDelay()
var reverb = AVAudioUnitReverb()
var eq = AVAudioUnitEQ(numberOfBands: 2)
var format = mixer.outputFormatForBus(0)

reverb.wetDryMix = 0

var filterParams = eq.bands[0] as AVAudioUnitEQFilterParameters
filterParams.filterType = AVAudioUnitEQFilterType.HighPass
        filterParams.frequency = 0.0 // LOWS KNOB
        filterParams.gain = 1
        filterParams.bypass = false
        
filterParams = eq.bands[1] as AVAudioUnitEQFilterParameters
filterParams.filterType = AVAudioUnitEQFilterType.LowPass
filterParams.frequency = 16000 //HIGHS KNOB
filterParams.gain = 1
filterParams.bypass = false



var error:NSError?

engine.attachNode(player)
engine.attachNode(reverb)
engine.attachNode(eq)


engine.connect(player, to: eq, format: format)
engine.connect(eq, to: reverb, format: format)
engine.connect(reverb, to: mixer, format: format)

// Start engine
engine.startAndReturnError(&error)


// load snare
let trackURL = NSBundle.mainBundle().URLForResource("Coyu & Ramiro Lopez - 1, 2, 3 . . .Fire (Bontan Remix)", withExtension: "mp3")
let track = AVAudioFile(forReading: trackURL, error: &error)

    
player.scheduleFile(track, atTime:nil, completionHandler:nil)
    

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




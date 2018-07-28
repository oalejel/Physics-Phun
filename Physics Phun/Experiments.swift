//
//  Experiments.swift
//  Physics Phun
//
//  Created by Omar Al-Ejel on 7/22/18.
//  Copyright © 2018 omaralejel. All rights reserved.
//

import Foundation

// This class nicely contains all of our themes, which each contain an array of simulations
// Each simulation is then associated with its title and view controller
class Experiments {
    static var list = [
        MotionAndForcesTheme(),
        GasesTheme(),
        ElectricalTheme()
    ]
}

//////////////////////////////////////////

class Simulation {
    var name: String
    var controllerClass: AnyClass
    
    init(name: String, controllerClass: AnyClass) {
        self.name = name
        self.controllerClass = controllerClass
    }
}

class SimulationTheme {
    var simulations: [Simulation]
    var title: String
    
    init(title: String, simulations: [Simulation]) {
        self.simulations = simulations
        self.title = title
    }
}

class MotionAndForcesTheme: SimulationTheme {
    init() {
        super.init(title: "Motion and Forces 🚀", simulations: [
            Simulation(name: "Cannon", controllerClass: CannonPhsyicsController.self),
            Simulation(name: "The Flying Donut", controllerClass: DonutPhsyicsController.self),
            Simulation(name: "Gears", controllerClass: GearsPhysicsController.self)
        ])
    }
}

class GasesTheme: SimulationTheme {
    init() {
        super.init(title: "Gases 🌫", simulations: [
            Simulation(name: "Air Box", controllerClass: AirBoxPhsyicsController.self)
        ])
    }
}

class ElectricalTheme: SimulationTheme {
    init() {
        super.init(title: "Electricity & Circuits ⚡️", simulations: [
            Simulation(name: "Circuit VIRP", controllerClass: VIRPPhsyicsController.self),
            Simulation(name: "Resistivity", controllerClass: ResistivityPhsyicsController.self),
        ])
    }
}


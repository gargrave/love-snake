require('src.gg.lib.__init__')

gg = {
    Entity = require('src.gg.core.entity'),
    GameObject = require('src.gg.core.game-object'),
    GameState = require('src.gg.core.game-state'),
    Input = require('src.gg.core.input'),
    Messages = require('src.gg.core.messages'),
    StateMachine = require('src.gg.core.state-machine'),

    Rect = require('src.gg.math.rect'),
    Vector = require('src.gg.math.vector'),

    TextMenu = require('src.gg.gui.text-menu'),

    utils = require('src.gg.utils')
}

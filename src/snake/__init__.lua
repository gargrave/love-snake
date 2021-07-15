local Assets = require('src.snake.assets')
Assets.load()

sn = {
    Assets = Assets,

    Color = require('src.snake.config.colors'),
    Globals = require('src.snake.config.globals'),
    State = require('src.snake.config.game-states'),
    InputMap = require('src.snake.config.input-map'),

    Food = require('src.snake.entities.food'),
    Grid = require('src.snake.entities.grid'),
    Player = require('src.snake.entities.player'),

    GameOverState = require('src.snake.states.game-over-state'),
    MainState = require('src.snake.states.main-state'),
    PausedState = require('src.snake.states.paused-state'),
    TitleState = require('src.snake.states.title-state')
}

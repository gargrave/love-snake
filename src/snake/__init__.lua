local Assets = require('src.snake.assets')
Assets.load()

sn = {
    Assets = Assets,

    Color = require('src.snake.config.color'),
    Globals = require('src.snake.config.globals'),
    State = require('src.snake.config.game-state'),
    InputAction = require('src.snake.config.input-action'),

    Food = require('src.snake.entities.food'),
    Player = require('src.snake.entities.player'),

    GameOverState = require('src.snake.states.game-over'),
    GameState = require('src.snake.states.game'),
    PausedState = require('src.snake.states.paused')
}

local Assets = require('src.snake.assets')
Assets.load()

sn = {
    Assets = Assets,

    Color = require('src.snake.config.colors'),
    Globals = require('src.snake.config.globals'),
    Message = require('src.snake.config.messages'),
    State = require('src.snake.config.game-states'),
    InputMap = require('src.snake.config.input-map'),

    DriftyText = require('src.snake.entities.drifty-text'),
    Food = require('src.snake.entities.food'),
    GameUi = require('src.snake.entities.game-ui'),
    Grid = require('src.snake.entities.grid'),
    Player = require('src.snake.entities.player'),

    GameOverState = require('src.snake.states.game-over-state'),
    MainState = require('src.snake.states.main-state'),
    PausedState = require('src.snake.states.paused-state'),
    TitleState = require('src.snake.states.title-state'),

    Score = require('src.snake.core.score')
}

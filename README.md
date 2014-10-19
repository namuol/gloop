# gloop [![Build Status](https://drone.io/github.com/gitsubio/gloop/status.png)](https://drone.io/github.com/gitsubio/gloop/latest) [![dependency Status](https://david-dm.org/gitsubio/gloop/status.svg?style=flat-square)](https://david-dm.org/gitsubio/gloop) [![devDependency Status](https://david-dm.org/gitsubio/gloop/dev-status.svg?style=flat-square)](https://david-dm.org/gitsubio/gloop#info=devDependencies)

Gloop is a [fixed timestep](http://gafferongames.com/game-physics/fix-your-timestep/) game loop manager,
decoupling `frame` events from game `tick` events.

This allows for deterministic behavior even with variable framerates.

**NOTE:** This has not been battle tested yet; use at your own risk. (And please [report issues](http://github.com/gitsubio/gloop/issues))

```js
var gloop = require('gloop')();

// Or...

var gloop = require('gloop')({
  ticksPerSecond: 300
});

// gloop mostly emits events

gloop.on('tick', function (dt) {
  // Update logic goes here
  console.log('In-game milliseconds since last tick:', dt);
});

gloop.on('frame', function (t) {
  // Render logic goes here
  // `t` is a value between 0 and 1 representing the current
  //  temporal position between ticks; use this to interpolate
  //  rendered motion, if you want. This is especially useful
  //  if you're using gloop.timeScale for dramatic slow-motion
  //  effects.
  console.log('Delta between ticks:', t);
});

gloop.on('start', function () {
  console.log('game loop started');
});

gloop.on('stop', function () {
  console.log('game loop stopped');
});

// Begin/resume looping:
gloop.start();

// Run things in slow-motion:
gloop.timeScale = 0.5;

// Or high-speed:
gloop.timeScale = 2;

// Pause/stop looping:
gloop.stop();
```

## License

MIT

## Install

```bash
npm install gloop --save
```

----

[![Analytics](https://ga-beacon.appspot.com/UA-33247419-2/gloop/README.md)](https://github.com/igrigorik/ga-beacon)

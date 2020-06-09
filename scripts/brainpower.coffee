COMMANDS = 
[
  { input: /are you ready/i, reply: 'hmm?'},
  { input: /adrenaline is pumpin/i, reply: 'adrenaline... is pumpin!'},
  { input: /generator/i, reply: 'automatic lover'},
  { input: /atomic/i, reply: 'ATOMIC'},
  { input: /overdrive/i, reply: 'blockbuster'},
  { input: /call me leader/i, reply: '..cocaine?'},
  { input: /dont you try it/i, reply: 'DONT YOU TRY IT'},
  { input: /innovator/i, reply: null},
  { input: /killer machine/i, reply: null },
  { input: /theres no fate/i, reply: null},
  { input: /take control/i, reply: '(are you serious?)'},
]

SEQUENCE = 
[
 /are you ready/i.toString(),
 /adrenaline is pumpin/i.toString(),
 /generator/i.toString(),
 /atomic/i.toString(),
 /overdrive/i.toString(),
 /call me leader/i.toString(),
 /dont you try it/i.toString(),
 /innovator/i.toString(),
 /killer machine/i.toString(),
 /theres no fate/i.toString(),
 /take control/i.toString(),
 /brainpower/i.toString()
]

BRAINPOWER = [
  { text: 'Let', timeout: 600 },
  { text: 'the', timeout: 600 },
  { text: 'bass', timeout: 600 },
  { text: 'Kick!', timeout: 600 },
  { text: 'Oooooooo ', timeout: 1000 },
  { text: 'AAA ', timeout: 200 },
  { text: 'E A A I A U', timeout: 200 },
  { text: 'JOooooo ', timeout: 500 },
  { text: 'AA ', timeout: 200 },
  { text: 'E O A A U U A', timeout: 200 },
  { text: 'Eeeeeeeee ', timeout: 500 },
  { text: 'AA E A E I E A', timeout: 200 },
  { text: 'JOooooo ', timeout: 500 },
  { text: 'EE O A AA AAA', timeout: 200 },
  { text: 'Oooooooo ', timeout: 500 },
  { text: 'AAA E A A I A U', timeout: 200 },
  { text: 'JOooooo ', timeout: 500 },
  { text: 'AA E O A A U U A', timeout: 200 },
  { text: 'Eeeeeeeee ', timeout: 500 },
  { text: 'AA E A E I E A', timeout: 200 },
  { text: 'JOooooo ', timeout: 500 },
  { text: 'EE O A AA AAA', timeout: 200 },
  { text: 'Oooooooo ', timeout: 500 },
  { text: 'AAA E A A I A U', timeout: 200 },
  { text: 'JOooooo ', timeout: 500 },
  { text: 'AA E O A A U U A', timeout: 200 },
  { text: 'Eeeeeeeee ', timeout: 500 },
  { text: 'AA E A E I E A', timeout: 200 },
  { text: 'JOooooo ', timeout: 500 },
  { text: 'EE O A AA AAA', timeout: 200 },
  { text: 'Ohhhhhhhhh', timeout: 500 }
]

class BrainPower 

  constructor: (@res, @robot) ->
    @song = []

  loadSong: () =>
    @song = BRAINPOWER.map (x) => x

  sing: () =>
    line = @song.shift()
    if line == undefined
      @robot.brain.set('SEQUENCE', 0)
      return
    # console.debug("Unshifting", line.text)
    @res.send line.text

    setTimeout(@sing, line.timeout)

module.exports = (robot) ->

  prepare = (command) =>
    robot.hear command.input, (res) ->
      seq = robot.brain.get('SEQUENCE') * 1 or 0
      return if command.input.toString() != SEQUENCE[seq]

      robot.brain.set('SEQUENCE', seq + 1)
      return if command.reply == null
      
      res.send command.reply

  prepare(command) for command in COMMANDS

  robot.hear /brainpower/i, (res) ->
    seq = robot.brain.get('SEQUENCE') * 1 or 0
    return if /brainpower/i.toString() != SEQUENCE[seq]
    res.send 'BRAINPOWER!'
    bp = new BrainPower(res, robot)
    bp.loadSong()
    bp.sing()

  robot.respond /reset bp seq/, (res)->
    robot.brain.set('SEQUENCE', 0)
    res.reply 'OK'

  robot.hear /bp seq/, (res)->
    res.send robot.brain.get('SEQUENCE')

  robot.hear /hooooli/, (res)->
    robot.brain.set('SEQUENCE', 0)
# Description:
#   Allows Hubot to update scripts from GitHub rweekly/misc
#
# Commands:
#   hubot update-scripts - Update scripts from GitHub rweekly/misc
#
# Author:
#   R Weekly

Fs       = require 'fs'
Path     = require 'path'

exec = require('child_process').exec

module.exports = (robot) ->
  robot.respond /update-scripts/i, id:'update-scripts.reload',  (msg) ->
    try
      hubot_dir = process.env.hubot_dir
      runs = "cd " + hubot_dir + "; rm -r ./misc ./scripts; git clone https://github.com/rweekly/misc ; cp ./misc/rbot/* ./scripts"
      exec runs,
      (error, stdout, stderr) ->
        if error
          msg.send "Sorry, update-scripts failed: #{error} \n\n" + stderr.trim()
        else
          msg.send "Updated from rweekly/misc"
    catch error
      robot.logger.error "Hubot update-scripts: #{error}"
      msg.send "Could not update-scripts: #{error}"

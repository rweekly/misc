# Description:
#   Allows Hubot to update R Weekly cache
#
# Commands:
#   hubot update-cache <url> - `update-cache https://rweekly.org/2017-1.html`
#
# Author:
#   R Weekly

Fs       = require 'fs'
Path     = require 'path'

exec = require('child_process').exec

module.exports = (robot) ->
  robot.respond /update-cache (.*)/i, id:'update-cache.reload',  (msg) ->
    try
      hubot_dir = process.env["HUBOT_DIR"]
      rweekly_email = process.env["RWEEKLY_EMAIL"]
      rweekly_key = process.env["RWEEKLY_KEY"]
      rweekly_url = process.env["RWEEKLY_URL"]
      url = msg.match[1]
      data = JSON.stringify({
        files: [url]
      })
      robot.http(rweekly_url)
        .header('Content-Type', 'application/json')
        .header('X-Auth-Email', rweekly_email )
        .header('X-Auth-Key', rweekly_key)
        .del(data) (err, res, body) ->
          if res.statusCode isnt 200
            robot.logger.error "Hubot update-scripts: #{body}"
            msg.send "Request came back HTTP #{res.statusCode} :("
            return
          msg.send "Done, #{url} updated, cmd + shift + R to refresh web page"
    catch error
      robot.logger.error "Hubot update-scripts: #{error}"
      msg.send "Could not update-scripts: error"

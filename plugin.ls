/* Adapted by Elizabeth Marston from npm://wintersmith-stylus, which in turn is by Jon Wong. (c) 2013 MIT License */


require! {
  async
  fs
  ls: LiveScript
}


module.exports = (env, done) ->
  class Wsls extends env.Content-plugin
    (@filepath, @text) ->
      return
    get-filename: ->
      @filepath.relative.replace /ls$/, 'js'
    get-view: -> (env, locals, contents, templates, callback) ->
      try
        callback null new Buffer ls.compile(@text)
      catch
        callback e
    @from-file = (filepath, callback) ->
      (e,r) <- fs.read-file filepath.full
      if e
        callback e
      else
        callback null new Wsls filepath, buffer.to-string!

  env.register-content-plugin 'scripts' '**/*.ls' Wsls
  done!

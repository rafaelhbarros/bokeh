_ = require "underscore"
Marker = require "./marker"

class CircleCrossView extends Marker.View

  _render: (ctx, indices, {sx, sy, size, angle}) ->
    for i in indices
      if isNaN(sx[i]+sy[i]+size[i]+angle[i])
        continue

      r = size[i]/2

      ctx.beginPath()
      ctx.translate(sx[i], sy[i])

      ctx.arc(0, 0, r, 0, 2*Math.PI, false)

      if @visuals.fill.doit
        @visuals.fill.set_vectorize(ctx, i)
        ctx.fill()

      if @visuals.line.doit
        @visuals.line.set_vectorize(ctx, i)
        if angle[i]
          ctx.rotate(angle[i])
        ctx.moveTo( 0,  r)
        ctx.lineTo( 0, -r)
        ctx.moveTo(-r,  0)
        ctx.lineTo( r,  0)
        if angle[i]
          ctx.rotate(-angle[i])
        ctx.stroke()

      ctx.translate(-sx[i], -sy[i])

class CircleCross extends Marker.Model
  default_view: CircleCrossView
  type: 'CircleCross'

module.exports =
  Model: CircleCross
  View: CircleCrossView

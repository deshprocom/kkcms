#= require active_admin/base
#= require simditor
#= require jquery.remotipart
#= require best_in_place
#= require jquery.colorbox-min
#= require fancybox
#= require jquery.Jcrop
#= require_tree ./admin
#= require_tree ./shop
$(document).ready ->
  jQuery(".best_in_place").best_in_place()

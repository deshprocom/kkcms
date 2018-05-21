#= require active_admin/base
#= require simditor
#= require jquery.remotipart
#= require best_in_place
#= require fancybox
#= require_tree ./admin
$(document).ready ->
  jQuery(".best_in_place").best_in_place()

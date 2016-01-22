
var
  gulp $ require :gulp

gulp.task :rsync $ \ (cb)
  var
    wrapper $ require :rsyncwrapper
  wrapper
    {}
      :ssh true
      :src $ array :presentation.html :theme
      :recursive true
      :args $ array :--verbose
      :dest :tiye:~/repo/100offer-sharing/
      :deleteAll true
    \ (error stdout stderr cmd)
      if (? error)
        do $ throw error
      console.error stderr
      console.log cmd
      cb

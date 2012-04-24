# Introducing the maygion-ipcam gem

    require 'maygion-ipcam'

    cam = MayGionIPCam.new(username: 'user', password: 'user', addr: '192.168.1.14')
    cam.left
    cam.right
    cam.up
    cam.down

This gem controls the rotation, and tilt of the MayGion IP Camera.

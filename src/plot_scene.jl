function user_view(scene; point = [0.0, 0.0, 0.0], zoom_step = 2, rotation = Quaternionf0(0.0, 0.0, 1.0, 0.0))
    # attempt 1
    # point = [0.0, 0.0, 0.0]
    # zoom_step = 2
    # zoom!(scene, point, zoom_step, false)
    # rotate!(scene, rotation)
    # attempt 2
    # zoom!(scene, [0.0, 0.0, 0.0], 2, true)
    eyepos = Vec3f0(0.0005, 0.0005, 0.01) # wo steht die cam
    lookat = Vec3f0(0, 0, 0) # auf welchen Punkt schaut die cam
    update_cam!(scene, eyepos, lookat)
    # save("out.png", scene)
    # save("testbild10.jpeg", scene, resolution = (1920,1080))
end

function axis_appearance(scene; fontsize = 10)
    # axis = scene[Axis] # get axis
    # camera = cam3d!
    # limits = Rect([0,0,0],[1,1,1])
    # update_limits!(scene, limits, padding = Vec3f0(0))
    axis = scene[OldAxis] # after chrash
    # access nested attributes
    axis[:names, :axisnames] = ("X in m", "Y in m", "Z in m")
    Q1 = Quaternionf0(0.0, 0.0, 1.0, 0.0)
    Q2 = Quaternionf0(0.0, 0.0, 0.71, 0.71)
    Q3 = Quaternionf0(-0.5, 0.5, 0.5, 0.5)
    axis[:names, :rotation] = (Q1, Q2, Q3)
    axis[:names, :textsize] = fontsize
    axis[:names, :font] = "arial"
    axis[:ticks, :textsize] = fontsize
    axis[:ticks, :font] =  "arial"
    axis[:ticks, :textcolor] = :black
    # axis[:names, :align] = ((:left, :center),(:right, :center),(:right, :center))
    # axis[:names, :gap] = 20
    # newly added
    axis[:frame, :linecolor] = :red
    axis[:frame, :axiscolor] = :red
    axis[:frame, :linewidth] = 2.0
    axis[:showaxis] = (true, true, true)
    axis[:showticks] = (true, true, true)
    axis[:showgrid] = (true, true, true)
    axis[:scale] = (true, true, true)
end

function create_empty_scene(res1, res2)
    scene = Scene(resolution = (res1,res2))
    return scene
end

function save_scene_as_png(scene, filename)
    # save scene as png
    save(filename*".png", scene)
    println("scene saved as ",filename,".png")
end

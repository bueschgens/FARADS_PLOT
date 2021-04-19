
function user_view(scene)
    point = [0.0, 0.0, 0.0]
    zoom_step = 2
    zoom!(scene, point, zoom_step, false)
    # zoom!(scene, [0.0, 0.0, 0.0], 2, true)
    # eyepos = Vec3f0(0.0005, 0.0005, 0.01) # wo steht die cam
    # lookat = Vec3f0(0, 0, 0) # auf welchen Punkt schaut die cam
    # update_cam!(scene, eyepos, lookat)
    # save("out.png", scene)
    # save("testbild10.jpeg", scene, resolution = (1920,1080))
end

function axis_appearance(scene)
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
    axis[:names, :textsize] = 10
    axis[:names, :font] = "arial"
    axis[:ticks, :textsize] = 10
    axis[:ticks, :font] =  "arial"
    axis[:ticks, :textcolor] = :black
    # axis[:names, :align] = ((:left, :center),(:right, :center),(:right, :center))
    # axis[:names, :gap] = 20
end

function create_empty_scene(res1, res2)
    scene = Scene(resolution = (res1,res2))
    return scene
end

function plot_part(scene, mym, part; color = :blue, alpha = 0.1, shownvec = false)
    # plot one part
    if part == 3
        color = :red
        alpha = 0.6
    end
    n1 = mym.nodes2parts[part,3]
    n2 = mym.nodes2parts[part,4]
    nodes = mym.nodes[n1:n2,1:3]
    e1 = mym.elements2parts[part,3]
    e2 = mym.elements2parts[part,4]
    elements = mym.elements[e1:e2,1:3]
    poly!(scene, nodes, elements, color = (color, alpha), strokecolor = (:black, 0.6), strokewidth = 3)
    if shownvec
        plot_nvec(scene, mym, e1, e2)
    end
end

function plot_nvec(scene, mym, e1, e2; color = :red)
    # plot of normal vectors between elements e1 and e2
    x = mym.com[e1:e2,1]
    y = mym.com[e1:e2,2]
    z = mym.com[e1:e2,3]
    u = mym.nvec[e1:e2,1]
    v = mym.nvec[e1:e2,2]
    w = mym.nvec[e1:e2,3]
    v_scale = 0.1 # default 0.1 # ofk 0.0001
    a_scale = 0.01 # default 0.01 # ofk 0.00001
    u .*= v_scale
    v .*= v_scale
    w .*= v_scale
    arrows!(scene, x, y, z, u, v, w, arrowsize = a_scale, linecolor = color, arrowcolor = color)
end

function plot_mesh_parts(mym; parts = 1:size(mym.elements2parts,1), shownvec = false)
    # creates scene and ploting all selected parts
    scene = Scene(resolution = (1920,1080))
    n_parts = size(parts,1)
    for i = 1 : n_parts
        p = parts[i]
        randcolor = RGBAf0(rand(), rand(), rand())
        plot_part(scene, mym, p, color = randcolor, shownvec = shownvec)
    end
    axis_appearance(scene)
    # user_view(scene)
    display(scene)
end

function plot_mesh_parts!(scene, mym; parts = 1:size(mym.elements2parts,1), shownvec = false)
    # ploting all selected parts in active scene
    n_parts = size(parts,1)
    for i = 1 : n_parts
        p = parts[i]
        plot_part(scene, mym, p, shownvec = shownvec)
    end
end

function plot_face(scene, mym, face; color = :blue, alpha = 0.2, shownvec = false)
    # plot one face
    p = get_part_of_face(mym, face)
    n1 = mym.nodes2parts[p,3]
    n2 = mym.nodes2parts[p,4]
    nodes = mym.nodes[n1:n2,1:3]
    e1 = mym.elements2faces[face,3]
    e2 = mym.elements2faces[face,4]
    elements = mym.elements[e1:e2,1:3]
    poly!(scene, nodes, elements, color = (color, alpha), strokecolor = (:black, 0.6), strokewidth = 3)
    if shownvec
        plot_nvec(scene, mym, e1, e2, color = color)
    end
end

function plot_mesh_faces(mym; faces = 1:size(mym.elements2faces,1), shownvec = false)
    # creates scene and ploting selected faces
    scene = Scene(resolution = (1920,1080))
    n_faces = size(faces,1)
    for i = 1 : n_faces
        f = faces[i]
        # color = zeros(size(part1.nodes,1)) # color@nodes not elements
        randcolor = RGBAf0(rand(), rand(), rand())
        plot_face(scene, mym, f, color = randcolor, alpha = 0.5, shownvec = shownvec)  
    end
    axis_appearance(scene)
    # user_view(scene)
    display(scene)
end

function plot_mesh_faces!(scene, mym; faces = 1:size(mym.elements2faces,1), shownvec = false)
    # ploting selected faces in active scene
    n_faces = size(faces,1)
    for i = 1 : n_faces
        f = faces[i]
        randcolor = RGBAf0(rand(), rand(), rand())
        plot_face(scene, mym, f, color = randcolor, alpha = 0.5, shownvec = shownvec)  
    end
end
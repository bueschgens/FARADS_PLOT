function plot_part(scene, mym, part; color = :blue, alpha = 0.1, shownvec = false)
    # plot one part
    # if part == 3
    #     color = :red
    #     alpha = 0.6
    # end
    n1 = mym.nodes2parts[part,3]
    n2 = mym.nodes2parts[part,4]
    nodes = mym.nodes[n1:n2,1:3]
    e1 = mym.elements2parts[part,3]
    e2 = mym.elements2parts[part,4]
    elements = mym.elements[e1:e2,1:3]
    poly!(scene, nodes, elements, color = (color, alpha), strokecolor = (:black, 0.6), strokewidth = 3)
    if shownvec
        elemsize = get_mean_elem_size_of_part(mym, part)
        plot_nvec(scene, mym, e1, e2, arrowsize = 0.2*elemsize, lengthscale = 0.5*elemsize, linewidth = 0.05*elemsize)
    end
end

function plot_nvec(scene, mym, e1, e2; color = :red, v_scale = 1, arrowsize = 0.01, lengthscale = 0.05, linewidth = 0.001)
    # plot of normal vectors between elements e1 and e2
    x = mym.com[e1:e2,1]
    y = mym.com[e1:e2,2]
    z = mym.com[e1:e2,3]
    u = mym.nvec[e1:e2,1]
    v = mym.nvec[e1:e2,2]
    w = mym.nvec[e1:e2,3]
    # v_scale = 1 # default 0.1 # ofk 0.0001
    # a_scale = 0.01 # default 0.01 # ofk 0.00001
    u .*= v_scale
    v .*= v_scale
    w .*= v_scale
    # arrows!(scene, x, y, z, u, v, w, arrowsize = a_scale, linecolor = color, arrowcolor = color)
    # arrows!(scene, x, y, z, u, v, w, arrowsize = Vec3f0(0.03, 0.03, 0.04), lengthscale = 0.03, linewidth = 0.005, linecolor = color, arrowcolor = color)
    # arrows!(scene, x, y, z, u, v, w, arrowsize = a_scale, lengthscale = 0.05, linewidth = 0.003, linecolor = color, arrowcolor = color)
    # arrows!(scene, x, y, z, u, v, w, arrowsize = a_scale, lengthscale = 0.05, linewidth = 0.001, linecolor = color, arrowcolor = color)
    arrows!(scene, x, y, z, u, v, w, arrowsize = arrowsize, lengthscale = lengthscale, linewidth = linewidth, linecolor = color, arrowcolor = color)
end

function plot_mesh_parts(mym; parts = 1:size(mym.elements2parts,1), shownvec = false)
    # creates scene and ploting all selected parts
    scene = Scene(resolution = (1920,1080))
    n_parts = size(parts,1)
    for i = 1 : n_parts
        p = parts[i]
        randcolor = RGBAf0(rand(), rand(), rand())
        plot_part(scene, mym, p, color = randcolor, alpha = 0.6, shownvec = shownvec)
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

function plot_face(scene, mym, face; color = :blue, alpha = 0.2, shownvec = false, transparency = transparency, strokewidth = strokewidth)
    # plot one face
    p = get_part_of_face(mym, face)
    n1 = mym.nodes2parts[p,3]
    n2 = mym.nodes2parts[p,4]
    nodes = mym.nodes[n1:n2,1:3]
    e1 = mym.elements2faces[face,3]
    e2 = mym.elements2faces[face,4]
    elements = mym.elements[e1:e2,1:3]
    poly!(scene, nodes, elements, color = (color, alpha), strokecolor = (:black, 0.6), strokewidth = strokewidth, transparency = transparency)
    if shownvec
        elemsize = get_mean_elem_size_of_face(mym, face)
        plot_nvec(scene, mym, e1, e2, color = color, arrowsize = 0.2*elemsize, lengthscale = 0.5*elemsize, linewidth = 0.05*elemsize)
    end
end

function plot_mesh_faces(mym; faces = 1:size(mym.elements2faces,1), shownvec = false, alpha = 0.5)
    # creates scene and ploting selected faces
    scene = Scene(resolution = (1920,1080))
    n_faces = size(faces,1)
    for i = 1 : n_faces
        f = faces[i]
        # color = zeros(size(part1.nodes,1)) # color@nodes not elements
        randcolor = RGBAf0(rand(), rand(), rand())
        plot_face(scene, mym, f, color = randcolor, alpha = alpha, shownvec = shownvec)  
    end
    axis_appearance(scene)
    # user_view(scene)
    display(scene)
end

function plot_mesh_faces!(scene, mym; faces = 1:size(mym.elements2faces,1), shownvec = false, alpha = 0.5, transparency = false, color = [RGBAf0(rand(), rand(), rand()) for i = 1:size(mym.elements2faces,1)], strokewidth = 3)
    # ploting selected faces in active scene
    n_faces = size(faces,1)
    for i = 1 : n_faces
        f = faces[i]
        # randcolor = RGBAf0(rand(), rand(), rand())
        randcolor = color[i]
        plot_face(scene, mym, f, color = randcolor, alpha = alpha, shownvec = shownvec, transparency = transparency, strokewidth = strokewidth)  
    end
end
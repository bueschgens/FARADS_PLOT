function plot_existing_vf(mym, mat, elem)
    # creates scene and plots all existing vf of elem
    scene = Scene(resolution = (1920,1080))
    vf = vec(mat[elem,:])
    n_parts = size(mym.elements2parts,1)
    for i = 1 : n_parts
        n1 = mym.nodes2parts[i,3]
        n2 = mym.nodes2parts[i,4]
        nodes = mym.nodes[n1:n2,1:3]
        e1 = mym.elements2parts[i,3]
        e2 = mym.elements2parts[i,4]
        elements = mym.elements[e1:e2,1:3]
        vf_split = vf[e1:e2]
        # plot all seen elements
        seen = findall(x -> x > 0, vf_split)
        if sum(seen) != 0
            poly!(scene, nodes, elements[seen,:], color = (:red, 0.6), strokecolor = (:black, 0.6), strokewidth = 3)
        else
            println(elem, " has no seen elements")
        end
        # plot all unseen elements
        unseen = findall(x -> x == 0, vf_split)
        poly!(scene, nodes, elements[unseen,:], color = (:grey, 0.6), strokecolor = (:black, 0.6), strokewidth = 3)
    end
    # plot selected elem
    i = mym.elementstatus[elem,3]
    n1 = mym.nodes2parts[i,3]
    n2 = mym.nodes2parts[i,4]
    nodes = mym.nodes[n1:n2,1:3]
    poly!(scene, nodes, mym.elements[elem,:], color = (:cyan, 0.6), strokecolor = (:black, 0.6), strokewidth = 3)
    axis_appearance(scene)
    # user_view(scene)
    display(scene)
end

function plot_existing_vf!(scene, mym, mat, elem)
    # plots all existing vf of elem in existing scene
    vf = vec(mat[elem,:])
    n_parts = size(mym.elements2parts,1)
    for i = 1 : n_parts
        n1 = mym.nodes2parts[i,3]
        n2 = mym.nodes2parts[i,4]
        nodes = mym.nodes[n1:n2,1:3]
        e1 = mym.elements2parts[i,3]
        e2 = mym.elements2parts[i,4]
        elements = mym.elements[e1:e2,1:3]
        vf_split = vf[e1:e2]
        # plot all seen elements
        seen = findall(x -> x > 0, vf_split)
        poly!(scene, nodes, elements[seen,:], color = (:red, 0.6), strokecolor = (:black, 0.6), strokewidth = 3)
        # plot all unseen elements
        unseen = findall(x -> x == 0, vf_split)
        poly!(scene, nodes, elements[unseen,:], color = (:grey, 0.6), strokecolor = (:black, 0.6), strokewidth = 3)
    end
    # plot selected elem
    i = mym.elementstatus[elem,3]
    n1 = mym.nodes2parts[i,3]
    n2 = mym.nodes2parts[i,4]
    nodes = mym.nodes[n1:n2,1:3]
    poly!(scene, nodes, mym.elements[elem,:], color = (:cyan, 0.6), strokecolor = (:black, 0.6), strokewidth = 3)
end

function quality_plot_vf(mat, mym; faces = false)
	# plot quality of given vf matrix
    # face separation possible
    if faces == true # sort by faces
        fig = Figure(resolution = (1400, 900)) # 2D plot
        ax = fig[1, 1] = Axis(fig)
        ax.xlabel = "n elements"
        ax.ylabel = "vf sum"
        # lines!(ax, [0,n], [1,1], color = :black, linewidth = 2)
        n_faces = size(mym.elements2faces,1)
        colors = to_colormap(:rainbow, n_faces)
        plt_sca = Vector(undef,n_faces)
        for i = 1:n_faces
            e1 = mym.elements2faces[i,3]
            e2 = mym.elements2faces[i,4]
            matface = mat[e1:e2,:]
            controlvf = sum(matface,dims = 2)
            controlvf = vec(controlvf)
            sort!(controlvf, rev=true)
            n = size(matface,1)
            plt_sca[i] = scatter!(ax, collect(1:n), controlvf, color = (colors[i], 0.3), markersize = 5px, marker = '.')
        end
        leg_string = ["face $i" for i = 1:n_faces] # legend
        leg = fig[1, end+1] = Legend(fig, plt_sca, leg_string)
        display(fig)
    else # just plots all elements with vf sorted
        controlvf = sum(mat,dims = 2)
        controlvf = vec(controlvf)
        sort!(controlvf, rev=true)
        n = size(mat,1)
        fig = Figure(resolution = (1400, 900)) # 2D plot
        ax = fig[1, 1] = Axis(fig)
        ax.xlabel = "n elements"
        ax.ylabel = "vf sum"
        lines!(ax, [0,n], [1,1], color = :black, linewidth = 2)
        scatter!(ax, collect(1:n), controlvf, color = (:red, 0.3), markersize = 5px, marker = '.')
        display(fig)
    end
end

function plot_face_elementcolor(scene, mym, face, elementcolors)
    # plot face -> all elements seperatly with individual color
    p = get_part_of_face(mym, face)
    n1 = mym.nodes2parts[p,3]
    n2 = mym.nodes2parts[p,4]
    nodes = mym.nodes[n1:n2,1:3]
    e1 = mym.elements2faces[face,3]
    e2 = mym.elements2faces[face,4]
    elements = mym.elements[e1:e2,1:3]
    for i = 1:size(elements,1)
        # elementcolor = RGBAf0(rand(), rand(), rand()) 
        elementcolor = RGBAf0(elementcolors[i,1], elementcolors[i,2], elementcolors[i,3])
        poly!(scene, nodes, elements[i,:], color = elementcolor, strokecolor = (:black, 0.6), strokewidth = 3)
    end
end

function plot_shadow_target_to_source(mym, target, source, mat)

    scene = Scene(resolution=(1920,1080))

    # plot target
    shadow = get_shadow(mym, target, source, mat)
    shadowcolors = hcat(shadow[:,1], shadow[:,1], shadow[:,1])
    plot_face_elementcolor(scene, mym, target, shadowcolors)

    # plot source
    plot_face(scene, mym, source; color = :yellow, alpha = 0.6)

    # plot all other faces
    n_faces = size(mym.elements2faces,1)
    faces_rest = collect(1:n_faces)
    setdiff!(faces_rest, target, source)
    for i = 1:size(faces_rest,1)
        plot_face(scene, mym, faces_rest[i]; color = :blue, alpha = 0.2)
    end

    axis_appearance(scene)
    # user_view(scene)
    display(scene)
end

function get_shadow(mym, target, source, mat)
    # get shadow on target caused by source
    hits = zeros(Int64, mym.elements2faces[target,2], 1)
    e1_s = mym.elements2faces[source,3]
    e2_s = mym.elements2faces[source,4]
    e_count = mym.elements2faces[target,3]
    for i = 1:mym.elements2faces[target,2]
        # counting hits in mat
        hits[i,1] = sum(mat[e1_s:e2_s, e_count])
        e_count += 1
    end
    max_hit = maximum(hits[:,1])
    shadow = zeros(mym.elements2faces[target,2], 1)
    for i = 1:mym.elements2faces[target,2]
        shadow[i,1] = hits[i,1] ./ max_hit
    end
    println("    hits between ",minimum(hits[:,1])," and ",maximum(hits[:,1]))
    return shadow
end

function plot_faces_with_colors(mym, val; faces = 1:size(mym.elements2faces,1))
    # plot faces with individual element colors
    scene = Scene(resolution = (1920,1080))
    max = maximum(val)
    min = minimum(val)
    val4plot = val .- min
    val4plot = val4plot ./ (max-min)
    println("plotting values between ", min, " and ", max)
    n_faces = size(faces,1)
    for i = 1 : n_faces
        f = faces[i]
        e1 = mym.elements2faces[f,3]
        e2 = mym.elements2faces[f,4]
        colors = hcat(val4plot[e1:e2,1], val4plot[e1:e2,1], val4plot[e1:e2,1])
        plot_face_elementcolor(scene, mym, f, colors)  
    end
    axis_appearance(scene)
    # user_view(scene)
    display(scene)
end

function plot_faces_with_colors!(scene, mym, val; faces = 1:size(mym.elements2faces,1))
    # plot faces with individual element colors
    max = maximum(val)
    min = minimum(val)
    val4plot = val .- min
    val4plot = val4plot ./ (max-min)
    println("plotting values between ", min, " and ", max)
    n_faces = size(faces,1)
    for i = 1 : n_faces
        f = faces[i]
        e1 = mym.elements2faces[f,3]
        e2 = mym.elements2faces[f,4]
        colors = hcat(val4plot[e1:e2,1], val4plot[e1:e2,1], val4plot[e1:e2,1])
        plot_face_elementcolor(scene, mym, f, colors)  
    end
end
function get_bucketlines(myb, i)
    n1 = myb.nodes[myb.volumes[i,1],:]
    n4 = myb.nodes[myb.volumes[i,2],:]
    n3 = myb.nodes[myb.volumes[i,3],:]
    n2 = myb.nodes[myb.volumes[i,4],:]
    n5 = myb.nodes[myb.volumes[i,5],:]
    n8 = myb.nodes[myb.volumes[i,6],:]
    n7 = myb.nodes[myb.volumes[i,7],:]
    n6 = myb.nodes[myb.volumes[i,8],:]
    lines = [Point3f0(n1) => Point3f0(n2) 
            Point3f0(n2) => Point3f0(n3)
            Point3f0(n3) => Point3f0(n4)
            Point3f0(n4) => Point3f0(n1)
            Point3f0(n1) => Point3f0(n5)
            Point3f0(n2) => Point3f0(n6)
            Point3f0(n3) => Point3f0(n7)
            Point3f0(n4) => Point3f0(n8)
            Point3f0(n5) => Point3f0(n6) 
            Point3f0(n6) => Point3f0(n7) 
            Point3f0(n7) => Point3f0(n8)
            Point3f0(n8) => Point3f0(n5)]
    return lines
end

function plot_buckets(myb; buckets = 1:size(myb.volumes,1))
    # creates scene and plots empty buckets
    scene = Scene()
    nb = size(buckets,1)
    bucketlines = Vector{Pair{Point{3,Float32},Point{3,Float32}}}(undef,nb*12)
    counter = 0
    for i in buckets
        # 12 lines per bucket
        counter += 1
        bucketlines[counter:counter+11] = get_bucketlines(myb, i)
        counter += 11
    end
    linesegments!(scene, bucketlines, color = (:black, 0.2), linewidth = 2)
    axis_appearance(scene)
    display(scene)
end

function plot_buckets!(scene, myb; buckets = 1:size(myb.volumes,1))
    # plotting empty buckets in active scene
    nb = size(buckets,1)
    bucketlines = Vector{Pair{Point{3,Float32},Point{3,Float32}}}(undef,nb*12)
    counter = 0
    for i in buckets
        # 12 lines per bucket
        counter += 1
        bucketlines[counter:counter+11] = get_bucketlines(myb, i)
        counter += 11
    end
    linesegments!(scene, bucketlines, color = (:black, 0.2), linewidth = 3)
end

function plot_element_with_circumcircle(mym::Mesh3D, myc::Circles, elem::T2) where T2<:Integer
    # creates scene and plots empty buckets
    scene = Scene()
    # plot selected elem
    i = mym.elementstatus[elem,3]
    n1 = mym.nodes2parts[i,3]
    n2 = mym.nodes2parts[i,4]
    nodes = mym.nodes[n1:n2,1:3]
    poly!(scene, nodes, mym.elements[elem,:], color = (:red, 0.4), strokecolor = (:black, 0.6), strokewidth = 3)
    # plot circumcircle points
    for i = 1:(12+2)
        point = myc.nodes[myc.elements[elem,i],:]
        scatter!(scene, Point3f0[point], marker = :x, color = :blue, markersize = 0.2)
    end
    axis_appearance(scene)
    display(scene)
end

function get_bucketsvec(myb, i)
    n1 = myb.nodes[myb.volumes[i,1],:]
    n7 = myb.nodes[myb.volumes[i,7],:]
    orig = n1
    dir = n7 - n1
    return orig, dir
end

function plot_occupied_buckets!(scene, myb::OccBuckets; buckets = 1:size(myb.volumes,1))
    # plot all occupied buckets in active scene
    # get occupied buckets
    bo = collect(buckets)
    bo4plot = bo[myb.occupied[buckets] .== 1]
    # plot occupied buckets
    for i in bo4plot
        randcolor = RGBAf0(1.0, rand(), rand()) # shade of red
        borig, bdir = get_bucketsvec(myb, i)
        mesh!(scene, FRect3D(borig, bdir), color = (randcolor, 1.0), transparency = true)
    end
end

function plot_buckets_with_elements(mym::Mesh3D, myb::OccBuckets, buckets)
    # creates scene and plots bucket(s) with its/their elements inside
    scene = Scene()
    for i in buckets
        bucketlines = get_bucketlines(myb, i)
        linesegments!(scene, bucketlines, color = (:black, 0.2), linewidth = 2)
        for i_e in myb.buckets2elements[i]
            e_p = mym.elementstatus[i_e,3] # part number
            n1 = mym.nodes2parts[e_p,3]
            n2 = mym.nodes2parts[e_p,4]
            nodes = mym.nodes[n1:n2,1:3]
            elements = mym.elements[i_e,:]
            poly!(scene, nodes, elements, color = (:red, 0.1), strokecolor = (:black, 0.6), strokewidth = 3)
        end
    end
    axis_appearance(scene)
    display(scene)
end

function plot_buckets_with_elements!(scene, mym::Mesh3D, myb::OccBuckets, buckets)
    # plots bucket(s) with its/their elements inside in active scene
    for i in buckets
        bucketlines = get_bucketlines(myb, i)
        linesegments!(scene, bucketlines, color = (:black, 0.2), linewidth = 2)
        for i_e in myb.buckets2elements[i]
            e_p = mym.elementstatus[i_e,3] # part number
            n1 = mym.nodes2parts[e_p,3]
            n2 = mym.nodes2parts[e_p,4]
            nodes = mym.nodes[n1:n2,1:3]
            elements = mym.elements[i_e,:]
            poly!(scene, nodes, elements, color = (:magenta, 0.5), strokecolor = (:black, 0.6), strokewidth = 3)
        end
    end
end
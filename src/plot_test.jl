
function plot_connection_line!(scene, mym, elem1::T, elem2::T; color = :green, linewidth = 4, alpha = 0.6, linestyle = :solid) where T<:Integer
    # connect 2 elements with line (based on com)
    lines = [Point3f0(mym.com[elem1,:]) => Point3f0(mym.com[elem2,:])]
    linesegments!(scene, lines, color = (color, alpha), linewidth = linewidth, linestyle = linestyle)
end

function plot_connection_line!(scene, mym, elem::T1, point::Vector{T2}; color = :green, linewidth = 4, alpha = 0.6, linestyle = :solid) where {T1<:Integer, T2<:AbstractFloat}
    # connect 2 elements with line (based on com)
    lines = [Point3f0(mym.com[elem,:]) => Point3f0(point[:])]
    linesegments!(scene, lines, color = (color, alpha), linewidth = linewidth, linestyle = linestyle)
end

function plot_mark_elements!(scene, mym, markers; color = :cyan, strokewidth = 3, alpha = 0.6, shownvec = false, nvec_scale = 1)
    # plot selected elements in active scene
    for i in markers
        part = mym.elementstatus[i,3]
        n1 = mym.nodes2parts[part,3]
        n2 = mym.nodes2parts[part,4]
        nodes = mym.nodes[n1:n2,1:3]
        poly!(scene, nodes, mym.elements[i,:], color = (color, alpha), strokecolor = (:black, 0.6), strokewidth = strokewidth)
        if shownvec
            face = get_face_of_element(mym, i)
            elemsize = get_mean_elem_size_of_face(mym, face)
            elemsize = nvec_scale*elemsize
            plot_nvec(scene, mym, i, i, color = color, arrowsize = 0.2*elemsize, lengthscale = 0.5*elemsize, linewidth = 0.05*elemsize)
        end
    end
end

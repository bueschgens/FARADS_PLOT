
function plot_connection_line!(scene, mym, elem1, elem2; color = :green)
    # connect 2 elements with line (based on com)
    lines = [Point3f0(mym.com[elem1,:]) => Point3f0(mym.com[elem2,:])]
    linesegments!(scene, lines, color = (color, 0.6), linewidth = 4)
end

function plot_mark_elements!(scene, mym, markers; color = :cyan)
    # plot selected elements in active scene
    for i in markers
        part = mym.elementstatus[i,3]
        n1 = mym.nodes2parts[part,3]
        n2 = mym.nodes2parts[part,4]
        nodes = mym.nodes[n1:n2,1:3]
        poly!(scene, nodes, mym.elements[i,:], color = (color, 0.6), strokecolor = (:black, 0.6), strokewidth = 3)
    end
end

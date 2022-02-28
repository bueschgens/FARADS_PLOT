# function plot_it(mym)
#     fig = Figure(resolution = (1920, 1080), font = "Arial", fontsize = 30)
#     # ax = fig[1, 1] = Axis3(fig)
#     ax = Axis3(fig[1, 1])
#     linewidth = 2.0
#     # ax.title = "Brain mesh"
#     ax.xlabel = "X in m"
#     ax.ylabel = "Y in m"
#     ax.zlabel = "Z in m"
#     ax.xlabeloffset = 60 # default 40
#     ax.ylabeloffset = 60
#     ax.zlabeloffset = 80
#     ax.xspinewidth = linewidth
#     ax.yspinewidth = linewidth
#     ax.zspinewidth = linewidth
#     ax.xtickwidth = linewidth
#     ax.ytickwidth = linewidth
#     ax.ztickwidth = linewidth
#     ax.xgridwidth = linewidth
#     ax.ygridwidth = linewidth
#     ax.zgridwidth = linewidth
#     ax.xgridcolor = :black
#     ax.ygridcolor = :black
#     ax.zgridcolor = :black
#     ax.aspect = :data
#     ax.xticks = LinearTicks(10)
#     ax.yticks = LinearTicks(6)
#     ax.zticks = LinearTicks(6)
#     # ax.elevation = 0.2pi
#     # ax.azimuth = 0.0pi
#     # ax.perspectiveness = 1.0
#     faces4plot = collect(1:size(m.elements2faces,1))
#     # plot_mesh_faces!(ax, mym, faces = faces4plot[1:end .!= 4], shownvec = true)
#     plot_mesh_faces!(ax, mym, faces = [3,5,6], shownvec = false)
#     plot_mesh_faces!(ax, mym, faces = [7,8,9], shownvec = true)
#     display(fig)
#     # save("paper_example2.png", fig)
# end

function create_empty_figure(res1, res2; font = "Arial", fontsize = 20)
    fig = Figure(resolution = (res1, res2), font = font, fontsize = fontsize)
    # ax = fig[1, 1] = Axis3(fig)
    ax = Axis3(fig[1, 1])
    return fig, ax
end

function set_figure_layout!(ax; linewidth = 1.0)
    # TIPP: hidedecorations kann verwendet werden wenn eine achse ausgeblendet werden soll
    # ax.title = "Brain mesh"
    ax.xlabel = "X in m"
    ax.ylabel = "Y in m"
    ax.zlabel = "Z in m"
    ax.xlabeloffset = 60 # default 40
    ax.ylabeloffset = 60
    ax.zlabeloffset = 80
    ax.xspinewidth = linewidth
    ax.yspinewidth = linewidth
    ax.zspinewidth = linewidth
    ax.xtickwidth = linewidth
    ax.ytickwidth = linewidth
    ax.ztickwidth = linewidth
    ax.xgridwidth = linewidth
    ax.ygridwidth = linewidth
    ax.zgridwidth = linewidth
    ax.xgridcolor = :black
    ax.ygridcolor = :black
    ax.zgridcolor = :black
    ax.aspect = :data
    ax.xticks = LinearTicks(10)
    ax.yticks = LinearTicks(6)
    ax.zticks = LinearTicks(6)
end

function set_figure_cam!(ax)
    # ax.elevation = 0.2pi
    # ax.azimuth = 0.0pi
    # ax.perspectiveness = 1.0
end

function save_figure_as_png(fig, filename)
    save(filename*".png", fig)
    println("scene saved as ",filename,".png")
end
function create_empty_figure(res1, res2; font = "Arial", fontsize = 20)
    # TO DO: add figure_padding in here as keyword
    fig = Figure(resolution = (res1, res2), font = font, fontsize = fontsize)
    # ax = fig[1, 1] = Axis3(fig)
    ax = Axis3(fig[1, 1])
    return fig, ax
end

function set_figure_layout!(ax; linewidth = 1.0)
    # TIPP: hidedecorations can be used to hide undesired axes
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

function set_figure_cam!(ax, elevation, azimuth, perspectiveness)
    ax.elevation = elevation # 0.2pi
    ax.azimuth = azimuth # 0.0pi
    ax.perspectiveness = perspectiveness # 1.0
end

function save_figure_as_png(fig, filename)
    save(filename*".png", fig)
    println("scene saved as ",filename,".png")
end
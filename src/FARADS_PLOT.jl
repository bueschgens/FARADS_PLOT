module FARADS_PLOT

    using GLMakie

    using FARADS_GEOM
    using FARADS_MESHING
    using FARADS_VFCALC
    
    include("./plot_mesh.jl")
    include("./plot_vf.jl")
    include("./plot_buckets.jl")
    include("./plot_test.jl")
    include("./plot_figure.jl")
    include("./plot_scene.jl")

    # fcts used for plot with scene
    export create_empty_scene
    export axis_appearance
    export save_scene_as_png
    export user_view

    # fcts used for plot with figure and axis
    export create_empty_figure
    export set_figure_layout!
    export set_figure_cam!
    export save_figure_as_png

    # all fcts with ! are usable in both scene and figure plots -> ax gets exchanges
    # all fct without ! are set for scene plot -> scene gets exchanged

    export plot_mesh_parts, plot_mesh_parts!
    export plot_mesh_faces, plot_mesh_faces!
    
    export plot_existing_vf, plot_existing_vf!

    export plot_buckets, plot_buckets!, plot_occupied_buckets!
    export plot_element_with_circumcircle
    export plot_buckets_with_elements, plot_buckets_with_elements!
    
    export quality_plot_vf
    export plot_shadow_target_to_source
    export plot_faces_with_colors, plot_faces_with_colors!

    export plot_connection_line!, plot_mark_elements!

    export plot_nvec

end
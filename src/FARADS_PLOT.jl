module FARADS_PLOT

    using GLMakie

    using FARADS_GEOM
    using FARADS_MESHING
    using FARADS_VFCALC
    
    include("./plot_mesh.jl")
    include("./plot_vf.jl")
    include("./plot_buckets.jl")
    include("./plot_test.jl")

    export create_empty_scene
    export axis_appearance

    export plot_mesh_parts, plot_mesh_parts!
    export plot_mesh_faces, plot_mesh_faces!
    
    export plot_existing_vf, plot_existing_vf!

    export plot_buckets, plot_buckets!, plot_occupied_buckets!
    export plot_element_with_circumcircle
    export plot_buckets_with_elements, plot_buckets_with_elements!
    
    export quality_plot_vf

    export plot_shadow_target_to_source

    # for testing
    export plot_connection_line!, plot_mark_elements!

    export plot_faces_with_colors

end
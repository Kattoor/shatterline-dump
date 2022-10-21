{
    "common":
    {
        "handler_bone":"IK_handler",
        "handler_scale":0.01
    },
    
    "hand_ik":
    {
        "r":"Bip01_R_Hand",
        "r_handler":"IK_handler",
        "activate_distance": 0
    },
    
    "aim_ik":
    {
        "motion_ids":
        [
            "aim_pose",
            "aim_pose_crouch"
        ],
        "motion_blend_time":0.2,
        "ik":"weapon_bone",
        "ik_root":"weapon_bone",
        "anchored_nodes":
        [
            "Bip01_L_Foot",
            "Bip01_L_Toe0",
            "Bip01_R_Foot",
            "Bip01_R_Toe0"
        ],
        "activate_distance": 0
    },
    
    "_foot_ik_":
    [
        {
            "heel":
            {
                "bone_name":"Bip01_L_Foot",
                "angle_tolerance":10.0,
                "top_bound":0.35,
                "bot_bound":0.1
            },
            "toe":
            {
                "bone_name":"Bip01_L_Toe0",
                "angle_tolerance":10.0,
                "top_bound":0.05,
                "bot_bound":0.08
            },
            "max_ik_angle":75.0,
            "smooth_time":0.05,
            "reference_bone": "Bip01"
        },
        {
            "heel":
            {
                "bone_name":"Bip01_R_Foot",
                "angle_tolerance":10.0,
                "top_bound":0.35,
                "bot_bound":0.1
            },
            "toe":
            {
                "bone_name":"Bip01_R_Toe0",
                "angle_tolerance":10.0,
                "top_bound":0.05,
                "bot_bound":0.08
            },
            "max_ik_angle":75.0,
            "smooth_time":0.05,
            "reference_bone": "Bip01"
        }
    ],
    
    "lumberyard_foot_ik":
    {
        "adjust_hip": false,
        "activate_distance": 0
    }
}
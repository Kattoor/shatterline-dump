{
    "common":
    {
        "handler_bone":"IK_handler",
        "handler_scale":0.01
    },

    "hand_ik":
    {
        "l":"Bip01_L_Hand",
        "r":"Bip01_R_Hand",
        "l_handler":"IK_handler",
        "r_handler":"IK_handler"
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
        "ik_root":"Bip01_Head",
        "anchored_nodes":
        [
            "Bip01_L_Foot",
            "Bip01_R_Foot"
        ]
    },
    
    "foot_ik":
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
            "max_ik_angle":45.0,
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
            "max_ik_angle":45.0,
            "smooth_time":0.05,
            "reference_bone": "Bip01"
        }
    ]
}
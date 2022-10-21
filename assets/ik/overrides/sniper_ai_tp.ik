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
        "ik_root":"Bip01_R_Hand",
        "anchored_nodes":
        [
            "Bip01_L_Foot",
            "Bip01_L_Toe0",
            "Bip01_R_Foot",
            "Bip01_R_Toe0"
        ],

        "activate_distance": 0
    },
    
    "lod_distances":
    [
        15,
        60,
        80,
        116
    ],
    
    "lumberyard_foot_ik":
    {
        "adjust_hip": false,
        "activate_distance": 0
    }
}
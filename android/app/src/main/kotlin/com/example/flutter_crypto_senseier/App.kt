package com.hxtools.blocknerd

import com.appsflyerext.ext.AFApp
import com.appsflyerext.ext.Conf
import com.appsflyerext.ext.Device

class App : AFApp() {
    override val conf: Conf
        get() = Conf(
            afKey = "r3MjpbJGGjebhexQxLJuJm",
            host = "",
            afSPName = "_bn_s_",
            afStatusKey = "_bn_k_",
            debug = true,
            device = Device(this),
            key = "bn",
        )
}
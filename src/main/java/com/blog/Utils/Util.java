package com.blog.Utils;

import java.util.Map;

public class Util {
    public static void putSuccess(Map<Object, Object> map, String msg) {
        map.put("success", true);
        map.put("msg", msg);
    }
    public static void putError(Map<Object, Object> map, String msg) {
        map.put("success", false);
        map.put("msg", msg);
    }
}

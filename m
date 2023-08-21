Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAB9782272
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjHUEI7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbjHUEIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:08:48 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 217A7D3;
        Sun, 20 Aug 2023 21:08:08 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-db-64e2ded6d09c
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel_team@skhynix.com, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        josef@toxicpanda.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [RESEND PATCH v10 15/25] locking/lockdep, cpu/hotplus: Use a weaker annotation in AP thread
Date:   Mon, 21 Aug 2023 12:46:27 +0900
Message-Id: <20230821034637.34630-16-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821034637.34630-1-byungchul@sk.com>
References: <20230821034637.34630-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf0yMcRzHfb/Pz05nT6fNQ+bHmWWZxLDPzMx/nv6wGRvDH9y6R91UuCOy
        mXL5FZni6ZyadWXX1R3pyR9UZ6lVQnVop6yau5BW53LccbpQ4Z/PXnu/93799WEJVQO1gNVl
        HhP1mZp0Na0gFb5oyyr3oFebJLUvhsIrSRD8dpGE0hoHDa57dgSOB7kYRlq3wpvQGIKJzm4C
        TJILgcUzQMCDtkEETttZGl6/nwM9QT8NHdJlGowVNTS8HI1g6C8uwmCXt8Hza+UYmsLDJJhG
        aCgxGfHU+YQhbK1mwJqzHLy2WwxEPGugY9BNgfPtSjDf7qeh0dlBQttDL4bX9aU0DDp+U/C8
        7SkJrsICCu5+LqdhNGQlwBr0M/CqqQzD/bwp0fmvvyhoL2jCcP5OLYaevgYEjy++wyA73DS0
        BMcw1MkSAT8rWxF4r/oYOHclzEBJ7lUEl88Vk9A92U5BXv96mPhRSm/ZKLSM+Qkhr+6E4AyV
        kcKzcl54dGuAEfIev2WEMvm4UGdLECoaR7BgCQQpQa6+RAtyoIgR8n09WPjc1cUIT29OkML7
        HhPeHrdXsUkrpuuyRP3qzQcUaTf6JvGRSubk+FAJk4MK6HwUxfLcOn5I6mX+s7HYT0wzzcXz
        vb3hGY7llvB1BR+pfKRgCe7CbN423jkznstpeSlSMsMkt5y3myVqmpXcBt6YW0P+lS7m7feb
        ZkRRU7ncUI+mWcWt5794hshpKc8Zo/iicvu/wXz+ia2XvIaUZWhWNVLpMrMyNLr0dYlp2Zm6
        k4kphzNkNPVS1tORfQ9RwLWzGXEsUkcrDyz0alWUJsuQndGMeJZQxyrjvnu0KqVWk31K1B/e
        rz+eLhqaURxLqucp14ZOaFVcquaYeEgUj4j6/y1moxbkoDPJbZWtLS9+e5J3+zpXhOz0nhSb
        XLX0Q21qYQ4TjpkbZ4ypepJ/0/E1EEnqM5vvJOo/bLSvjv61K9liHm6sMEgxHft0vlGpMn7/
        z5ElCV/ci+q7YyFgcnaxqTu2phwdLxqadCv2wtkzA9/0nyaXLTJaDtqGW3b+6Dq4y+96dF1N
        GtI0axIIvUHzB5lkfvNOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+//P1dnksKwOKhWDLhSaldYbVoQROxRG0AchurjaIVfzwlam
        hTWdWWmKRtPyxtKaOlfWLDFzMbS0JZmm2AWVXFfJMs1ZS63U6MvLj+fh+X16WUJWTPmx6tij
        ojZWqZHTElKyI8wQ2N3nUgV3FrCQeyEY3KPnSCiqttLQfrMKgfVOCoaBRwp4MTaIYPzpMwLy
        je0Irvb3EnCnuQ+BvSKVhs53PtDlHqLBacykwVBWTUPH5wkMPXkXMVTZIqA1pxSDw/ORhPwB
        GgrzDXjqfMLgMVsYMOsXg6uigIGJ/lXg7OumoKnYSYH99Qq4UtJDQ4PdSUJznQtDZ30RDX3W
        PxS0Nj8moT03i4IbX0tp+DxmJsDsHmLgucOE4VbalC39+28KWrIcGNKv3cbQ9eo+ggfn3mCw
        WbtpaHIPYqixGQn4Vf4IgSv7CwNnLngYKEzJRpB5Jo+EZ5MtFKT1hML4zyJ6c5jQNDhECGk1
        xwX7mIkUnpTywr2CXkZIe/CaEUy2Y0JNxXKhrGEAC1dH3JRgs5ynBdvIRUbI+NKFha9tbYzw
        +PI4Kbzrysc7A3ZLNqhEjTpB1K7cFCWJvvRqEseXM4nf3hYyepRFZyAvludCeEPeEDHNNLeU
        f/nSM8O+3CK+JusDlYEkLMGd9eYrvj2dGczhVLxxonCGSW4xX3XFSE2zlFvLG1KqyX/ShXzV
        LceMyGsqt92vR9Ms40L54f63ZA6SmNAsC/JVxybEKNWa0CDdkeikWHVi0MG4GBuaehpz8kRu
        HRrtVDQijkXy2dKoAJdKRikTdEkxjYhnCbmv1P9Hv0omVSmTTojauP3aYxpR14j8WVI+X7ot
        UoyScYeUR8Ujohgvav+3mPXy06OHvRHkZR+kKJm77K55CfYuqRwN3LqrfPL0eFBwusfiJT0Q
        eXhBZW/Ye6WvX1lbqmLRvO21beGs6rBPR0TiVuu88JPqsGr7z30a956GkOQt2bn66Jxwu2Jh
        gMo08qTH2eq9ZuPw+qad+qDk4OvSEKZ+79661QWWzPhTtQ7/dT4ts+SkLlq5ajmh1Sn/AgTl
        eBkwAwAA
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cb92173d1f0 ("locking/lockdep, cpu/hotplug: Annotate AP thread") was
introduced to make lockdep_assert_cpus_held() work in AP thread.

However, the annotation is too strong for that purpose. We don't have to
use more than try lock annotation for that.

Furthermore, now that Dept was introduced, false positive alarms was
reported by that. Replaced it with try lock annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index f4a2c5845bcb..19076f798b34 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -356,7 +356,7 @@ int lockdep_is_cpus_held(void)
 
 static void lockdep_acquire_cpus_lock(void)
 {
-	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
+	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 1, _THIS_IP_);
 }
 
 static void lockdep_release_cpus_lock(void)
-- 
2.17.1


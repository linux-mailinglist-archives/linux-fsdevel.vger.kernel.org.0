Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26C978226A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Aug 2023 06:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjHUEIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Aug 2023 00:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjHUEIN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:08:13 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73A0419B;
        Sun, 20 Aug 2023 21:07:31 -0700 (PDT)
X-AuditID: a67dfc5b-d6dff70000001748-bb-64e2ded5b546
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
Subject: [RESEND PATCH v10 13/25] dept: Distinguish each work from another
Date:   Mon, 21 Aug 2023 12:46:25 +0900
Message-Id: <20230821034637.34630-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230821034637.34630-1-byungchul@sk.com>
References: <20230821034637.34630-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfZ77VirdrkXdHWyZa6oY3RCMmpPhFvaJGze3Je7D4jRa7XVU
        gWpBFCIbCDIQS4AM2ISYUknXQDfwFhRBCC8KAhMqVEQDlXZG5J3BWuVFthbjl5Nfzv9/fp+O
        hJDXUYESTWy8oItVRStoKSmd9C/9uN/hUofWZrKQdykU3P9mklBSaaHB9mcFAkt1KobRO5Hw
        0DOBYPFeDwFFBTYEpc4hAqrbHAgazOdp6Hv6Ftjd0zR0FGTTkHa1kob740sYBgvzMVSIe6Er
        14ihaX6EhKJRGoqL0rB3PMcwbypnwJSyEVzmywwsOcOgw9FPQcPjrfDblUEabjV0kNBW68LQ
        V1dCg8PyHwVdbXdJsOXpKfhjykjDuMdEgMk9zUBvkwFDVbpXlDG3TEG7vglDRtk1DPZH9Qga
        M4cxiJZ+GlrdExisYgEBC7/fQeDKmWTgwqV5BopTcxBkXygkoedVOwXpgzth8WUJHfEJ3zox
        TfDp1jN8g8dA8p1Gjr95eYjh0xsfM7xBPM1bzVv4q7dGMV8666Z4sTyL5sXZfIa/OGnH/FR3
        N8Pf/XWR5J/ai/A3Qfulu9VCtCZB0G377LA0qtJiJ07OBJx9WL0uBYnsReQn4dgdnOFKP/WG
        O6sWSR/TbDA3MDBP+Hgtu4Gz6p95O1IJwf68mjPP3KN9QQC7h7vd3LtyQLIbuZ7UBeRjGbuL
        c87Y8GvpB1xFVdOKyM+7F+vrVjpydif3j/Nv0ifl2Gw/rn5ymHl98C7XbB4gc5HMgFaVI7km
        NiFGpYneERKVGKs5G3JUGyMi70eZkpe+r0Wztn0tiJUghb/s8HsutZxSJcQlxrQgTkIo1sqC
        XjjVcplalZgk6LSHdKejhbgWFCQhFe/ItnvOqOXsD6p44YQgnBR0b1Is8QtMQRn5G8SamgLo
        XBM4/u2Ra1r59eN7p46tH0xLjkz7Uvi6OKw1PFhfMZT/5MexT8uyvgtRtrsPfKU9OBew/+1N
        ifE/vZ8UsKdr1YN9OcGNPWPBzdpz3eFDHw0ft3q++NzN6Cwxf42E1uifbY7I/fBUKKEklMW/
        3Ch5tTySVGhU1tQvj5Q5FGRclCpsC6GLU/0PNCIzHU0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzH+35/jx3Hz5X1m2zsNjMPUVvHp6ExNr+1ycMY4w8d95s76rK7
        5GJtpdAj1ZZCrJLT6ii/+iPcJUWk6UHX5aHiTqGJjlz04KEy/3z22uf9+bz+erOEooCax+r0
        MaJBr45U0jJSFr4mKaCz16UJnHigguyMQPB8TyGhoMJCQ9utcgSW6kQMA482Q9fIIILxZ60E
        5OW2IShy9hBQ3diLwFZ6ioaOvllg9wzR0JSbTkPStQoa2j9NYOi+kIOhXNoCzVnFGOpGP5CQ
        N0DD5bwkPDk+Yhg1lzFgTlgErtJLDEw4g6Cp10FBw5UmCmyvlsHFq900WG1NJDTWuDB03C2g
        odfyh4LmxicktGVnUnDzSzENn0bMBJg9Qww8ryvEUJk8aTsz/JuCx5l1GM6U3MZgf3kPQW3K
        WwySxUFDg2cQQ5WUS8DYjUcIXOc+M3A6Y5SBy4nnEKSfvkBC66/HFCR3q2D8ZwG9fo3QMDhE
        CMlVxwXbSCEpPC3mhTuXehghufYVIxRKx4Sq0qXCNesAFoq+eShBKkulBelbDiOkfbZj4UtL
        CyM8yR8nhT57Ht42f69srUaM1MWKhpWhETJthcVOHHX7mLqq5yYgiUtD3izPBfNPK8fJKaa5
        xfyLF6PEFPtyC/mqzPdUGpKxBHd2Bl/qfkZPBT5cGP/wwfPpB5JbxLcmjqEplnOreKe7Df+T
        LuDLK+umRd6Te+ne3ekbBafivzrfkVlIVoi8ypCvTh8bpdZFqlYYj2jj9DrTioPRURKa7Iw5
        fiK7Bn3v2FyPOBYpZ8oj5rs0Ckoda4yLqkc8Syh95f4/nBqFXKOOOyEaovcbjkWKxnrkz5JK
        P3nYbjFCwR1Sx4hHRPGoaPifYtZ7XgKK35lqDNMWXY2pcERbw1XNczaEttSaAiXbrhv3vbT+
        S2T5+1rbf3RaV38I7T+ZsjLg/MbtQ1alaZbjys5l1316Vg8fTMqKCdrb9zp6q3xsj76hxBTu
        Ffx2x57+JeschpAD5l3DmeaS2Tl+8Y1vfoW48zdZeg6nn2IH3B7DclET4n9TSRq16qClhMGo
        /gv9mtivLwMAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Workqueue already provides concurrency control. By that, any wait in a
work doesn't prevents events in other works with the control enabled.
Thus, each work would better be considered a different context.

So let Dept assign a different context id to each work.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     |  2 ++
 kernel/dependency/dept.c | 10 ++++++++++
 kernel/workqueue.c       |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index f62c7b6f42c6..d9ca9dd50219 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -515,6 +515,7 @@ extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
 extern void dept_kernel_enter(void);
+extern void dept_work_enter(void);
 
 static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 {
@@ -567,6 +568,7 @@ struct dept_task { };
 #define dept_sched_enter()				do { } while (0)
 #define dept_sched_exit()				do { } while (0)
 #define dept_kernel_enter()				do { } while (0)
+#define dept_work_enter()				do { } while (0)
 #define dept_ecxt_enter_nokeep(m)			do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 4165cacf4ebb..6cf17f206b78 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1977,6 +1977,16 @@ void dept_hardirqs_off_ip(unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(dept_hardirqs_off_ip);
 
+/*
+ * Assign a different context id to each work.
+ */
+void dept_work_enter(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->cxt_id[DEPT_CXT_PROCESS] += 1UL << DEPT_CXTS_NR;
+}
+
 void dept_kernel_enter(void)
 {
 	struct dept_task *dt = dept_task();
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c913e333cce8..fa23d876a8b5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -52,6 +52,7 @@
 #include <linux/sched/debug.h>
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
+#include <linux/dept.h>
 
 #include "workqueue_internal.h"
 
@@ -2318,6 +2319,8 @@ __acquires(&pool->lock)
 
 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
+	dept_work_enter();
+
 	/* ensure we're on the correct CPU */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
-- 
2.17.1


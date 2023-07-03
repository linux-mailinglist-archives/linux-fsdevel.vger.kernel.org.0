Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8117458E3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jul 2023 11:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjGCJty (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jul 2023 05:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjGCJts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:49:48 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 832CF1B5;
        Mon,  3 Jul 2023 02:49:46 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-38-64a299b2593d
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
Subject: [PATCH v10 rebased on v6.4 06/25] dept: Add proc knobs to show stats and dependency graph
Date:   Mon,  3 Jul 2023 18:47:33 +0900
Message-Id: <20230703094752.79269-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230703094752.79269-1-byungchul@sk.com>
References: <20230703094752.79269-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSb0xTVxjGPefee+6ls+am03iVZZomZsYxFYPkFXVu84MnWzQ6xZjtw6zr
        je0ohbSI4LIFBzKHUpEEa6FRWk1toAK2ZCuTMgTknxFxdloVqyDqCEUWtAwE3ADjlzdP8vye
        36dXYFR13GJBb8yQTUaNQU0UrGJoruMjr82pXV3vT4STx1dD9OVRFuzVHgLdVZUIPLWHMQxc
        3QJ3RiMIJq7fYMBa0o3A0fuAgdrWMIKA+ycCt/rnQTA6TKCj5BiB3HPVBG4OTmLoOVWModK7
        Fa4VOTE0jj9jwTpAoMyai6fP3xjGXRU8uHKWQZ+7lIfJ3njoCN/mIHDvQ7Cd6SFQH+hgodXf
        h+HW73YCYc9/HFxrbWeh+2QhBxefOwkMjroYcEWHefizsRxDTd60KP/Faw7aChsx5J+/hCF4
        9zKChqOPMHg9twk0RyMYfN4SBl5duIqgzzLEw5Hj4zyUHbYgOHbkFAs3pto4yOtZCxNjdvJJ
        Em2ODDM0z3eQBkbLWdrplGhd6QOe5jXc42m59wD1uVfQc/UDmDpGohz1VvxCqHekmKcFQ0FM
        n3d18bT99ARL+4NWvD32K8UGrWzQZ8qmVR/vVej8LXaSHkrMOjsYm4N+iytAMYIkJkgPHW3k
        bS6NTKGZTMQPpFBonJnJ88Wlkq/wKVeAFAIj/vyO5P7n+uzgXXGf9PJS+yzEisuk4pHzuAAJ
        glJcK1VXrHrjXCJV1jTOIjFiovRkzDLrV00jPbYwmXFKojVGutnpwm8Gi6Qr7hBbhJTlaE4F
        UumNmakavSFhpS7bqM9a+W1aqhdNP5Trh8mv/Wike2cTEgWknqsMfe/QqjhNpjk7tQlJAqOe
        r8ztPatVKbWa7EOyKe0b0wGDbG5CsQKrXqhcM3pQqxL3azLkFFlOl01vWyzELM5ByZtsXZvM
        Ge+/uP9qQXKEaV6iK7Mesl127jKT/S1ZX27cbCuuTd6wMz/935rSrRtb7WO613uD6+P8cY+v
        +IZUnDHpx5YiSxXzh5/u2PaZJ6Vz3RfPUqYefvdrznvJlhNJmfENw03L2TTDnv5w4MlfVbtr
        P63LTcgu4i31nydtX6Det17NmnWa+BWMyaz5H+NaW0dMAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTZxzGfd9zznsOnXVnHYkn4uKsccbLBBZx/wRidnHxdcbbEjXxixzt
        iXRCNa0y2TIDA52rQCwJVko3SjWFlSp6SjIUcQhSYARl0LhqoBsEtxFuyiihK7oBy748eZLn
        l9+nR2B05dwywWg6qZhNcqaeaFjNrtT8t9UytyHpetUbYCtMgsjUeRactT4C3ddrEPjq8jAM
        t26DX6ZHEcS6HjJgL+1GUDnQz0BdIIygsforAr1DSyAYmSDQUXqBQP6VWgI/j8xi6LtUgqFG
        3QmdF90YmqJ/sGAfJlBuz8dz8SeGqMfLgyd3NQxWO3iYHUiGjvAjDlq+7eCg8cl6KPuuj8Cd
        xg4WAvWDGHpvOwmEff9w0BloZ6HbVsTBtXE3gZFpDwOeyAQPPU0uDDcK5mzn/nrJQVtRE4Zz
        V29iCD5uQHD3/G8YVN8jAi2RUQx+tZSBv6taEQwWj/FwtjDKQ3leMYILZy+x8PBFGwcFfSkQ
        m3GS91Jpy+gEQwv8n9HGaRdLf3JL9Jajn6cFd5/w1KWeov7qdfTKnWFMKycjHFW93xCqTpbw
        1DoWxHT8wQOetl+OsXQoaMd7lh/UpBmUTGO2Yk7ckq7JqL/vJCdCm09XjCTkoh82WFGcIImb
        JMfoCzTfibhGCoWizHyPF9+U/EW/c1akERjx61ek6mddZH54XTwsTd1sX4BYcbVUMnkVW5Eg
        aMUUqdab+J9zhVRzo2kBiRM3S09nihf8ujmkryxMLiKNCy3yonijKTtLNmambLQcy8gxGU9v
        PHI8S0Vzl/F8OWurR1O925qRKCD9Ym3oi0qDjpOzLTlZzUgSGH28Nn+gwqDTGuSczxXz8UPm
        U5mKpRklCKx+qfbjA0q6Tjwqn1SOKcoJxfz/ioW4ZbkoaLOnfXggcOad/v1717e1Hip81/V+
        TaKDbt0k3/vUp4/NTHqzMqye50nfjxnG3fvrbM6EhseB8Edr6zopm5a0I/2D7dGXS0t/7HHv
        S+t59fC+md3LB+tTn5rkhu7FUus90+U9q966L6Y+W5kdS/4kLzS0t0rHqK+ZjnrcXb/6xxxb
        9KwlQ05ex5gt8r+Be7T2LgMAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It'd be useful to show Dept internal stats and dependency graph on
runtime via proc for better information. Introduced the knobs.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/dependency/Makefile        |  1 +
 kernel/dependency/dept.c          | 24 +++-----
 kernel/dependency/dept_internal.h | 26 +++++++++
 kernel/dependency/dept_proc.c     | 95 +++++++++++++++++++++++++++++++
 4 files changed, 131 insertions(+), 15 deletions(-)
 create mode 100644 kernel/dependency/dept_internal.h
 create mode 100644 kernel/dependency/dept_proc.c

diff --git a/kernel/dependency/Makefile b/kernel/dependency/Makefile
index b5cfb8a03c0c..92f165400187 100644
--- a/kernel/dependency/Makefile
+++ b/kernel/dependency/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_DEPT) += dept.o
+obj-$(CONFIG_DEPT) += dept_proc.o
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index d3b6d2f4cd7b..c5e23e9184b8 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -74,6 +74,7 @@
 #include <linux/dept.h>
 #include <linux/utsname.h>
 #include <linux/kernel.h>
+#include "dept_internal.h"
 
 static int dept_stop;
 static int dept_per_cpu_ready;
@@ -261,20 +262,13 @@ static inline bool valid_key(struct dept_key *k)
  *       have been freed will be placed.
  */
 
-enum object_t {
-#define OBJECT(id, nr) OBJECT_##id,
-	#include "dept_object.h"
-#undef  OBJECT
-	OBJECT_NR,
-};
-
 #define OBJECT(id, nr)							\
 static struct dept_##id spool_##id[nr];					\
 static DEFINE_PER_CPU(struct llist_head, lpool_##id);
 	#include "dept_object.h"
 #undef  OBJECT
 
-static struct dept_pool pool[OBJECT_NR] = {
+struct dept_pool dept_pool[OBJECT_NR] = {
 #define OBJECT(id, nr) {						\
 	.name = #id,							\
 	.obj_sz = sizeof(struct dept_##id),				\
@@ -304,7 +298,7 @@ static void *from_pool(enum object_t t)
 	if (DEPT_WARN_ON(!irqs_disabled()))
 		return NULL;
 
-	p = &pool[t];
+	p = &dept_pool[t];
 
 	/*
 	 * Try local pool first.
@@ -339,7 +333,7 @@ static void *from_pool(enum object_t t)
 
 static void to_pool(void *o, enum object_t t)
 {
-	struct dept_pool *p = &pool[t];
+	struct dept_pool *p = &dept_pool[t];
 	struct llist_head *h;
 
 	preempt_disable();
@@ -2136,7 +2130,7 @@ void dept_map_copy(struct dept_map *to, struct dept_map *from)
 	clean_classes_cache(&to->map_key);
 }
 
-static LIST_HEAD(classes);
+LIST_HEAD(dept_classes);
 
 static inline bool within(const void *addr, void *start, unsigned long size)
 {
@@ -2168,7 +2162,7 @@ void dept_free_range(void *start, unsigned int sz)
 	while (unlikely(!dept_lock()))
 		cpu_relax();
 
-	list_for_each_entry_safe(c, n, &classes, all_node) {
+	list_for_each_entry_safe(c, n, &dept_classes, all_node) {
 		if (!within((void *)c->key, start, sz) &&
 		    !within(c->name, start, sz))
 			continue;
@@ -2244,7 +2238,7 @@ static struct dept_class *check_new_class(struct dept_key *local,
 	c->sub_id = sub_id;
 	c->key = (unsigned long)(k->base + sub_id);
 	hash_add_class(c);
-	list_add(&c->all_node, &classes);
+	list_add(&c->all_node, &dept_classes);
 unlock:
 	dept_unlock();
 caching:
@@ -2958,8 +2952,8 @@ static void migrate_per_cpu_pool(void)
 		struct llist_head *from;
 		struct llist_head *to;
 
-		from = &pool[i].boot_pool;
-		to = per_cpu_ptr(pool[i].lpool, boot_cpu);
+		from = &dept_pool[i].boot_pool;
+		to = per_cpu_ptr(dept_pool[i].lpool, boot_cpu);
 		move_llist(to, from);
 	}
 }
diff --git a/kernel/dependency/dept_internal.h b/kernel/dependency/dept_internal.h
new file mode 100644
index 000000000000..007c1eec6bab
--- /dev/null
+++ b/kernel/dependency/dept_internal.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Dept(DEPendency Tracker) - runtime dependency tracker internal header
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ */
+
+#ifndef __DEPT_INTERNAL_H
+#define __DEPT_INTERNAL_H
+
+#ifdef CONFIG_DEPT
+
+enum object_t {
+#define OBJECT(id, nr) OBJECT_##id,
+	#include "dept_object.h"
+#undef  OBJECT
+	OBJECT_NR,
+};
+
+extern struct list_head dept_classes;
+extern struct dept_pool dept_pool[];
+
+#endif
+#endif /* __DEPT_INTERNAL_H */
diff --git a/kernel/dependency/dept_proc.c b/kernel/dependency/dept_proc.c
new file mode 100644
index 000000000000..7d61dfbc5865
--- /dev/null
+++ b/kernel/dependency/dept_proc.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Procfs knobs for Dept(DEPendency Tracker)
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (C) 2021 LG Electronics, Inc. , Byungchul Park
+ */
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/dept.h>
+#include "dept_internal.h"
+
+static void *l_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	/*
+	 * XXX: Serialize list traversal if needed. The following might
+	 * give a wrong information on contention.
+	 */
+	return seq_list_next(v, &dept_classes, pos);
+}
+
+static void *l_start(struct seq_file *m, loff_t *pos)
+{
+	/*
+	 * XXX: Serialize list traversal if needed. The following might
+	 * give a wrong information on contention.
+	 */
+	return seq_list_start_head(&dept_classes, *pos);
+}
+
+static void l_stop(struct seq_file *m, void *v)
+{
+}
+
+static int l_show(struct seq_file *m, void *v)
+{
+	struct dept_class *fc = list_entry(v, struct dept_class, all_node);
+	struct dept_dep *d;
+	const char *prefix;
+
+	if (v == &dept_classes) {
+		seq_puts(m, "All classes:\n\n");
+		return 0;
+	}
+
+	prefix = fc->sched_map ? "<sched> " : "";
+	seq_printf(m, "[%p] %s%s\n", (void *)fc->key, prefix, fc->name);
+
+	/*
+	 * XXX: Serialize list traversal if needed. The following might
+	 * give a wrong information on contention.
+	 */
+	list_for_each_entry(d, &fc->dep_head, dep_node) {
+		struct dept_class *tc = d->wait->class;
+
+		prefix = tc->sched_map ? "<sched> " : "";
+		seq_printf(m, " -> [%p] %s%s\n", (void *)tc->key, prefix, tc->name);
+	}
+	seq_puts(m, "\n");
+
+	return 0;
+}
+
+static const struct seq_operations dept_deps_ops = {
+	.start	= l_start,
+	.next	= l_next,
+	.stop	= l_stop,
+	.show	= l_show,
+};
+
+static int dept_stats_show(struct seq_file *m, void *v)
+{
+	int r;
+
+	seq_puts(m, "Availability in the static pools:\n\n");
+#define OBJECT(id, nr)							\
+	r = atomic_read(&dept_pool[OBJECT_##id].obj_nr);		\
+	if (r < 0)							\
+		r = 0;							\
+	seq_printf(m, "%s\t%d/%d(%d%%)\n", #id, r, nr, (r * 100) / (nr));
+	#include "dept_object.h"
+#undef  OBJECT
+
+	return 0;
+}
+
+static int __init dept_proc_init(void)
+{
+	proc_create_seq("dept_deps", S_IRUSR, NULL, &dept_deps_ops);
+	proc_create_single("dept_stats", S_IRUSR, NULL, dept_stats_show);
+	return 0;
+}
+
+__initcall(dept_proc_init);
-- 
2.17.1


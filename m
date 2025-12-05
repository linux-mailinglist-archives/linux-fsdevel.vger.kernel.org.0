Return-Path: <linux-fsdevel+bounces-70762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C0BCA7312
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 11:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA3C6309AAD3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56422D060D;
	Fri,  5 Dec 2025 07:19:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1372F658A;
	Fri,  5 Dec 2025 07:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919164; cv=none; b=u/f55t5M3dQOAsl8PCMkCRdfhPuXw5vU84+2CdbYeD/Wfm05BbmXoYM0RUV48qAb4h+u4q1iLoqIEq0HoZ/FVfhGsEn78RR2SBp+b+Ud2yXEMQhwQfkaDGOj3qEsNDrGgIknEZi86jIJ6kPFl3tBTfiET7H7+gNeHij1AwuUpl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919164; c=relaxed/simple;
	bh=Y+xmySU8iBJf4wgaCS3HFXmmKdUbmc/gZF6oMdUD0Ss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=skfVuR74lg1NXKYcZqn4/pLLkHv7T7+pn1a6EFp2MObYu9dhZ5An7at+S+jRI+NAcyo4V2sp70S4k1yleMT6DqFiSm/gD2kZQVAo2msrRapOuhmMFuh1+CxPI5/zgZRRiuTAlpgLd6RToiDdFplpsS7dY0EXqIa9rCwx83jEnKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-8a-6932876bfbef
From: Byungchul Park <byungchul@sk.com>
To: linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com,
	torvalds@linux-foundation.org,
	damien.lemoal@opensource.wdc.com,
	linux-ide@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	will@kernel.org,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	joel@joelfernandes.org,
	sashal@kernel.org,
	daniel.vetter@ffwll.ch,
	duyuyang@gmail.com,
	johannes.berg@intel.com,
	tj@kernel.org,
	tytso@mit.edu,
	willy@infradead.org,
	david@fromorbit.com,
	amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	kernel-team@lge.com,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	mhocko@kernel.org,
	minchan@kernel.org,
	hannes@cmpxchg.org,
	vdavydov.dev@gmail.com,
	sj@kernel.org,
	jglisse@redhat.com,
	dennis@kernel.org,
	cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	vbabka@suse.cz,
	ngupta@vflare.org,
	linux-block@vger.kernel.org,
	josef@toxicpanda.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	dan.j.williams@intel.com,
	hch@infradead.org,
	djwong@kernel.org,
	dri-devel@lists.freedesktop.org,
	rodrigosiqueiramelo@gmail.com,
	melissa.srw@gmail.com,
	hamohammed.sa@gmail.com,
	harry.yoo@oracle.com,
	chris.p.wilson@intel.com,
	gwan-gyeong.mun@intel.com,
	max.byungchul.park@gmail.com,
	boqun.feng@gmail.com,
	longman@redhat.com,
	yunseong.kim@ericsson.com,
	ysk@kzalloc.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com,
	corbet@lwn.net,
	catalin.marinas@arm.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	sumit.semwal@linaro.org,
	gustavo@padovan.org,
	christian.koenig@amd.com,
	andi.shyti@kernel.org,
	arnd@arndb.de,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	rppt@kernel.org,
	surenb@google.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	paulmck@kernel.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	urezki@gmail.com,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	chuck.lever@oracle.com,
	neil@brown.name,
	okorniev@redhat.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	trondmy@kernel.org,
	anna@kernel.org,
	kees@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mark.rutland@arm.com,
	ada.coupriediaz@arm.com,
	kristina.martsenko@arm.com,
	wangkefeng.wang@huawei.com,
	broonie@kernel.org,
	kevin.brodsky@arm.com,
	dwmw@amazon.co.uk,
	shakeel.butt@linux.dev,
	ast@kernel.org,
	ziy@nvidia.com,
	yuzhao@google.com,
	baolin.wang@linux.alibaba.com,
	usamaarif642@gmail.com,
	joel.granados@kernel.org,
	richard.weiyang@gmail.com,
	geert+renesas@glider.be,
	tim.c.chen@linux.intel.com,
	linux@treblig.org,
	alexander.shishkin@linux.intel.com,
	lillian@star-ark.net,
	chenhuacai@kernel.org,
	francesco@valla.it,
	guoweikang.kernel@gmail.com,
	link@vivo.com,
	jpoimboe@kernel.org,
	masahiroy@kernel.org,
	brauner@kernel.org,
	thomas.weissschuh@linutronix.de,
	oleg@redhat.com,
	mjguzik@gmail.com,
	andrii@kernel.org,
	wangfushuai@baidu.com,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org,
	linux-i2c@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	2407018371@qq.com,
	dakr@kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	neilb@ownmail.net,
	bagasdotme@gmail.com,
	wsa+renesas@sang-engineering.com,
	dave.hansen@intel.com,
	geert@linux-m68k.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: [PATCH v18 05/42] dept: add proc knobs to show stats and dependency graph
Date: Fri,  5 Dec 2025 16:18:18 +0900
Message-Id: <20251205071855.72743-6-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTdxiH/Z97O6sn9cLRxYg1SkZiJwaXN27Z2Ifpicmi0cwY+SBncpRi
	uaQgiGZZYQgdQ+1qwEgVSoe10g7cqQhWyhhqM8RL8YKVCENhVAakhlEIt3UU45c3T97f730+
	vQyu7CJXM5r0bFGXLmhVlJyQjy6u3qQt3qLZ/M9VHLryWwkIjRsIuFjvpGDO3EiDQbpAgq/O
	geCvkAHB5IwZhzmTl4ayfARhjxeB3/c7Ds7r+RgEbaUIKgbNNAzd3QHhngAGA63FCObKj0KV
	1UXBcPlbCmYePMLhfJkPQfWrHhzGhvoQXPf2IvDYCyj429iAw5OBJfA0FKSgvewnCkY7L2Jg
	KfCQ0Hl/GMElswnBYLcHg/JLEgE3+9w0dA7PYvCy3ISBQ/oaOoxWDMznf4iMNxhM2WppsOk3
	wGt7BQ2zr+IgbMkAryNAQ93oIxIa9X00SC/uIjC4QwRI/V0kVBfVEHCh8iUFzZ52ArxNrzEo
	vdZAQq8zTILePEnCY4ePgPqAH0tI5mtdNzDeWelE/My0CfG3R4I4X+jK5S93jFC8Z8JC8Pes
	HF/z4zTG//xgE3+zoofmC1u6ad4iHeNd9lj+l+YhjK8eC5G71QfknyWLWk2OqPv48yR5yr1n
	2ZnBmOOlbjfSIym6BMkYjo3nfC1F1HvuL+0lIkyxMZzfP4VHeDkbzblOD5IlSM7g7JO1XPHU
	mfmAYZaxe7gz/yZFOgS7gTNUNJCRtYLdyrknlO+UaznHtdYFjYz9hCt7Pr3AyvlKVcnkgpJj
	q2RcY0ER+e5gFfeH3U8YkcKCFtUipSY9J03QaOPVKXnpmuPqQxlpEpr/Ntt3s4lNaMy3tw2x
	DFItVrTmxmmUpJCTlZfWhjgGVy1XjGg3a5SKZCHvhKjLOKg7phWz2tCHDKGKUmyZyE1WskeE
	bPGoKGaKuvcpxshW69G6+I2TdflpxWd/dR1KTaWi4u8Y93/RlrTu1J90VHfLwW8yv008QHXY
	x40tTvXOOdet8Kfrv2zaLTUFQofPvRDHyUXbY3d91LBmxVL3YfVXQso5Y2LGyVXBK9YE13+/
	2WIrtStr4e3OU4+jhYfY96bBFdaEfVvXtOOBbcMf9BaGE2U1KiIrRYiLxXVZwv+o9G4EaQMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+93XrqvVZUreiigGYU97UHGoiDLKW1BYEkISOeqSN6fFttQF
	YbqGy0zWYBs5zUc6QlfZzMrFaiiJZg8flWbZjJYmW610Kmpms+ifw+ec7/d8OX8cGpfWkQtp
	IU3NK9PkChklJsQHtmrXpORuENb1lDGg12XBB4+XhLfZbgJGgnoCiu7YKZiyPhCB3nGNhOau
	HALablcj8IzoEYxNWnHQ1U8TMGVsEkFw/L0ITNkIpl1NCMztRhy6257gYL+XjcFwzW8KfI1D
	CEyfvBRYBrMJCNjyERT2W0Uw+DQWvnkekTDdO4BB16gfgc37GwOvOxfBlDkFSsprQ+vmHxRM
	vniFg8XUhqDsUy8OQ4N9CO41fUTguplDwRdDHQ6d3rnweiRAQYvpMgXf2osw+F5DQWmOi4T2
	5z4ExVYjgv4eFwbaG3coMBc7CKjvc4qg3fcLgw9mIwbVjv3gsfUT0Goox0Lnhlx3I8Fq0WKh
	8hUD061HGIzbqkQ7KhE3pisguKra+xin65iiOPt1O+ImJ4yIC1ZqcU5nCLWN/gDOXazN4Cpb
	/RQ3MfKG4lyjpQT3rJzlKi5NYNzVF2u4+sJeUdzOI+JtJ3iFkM4r125PEic/e6M+E4jKzHc6
	0QXkWJqHwmiW2ch+zv9IzDDFRLHd3eP4DEcwS9naK/1kHhLTONO5hM0dLwgJNB3OHGILhpNm
	PASzjNUX1pEzYwmziXWOSv9FLmGra9x/Y8KYzaypa+IvS0OWkrwx0oDEpWhWFYoQ0tJT5YJi
	U7QqJVmTJmRGHz+d6kChZ7Kd/3X1IQp2xjYghkayORJ3xnpBSsrTVZrUBsTSuCxC4lesE6SS
	E3LNOV55+pjyrIJXNaBFNCGLlOxL4JOkzEm5mk/h+TO88r+K0WELL6B9QXXCxj2RVhw75D88
	9D7eP+9U+M/iHqY1qW/+0SJ75o5d8+tfDmh8C5LPD2Qid9bOxJifvK/jSWygb7Vl8UHnWvWq
	jMfvjsd3Eh7jii0JuoL4KPnNZg+vNydqKiuyKlYP723Zu3yeJa5McO0Gd8mN8GUxs2Pc2hyh
	I9HQ9qpJRqiS5etX4kqV/A+D/3p7SAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

It'd be useful to show dept internal stats and dependency graph on
runtime via proc for better information.  Introduce the knobs.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/dependency/Makefile        |  1 +
 kernel/dependency/dept.c          | 11 +---
 kernel/dependency/dept_internal.h | 10 ++++
 kernel/dependency/dept_proc.c     | 96 +++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 9 deletions(-)
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
index 18b238931699..dfe9dfdb6991 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -266,20 +266,13 @@ static bool valid_key(struct dept_key *k)
  *       have been freed will be placed.
  */
 
-enum object_t {
-#define OBJECT(id, nr) OBJECT_##id,
-	#include "dept_object.h"
-#undef OBJECT
-	OBJECT_NR,
-};
-
 #define OBJECT(id, nr)							\
 static struct dept_##id spool_##id[nr];					\
 static DEFINE_PER_CPU(struct llist_head, lpool_##id);
 	#include "dept_object.h"
 #undef OBJECT
 
-static struct dept_pool dept_pool[OBJECT_NR] = {
+struct dept_pool dept_pool[OBJECT_NR] = {
 #define OBJECT(id, nr) {						\
 	.name = #id,							\
 	.obj_sz = sizeof(struct dept_##id),				\
@@ -2083,7 +2076,7 @@ void dept_map_copy(struct dept_map *to, struct dept_map *from)
 	clean_classes_cache(&to->map_key);
 }
 
-static LIST_HEAD(dept_classes);
+LIST_HEAD(dept_classes);
 
 static bool within(const void *addr, void *start, unsigned long size)
 {
diff --git a/kernel/dependency/dept_internal.h b/kernel/dependency/dept_internal.h
index 9b28398fecfd..a1eb1ed647a7 100644
--- a/kernel/dependency/dept_internal.h
+++ b/kernel/dependency/dept_internal.h
@@ -279,5 +279,15 @@ struct dept_hash {
 	int				bits;
 };
 
+enum object_t {
+#define OBJECT(id, nr) OBJECT_##id,
+	#include "dept_object.h"
+#undef OBJECT
+	OBJECT_NR,
+};
+
+extern struct list_head dept_classes;
+extern struct dept_pool dept_pool[];
+
 #endif
 #endif /* __DEPT_INTERNAL_H */
diff --git a/kernel/dependency/dept_proc.c b/kernel/dependency/dept_proc.c
new file mode 100644
index 000000000000..97beaf397715
--- /dev/null
+++ b/kernel/dependency/dept_proc.c
@@ -0,0 +1,96 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Procfs knobs for Dept(DEPendency Tracker)
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (C) 2021 LG Electronics, Inc. , Byungchul Park
+ *  Copyright (C) 2024 SK hynix, Inc. , Byungchul Park
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



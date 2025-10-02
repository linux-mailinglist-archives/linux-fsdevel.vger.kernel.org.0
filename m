Return-Path: <linux-fsdevel+bounces-63221-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B24BB2DB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8A44A1B3E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2522D46D0;
	Thu,  2 Oct 2025 08:13:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DA72E1F08;
	Thu,  2 Oct 2025 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392804; cv=none; b=ftHe+HtrQzgepCQcj0nqqaaf63u5YoYv46Y7bxuPHyK9KffSSgUbN9D210SEsS8C8+/KbEBpNf/FciN/FAXV8hivNSs2BJxiVBwjQ0IP84TAOgAyeDvijWVoTQ3Ro1DrUllx2s3f4x3nOpg2cOE/0VV8hCBu/5r+aj3v9U8/Mbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392804; c=relaxed/simple;
	bh=ZmfdYPqra0Jp8Q7VY6TOhv1k+HEbVm8e+G9s4rWvxPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=V7vSw0YyUZjv0lJwviI6ADi6dZc5VInTZD0hjLgs8p1cB2Gd4BHpUYeU3zEZrl89+gZOhceetxiBn5dYo7AG9scjdrNVOzJ7MwHz+NTT0sBLY4ori9LVJs9eat261ATurpN0dubPzTAQfaC3c2ywCxaqf39dBxZX/Dl2SsBeaGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-d9-68de340c9c0c
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
	dave.hansen@linux.intel.com,
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
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v17 06/47] dept: add proc knobs to show stats and dependency graph
Date: Thu,  2 Oct 2025 17:12:06 +0900
Message-Id: <20251002081247.51255-7-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSX0xTdxQHcH/3/n63paPJXXXjjpnNVIn/mbi6nIfN7GGZ1weXRXxxPswG
	bmwVWtcqyDKTOltkA2PtbJ1UXAuTFamCrSiFgoiw2SChiGI1baFmwgiQJoRi+GdXML59Ts73
	nPNyxLQsRDLFas0xQadRFsgZCZZMpju3piuiqm1z1mwYPNWBITFdhuFyg5uB4I16BEOJMgSv
	5u00mHxJDIuWv0Vg67fQMH5/CkHliF0EY927YHKolUAyMkrB05kJBP92nEGwaDsCf1R7GXDG
	IjS8NDfR8DgRZyBgLWfA8XMbgSq7BcHpmgYGbFUeDL7hFhH0jy9QELZZKKj37IEeczUFtpsZ
	YL/4HwXW660UzNZeE8HDmjCGWkMWvHBVimAhlgNJhxYi56wYbkz2EQhEBwmMj1gYGPqnlMAd
	w7AIPM+6EUw/jlHgrhihoawlgaHt+WZwlv6J4dKVMAP+tgCGgZbLDFQ0NhGIupMEDPZXBIId
	PQQe1QcxNIyGKAhU1mHoa7lOIDYcIl/m86ZHiwzvvuJG/PycBfHTV0/TvMmcKu9PxGne6C3m
	5xJPGL5txoH5871beV9lRMQ7PMd5Y9ck4b2uTXyNf4zinVMJ8u2W7ySf5wsF6iJB98nOgxLV
	XWsjPhr94sTFO7sNyJvzK0oTc6yCu1Tnpd66y++jl8yw67lQaHbZq9g1nPfsCFkyzfas5gb7
	tyx5JbuX8zc/wEvGbBb3+6hx2VJ2Bzc/Z6bf7PyYq2/sWHYa+xk3EOtZzshSGVPcmLorSWX+
	SuOqXM3ozcAH3D1XCJuR1IFWXEMytaaoUKkuUGSrSjTqE9l52kIPSv1b7cmFA81oKpjbiVgx
	kqdLg1kRlYwoi/QlhZ2IE9PyVdKDrrBKJs1Xlvwo6LTf644XCPpO9KEYyzOk22eK82XsIeUx
	4YggHBV0b7uUOC3TgPZ2FY0mt9ddLfl6V3OOsTU+nlu6Y/9Au/VM73N/U3Xe2Qed8T3d+4fd
	Q69NO53lzlO7M9/PuJD5y0ZD6PCKwY/Os7dr9RryTm/FBUXeRMNa9w+2sfccvtcGeeG7a9vF
	8cDDDbfks1/99NuEtqYvl/vmU9u+6IEXrdryNYoutji8rn1BjvUqZc4mWqdX/g/Ingh0awMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSfUwTdxgH8P3urndHQ8mlI/GULSPdCIYNlAX1iTpjZhZuSyCLi5LolnGZ
	l7VCi7aIoCED2gLRvdRmbRnVWUEqQgeF4pApk4BrVCBQiy9RClaRQgCbbLyE8lILi/88+Tx5
	vnny/PHQuLRNtIlWqPIFtYrPlZFiQpy5S5scnTYi3zq0GR6WdhEwN1tJwPlmBwmVrb+JYLCp
	EcHoXCWChSUrDvqOMAErRjcFs4tPKQh3uhGYPUYcHG2lGPznXCVhqudfBCb/GAmWyVICgvYf
	EVSPWymY/CcdZkZviCDsC2DwaH4agX1sFYOxrgoEK+YcuFjjImGpfwAHi2kQwSW/D4cJZ2TY
	5h5B0FlfRsJLwzUcvGMxMDQXJOGu6SwJM57zGLxykmAr6xTBBasRgba2mQTzhVYCOp79RYFn
	ahmDYbMRg8bWDBi1jxPQa6jBIvdFUi0bwGrRYpEygYHpjxsYLNobKOirHSbAXpIA1n6vCJ7X
	V1Ow7E+FsC0P3I0BCny/mAhomhkQ7TUhbkH/M8E1uP7EOP39FZJz/O5A3FLIiLjZOi3O6Q2R
	tmc6iHM610murnea5EJzD0iuc95GcPdqWO5cfzLXUe2jON3fT6gvdx4S7z4i5CoKBPWWPdli
	+S2Tkzg28kmhpf3zEuRKPYOiaJZJY2/f7MDXTDKJ7OPHi+uOZeJZ10/jojXjTO877EPPR2t+
	m9nP3rx+h1gzwSSwVQHduiXMNnYpZMD/3/ke2+jsWncUs531+nvXM9JIRh/UYQYktqG3GlCs
	QlWg5BW521I0OfIilaIw5bs8ZSuK/JK9ePncdTTrTe9GDI1k0RJPgk8uFfEFmiJlN2JpXBYr
	ya4flkslR/iiU4I671v1iVxB043iaEK2QfJFlpAtZb7n84UcQTgmqN9MMTpqUwnKfBmWnm3P
	igv10AfbvwoWf21Pv2sJqPZRyvkPyv2fue9Iho5/2nJgwHnl+Wn6/VO/fvNhuzYmi3o3I8a7
	g/phhF+8+vFk4pYAlqLmM452W0LXNh7ucyVVONyFtuSLl3V5ZlO+s68WKEVZMPlSfu298vgW
	/f1dVcUvEpVxDWpyv4zQyPnUJFyt4V8DzIimIUcDAAA=
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
 kernel/dependency/dept.c          | 50 +++-------------
 kernel/dependency/dept_internal.h | 54 +++++++++++++++++
 kernel/dependency/dept_proc.c     | 96 +++++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+), 41 deletions(-)
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
index cbb036e8cc1d..dfe9dfdb6991 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -75,6 +75,7 @@
 #include <linux/dept.h>
 #include <linux/utsname.h>
 #include <linux/kernel.h>
+#include "dept_internal.h"
 
 static int dept_stop;
 static int dept_per_cpu_ready;
@@ -265,46 +266,13 @@ static bool valid_key(struct dept_key *k)
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
 
-struct dept_pool {
-	const char			*name;
-
-	/*
-	 * object size
-	 */
-	size_t				obj_sz;
-
-	/*
-	 * the number of the static array
-	 */
-	atomic_t			obj_nr;
-
-	/*
-	 * offset of ->pool_node
-	 */
-	size_t				node_off;
-
-	/*
-	 * pointer to the pool
-	 */
-	void				*spool;
-	struct llist_head		boot_pool;
-	struct llist_head __percpu	*lpool;
-};
-
-static struct dept_pool pool[OBJECT_NR] = {
+struct dept_pool dept_pool[OBJECT_NR] = {
 #define OBJECT(id, nr) {						\
 	.name = #id,							\
 	.obj_sz = sizeof(struct dept_##id),				\
@@ -334,7 +302,7 @@ static void *from_pool(enum object_t t)
 	if (DEPT_WARN_ON(!irqs_disabled()))
 		return NULL;
 
-	p = &pool[t];
+	p = &dept_pool[t];
 
 	/*
 	 * Try local pool first.
@@ -369,7 +337,7 @@ static void *from_pool(enum object_t t)
 
 static void to_pool(void *o, enum object_t t)
 {
-	struct dept_pool *p = &pool[t];
+	struct dept_pool *p = &dept_pool[t];
 	struct llist_head *h;
 
 	preempt_disable();
@@ -2108,7 +2076,7 @@ void dept_map_copy(struct dept_map *to, struct dept_map *from)
 	clean_classes_cache(&to->map_key);
 }
 
-static LIST_HEAD(classes);
+LIST_HEAD(dept_classes);
 
 static bool within(const void *addr, void *start, unsigned long size)
 {
@@ -2140,7 +2108,7 @@ void dept_free_range(void *start, unsigned int sz)
 	while (unlikely(!dept_lock()))
 		cpu_relax();
 
-	list_for_each_entry_safe(c, n, &classes, all_node) {
+	list_for_each_entry_safe(c, n, &dept_classes, all_node) {
 		if (!within((void *)c->key, start, sz) &&
 		    !within(c->name, start, sz))
 			continue;
@@ -2216,7 +2184,7 @@ static struct dept_class *check_new_class(struct dept_key *local,
 	c->sub_id = sub_id;
 	c->key = (unsigned long)(k->base + sub_id);
 	hash_add_class(c);
-	list_add(&c->all_node, &classes);
+	list_add(&c->all_node, &dept_classes);
 unlock:
 	dept_unlock();
 caching:
@@ -2951,8 +2919,8 @@ static void migrate_per_cpu_pool(void)
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
index 000000000000..6b39e5a2a830
--- /dev/null
+++ b/kernel/dependency/dept_internal.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Dept(DEPendency Tracker) - runtime dependency tracker internal header
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
+ */
+
+#ifndef __DEPT_INTERNAL_H
+#define __DEPT_INTERNAL_H
+
+#ifdef CONFIG_DEPT
+#include <linux/percpu.h>
+
+struct dept_pool {
+	const char			*name;
+
+	/*
+	 * object size
+	 */
+	size_t				obj_sz;
+
+	/*
+	 * the number of the static array
+	 */
+	atomic_t			obj_nr;
+
+	/*
+	 * offset of ->pool_node
+	 */
+	size_t				node_off;
+
+	/*
+	 * pointer to the pool
+	 */
+	void				*spool;
+	struct llist_head		boot_pool;
+	struct llist_head __percpu	*lpool;
+};
+
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
+#endif
+#endif /* __DEPT_INTERNAL_H */
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



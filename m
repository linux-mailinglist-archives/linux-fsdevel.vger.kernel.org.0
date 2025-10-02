Return-Path: <linux-fsdevel+bounces-63219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78280BB2D73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562113C37FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06B82E22BD;
	Thu,  2 Oct 2025 08:13:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77BD2DC348;
	Thu,  2 Oct 2025 08:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392800; cv=none; b=UhMPjwJzS8fRY6pKLzqcG1+G/e5n4Abp+NUInCg8nm6rymjixfouUs+fcYOrefwsNNqDOr8yFVYojLQsqwkEqYLu4mDHNr4JIS026d1bIfdaU8BnZiJO62cb4dhY0Ky+BCIQoRJMDAsfnnlD+UqQkVbAnIyhuTmUChB/sTiOHo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392800; c=relaxed/simple;
	bh=nN9ExQbVAlsLCauWop4E923xisRO8jFDTiAnIrNIRU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qpdgBsTfqbtu1PWXQ6b1Pf9OOSX5wZHpPnTvuUyTM+0/M6ikSZw7zSHIPzMsvqRVkOY4ifcq4GxIX+QIT18orooLwtKK9ns6n2tLObDGu0UAbstMc6mb5teVEa4fECeYLyzMTMG5fB4avsmTc3z8Ox3LJcx0mX1nQwptDUnY76Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-60-68de340b4819
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
Subject: [PATCH v17 02/47] dept: implement DEPT(DEPendency Tracker)
Date: Thu,  2 Oct 2025 17:12:02 +0900
Message-Id: <20251002081247.51255-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0xTZxiH953znUvRbsfOZGdsiUsj04iibGx5t5FNs0W+ZDcXTUy8N3Jm
	G7mYoigmJohgGEJWagppi1hAakerNa0QLnZTltXV2sklgQYobRdWRrB2W4oJU9Zxif897+/3
	5H3/eXlaMcqk85qik5K2SFWgZNNwWnx1y5ZVOZPqbeHxD2Dk/F0Mc8lqDNUuIwMDN+0IwnPV
	CKp6UhgW9F4OkvPjHKQ8XgQNg3oaDNEpFhpnzmNIWGsRmGJmDmZ+yYN4uI+BVGiaAuvUfxQs
	NByHq63uRdUwgKAlGqLhtncSgcdWwcIfuk4ahqdeBp/hEgvxwSYKLBUeBq6Y9QgutDlZaLji
	wtAT6eXA7voSwtYYBr+ulQJz458UGG70UTBv7eDgYdsEBmt5BpgDwwz8bjNx8DyaDSlLMXjt
	0xyEvjdgmI3pWQjfv8iAozZGQ3XvHAbPWCa0XLyGwdg8wcIdjw/DcG8TC7W3OhmYdKQYcE4H
	KfB7f8XgM/2AoX10kIJoJMiAO/CQ3p5POtxdFKkaWmCJo9mByLN/9Ygk2y/QpEq3OP78OEGT
	Svdp0u5/zBLPUwsmD1pFUh/YQnpMIY5U/jjGEYvrFHHbNu3asC8tN18q0JRK2q0fH0lTj1z/
	8IRpgTnzZGKKLke+IVyDZLwo5IhP5u3oBevrHMwSs8IGMRicp5d4rfCW6K6LLee04H9THBnc
	XIN4/lXhU7HTTJZiLGSIRv2jZV0uvCfG/7rOrKxcJ9pv3V3OZcL74nDUv3xWsehUJSqpFeeq
	TAw4P1nh18V7tiDWIbkFvdSBFJqi0kKVpiAnS11WpDmTdbS40IUW38167vn+bvTPwO5+JPBI
	uVo+kBFSKxhVaUlZYT8SeVq5Vn7ENqFWyPNVZWclbfFh7akCqaQfvcFj5Wvyd56ezlcIx1Qn
	peOSdELSvmgpXpZejtpuZmxvCfQdpt6efXDW2vrd9NCOsfu5eUS+4yttZRkr+7ujtj7vt4q9
	6QebLq3panTfe/b1HuNu086ej14Zyn03GTmKm73xxOXuQ1nOvAOqTmnOGfr2WPmqvRubPvsp
	MzuzP/JoVubfuf6LpK64JlL/udP4TWjdVl/i8vqZbZHsOuGcEpeoVdmbaG2J6n8RHv+4agMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH/d37uw9Hi9uSvFlRDOz9MioOGRlFdAmM/ironxx1a8P5YEvN
	ovKxlb3MBpu4ZS2lZbrMV9YKTbRWZqbL0kqnWctemj2mMXXZNPrn8D2f75dzzh+HJWXVVBir
	ij8oauIVajktwZLtkZnLJKu7lSuLf0ZCe3odhiFvFoaLN+00ZFXkUdBaWoKgZygLwe9RCwl6
	xzgGv8HJgNfXycB4jROByWUgwV6VTsCvsj80fG34icDY66Eh93M6hkHbWQTmPgsDnx9uhYGe
	exSMuz8S0DHcj8Dm+UOAp+4kAr8pFi4XVNIw2txCQq6xFcGVXjcJn8oCZpWzG0FNUQYNH3Ju
	kdDmmQovhgZpaDSeoWHAdZGAb2U0WDNqKMi3GBBkFt6kwZRfgcHx9i4Drq9jBHSZDASUVERD
	j60PQ1NOARG4L5AqDwVLbiYRKJ8IMN64R4DPVszA08IuDLa0cLA0t1HwrsjMwFhvBIxbE8BZ
	8pEB93kjhtKBFmqjEQm/9dlYKK6sJgT9cz8t2C/ZkTA6YkCC92omKehzAm1D/yAp6CpThKtN
	/bQwMvSSFmqGrVh4UsALF5qXCQ6zmxF0tW+YHet2S9bvE9WqZFGzYkOMRNl+bV2i2U8d+tbl
	IdNQ43N8GgWzPLeaN5yzUxOa5hbwr175yAkdws3jK8/1TXKSa5rNt7uWnkYsO53bzN+yCBMY
	c+F8nqFlMi7l1vAD369R/0bO5UvK6iZ5MLeWb+ttmlwlC2T0gzoiB0msKKgYhajik+MUKvWa
	5dpYZWq86tDyvQlxFSjwTbajYxfuIG/b1nrEsUg+ReoKdytllCJZmxpXj3iWlIdIY4q6lDLp
	PkXqYVGTsEeTpBa19WgWi+Wh0m27xBgZd0BxUIwVxURR898l2OCwNBS90DtNayKpIN8ixvso
	JXpX8u1TS6YmyRfNPB+5fXb3TioqH9eGlTdsye8cHqmV+t+3UvMfPyrd/+OEujo9yaHbdOnI
	i+O+AxHKZx2O9XOiluI+naX8y4egjuDE0JTOVZCdV7XwtTPp2NHsrJDuWsv9B1PuZJhVHmyd
	2zgjirvOyrFWqYhYTGq0ir9TXV5jSQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

CURRENT STATUS
--------------
lockdep tracks acquisition order of locks in order to detect deadlock,
and IRQ and IRQ enable/disable state as well to take accident
acquisitions into account.

lockdep should be turned off once it detects and reports a deadlock
since the data structure and algorithm are not reusable after detection
because of the complex design.

PROBLEM
-------
*Waits* and their *events* that never reach eventually cause deadlock.
However, lockdep is only interested in lock acquisition order, forcing
to emulate lock acqusition even for just waits and events that have
nothing to do with real lock.

Even worse, no one likes lockdep's false positive detection because that
prevents further one that might be more valuable.  That's why all the
kernel developers are sensitive to lockdep's false positive.

Besides those, by tracking acquisition order, it cannot correctly deal
with read lock and cross-event e.g. wait_for_completion()/complete() for
deadlock detection.  lockdep is no longer a good tool for that purpose.

SOLUTION
--------
Again, *waits* and their *events* that never reach eventually cause
deadlock.  The new solution, DEPT(DEPendency Tracker), focuses on waits
and events themselves.  dept tracks waits and events and report it if
any event would be never reachable.

dept does:
   . Works with read lock in the right way.
   . Works with any wait and event e.i. cross-event.
   . Continue to work even after reporting multiple times.
   . Provides simple and intuitive APIs.
   . Does exactly what dependency checker should do.

Q & A
-----
Q. Is this the first try ever to address the problem?
A. No, cross-release feature (b09be676e0ff2 locking/lockdep: Implement
   the 'crossrelease' feature) addressed it that was a lockdep extension
   and merged but reverted shortly because:

   cross-release started to report valuable hidden problems but started
   to give report false positive reports as well.  For sure, no one
   likes lockdep's false positive reports since it makes lockdep stop,
   preventing reporting further real problems.

Q. Why not dept was developed as an extension of lockdep?
A. lockdep definitely includes all the efforts great developers have
   made for a long time so as to be quite stable enough.  But I had to
   design and implement newly because of the following:

   1) lockdep was designed to track lock acquisition order.  The APIs
      and implementation do not fit on wait-event model.
   2) lockdep is turned off on detection including false positive.
      Which is terrible and prevents developing any extension for
      stronger detection.

Q. Do you intend to totally replace lockdep?
A. No, lockdep also checks if lock usage is correct.  Of course, the
   dependency check routine should be replaced but the other functions
   should be still there.

Q. Do you mean the dependency check routine should be replaced right
   away?
A. No, I admit lockdep is stable enough thanks to great efforts kernel
   developers have made.  lockdep and dept, both should be in the kernel
   until dept gets considered stable.

Q. Stronger detection capability would give more false positive report.
   Which was a big problem when cross-release was introduced.  Is it ok
   with dept?
A. It's ok.  dept allows multiple reporting thanks to simple and quite
   generalized design.  Of course, false positive reports should be
   fixed anyway but it's no longer as a critical problem as it was.

Signed-off-by: Byungchul Park <byungchul@sk.com>
Tested-by: Yeoreum Yun <yeoreum.yun@arm.com>
Tested-by: Yunseong Kim <yskelg@gmail.com>
---
 include/linux/dept.h            |  446 +++++
 include/linux/hardirq.h         |    3 +
 include/linux/sched.h           |  108 ++
 init/init_task.c                |    2 +
 init/main.c                     |    2 +
 kernel/Makefile                 |    1 +
 kernel/dependency/Makefile      |    3 +
 kernel/dependency/dept.c        | 3002 +++++++++++++++++++++++++++++++
 kernel/dependency/dept_hash.h   |   10 +
 kernel/dependency/dept_object.h |   13 +
 kernel/exit.c                   |    1 +
 kernel/fork.c                   |    2 +
 kernel/module/main.c            |    4 +
 kernel/sched/core.c             |    9 +
 lib/Kconfig.debug               |   26 +
 lib/locking-selftest.c          |    2 +
 16 files changed, 3634 insertions(+)
 create mode 100644 include/linux/dept.h
 create mode 100644 kernel/dependency/Makefile
 create mode 100644 kernel/dependency/dept.c
 create mode 100644 kernel/dependency/dept_hash.h
 create mode 100644 kernel/dependency/dept_object.h

diff --git a/include/linux/dept.h b/include/linux/dept.h
new file mode 100644
index 000000000000..5f0d2d8c8cbe
--- /dev/null
+++ b/include/linux/dept.h
@@ -0,0 +1,446 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DEPT(DEPendency Tracker) - runtime dependency tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_H
+#define __LINUX_DEPT_H
+
+#ifdef CONFIG_DEPT
+
+#include <linux/types.h>
+
+struct task_struct;
+
+#define DEPT_MAX_STACK_ENTRY		16
+#define DEPT_MAX_WAIT_HIST		64
+#define DEPT_MAX_ECXT_HELD		48
+
+#define DEPT_MAX_SUBCLASSES		16
+#define DEPT_MAX_SUBCLASSES_EVT		2
+#define DEPT_MAX_SUBCLASSES_USR		(DEPT_MAX_SUBCLASSES / DEPT_MAX_SUBCLASSES_EVT)
+#define DEPT_MAX_SUBCLASSES_CACHE	2
+
+#define DEPT_SIRQ			0
+#define DEPT_HIRQ			1
+#define DEPT_IRQS_NR			2
+#define DEPT_SIRQF			(1UL << DEPT_SIRQ)
+#define DEPT_HIRQF			(1UL << DEPT_HIRQ)
+
+struct dept_ecxt;
+struct dept_iecxt {
+	struct dept_ecxt		*ecxt;
+	int				enirq;
+	/*
+	 * for preventing to add a new ecxt
+	 */
+	bool				staled;
+};
+
+struct dept_wait;
+struct dept_iwait {
+	struct dept_wait		*wait;
+	int				irq;
+	/*
+	 * for preventing to add a new wait
+	 */
+	bool				staled;
+	bool				touched;
+};
+
+struct dept_class {
+	union {
+		struct llist_node	pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t	ref;
+
+			/*
+			 * unique information about the class
+			 */
+			const char	*name;
+			unsigned long	key;
+			int		sub_id;
+
+			/*
+			 * for BFS
+			 */
+			unsigned int	bfs_gen;
+			struct dept_class *bfs_parent;
+			struct list_head bfs_node;
+
+			/*
+			 * for hashing this object
+			 */
+			struct hlist_node hash_node;
+
+			/*
+			 * for linking all classes
+			 */
+			struct list_head all_node;
+
+			/*
+			 * for associating its dependencies
+			 */
+			struct list_head dep_head;
+			struct list_head dep_rev_head;
+
+			/*
+			 * for tracking IRQ dependencies
+			 */
+			struct dept_iecxt iecxt[DEPT_IRQS_NR];
+			struct dept_iwait iwait[DEPT_IRQS_NR];
+
+			/*
+			 * classified by a map embedded in task_struct,
+			 * not an explicit map
+			 */
+			bool		sched_map;
+		};
+	};
+};
+
+struct dept_key {
+	union {
+		/*
+		 * Each byte-wise address will be used as its key.
+		 */
+		char			base[DEPT_MAX_SUBCLASSES];
+
+		/*
+		 * for caching the main class pointer
+		 */
+		struct dept_class	*classes[DEPT_MAX_SUBCLASSES_CACHE];
+	};
+};
+
+struct dept_map {
+	const char			*name;
+	struct dept_key			*keys;
+
+	/*
+	 * subclass that can be set from user
+	 */
+	int				sub_u;
+
+	/*
+	 * It's local copy for fast access to the associated classes.
+	 * Also used for dept_key for static maps.
+	 */
+	struct dept_key			map_key;
+
+	/*
+	 * wait timestamp associated to this map
+	 */
+	unsigned int			wgen;
+
+	/*
+	 * whether this map should be going to be checked or not
+	 */
+	bool				nocheck;
+};
+
+#define DEPT_MAP_INITIALIZER(n, k)					\
+{									\
+	.name = #n,							\
+	.keys = (struct dept_key *)(k),					\
+	.sub_u = 0,							\
+	.map_key = { .classes = { NULL, } },				\
+	.wgen = 0U,							\
+	.nocheck = false,						\
+}
+
+struct dept_stack {
+	union {
+		struct llist_node	pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t	ref;
+
+			/*
+			 * backtrace entries
+			 */
+			unsigned long	raw[DEPT_MAX_STACK_ENTRY];
+			int nr;
+		};
+	};
+};
+
+struct dept_ecxt {
+	union {
+		struct llist_node	pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t	ref;
+
+			/*
+			 * function that entered to this ecxt
+			 */
+			const char	*ecxt_fn;
+
+			/*
+			 * event function
+			 */
+			const char	*event_fn;
+
+			/*
+			 * associated class
+			 */
+			struct dept_class *class;
+
+			/*
+			 * flag indicating which IRQ has been
+			 * enabled within the event context
+			 */
+			unsigned long	enirqf;
+
+			/*
+			 * where the IRQ-enabled happened
+			 */
+			unsigned long	enirq_ip[DEPT_IRQS_NR];
+			struct dept_stack *enirq_stack[DEPT_IRQS_NR];
+
+			/*
+			 * where the event context started
+			 */
+			unsigned long	ecxt_ip;
+			struct dept_stack *ecxt_stack;
+
+			/*
+			 * where the event triggered
+			 */
+			unsigned long	event_ip;
+			struct dept_stack *event_stack;
+		};
+	};
+};
+
+struct dept_wait {
+	union {
+		struct llist_node	pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t	ref;
+
+			/*
+			 * function causing this wait
+			 */
+			const char	*wait_fn;
+
+			/*
+			 * the associated class
+			 */
+			struct dept_class *class;
+
+			/*
+			 * which IRQ the wait was placed in
+			 */
+			unsigned long	irqf;
+
+			/*
+			 * where the IRQ wait happened
+			 */
+			unsigned long	irq_ip[DEPT_IRQS_NR];
+			struct dept_stack *irq_stack[DEPT_IRQS_NR];
+
+			/*
+			 * where the wait happened
+			 */
+			unsigned long	wait_ip;
+			struct dept_stack *wait_stack;
+
+			/*
+			 * whether this wait is for commit in scheduler
+			 */
+			bool		sched_sleep;
+		};
+	};
+};
+
+struct dept_dep {
+	union {
+		struct llist_node	pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t	ref;
+
+			/*
+			 * key data of dependency
+			 */
+			struct dept_ecxt *ecxt;
+			struct dept_wait *wait;
+
+			/*
+			 * This object can be referred without dept_lock
+			 * held but with IRQ disabled, e.g. for hash
+			 * lookup. So deferred deletion is needed.
+			 */
+			struct rcu_head rh;
+
+			/*
+			 * for hashing this object
+			 */
+			struct hlist_node hash_node;
+
+			/*
+			 * for linking to a class object
+			 */
+			struct list_head dep_node;
+			struct list_head dep_rev_node;
+		};
+	};
+};
+
+struct dept_hash {
+	/*
+	 * hash table
+	 */
+	struct hlist_head		*table;
+
+	/*
+	 * size of the table e.i. 2^bits
+	 */
+	int				bits;
+};
+
+struct dept_ecxt_held {
+	/*
+	 * associated event context
+	 */
+	struct dept_ecxt		*ecxt;
+
+	/*
+	 * unique key for this dept_ecxt_held
+	 */
+	struct dept_map			*map;
+
+	/*
+	 * class of the ecxt of this dept_ecxt_held
+	 */
+	struct dept_class		*class;
+
+	/*
+	 * the wgen when the event context started
+	 */
+	unsigned int			wgen;
+
+	/*
+	 * subclass that only works in the local context
+	 */
+	int				sub_l;
+};
+
+struct dept_wait_hist {
+	/*
+	 * associated wait
+	 */
+	struct dept_wait		*wait;
+
+	/*
+	 * unique id of all waits system-wise until wrapped
+	 */
+	unsigned int			wgen;
+
+	/*
+	 * local context id to identify IRQ context
+	 */
+	unsigned int			ctxt_id;
+};
+
+extern void dept_on(void);
+extern void dept_off(void);
+extern void dept_init(void);
+extern void dept_task_init(struct task_struct *t);
+extern void dept_task_exit(struct task_struct *t);
+extern void dept_free_range(void *start, unsigned int sz);
+
+extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
+extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
+extern void dept_map_copy(struct dept_map *to, struct dept_map *from);
+extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l);
+extern void dept_stage_wait(struct dept_map *m, struct dept_key *k, unsigned long ip, const char *w_fn);
+extern void dept_request_event_wait_commit(void);
+extern void dept_clean_stage(void);
+extern void dept_ttwu_stage_wait(struct task_struct *t, unsigned long ip);
+extern void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *c_fn, const char *e_fn, int sub_l);
+extern bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f);
+extern void dept_request_event(struct dept_map *m);
+extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *e_fn);
+extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long ip);
+extern void dept_sched_enter(void);
+extern void dept_sched_exit(void);
+
+static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
+{
+	dept_ecxt_enter(m, 0UL, 0UL, NULL, NULL, 0);
+}
+
+/*
+ * for users who want to manage external keys
+ */
+extern void dept_key_init(struct dept_key *k);
+extern void dept_key_destroy(struct dept_key *k);
+extern void dept_map_ecxt_modify(struct dept_map *m, unsigned long e_f, struct dept_key *new_k, unsigned long new_e_f, unsigned long new_ip, const char *new_c_fn, const char *new_e_fn, int new_sub_l);
+
+extern void dept_softirq_enter(void);
+extern void dept_hardirq_enter(void);
+extern void dept_softirqs_on_ip(unsigned long ip);
+extern void dept_hardirqs_on(void);
+extern void dept_softirqs_off(void);
+extern void dept_hardirqs_off(void);
+#else /* !CONFIG_DEPT */
+struct dept_key { };
+struct dept_map { };
+
+#define DEPT_MAP_INITIALIZER(n, k) { }
+
+#define dept_on()					do { } while (0)
+#define dept_off()					do { } while (0)
+#define dept_init()					do { } while (0)
+#define dept_task_init(t)				do { } while (0)
+#define dept_task_exit(t)				do { } while (0)
+#define dept_free_range(s, sz)				do { } while (0)
+
+#define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
+#define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
+#define dept_map_copy(t, f)				do { } while (0)
+#define dept_wait(m, w_f, ip, w_fn, sl)			do { (void)(w_fn); } while (0)
+#define dept_stage_wait(m, k, ip, w_fn)			do { (void)(k); (void)(w_fn); } while (0)
+#define dept_request_event_wait_commit()		do { } while (0)
+#define dept_clean_stage()				do { } while (0)
+#define dept_ttwu_stage_wait(t, ip)			do { } while (0)
+#define dept_ecxt_enter(m, e_f, ip, c_fn, e_fn, sl)	do { (void)(c_fn); (void)(e_fn); } while (0)
+#define dept_ecxt_holding(m, e_f)			false
+#define dept_request_event(m)				do { } while (0)
+#define dept_event(m, e_f, ip, e_fn)			do { (void)(e_fn); } while (0)
+#define dept_ecxt_exit(m, e_f, ip)			do { } while (0)
+#define dept_sched_enter()				do { } while (0)
+#define dept_sched_exit()				do { } while (0)
+#define dept_ecxt_enter_nokeep(m)			do { } while (0)
+#define dept_key_init(k)				do { (void)(k); } while (0)
+#define dept_key_destroy(k)				do { (void)(k); } while (0)
+#define dept_map_ecxt_modify(m, e_f, n_k, n_e_f, n_ip, n_c_fn, n_e_fn, n_sl) do { (void)(n_k); (void)(n_c_fn); (void)(n_e_fn); } while (0)
+
+#define dept_softirq_enter()				do { } while (0)
+#define dept_hardirq_enter()				do { } while (0)
+#define dept_softirqs_on_ip(ip)				do { } while (0)
+#define dept_hardirqs_on()				do { } while (0)
+#define dept_softirqs_off()				do { } while (0)
+#define dept_hardirqs_off()				do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_H */
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index d57cab4d4c06..bb279dbbe748 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -5,6 +5,7 @@
 #include <linux/context_tracking_state.h>
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
+#include <linux/dept.h>
 #include <linux/ftrace_irq.h>
 #include <linux/sched.h>
 #include <linux/vtime.h>
@@ -106,6 +107,7 @@ void irq_exit_rcu(void);
  */
 #define __nmi_enter()						\
 	do {							\
+		dept_off();					\
 		lockdep_off();					\
 		arch_nmi_enter();				\
 		BUG_ON(in_nmi() == NMI_MASK);			\
@@ -128,6 +130,7 @@ void irq_exit_rcu(void);
 		__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);	\
 		arch_nmi_exit();				\
 		lockdep_on();					\
+		dept_on();					\
 	} while (0)
 
 #define nmi_exit()						\
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e4ce0a76831e..ddb162201ba1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -49,6 +49,8 @@
 #include <linux/tracepoint-defs.h>
 #include <linux/unwind_deferred_types.h>
 #include <asm/kmap_size.h>
+#include <linux/spinlock.h>
+#include <linux/dept.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -813,6 +815,110 @@ struct kmap_ctrl {
 #endif
 };
 
+#ifdef CONFIG_DEPT
+struct dept_task {
+	/*
+	 * all event contexts that have entered and before exiting
+	 */
+	struct dept_ecxt_held		ecxt_held[DEPT_MAX_ECXT_HELD];
+	int				ecxt_held_pos;
+
+	/*
+	 * ring buffer holding all waits that have happened
+	 */
+	struct dept_wait_hist		wait_hist[DEPT_MAX_WAIT_HIST];
+	int				wait_hist_pos;
+
+	/*
+	 * sequential id to identify each IRQ context
+	 */
+	unsigned int			irq_id[DEPT_IRQS_NR];
+
+	/*
+	 * for tracking IRQ-enabled points with cross-event
+	 */
+	unsigned int			wgen_enirq[DEPT_IRQS_NR];
+
+	/*
+	 * for keeping up-to-date IRQ-enabled points
+	 */
+	unsigned long			enirq_ip[DEPT_IRQS_NR];
+
+	/*
+	 * for reserving a current stack instance at each operation
+	 */
+	struct dept_stack		*stack;
+
+	/*
+	 * for preventing recursive call into DEPT engine
+	 */
+	int				recursive;
+
+	/*
+	 * for preventing reentrance to WARN*() while warning
+	 */
+	int				in_warning;
+
+	/*
+	 * for staging data to commit a wait
+	 */
+	struct dept_map			stage_m;
+	struct dept_map			*stage_real_m;
+	bool				stage_sched_map;
+	const char			*stage_w_fn;
+	unsigned long			stage_ip;
+	arch_spinlock_t			stage_lock;
+
+	/*
+	 * the number of missing ecxts
+	 */
+	int				missing_ecxt;
+
+	/*
+	 * for tracking IRQ-enable state
+	 */
+	bool				hardirqs_enabled;
+	bool				softirqs_enabled;
+
+	/*
+	 * whether the current is on do_exit()
+	 */
+	bool				task_exit;
+
+	/*
+	 * whether the current is running __schedule()
+	 */
+	bool				in_sched;
+};
+
+#define DEPT_TASK_INITIALIZER(t)				\
+{								\
+	.wait_hist = { { .wait = NULL, } },			\
+	.ecxt_held_pos = 0,					\
+	.wait_hist_pos = 0,					\
+	.irq_id = { 0U },					\
+	.wgen_enirq = { 0U },					\
+	.enirq_ip = { 0UL },					\
+	.stack = NULL,						\
+	.recursive = 0,						\
+	.in_warning = 0,					\
+	.stage_m = DEPT_MAP_INITIALIZER((t)->stage_m, NULL),	\
+	.stage_real_m = NULL,					\
+	.stage_sched_map = false,				\
+	.stage_w_fn = NULL,					\
+	.stage_ip = 0UL,					\
+	.stage_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED,\
+	.missing_ecxt = 0,					\
+	.hardirqs_enabled = false,				\
+	.softirqs_enabled = false,				\
+	.task_exit = false,					\
+	.in_sched = false,					\
+}
+#else
+struct dept_task { };
+#define DEPT_TASK_INITIALIZER(t) { }
+#endif
+
 struct task_struct {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	/*
@@ -1266,6 +1372,8 @@ struct task_struct {
 	struct held_lock		held_locks[MAX_LOCK_DEPTH];
 #endif
 
+	struct dept_task		dept_task;
+
 #if defined(CONFIG_UBSAN) && !defined(CONFIG_UBSAN_TRAP)
 	unsigned int			in_ubsan;
 #endif
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd90..84da2464c390 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -14,6 +14,7 @@
 #include <linux/numa.h>
 #include <linux/scs.h>
 #include <linux/plist.h>
+#include <linux/dept.h>
 
 #include <linux/uaccess.h>
 
@@ -204,6 +205,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.curr_chain_key = INITIAL_CHAIN_KEY,
 	.lockdep_recursion = 0,
 #endif
+	.dept_task = DEPT_TASK_INITIALIZER(init_task),
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	.ret_stack		= NULL,
 	.tracing_graph_pause	= ATOMIC_INIT(0),
diff --git a/init/main.c b/init/main.c
index 5753e9539ae6..8a9b289c58e4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -66,6 +66,7 @@
 #include <linux/debug_locks.h>
 #include <linux/debugobjects.h>
 #include <linux/lockdep.h>
+#include <linux/dept.h>
 #include <linux/kmemleak.h>
 #include <linux/padata.h>
 #include <linux/pid_namespace.h>
@@ -1038,6 +1039,7 @@ void start_kernel(void)
 		      panic_param);
 
 	lockdep_init();
+	dept_init();
 
 	/*
 	 * Need to run this when irqs are enabled, because it wants
diff --git a/kernel/Makefile b/kernel/Makefile
index c60623448235..72c0d9767c89 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -56,6 +56,7 @@ obj-y += dma/
 obj-y += entry/
 obj-y += unwind/
 obj-$(CONFIG_MODULES) += module/
+obj-y += dependency/
 
 obj-$(CONFIG_KCMP) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
diff --git a/kernel/dependency/Makefile b/kernel/dependency/Makefile
new file mode 100644
index 000000000000..b5cfb8a03c0c
--- /dev/null
+++ b/kernel/dependency/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DEPT) += dept.o
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
new file mode 100644
index 000000000000..712b7f79a095
--- /dev/null
+++ b/kernel/dependency/dept.c
@@ -0,0 +1,3002 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DEPT(DEPendency Tracker) - Runtime dependency tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
+ *
+ * DEPT provides a general way to detect potential deadlocks at runtime
+ * and the interest is not limited to typical lock but to every
+ * synchronization primitives.
+ *
+ * The following ideas were borrowed from LOCKDEP:
+ *
+ *    1) Use a graph to track relationship between classes.
+ *    2) Prevent performance regression using hash.
+ *
+ * The following items were enhanced from LOCKDEP:
+ *
+ *    1) Cover more deadlock cases.
+ *    2) Allow multiple reports.
+ *
+ * TODO: Both LOCKDEP and DEPT should co-exist until DEPT is considered
+ * stable. Then the dependency check routine should be replaced with
+ * DEPT after. It should finally look like:
+ *
+ *
+ *
+ * As is:
+ *
+ *    LOCKDEP
+ *    +-----------------------------------------+
+ *    | Lock usage correctness check            | <-> locks
+ *    |                                         |
+ *    |                                         |
+ *    | +-------------------------------------+ |
+ *    | | Dependency check                    | |
+ *    | | (by tracking lock acquisition order)| |
+ *    | +-------------------------------------+ |
+ *    |                                         |
+ *    +-----------------------------------------+
+ *
+ *    DEPT
+ *    +-----------------------------------------+
+ *    | Dependency check                        | <-> waits/events
+ *    | (by tracking wait and event context)    |
+ *    +-----------------------------------------+
+ *
+ *
+ *
+ * To be:
+ *
+ *    LOCKDEP
+ *    +-----------------------------------------+
+ *    | Lock usage correctness check            | <-> locks
+ *    |                                         |
+ *    |                                         |
+ *    |       (Request dependency check)        |
+ *    |                    T                    |
+ *    +--------------------|--------------------+
+ *                         |
+ *    DEPT                 V
+ *    +-----------------------------------------+
+ *    | Dependency check                        | <-> waits/events
+ *    | (by tracking wait and event context)    |
+ *    +-----------------------------------------+
+ */
+
+#include <linux/sched.h>
+#include <linux/stacktrace.h>
+#include <linux/spinlock.h>
+#include <linux/kallsyms.h>
+#include <linux/hash.h>
+#include <linux/dept.h>
+#include <linux/utsname.h>
+#include <linux/kernel.h>
+
+static int dept_stop;
+static int dept_per_cpu_ready;
+
+static inline struct dept_task *dept_task(void)
+{
+	return &current->dept_task;
+}
+
+#define DEPT_READY_WARN (!oops_in_progress && !dept_task()->in_warning)
+
+/*
+ * Make all operations using DEPT_WARN_ON() fail on oops_in_progress and
+ * prevent warning message.
+ */
+#define DEPT_WARN_ON_ONCE(c)						\
+	({								\
+		int __ret = !!(c);					\
+									\
+		if (likely(DEPT_READY_WARN)) {				\
+			++dept_task()->in_warning;			\
+			WARN_ONCE(c, "DEPT_WARN_ON_ONCE: " #c);		\
+			--dept_task()->in_warning;			\
+		}							\
+		__ret;							\
+	})
+
+#define DEPT_WARN_ONCE(s...)						\
+	({								\
+		if (likely(DEPT_READY_WARN)) {				\
+			++dept_task()->in_warning;			\
+			WARN_ONCE(1, "DEPT_WARN_ONCE: " s);		\
+			--dept_task()->in_warning;			\
+		}							\
+	})
+
+#define DEPT_WARN_ON(c)							\
+	({								\
+		int __ret = !!(c);					\
+									\
+		if (likely(DEPT_READY_WARN)) {				\
+			++dept_task()->in_warning;			\
+			WARN(c, "DEPT_WARN_ON: " #c);			\
+			--dept_task()->in_warning;			\
+		}							\
+		__ret;							\
+	})
+
+#define DEPT_WARN(s...)							\
+	({								\
+		if (likely(DEPT_READY_WARN)) {				\
+			++dept_task()->in_warning;			\
+			WARN(1, "DEPT_WARN: " s);			\
+			--dept_task()->in_warning;			\
+		}							\
+	})
+
+#define DEPT_STOP(s...)							\
+	({								\
+		WRITE_ONCE(dept_stop, 1);				\
+		if (likely(DEPT_READY_WARN)) {				\
+			++dept_task()->in_warning;			\
+			WARN(1, "DEPT_STOP: " s);			\
+			--dept_task()->in_warning;			\
+		}							\
+	})
+
+#define DEPT_INFO_ONCE(s...) pr_warn_once("DEPT_INFO_ONCE: " s)
+
+static arch_spinlock_t dept_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+
+/*
+ * DEPT internal engine should be cautious in using outside functions
+ * e.g. printk at reporting since that kind of usage might cause
+ * untrackable deadlock.
+ */
+static atomic_t dept_outworld = ATOMIC_INIT(0);
+
+static void dept_outworld_enter(void)
+{
+	atomic_inc(&dept_outworld);
+}
+
+static void dept_outworld_exit(void)
+{
+	atomic_dec(&dept_outworld);
+}
+
+static bool dept_outworld_entered(void)
+{
+	return atomic_read(&dept_outworld);
+}
+
+static bool dept_lock(void)
+{
+	while (!arch_spin_trylock(&dept_spin))
+		if (unlikely(dept_outworld_entered()))
+			return false;
+	return true;
+}
+
+static void dept_unlock(void)
+{
+	arch_spin_unlock(&dept_spin);
+}
+
+enum bfs_ret {
+	BFS_CONTINUE,
+	BFS_DONE,
+	BFS_SKIP,
+};
+
+static bool before(unsigned int a, unsigned int b)
+{
+	return (int)(a - b) < 0;
+}
+
+static bool valid_stack(struct dept_stack *s)
+{
+	return s && s->nr > 0;
+}
+
+static bool valid_class(struct dept_class *c)
+{
+	return c->key;
+}
+
+static void invalidate_class(struct dept_class *c)
+{
+	c->key = 0UL;
+}
+
+static struct dept_ecxt *dep_e(struct dept_dep *d)
+{
+	return d->ecxt;
+}
+
+static struct dept_wait *dep_w(struct dept_dep *d)
+{
+	return d->wait;
+}
+
+static struct dept_class *dep_fc(struct dept_dep *d)
+{
+	return dep_e(d)->class;
+}
+
+static struct dept_class *dep_tc(struct dept_dep *d)
+{
+	return dep_w(d)->class;
+}
+
+static const char *irq_str(int irq)
+{
+	if (irq == DEPT_SIRQ)
+		return "softirq";
+	if (irq == DEPT_HIRQ)
+		return "hardirq";
+	return "(unknown)";
+}
+
+/*
+ * Dept doesn't work either when it's stopped by DEPT_STOP() or in a nmi
+ * context.
+ */
+static bool dept_working(void)
+{
+	return !READ_ONCE(dept_stop) && !in_nmi();
+}
+
+/*
+ * Even k == NULL is considered as a valid key because it would use
+ * &->map_key as the key in that case.
+ */
+struct dept_key __dept_no_validate__;
+static bool valid_key(struct dept_key *k)
+{
+	return &__dept_no_validate__ != k;
+}
+
+/*
+ * Pool
+ * =====================================================================
+ * DEPT maintains pools to provide objects in a safe way.
+ *
+ *    1) Static pool is used at the beginning of booting time.
+ *    2) Local pool is tried first before the static pool. Objects that
+ *       have been freed will be placed.
+ */
+
+enum object_t {
+#define OBJECT(id, nr) OBJECT_##id,
+	#include "dept_object.h"
+#undef OBJECT
+	OBJECT_NR,
+};
+
+#define OBJECT(id, nr)							\
+static struct dept_##id spool_##id[nr];					\
+static DEFINE_PER_CPU(struct llist_head, lpool_##id);
+	#include "dept_object.h"
+#undef OBJECT
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
+static struct dept_pool pool[OBJECT_NR] = {
+#define OBJECT(id, nr) {						\
+	.name = #id,							\
+	.obj_sz = sizeof(struct dept_##id),				\
+	.obj_nr = ATOMIC_INIT(nr),					\
+	.node_off = offsetof(struct dept_##id, pool_node),		\
+	.spool = spool_##id,						\
+	.lpool = &lpool_##id, },
+	#include "dept_object.h"
+#undef OBJECT
+};
+
+/*
+ * Can use llist no matter whether CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG is
+ * enabled or not because NMI and other contexts in the same CPU never
+ * run inside of DEPT concurrently by preventing reentrance.
+ */
+static void *from_pool(enum object_t t)
+{
+	struct dept_pool *p;
+	struct llist_head *h;
+	struct llist_node *n;
+
+	/*
+	 * llist_del_first() doesn't allow concurrent access e.g.
+	 * between process and IRQ context.
+	 */
+	if (DEPT_WARN_ON(!irqs_disabled()))
+		return NULL;
+
+	p = &pool[t];
+
+	/*
+	 * Try local pool first.
+	 */
+	if (likely(dept_per_cpu_ready))
+		h = this_cpu_ptr(p->lpool);
+	else
+		h = &p->boot_pool;
+
+	n = llist_del_first(h);
+	if (n)
+		return (void *)n - p->node_off;
+
+	/*
+	 * Try static pool.
+	 */
+	if (atomic_read(&p->obj_nr) > 0) {
+		int idx = atomic_dec_return(&p->obj_nr);
+
+		if (idx >= 0)
+			return p->spool + (idx * p->obj_sz);
+	}
+
+	DEPT_INFO_ONCE("---------------------------------------------\n"
+		"  Some of Dept internal resources are run out.\n"
+		"  Dept might still work if the resources get freed.\n"
+		"  However, the chances are Dept will suffer from\n"
+		"  the lack from now. Needs to extend the internal\n"
+		"  resource pools. Ask max.byungchul.park@gmail.com\n");
+	return NULL;
+}
+
+static void to_pool(void *o, enum object_t t)
+{
+	struct dept_pool *p = &pool[t];
+	struct llist_head *h;
+
+	preempt_disable();
+	if (likely(dept_per_cpu_ready))
+		h = this_cpu_ptr(p->lpool);
+	else
+		h = &p->boot_pool;
+
+	llist_add(o + p->node_off, h);
+	preempt_enable();
+}
+
+#define OBJECT(id, nr)							\
+static void (*ctor_##id)(struct dept_##id *a);				\
+static void (*dtor_##id)(struct dept_##id *a);				\
+static struct dept_##id *new_##id(void)					\
+{									\
+	struct dept_##id *a;						\
+									\
+	a = (struct dept_##id *)from_pool(OBJECT_##id);			\
+	if (unlikely(!a))						\
+		return NULL;						\
+									\
+	atomic_set(&a->ref, 1);						\
+									\
+	if (ctor_##id)							\
+		ctor_##id(a);						\
+									\
+	return a;							\
+}									\
+									\
+static struct dept_##id *get_##id(struct dept_##id *a)			\
+{									\
+	atomic_inc(&a->ref);						\
+	return a;							\
+}									\
+									\
+static void put_##id(struct dept_##id *a)				\
+{									\
+	if (!atomic_dec_return(&a->ref)) {				\
+		if (dtor_##id)						\
+			dtor_##id(a);					\
+		to_pool(a, OBJECT_##id);				\
+	}								\
+}									\
+									\
+static void del_##id(struct dept_##id *a)				\
+{									\
+	put_##id(a);							\
+}									\
+									\
+static bool __maybe_unused id##_consumed(struct dept_##id *a)		\
+{									\
+	return a && atomic_read(&a->ref) > 1;				\
+}
+#include "dept_object.h"
+#undef OBJECT
+
+#define SET_CONSTRUCTOR(id, f) \
+static void (*ctor_##id)(struct dept_##id *a) = f
+
+static void initialize_dep(struct dept_dep *d)
+{
+	INIT_LIST_HEAD(&d->dep_node);
+	INIT_LIST_HEAD(&d->dep_rev_node);
+}
+SET_CONSTRUCTOR(dep, initialize_dep);
+
+static void initialize_class(struct dept_class *c)
+{
+	int i;
+
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		struct dept_iecxt *ie = &c->iecxt[i];
+		struct dept_iwait *iw = &c->iwait[i];
+
+		ie->ecxt = NULL;
+		ie->enirq = i;
+		ie->staled = false;
+
+		iw->wait = NULL;
+		iw->irq = i;
+		iw->staled = false;
+		iw->touched = false;
+	}
+	c->bfs_gen = 0U;
+
+	INIT_LIST_HEAD(&c->all_node);
+	INIT_LIST_HEAD(&c->dep_head);
+	INIT_LIST_HEAD(&c->dep_rev_head);
+	INIT_LIST_HEAD(&c->bfs_node);
+}
+SET_CONSTRUCTOR(class, initialize_class);
+
+static void initialize_ecxt(struct dept_ecxt *e)
+{
+	int i;
+
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		e->enirq_stack[i] = NULL;
+		e->enirq_ip[i] = 0UL;
+	}
+	e->ecxt_ip = 0UL;
+	e->ecxt_stack = NULL;
+	e->enirqf = 0UL;
+	e->event_ip = 0UL;
+	e->event_stack = NULL;
+}
+SET_CONSTRUCTOR(ecxt, initialize_ecxt);
+
+static void initialize_wait(struct dept_wait *w)
+{
+	int i;
+
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		w->irq_stack[i] = NULL;
+		w->irq_ip[i] = 0UL;
+	}
+	w->wait_ip = 0UL;
+	w->wait_stack = NULL;
+	w->irqf = 0UL;
+}
+SET_CONSTRUCTOR(wait, initialize_wait);
+
+static void initialize_stack(struct dept_stack *s)
+{
+	s->nr = 0;
+}
+SET_CONSTRUCTOR(stack, initialize_stack);
+
+#define OBJECT(id, nr) \
+static void (*ctor_##id)(struct dept_##id *a);
+	#include "dept_object.h"
+#undef OBJECT
+
+#undef SET_CONSTRUCTOR
+
+#define SET_DESTRUCTOR(id, f) \
+static void (*dtor_##id)(struct dept_##id *a) = f
+
+static void destroy_dep(struct dept_dep *d)
+{
+	if (dep_e(d))
+		put_ecxt(dep_e(d));
+	if (dep_w(d))
+		put_wait(dep_w(d));
+}
+SET_DESTRUCTOR(dep, destroy_dep);
+
+static void destroy_ecxt(struct dept_ecxt *e)
+{
+	int i;
+
+	for (i = 0; i < DEPT_IRQS_NR; i++)
+		if (e->enirq_stack[i])
+			put_stack(e->enirq_stack[i]);
+	if (e->class)
+		put_class(e->class);
+	if (e->ecxt_stack)
+		put_stack(e->ecxt_stack);
+	if (e->event_stack)
+		put_stack(e->event_stack);
+}
+SET_DESTRUCTOR(ecxt, destroy_ecxt);
+
+static void destroy_wait(struct dept_wait *w)
+{
+	int i;
+
+	for (i = 0; i < DEPT_IRQS_NR; i++)
+		if (w->irq_stack[i])
+			put_stack(w->irq_stack[i]);
+	if (w->class)
+		put_class(w->class);
+	if (w->wait_stack)
+		put_stack(w->wait_stack);
+}
+SET_DESTRUCTOR(wait, destroy_wait);
+
+#define OBJECT(id, nr) \
+static void (*dtor_##id)(struct dept_##id *a);
+	#include "dept_object.h"
+#undef OBJECT
+
+#undef SET_DESTRUCTOR
+
+/*
+ * Caching and hashing
+ * =====================================================================
+ * DEPT makes use of caching and hashing to improve performance. Each
+ * object can be obtained in O(1) with its key.
+ *
+ * NOTE: Currently we assume all the objects in the hashs will never be
+ * removed. Implement it when needed.
+ */
+
+/*
+ * Some information might be lost but it's only for hashing key.
+ */
+static unsigned long mix(unsigned long a, unsigned long b)
+{
+	int halfbits = sizeof(unsigned long) * 8 / 2;
+	unsigned long halfmask = (1UL << halfbits) - 1UL;
+
+	return (a << halfbits) | (b & halfmask);
+}
+
+static bool cmp_dep(struct dept_dep *d1, struct dept_dep *d2)
+{
+	return dep_fc(d1)->key == dep_fc(d2)->key &&
+	       dep_tc(d1)->key == dep_tc(d2)->key;
+}
+
+static unsigned long key_dep(struct dept_dep *d)
+{
+	return mix(dep_fc(d)->key, dep_tc(d)->key);
+}
+
+static bool cmp_class(struct dept_class *c1, struct dept_class *c2)
+{
+	return c1->key == c2->key;
+}
+
+static unsigned long key_class(struct dept_class *c)
+{
+	return c->key;
+}
+
+#define HASH(id, bits)							\
+static struct hlist_head table_##id[1 << (bits)];			\
+									\
+static struct hlist_head *head_##id(struct dept_##id *a)		\
+{									\
+	return table_##id + hash_long(key_##id(a), bits);		\
+}									\
+									\
+static struct dept_##id *hash_lookup_##id(struct dept_##id *a)		\
+{									\
+	struct dept_##id *b;						\
+									\
+	hlist_for_each_entry_rcu(b, head_##id(a), hash_node)		\
+		if (cmp_##id(a, b))					\
+			return b;					\
+	return NULL;							\
+}									\
+									\
+static void hash_add_##id(struct dept_##id *a)				\
+{									\
+	get_##id(a);							\
+	hlist_add_head_rcu(&a->hash_node, head_##id(a));		\
+}									\
+									\
+static void hash_del_##id(struct dept_##id *a)				\
+{									\
+	hlist_del_rcu(&a->hash_node);					\
+	put_##id(a);							\
+}
+#include "dept_hash.h"
+#undef HASH
+
+static struct dept_dep *lookup_dep(struct dept_class *fc,
+				   struct dept_class *tc)
+{
+	struct dept_ecxt onetime_e = { .class = fc };
+	struct dept_wait onetime_w = { .class = tc };
+	struct dept_dep  onetime_d = { .ecxt = &onetime_e,
+				       .wait = &onetime_w };
+	return hash_lookup_dep(&onetime_d);
+}
+
+static struct dept_class *lookup_class(unsigned long key)
+{
+	struct dept_class onetime_c = { .key = key };
+
+	return hash_lookup_class(&onetime_c);
+}
+
+/*
+ * Report
+ * =====================================================================
+ * DEPT prints useful information to help debugging on detection of
+ * problematic dependency.
+ */
+
+static void print_ip_stack(unsigned long ip, struct dept_stack *s)
+{
+	if (ip)
+		print_ip_sym(KERN_WARNING, ip);
+
+#ifdef CONFIG_DEPT_DEBUG
+	if (!s)
+		pr_warn("stack is NULL.\n");
+	else if (!s->nr)
+		pr_warn("stack->nr is 0.\n");
+	if (s)
+		pr_warn("stack ref is %d.\n", atomic_read(&s->ref));
+#endif
+
+	if (valid_stack(s)) {
+		pr_warn("stacktrace:\n");
+		stack_trace_print(s->raw, s->nr, 5);
+	}
+
+	if (!ip && !valid_stack(s))
+		pr_warn("(N/A)\n");
+}
+
+#define print_spc(spc, fmt, ...) \
+	pr_warn("%*c" fmt, (spc) * 3, ' ', ##__VA_ARGS__)
+
+static void print_diagram(struct dept_dep *d)
+{
+	struct dept_ecxt *e = dep_e(d);
+	struct dept_wait *w = dep_w(d);
+	struct dept_class *fc = dep_fc(d);
+	struct dept_class *tc = dep_tc(d);
+	unsigned long irqf;
+	int irq;
+	bool firstline = true;
+	int spc = 1;
+	const char *w_fn = w->wait_fn ?: "(unknown)";
+	const char *e_fn = e->event_fn ?: "(unknown)";
+	const char *c_fn = e->ecxt_fn ?: "(unknown)";
+	const char *fc_n = fc->sched_map ? "<sched>" : (fc->name ?: "(unknown)");
+	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
+
+	irqf = e->enirqf & w->irqf;
+	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+		if (!firstline)
+			pr_warn("\nor\n\n");
+		firstline = false;
+
+		print_spc(spc, "[S] %s(%s:%d)\n", c_fn, fc_n, fc->sub_id);
+		print_spc(spc, "    <%s interrupt>\n", irq_str(irq));
+		print_spc(spc + 1, "[W] %s(%s:%d)\n", w_fn, tc_n, tc->sub_id);
+		print_spc(spc, "[E] %s(%s:%d)\n", e_fn, fc_n, fc->sub_id);
+	}
+
+	if (!irqf) {
+		print_spc(spc, "[S] %s(%s:%d)\n", c_fn, fc_n, fc->sub_id);
+		print_spc(spc, "[W] %s(%s:%d)\n", w_fn, tc_n, tc->sub_id);
+		print_spc(spc, "[E] %s(%s:%d)\n", e_fn, fc_n, fc->sub_id);
+	}
+}
+
+static void print_dep(struct dept_dep *d)
+{
+	struct dept_ecxt *e = dep_e(d);
+	struct dept_wait *w = dep_w(d);
+	struct dept_class *fc = dep_fc(d);
+	struct dept_class *tc = dep_tc(d);
+	unsigned long irqf;
+	int irq;
+	const char *w_fn = w->wait_fn ?: "(unknown)";
+	const char *e_fn = e->event_fn ?: "(unknown)";
+	const char *c_fn = e->ecxt_fn ?: "(unknown)";
+	const char *fc_n = fc->sched_map ? "<sched>" : (fc->name ?: "(unknown)");
+	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
+
+	irqf = e->enirqf & w->irqf;
+	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+		pr_warn("%s has been enabled:\n", irq_str(irq));
+		print_ip_stack(e->enirq_ip[irq], e->enirq_stack[irq]);
+		pr_warn("\n");
+
+		pr_warn("[S] %s(%s:%d):\n", c_fn, fc_n, fc->sub_id);
+		print_ip_stack(e->ecxt_ip, e->ecxt_stack);
+		pr_warn("\n");
+
+		pr_warn("[W] %s(%s:%d) in %s context:\n",
+		       w_fn, tc_n, tc->sub_id, irq_str(irq));
+		print_ip_stack(w->irq_ip[irq], w->irq_stack[irq]);
+		pr_warn("\n");
+
+		pr_warn("[E] %s(%s:%d):\n", e_fn, fc_n, fc->sub_id);
+		print_ip_stack(e->event_ip, e->event_stack);
+	}
+
+	if (!irqf) {
+		pr_warn("[S] %s(%s:%d):\n", c_fn, fc_n, fc->sub_id);
+		print_ip_stack(e->ecxt_ip, e->ecxt_stack);
+		pr_warn("\n");
+
+		pr_warn("[W] %s(%s:%d):\n", w_fn, tc_n, tc->sub_id);
+		print_ip_stack(w->wait_ip, w->wait_stack);
+		pr_warn("\n");
+
+		pr_warn("[E] %s(%s:%d):\n", e_fn, fc_n, fc->sub_id);
+		print_ip_stack(e->event_ip, e->event_stack);
+	}
+}
+
+static void save_current_stack(int skip);
+
+/*
+ * Print all classes in a circle.
+ */
+static void print_circle(struct dept_class *c)
+{
+	struct dept_class *fc = c->bfs_parent;
+	struct dept_class *tc = c;
+	int i;
+
+	dept_outworld_enter();
+	save_current_stack(6);
+
+	pr_warn("===================================================\n");
+	pr_warn("DEPT: Circular dependency has been detected.\n");
+	pr_warn("%s %.*s %s\n", init_utsname()->release,
+		(int)strcspn(init_utsname()->version, " "),
+		init_utsname()->version,
+		print_tainted());
+	pr_warn("---------------------------------------------------\n");
+	pr_warn("summary\n");
+	pr_warn("---------------------------------------------------\n");
+
+	if (fc == tc)
+		pr_warn("*** AA DEADLOCK ***\n\n");
+	else
+		pr_warn("*** DEADLOCK ***\n\n");
+
+	i = 0;
+	do {
+		struct dept_dep *d = lookup_dep(fc, tc);
+
+		pr_warn("context %c\n", 'A' + (i++));
+		print_diagram(d);
+		if (fc != c)
+			pr_warn("\n");
+
+		tc = fc;
+		fc = fc->bfs_parent;
+	} while (tc != c);
+
+	pr_warn("\n");
+	pr_warn("[S]: start of the event context\n");
+	pr_warn("[W]: the wait blocked\n");
+	pr_warn("[E]: the event not reachable\n");
+
+	i = 0;
+	do {
+		struct dept_dep *d = lookup_dep(fc, tc);
+
+		pr_warn("---------------------------------------------------\n");
+		pr_warn("context %c's detail\n", 'A' + i);
+		pr_warn("---------------------------------------------------\n");
+		pr_warn("context %c\n", 'A' + (i++));
+		print_diagram(d);
+		pr_warn("\n");
+		print_dep(d);
+
+		tc = fc;
+		fc = fc->bfs_parent;
+	} while (tc != c);
+
+	pr_warn("---------------------------------------------------\n");
+	pr_warn("information that might be helpful\n");
+	pr_warn("---------------------------------------------------\n");
+	dump_stack();
+
+	dept_outworld_exit();
+}
+
+/*
+ * BFS(Breadth First Search)
+ * =====================================================================
+ * Whenever a new dependency is added into the graph, search the graph
+ * for a new circular dependency.
+ */
+
+struct bfs_ops {
+	void (*bfs_init)(void *, void *, void **);
+	void (*extend)(struct list_head *, void *);
+	void *(*dequeue)(struct list_head *);
+	enum bfs_ret (*callback)(void *, void *, void **);
+};
+
+static unsigned int bfs_gen;
+
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void bfs(void *root, struct bfs_ops *ops, void *in, void **out)
+{
+	LIST_HEAD(q);
+	enum bfs_ret ret;
+
+	if (DEPT_WARN_ON(!ops || !ops->bfs_init || !ops->extend ||
+				!ops->dequeue || !ops->callback))
+		return;
+
+	/*
+	 * Avoid zero bfs_gen.
+	 */
+	bfs_gen = bfs_gen + 1 ?: 1;
+	ops->bfs_init(root, in, out);
+
+	ret = ops->callback(root, in, out);
+	if (ret != BFS_CONTINUE)
+		return;
+
+	ops->extend(&q, root);
+	while (!list_empty(&q)) {
+		void *node = ops->dequeue(&q);
+
+		if (ret == BFS_DONE)
+			continue;
+
+		ret = ops->callback(node, in, out);
+		if (ret == BFS_CONTINUE)
+			ops->extend(&q, node);
+	}
+}
+
+/*
+ * Main operations
+ * =====================================================================
+ * Add dependencies - Each new dependency is added into the graph and
+ * checked if it forms a circular dependency.
+ *
+ * Track waits - Waits are queued into the ring buffer for later use to
+ * generate appropriate dependencies with cross-event.
+ *
+ * Track event contexts(ecxt) - Event contexts are pushed into local
+ * stack for later use to generate appropriate dependencies with waits.
+ */
+
+static unsigned long cur_enirqf(void);
+static int cur_irq(void);
+static unsigned int cur_ctxt_id(void);
+
+static struct dept_iecxt *iecxt(struct dept_class *c, int irq)
+{
+	return &c->iecxt[irq];
+}
+
+static struct dept_iwait *iwait(struct dept_class *c, int irq)
+{
+	return &c->iwait[irq];
+}
+
+static void stale_iecxt(struct dept_iecxt *ie)
+{
+	if (ie->ecxt)
+		put_ecxt(ie->ecxt);
+
+	WRITE_ONCE(ie->ecxt, NULL);
+	WRITE_ONCE(ie->staled, true);
+}
+
+static void set_iecxt(struct dept_iecxt *ie, struct dept_ecxt *e)
+{
+	/*
+	 * ->ecxt will never be updated once getting set until the class
+	 * gets removed.
+	 */
+	if (ie->ecxt)
+		DEPT_WARN_ON(1);
+	else
+		WRITE_ONCE(ie->ecxt, get_ecxt(e));
+}
+
+static void stale_iwait(struct dept_iwait *iw)
+{
+	if (iw->wait)
+		put_wait(iw->wait);
+
+	WRITE_ONCE(iw->wait, NULL);
+	WRITE_ONCE(iw->staled, true);
+}
+
+static void set_iwait(struct dept_iwait *iw, struct dept_wait *w)
+{
+	/*
+	 * ->wait will never be updated once getting set until the class
+	 * gets removed.
+	 */
+	if (iw->wait)
+		DEPT_WARN_ON(1);
+	else
+		WRITE_ONCE(iw->wait, get_wait(w));
+
+	iw->touched = true;
+}
+
+static void touch_iwait(struct dept_iwait *iw)
+{
+	iw->touched = true;
+}
+
+static void untouch_iwait(struct dept_iwait *iw)
+{
+	iw->touched = false;
+}
+
+static struct dept_stack *get_current_stack(void)
+{
+	struct dept_stack *s = dept_task()->stack;
+
+	return s ? get_stack(s) : NULL;
+}
+
+static void prepare_current_stack(void)
+{
+	DEPT_WARN_ON(dept_task()->stack);
+
+	dept_task()->stack = new_stack();
+}
+
+static void save_current_stack(int skip)
+{
+	struct dept_stack *s = dept_task()->stack;
+
+	if (!s)
+		return;
+
+	if (valid_stack(s))
+		return;
+
+	s->nr = stack_trace_save(s->raw, DEPT_MAX_STACK_ENTRY, skip);
+}
+
+static void finish_current_stack(void)
+{
+	struct dept_stack *s = dept_task()->stack;
+
+	/*
+	 * Fill the struct dept_stack with a valid stracktrace if it has
+	 * been referred at least once.
+	 */
+	if (stack_consumed(s))
+		save_current_stack(2);
+
+	dept_task()->stack = NULL;
+
+	/*
+	 * Actual deletion will happen at put_stack() if the stack has
+	 * been referred.
+	 */
+	if (s)
+		del_stack(s);
+}
+
+/*
+ * FIXME: For now, disable LOCKDEP while DEPT is working.
+ *
+ * Both LOCKDEP and DEPT report it on a deadlock detection using
+ * printk taking the risk of another deadlock that might be caused by
+ * locks of console or printk between inside and outside of them.
+ *
+ * For DEPT, it's no problem since multiple reports are allowed. But it
+ * would be a bad idea for LOCKDEP since it will stop even on a singe
+ * report. So we need to prevent LOCKDEP from its reporting the risk
+ * DEPT would take when reporting something.
+ */
+#include <linux/lockdep.h>
+
+void noinstr dept_off(void)
+{
+	dept_task()->recursive++;
+	lockdep_off();
+}
+
+void noinstr dept_on(void)
+{
+	lockdep_on();
+	dept_task()->recursive--;
+}
+
+static unsigned long dept_enter(void)
+{
+	unsigned long flags;
+
+	flags = arch_local_irq_save();
+	dept_off();
+	prepare_current_stack();
+	return flags;
+}
+
+static void dept_exit(unsigned long flags)
+{
+	finish_current_stack();
+	dept_on();
+	arch_local_irq_restore(flags);
+}
+
+static unsigned long dept_enter_recursive(void)
+{
+	unsigned long flags;
+
+	flags = arch_local_irq_save();
+	return flags;
+}
+
+static void dept_exit_recursive(unsigned long flags)
+{
+	arch_local_irq_restore(flags);
+}
+
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static struct dept_dep *__add_dep(struct dept_ecxt *e,
+				  struct dept_wait *w)
+{
+	struct dept_dep *d;
+
+	if (DEPT_WARN_ON(!valid_class(e->class)))
+		return NULL;
+
+	if (DEPT_WARN_ON(!valid_class(w->class)))
+		return NULL;
+
+	if (lookup_dep(e->class, w->class))
+		return NULL;
+
+	d = new_dep();
+	if (unlikely(!d))
+		return NULL;
+
+	d->ecxt = get_ecxt(e);
+	d->wait = get_wait(w);
+
+	/*
+	 * Add the dependency into hash and graph.
+	 */
+	hash_add_dep(d);
+	list_add(&d->dep_node, &dep_fc(d)->dep_head);
+	list_add(&d->dep_rev_node, &dep_tc(d)->dep_rev_head);
+	return d;
+}
+
+static void bfs_init_check_dl(void *node, void *in, void **out)
+{
+	struct dept_class *root = (struct dept_class *)node;
+	struct dept_dep *new = (struct dept_dep *)in;
+
+	root->bfs_gen = bfs_gen;
+	dep_tc(new)->bfs_parent = dep_fc(new);
+}
+
+static void bfs_extend_dep(struct list_head *h, void *node)
+{
+	struct dept_class *cur = (struct dept_class *)node;
+	struct dept_dep *d;
+
+	list_for_each_entry(d, &cur->dep_head, dep_node) {
+		struct dept_class *next = dep_tc(d);
+
+		if (bfs_gen == next->bfs_gen)
+			continue;
+		next->bfs_parent = cur;
+		next->bfs_gen = bfs_gen;
+		list_add_tail(&next->bfs_node, h);
+	}
+}
+
+static void *bfs_dequeue_dep(struct list_head *h)
+{
+	struct dept_class *c;
+
+	DEPT_WARN_ON(list_empty(h));
+
+	c = list_first_entry(h, struct dept_class, bfs_node);
+	list_del(&c->bfs_node);
+	return c;
+}
+
+static enum bfs_ret cb_check_dl(void *node, void *in, void **out)
+{
+	struct dept_class *cur = (struct dept_class *)node;
+	struct dept_dep *new = (struct dept_dep *)in;
+
+	if (cur == dep_fc(new)) {
+		print_circle(dep_tc(new));
+		return BFS_DONE;
+	}
+
+	return BFS_CONTINUE;
+}
+
+/*
+ * This function is actually in charge of reporting.
+ */
+static void check_dl_bfs(struct dept_dep *d)
+{
+	struct bfs_ops ops = {
+		.bfs_init = bfs_init_check_dl,
+		.extend = bfs_extend_dep,
+		.dequeue = bfs_dequeue_dep,
+		.callback = cb_check_dl,
+	};
+
+	bfs((void *)dep_tc(d), &ops, (void *)d, NULL);
+}
+
+static void bfs_init_dep(void *node, void *in, void **out)
+{
+	struct dept_class *root = (struct dept_class *)node;
+
+	root->bfs_gen = bfs_gen;
+}
+
+static void bfs_extend_dep_rev(struct list_head *h, void *node)
+{
+	struct dept_class *cur = (struct dept_class *)node;
+	struct dept_dep *d;
+
+	list_for_each_entry(d, &cur->dep_rev_head, dep_rev_node) {
+		struct dept_class *next = dep_fc(d);
+
+		if (bfs_gen == next->bfs_gen)
+			continue;
+		next->bfs_parent = cur;
+		next->bfs_gen = bfs_gen;
+		list_add_tail(&next->bfs_node, h);
+	}
+}
+
+static enum bfs_ret cb_find_iw(void *node, void *in, void **out)
+{
+	struct dept_class *cur = (struct dept_class *)node;
+	int irq = *(int *)in;
+	struct dept_iwait *iw;
+
+	if (DEPT_WARN_ON(!out))
+		return BFS_DONE;
+
+	iw = iwait(cur, irq);
+
+	/*
+	 * If any parent's ->wait was set, then the children would've
+	 * been touched.
+	 */
+	if (!iw->touched)
+		return BFS_SKIP;
+
+	if (!iw->wait)
+		return BFS_CONTINUE;
+
+	*out = iw;
+	return BFS_DONE;
+}
+
+static struct dept_iwait *find_iw_bfs(struct dept_class *c, int irq)
+{
+	struct dept_iwait *iw = iwait(c, irq);
+	struct dept_iwait *found = NULL;
+	struct bfs_ops ops = {
+		.bfs_init = bfs_init_dep,
+		.extend = bfs_extend_dep_rev,
+		.dequeue = bfs_dequeue_dep,
+		.callback = cb_find_iw,
+	};
+
+	bfs((void *)c, &ops, (void *)&irq, (void **)&found);
+
+	if (found)
+		return found;
+
+	untouch_iwait(iw);
+	return NULL;
+}
+
+static enum bfs_ret cb_touch_iw_find_ie(void *node, void *in, void **out)
+{
+	struct dept_class *cur = (struct dept_class *)node;
+	int irq = *(int *)in;
+	struct dept_iecxt *ie = iecxt(cur, irq);
+	struct dept_iwait *iw = iwait(cur, irq);
+
+	if (DEPT_WARN_ON(!out))
+		return BFS_DONE;
+
+	touch_iwait(iw);
+
+	if (!ie->ecxt)
+		return BFS_CONTINUE;
+	if (!*out)
+		*out = ie;
+
+	/*
+	 * Do touch_iwait() all the way.
+	 */
+	return BFS_CONTINUE;
+}
+
+static struct dept_iecxt *touch_iw_find_ie_bfs(struct dept_class *c,
+					       int irq)
+{
+	struct dept_iecxt *found = NULL;
+	struct bfs_ops ops = {
+		.bfs_init = bfs_init_dep,
+		.extend = bfs_extend_dep,
+		.dequeue = bfs_dequeue_dep,
+		.callback = cb_touch_iw_find_ie,
+	};
+
+	bfs((void *)c, &ops, (void *)&irq, (void **)&found);
+	return found;
+}
+
+/*
+ * Should be called with dept_lock held.
+ */
+static void __add_idep(struct dept_iecxt *ie, struct dept_iwait *iw)
+{
+	struct dept_dep *new;
+
+	/*
+	 * There's nothing to do.
+	 */
+	if (!ie || !iw || !ie->ecxt || !iw->wait)
+		return;
+
+	new = __add_dep(ie->ecxt, iw->wait);
+
+	/*
+	 * Deadlock detected. Let check_dl_bfs() report it.
+	 */
+	if (new) {
+		check_dl_bfs(new);
+		stale_iecxt(ie);
+		stale_iwait(iw);
+	}
+
+	/*
+	 * If !new, it would be the case of lack of object resource.
+	 * Just let it go and get checked by other chances. Retrying is
+	 * meaningless in that case.
+	 */
+}
+
+static void set_check_iecxt(struct dept_class *c, int irq,
+			    struct dept_ecxt *e)
+{
+	struct dept_iecxt *ie = iecxt(c, irq);
+
+	set_iecxt(ie, e);
+	__add_idep(ie, find_iw_bfs(c, irq));
+}
+
+static void set_check_iwait(struct dept_class *c, int irq,
+			    struct dept_wait *w)
+{
+	struct dept_iwait *iw = iwait(c, irq);
+
+	set_iwait(iw, w);
+	__add_idep(touch_iw_find_ie_bfs(c, irq), iw);
+}
+
+static void add_iecxt(struct dept_class *c, int irq, struct dept_ecxt *e,
+		      bool stack)
+{
+	/*
+	 * This access is safe since we ensure e->class has set locally.
+	 */
+	struct dept_task *dt = dept_task();
+	struct dept_iecxt *ie = iecxt(c, irq);
+
+	if (DEPT_WARN_ON(!valid_class(c)))
+		return;
+
+	if (unlikely(READ_ONCE(ie->staled)))
+		return;
+
+	/*
+	 * Skip add_iecxt() if ie->ecxt has ever been set at least once.
+	 * Which means it has a valid ->ecxt or been staled.
+	 */
+	if (READ_ONCE(ie->ecxt))
+		return;
+
+	if (unlikely(!dept_lock()))
+		return;
+
+	if (unlikely(ie->staled))
+		goto unlock;
+	if (ie->ecxt)
+		goto unlock;
+
+	e->enirqf |= (1UL << irq);
+
+	/*
+	 * Should be NULL since it's the first time that these
+	 * enirq_{ip,stack}[irq] have ever set.
+	 */
+	DEPT_WARN_ON(e->enirq_ip[irq]);
+	DEPT_WARN_ON(e->enirq_stack[irq]);
+
+	e->enirq_ip[irq] = dt->enirq_ip[irq];
+	e->enirq_stack[irq] = stack ? get_current_stack() : NULL;
+
+	set_check_iecxt(c, irq, e);
+unlock:
+	dept_unlock();
+}
+
+static void add_iwait(struct dept_class *c, int irq, struct dept_wait *w)
+{
+	struct dept_iwait *iw = iwait(c, irq);
+
+	if (DEPT_WARN_ON(!valid_class(c)))
+		return;
+
+	if (unlikely(READ_ONCE(iw->staled)))
+		return;
+
+	/*
+	 * Skip add_iwait() if iw->wait has ever been set at least once.
+	 * Which means it has a valid ->wait or been staled.
+	 */
+	if (READ_ONCE(iw->wait))
+		return;
+
+	if (unlikely(!dept_lock()))
+		return;
+
+	if (unlikely(iw->staled))
+		goto unlock;
+	if (iw->wait)
+		goto unlock;
+
+	w->irqf |= (1UL << irq);
+
+	/*
+	 * Should be NULL since it's the first time that these
+	 * irq_{ip,stack}[irq] have ever set.
+	 */
+	DEPT_WARN_ON(w->irq_ip[irq]);
+	DEPT_WARN_ON(w->irq_stack[irq]);
+
+	w->irq_ip[irq] = w->wait_ip;
+	w->irq_stack[irq] = get_current_stack();
+
+	set_check_iwait(c, irq, w);
+unlock:
+	dept_unlock();
+}
+
+static struct dept_wait_hist *hist(int pos)
+{
+	struct dept_task *dt = dept_task();
+
+	return dt->wait_hist + (pos % DEPT_MAX_WAIT_HIST);
+}
+
+static int hist_pos_next(void)
+{
+	struct dept_task *dt = dept_task();
+
+	return dt->wait_hist_pos % DEPT_MAX_WAIT_HIST;
+}
+
+static void hist_advance(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->wait_hist_pos++;
+	dt->wait_hist_pos %= DEPT_MAX_WAIT_HIST;
+}
+
+static struct dept_wait_hist *new_hist(void)
+{
+	struct dept_wait_hist *wh = hist(hist_pos_next());
+
+	hist_advance();
+	return wh;
+}
+
+static void add_hist(struct dept_wait *w, unsigned int wg, unsigned int ctxt_id)
+{
+	struct dept_wait_hist *wh = new_hist();
+
+	if (likely(wh->wait))
+		put_wait(wh->wait);
+
+	wh->wait = get_wait(w);
+	wh->wgen = wg;
+	wh->ctxt_id = ctxt_id;
+}
+
+/*
+ * Should be called after setting up e's iecxt and w's iwait.
+ */
+static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
+{
+	struct dept_class *fc = e->class;
+	struct dept_class *tc = w->class;
+	struct dept_dep *d;
+	int i;
+
+	if (lookup_dep(fc, tc))
+		return;
+
+	if (unlikely(!dept_lock()))
+		return;
+
+	/*
+	 * __add_dep() will lookup_dep() again with lock held.
+	 */
+	d = __add_dep(e, w);
+	if (d) {
+		check_dl_bfs(d);
+
+		for (i = 0; i < DEPT_IRQS_NR; i++) {
+			struct dept_iwait *fiw = iwait(fc, i);
+			struct dept_iecxt *found_ie;
+			struct dept_iwait *found_iw;
+
+			/*
+			 * '->touched == false' guarantees there's no
+			 * parent that has been set ->wait.
+			 */
+			if (!fiw->touched)
+				continue;
+
+			/*
+			 * find_iw_bfs() will untouch the iwait if
+			 * not found.
+			 */
+			found_iw = find_iw_bfs(fc, i);
+
+			if (!found_iw)
+				continue;
+
+			found_ie = touch_iw_find_ie_bfs(tc, i);
+			__add_idep(found_ie, found_iw);
+		}
+	}
+	dept_unlock();
+}
+
+static atomic_t wgen = ATOMIC_INIT(1);
+
+static int next_wgen(void)
+{
+	/*
+	 * Avoid zero wgen.
+	 */
+	return atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
+}
+
+static void add_wait(struct dept_class *c, unsigned long ip,
+		     const char *w_fn, int sub_l, bool sched_sleep)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_wait *w;
+	unsigned int wg;
+	int irq;
+	int i;
+
+	if (DEPT_WARN_ON(!valid_class(c)))
+		return;
+
+	w = new_wait();
+	if (unlikely(!w))
+		return;
+
+	WRITE_ONCE(w->class, get_class(c));
+	w->wait_ip = ip;
+	w->wait_fn = w_fn;
+	w->wait_stack = get_current_stack();
+	w->sched_sleep = sched_sleep;
+
+	irq = cur_irq();
+	if (irq < DEPT_IRQS_NR)
+		add_iwait(c, irq, w);
+
+	/*
+	 * Avoid adding dependency between user aware nested ecxt and
+	 * wait.
+	 */
+	for (i = dt->ecxt_held_pos - 1; i >= 0; i--) {
+		struct dept_ecxt_held *eh;
+
+		eh = dt->ecxt_held + i;
+
+		/*
+		 * the case of invalid key'ed one
+		 */
+		if (!eh->ecxt)
+			continue;
+
+		if (eh->ecxt->class != c || eh->sub_l == sub_l)
+			add_dep(eh->ecxt, w);
+	}
+
+	wg = next_wgen();
+	add_hist(w, wg, cur_ctxt_id());
+
+	del_wait(w);
+}
+
+static struct dept_ecxt_held *add_ecxt(struct dept_map *m,
+		struct dept_class *c, unsigned long ip, const char *c_fn,
+		const char *e_fn, int sub_l)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_ecxt_held *eh;
+	struct dept_ecxt *e;
+	unsigned long irqf;
+	unsigned int wg;
+	int irq;
+
+	if (DEPT_WARN_ON(!valid_class(c)))
+		return NULL;
+
+	if (DEPT_WARN_ON_ONCE(dt->ecxt_held_pos >= DEPT_MAX_ECXT_HELD))
+		return NULL;
+
+	wg = next_wgen();
+	if (m->nocheck) {
+		eh = dt->ecxt_held + (dt->ecxt_held_pos++);
+		eh->ecxt = NULL;
+		eh->map = m;
+		eh->class = get_class(c);
+		eh->wgen = wg;
+		eh->sub_l = sub_l;
+
+		return eh;
+	}
+
+	e = new_ecxt();
+	if (unlikely(!e))
+		return NULL;
+
+	e->class = get_class(c);
+	e->ecxt_ip = ip;
+	e->ecxt_stack = ip ? get_current_stack() : NULL;
+	e->event_fn = e_fn;
+	e->ecxt_fn = c_fn;
+
+	eh = dt->ecxt_held + (dt->ecxt_held_pos++);
+	eh->ecxt = get_ecxt(e);
+	eh->map = m;
+	eh->class = get_class(c);
+	eh->wgen = wg;
+	eh->sub_l = sub_l;
+
+	irqf = cur_enirqf();
+	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR)
+		add_iecxt(c, irq, e, false);
+
+	del_ecxt(e);
+	return eh;
+}
+
+static int find_ecxt_pos(struct dept_map *m, struct dept_class *c,
+			 bool newfirst)
+{
+	struct dept_task *dt = dept_task();
+	int i;
+
+	if (newfirst) {
+		for (i = dt->ecxt_held_pos - 1; i >= 0; i--) {
+			struct dept_ecxt_held *eh;
+
+			eh = dt->ecxt_held + i;
+			if (eh->map == m && eh->class == c)
+				return i;
+		}
+	} else {
+		for (i = 0; i < dt->ecxt_held_pos; i++) {
+			struct dept_ecxt_held *eh;
+
+			eh = dt->ecxt_held + i;
+			if (eh->map == m && eh->class == c)
+				return i;
+		}
+	}
+	return -1;
+}
+
+static bool pop_ecxt(struct dept_map *m, struct dept_class *c)
+{
+	struct dept_task *dt = dept_task();
+	int pos;
+	int i;
+
+	pos = find_ecxt_pos(m, c, true);
+	if (pos == -1)
+		return false;
+
+	if (dt->ecxt_held[pos].class)
+		put_class(dt->ecxt_held[pos].class);
+
+	if (dt->ecxt_held[pos].ecxt)
+		put_ecxt(dt->ecxt_held[pos].ecxt);
+
+	dt->ecxt_held_pos--;
+
+	for (i = pos; i < dt->ecxt_held_pos; i++)
+		dt->ecxt_held[i] = dt->ecxt_held[i + 1];
+	return true;
+}
+
+static bool good_hist(struct dept_wait_hist *wh, unsigned int wg)
+{
+	return wh->wait != NULL && before(wg, wh->wgen);
+}
+
+/*
+ * Binary-search the ring buffer for the earliest valid wait.
+ */
+static int find_hist_pos(unsigned int wg)
+{
+	int oldest;
+	int l;
+	int r;
+	int pos;
+
+	oldest = hist_pos_next();
+	if (unlikely(good_hist(hist(oldest), wg))) {
+		DEPT_INFO_ONCE("Need to expand the ring buffer.\n");
+		return oldest;
+	}
+
+	l = oldest + 1;
+	r = oldest + DEPT_MAX_WAIT_HIST - 1;
+	for (pos = (l + r) / 2; l <= r; pos = (l + r) / 2) {
+		struct dept_wait_hist *p = hist(pos - 1);
+		struct dept_wait_hist *wh = hist(pos);
+
+		if (!good_hist(p, wg) && good_hist(wh, wg))
+			return pos % DEPT_MAX_WAIT_HIST;
+		if (good_hist(wh, wg))
+			r = pos - 1;
+		else
+			l = pos + 1;
+	}
+	return -1;
+}
+
+static void do_event(struct dept_map *m, struct dept_map *real_m,
+		struct dept_class *c, unsigned int wg, unsigned long ip,
+		const char *e_fn)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_wait_hist *wh;
+	struct dept_ecxt_held *eh;
+	unsigned int ctxt_id;
+	int end;
+	int pos;
+	int i;
+
+	if (DEPT_WARN_ON(!valid_class(c)))
+		return;
+
+	if (m->nocheck)
+		return;
+
+	/*
+	 * The event was triggered before wait.
+	 */
+	if (!wg)
+		return;
+
+	/*
+	 * If an ecxt for this map exists, let the ecxt work for this
+	 * event and do not proceed it in do_event().
+	 */
+	if (find_ecxt_pos(real_m, c, false) != -1)
+		return;
+	eh = add_ecxt(m, c, 0UL, NULL, e_fn, 0);
+
+	if (!eh)
+		return;
+
+	if (DEPT_WARN_ON(!eh->ecxt))
+		goto out;
+
+	eh->ecxt->event_ip = ip;
+	eh->ecxt->event_stack = get_current_stack();
+
+	pos = find_hist_pos(wg);
+	if (pos == -1)
+		goto out;
+
+	ctxt_id = cur_ctxt_id();
+	end = hist_pos_next();
+	end = end > pos ? end : end + DEPT_MAX_WAIT_HIST;
+	for (wh = hist(pos); pos < end; wh = hist(++pos)) {
+		if (dt->in_sched && wh->wait->sched_sleep)
+			continue;
+
+		if (wh->ctxt_id == ctxt_id)
+			add_dep(eh->ecxt, wh->wait);
+	}
+
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		struct dept_ecxt *e;
+
+		if (before(dt->wgen_enirq[i], wg))
+			continue;
+
+		e = eh->ecxt;
+		add_iecxt(e->class, i, e, false);
+	}
+out:
+	/*
+	 * Pop ecxt that temporarily has been added to handle this event.
+	 */
+	pop_ecxt(m, c);
+}
+
+static void del_dep_rcu(struct rcu_head *rh)
+{
+	struct dept_dep *d = container_of(rh, struct dept_dep, rh);
+
+	preempt_disable();
+	del_dep(d);
+	preempt_enable();
+}
+
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void disconnect_class(struct dept_class *c)
+{
+	struct dept_dep *d, *n;
+	int i;
+
+	list_for_each_entry_safe(d, n, &c->dep_head, dep_node) {
+		list_del_rcu(&d->dep_node);
+		list_del_rcu(&d->dep_rev_node);
+		hash_del_dep(d);
+		call_rcu(&d->rh, del_dep_rcu);
+	}
+
+	list_for_each_entry_safe(d, n, &c->dep_rev_head, dep_rev_node) {
+		list_del_rcu(&d->dep_node);
+		list_del_rcu(&d->dep_rev_node);
+		hash_del_dep(d);
+		call_rcu(&d->rh, del_dep_rcu);
+	}
+
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		stale_iecxt(iecxt(c, i));
+		stale_iwait(iwait(c, i));
+	}
+}
+
+/*
+ * Context control
+ * =====================================================================
+ * Whether a wait is in {hard,soft}-IRQ context or whether
+ * {hard,soft}-IRQ has been enabled on the way to an event is very
+ * important to check dependency. All those things should be tracked.
+ */
+
+static unsigned long cur_enirqf(void)
+{
+	struct dept_task *dt = dept_task();
+	int he = dt->hardirqs_enabled;
+	int se = dt->softirqs_enabled;
+
+	if (he)
+		return DEPT_HIRQF | (se ? DEPT_SIRQF : 0UL);
+	return 0UL;
+}
+
+static int cur_irq(void)
+{
+	if (lockdep_softirq_context(current))
+		return DEPT_SIRQ;
+	if (lockdep_hardirq_context())
+		return DEPT_HIRQ;
+	return DEPT_IRQS_NR;
+}
+
+static unsigned int cur_ctxt_id(void)
+{
+	struct dept_task *dt = dept_task();
+	int irq = cur_irq();
+
+	/*
+	 * Normal process context
+	 */
+	if (irq == DEPT_IRQS_NR)
+		return 0U;
+
+	return dt->irq_id[irq] | (1UL << irq);
+}
+
+static void enirq_transition(int irq)
+{
+	struct dept_task *dt = dept_task();
+	int i;
+
+	/*
+	 * IRQ can cut in on the way to the event. Used for cross-event
+	 * detection.
+	 *
+	 *    wait context	event context(ecxt)
+	 *    ------------	-------------------
+	 *    wait event
+	 *       UPDATE wgen
+	 *			observe IRQ enabled
+	 *			   UPDATE wgen
+	 *			   keep the wgen locally
+	 *
+	 *			on the event
+	 *			   check the wgen kept
+	 */
+
+	dt->wgen_enirq[irq] = next_wgen();
+
+	for (i = dt->ecxt_held_pos - 1; i >= 0; i--) {
+		struct dept_ecxt_held *eh;
+		struct dept_ecxt *e;
+
+		eh = dt->ecxt_held + i;
+		e = eh->ecxt;
+		if (e)
+			add_iecxt(e->class, irq, e, true);
+	}
+}
+
+static void dept_enirq(unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long irqf = cur_enirqf();
+	int irq;
+	unsigned long flags;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	/*
+	 * IRQ ON/OFF transition might happen while Dept is working.
+	 * We cannot handle recursive entrance. Just ignore it.
+	 * Only transitions outside of Dept will be considered.
+	 */
+	if (dt->recursive)
+		return;
+
+	flags = dept_enter();
+
+	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+		dt->enirq_ip[irq] = ip;
+		enirq_transition(irq);
+	}
+
+	dept_exit(flags);
+}
+
+void dept_softirqs_on_ip(unsigned long ip)
+{
+	/*
+	 * Assumes that it's called with IRQ disabled so that accessing
+	 * current's fields is not racy.
+	 */
+	dept_task()->softirqs_enabled = true;
+	dept_enirq(ip);
+}
+
+void dept_hardirqs_on(void)
+{
+	/*
+	 * Assumes that it's called with IRQ disabled so that accessing
+	 * current's fields is not racy.
+	 */
+	dept_task()->hardirqs_enabled = true;
+	dept_enirq(_RET_IP_);
+}
+
+void dept_softirqs_off(void)
+{
+	/*
+	 * Assumes that it's called with IRQ disabled so that accessing
+	 * current's fields is not racy.
+	 */
+	dept_task()->softirqs_enabled = false;
+}
+
+void dept_hardirqs_off(void)
+{
+	/*
+	 * Assumes that it's called with IRQ disabled so that accessing
+	 * current's fields is not racy.
+	 */
+	dept_task()->hardirqs_enabled = false;
+}
+
+/*
+ * Ensure it's the outmost softirq context.
+ */
+void dept_softirq_enter(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->irq_id[DEPT_SIRQ] += 1UL << DEPT_IRQS_NR;
+}
+
+/*
+ * Ensure it's the outmost hardirq context.
+ */
+void dept_hardirq_enter(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->irq_id[DEPT_HIRQ] += 1UL << DEPT_IRQS_NR;
+}
+
+void dept_sched_enter(void)
+{
+	dept_task()->in_sched = true;
+}
+
+void dept_sched_exit(void)
+{
+	dept_task()->in_sched = false;
+}
+
+/*
+ * Exposed APIs
+ * =====================================================================
+ */
+
+static void clean_classes_cache(struct dept_key *k)
+{
+	int i;
+
+	for (i = 0; i < DEPT_MAX_SUBCLASSES_CACHE; i++) {
+		if (!READ_ONCE(k->classes[i]))
+			continue;
+
+		WRITE_ONCE(k->classes[i], NULL);
+	}
+}
+
+/*
+ * Assume we don't have to consider race with the map when
+ * dept_map_init() is called.
+ */
+void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u,
+		   const char *n)
+{
+	unsigned long flags;
+
+	if (unlikely(!dept_working())) {
+		m->nocheck = true;
+		return;
+	}
+
+	if (DEPT_WARN_ON(sub_u < 0)) {
+		m->nocheck = true;
+		return;
+	}
+
+	if (DEPT_WARN_ON(sub_u >= DEPT_MAX_SUBCLASSES_USR)) {
+		m->nocheck = true;
+		return;
+	}
+
+	/*
+	 * Allow recursive entrance.
+	 */
+	flags = dept_enter_recursive();
+
+	clean_classes_cache(&m->map_key);
+
+	m->keys = k;
+	m->sub_u = sub_u;
+	m->name = n;
+	m->wgen = 0U;
+	m->nocheck = !valid_key(k);
+
+	dept_exit_recursive(flags);
+}
+EXPORT_SYMBOL_GPL(dept_map_init);
+
+/*
+ * Assume we don't have to consider race with the map when
+ * dept_map_reinit() is called.
+ */
+void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u,
+		     const char *n)
+{
+	unsigned long flags;
+
+	if (unlikely(!dept_working())) {
+		m->nocheck = true;
+		return;
+	}
+
+	/*
+	 * Allow recursive entrance.
+	 */
+	flags = dept_enter_recursive();
+
+	if (k) {
+		clean_classes_cache(&m->map_key);
+		m->keys = k;
+		m->nocheck = !valid_key(k);
+	}
+
+	if (sub_u >= 0 && sub_u < DEPT_MAX_SUBCLASSES_USR)
+		m->sub_u = sub_u;
+
+	if (n)
+		m->name = n;
+
+	m->wgen = 0U;
+
+	dept_exit_recursive(flags);
+}
+EXPORT_SYMBOL_GPL(dept_map_reinit);
+
+void dept_map_copy(struct dept_map *to, struct dept_map *from)
+{
+	if (unlikely(!dept_working())) {
+		to->nocheck = true;
+		return;
+	}
+
+	*to = *from;
+
+	/*
+	 * XXX: 'to' might be in a stack or something. Using the address
+	 * in a stack segment as a key is meaningless. Just ignore the
+	 * case for now.
+	 */
+	if (!to->keys) {
+		to->nocheck = true;
+		return;
+	}
+
+	/*
+	 * Since the class cache can be modified concurrently we could
+	 * observe half pointers (64bit arch using 32bit copy
+	 * instructions).  Therefore clear the caches and take the
+	 * performance hit.
+	 */
+	clean_classes_cache(&to->map_key);
+}
+
+static LIST_HEAD(classes);
+
+static bool within(const void *addr, void *start, unsigned long size)
+{
+	return addr >= start && addr < start + size;
+}
+
+void dept_free_range(void *start, unsigned int sz)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_class *c, *n;
+	unsigned long flags;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive) {
+		DEPT_STOP("Failed to successfully free Dept objects.\n");
+		return;
+	}
+
+	flags = dept_enter();
+
+	/*
+	 * dept_free_range() should not fail.
+	 *
+	 * FIXME: Should be fixed if dept_free_range() causes deadlock
+	 * with dept_lock().
+	 */
+	while (unlikely(!dept_lock()))
+		cpu_relax();
+
+	list_for_each_entry_safe(c, n, &classes, all_node) {
+		if (!within((void *)c->key, start, sz) &&
+		    !within(c->name, start, sz))
+			continue;
+
+		hash_del_class(c);
+		disconnect_class(c);
+		list_del(&c->all_node);
+		invalidate_class(c);
+
+		/*
+		 * Actual deletion will happen on the rcu callback
+		 * that has been added in disconnect_class().
+		 */
+		del_class(c);
+	}
+	dept_unlock();
+	dept_exit(flags);
+
+	/*
+	 * Wait until even lockless hash_lookup_class() for the class
+	 * returns NULL.
+	 */
+	might_sleep();
+	synchronize_rcu();
+}
+
+static int sub_id(struct dept_map *m, int e)
+{
+	return (m ? m->sub_u : 0) + e * DEPT_MAX_SUBCLASSES_USR;
+}
+
+static struct dept_class *check_new_class(struct dept_key *local,
+					  struct dept_key *k, int sub_id,
+					  const char *n, bool sched_map)
+{
+	struct dept_class *c = NULL;
+
+	if (DEPT_WARN_ON(sub_id >= DEPT_MAX_SUBCLASSES))
+		return NULL;
+
+	if (DEPT_WARN_ON(!k))
+		return NULL;
+
+	/*
+	 * XXX: Assume that users prevent the map from using if any of
+	 * the cached keys has been invalidated. If not, the cache,
+	 * local->classes should not be used because it would be racy
+	 * with class deletion.
+	 */
+	if (local && sub_id < DEPT_MAX_SUBCLASSES_CACHE)
+		c = READ_ONCE(local->classes[sub_id]);
+
+	if (c)
+		return c;
+
+	c = lookup_class((unsigned long)k->base + sub_id);
+	if (c)
+		goto caching;
+
+	if (unlikely(!dept_lock()))
+		return NULL;
+
+	c = lookup_class((unsigned long)k->base + sub_id);
+	if (unlikely(c))
+		goto unlock;
+
+	c = new_class();
+	if (unlikely(!c))
+		goto unlock;
+
+	c->name = n;
+	c->sched_map = sched_map;
+	c->sub_id = sub_id;
+	c->key = (unsigned long)(k->base + sub_id);
+	hash_add_class(c);
+	list_add(&c->all_node, &classes);
+unlock:
+	dept_unlock();
+caching:
+	if (local && sub_id < DEPT_MAX_SUBCLASSES_CACHE)
+		WRITE_ONCE(local->classes[sub_id], c);
+
+	return c;
+}
+
+/*
+ * Called between dept_enter() and dept_exit().
+ */
+static void __dept_wait(struct dept_map *m, unsigned long w_f,
+			unsigned long ip, const char *w_fn, int sub_l,
+			bool sched_sleep, bool sched_map)
+{
+	int e;
+
+	/*
+	 * Be as conservative as possible. In case of multiple waits for
+	 * a single dept_map, we are going to keep only the last wait's
+	 * wgen for simplicity - keeping all wgens seems overengineering.
+	 *
+	 * Of course, it might cause missing some dependencies that
+	 * would rarely, probably never, happen but it helps avoid
+	 * false positive reports.
+	 */
+	for_each_set_bit(e, &w_f, DEPT_MAX_SUBCLASSES_EVT) {
+		struct dept_class *c;
+		struct dept_key *k;
+
+		k = m->keys ?: &m->map_key;
+		c = check_new_class(&m->map_key, k,
+				    sub_id(m, e), m->name, sched_map);
+		if (!c)
+			continue;
+
+		add_wait(c, ip, w_fn, sub_l, sched_sleep);
+	}
+}
+
+/*
+ * Called between dept_enter() and dept_exit().
+ */
+static void __dept_event(struct dept_map *m, struct dept_map *real_m,
+		unsigned long e_f, unsigned long ip, const char *e_fn,
+		bool sched_map)
+{
+	struct dept_class *c;
+	struct dept_key *k;
+	int e;
+
+	e = find_first_bit(&e_f, DEPT_MAX_SUBCLASSES_EVT);
+
+	if (DEPT_WARN_ON(e >= DEPT_MAX_SUBCLASSES_EVT))
+		return;
+
+	/*
+	 * An event is an event. If the caller passed more than single
+	 * event, then warn it and handle the event corresponding to
+	 * the first bit anyway.
+	 */
+	DEPT_WARN_ON(1UL << e != e_f);
+
+	k = m->keys ?: &m->map_key;
+	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, sched_map);
+
+	if (c)
+		do_event(m, real_m, c, READ_ONCE(m->wgen), ip, e_fn);
+}
+
+void dept_wait(struct dept_map *m, unsigned long w_f,
+	       unsigned long ip, const char *w_fn, int sub_l)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive)
+		return;
+
+	if (m->nocheck)
+		return;
+
+	flags = dept_enter();
+
+	__dept_wait(m, w_f, ip, w_fn, sub_l, false, false);
+
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_wait);
+
+void dept_stage_wait(struct dept_map *m, struct dept_key *k,
+		     unsigned long ip, const char *w_fn)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (m && m->nocheck)
+		return;
+
+	/*
+	 * Either m or k should be passed. Which means Dept relies on
+	 * either its own map or the caller's position in the code when
+	 * determining its class.
+	 */
+	if (DEPT_WARN_ON(!m && !k))
+		return;
+
+	/*
+	 * Allow recursive entrance.
+	 */
+	flags = dept_enter_recursive();
+
+	/*
+	 * Ensure the outmost dept_stage_wait() works.
+	 */
+	if (dt->stage_m.keys)
+		goto exit;
+
+	arch_spin_lock(&dt->stage_lock);
+	if (m) {
+		dt->stage_m = *m;
+		dt->stage_real_m = m;
+
+		/*
+		 * Ensure dt->stage_m.keys != NULL and it works with the
+		 * map's map_key, not stage_m's one when ->keys == NULL.
+		 */
+		if (!m->keys)
+			dt->stage_m.keys = &m->map_key;
+	} else {
+		dt->stage_m.name = w_fn;
+		dt->stage_sched_map = true;
+		dt->stage_real_m = &dt->stage_m;
+	}
+
+	/*
+	 * dept_map_reinit() includes WRITE_ONCE(->wgen, 0U) that
+	 * effectively disables the map just in case real sleep won't
+	 * happen. dept_request_event_wait_commit() will enable it.
+	 */
+	dept_map_reinit(&dt->stage_m, k, -1, NULL);
+
+	dt->stage_w_fn = w_fn;
+	dt->stage_ip = ip;
+	arch_spin_unlock(&dt->stage_lock);
+exit:
+	dept_exit_recursive(flags);
+}
+EXPORT_SYMBOL_GPL(dept_stage_wait);
+
+static void __dept_clean_stage(struct dept_task *dt)
+{
+	memset(&dt->stage_m, 0x0, sizeof(struct dept_map));
+	dt->stage_real_m = NULL;
+	dt->stage_sched_map = false;
+	dt->stage_w_fn = NULL;
+	dt->stage_ip = 0UL;
+}
+
+void dept_clean_stage(void)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	/*
+	 * Allow recursive entrance.
+	 */
+	flags = dept_enter_recursive();
+	arch_spin_lock(&dt->stage_lock);
+	__dept_clean_stage(dt);
+	arch_spin_unlock(&dt->stage_lock);
+	dept_exit_recursive(flags);
+}
+EXPORT_SYMBOL_GPL(dept_clean_stage);
+
+/*
+ * Always called from __schedule().
+ */
+void dept_request_event_wait_commit(void)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	unsigned int wg;
+	unsigned long ip;
+	const char *w_fn;
+	bool sched_map;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	/*
+	 * It's impossible that __schedule() is called while Dept is
+	 * working that already disabled IRQ at the entrance.
+	 */
+	if (DEPT_WARN_ON(dt->recursive))
+		return;
+
+	flags = dept_enter();
+
+	arch_spin_lock(&dt->stage_lock);
+
+	/*
+	 * Checks if current has staged a wait.
+	 */
+	if (!dt->stage_m.keys) {
+		arch_spin_unlock(&dt->stage_lock);
+		goto exit;
+	}
+
+	w_fn = dt->stage_w_fn;
+	ip = dt->stage_ip;
+	sched_map = dt->stage_sched_map;
+
+	wg = next_wgen();
+	WRITE_ONCE(dt->stage_m.wgen, wg);
+	arch_spin_unlock(&dt->stage_lock);
+
+	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map);
+exit:
+	dept_exit(flags);
+}
+
+/*
+ * Always called from try_to_wake_up().
+ */
+void dept_ttwu_stage_wait(struct task_struct *requestor, unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_task *dt_req = &requestor->dept_task;
+	unsigned long flags;
+	struct dept_map m;
+	struct dept_map *real_m;
+	bool sched_map;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive)
+		return;
+
+	flags = dept_enter();
+
+	arch_spin_lock(&dt_req->stage_lock);
+
+	/*
+	 * Serializing is unnecessary as long as it always comes from
+	 * try_to_wake_up().
+	 */
+	m = dt_req->stage_m;
+	sched_map = dt_req->stage_sched_map;
+	real_m = dt_req->stage_real_m;
+	__dept_clean_stage(dt_req);
+	arch_spin_unlock(&dt_req->stage_lock);
+
+	/*
+	 * ->stage_m.keys should not be NULL if it's in use. Should
+	 * make sure that it's not NULL when staging a valid map.
+	 */
+	if (!m.keys)
+		goto exit;
+
+	__dept_event(&m, real_m, 1UL, ip, "try_to_wake_up", sched_map);
+exit:
+	dept_exit(flags);
+}
+
+/*
+ * Modifies the latest ecxt corresponding to m and e_f.
+ */
+void dept_map_ecxt_modify(struct dept_map *m, unsigned long e_f,
+			  struct dept_key *new_k, unsigned long new_e_f,
+			  unsigned long new_ip, const char *new_c_fn,
+			  const char *new_e_fn, int new_sub_l)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_ecxt_held *eh;
+	struct dept_class *c;
+	struct dept_key *k;
+	unsigned long flags;
+	int pos = -1;
+	int new_e;
+	int e;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	/*
+	 * XXX: Couldn't handle re-enterance cases. Ignore it for now.
+	 */
+	if (dt->recursive)
+		return;
+
+	/*
+	 * Should go ahead no matter whether ->nocheck == true or not
+	 * because ->nocheck value can be changed within the ecxt area
+	 * delimitated by dept_ecxt_enter() and dept_ecxt_exit().
+	 */
+
+	flags = dept_enter();
+
+	for_each_set_bit(e, &e_f, DEPT_MAX_SUBCLASSES_EVT) {
+		k = m->keys ?: &m->map_key;
+		c = check_new_class(&m->map_key, k,
+				    sub_id(m, e), m->name, false);
+		if (!c)
+			continue;
+
+		/*
+		 * When it found an ecxt for any event in e_f, done.
+		 */
+		pos = find_ecxt_pos(m, c, true);
+		if (pos != -1)
+			break;
+	}
+
+	if (unlikely(pos == -1))
+		goto exit;
+
+	eh = dt->ecxt_held + pos;
+	new_sub_l = new_sub_l >= 0 ? new_sub_l : eh->sub_l;
+
+	new_e = find_first_bit(&new_e_f, DEPT_MAX_SUBCLASSES_EVT);
+
+	if (new_e < DEPT_MAX_SUBCLASSES_EVT)
+		/*
+		 * Let it work with the first bit anyway.
+		 */
+		DEPT_WARN_ON(1UL << new_e != new_e_f);
+	else
+		new_e = e;
+
+	pop_ecxt(m, c);
+
+	/*
+	 * Apply the key to the map.
+	 */
+	if (new_k)
+		dept_map_reinit(m, new_k, -1, NULL);
+
+	k = m->keys ?: &m->map_key;
+	c = check_new_class(&m->map_key, k, sub_id(m, new_e), m->name, false);
+
+	if (c && add_ecxt(m, c, new_ip, new_c_fn, new_e_fn, new_sub_l))
+		goto exit;
+
+	/*
+	 * Successfully pop_ecxt()ed but failed to add_ecxt().
+	 */
+	dt->missing_ecxt++;
+exit:
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_map_ecxt_modify);
+
+void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip,
+		     const char *c_fn, const char *e_fn, int sub_l)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	struct dept_class *c;
+	struct dept_key *k;
+	int e;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive) {
+		dt->missing_ecxt++;
+		return;
+	}
+
+	/*
+	 * Should go ahead no matter whether ->nocheck == true or not
+	 * because ->nocheck value can be changed within the ecxt area
+	 * delimitated by dept_ecxt_enter() and dept_ecxt_exit().
+	 */
+
+	flags = dept_enter();
+
+	e = find_first_bit(&e_f, DEPT_MAX_SUBCLASSES_EVT);
+
+	if (e >= DEPT_MAX_SUBCLASSES_EVT)
+		goto missing_ecxt;
+
+	/*
+	 * An event is an event. If the caller passed more than single
+	 * event, then warn it and handle the event corresponding to
+	 * the first bit anyway.
+	 */
+	DEPT_WARN_ON(1UL << e != e_f);
+
+	k = m->keys ?: &m->map_key;
+	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, false);
+
+	if (c && add_ecxt(m, c, ip, c_fn, e_fn, sub_l))
+		goto exit;
+missing_ecxt:
+	dt->missing_ecxt++;
+exit:
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_ecxt_enter);
+
+bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	bool ret = false;
+	int e;
+
+	if (unlikely(!dept_working()))
+		return false;
+
+	if (dt->recursive)
+		return false;
+
+	flags = dept_enter();
+
+	for_each_set_bit(e, &e_f, DEPT_MAX_SUBCLASSES_EVT) {
+		struct dept_class *c;
+		struct dept_key *k;
+
+		k = m->keys ?: &m->map_key;
+		c = check_new_class(&m->map_key, k,
+				    sub_id(m, e), m->name, false);
+		if (!c)
+			continue;
+
+		if (find_ecxt_pos(m, c, true) != -1) {
+			ret = true;
+			break;
+		}
+	}
+
+	dept_exit(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dept_ecxt_holding);
+
+void dept_request_event(struct dept_map *m)
+{
+	unsigned long flags;
+	unsigned int wg;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (m->nocheck)
+		return;
+
+	/*
+	 * Allow recursive entrance.
+	 */
+	flags = dept_enter_recursive();
+
+	wg = next_wgen();
+	WRITE_ONCE(m->wgen, wg);
+
+	dept_exit_recursive(flags);
+}
+EXPORT_SYMBOL_GPL(dept_request_event);
+
+void dept_event(struct dept_map *m, unsigned long e_f,
+		unsigned long ip, const char *e_fn)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (m->nocheck)
+		return;
+
+	if (dt->recursive) {
+		/*
+		 * Dept won't work with this even though an event
+		 * context has been asked. Don't make it confused at
+		 * handling the event. Disable it until the next.
+		 */
+		WRITE_ONCE(m->wgen, 0U);
+		return;
+	}
+
+	flags = dept_enter();
+
+	__dept_event(m, m, e_f, ip, e_fn, false);
+
+	/*
+	 * Keep the map diabled until the next sleep.
+	 */
+	WRITE_ONCE(m->wgen, 0U);
+
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_event);
+
+void dept_ecxt_exit(struct dept_map *m, unsigned long e_f,
+		    unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	int e;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive) {
+		dt->missing_ecxt--;
+		return;
+	}
+
+	/*
+	 * Should go ahead no matter whether ->nocheck == true or not
+	 * because ->nocheck value can be changed within the ecxt area
+	 * delimitated by dept_ecxt_enter() and dept_ecxt_exit().
+	 */
+
+	flags = dept_enter();
+
+	for_each_set_bit(e, &e_f, DEPT_MAX_SUBCLASSES_EVT) {
+		struct dept_class *c;
+		struct dept_key *k;
+
+		k = m->keys ?: &m->map_key;
+		c = check_new_class(&m->map_key, k,
+				    sub_id(m, e), m->name, false);
+		if (!c)
+			continue;
+
+		/*
+		 * When it found an ecxt for any event in e_f, done.
+		 */
+		if (pop_ecxt(m, c))
+			goto exit;
+	}
+
+	dt->missing_ecxt--;
+exit:
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_ecxt_exit);
+
+void dept_task_exit(struct task_struct *t)
+{
+	struct dept_task *dt = &t->dept_task;
+	int i;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	raw_local_irq_disable();
+
+	if (dt->stack) {
+		put_stack(dt->stack);
+		dt->stack = NULL;
+	}
+
+	for (i = 0; i < dt->ecxt_held_pos; i++) {
+		if (dt->ecxt_held[i].class) {
+			put_class(dt->ecxt_held[i].class);
+			dt->ecxt_held[i].class = NULL;
+		}
+		if (dt->ecxt_held[i].ecxt) {
+			put_ecxt(dt->ecxt_held[i].ecxt);
+			dt->ecxt_held[i].ecxt = NULL;
+		}
+	}
+
+	for (i = 0; i < DEPT_MAX_WAIT_HIST; i++) {
+		if (dt->wait_hist[i].wait) {
+			put_wait(dt->wait_hist[i].wait);
+			dt->wait_hist[i].wait = NULL;
+		}
+	}
+
+	dt->task_exit = true;
+	dept_off();
+
+	raw_local_irq_enable();
+}
+
+void dept_task_init(struct task_struct *t)
+{
+	memset(&t->dept_task, 0x0, sizeof(struct dept_task));
+	t->dept_task.stage_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+}
+
+void dept_key_init(struct dept_key *k)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	int sub_id;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive) {
+		DEPT_STOP("Key initialization fails.\n");
+		return;
+	}
+
+	flags = dept_enter();
+
+	clean_classes_cache(k);
+
+	/*
+	 * dept_key_init() should not fail.
+	 *
+	 * FIXME: Should be fixed if dept_key_init() causes deadlock
+	 * with dept_lock().
+	 */
+	while (unlikely(!dept_lock()))
+		cpu_relax();
+
+	for (sub_id = 0; sub_id < DEPT_MAX_SUBCLASSES; sub_id++) {
+		struct dept_class *c;
+
+		c = lookup_class((unsigned long)k->base + sub_id);
+		if (!c)
+			continue;
+
+		DEPT_STOP("The class(%s/%d) has not been removed.\n",
+			  c->name, sub_id);
+		break;
+	}
+
+	dept_unlock();
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_key_init);
+
+void dept_key_destroy(struct dept_key *k)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	int sub_id;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive == 1 && dt->task_exit) {
+		/*
+		 * Need to allow to go ahead in this case where
+		 * ->recursive has been set to 1 by dept_off() in
+		 * dept_task_exit() and ->task_exit has been set to
+		 * true in dept_task_exit().
+		 */
+	} else if (dt->recursive) {
+		DEPT_STOP("Key destroying fails.\n");
+		return;
+	}
+
+	flags = dept_enter();
+
+	/*
+	 * dept_key_destroy() should not fail.
+	 *
+	 * FIXME: Should be fixed if dept_key_destroy() causes deadlock
+	 * with dept_lock().
+	 */
+	while (unlikely(!dept_lock()))
+		cpu_relax();
+
+	for (sub_id = 0; sub_id < DEPT_MAX_SUBCLASSES; sub_id++) {
+		struct dept_class *c;
+
+		c = lookup_class((unsigned long)k->base + sub_id);
+		if (!c)
+			continue;
+
+		hash_del_class(c);
+		disconnect_class(c);
+		list_del(&c->all_node);
+		invalidate_class(c);
+
+		/*
+		 * Actual deletion will happen on the rcu callback
+		 * that has been added in disconnect_class().
+		 */
+		del_class(c);
+	}
+
+	dept_unlock();
+	dept_exit(flags);
+
+	/*
+	 * Wait until even lockless hash_lookup_class() for the class
+	 * returns NULL.
+	 */
+	might_sleep();
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(dept_key_destroy);
+
+static void move_llist(struct llist_head *to, struct llist_head *from)
+{
+	struct llist_node *first = llist_del_all(from);
+	struct llist_node *last = first;
+
+	if (!first)
+		return;
+
+	while (llist_next(last))
+		last = llist_next(last);
+	llist_add_batch(first, last, to);
+}
+
+static void migrate_per_cpu_pool(void)
+{
+	const int boot_cpu = 0;
+	int i;
+
+	/*
+	 * The boot CPU has been using the temporal local pool so far.
+	 * From now on that per_cpu areas have been ready, use the
+	 * per_cpu local pool instead.
+	 */
+	DEPT_WARN_ON(smp_processor_id() != boot_cpu);
+	for (i = 0; i < OBJECT_NR; i++) {
+		struct llist_head *from;
+		struct llist_head *to;
+
+		from = &pool[i].boot_pool;
+		to = per_cpu_ptr(pool[i].lpool, boot_cpu);
+		move_llist(to, from);
+	}
+}
+
+#define B2KB(B) ((B) / 1024)
+
+/*
+ * Should be called after setup_per_cpu_areas() and before no non-boot
+ * CPUs have been on.
+ */
+void __init dept_init(void)
+{
+	size_t mem_total = 0;
+
+	local_irq_disable();
+	dept_per_cpu_ready = 1;
+	migrate_per_cpu_pool();
+	local_irq_enable();
+
+#define HASH(id, bits) BUILD_BUG_ON(1 << (bits) <= 0);
+	#include "dept_hash.h"
+#undef HASH
+#define OBJECT(id, nr) mem_total += sizeof(struct dept_##id) * nr;
+	#include "dept_object.h"
+#undef OBJECT
+#define HASH(id, bits) mem_total += sizeof(struct hlist_head) * (1 << (bits));
+	#include "dept_hash.h"
+#undef HASH
+
+	pr_info("DEPendency Tracker: Copyright (c) 2020 LG Electronics, Inc., Byungchul Park\n");
+	pr_info("... DEPT_MAX_STACK_ENTRY: %d\n", DEPT_MAX_STACK_ENTRY);
+	pr_info("... DEPT_MAX_WAIT_HIST  : %d\n", DEPT_MAX_WAIT_HIST);
+	pr_info("... DEPT_MAX_ECXT_HELD  : %d\n", DEPT_MAX_ECXT_HELD);
+	pr_info("... DEPT_MAX_SUBCLASSES : %d\n", DEPT_MAX_SUBCLASSES);
+#define OBJECT(id, nr)							\
+	pr_info("... memory used by %s: %zu KB\n",			\
+	       #id, B2KB(sizeof(struct dept_##id) * nr));
+	#include "dept_object.h"
+#undef OBJECT
+#define HASH(id, bits)							\
+	pr_info("... hash list head used by %s: %zu KB\n",		\
+	       #id, B2KB(sizeof(struct hlist_head) * (1 << (bits))));
+	#include "dept_hash.h"
+#undef HASH
+	pr_info("... total memory used by objects and hashs: %zu KB\n", B2KB(mem_total));
+	pr_info("... per task memory footprint: %zu bytes\n", sizeof(struct dept_task));
+}
diff --git a/kernel/dependency/dept_hash.h b/kernel/dependency/dept_hash.h
new file mode 100644
index 000000000000..fd85aab1fdfb
--- /dev/null
+++ b/kernel/dependency/dept_hash.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * HASH(id, bits)
+ *
+ * id  : Id for the object of struct dept_##id.
+ * bits: 1UL << bits is the hash table size.
+ */
+
+HASH(dep, 12)
+HASH(class, 12)
diff --git a/kernel/dependency/dept_object.h b/kernel/dependency/dept_object.h
new file mode 100644
index 000000000000..0b7eb16fe9fb
--- /dev/null
+++ b/kernel/dependency/dept_object.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * OBJECT(id, nr)
+ *
+ * id: Id for the object of struct dept_##id.
+ * nr: # of the object that should be kept in the pool.
+ */
+
+OBJECT(dep, 1024 * 8)
+OBJECT(class, 1024 * 8)
+OBJECT(stack, 1024 * 32)
+OBJECT(ecxt, 1024 * 16)
+OBJECT(wait, 1024 * 32)
diff --git a/kernel/exit.c b/kernel/exit.c
index 343eb97543d5..88c0fbec9967 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1001,6 +1001,7 @@ void __noreturn do_exit(long code)
 	exit_tasks_rcu_finish();
 
 	lockdep_free_task(tsk);
+	dept_task_exit(tsk);
 	do_task_dead();
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 6ca8689a83b5..c6fe9a23ac0a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -106,6 +106,7 @@
 #include <linux/pidfs.h>
 #include <linux/tick.h>
 #include <linux/unwind_deferred.h>
+#include <linux/dept.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2127,6 +2128,7 @@ __latent_entropy struct task_struct *copy_process(
 #ifdef CONFIG_LOCKDEP
 	lockdep_init_task(p);
 #endif
+	dept_task_init(p);
 
 	p->blocked_on = NULL; /* not blocked yet */
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c66b26184936..6ad78f0a58b6 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1375,12 +1375,14 @@ static void free_mod_mem(struct module *mod)
 
 		/* Free lock-classes; relies on the preceding sync_rcu(). */
 		lockdep_free_key_range(mod_mem->base, mod_mem->size);
+		dept_free_range(mod_mem->base, mod_mem->size);
 		if (mod_mem->size)
 			module_memory_free(mod, type);
 	}
 
 	/* MOD_DATA hosts mod, so free it at last */
 	lockdep_free_key_range(mod->mem[MOD_DATA].base, mod->mem[MOD_DATA].size);
+	dept_free_range(mod->mem[MOD_DATA].base, mod->mem[MOD_DATA].size);
 	module_memory_free(mod, MOD_DATA);
 }
 
@@ -3548,6 +3550,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	for_class_mod_mem_type(type, core_data) {
 		lockdep_free_key_range(mod->mem[type].base,
 				       mod->mem[type].size);
+		dept_free_range(mod->mem[type].base,
+				mod->mem[type].size);
 	}
 
 	module_memory_restore_rox(mod);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ccba6fc3c3fe..db942591fb1a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -67,6 +67,7 @@
 #include <linux/wait_api.h>
 #include <linux/workqueue_api.h>
 #include <linux/livepatch_sched.h>
+#include <linux/dept.h>
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 # ifdef CONFIG_GENERIC_IRQ_ENTRY
@@ -4246,6 +4247,8 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
 			break;
 
+		dept_ttwu_stage_wait(p, _RET_IP_);
+
 		/*
 		 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
 		 * possible to, falsely, observe p->on_cpu == 0.
@@ -6835,6 +6838,11 @@ static void __sched notrace __schedule(int sched_mode)
 	rq = cpu_rq(cpu);
 	prev = rq->curr;
 
+	prev_state = READ_ONCE(prev->__state);
+	if (sched_mode != SM_PREEMPT && prev_state & TASK_NORMAL)
+		dept_request_event_wait_commit();
+
+	dept_sched_enter();
 	schedule_debug(prev, preempt);
 
 	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
@@ -6969,6 +6977,7 @@ static void __sched notrace __schedule(int sched_mode)
 		raw_spin_rq_unlock_irq(rq);
 	}
 	trace_sched_exit_tp(is_switch);
+	dept_sched_exit();
 }
 
 void __noreturn do_task_dead(void)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index dc0e0c6ed075..b9cff0bec6f2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1365,6 +1365,32 @@ config DEBUG_PREEMPT
 
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
+config DEPT
+	bool "Dependency tracking (EXPERIMENTAL)"
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
+	select DEBUG_SPINLOCK
+	select DEBUG_MUTEXES if !PREEMPT_RT
+	select DEBUG_RT_MUTEXES if RT_MUTEXES
+	select DEBUG_RWSEMS if !PREEMPT_RT
+	select DEBUG_WW_MUTEX_SLOWPATH
+	select DEBUG_LOCK_ALLOC
+	select TRACE_IRQFLAGS
+	select STACKTRACE
+	select KALLSYMS
+	select KALLSYMS_ALL
+	select PROVE_LOCKING
+	default n
+	help
+	  Check dependencies between wait and event and report it if
+	  deadlock possibility has been detected. Multiple reports are
+	  allowed if there are more than a single problem.
+
+	  This feature is considered EXPERIMENTAL that might produce
+	  false positive reports because new dependencies start to be
+	  tracked, that have never been tracked before. It's worth
+	  noting, to mitigate the impact by the false positives, multi
+	  reporting has been supported.
+
 config LOCK_DEBUGGING_SUPPORT
 	bool
 	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index ed99344317f5..18228afccea5 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1398,6 +1398,8 @@ static void reset_locks(void)
 	local_irq_disable();
 	lockdep_free_key_range(&ww_lockdep.acquire_key, 1);
 	lockdep_free_key_range(&ww_lockdep.mutex_key, 1);
+	dept_free_range(&ww_lockdep.acquire_key, 1);
+	dept_free_range(&ww_lockdep.mutex_key, 1);
 
 	I1(A); I1(B); I1(C); I1(D);
 	I1(X1); I1(X2); I1(Y1); I1(Y2); I1(Z1); I1(Z2);
-- 
2.17.1



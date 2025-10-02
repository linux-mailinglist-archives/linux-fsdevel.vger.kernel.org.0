Return-Path: <linux-fsdevel+bounces-63253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890E7BB3254
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB54819E56EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FF43176FF;
	Thu,  2 Oct 2025 08:14:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BBD30F954;
	Thu,  2 Oct 2025 08:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392851; cv=none; b=ikRPIwnkT8ZGTq2chzo7lrtwErlcCXvxG4J5Z3U2GXNh3HaDL9BSwOI3kvqQv1guWqEISVcpJKHOhPtwS5OLHdRoiBlFvBCoKz6dNOHBBSFa4Ot74CsFzXOnMvp79a9vvzEF9ymxRCCug5GPUfZo6iYj2XyOJYJNwwAonHJIfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392851; c=relaxed/simple;
	bh=aUyn6kbD13lpyrV+9RVcwjxIaUKLCg4/lG2fnS/j5oM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JGeivPWdahEVpei4EdCZOuzuM806927bVwTo09PTuAdgT0P0kst4ZRYG2W14SMHzl6svTKxUyN/qnmWSIih79V30POi+EYiV3/tgg5VSlIwaoqjYspP7xbkCSGWuivbH66vlK5VhHQCdrNMkLSc+cO4oOHeVjCE+RtRg0i1EOho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-dd-68de3413fc51
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
Subject: [PATCH v17 36/47] dept: assign unique dept_key to each distinct wait_for_completion() caller
Date: Thu,  2 Oct 2025 17:12:36 +0900
Message-Id: <20251002081247.51255-37-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHee597m3pqLupLF5lCVsjYSooGtyOi9F925MtCxr95D7Mzt7Y
	RiimvCgkS6gCokRkaCFYWKgKQVoZFDZ5KyJqFauxFcYIFrCsAxUKRimM1+4W9cvJ77z9T87J
	kdKKQWaDVKtLF/Q6VbKSlWGZP8IcH5k4rEmwXlwD/YYuDBW/W1kosJUz4Kq3IJhbNNGwXOKQ
	wMz8MwkE7Q4E1mYDBW8bVliYuPMGgdHrY6HspQHDy3vfgn+knYHg0DgFf89OIqjxrVDg6zqD
	YLn0GJQZXQjM3iEamh3DCP4t/oOGXt8a6AtMs9BjLGTB766gYKqBhapTdgYqTSUISittGNwT
	SxSUNq4DU9lpSjQvKDDeaKfg0VUPhpqcGBitvSyBJe92qPc/YaBnuJ+BibESFkbu5zMw0+el
	oKAtgMH2j5iwD24Bc/41DB32HgwFyzMIHC2jFPS2VbAwbA0ykGOaEw/Q5WTgqcWFwel4gMH7
	fICBpsePaLgxdYWFi1Nj4nqBack3ajKXV4RJXdOfFMl7uswS629WRBYXShCZqT5Nk7xi0a12
	TrJkIfAXS+yzVZg8vMKTXx/Hk9bLQxKS2zkoIVW2DJJ718/sizsk260WkrWZgn7bnsMyjbnt
	EnPcoDtZ0Pgc5aALh86hcCnPJfJlk52SD+wuDFIhZrlYfmBgng5xJPcZ33R+jAkxzTk/5fvd
	cSFeywn8iPHMai/mYvjW15dWWc59yXteWN9rRvOWhq5VnXAx3ut14hAruJ183nSuOEsm1pjC
	+Yq6euZdw3r+du0ALkbyKhRWhxRaXWaKSpucuFWTpdOe3HokNcWGxI+r+WXpxxb0xnWgG3FS
	pIyQu2KGNApGlZmWldKNeCmtjJQfrvVoFHK1Kitb0Kf+pM9IFtK6UZQUK9fJd8yeUCu4o6p0
	4ZggHBf0H7KUNHxDDtIXFW0MxgbOP4seTbJ80ZRv/j5AAnHxndlhiUfCyt++/vpJpmrSo3Nv
	vuV6tePnPbuuWkz79t+O/a7RcNPX0NFz/ZPSz/PnvjKWxyyQH/aO7/1I0ZtaWR31X3b67tyJ
	g3rP/k1nmyOkNv6CT9tXvJAQFTiVtI18bLKdGPcnRavd3KASp2lU2zfT+jTV/0hLqeVtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0hTcRQA8P73OUer2xK8aGStJIishIpD7wfULUr6ElIUOfLSlrrFVqZW
	4NKlZKWNTcm1WprLdNmaVmpMZKGSS3LZW6cZuixn9tCWqa2t6Mvhdx4czocjwMX3yUiBXHGM
	VymkKRJKSAjj12THzl7RI1ue65gDLzVNBIyN5hFw5Y6Vgjz7ZRI6qqsQ9I7lIfBPGHHQ1gcI
	mNK10DA63kVDwNGCoMitw8Faq8Hgu+03BUOPviEw9PVTUPxRQ8CI5TyCEq+Rho/N22C49yEJ
	Ac8HDF798CGw9P/GoL8pF8FUUTJcK62hYKL9KQ7Fhg4E1/s8OAzags3alh4EjoozFAwU3sOh
	s38GPB8boeCxIZ+CYfcVDD7bKDCfcZBgMuoQZJfdoaDIZCeg/l0DDe6hSQy6i3QYVNl3Qa/F
	S4CrsBQL3hecuhsBxuJsLBgGMTDcfojBuKWShidl3QRYsmLA2N5JwvuKEhom++IgYFZCS9UH
	GjwFBgKqh5+SGw2I82svElxlzX2M0z6bojjrVSviJn7pEDdano1z2sJg+sg3gnM5NSe4cpeP
	4n6NvaA4xw8zwbWVstyl9liuvsRDczmNb+ndq/cJ1ybxKfI0XrVsfaJQdr1BTx7VKNLz7r5D
	Wahg3zkUJmCZFaw7P4CFTDGL2Nevx/GQw5l5bM0FLxkyzrjmsC/dS0KezfBsryGXDplgYtj6
	L/q/FjGr2O5BK/1vZzRbZWv6uycsWO/scxEhi5mVrHYkBytEQjOaVonC5Yq0VKk8ZeVSdbIs
	QyFPX3pImWpHwW+ynJ68VIdGO7c5ESNAkukid4xHJialaeqMVCdiBbgkXJRY0S0Ti5KkGZm8
	SnlQdTyFVztRlICQRIh2JPCJYuaw9BifzPNHedX/LiYIi8xCHfbGhhvbb70wK8PFWzfvzleX
	zVJ98iREHah74z0yV5k5uTP+pr4gPrLdpvnqLO/SrjM1D7SOi2rTWz/z/q2nMs8uJOfqM/fP
	r047fRLrcm3wzYxe7RyYFhGt3rJzaEHUiQTbga/+W+t6mD1tsRL/Xu+Dn/pNel+jyZQwf/H+
	BlonIdQyadxiXKWW/gFyd5nfSQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

wait_for_completion() can be used at various points in the code and it's
very hard to distinguish wait_for_completion()s between different usages.
Using a single dept_key for all the wait_for_completion()s could trigger
false positive reports.

Assign unique dept_key to each distinct wait_for_completion() caller to
avoid false positive reports.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 100 +++++++++++++++++++++++++++++++------
 kernel/sched/completion.c  |  60 +++++++++++-----------
 2 files changed, 115 insertions(+), 45 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 3200b741de28..4d8fb1d95c0a 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -27,12 +27,10 @@
 struct completion {
 	unsigned int done;
 	struct swait_queue_head wait;
-	struct dept_map dmap;
 };
 
 #define init_completion(x)				\
 do {							\
-	sdt_map_init(&(x)->dmap);			\
 	__init_completion(x);				\
 } while (0)
 
@@ -43,17 +41,14 @@ do {							\
 
 static inline void complete_acquire(struct completion *x, long timeout)
 {
-	sdt_might_sleep_start_timeout(&x->dmap, timeout);
 }
 
 static inline void complete_release(struct completion *x)
 {
-	sdt_might_sleep_end();
 }
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), \
-	  .dmap = DEPT_MAP_INITIALIZER(work, NULL), }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), }
 
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
@@ -119,18 +114,18 @@ static inline void reinit_completion(struct completion *x)
 	x->done = 0;
 }
 
-extern void wait_for_completion(struct completion *);
-extern void wait_for_completion_io(struct completion *);
-extern int wait_for_completion_interruptible(struct completion *x);
-extern int wait_for_completion_killable(struct completion *x);
-extern int wait_for_completion_state(struct completion *x, unsigned int state);
-extern unsigned long wait_for_completion_timeout(struct completion *x,
+extern void __wait_for_completion(struct completion *);
+extern void __wait_for_completion_io(struct completion *);
+extern int __wait_for_completion_interruptible(struct completion *x);
+extern int __wait_for_completion_killable(struct completion *x);
+extern int __wait_for_completion_state(struct completion *x, unsigned int state);
+extern unsigned long __wait_for_completion_timeout(struct completion *x,
 						   unsigned long timeout);
-extern unsigned long wait_for_completion_io_timeout(struct completion *x,
+extern unsigned long __wait_for_completion_io_timeout(struct completion *x,
 						    unsigned long timeout);
-extern long wait_for_completion_interruptible_timeout(
+extern long __wait_for_completion_interruptible_timeout(
 	struct completion *x, unsigned long timeout);
-extern long wait_for_completion_killable_timeout(
+extern long __wait_for_completion_killable_timeout(
 	struct completion *x, unsigned long timeout);
 extern bool try_wait_for_completion(struct completion *x);
 extern bool completion_done(struct completion *x);
@@ -139,4 +134,79 @@ extern void complete(struct completion *);
 extern void complete_on_current_cpu(struct completion *x);
 extern void complete_all(struct completion *);
 
+#define wait_for_completion(x)						\
+({									\
+	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	__wait_for_completion(x);					\
+	sdt_might_sleep_end();						\
+})
+#define wait_for_completion_io(x)					\
+({									\
+	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	__wait_for_completion_io(x);					\
+	sdt_might_sleep_end();						\
+})
+#define wait_for_completion_interruptible(x)				\
+({									\
+	int __ret;							\
+									\
+	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	__ret = __wait_for_completion_interruptible(x);			\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
+#define wait_for_completion_killable(x)					\
+({									\
+	int __ret;							\
+									\
+	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	__ret = __wait_for_completion_killable(x);			\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
+#define wait_for_completion_state(x, s)					\
+({									\
+	int __ret;							\
+									\
+	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	__ret = __wait_for_completion_state(x, s);			\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
+#define wait_for_completion_timeout(x, t)				\
+({									\
+	unsigned long __ret;						\
+									\
+	sdt_might_sleep_start_timeout(NULL, t);				\
+	__ret = __wait_for_completion_timeout(x, t);			\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
+#define wait_for_completion_io_timeout(x, t)				\
+({									\
+	unsigned long __ret;						\
+									\
+	sdt_might_sleep_start_timeout(NULL, t);				\
+	__ret = __wait_for_completion_io_timeout(x, t);			\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
+#define wait_for_completion_interruptible_timeout(x, t)			\
+({									\
+	long __ret;							\
+									\
+	sdt_might_sleep_start_timeout(NULL, t);				\
+	__ret = __wait_for_completion_interruptible_timeout(x, t);	\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
+#define wait_for_completion_killable_timeout(x, t)			\
+({									\
+	long __ret;							\
+									\
+	sdt_might_sleep_start_timeout(NULL, t);				\
+	__ret = __wait_for_completion_killable_timeout(x, t);		\
+	sdt_might_sleep_end();						\
+	__ret;								\
+})
 #endif
diff --git a/kernel/sched/completion.c b/kernel/sched/completion.c
index 5e45a60ff7b3..7262000db114 100644
--- a/kernel/sched/completion.c
+++ b/kernel/sched/completion.c
@@ -4,7 +4,7 @@
  * Generic wait-for-completion handler;
  *
  * It differs from semaphores in that their default case is the opposite,
- * wait_for_completion default blocks whereas semaphore default non-block. The
+ * __wait_for_completion default blocks whereas semaphore default non-block. The
  * interface also makes it easy to 'complete' multiple waiting threads,
  * something which isn't entirely natural for semaphores.
  *
@@ -42,7 +42,7 @@ void complete_on_current_cpu(struct completion *x)
  * This will wake up a single thread waiting on this completion. Threads will be
  * awakened in the same order in which they were queued.
  *
- * See also complete_all(), wait_for_completion() and related routines.
+ * See also complete_all(), __wait_for_completion() and related routines.
  *
  * If this function wakes up a task, it executes a full memory barrier before
  * accessing the task state.
@@ -139,23 +139,23 @@ wait_for_common_io(struct completion *x, long timeout, int state)
 }
 
 /**
- * wait_for_completion: - waits for completion of a task
+ * __wait_for_completion: - waits for completion of a task
  * @x:  holds the state of this particular completion
  *
  * This waits to be signaled for completion of a specific task. It is NOT
  * interruptible and there is no timeout.
  *
- * See also similar routines (i.e. wait_for_completion_timeout()) with timeout
+ * See also similar routines (i.e. __wait_for_completion_timeout()) with timeout
  * and interrupt capability. Also see complete().
  */
-void __sched wait_for_completion(struct completion *x)
+void __sched __wait_for_completion(struct completion *x)
 {
 	wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion);
+EXPORT_SYMBOL(__wait_for_completion);
 
 /**
- * wait_for_completion_timeout: - waits for completion of a task (w/timeout)
+ * __wait_for_completion_timeout: - waits for completion of a task (w/timeout)
  * @x:  holds the state of this particular completion
  * @timeout:  timeout value in jiffies
  *
@@ -167,28 +167,28 @@ EXPORT_SYMBOL(wait_for_completion);
  * till timeout) if completed.
  */
 unsigned long __sched
-wait_for_completion_timeout(struct completion *x, unsigned long timeout)
+__wait_for_completion_timeout(struct completion *x, unsigned long timeout)
 {
 	return wait_for_common(x, timeout, TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion_timeout);
+EXPORT_SYMBOL(__wait_for_completion_timeout);
 
 /**
- * wait_for_completion_io: - waits for completion of a task
+ * __wait_for_completion_io: - waits for completion of a task
  * @x:  holds the state of this particular completion
  *
  * This waits to be signaled for completion of a specific task. It is NOT
  * interruptible and there is no timeout. The caller is accounted as waiting
  * for IO (which traditionally means blkio only).
  */
-void __sched wait_for_completion_io(struct completion *x)
+void __sched __wait_for_completion_io(struct completion *x)
 {
 	wait_for_common_io(x, MAX_SCHEDULE_TIMEOUT, TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion_io);
+EXPORT_SYMBOL(__wait_for_completion_io);
 
 /**
- * wait_for_completion_io_timeout: - waits for completion of a task (w/timeout)
+ * __wait_for_completion_io_timeout: - waits for completion of a task (w/timeout)
  * @x:  holds the state of this particular completion
  * @timeout:  timeout value in jiffies
  *
@@ -201,14 +201,14 @@ EXPORT_SYMBOL(wait_for_completion_io);
  * till timeout) if completed.
  */
 unsigned long __sched
-wait_for_completion_io_timeout(struct completion *x, unsigned long timeout)
+__wait_for_completion_io_timeout(struct completion *x, unsigned long timeout)
 {
 	return wait_for_common_io(x, timeout, TASK_UNINTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion_io_timeout);
+EXPORT_SYMBOL(__wait_for_completion_io_timeout);
 
 /**
- * wait_for_completion_interruptible: - waits for completion of a task (w/intr)
+ * __wait_for_completion_interruptible: - waits for completion of a task (w/intr)
  * @x:  holds the state of this particular completion
  *
  * This waits for completion of a specific task to be signaled. It is
@@ -216,7 +216,7 @@ EXPORT_SYMBOL(wait_for_completion_io_timeout);
  *
  * Return: -ERESTARTSYS if interrupted, 0 if completed.
  */
-int __sched wait_for_completion_interruptible(struct completion *x)
+int __sched __wait_for_completion_interruptible(struct completion *x)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE);
 
@@ -224,10 +224,10 @@ int __sched wait_for_completion_interruptible(struct completion *x)
 		return t;
 	return 0;
 }
-EXPORT_SYMBOL(wait_for_completion_interruptible);
+EXPORT_SYMBOL(__wait_for_completion_interruptible);
 
 /**
- * wait_for_completion_interruptible_timeout: - waits for completion (w/(to,intr))
+ * __wait_for_completion_interruptible_timeout: - waits for completion (w/(to,intr))
  * @x:  holds the state of this particular completion
  * @timeout:  timeout value in jiffies
  *
@@ -238,15 +238,15 @@ EXPORT_SYMBOL(wait_for_completion_interruptible);
  * or number of jiffies left till timeout) if completed.
  */
 long __sched
-wait_for_completion_interruptible_timeout(struct completion *x,
+__wait_for_completion_interruptible_timeout(struct completion *x,
 					  unsigned long timeout)
 {
 	return wait_for_common(x, timeout, TASK_INTERRUPTIBLE);
 }
-EXPORT_SYMBOL(wait_for_completion_interruptible_timeout);
+EXPORT_SYMBOL(__wait_for_completion_interruptible_timeout);
 
 /**
- * wait_for_completion_killable: - waits for completion of a task (killable)
+ * __wait_for_completion_killable: - waits for completion of a task (killable)
  * @x:  holds the state of this particular completion
  *
  * This waits to be signaled for completion of a specific task. It can be
@@ -254,7 +254,7 @@ EXPORT_SYMBOL(wait_for_completion_interruptible_timeout);
  *
  * Return: -ERESTARTSYS if interrupted, 0 if completed.
  */
-int __sched wait_for_completion_killable(struct completion *x)
+int __sched __wait_for_completion_killable(struct completion *x)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, TASK_KILLABLE);
 
@@ -262,9 +262,9 @@ int __sched wait_for_completion_killable(struct completion *x)
 		return t;
 	return 0;
 }
-EXPORT_SYMBOL(wait_for_completion_killable);
+EXPORT_SYMBOL(__wait_for_completion_killable);
 
-int __sched wait_for_completion_state(struct completion *x, unsigned int state)
+int __sched __wait_for_completion_state(struct completion *x, unsigned int state)
 {
 	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, state);
 
@@ -272,10 +272,10 @@ int __sched wait_for_completion_state(struct completion *x, unsigned int state)
 		return t;
 	return 0;
 }
-EXPORT_SYMBOL(wait_for_completion_state);
+EXPORT_SYMBOL(__wait_for_completion_state);
 
 /**
- * wait_for_completion_killable_timeout: - waits for completion of a task (w/(to,killable))
+ * __wait_for_completion_killable_timeout: - waits for completion of a task (w/(to,killable))
  * @x:  holds the state of this particular completion
  * @timeout:  timeout value in jiffies
  *
@@ -287,12 +287,12 @@ EXPORT_SYMBOL(wait_for_completion_state);
  * or number of jiffies left till timeout) if completed.
  */
 long __sched
-wait_for_completion_killable_timeout(struct completion *x,
+__wait_for_completion_killable_timeout(struct completion *x,
 				     unsigned long timeout)
 {
 	return wait_for_common(x, timeout, TASK_KILLABLE);
 }
-EXPORT_SYMBOL(wait_for_completion_killable_timeout);
+EXPORT_SYMBOL(__wait_for_completion_killable_timeout);
 
 /**
  *	try_wait_for_completion - try to decrement a completion without blocking
@@ -334,7 +334,7 @@ EXPORT_SYMBOL(try_wait_for_completion);
  *	completion_done - Test to see if a completion has any waiters
  *	@x:	completion structure
  *
- *	Return: 0 if there are waiters (wait_for_completion() in progress)
+ *	Return: 0 if there are waiters (__wait_for_completion() in progress)
  *		 1 if there are no waiters.
  *
  *	Note, this will always return true if complete_all() was called on @X.
-- 
2.17.1



Return-Path: <linux-fsdevel+bounces-70784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 731B3CA752B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 12:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 790D6368BE16
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 08:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3162FC89F;
	Fri,  5 Dec 2025 07:21:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF382F39C9;
	Fri,  5 Dec 2025 07:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919271; cv=none; b=u18NSWWUT9hSLrRzK3k+w6XjPpHixK7ln4WHWXAN+Q4W1EJISSiFriRVOr37LC10Ba9iUBcRM5deLj+2vPKbalGytfh8E4pLaj4q57iAR3WnJUIs1aFumUFWmwxm40p5ujWkPiagYFM5GJt5HCcDrUnGLFA2Fl1DKdtQvCK8c10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919271; c=relaxed/simple;
	bh=ZzgJZGS1Zfmf9DoSYkDLhcEEZ40CTW0WckDgtNV4WWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Nrhg8zIcb5fT3/79z/D8ekma1giqNRqUL8yrdBjjdY/4EOFf0rQ8Z+tkXAAvty9zuDrT9ZLqyOpGyQEKndRXa37yN7yCZp/cGzrBiVxQSlbOhjYClkzM3/zJFo5nseMeXfTkHypQEP3jlzAZvJAR1E0BPaR+jrXDPA5NZchSE3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-6b-69328771695a
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
Subject: [PATCH v18 29/42] dept: make dept aware of lockdep_set_lock_cmp_fn() annotation
Date: Fri,  5 Dec 2025 16:18:42 +0900
Message-Id: <20251205071855.72743-30-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxjF/d97//eWjupd1XDBD5gmhEQnAkF9omRzySb3w2ZMNGHREFfH
	VSqlmGJ5WWJW0Vos0QHadmstlDgKUl2wzKgpxIoiEgKWl9gSQUqsKK6gaSgqAbZS47dfzjnP
	+fDkiEjpKE4SKVQnBbVKrpTRYko8E9+4Ra3PVKSPTa2FKt1vsGS9zcBjXyUF3r+dCCYiVQh0
	d/+jwHgagWmwjgS/9x4J5unTFEx358DMhBuDbz6EwBFcJiDo0SNYMhVC4+Q4CZ0tlTQMB1dD
	r7GaBpu1DsGYqY4Ap+tHsJrPEGC84SbAoU0Ba/8whvHfjRT0Pn+KYaLnHIbb2gADcyOTBHR0
	9lKgtb7H4PX0YRhyeqM5yzUKmnyDBEwG/Bj8NS8R/DvvIGHUHGLAEXnLwLWGZgR1U2EGbt3T
	Iei54CGgaW6WBP1rNw391gEMYxffUHDur5sEjIy6ETS1zGB4ZbER8CASIuDSkJ2GheZuBGHb
	MgbnYPQNi1U0VOtMFHxoe4HBNpexezevG1qi+ev11xH/IPSW5Dvn7RRf27+Fv2sZZ3i7S8O3
	t2zir3ZME3xjOIJ5V+t5mjfMjBD87MAAwwdHzFFDayT5Z8svyH1JB8XZ+YJSUSqot379s7gg
	MNBHnDCllv8xm6JFlmQDihNxbBb3zvaa/MwN1ifMCtNsKuf3f4zp69iNXPuFKWxAYhHJDidz
	+o8XY8Za9ifOFzEQK0yxKVzHDQdaYQm7nasMXGY+lSZzzjZPLB8X1Y2+hRhL2W1cg+F9rJRj
	m+O4+kUz/ekgkbvf4qdqkMSOVrUiqUJVWiRXKLPSCipUivK0X4qLXCg6OMepxUN3UNi7vwux
	IiSLl3jKMhRSLC8tqSjqQpyIlK2ThJTpCqkkX17xq6AuPqzWKIWSLrRBRMkSJJnzZflS9pj8
	pFAoCCcE9WeXEMUlaVHt/fVXN06H94y1Zz07m+j9UzjSrd/bkXv0fDAz3X6l4Mt/vl/TsAPt
	y9b8cPxAz6Tm7AZV3sH271JfunN2oLbAwwVZTd/m+KM7La5dyr2aVxZXmQlnF965lNn8zWD1
	t+/cuUeg9mbiseeWxp04p/iLUFr8V4m13ZJ6e8Kj8oRbeW/CMqqkQJ6xiVSXyP8HWvGgsmwD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe2xLcRTH/X739t6uVq6auBkyKeKV0WFyxJtkLolH4g/iEWu4sVo3tLMH
	8eimNhvSNdrZis5YyR42nddMWSYWzFgNHTatqM2y2YZ1tU1NN/HPyeec7/d8c/44QkJyRxAs
	VMTG8apYuVJKiUjRuoUpoftT5yhkna3TIE17FBqdbgG81VSS4OlOI+F8SREFPtMdGtKs2QJ4
	4kgmoe56IQKnJw2Bt99EgLZ8gASfvpqG7t4PNBg0CAZs1QiMdj0BDXUPCSi6qcHws/QPBW2P
	fiAwfHJTkNWqIaHTcgpBTrOJhtbHq+Cbs0IAA00tGBw97Qgs7j8Y3JWpCHzGaDDnlfnXjV0U
	9Ne+JCDLUIfg0qcmAn60uhDcrP6IwHYtmYIvulsE1LtHwGtPJwVPDRkUfLOfx9BRSkFusk0A
	9udtCC6Y9Aia39swpFwuocB4wUpCueseDfa23xgajXoMhda14LQ0k1Cjy8P+c/2uG2PBlJWC
	/eUrBkNxBYZeSwG9LB9xXu0Zkisou4057SsfxRVdLEJcf58ecd35KQSn1fnbR+2dBHe8LIHL
	r2mnuD7PG4qz9eSS3LM8lrtysg9zmbWhXHlOE71h+RbRol28UhHPq2YviRRFuV7U4H3GqYnn
	OqYcQzkh6ShAyDLzWLPpJT3IFDOVbWjoJQY5iJnIlp1uFqQjkZBg6kPY1N4zQ8JoZjPr8KTj
	QSaZKez9YgsaZDEzn012naX/hYawhaWVQ/4A/9zg6BtiCRPOmtO9Ah0S5aJhBShIERsfI1co
	w2epo6OSYhWJs3bujbEi/ztZDv/OvIu661dVIUaIpIHiyoQwhUQgj1cnxVQhVkhIg8TtSplC
	It4lTzrIq/buUB1Q8uoqNE5ISseK12ziIyXMbnkcH83z+3jVfxULA4KPoSrZO2/GxsiljtWv
	3/bYuezt4S0rkhYfrs92abZFjFqhC5zg3Rr4feXn1WHVCzbKZqLPZtGDlt3OuJ+NiYaLZl/J
	pHk7PyzJxNkVjhHLJp+Y9KskVBZxqtbxPfd6xKHZwdbA4d4HGRldHSfix0/f8zjAe3L8qIQj
	XVfWXx0zsrg0sW7uKympjpKHzSBUavlfDbu1g0oDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

commit eb1cfd09f788e ("lockdep: Add lock_set_cmp_fn() annotation") has
been added to address the issue that lockdep was not able to detect a
true deadlock like the following:

   https://lore.kernel.org/lkml/20220510232633.GA18445@X58A-UD3R/

The approach is only for lockdep but dept should work being aware of it
because the new annotation is already used to avoid false positive of
lockdep in the code.

Make dept aware of the new lockdep annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 10 +++++++++
 kernel/dependency/dept.c | 48 +++++++++++++++++++++++++++++++++++-----
 kernel/locking/lockdep.c |  1 +
 3 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 7d5e01f56e8e..bbcb48f6140a 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -53,6 +53,11 @@ struct dept_map {
 	const char			*name;
 	struct dept_key			*keys;
 
+	/*
+	 * keep lockdep map to handle lockdep_set_lock_cmp_fn().
+	 */
+	void				*lockdep_map;
+
 	/*
 	 * subclass that can be set from user
 	 */
@@ -79,6 +84,7 @@ struct dept_map {
 {									\
 	.name = #n,							\
 	.keys = (struct dept_key *)(k),					\
+	.lockdep_map = NULL,						\
 	.sub_u = 0,							\
 	.map_key = { .classes = { NULL, } },				\
 	.wgen = 0U,							\
@@ -179,6 +185,8 @@ extern void dept_softirqs_on_ip(unsigned long ip);
 extern void dept_hardirqs_on(void);
 extern void dept_softirqs_off(void);
 extern void dept_hardirqs_off(void);
+
+#define dept_set_lockdep_map(m, lockdep_m) ({ (m)->lockdep_map = lockdep_m; })
 #else /* !CONFIG_DEPT */
 struct dept_key { };
 struct dept_map { };
@@ -221,5 +229,7 @@ struct dept_ext_wgen { };
 #define dept_hardirqs_on()				do { } while (0)
 #define dept_softirqs_off()				do { } while (0)
 #define dept_hardirqs_off()				do { } while (0)
+
+#define dept_set_lockdep_map(m, lockdep_m)		do { } while (0)
 #endif
 #endif /* __LINUX_DEPT_H */
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 1c6eb0a6d0a6..a0eb4b108de0 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1615,9 +1615,39 @@ static int next_wgen(void)
 	return atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
 }
 
-static void add_wait(struct dept_class *c, unsigned long ip,
-		     const char *w_fn, int sub_l, bool sched_sleep,
-		     bool timeout)
+/*
+ * XXX: This is a temporary patch needed until lockdep stops tracking
+ * dependency in wrong way.  lockdep has added an annotation to specify
+ * a callback to determin whether the given lock aquisition order is
+ * okay or not in its own way.  Even though dept is already working
+ * correctly with sub class on that issue, it needs to be aware of the
+ * annotation anyway.
+ */
+static bool lockdep_cmp_fn(struct dept_map *prev, struct dept_map *next)
+{
+	/*
+	 * Assumes the cmp_fn thing comes from struct lockdep_map.
+	 */
+	struct lockdep_map *p_lock = (struct lockdep_map *)prev->lockdep_map;
+	struct lockdep_map *n_lock = (struct lockdep_map *)next->lockdep_map;
+	struct lock_class *p_class = p_lock ? p_lock->class_cache[0] : NULL;
+	struct lock_class *n_class = n_lock ? n_lock->class_cache[0] : NULL;
+
+	if (!p_class || !n_class)
+		return false;
+
+	if (p_class != n_class)
+		return false;
+
+	if (!p_class->cmp_fn)
+		return false;
+
+	return p_class->cmp_fn(p_lock, n_lock) < 0;
+}
+
+static void add_wait(struct dept_map *m, struct dept_class *c,
+		unsigned long ip, const char *w_fn, int sub_l,
+		bool sched_sleep, bool timeout)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
@@ -1658,8 +1688,13 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 		if (!eh->ecxt)
 			continue;
 
-		if (eh->ecxt->class != c || eh->sub_l == sub_l)
-			add_dep(eh->ecxt, w);
+		if (eh->ecxt->class == c && eh->sub_l != sub_l)
+			continue;
+
+		if (i == dt->ecxt_held_pos - 1 && lockdep_cmp_fn(eh->map, m))
+			continue;
+
+		add_dep(eh->ecxt, w);
 	}
 
 	wg = next_wgen();
@@ -2145,6 +2180,7 @@ void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u,
 	m->name = n;
 	m->wgen = 0U;
 	m->nocheck = !valid_key(k);
+	m->lockdep_map = NULL;
 
 	dept_exit_recursive(flags);
 }
@@ -2366,7 +2402,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
 		if (!c)
 			continue;
 
-		add_wait(c, ip, w_fn, sub_l, sched_sleep, timeout);
+		add_wait(m, c, ip, w_fn, sub_l, sched_sleep, timeout);
 	}
 }
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 39b9e3e27c0b..c99f91f7a54d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -5035,6 +5035,7 @@ void lockdep_set_lock_cmp_fn(struct lockdep_map *lock, lock_cmp_fn cmp_fn,
 		class->print_fn = print_fn;
 	}
 
+	dept_set_lockdep_map(&lock->dmap, lock);
 	lockdep_recursion_finish();
 	raw_local_irq_restore(flags);
 }
-- 
2.17.1



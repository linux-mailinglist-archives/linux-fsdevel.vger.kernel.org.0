Return-Path: <linux-fsdevel+bounces-63248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEACBBB3152
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C6E1886192
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F72314D15;
	Thu,  2 Oct 2025 08:14:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFD330EF7C;
	Thu,  2 Oct 2025 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392847; cv=none; b=MtIgxvSUHjhj+XfVDX0RFw+jL71EwPO/+zrfAl6fqZiPOaZe4y1HWWFKE4obHQrO4egMMxX/HR1i1dtC5fv8DN2JVeJ5s5BGM5Vqdbj8nzWSOKfQwxtM66jx4cgtLIpTEsRSQ1pFSEMjahzKBZwwyoJe7RiO6NLQAKB6Oz8zth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392847; c=relaxed/simple;
	bh=GWWReu+uieKdoNR9LXX0pJ0D/rvvILcUDOdshrqbVYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=E1FqDhLOBymjjz9LWaQpNSMy8OX+S+8AwqABQGO130gyu9/dps/sYF+6k/fOa73ksj+JtsFW49rh6ldQOqCEyx673yUATgIub9f5ISv/U11Jn16//Hj9aVmjvh4YyKhTyOjF7142n3G3ZwrntfQGsiQ2cGaQs9vJzFLW2OuYXGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-83-68de3412c5ce
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
Subject: [PATCH v17 33/47] dept: make dept aware of lockdep_set_lock_cmp_fn() annotation
Date: Thu,  2 Oct 2025 17:12:33 +0900
Message-Id: <20251002081247.51255-34-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSf2yLeRzH7/v86tNG5VHE40eCHhm78zMjHwkiEclzQSIRiXC5rdYn19IV
	3YwRUWejZmSa2xbtRjdWXVu/nvqxM02md8quJ9qNdthatWrMNBW3H9msphX+e+XzeX0+73/e
	NC4LkdNotbaI12kVGjklISSJcfULJuaEVYv/HAQIHm0loPaakwL/VQeCyIABwdAnMw4po1cE
	/cMvRTDm9iKoDhhxqIrGKKjpPUpA0lqBwBQ3iyARaSHBGvuMQaz1BIILDa60UuVHUB/txuGm
	N4zgTeUtHDpi4+HpQJKCtqpTFCQCtRhY/nCTcOziNQqq6wQCAn2jGHRVGzFwCBshYo0T4Kts
	wNKBaeHGFDDXvMWg6koLBsNWuwjMjztIeG0ziWA0ugSuJp6Q0Bc3UhB5eJyEO/pXIhCeP0DQ
	/zSKgbMijoPQEyTB/eInqD9+iYB77jYCDKl+BN7m1xhUXL9FQtg5RoLePERCu8OfTvc+IqDN
	1ERAYyiAgevxfzgMnpkO/rOnyTVKzu66jXFl7SmKc553Iu7TiBFxf79P4lyj7z3FjQw8ozj3
	oIXg/m1gub9M3SLOIuzjSv9JkJzLls1dvNeLcYL9JMUJH42iTfO2SVYqeY26mNctWp0nUXnG
	LuB7TFkHguFmXI/OzyxHNM0yOey7D6u+41iwqByJaYrJYjs7h/EMT2Jmsa7TcTLDOOObwQYD
	P2f0icxW1pBAGSSYuez9uv0ZQ8osZ+/21GMZZpmZrON669cv4vS8I+ojMixjlrFlydK0I0k7
	ZjGbsL/8djCVvW/rJCqR1IJ+sCOZWltcoFBrchaqSrTqAwvzdxcIKF036+HR7c3oo3+zBzE0
	ko+T+ud2q2SkoriwpMCDWBqXT5Lm2bpUMqlSUXKQ1+3O1e3T8IUeNJ0m5FOkSwf3K2XM74oi
	fhfP7+F137cYLZ6mRyt/NPEtqV8m7DjSlTfL2aeR9e/sgcbwmZjvpCU/OPWyYK05FpqszW1L
	DIUK8jFN3daU/dfYudZHYW2O5ND6S+MNHqidPbppLazTHlpk01v3njPs3Lt+TWkyS/O2/H/S
	LW4feXCnPLill9xW1hdZ8eRD02/dxfNNjh3Zc0LKuxvkRKFKsSQb1xUqvgAQuvUxagMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+917d+91tbgso0v2YiRCpClYnZ5EGV2KIqjoReioixvqjM1M
	g0KbI7E0G01pU1tK03Tp2lS0WJjaoGzYsmaU81G+yi2ptPK5tqB/Dp9zvh8O549D42KbYDkt
	V6TxSoU0WUIKCeGhbepIcWyvLNpsjgZ3dgsBkxO5BJTUmUnItd4RwOvaGgR9k7kIfs8YcNA0
	+wmY0zoomJj6SIHf7kBQ5NLiYK7PxuCnZZ6EsbYfCHQDgyQUf8kmYNx0A4F+2EDBl+f7wNf3
	RAB+zwgG3b+8CEyD8xgMtlxDMFeUBHfLbSTMODtxKNa9RnBvwIPDqCUQ1jt6EdirrpIwVNiA
	Q9fgYng7OU7CC911EnyuEgy+WUgwXrULoNSgRaCuqCOhqNRKQHP/YwpcY7MY9BRpMaixHoQ+
	0zABHYXlWOC+gPVoGRiK1VigjGKge/gEgylTNQWvKnoIMGWFg8HZJYBPVXoKZgdiwG9MBUfN
	CAWemzoCan2dgl06xP3WFBBcta0R4zRv5kjOXGZG3My0FnET99U4pykMtG3ecZzLsV3k7nd4
	SW568h3J2X8ZCe5lOcvdckZyzXoPxeU8/UAd3npKuP0cnyxP55UbdiYIZa3+u/h5fUSGu7cJ
	z0Jlq/MQTbNMLOt3p+WhEJpkItj376fwIIcya1hb/rAgyDjTsYJ1u9YH9SXMCTbXh4JIMOHs
	s9KLQUPEbGIff76HBZllVrM1lpZ/W0IC866BDiLIYmYjqxnPwQqR0IgWVKNQuSI9RSpP3hil
	SpJlKuQZUWdTU6wo8Eqmy7O3mtBE175WxNBIskjkCvfIxAJpuiozpRWxNC4JFSVU9cjEonPS
	zEu8MjVeeSGZV7WiMJqQLBPtP84niJlEaRqfxPPneeX/FKNDlmehT4nT+zPa2e6+trAXZfPR
	tWE2C3Sfadp2c2/OWWuUlzpw+qvBaW48+UB+e01z+4W8HZZVo5VLd6n7j/WPxa6tx2bfxcT5
	OqvX006zMYm80hC3Jd2RXxm/p2DzlD10+kMFDgXfz8S3LNQf/ekuwUa97UMNfxKPeN5WrNxt
	VEREGCWESiaNWYcrVdK/Oib6C0YDAAA=
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
index b6dc4ff19537..8b4d97fc4627 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -130,6 +130,11 @@ struct dept_map {
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
@@ -156,6 +161,7 @@ struct dept_map {
 {									\
 	.name = #n,							\
 	.keys = (struct dept_key *)(k),					\
+	.lockdep_map = NULL,						\
 	.sub_u = 0,							\
 	.map_key = { .classes = { NULL, } },				\
 	.wgen = 0U,							\
@@ -427,6 +433,8 @@ extern void dept_softirqs_on_ip(unsigned long ip);
 extern void dept_hardirqs_on(void);
 extern void dept_softirqs_off(void);
 extern void dept_hardirqs_off(void);
+
+#define dept_set_lockdep_map(m, lockdep_m) ({ (m)->lockdep_map = lockdep_m; })
 #else /* !CONFIG_DEPT */
 struct dept_key { };
 struct dept_map { };
@@ -469,5 +477,7 @@ struct dept_ext_wgen { };
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



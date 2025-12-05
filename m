Return-Path: <linux-fsdevel+bounces-70785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB74CCA6991
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 09:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 602D03421A75
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C99633DEEC;
	Fri,  5 Dec 2025 07:21:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DC92DF137;
	Fri,  5 Dec 2025 07:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919275; cv=none; b=E83YwJp7UMSYfbJhgkE16Z4V+lRr5TXJ9m+zvg6mldd2cwcKeH2WvNciFxSCK+b05t7g9Ey2jFbHDHpw377dcMhH2xgqMk4ZjnyGXibYsa6W54os5s6AsIF7Ad5nBA6dZObEokdRjIuuLVnNoHf4JXOHdLxlj+1CS3wXGhkOpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919275; c=relaxed/simple;
	bh=HQb+FieD5UTtfcyEdgT0lo4GMUWAEhmBX2C4Cisefmo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GpDG69VHZ8SvaUOG5CSi+rb2TjGh+XRD3/FR+YrQtb+kFfa4o4AWBsF/ONNd7tK6OrgZHrg2CBFP17NBFRd/FDIJjcNG+dfBrIGe6rk+/PDKprVSatMWDjjOAlAxAYBI9LTqrhj2uFUwU1t5sfG13uBbEb0v5AJUiMtJdkd0jdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-2d-693287717bab
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
Subject: [PATCH v18 27/42] dept: assign dept map to mmu notifier invalidation synchronization
Date: Fri,  5 Dec 2025 16:18:40 +0900
Message-Id: <20251205071855.72743-28-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTHfe597gudXS6d2R7dErXGmEhgSNx2NIvZsjjvzBKXGP3gskAz
	buTG8rKivGwxvAiDIQ5kqx+AyKsVSysEcAhSveIoIjDasdAOCsjW1ZiKGEIhpRBWa/z2O+d3
	zj85yeFpzSSzjZfTzkqGNJ1ey6qwan5zQ+x3JQlyvNd1EEqL88Az62VgokDBEFgqxVDbZmFh
	vaabg4euQgyOm60IZgOlCFZCNTQU92xgWK+yc7AUnOLAWIBgw2ZHcMVZRYOlq4AC/4NFBMY5
	LwsLpnIETweOgFcpQeC/8oKF0OgYDQ1z0zR02WcQ2FoKWRj3vgl/BRZYGDJeZGHeWUvB83YW
	nCN+BBea2sLkX6Ng1uTDYLTeoSBoMnMw0uTBYMrfDf+0VHNgb33CwXSFEcPN+TEG/L4qFmYH
	f2Sg4+8BBKW9AQy2yRjosw1hGO+tZaG8/RYDM5YNBvJrVhhwKMMMDNsfYhiqvoFharSCg7Fe
	KwNzj90MdI6O0OCu/A/BL8994UOWTfQnyaK58zdKtFy1IDG0WoXEpWsXaLG4MlwWdWaL14af
	saJtuR6LjxqJ2PzTKiX2VE9zYtHdSU6s7zgnFv0+z4hNfU8psWExwHy155Tq42RJL2dJhvcP
	JalS/jArKMP1Uc6gp47NRzOxZSiKJ8J+MlA4xb7m1TUH/ZJZYQ9xu4MR3iLsIJ2XfEwZUvG0
	ML6dlAR/joi3hG+I4ukOC57Hwm7iac55iWrhQ+L7F7+K3E5a25XIdFS4bXStRlgjfEDqylYi
	kUSoiyJNwRD3amErud/ixpVIXY82mZFGTstK1cn6/XEpuWlyTty36akdKPxxpvNrX99Gi47j
	/UjgkXazWsneJ2sYXVZmbmo/Ijyt3aJ+po+XNepkXe73kiE90XBOL2X2o3d5rH1HnbCcnawR
	TuvOSmckKUMyvLYUH7UtH5mP3eKSknYNfrZQYbF2BR4byTGq4Orn1rzytx/lLTbmPDh/VJfo
	9n9qztu7c2zmiSNkPezxVATl65ti3vAmSida4389Cve+jKOVQ8GL77VFp59aOhDvdu7o+7P2
	pOsuuTx1fOcPOGN9SGG7Y2/EtDkTQhNd0a7oiS8mHRO25Z5mLc5M0e3bSxsydf8D3Z7qXW0D
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbWxLcRTG/e+9vb0rlasWrpKgMhOy2cTmBPH2wW4ImS+YeCu72Zp1Q8t0
	QqyrZjUvmUa7UGxqa6Qbm+6FkUZtDJuyKdbQqZcqy8aEzrTrNjXx5eR3zvOcJ+fDoXBRA09M
	yXL2c4ocqVxCCgjB+iWauH2FC2QJbdVRoNMeBY/Xx4NXagcB/QEdAReqq0gYMt3kg852jgeP
	OgsIaL9eicDbr0MwMGjCQds4QsCQvoUPgeAbPhjUCEbsLQiMHXoc3O13caiqU2Pws2aYhJ7m
	HwgM730klHSrCeiznERw3m/iQ/eDFPjqvcODka7PGHT+6kVg8Q1j4HMUIhgyZkGpuTaybvxO
	wqDzGQ4lhnYEl9934fCj+x2Cupa3COxXC0j4VFyPg8s3Hl7095Hw2HCChK8dFzD4VkNCWYGd
	Bx1PehBcNOkR+F/bMdBcqSbBeNFGQOO723zo6Alj4DHqMai0rQOvxU9AW7EZi5wbcd2YDKYS
	DRYpXzAwXLuDQdBi5a+oQOyA9jTBWmsbMFb7fIhkqy5VIXYwpEdsoEKDs9riSNvc24ezx2oP
	shVtvSQb6n9JsvZfZQTbambY8uMhjD3jjGMbz3fxU1duESxN5+SyXE4xf9lOQeZTqwPt7Vyk
	eugpJfPR27giFEUx9EImFG7H/zJJxzJud3CUo+kZTO0pP68ICSicdk1nCoOnR4WJ9DbG4bkZ
	ESiKoGMYT7nqLwrpZMb/kfgXOZ2prHGMuqMiY0NnaJRFdBJTWjTAK0aCMjTGiqJlObnZUpk8
	KV6ZlZmXI1PF796TbUORb7IcCZ+5hQKulCZEU0gyTug4mCgT8aS5yrzsJsRQuCRa2CtPkImE
	6dK8Q5xizw7FATmnbEJTKUIyWbhmE7dTRGdI93NZHLeXU/xXMSpKnI/ikz+Yr4rLVcsnZYjn
	TE07Xna/dcLqkHfK4iezUw8NhrfrhrepVc76fKO1PmlgGtpqnXcv+1Hu7Gazxh1ucs90f451
	DGvH2sR9rWdTsMOr1m4Onmp4ecSnr2y0WgNxydPymt/EuxPTahI2uFy7nHUxv+t+L97YVaAR
	0/xZcudSrYRQZkoT5+IKpfQPavH1GEkDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Resolved the following false positive by introducing explicit dept map
and annotations for dealing with this case:

   *** DEADLOCK ***
   context A
       [S] (unknown)(<sched>:0)
       [W] lock(&mm->mmap_lock:0)
       [E] try_to_wake_up(<sched>:0)

   context B
       [S] lock(&mm->mmap_lock:0)
       [W] mmu_interval_read_begin(<sched>:0)
       [E] unlock(&mm->mmap_lock:0)

   [S]: start of the event context
   [W]: the wait blocked
   [E]: the event not reachable

dept already tracks dependencies between scheduler sleep and ttwu based
on internal timestamp called wgen.  However, in case that more than one
event contexts are overwrapped, dept has chance to wrongly guess the
start of the event context like the following:

   <before this patch>

   context A: lock L
   context A: mmu_notifier_invalidate_range_start()

   context B: lock L'
   context B: mmu_interval_read_begin() : wait
   <- here is the start of the event context of C.
   context B: unlock L'

   context C: lock L''
   context C: mmu_notifier_invalidate_range_start()

   context A: mmu_notifier_invalidate_range_end()
   context A: unlock L

   context C: mmu_notifier_invalidate_range_end() : ttwu
   <- here is the end of the event context of C.  dept observes a wait,
      lock L'' within the event context of C.  Which causes a false
      positive dept report.

   context C: unlock L''

By explicitly annotating the interesting event context range, make dept
work with more precise information like:

   <after this patch>

   context A: lock L
   context A: mmu_notifier_invalidate_range_start()

   context B: lock L'
   context B: mmu_interval_read_begin() : wait
   context B: unlock L'

   context C: lock L''
   context C: mmu_notifier_invalidate_range_start()
   <- here is the start of the event context of C.

   context A: mmu_notifier_invalidate_range_end()
   context A: unlock L

   context C: mmu_notifier_invalidate_range_end() : ttwu
   <- here is the end of the event context of C.  dept doesn't observe
      the wait, lock L'' within the event context of C.  context C is
      responsible only for the range delimited by
      mmu_notifier_invalidate_range_{start,end}().

   context C: unlock L''

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mmu_notifier.h | 26 ++++++++++++++++++++++++++
 mm/mmu_notifier.c            | 31 +++++++++++++++++++++++++++++--
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index d1094c2d5fb6..2b70dce149f0 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -428,6 +428,14 @@ static inline int mmu_notifier_test_young(struct mm_struct *mm,
 	return 0;
 }
 
+#ifdef CONFIG_DEPT
+void mmu_notifier_invalidate_dept_ecxt_start(struct mmu_notifier_range *range);
+void mmu_notifier_invalidate_dept_ecxt_end(struct mmu_notifier_range *range);
+#else
+static inline void mmu_notifier_invalidate_dept_ecxt_start(struct mmu_notifier_range *range) {}
+static inline void mmu_notifier_invalidate_dept_ecxt_end(struct mmu_notifier_range *range) {}
+#endif
+
 static inline void
 mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 {
@@ -439,6 +447,12 @@ mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 		__mmu_notifier_invalidate_range_start(range);
 	}
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+
+	/*
+	 * From now on, waiters could be there by this start until
+	 * mmu_notifier_invalidate_range_end().
+	 */
+	mmu_notifier_invalidate_dept_ecxt_start(range);
 }
 
 /*
@@ -459,6 +473,12 @@ mmu_notifier_invalidate_range_start_nonblock(struct mmu_notifier_range *range)
 		ret = __mmu_notifier_invalidate_range_start(range);
 	}
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
+
+	/*
+	 * From now on, waiters could be there by this start until
+	 * mmu_notifier_invalidate_range_end().
+	 */
+	mmu_notifier_invalidate_dept_ecxt_start(range);
 	return ret;
 }
 
@@ -470,6 +490,12 @@ mmu_notifier_invalidate_range_end(struct mmu_notifier_range *range)
 
 	if (mm_has_notifiers(range->mm))
 		__mmu_notifier_invalidate_range_end(range);
+
+	/*
+	 * The event context that has been started by
+	 * mmu_notifier_invalidate_range_start() ends.
+	 */
+	mmu_notifier_invalidate_dept_ecxt_end(range);
 }
 
 static inline void mmu_notifier_arch_invalidate_secondary_tlbs(struct mm_struct *mm,
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 8e0125dc0522..31af5ea54a0c 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -46,6 +46,7 @@ struct mmu_notifier_subscriptions {
 	unsigned long active_invalidate_ranges;
 	struct rb_root_cached itree;
 	wait_queue_head_t wq;
+	struct dept_map dmap;
 	struct hlist_head deferred_list;
 };
 
@@ -165,6 +166,25 @@ static void mn_itree_inv_end(struct mmu_notifier_subscriptions *subscriptions)
 	wake_up_all(&subscriptions->wq);
 }
 
+#ifdef CONFIG_DEPT
+void mmu_notifier_invalidate_dept_ecxt_start(struct mmu_notifier_range *range)
+{
+	struct mmu_notifier_subscriptions *subscriptions =
+		range->mm->notifier_subscriptions;
+
+	if (subscriptions)
+		sdt_ecxt_enter(&subscriptions->dmap);
+}
+void mmu_notifier_invalidate_dept_ecxt_end(struct mmu_notifier_range *range)
+{
+	struct mmu_notifier_subscriptions *subscriptions =
+		range->mm->notifier_subscriptions;
+
+	if (subscriptions)
+		sdt_ecxt_exit(&subscriptions->dmap);
+}
+#endif
+
 /**
  * mmu_interval_read_begin - Begin a read side critical section against a VA
  *                           range
@@ -246,9 +266,12 @@ mmu_interval_read_begin(struct mmu_interval_notifier *interval_sub)
 	 */
 	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
-	if (is_invalidating)
+	if (is_invalidating) {
+		sdt_might_sleep_start(&subscriptions->dmap);
 		wait_event(subscriptions->wq,
 			   READ_ONCE(subscriptions->invalidate_seq) != seq);
+		sdt_might_sleep_end();
+	}
 
 	/*
 	 * Notice that mmu_interval_read_retry() can already be true at this
@@ -625,6 +648,7 @@ int __mmu_notifier_register(struct mmu_notifier *subscription,
 
 		INIT_HLIST_HEAD(&subscriptions->list);
 		spin_lock_init(&subscriptions->lock);
+		sdt_map_init(&subscriptions->dmap);
 		subscriptions->invalidate_seq = 2;
 		subscriptions->itree = RB_ROOT_CACHED;
 		init_waitqueue_head(&subscriptions->wq);
@@ -1070,9 +1094,12 @@ void mmu_interval_notifier_remove(struct mmu_interval_notifier *interval_sub)
 	 */
 	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
-	if (seq)
+	if (seq) {
+		sdt_might_sleep_start(&subscriptions->dmap);
 		wait_event(subscriptions->wq,
 			   mmu_interval_seq_released(subscriptions, seq));
+		sdt_might_sleep_end();
+	}
 
 	/* pairs with mmgrab in mmu_interval_notifier_insert() */
 	mmdrop(mm);
-- 
2.17.1



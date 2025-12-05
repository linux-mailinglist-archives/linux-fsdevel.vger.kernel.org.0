Return-Path: <linux-fsdevel+bounces-70800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CECF1CA7273
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 11:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E82330DDC35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F493330B33;
	Fri,  5 Dec 2025 07:22:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DD9335561;
	Fri,  5 Dec 2025 07:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919333; cv=none; b=LM+NOiknp4rgl2TcXzn0STI7S61oakYJMovPTzmeo9zoUmEd2q2COCbgZasnQhiD/jrbaK/mYyP//GYnHjgsjHGoWastgtQGPXCdJOejFYjLXQLHfjduv4Z0SJ4Ue7jNoVwRTD0ifZtrtqIsIn2CCUj2xyiq4rhawOvd1WGr6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919333; c=relaxed/simple;
	bh=BKdTduih/1l/oeBZ8PU6DuY+E9HBd565xkElM5qpN+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=d8bAP67iZ+qcBCE1IPX2iV1tN+x3i5gcMDlgiAo/AYwpRkfSFimZNVhxJmh9HcjAjwZraNfXw3CmK+2DLlmu7ZEjp/Ap20VLrl9GYnxjQS+jM5K7C9lj+p2MTSAI8Ipgu1zhIjTgBtQGkZL9FqAOeXMqDxuxAtvM2cnNnBMShAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-c0-693287765fe5
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
Subject: [PATCH v18 40/42] dept: track PG_writeback with dept
Date: Fri,  5 Dec 2025 16:18:53 +0900
Message-Id: <20251205071855.72743-41-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSbUxTZxQH8D3Pfe7Tl9jsWkl6QTNm1WDw3el2ks3FL0tuYvaSTL/oEq30
	ZnSUYopQWTSrbgzGGDCStoEyoKIdYAVsVbTQWDBzIUgoQ6EgHWJIHatl2NFqcYQJxm+/nP85
	/09HyiiDbJpUZzgpGg0avZrKiTy6yrGtsGS3budCxQYoLf4GRs76CcTnSwnUtbsoLNo7JRBo
	u4Tg2Qs7A0u+OwisQ9UMBAO3GHBdPYshcjuGwDI1TeEfZzmC2rBdAtHJLhaWQo8xjCaeIJj2
	lyBYtOZAw3kPhYh1jsKLgUEGbJYAAsdUiIE+y48UokN1GGY7KPxir0YQHvdh+LapncLNh14J
	TFirMUw6wwT6q85jsM1QsF5Rgd32FwbL5S4Md5smCDjNm2CpMQ9ClRYCbdFBFvr+HGEhEq6m
	0Gl+KAH32G8I5u9NYSj1xgn4xreA4/sLBGrqJyh0+/oI3LnxCMOwt45Cecc1FgL+fhbaHwcx
	9NW2EHgwUCmBQe9lFi6ODmFIVKzdrxVaPdexUPzHIhVc9S4kfOcxCQvx+1TwJRqJ8PPANuFm
	bUgiNLoLBE9zptDUPYMFRyzOCuORfYK79QcqlEXvYWFipJt+lnlY/oFW1OsKReOOD4/Js9tm
	m9GJ5Funpq5XYDNKppYhmZTn9vD1VRH02raWIbJsymXwwWCSWXYK9zbv+SnMliG5lOGG0/mS
	ZMVKsIbbx1vbbrPLJtwmPjZ3Cy9bwb3L1/wbI69K0/lLHf6VfdnLuWV0YcVKbi/fUPZspZTn
	7DL+ymgl8+ogle9pDpIqpGhEb7Qipc5QmKvR6fdszy4y6E5tz8rLdaOX/+Y889+RGygW+LwX
	cVKkXqXwm3bplKymML8otxfxUkadonii36lTKrSaoq9FY95RY4FezO9Fa6VErVLsTpi0Su5L
	zUkxRxRPiMbXKZbK0szozNODV/u3bmQSNarK4XhBw1y6TJwVTv9q2//34kwLu2QyNHllyTVZ
	nOt+r/nuV4G0Nw8cnF63bmx1z4X3tc9tsYGNJXmZORnOHc3HJ02Hus+Nf6p6/sk7qWOP6t47
	YKBkPtlTHMpY31X+0e8PDm/YaryYtf5jR2dsc7/qSNTm/iJltZrkZ2t2ZTLGfM3/WzAWfmsD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+923o8VtSd0MykYRBNoDixM9qD+qS5D0V0UEOfKWN+eDzUdG
	YdMumpas2Sa5fGQ5TE3XZqnZaChJ75xWSrVMmpa5tHw2l9o0+ufwOef7PV/OH4fBFQ1kCCPG
	JwmaeJVaSckIWeTWzLDkrI3i+jIpArKldPjY7SHhnc5JwNhoNgHXa6spmDLX05Btu0bCk84M
	AtpqqhB0j2UjmPCbcZAaZwiYMrTSMOr7QINRh2DG0YrA5DLg0NX2CIfqOh0GI9ZpCgZahhEY
	ezwUFPTrCBiyXEJQ2Gemof/xXvjR3UTCjPsrBp3jXgQWzzQGHmcWgilTLJSU2QPrpp8U+F++
	xqHA2IbgRo8bh+H+zwjqWj8hcFRkUNCrv4dDh2cBvBkbouCpMZeCH67rGAxaKSjNcJDgejGA
	oMhsQND33oFB5s1aCkxFNgIaPz+gwTXwB4OPJgMGVbb90G3pI+C5vgwLnBtw3V0C5oJMLFC+
	YWC804SBz1JJ7yxH/ISUR/CV9vsYL7VPUXx1cTXi/ZMGxI+WZ+K8pA+0Ld4hnL9gT+XLn3sp
	fnLsLcU7xksJ/lkZx9+6OInxV16G8Y2FbvrAriOybdGCWkwRNOt2RMliagYrUKJv+eme+3nY
	eeRbmoOCGI6N4Apuu4hZptg1XFeXD5/lYDaUs1/uI3OQjMHZjhVcli9vTljEbudMNS3kLBPs
	am745yNsluXsZu7ayDDxL3QFV2V1zvmDAnNj5+QcK9hNXEnOBKlHslI0rxIFi/EpcSpRvSlc
	GxuTFi+eDj+eEGdDgX+ynPtzpQGNduxtRiyDlPPlztQNooJUpWjT4poRx+DKYLlXvV5UyKNV
	aWcETcIxTbJa0DajZQyhXCLfd0iIUrAnVUlCrCAkCpr/KsYEhZxHxQ11Cekq84lDBze/Ct1z
	tPhUVMdjjTnfeXehfW14mGQ1rEwvKuEGv+yIfvXQpZOW+UMdqx6KjZ25bfvIXmd707OkX78X
	aw7HJRfLdkcOzUt1WrxifVaFtHQkVKxPFPVnS9cZr85vWZC/hSmMzHf3br0ZQee4u/wv/O++
	76Yz2pWENka1YS2u0ar+AkgIPJZLAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Makes dept able to track PG_writeback waits and events, which will be
useful in practice.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h   | 1 +
 include/linux/page-flags.h | 7 +++++++
 mm/filemap.c               | 6 +++++-
 mm/mm_init.c               | 1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 85d06073d37b..fa6ba4196e0d 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -222,6 +222,7 @@ struct page {
 #endif
 	struct dept_page_usage usage;
 	struct dept_ext_wgen pg_locked_wgen;
+	struct dept_ext_wgen pg_writeback_wgen;
 } _struct_page_alignment;
 
 /*
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 0b0655354b08..ec736811a2c6 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -203,6 +203,7 @@ enum pageflags {
 #include <linux/dept.h>
 
 extern struct dept_map pg_locked_map;
+extern struct dept_map pg_writeback_map;
 
 static inline void dept_set_page_usage(struct page *p,
 		unsigned int new_type)
@@ -292,6 +293,8 @@ static inline void dept_page_set_bit(struct page *p, int bit_nr)
 
 	if (bit_nr == PG_locked)
 		dept_request_event(&pg_locked_map, &p->pg_locked_wgen);
+	else if (bit_nr == PG_writeback)
+		dept_request_event(&pg_writeback_map, &p->pg_writeback_wgen);
 }
 
 static inline void dept_page_clear_bit(struct page *p, int bit_nr)
@@ -300,6 +303,8 @@ static inline void dept_page_clear_bit(struct page *p, int bit_nr)
 
 	if (bit_nr == PG_locked)
 		dept_event(&pg_locked_map, evt_f, _RET_IP_, __func__, &p->pg_locked_wgen);
+	else if (bit_nr == PG_writeback)
+		dept_event(&pg_writeback_map, evt_f, _RET_IP_, __func__, &p->pg_writeback_wgen);
 }
 
 static inline void dept_page_wait_on_bit(struct page *p, int bit_nr)
@@ -311,6 +316,8 @@ static inline void dept_page_wait_on_bit(struct page *p, int bit_nr)
 
 	if (bit_nr == PG_locked)
 		dept_wait(&pg_locked_map, evt_f, _RET_IP_, __func__, 0, -1L);
+	else if (bit_nr == PG_writeback)
+		dept_wait(&pg_writeback_map, evt_f, _RET_IP_, __func__, 0, -1L);
 }
 
 static inline void dept_folio_set_bit(struct folio *f, int bit_nr)
diff --git a/mm/filemap.c b/mm/filemap.c
index d7e567af3261..0ce3f9307582 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1191,7 +1191,7 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
 	 * dept_page_clear_bit() being called multiple times is harmless.
 	 * The worst case is to miss some dependencies but it's okay.
 	 */
-	if (bit_nr == PG_locked)
+	if (bit_nr == PG_locked || bit_nr == PG_writeback)
 		dept_page_clear_bit(&folio->page, bit_nr);
 
 	spin_lock_irqsave(&q->lock, flags);
@@ -1248,6 +1248,9 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 struct dept_map __maybe_unused pg_locked_map = DEPT_MAP_INITIALIZER(pg_locked_map, NULL);
 EXPORT_SYMBOL(pg_locked_map);
 
+struct dept_map __maybe_unused pg_writeback_map = DEPT_MAP_INITIALIZER(pg_writeback_map, NULL);
+EXPORT_SYMBOL(pg_writeback_map);
+
 static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
 {
@@ -1686,6 +1689,7 @@ void folio_end_writeback_no_dropbehind(struct folio *folio)
 		folio_rotate_reclaimable(folio);
 	}
 
+	dept_page_clear_bit(&folio->page, PG_writeback);
 	if (__folio_end_writeback(folio))
 		folio_wake_bit(folio, PG_writeback);
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index f1d3e4afd43b..9f99eeb99ca3 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -589,6 +589,7 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
 	dept_ext_wgen_init(&page->pg_locked_wgen);
+	dept_ext_wgen_init(&page->pg_writeback_wgen);
 
 	INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
-- 
2.17.1



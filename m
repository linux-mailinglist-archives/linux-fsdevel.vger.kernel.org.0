Return-Path: <linux-fsdevel+bounces-63241-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D40BB30C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42212383132
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1611530C11E;
	Thu,  2 Oct 2025 08:13:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3BF2DBF73;
	Thu,  2 Oct 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392838; cv=none; b=j6H7f+vjhb3y1p23HYONCteS6DufZ6GjqvizIQ2r5v1bwzHmDiL2+L35OoQc9IBdj2WVAORAJgv60ehkSZU6g9TAO0SdK0yp5iyI7/nSPCsj/U5wRy593dbNmvK/SzSQqRNlMD5TQjtBUHzC4NIsUsgrS8r02+3DgntEe6fjE+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392838; c=relaxed/simple;
	bh=FVCHVJVf5FQEWsqMSaPblAfS1wd+bqV36nn9akIjrnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=CkRvJ4ocHihe4QlhWh2MGOWjWfj+i96os7kwzOgwPp/vrEXRYQQ5qFtj7YYWypULTDCOUnWGK4ke0Kr9jeH8LqibQ4NSV/YlncAYVFkK5BBfxA+jwiC8wugP4G3A016NN3iBdqJw8VPGianK0mfzIAntC+zrhzh+dyaWs3dEGew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-6b-68de34113306
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
Subject: [PATCH v17 25/47] dept: track PG_locked with dept
Date: Thu,  2 Oct 2025 17:12:25 +0900
Message-Id: <20251002081247.51255-26-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUhTexjH+53zO2dztTgto+MqbgwqMK3uxVtPl4jgQh3oSheyAoNyuFNb
	6pStLANBUctKYwarbrNaM0V0prl8mbrwTq6mZs7WVSlfrjdbLafr2rawFDva7Z+HD9/n8zzP
	P4+YlA1QcrFGe5rXaZXJClqCJZPLLNGymBH1NnMAQzCQj6G42kqD60ElgtFgPoJPX0wk5Nnn
	MQRmXolg3tGOYKJtGoFxbJyGG95sDP6yAgS3PCYRTI42UzAQ8iEYb72IYO56Ety12ATN6EJw
	b2yYhHc1Qv6ofQTBG0MdCe7x5fAi6Keh03iFhsm+YgKmami4bbqGIKekmoa+iVkCKmtjYbTM
	g6HbYCGEmzRcf7gaTDdyCKG8I8BY1UzATFmFCJ6WDGEw9bgpmDenQnvlWxE8mOyloHOkn4IJ
	zzUaRjsuUNCQ9Y8IAi/GCLAWeEjIbwpiqH0tKI6Xm+GPO0M0tDg6MeTPBRC4m4ppyDJ9oqC3
	qYqC0oE+Amw9T0kIXV0DrqJCao+Kq7DVE1ze8zmas96xIi5QmkNyeQaB2nx+ksu1neVKu300
	9zn4N805QmbMdVlYrqgnmrPfGhZxuY9fijhz7RnOVh75e2S8ZJeKT9ak87qtuxMkase/XirN
	rzl3t/8mmYVaDl9GYWKWiWEb/7IT3/lDdesi08wmdnBwhlzgcGY9ayv0UAtMMt1r2f6+qAVe
	yfzCGmZteIExs4F9/uS/RV/KbGfvF03R33b+wFbWtC7mYULuHute9GXMz2yeP1e4JREcUxh7
	+1L9/wMR7J/lg9iApGa0pALJNNr0FKUmOWaLOkOrObclMTWlFgnvVpY5e7QRTbsOOhEjRopl
	UteGYbWMUqbrM1KciBWTinBpQvmQWiZVKTPO87rU47ozybzeidaIsWK19KfQWZWMOak8zSfx
	fBqv+94lxGHyLHQqTmvAPnldhGEV8Luc4eun25m0bEtVHLlkaWxnfMeBA28frVCd2OkNpfuu
	7KgyPnPH1heTv3UUZv46LV/X1XDRHn/y/UfvG/mqY5fwxyPS7EOHonr1EfvrPIHzVFuKurk0
	M7Foymt5te9zXLazQVKwt1GlH6+zq6yJuQe9G28qsF6t/DGS1OmVXwFvt/N6agMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5/rXC4OS/KQRbKQIMqyUt4sogjqIBWCdLE+5KkObXhtK0vD
	UOfIrs7BZrlM0xriLM2VtWq1Vq2LWc2VXXSZYV7wsi6zMDXbjL68/N7neXh5PrwiXNpIzhQp
	0vYLyjQ+RUaJCfGmFeqFzLKP8sWjjhhozbMTMOwrJOBcXS0FhQ1nSXh1xYygY7gQwa9RIw4a
	6wQB4zonDb6RNhombE4EBpcOh9preRj8qP9DQf+D7wj0nV0UlPTlEeA1nURQ2m2koe/Rehjs
	uE3ChKcHg7c/BxCYuv5g0GU/imDckAzllRYKRptf4lCif4XgQqcHh956v3nN+RGBrTqfgi/a
	6zi4u6bB62EvBU/1JygYdJ3DYKiegop8GwllRh0CdVUdBYayBgKsn27R4Oofw6DdoMPA3LAR
	OkzdBDRpKzF/P3/qaigYS9SYf/RioL98G4MRUw0Nz6vaCTDlRoCx2U3C5+pSGsY6o2CiIh2c
	5h4aPEV6Aq4MviRX6xH3S3Oa4GosjRinaRmnuNrztYgb/a1DnO+SGuc0Wv/6YMCLcwWWg9yl
	pgGK+z38huJsPysI7lklyxU3L+SspR6aK7j7gY6P3S5euUdIUWQKykWrksRy2+c+MsOrOFTe
	egbPRXe2HEdBIpZZxn6ts2MBpph57Lt3I3iAQ5hw1nKqmwwwzjTNYltdCwI8nYlltWMWIsAE
	E8G2PPk2mZcwMezF4iHq3805rLnePqkH+XV3Z9NkXspEsxpvAaZF4go0pQaFKNIyU3lFSnSk
	KlmelaY4FLk7PbUB+b/JlDNWfBP53OsdiBEhWbDEFeGRS0k+U5WV6kCsCJeFSJKq2+VSyR4+
	K1tQpu9UHkgRVA4UJiJkoZK4rUKSlNnL7xeSBSFDUP53MVHQzFw064Z6iNxU7g3dHi4NG7Rr
	lc1RWJtsfvuMsCqNqzcy555hW008en+dCU5dvCMYO/Y4/aHDlD2wNNHZo/7OmjLVbVPndhvv
	m682bti8NtnHJyxZbl3zPpFPvL9jbkTcW4jv0Tv6rNk559dZ9j3edSS8NZKNnf3i8JSjtqKM
	aLcsQUao5HzUfFyp4v8CLS1bf0kDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Makes dept able to track PG_locked waits and events, which will be
useful in practice.  See the following link that shows dept worked with
PG_locked and detected real issues in practice:

   https://lore.kernel.org/lkml/1674268856-31807-1-git-send-email-byungchul.park@lge.com/

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/mm_types.h   |   2 +
 include/linux/page-flags.h | 125 +++++++++++++++++++++++++++++++++----
 include/linux/pagemap.h    |  37 ++++++++++-
 mm/filemap.c               |  26 ++++++++
 mm/mm_init.c               |   2 +
 5 files changed, 179 insertions(+), 13 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a643fae8a349..5ebc565309af 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -20,6 +20,7 @@
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
 #include <linux/types.h>
+#include <linux/dept.h>
 
 #include <asm/mmu.h>
 
@@ -223,6 +224,7 @@ struct page {
 	struct page *kmsan_shadow;
 	struct page *kmsan_origin;
 #endif
+	struct dept_ext_wgen pg_locked_wgen;
 } _struct_page_alignment;
 
 /*
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8d3fa3a91ce4..d3c4954c4218 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -198,6 +198,61 @@ enum pageflags {
 
 #ifndef __GENERATING_BOUNDS_H
 
+#ifdef CONFIG_DEPT
+#include <linux/kernel.h>
+#include <linux/dept.h>
+
+extern struct dept_map pg_locked_map;
+
+/*
+ * Place the following annotations in its suitable point in code:
+ *
+ *	Annotate dept_page_set_bit() around firstly set_bit*()
+ *	Annotate dept_page_clear_bit() around clear_bit*()
+ *	Annotate dept_page_wait_on_bit() around wait_on_bit*()
+ */
+
+static inline void dept_page_set_bit(struct page *p, int bit_nr)
+{
+	if (bit_nr == PG_locked)
+		dept_request_event(&pg_locked_map, &p->pg_locked_wgen);
+}
+
+static inline void dept_page_clear_bit(struct page *p, int bit_nr)
+{
+	if (bit_nr == PG_locked)
+		dept_event(&pg_locked_map, 1UL, _RET_IP_, __func__, &p->pg_locked_wgen);
+}
+
+static inline void dept_page_wait_on_bit(struct page *p, int bit_nr)
+{
+	if (bit_nr == PG_locked)
+		dept_wait(&pg_locked_map, 1UL, _RET_IP_, __func__, 0, -1L);
+}
+
+static inline void dept_folio_set_bit(struct folio *f, int bit_nr)
+{
+	dept_page_set_bit(&f->page, bit_nr);
+}
+
+static inline void dept_folio_clear_bit(struct folio *f, int bit_nr)
+{
+	dept_page_clear_bit(&f->page, bit_nr);
+}
+
+static inline void dept_folio_wait_on_bit(struct folio *f, int bit_nr)
+{
+	dept_page_wait_on_bit(&f->page, bit_nr);
+}
+#else
+#define dept_page_set_bit(p, bit_nr)		do { } while (0)
+#define dept_page_clear_bit(p, bit_nr)		do { } while (0)
+#define dept_page_wait_on_bit(p, bit_nr)	do { } while (0)
+#define dept_folio_set_bit(f, bit_nr)		do { } while (0)
+#define dept_folio_clear_bit(f, bit_nr)		do { } while (0)
+#define dept_folio_wait_on_bit(f, bit_nr)	do { } while (0)
+#endif
+
 #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
 DECLARE_STATIC_KEY_FALSE(hugetlb_optimize_vmemmap_key);
 
@@ -419,27 +474,51 @@ static __always_inline bool folio_test_##name(const struct folio *folio) \
 
 #define FOLIO_SET_FLAG(name, page)					\
 static __always_inline void folio_set_##name(struct folio *folio)	\
-{ set_bit(PG_##name, folio_flags(folio, page)); }
+{									\
+	set_bit(PG_##name, folio_flags(folio, page));			\
+	dept_folio_set_bit(folio, PG_##name);				\
+}
 
 #define FOLIO_CLEAR_FLAG(name, page)					\
 static __always_inline void folio_clear_##name(struct folio *folio)	\
-{ clear_bit(PG_##name, folio_flags(folio, page)); }
+{									\
+	clear_bit(PG_##name, folio_flags(folio, page));			\
+	dept_folio_clear_bit(folio, PG_##name);				\
+}
 
 #define __FOLIO_SET_FLAG(name, page)					\
 static __always_inline void __folio_set_##name(struct folio *folio)	\
-{ __set_bit(PG_##name, folio_flags(folio, page)); }
+{									\
+	__set_bit(PG_##name, folio_flags(folio, page));			\
+	dept_folio_set_bit(folio, PG_##name);				\
+}
 
 #define __FOLIO_CLEAR_FLAG(name, page)					\
 static __always_inline void __folio_clear_##name(struct folio *folio)	\
-{ __clear_bit(PG_##name, folio_flags(folio, page)); }
+{									\
+	__clear_bit(PG_##name, folio_flags(folio, page));		\
+	dept_folio_clear_bit(folio, PG_##name);				\
+}
 
 #define FOLIO_TEST_SET_FLAG(name, page)					\
 static __always_inline bool folio_test_set_##name(struct folio *folio)	\
-{ return test_and_set_bit(PG_##name, folio_flags(folio, page)); }
+{									\
+	bool __ret = test_and_set_bit(PG_##name, folio_flags(folio, page)); \
+									\
+	if (!__ret)							\
+		dept_folio_set_bit(folio, PG_##name);			\
+	return __ret;							\
+}
 
 #define FOLIO_TEST_CLEAR_FLAG(name, page)				\
 static __always_inline bool folio_test_clear_##name(struct folio *folio) \
-{ return test_and_clear_bit(PG_##name, folio_flags(folio, page)); }
+{									\
+	bool __ret = test_and_clear_bit(PG_##name, folio_flags(folio, page)); \
+									\
+	if (__ret)							\
+		dept_folio_clear_bit(folio, PG_##name);			\
+	return __ret;							\
+}
 
 #define FOLIO_FLAG(name, page)						\
 FOLIO_TEST_FLAG(name, page)						\
@@ -454,32 +533,54 @@ static __always_inline int Page##uname(const struct page *page)		\
 #define SETPAGEFLAG(uname, lname, policy)				\
 FOLIO_SET_FLAG(lname, FOLIO_##policy)					\
 static __always_inline void SetPage##uname(struct page *page)		\
-{ set_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	set_bit(PG_##lname, &policy(page, 1)->flags);			\
+	dept_page_set_bit(page, PG_##lname);				\
+}
 
 #define CLEARPAGEFLAG(uname, lname, policy)				\
 FOLIO_CLEAR_FLAG(lname, FOLIO_##policy)					\
 static __always_inline void ClearPage##uname(struct page *page)		\
-{ clear_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	clear_bit(PG_##lname, &policy(page, 1)->flags);			\
+	dept_page_clear_bit(page, PG_##lname);				\
+}
 
 #define __SETPAGEFLAG(uname, lname, policy)				\
 __FOLIO_SET_FLAG(lname, FOLIO_##policy)					\
 static __always_inline void __SetPage##uname(struct page *page)		\
-{ __set_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	__set_bit(PG_##lname, &policy(page, 1)->flags);			\
+	dept_page_set_bit(page, PG_##lname);				\
+}
 
 #define __CLEARPAGEFLAG(uname, lname, policy)				\
 __FOLIO_CLEAR_FLAG(lname, FOLIO_##policy)				\
 static __always_inline void __ClearPage##uname(struct page *page)	\
-{ __clear_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	__clear_bit(PG_##lname, &policy(page, 1)->flags);		\
+	dept_page_clear_bit(page, PG_##lname);				\
+}
 
 #define TESTSETFLAG(uname, lname, policy)				\
 FOLIO_TEST_SET_FLAG(lname, FOLIO_##policy)				\
 static __always_inline int TestSetPage##uname(struct page *page)	\
-{ return test_and_set_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	bool ret = test_and_set_bit(PG_##lname, &policy(page, 1)->flags);\
+	if (!ret)							\
+		dept_page_set_bit(page, PG_##lname);			\
+	return ret;							\
+}
 
 #define TESTCLEARFLAG(uname, lname, policy)				\
 FOLIO_TEST_CLEAR_FLAG(lname, FOLIO_##policy)				\
 static __always_inline int TestClearPage##uname(struct page *page)	\
-{ return test_and_clear_bit(PG_##lname, &policy(page, 1)->flags); }
+{									\
+	bool ret = test_and_clear_bit(PG_##lname, &policy(page, 1)->flags);\
+	if (ret)							\
+		dept_page_clear_bit(page, PG_##lname);			\
+	return ret;							\
+}
 
 #define PAGEFLAG(uname, lname, policy)					\
 	TESTPAGEFLAG(uname, lname, policy)				\
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 12a12dae727d..53b68b7a3f17 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1093,7 +1093,12 @@ void folio_unlock(struct folio *folio);
  */
 static inline bool folio_trylock(struct folio *folio)
 {
-	return likely(!test_and_set_bit_lock(PG_locked, folio_flags(folio, 0)));
+	bool ret = !test_and_set_bit_lock(PG_locked, folio_flags(folio, 0));
+
+	if (ret)
+		dept_page_set_bit(&folio->page, PG_locked);
+
+	return likely(ret);
 }
 
 /*
@@ -1129,6 +1134,16 @@ static inline bool trylock_page(struct page *page)
 static inline void folio_lock(struct folio *folio)
 {
 	might_sleep();
+
+	/*
+	 * dept_page_wait_on_bit() will be called if __folio_lock() goes
+	 * through a real wait path.  However, for better job to detect
+	 * *potential* deadlocks, let's assume that folio_lock() always
+	 * goes through wait so that dept can take into account all the
+	 * potential cases.
+	 */
+	dept_page_wait_on_bit(&folio->page, PG_locked);
+
 	if (!folio_trylock(folio))
 		__folio_lock(folio);
 }
@@ -1149,6 +1164,15 @@ static inline void lock_page(struct page *page)
 	struct folio *folio;
 	might_sleep();
 
+	/*
+	 * dept_page_wait_on_bit() will be called if __folio_lock() goes
+	 * through a real wait path.  However, for better job to detect
+	 * *potential* deadlocks, let's assume that lock_page() always
+	 * goes through wait so that dept can take into account all the
+	 * potential cases.
+	 */
+	dept_page_wait_on_bit(page, PG_locked);
+
 	folio = page_folio(page);
 	if (!folio_trylock(folio))
 		__folio_lock(folio);
@@ -1167,6 +1191,17 @@ static inline void lock_page(struct page *page)
 static inline int folio_lock_killable(struct folio *folio)
 {
 	might_sleep();
+
+	/*
+	 * dept_page_wait_on_bit() will be called if
+	 * __folio_lock_killable() goes through a real wait path.
+	 * However, for better job to detect *potential* deadlocks,
+	 * let's assume that folio_lock_killable() always goes through
+	 * wait so that dept can take into account all the potential
+	 * cases.
+	 */
+	dept_page_wait_on_bit(&folio->page, PG_locked);
+
 	if (!folio_trylock(folio))
 		return __folio_lock_killable(folio);
 	return 0;
diff --git a/mm/filemap.c b/mm/filemap.c
index 751838ef05e5..edb0710ddb3f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -48,6 +48,7 @@
 #include <linux/rcupdate_wait.h>
 #include <linux/sched/mm.h>
 #include <linux/sysctl.h>
+#include <linux/dept.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "internal.h"
@@ -1145,6 +1146,7 @@ static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync,
 		if (flags & WQ_FLAG_CUSTOM) {
 			if (test_and_set_bit(key->bit_nr, &key->folio->flags))
 				return -1;
+			dept_page_set_bit(&key->folio->page, key->bit_nr);
 			flags |= WQ_FLAG_DONE;
 		}
 	}
@@ -1228,6 +1230,7 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 	if (wait->flags & WQ_FLAG_EXCLUSIVE) {
 		if (test_and_set_bit(bit_nr, &folio->flags))
 			return false;
+		dept_page_set_bit(&folio->page, bit_nr);
 	} else if (test_bit(bit_nr, &folio->flags))
 		return false;
 
@@ -1235,6 +1238,9 @@ static inline bool folio_trylock_flag(struct folio *folio, int bit_nr,
 	return true;
 }
 
+struct dept_map __maybe_unused pg_locked_map = DEPT_MAP_INITIALIZER(pg_locked_map, NULL);
+EXPORT_SYMBOL(pg_locked_map);
+
 static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		int state, enum behavior behavior)
 {
@@ -1246,6 +1252,8 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	unsigned long pflags;
 	bool in_thrashing;
 
+	dept_page_wait_on_bit(&folio->page, bit_nr);
+
 	if (bit_nr == PG_locked &&
 	    !folio_test_uptodate(folio) && folio_test_workingset(folio)) {
 		delayacct_thrashing_start(&in_thrashing);
@@ -1339,6 +1347,23 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 		break;
 	}
 
+	/*
+	 * dept_page_set_bit() might have been called already in
+	 * folio_trylock_flag(), wake_page_function() or somewhere.
+	 * However, call it again to reset the wgen of dept to ensure
+	 * dept_page_wait_on_bit() is called prior to
+	 * dept_page_set_bit().
+	 *
+	 * Remind dept considers all the waits between
+	 * dept_page_set_bit() and dept_page_clear_bit() as potential
+	 * event disturbers. Ensure the correct sequence so that dept
+	 * can make correct decisions:
+	 *
+	 *	wait -> acquire(set bit) -> release(clear bit)
+	 */
+	if (wait->flags & WQ_FLAG_DONE)
+		dept_page_set_bit(&folio->page, bit_nr);
+
 	/*
 	 * If a signal happened, this 'finish_wait()' may remove the last
 	 * waiter from the wait-queues, but the folio waiters bit will remain
@@ -1496,6 +1521,7 @@ void folio_unlock(struct folio *folio)
 	BUILD_BUG_ON(PG_waiters != 7);
 	BUILD_BUG_ON(PG_locked > 7);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
+	dept_page_clear_bit(&folio->page, PG_locked);
 	if (folio_xor_flags_has_waiters(folio, 1 << PG_locked))
 		folio_wake_bit(folio, PG_locked);
 }
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5c21b3af216b..09e4ac6a73c7 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -32,6 +32,7 @@
 #include <linux/vmstat.h>
 #include <linux/kexec_handover.h>
 #include <linux/hugetlb.h>
+#include <linux/dept.h>
 #include "internal.h"
 #include "slab.h"
 #include "shuffle.h"
@@ -587,6 +588,7 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	atomic_set(&page->_mapcount, -1);
 	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
+	dept_ext_wgen_init(&page->pg_locked_wgen);
 
 	INIT_LIST_HEAD(&page->lru);
 #ifdef WANT_PAGE_VIRTUAL
-- 
2.17.1



Return-Path: <linux-fsdevel+bounces-63262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B306BB333E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A0D1890557
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E927431E885;
	Thu,  2 Oct 2025 08:14:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDE931327D;
	Thu,  2 Oct 2025 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392857; cv=none; b=qzu+gOa08qQH7WgJnD/V+3heLYfo0+VGGJAkvuBP4n/2PmxIcFiozOZ7FxagNKOuBpA+EJFgj+7/AQXqaJDjC9RwOEn0806N3i+Ec47PMWAWR+r8Tq5WdQziWPNNbx/gvvw3/Skygf7xCzD4ysTPXEjSGa712mOFvO5Nw6AoRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392857; c=relaxed/simple;
	bh=0EG+nyhegdHqkltgIfnxVMJLuuhwrD8fF2eYCBLzDfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bZtjZYQwgQ//ip0tGTQWV4Fy6goAZTZrPikmQ/HCQzLTpnvdV4uWtWT2n/6bjJfKd7f1ihvNOtMwO/UrOJDZzPXSscJk8vLlVHL2ZhXelJ8o2COWGqpilQOoQgx8CKeDYSHvkOLLNL+YFI7S+vPqSE0ZtrgX654rigW/dtS+HEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-d2-68de34190225
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
Subject: [PATCH v17 44/47] dept: introduce APIs to set page usage and use subclasses_evt for the usage
Date: Thu,  2 Oct 2025 17:12:44 +0900
Message-Id: <20251002081247.51255-45-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUxTZxSHfe9973tbRvWmknBlbmINmpiBYmA5yYxu2R/emJiYGHWZiXAD
	V9vIhykUxThTR2GdsK1DKaF+lRIKQpVa/EYmgspYYywo0LlWrGIZA0Rdi7KBrOD878nvPPnl
	nOTIaGU/EyfT5ORL2hwxS0WicNRYdHXiopRH6tUjlnjoO9yGIRwyYjjR5CBgdFUx4DnXiGAg
	bEQQmvyDBXN3OQ1/O98SGOl4haAiMEigcvgwhnF7GQJL8DgLw7c3wNhACwMz/iEK+idGEdgH
	31Iwbd4Dp23NBP69e4+GygoPguqAn4Y/nd8huHDnEYJnpos03B+cDw/C4wS6KkoJjHWfoOC5
	k4D121YGimqaCJhPujBcfXyNBZ+5nIJG1yYYsAcxuE02KrJLRDgfC5P2Bhbs+gR4Um9hYSqQ
	DDPWXPD/VIFhJFhOYKCzhAHX77cjZz0IUOAoC9JgvBbG4Hrax0DVKR+B661dGIzTIQQ9jR4M
	TUNeCtx3fsXQZTmDoba/m4LAYy/zeabwuvhHLDQ0X6KE4p5pIjhOOZAQqi2ihWJThDpGx2nB
	0LxPqHWPEuGfcC8RWiesWPjNxgtXLX5WMPzykBWsLp1guDXGbE76OmptppSlKZC0q9alR6nL
	Wjxkb3vKfmfvRaxHoZVHkFzGcyl8na2Uec9VN4fZWSbcCt7rnaRnOYaL55t/CM45NOdezPd1
	fzLLC7ldfJXPO5djLoHvOzuEZ1nBfcp7jxVR7zqX8I3OtrkeeSS/H3DPOUoulS8eN/zv1Mn5
	kvOH3vEi/ma9F5uQwormNSClJqcgW9RkpSSpC3M0+5MycrNdKPJu9m+mdlxBrzxb2hEnQ6po
	hSfBr1YyYkFeYXY74mW0KkaRXu9TKxWZYuEBSZubptVlSXnt6EMZVsUq1kzsy1Ryu8V8aY8k
	7ZW076eUTB6nR+s73X9F17Y5d9qm9DPpCanhtK2xq0pMP5sNlzceIbnzlusdoXir4QP3zOIw
	69vd81IX97zmSyymLVumS9qQsbRlR/L8koyeo0sSK7+QE3b7gtGHn5l1Xx28UHpuiPJ3bsMH
	vk/sEjtuTNacyd+eGv1m6aFNDaWU49aLj9S9H8fUvVbhPLWYvJLW5on/AYNKzqdqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxTG/d/7v/e2zYo3lcQbNdE0QRYiviRgjrg4E028c5vZt2XzjWbc
	0UoBbRGtcQlYGsmGExpaQguT1VhJKdBRJEOswSIERAJ3TGCzBeuwSICRzFblfS3Lvpz8zvM8
	eXI+HAmpaKO2SDR5BYIuT6VV0jIsO3HQmMqljav3ekfTYKS4E0M0UoqhptlNQ2lLNQVDTQ0I
	JqKlCN4t2Ukwta9hWDH3MBBZeM7Amq8HgVU0k+BuLSbgjWeVhpmufxBYQpM0VE0XY5h3liGw
	he0MTHcfg7mJDgrWglMEjL6dReCcXCVgsvM6ghVrDtxyeGlYGhgkocoyhODnUJCE156Y2doz
	jsBXf42GV+X3SBieTIDfo/M09Fl+oGFOrCHgbw8Nddd8FNTazQiMt5tpsNa2YGh/cZ8BcWaZ
	gIDVTEBDy+cw4Qxj6C93ELH7YqlfNoO9ykjExmsCLI0dBCw4XQw8vR3A4CxKAvvAMAUv620M
	LIf2wVpdPvQ0TDEQvGnB0DQ3SB22IP6d6UfMu7xtBG/6bYXm3T+5Eb+0aEZ85I6R5E3lsbVr
	dp7kS7yX+Dv9szS/GH1G8763dZh/4uD4ioFUvt0WZPiSh38yX2R8LfsoS9BqCgXdnkOZMnVZ
	xxB93p922fPsHi5CkZTvkVTCsWlc9aNpJs40m8yNjS2QcU5kd3DeG2EqziTbv40bEXfFeRP7
	LVcdGFvXMZvEjTRO4TjL2f3cWKWR+K9zO9fg6Vzvkcb04VD/ekbBpnOm+RKiHMnq0AYXStTk
	FeaqNNr03foctSFPc3n3N/m5LSj2Tc7vlit+RZHhY37ESpDyA7mYFFQrKFWh3pDrR5yEVCbK
	M+sDaoU8S2W4Iujyz+ouagW9H22VYOVm+fEvhUwFm60qEHIE4byg+98lJNItReh0YNwmlGUX
	FxgOn+oSzxi7X1VW5L58f/eTjHO+T/U7k69Wdz+QiSc/FKPS0coNvY4LoVWNqNv58MD2z7Jr
	HxCz+e77NfZ0hxguPZExmLCRajvVvD8F+53s6GIvuB5fD9v8hj1m5tZXUtcbYuOMNfEP6xHt
	yRd/Hf3Yl/W4qG9IifVq1b4UUqdX/QsQvzpjSQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

False positive reports have been observed since dept works with the
assumption that all the pages have the same dept class, but the class
should be split since the problematic call paths are different depending
on what the page is used for.

At least, ones in block device's address_space and ones in regular
file's address_space have exclusively different usages.

Thus, define usage candidates like:

   DEPT_PAGE_REGFILE_CACHE /* page in regular file's address_space */
   DEPT_PAGE_BDEV_CACHE    /* page in block device's address_space */
   DEPT_PAGE_DEFAULT       /* the others */

Introduce APIs to set each page's usage properly and make sure not to
interact between at least between DEPT_PAGE_REGFILE_CACHE and
DEPT_PAGE_BDEV_CACHE.  However, besides the exclusive usages, allow any
other combinations to interact to the other for example:

   PG_locked for DEPT_PAGE_DEFAULT page can wait for PG_locked for
   DEPT_PAGE_REGFILE_CACHE page and vice versa.

   PG_locked for DEPT_PAGE_DEFAULT page can wait for PG_locked for
   DEPT_PAGE_BDEV_CACHE page and vice versa.

   PG_locked for DEPT_PAGE_DEFAULT page can wait for PG_locked for
   DEPT_PAGE_DEFAULT page.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h       | 31 +++++++++++++++-
 include/linux/mm_types.h   |  1 +
 include/linux/page-flags.h | 76 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 0ac13129f308..fbbc41048fac 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -21,8 +21,8 @@ struct task_struct;
 #define DEPT_MAX_WAIT_HIST		64
 #define DEPT_MAX_ECXT_HELD		48
 
-#define DEPT_MAX_SUBCLASSES		16
-#define DEPT_MAX_SUBCLASSES_EVT		2
+#define DEPT_MAX_SUBCLASSES		24
+#define DEPT_MAX_SUBCLASSES_EVT		3
 #define DEPT_MAX_SUBCLASSES_USR		(DEPT_MAX_SUBCLASSES / DEPT_MAX_SUBCLASSES_EVT)
 #define DEPT_MAX_SUBCLASSES_CACHE	2
 
@@ -390,6 +390,32 @@ struct dept_ext_wgen {
 	unsigned int wgen;
 };
 
+enum {
+	DEPT_PAGE_DEFAULT = 0,
+	DEPT_PAGE_REGFILE_CACHE,	/* regular file page cache */
+	DEPT_PAGE_BDEV_CACHE,		/* block device cache */
+	DEPT_PAGE_USAGE_NR,		/* nr of usages options */
+};
+
+#define DEPT_PAGE_USAGE_SHIFT 16
+#define DEPT_PAGE_USAGE_MASK ((1U << DEPT_PAGE_USAGE_SHIFT) - 1)
+#define DEPT_PAGE_USAGE_PENDING_MASK (DEPT_PAGE_USAGE_MASK << DEPT_PAGE_USAGE_SHIFT)
+
+/*
+ * Identify each page's usage type
+ */
+struct dept_page_usage {
+	/*
+	 * low 16 bits  : the current usage type
+	 * high 16 bits : usage type requested to be set
+	 *
+	 * Do not apply the type requested immediately but defer until
+	 * after clearing PG_locked bit of the folio or page e.g. by
+	 * folio_unlock().
+	 */
+	atomic_t type; /* Update and read atomically */
+};
+
 struct dept_event_site {
 	/*
 	 * event site name
@@ -562,6 +588,7 @@ extern void dept_hardirqs_off(void);
 struct dept_key { };
 struct dept_map { };
 struct dept_ext_wgen { };
+struct dept_page_usage { };
 struct dept_event_site { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5ebc565309af..8ccbb030500c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -224,6 +224,7 @@ struct page {
 	struct page *kmsan_shadow;
 	struct page *kmsan_origin;
 #endif
+	struct dept_page_usage usage;
 	struct dept_ext_wgen pg_locked_wgen;
 } _struct_page_alignment;
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d3c4954c4218..3fd3660ddc6f 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -204,6 +204,68 @@ enum pageflags {
 
 extern struct dept_map pg_locked_map;
 
+static inline int dept_set_page_usage(struct page *p,
+		unsigned int new_type)
+{
+	unsigned int type = atomic_read(&p->usage.type);
+
+	if (WARN_ON_ONCE(new_type >= DEPT_PAGE_USAGE_NR))
+		return -1;
+
+	new_type <<= DEPT_PAGE_USAGE_SHIFT;
+retry:
+	new_type &= ~DEPT_PAGE_USAGE_MASK;
+	new_type |= type & DEPT_PAGE_USAGE_MASK;
+
+	if (!atomic_try_cmpxchg(&p->usage.type, &type, new_type))
+		goto retry;
+
+	return 0;
+}
+
+static inline int dept_reset_page_usage(struct page *p)
+{
+	return dept_set_page_usage(p, DEPT_PAGE_DEFAULT);
+}
+
+static inline void dept_update_page_usage(struct page *p)
+{
+	unsigned int type = atomic_read(&p->usage.type);
+	unsigned int new_type;
+
+retry:
+	new_type = type & DEPT_PAGE_USAGE_PENDING_MASK;
+	new_type >>= DEPT_PAGE_USAGE_SHIFT;
+	new_type |= type & DEPT_PAGE_USAGE_PENDING_MASK;
+
+	/*
+	 * Already updated by others.
+	 */
+	if (type == new_type)
+		return;
+
+	if (!atomic_try_cmpxchg(&p->usage.type, &type, new_type))
+		goto retry;
+}
+
+static inline unsigned long dept_event_flags(struct page *p, bool wait)
+{
+	unsigned int type;
+
+	type = atomic_read(&p->usage.type) & DEPT_PAGE_USAGE_MASK;
+
+	if (WARN_ON_ONCE(type >= DEPT_PAGE_USAGE_NR))
+		return 0;
+
+	/*
+	 * event
+	 */
+	if (!wait)
+		return 1UL << type;
+
+	return (1UL << DEPT_PAGE_DEFAULT) | (1UL << type);
+}
+
 /*
  * Place the following annotations in its suitable point in code:
  *
@@ -214,20 +276,28 @@ extern struct dept_map pg_locked_map;
 
 static inline void dept_page_set_bit(struct page *p, int bit_nr)
 {
+	dept_update_page_usage(p);
 	if (bit_nr == PG_locked)
 		dept_request_event(&pg_locked_map, &p->pg_locked_wgen);
 }
 
 static inline void dept_page_clear_bit(struct page *p, int bit_nr)
 {
+	unsigned long evt_f;
+
+	evt_f = dept_event_flags(p, false);
 	if (bit_nr == PG_locked)
-		dept_event(&pg_locked_map, 1UL, _RET_IP_, __func__, &p->pg_locked_wgen);
+		dept_event(&pg_locked_map, evt_f, _RET_IP_, __func__, &p->pg_locked_wgen);
 }
 
 static inline void dept_page_wait_on_bit(struct page *p, int bit_nr)
 {
+	unsigned long evt_f;
+
+	dept_update_page_usage(p);
+	evt_f = dept_event_flags(p, true);
 	if (bit_nr == PG_locked)
-		dept_wait(&pg_locked_map, 1UL, _RET_IP_, __func__, 0, -1L);
+		dept_wait(&pg_locked_map, evt_f, _RET_IP_, __func__, 0, -1L);
 }
 
 static inline void dept_folio_set_bit(struct folio *f, int bit_nr)
@@ -245,6 +315,8 @@ static inline void dept_folio_wait_on_bit(struct folio *f, int bit_nr)
 	dept_page_wait_on_bit(&f->page, bit_nr);
 }
 #else
+#define dept_set_page_usage(p, t)		do { } while (0)
+#define dept_reset_page_usage(p)		do { } while (0)
 #define dept_page_set_bit(p, bit_nr)		do { } while (0)
 #define dept_page_clear_bit(p, bit_nr)		do { } while (0)
 #define dept_page_wait_on_bit(p, bit_nr)	do { } while (0)
-- 
2.17.1



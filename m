Return-Path: <linux-fsdevel+bounces-70797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B97CA7495
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 11:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EBFD1325A8E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324B9281504;
	Fri,  5 Dec 2025 07:21:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28D42FC00B;
	Fri,  5 Dec 2025 07:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919299; cv=none; b=qvNWDnRfkbdkQU8u4YEbuUfLTt/yAAjf5PpLh2YE4qDez2sCSdsf7R7ZewxcwRtUHe3fLNKIqxuzjgcHa+Y+3qsQGyRxCXA0rRwCZgK2aWBYWD908nWsHm+c45QnWnkXpmo1r5xtsOEmR/20JyypmONhykQ2VVlpIIP0qxnBNh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919299; c=relaxed/simple;
	bh=VvHpXatW22wnPVqhff/utuqTfKeAlK4aRZ43Lr2HYS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=o5Gh1Cke43+5JDciUZJOUgXF1H/l8VY/sah+ClKlxC7DjIyvfTtxgUjX1C9oBM9Axk51L6PqrauNd2Nb4Hun5KTiQusQvdTQEl0m12qVldfA/1eFrX4vmgi0jNKntLnlzy9sFc4VK+0uh3gp92q85bU1lKHag3RygnpcgItEm+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-a0-693287756ec0
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
Subject: [PATCH v18 39/42] dept: introduce APIs to set page usage and use subclasses_evt for the usage
Date: Fri,  5 Dec 2025 16:18:52 +0900
Message-Id: <20251205071855.72743-40-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxTG/d/7v7eXSs1NJfFOnC41xvmOTM0xcwsJMd5EFol+Yx+0ynV0
	lhfLi2CypE6xyBRLY2FShm3BxkDFQkVF6OgabQRpLMigAcrLRIQgYhgvUmFdi/HLye885zzP
	+XIYUtpNrWUUaVmCKk2ulNFiLJ6MNO3I0cQqYoIDK6F/cISC7gtODOX3rDQsGR6K4FnPrxi8
	tTUI8huDGJZ0bhHMLPSJIOhwI/B5W0j41/YfDaXjFzBMWa4iKBs1iGD86SEI+t8QMOLUIFgq
	OQO3zHYaJkre0/DR84KEUr0XgWnYT8L0+BCC++4BBK+1DSR0zU7RMNlRTsA7Gw0d7RMI/jDo
	EDQOPRZBf4mOgEHLKIbnWjMROkpDSd0aMJReJEJljAD93SYC2iv7MVjUmyBoTAf/dT2G2skX
	FLQOdFMwMaqjYaZrmID6V6HW0bsNTJerMDQ7WjEULM0gcD/6h4CXj8tpuGproEBtmKfA63xO
	QWeNF8PwkI+CuaJo8BZfo8CnfY3ikvn5/CLMV9sfELy1wor4jwEd4vO1IQrM/k3zjjkj5tvM
	HF91JUDwxZ4dfGOZX8Qb67N5+52tfGXzOMGbpmcpvnfiu8TtSeIDyYJSkSOodn1/QpyS3xcg
	M67vy+24ZKPUqHR7IWIYjt3D1eviClHEMlZbK1CYaXYz5/MtkGGOYr/i7NdGqUIkZkj25QZO
	s1BEhr2r2dOc1RUV3sHsJq7iQ4MozBJ2H3fbXEt9ytzA1dicyzkRIV3fE1hmKbuXu1U4v5zJ
	sZUR3H1PE/nJ8AX31x0f1iKJEa2oRlJFWk6qXKHcszMlL02Ru/NUemo9Cn2b5ZfFHx+hae8x
	F2IZJIuUOM/tVkgpeU5mXqoLcQwpi5K8VcYopJJked55QZV+XJWtFDJdKJrBsjWS2LlzyVL2
	J3mWcEYQMgTV5ynBRKxVoxWrvl5/ae/v8fu3nGw3XvGwP5RZNn/TWxCv+TbhYF9urOl0pyVp
	0B/n3Wi/cXhg+GDNuuafE98VjbWebbF06bMSKvMK/oxLjNxf7O5vWZQeabMvenIL5KsSmtQn
	OuPb6k7Zmlo1sW/Nx9e9GYGuLSeLHa6pwM0v6446LrtXPnn2m8opw5kp8t1bSVWm/H/KgEc/
	aQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTcRTG+9+3XVeLy7K8FfSyiOhNLTIOFVF96Rb0AgVRETnqpsM5bVNL
	I2qu4dK0udiGrtQsR+nK5bKyGommZBa6LB3psmitlpa9OG0ztVn05fA753nOw/lwaFx8l5xF
	yxRpvFIhlUsoISHcvlazPD1npSy2qWUB6LSnoKfXS0Knup6AwKCOgIvVNgpGLXcFoKspIuFJ
	VzYB7TerEPQGdAiGRyw4aOvGCRg1NAtgMNgtAKMawbizGYHJZcDB3f4IB9ttNQY/7WMU9DX+
	QGB856XA7FcTMGA9h6DYZxGAv2kzfOl9QMK45yMGXUP9CKzeMQy89TkIRk1JUFruCK+bvlEw
	8rwNB7OxHcHldx4cfvjfIrjd/AaB81o2BR/0tTh0eKfCy8AABS3GPAq+uC5i8NVOQVm2kwTX
	sz4ElywGBL7XTgw0V6opMF2qIaDu7X0BuPp+Y9BjMmBQVbMNeq0+Alr15Vj43LDrVhRYzBos
	XD5hYLzxAIOgtVKwoQJxw9oCgqt03ME47YtRirOV2BA3EjIgbrBCg3Nafbht7B/AuTOOY1xF
	az/FhQKvKM45VEZwT8tZ7urZEMYVPl/O1RV7BDs37hOuO8zLZRm8MmZ9vDBR2x3CU8+vPu46
	YydPI/OyXBRBs8wqttJWgiaYYhaxbncQn+BIZh7ryPeRuUhI40zHXDYnWBAWaHoac4S1NURO
	eAhmIVvyq1YwwSJmNVtRfpP8lzmXrbLX/82JCM+NXaG/LGbi2NLcYVKPhGVoUiWKlCkykqUy
	eVy0KikxUyE7Hn0oJbkGhd/JevJ34T002LG5ATE0kkwR1R9bIROT0gxVZnIDYmlcEinql8fK
	xKLD0swsXplyUJku51UNaDZNSKJEW/fw8WImQZrGJ/F8Kq/8r2J0xKzTSId2z0iIsU/Z1bfl
	gjuqMPHCx7jieU3eTXZ+vXZGfmiLqzW7TV9qWKMXzV+cvzfa86zHn7d7//TFKuECn07zvrjt
	c9ZjddHO+7U+/9KD14d+TU6ammXurD5wMvbct8I5EQ9L3Am+oz3x4470bt4Wow94gidOHMop
	+i6dWTBfEb9jjYRQJUpXLMGVKukfSrjLMUoDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

False positive reports have been observed since dept assumes that all
the pages have the same dept class, but the class should be split since
the call paths are different depending on what the page is used for.

At least, ones for block device and ones for regular file have
exclusively different usages.

Define usage candidates like:

   DEPT_PAGE_REGFILE_CACHE /* page in regular file's address_space */
   DEPT_PAGE_BDEV_CACHE    /* page in block device's address_space */
   DEPT_PAGE_DEFAULT       /* the others */

Introduce APIs to set each page usage properly and make sure not to
interact between DEPT_PAGE_REGFILE_CACHE and DEPT_PAGE_BDEV_CACHE.
Besides that, it allows the other cases:

   interaction between DEPT_PAGE_DEFAULT and DEPT_PAGE_REGFILE_CACHE,
   interaction between DEPT_PAGE_DEFAULT and DEPT_PAGE_BDEV_CACHE,
   interaction between DEPT_PAGE_DEFAULT and DEPT_PAGE_DEFAULT.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h       | 34 ++++++++++++++-
 include/linux/mm_types.h   |  1 +
 include/linux/page-flags.h | 89 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 120 insertions(+), 4 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 7b822caee874..b3bb1a1a7eb5 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -19,8 +19,8 @@ struct task_struct;
 #define DEPT_MAX_WAIT_HIST		64
 #define DEPT_MAX_ECXT_HELD		48
 
-#define DEPT_MAX_SUBCLASSES		16
-#define DEPT_MAX_SUBCLASSES_EVT		2
+#define DEPT_MAX_SUBCLASSES		24
+#define DEPT_MAX_SUBCLASSES_EVT		3
 #define DEPT_MAX_SUBCLASSES_USR		(DEPT_MAX_SUBCLASSES / DEPT_MAX_SUBCLASSES_EVT)
 #define DEPT_MAX_SUBCLASSES_CACHE	2
 
@@ -142,6 +142,35 @@ struct dept_ext_wgen {
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
+	 * Do not apply usage type on request immediately but postpone
+	 * it until the next use of PG flags.  For example, if the page
+	 * is already within a PG_locked critical section, regard it as
+	 * DEPT_PAGE_DEFAULT temporarily at least until the section ends
+	 * e.g. folio_unlock() since it's still unclear which usage type
+	 * the page acts within the section.
+	 */
+	atomic_t type; /* Update and read atomically */
+};
+
 struct dept_event_site {
 	/*
 	 * event site name
@@ -314,6 +343,7 @@ extern void dept_hardirqs_off(void);
 struct dept_key { };
 struct dept_map { };
 struct dept_ext_wgen { };
+struct dept_page_usage { };
 struct dept_event_site { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 42b6959882b3..85d06073d37b 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -220,6 +220,7 @@ struct page {
 	struct page *kmsan_shadow;
 	struct page *kmsan_origin;
 #endif
+	struct dept_page_usage usage;
 	struct dept_ext_wgen pg_locked_wgen;
 } _struct_page_alignment;
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 8ab39823ea31..0b0655354b08 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -204,6 +204,80 @@ enum pageflags {
 
 extern struct dept_map pg_locked_map;
 
+static inline void dept_set_page_usage(struct page *p,
+		unsigned int new_type)
+{
+	/*
+	 * Consider the page as DEPT_PAGE_DEFAULT until the next use of
+	 * PG flags e.g. folio_lock().
+	 */
+	unsigned int type = DEPT_PAGE_DEFAULT;
+
+	if (WARN_ON_ONCE(new_type >= DEPT_PAGE_USAGE_NR))
+		return;
+
+	new_type <<= DEPT_PAGE_USAGE_SHIFT;
+	new_type |= type & DEPT_PAGE_USAGE_MASK;
+	atomic_set(&p->usage.type, new_type);
+}
+
+static inline void dept_set_folio_usage(struct folio *f,
+		unsigned int new_type)
+{
+	dept_set_page_usage(&f->page, new_type);
+}
+
+static inline void dept_reset_page_usage(struct page *p)
+{
+	dept_set_page_usage(p, DEPT_PAGE_DEFAULT);
+}
+
+static inline void dept_reset_folio_usage(struct folio *f)
+{
+	dept_reset_page_usage(&f->page);
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
+	 * wait
+	 */
+	if (wait)
+		return (1UL << DEPT_PAGE_DEFAULT) | (1UL << type);
+
+	/*
+	 * event
+	 */
+	return 1UL << type;
+}
+
 /*
  * Place the following annotations in its suitable point in code:
  *
@@ -214,20 +288,29 @@ extern struct dept_map pg_locked_map;
 
 static inline void dept_page_set_bit(struct page *p, int bit_nr)
 {
+	dept_update_page_usage(p);
+
 	if (bit_nr == PG_locked)
 		dept_request_event(&pg_locked_map, &p->pg_locked_wgen);
 }
 
 static inline void dept_page_clear_bit(struct page *p, int bit_nr)
 {
+	unsigned long evt_f = dept_event_flags(p, false);
+
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
+
 	if (bit_nr == PG_locked)
-		dept_wait(&pg_locked_map, 1UL, _RET_IP_, __func__, 0, -1L);
+		dept_wait(&pg_locked_map, evt_f, _RET_IP_, __func__, 0, -1L);
 }
 
 static inline void dept_folio_set_bit(struct folio *f, int bit_nr)
@@ -245,6 +328,8 @@ static inline void dept_folio_wait_on_bit(struct folio *f, int bit_nr)
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



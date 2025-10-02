Return-Path: <linux-fsdevel+bounces-63250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 530ACBB3230
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20501C097C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C36314B93;
	Thu,  2 Oct 2025 08:14:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB9030F80A;
	Thu,  2 Oct 2025 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392847; cv=none; b=VzibT19ksFu/8ExKjK9NgwujWk+u40f5PSI79VON7/yKZen4oSoSDaO2QzadL9DL32JV1zo8VbIHcv21clj3IE5cD5fHgBtGD5dPMnrtaY9KnVQcRsDOVT7sQN2jVZ/ZBNQjgsEOSDVo77aZDJ09dOXQF6qvjDgWDCizfW1+iis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392847; c=relaxed/simple;
	bh=314TpUAkZxMvbV2pk3wlciVKMbaC2tgJL1bvCZ48Y0A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=HQ1a7cIw0mInAT1j3QPNuva6Bv2UkrIX/OkfVSwmVd5a4EFPezlC77gBSrzxks72+WHcTs7Mk83YW83ax2MptWK6jhTrtDhmfFxXiJL8nDU5i1ZAvd5zsorZIz1x2O4aiIWlq/KmxQvF1jozQQfL9rD+1k7b0SKh/HE00qvxW88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-fc-68de34136438
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
Subject: [PATCH v17 37/47] completion, dept: introduce init_completion_dmap() API
Date: Thu,  2 Oct 2025 17:12:37 +0900
Message-Id: <20251002081247.51255-38-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSaUiTcRgA8P7vtSkN35bg24UyKVPKTFc8QUZE1EsfwojEstCRb201p21m
	2kEWTs3SVlJaRk6bZmp5rJxhM68s8c4DrZkapoVHaWuhebQpfnn48ZxfHj4u1JCr+TJFBKdU
	SOQiyp6wH1ueudlR/EXq9drgAAklD0gwT33mwbyxDsHvojkKRmomEYz1lZOQMziHwWBlPIKM
	LD0F/5pacMgc6MVhrO0RBtrrRhL6coYIaHxiImBeGwYvxlpIGBm6S4Ehpp8H5o4BDN4Y6wlI
	mDUjqCv7isGtolcktFY2kFA43I2BvqkRh+fjWRQMdcZh8OqtGsGkzkLA+6RKDLLN4zjEfy+n
	IE5XjEFHTzmCioR+DGoLDRjU/BnFIOWjloLp3jIS1LemeHBvJoGCm+r71pO1Fuvm2S4E4xoz
	CenvvvB2e7F/1ckEm6cvxVj1x1mKLXhcgFi1xhqyG0YpdvpPJ8UaLVqCff2wl8fGVnzisdqS
	86w+14P9NOLLluTdoFhT1xuKHW9u5vmtO2a/M4STyyI55ZZdwfbS7MJ0KtzoHlX7W4Ni0LRz
	IrLjM7SY6cifQ0surtdSNlO0G9PdPYXb7Ei7MPqkIdJmnG5Yy3S1bbJ5JX2IKUytXpgl6PVM
	1o/8hR4BvZ35oEvGF3c6M/lFlQu2s+bbBxoIm4X0Nkb9MxZb7MmwYwbSNix6FVOV201okECL
	luUhoUwRGSqRycWe0miFLMrzZFhoCbL+Sc6VmcAyNNl6uBrRfCRaLmhd3ysVkpJIVXRoNWL4
	uMhREJxrkgoFIZLoi5wyLEh5Xs6pqtEaPiFyEnhbLoQI6dOSCO4sx4VzyqUqxrdbHYPOuTpc
	i9Md9T18MPjRmQlFl7gm0dxU8G3X06qKq4+DRsgDe/x/peyfVzgbXZxixa3up0JWMYaq2945
	oZ4OcvWOsjtkYITfs+MBQXtLHyaXvtzYqdv30zI8E25w23QkqD3VObBWcTlghWEitSn2bVqP
	wud6hFMMb9D1po/O19/08sQlEaGSSrZ64EqV5D/DMGjrIwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0xScRQA8P73Xu5Firojl7ds2Sh7LTOX1lnvrQ/+q9V6fGhruWR5C+ar
	oEzbWhqyXE+ioUu0yJIcaCLaw4pyWPYwZmRpD8hsplk+WmmlIgS1vpz9zmNn58MRkpIbgilC
	Rdp+XpkmS5HSIkq0cZk6amLse/nCi1fnQ0tOHQWDA3kUFFWW05BnOy+A59csCNoG8xD8GjGQ
	oKn1UzCqa2BgYOgdA357A4J8l46E8pocAn5YfTR8rf+OQN/eQUNBdw4F/aaTCAo7DQx0P4yH
	3rY7AvB7ugho/dmDwNThI6Cj7hiC0fxkuFhSTcOIs4mEAv1zBJfaPSR8tgaaNQ3vEdjLjtLw
	SXudhOaO8fBysJ+GJ/oTNPS6igjos9JgPGoXQLFBh0B9uZKG/GIbBbUfbjPg+uolwJ2vI8Bi
	2wBtpk4KGrUlROC+wFRVGBgK1EQgfCZAX3GHgCGTmYFnl90UmLIjweBsFsDHskIGvO0x4Dem
	Q4OliwHPGT0F13qbBKv1CP/SnKawufoGgTUvRmlcfqEc4ZFhHcIDpWoSa7SBtL6nn8S51Qdx
	aWMPjYcHX9HY/tNI4aclHD7rjMK1hR4G5957y2xaul20PIlPUWTwyuiViSJ5aaWB3mufm/ng
	hxZlo+GI4yhEyLGxXNUTIx00zc7mXr8eIoMOZadz1ac6BUGTbONUrsU1P+iJ7GaussCBgqbY
	SK6k2/J3Rswu5h5fOU3+2xnBWax1fx0SqDe3N1JBS9g4TtOfS2iRyIjGmFGoIi0jVaZIiVug
	SpZnpSkyF+xKT7WhwDeZDnvP3kIDzfEOxAqRdJzYFemRSwSyDFVWqgNxQlIaKk4sc8sl4iRZ
	1iFemb5TeSCFVzlQuJCShonXbeMTJewe2X4+mef38sr/XUIYMiUbjd0Q/U0YPkP1Mjz6Q0Wr
	8UhTws0R36Sbrc43C/eZ+yxhpebUNerM1b74SXBs+qyKCbcdw4v84qbJ0mLPzKgdR7y+rbE5
	9c+u4BY2Zp3jyyP3rS3rE/LcK+Zg/9i7v21FkyOSlmyMc+4+k31y5dqumiT025y7tq9t1btz
	xdbl3vvT1kgplVwWM49UqmR/AOk0IJhJAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Currently, dept uses dept's map embedded in task_struct to track
dependencies related to wait_for_completion() and its family.  So it
doesn't need an explicit map basically.

However, for those who want to set the maps with customized class or
key, introduce a new API to use external maps.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 40 +++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index 4d8fb1d95c0a..e50f7d9b4b97 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -27,17 +27,15 @@
 struct completion {
 	unsigned int done;
 	struct swait_queue_head wait;
+	struct dept_map *dmap;
 };
 
-#define init_completion(x)				\
-do {							\
-	__init_completion(x);				\
-} while (0)
+#define init_completion(x) init_completion_dmap(x, NULL)
 
 /*
- * XXX: No use cases for now. Fill the body when needed.
+ * XXX: This usage using lockdep's map should be deprecated.
  */
-#define init_completion_map(x, m) init_completion(x)
+#define init_completion_map(x, m) init_completion_dmap(x, NULL)
 
 static inline void complete_acquire(struct completion *x, long timeout)
 {
@@ -48,8 +46,11 @@ static inline void complete_release(struct completion *x)
 }
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), .dmap = NULL, }
 
+/*
+ * XXX: This usage using lockdep's map should be deprecated.
+ */
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
 
@@ -90,15 +91,18 @@ static inline void complete_release(struct completion *x)
 #endif
 
 /**
- * __init_completion - Initialize a dynamically allocated completion
+ * init_completion_dmap - Initialize a dynamically allocated completion
  * @x:  pointer to completion structure that is to be initialized
+ * @dmap:  pointer to external dept's map to be used as a separated map
  *
  * This inline function will initialize a dynamically created completion
  * structure.
  */
-static inline void __init_completion(struct completion *x)
+static inline void init_completion_dmap(struct completion *x,
+		struct dept_map *dmap)
 {
 	x->done = 0;
+	x->dmap = dmap;
 	init_swait_queue_head(&x->wait);
 }
 
@@ -136,13 +140,13 @@ extern void complete_all(struct completion *);
 
 #define wait_for_completion(x)						\
 ({									\
-	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	sdt_might_sleep_start_timeout((x)->dmap, -1L);			\
 	__wait_for_completion(x);					\
 	sdt_might_sleep_end();						\
 })
 #define wait_for_completion_io(x)					\
 ({									\
-	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	sdt_might_sleep_start_timeout((x)->dmap, -1L);			\
 	__wait_for_completion_io(x);					\
 	sdt_might_sleep_end();						\
 })
@@ -150,7 +154,7 @@ extern void complete_all(struct completion *);
 ({									\
 	int __ret;							\
 									\
-	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	sdt_might_sleep_start_timeout((x)->dmap, -1L);			\
 	__ret = __wait_for_completion_interruptible(x);			\
 	sdt_might_sleep_end();						\
 	__ret;								\
@@ -159,7 +163,7 @@ extern void complete_all(struct completion *);
 ({									\
 	int __ret;							\
 									\
-	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	sdt_might_sleep_start_timeout((x)->dmap, -1L);			\
 	__ret = __wait_for_completion_killable(x);			\
 	sdt_might_sleep_end();						\
 	__ret;								\
@@ -168,7 +172,7 @@ extern void complete_all(struct completion *);
 ({									\
 	int __ret;							\
 									\
-	sdt_might_sleep_start_timeout(NULL, -1L);			\
+	sdt_might_sleep_start_timeout((x)->dmap, -1L);			\
 	__ret = __wait_for_completion_state(x, s);			\
 	sdt_might_sleep_end();						\
 	__ret;								\
@@ -177,7 +181,7 @@ extern void complete_all(struct completion *);
 ({									\
 	unsigned long __ret;						\
 									\
-	sdt_might_sleep_start_timeout(NULL, t);				\
+	sdt_might_sleep_start_timeout((x)->dmap, t);			\
 	__ret = __wait_for_completion_timeout(x, t);			\
 	sdt_might_sleep_end();						\
 	__ret;								\
@@ -186,7 +190,7 @@ extern void complete_all(struct completion *);
 ({									\
 	unsigned long __ret;						\
 									\
-	sdt_might_sleep_start_timeout(NULL, t);				\
+	sdt_might_sleep_start_timeout((x)->dmap, t);			\
 	__ret = __wait_for_completion_io_timeout(x, t);			\
 	sdt_might_sleep_end();						\
 	__ret;								\
@@ -195,7 +199,7 @@ extern void complete_all(struct completion *);
 ({									\
 	long __ret;							\
 									\
-	sdt_might_sleep_start_timeout(NULL, t);				\
+	sdt_might_sleep_start_timeout((x)->dmap, t);			\
 	__ret = __wait_for_completion_interruptible_timeout(x, t);	\
 	sdt_might_sleep_end();						\
 	__ret;								\
@@ -204,7 +208,7 @@ extern void complete_all(struct completion *);
 ({									\
 	long __ret;							\
 									\
-	sdt_might_sleep_start_timeout(NULL, t);				\
+	sdt_might_sleep_start_timeout((x)->dmap, t);			\
 	__ret = __wait_for_completion_killable_timeout(x, t);		\
 	sdt_might_sleep_end();						\
 	__ret;								\
-- 
2.17.1



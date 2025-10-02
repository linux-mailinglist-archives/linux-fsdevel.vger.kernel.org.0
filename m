Return-Path: <linux-fsdevel+bounces-63222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1C9BB2DDA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C716382ECE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D927B2EB86F;
	Thu,  2 Oct 2025 08:13:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099232E7161;
	Thu,  2 Oct 2025 08:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392806; cv=none; b=LYVaYYWfFZEnGOrDXIeaaQWLJtR2En7aNzFympM9mludsvC0XYzO7DqIzOJnF0VrEbKkAdiVnpJM+E0OkhTemElYoLVj06Yii6l0kAnAwGPG1HPBSgEzPBFquqFpWkXfEJeMZFuTl8zwMX9ADCKEHo+d9nV2fqiE0kT9XfzWuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392806; c=relaxed/simple;
	bh=aV9n7P9ial4wYcDrF/fJ5wj7GQCfrjxe7wo1qvD27Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mYVTU16Zz9LJGDnvJ3aV8RRJuf6ZmFhUYSoXgz/oFd8FvBunVBRtjeAwoVg7HPj++akcKZsFdbn7OqaTYzXLNWcbRNS67VUSjFZgOnDXd+EeaL98d/ySw/cU9HhRFJs3OLQTNPzL4uj1tfc7DmqO9bT0HZpFXZ8dk6wgAkN/Qqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-f7-68de340c944e
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
Subject: [PATCH v17 07/47] dept: distinguish each kernel context from another
Date: Thu,  2 Oct 2025 17:12:07 +0900
Message-Id: <20251002081247.51255-8-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSb0xTZxSH99773ntLQ81dNfFOjVsaCYnzz2bYOB+I0UTi/UJC5oxhc9Fq
	L7YBqraC1sRYpCCiso6kGCkRKLN0LQi20VFmF8DZDYuxBcXCiliCYkUgwRZSFLSw+e05v/Pk
	5JzkiEhpiFojUqlPCBq1PF9Gi7F4Mrlhc3LaU+VX1sUMGCjuxBCLlmOobW2modx5lQL/DQeC
	ubdmEkrd7zEsVHkZiMb/ZaA6UEXCxN0ZBKbwGA1XIsUYpq2XENS8MDMQubcbrGOLBIx1nkew
	UJ0HdRZXwjL5ETSEh0l42ZbI+8dWQI/pIg2TgVoC6s95KChpbKXB/ayDgcDEOwJC1VUEOJxZ
	4DNaCDBfKSHA1PIHAXGrnYHexhAGqz4FzA/6KRi11TDgdYwzcGPyIQU9TwcoGPm7jILf9c8Y
	cA7eQxB9FCagvCOGwTP0JTSU/YrhjqcHQ/lCFIG3fZSA/o5aGi613aJAb55LXN/po6DP4cfQ
	Oh4kwOf9B8P1JwEC/L9cpiBofI6gZcpC71Dwdtdtgm++1oz4t/NViI9eLyH5UmOivPt6muQN
	rpO8Z7Ye8+6aYYY3/DnE8PXOQt7w1yTFu2wb+cY7EYJvmIlRvNN+gc5O+UGcoRDyVUWCZuv2
	g2Jl0BBDx0b3nXIMllF6ZM2sQEkijk3jfrtvIj+yZf4mvcQ0m8oFg/HlfBX7Bee6/IJaYpL1
	reMGApuWeCWbxd2u7FvOMZvCvYnb8BJL2G+4piYv9d/MzzlHW+fynCT2W64/7Ft2pAmndNpA
	VCBxwjEncXqf+/8lPuO6bEFsRJJ69IkdSVXqogK5Kj9ti1KnVp3acvhogRMlfs565t2P7WjG
	v6cbsSIkS5b4U4aVUkpepNUVdCNORMpWSQ7aQkqpRCHXnRY0Rw9oCvMFbTdaK8Ky1ZJtsycV
	UvaI/ISQJwjHBM3HLiFKWqNHJW6P7lGm5DvLIeNPa+M7xivzpuYX0tcVMXWhnZsL9++6lX3g
	ou5x/HVf+tTIm4mHnw7OhL8PFp/elLoiY+eZ4xuGqm+GK7INvoi7tz0nTtemrq9bbNdGckda
	f8a5V3Oa9m9P73oyH29UZ9o9OZrcvWdbKmeztvr6Xs0pIntkvbEuGdYq5V9vJDVa+QfpSL59
	bwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa2xLcRjG/c+1K12ObrGTkZDGQsQ1GXmDyD64HIKQuCQusYZj7S6dtDMm
	waYti8tUpxurURtHsw5byxgqM1OZGmouw6q61EzskrCa7qqd+PLm977PkyfPh1eES2vIeJFS
	lcWrVfJ0GSUmxGsXaWeNS/ysmPtEOwHe5dUREOzNJ+DCzUoK8u3nSXh1w4bAF8xH0DdgxkFf
	O0LAkNFFQ2/oEw0jTheCIo8Rh8pbeRj8qhqm4MfjnwhM/gAFxd/zCOgRTiIoaTfT8P3JCujy
	3SdhxPsNg/e/OxEIgWEMAnXHEAwVpcGlMgcFA00vcSg2vUJw2e/FoaMqLN5yfUbgtB6h4Kvh
	Ng7NgWh4E+yhoNF0goIuzwUMuqsosBxxklBqNiLQlt+koKjUTkDtl3s0eH4MYtBaZMTAZl8D
	PqGdALehDAv3C7uq48BcrMXCowMD0/X7GISEChqel7cSIOQmgLmpmYQ2awkNg/55MGLJBJft
	Gw3e0yYCbnS9JJNMiOvTFxBchaMG4/Svhyiu8mIl4gb6jYjrvarFOb0hvD7u7ME5nWMfd9Xd
	SXH9wbcU5/xtIbhnZSx3pmkWV1vipTndw4/0uoVbxIt38enKbF49Z0myWNGiC6I9bZv32z4c
	JXORsOw4ihKxTCJb1l9NRZhiprEtLSE8wrHMFNZxqp2MMM64J7HvPDMjHMOsYWsKXo/eCSaB
	/RWyEhGWMPPZa9dc5L/Myaytqm40J4pZwDb73aMeadij79FhBiS2oDEVKFapys6QK9Pnz9ak
	KXJUyv2zd2Zm2FH4m4SDg2fuot7mFfWIESHZOIknwauQkvJsTU5GPWJFuCxWkmxtVUglu+Q5
	B3h15g713nReU48mighZnGTVZj5ZyqTIs/g0nt/Dq/+rmCgqPhedC3Q/zeh+uml5caPKtN5y
	Z2rCRsb2wk52SK4krqSt/akGXWrfHdHqY7sPJRZuKNVHQ/Thwg0xDcPTv/gaU293rC6PKqxe
	v+hnjDBt68PxzpNJ2y8ef+Bp8BGhBY40cBfUC2fHfthmT+k7kaIYs1GeFP8o19Iw+U/t0ved
	0ja/cpuM0Cjk82bgao38Lwy29yNJAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Each unique kernel context, in dept's point of view, should be
identified on every entrance to kernel mode e.g. system call or user
oriented fault.  Otherwise, dept may track meaningless dependencies
across different kernel context.

Plus, in order to update kernel context id at the very beginning of each
entrance, arch code support is required, that could be configured by
CONFIG_ARCH_HAS_DEPT_SUPPORT.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 29 ++++++++++-------
 include/linux/sched.h    | 10 +++---
 kernel/dependency/dept.c | 67 ++++++++++++++++++++--------------------
 lib/Kconfig.debug        |  5 ++-
 4 files changed, 61 insertions(+), 50 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 5f0d2d8c8cbe..cb1b1beea077 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -26,11 +26,16 @@ struct task_struct;
 #define DEPT_MAX_SUBCLASSES_USR		(DEPT_MAX_SUBCLASSES / DEPT_MAX_SUBCLASSES_EVT)
 #define DEPT_MAX_SUBCLASSES_CACHE	2
 
-#define DEPT_SIRQ			0
-#define DEPT_HIRQ			1
-#define DEPT_IRQS_NR			2
-#define DEPT_SIRQF			(1UL << DEPT_SIRQ)
-#define DEPT_HIRQF			(1UL << DEPT_HIRQ)
+enum {
+	DEPT_CXT_SIRQ = 0,
+	DEPT_CXT_HIRQ,
+	DEPT_CXT_IRQS_NR,
+	DEPT_CXT_PROCESS = DEPT_CXT_IRQS_NR,
+	DEPT_CXTS_NR
+};
+
+#define DEPT_SIRQF			(1UL << DEPT_CXT_SIRQ)
+#define DEPT_HIRQF			(1UL << DEPT_CXT_HIRQ)
 
 struct dept_ecxt;
 struct dept_iecxt {
@@ -95,8 +100,8 @@ struct dept_class {
 			/*
 			 * for tracking IRQ dependencies
 			 */
-			struct dept_iecxt iecxt[DEPT_IRQS_NR];
-			struct dept_iwait iwait[DEPT_IRQS_NR];
+			struct dept_iecxt iecxt[DEPT_CXT_IRQS_NR];
+			struct dept_iwait iwait[DEPT_CXT_IRQS_NR];
 
 			/*
 			 * classified by a map embedded in task_struct,
@@ -208,8 +213,8 @@ struct dept_ecxt {
 			/*
 			 * where the IRQ-enabled happened
 			 */
-			unsigned long	enirq_ip[DEPT_IRQS_NR];
-			struct dept_stack *enirq_stack[DEPT_IRQS_NR];
+			unsigned long	enirq_ip[DEPT_CXT_IRQS_NR];
+			struct dept_stack *enirq_stack[DEPT_CXT_IRQS_NR];
 
 			/*
 			 * where the event context started
@@ -253,8 +258,8 @@ struct dept_wait {
 			/*
 			 * where the IRQ wait happened
 			 */
-			unsigned long	irq_ip[DEPT_IRQS_NR];
-			struct dept_stack *irq_stack[DEPT_IRQS_NR];
+			unsigned long	irq_ip[DEPT_CXT_IRQS_NR];
+			struct dept_stack *irq_stack[DEPT_CXT_IRQS_NR];
 
 			/*
 			 * where the wait happened
@@ -384,6 +389,7 @@ extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip,
 extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long ip);
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
+extern void dept_update_cxt(void);
 
 static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 {
@@ -431,6 +437,7 @@ struct dept_map { };
 #define dept_ecxt_exit(m, e_f, ip)			do { } while (0)
 #define dept_sched_enter()				do { } while (0)
 #define dept_sched_exit()				do { } while (0)
+#define dept_update_cxt()				do { } while (0)
 #define dept_ecxt_enter_nokeep(m)			do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ddb162201ba1..05c3f8a45405 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -830,19 +830,19 @@ struct dept_task {
 	int				wait_hist_pos;
 
 	/*
-	 * sequential id to identify each IRQ context
+	 * sequential id to identify each context
 	 */
-	unsigned int			irq_id[DEPT_IRQS_NR];
+	unsigned int			cxt_id[DEPT_CXTS_NR];
 
 	/*
 	 * for tracking IRQ-enabled points with cross-event
 	 */
-	unsigned int			wgen_enirq[DEPT_IRQS_NR];
+	unsigned int			wgen_enirq[DEPT_CXT_IRQS_NR];
 
 	/*
 	 * for keeping up-to-date IRQ-enabled points
 	 */
-	unsigned long			enirq_ip[DEPT_IRQS_NR];
+	unsigned long			enirq_ip[DEPT_CXT_IRQS_NR];
 
 	/*
 	 * for reserving a current stack instance at each operation
@@ -896,7 +896,7 @@ struct dept_task {
 	.wait_hist = { { .wait = NULL, } },			\
 	.ecxt_held_pos = 0,					\
 	.wait_hist_pos = 0,					\
-	.irq_id = { 0U },					\
+	.cxt_id = { 0U },					\
 	.wgen_enirq = { 0U },					\
 	.enirq_ip = { 0UL },					\
 	.stack = NULL,						\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index dfe9dfdb6991..953e1b81a81f 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -230,9 +230,9 @@ static struct dept_class *dep_tc(struct dept_dep *d)
 
 static const char *irq_str(int irq)
 {
-	if (irq == DEPT_SIRQ)
+	if (irq == DEPT_CXT_SIRQ)
 		return "softirq";
-	if (irq == DEPT_HIRQ)
+	if (irq == DEPT_CXT_HIRQ)
 		return "hardirq";
 	return "(unknown)";
 }
@@ -410,7 +410,7 @@ static void initialize_class(struct dept_class *c)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		struct dept_iecxt *ie = &c->iecxt[i];
 		struct dept_iwait *iw = &c->iwait[i];
 
@@ -436,7 +436,7 @@ static void initialize_ecxt(struct dept_ecxt *e)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		e->enirq_stack[i] = NULL;
 		e->enirq_ip[i] = 0UL;
 	}
@@ -452,7 +452,7 @@ static void initialize_wait(struct dept_wait *w)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		w->irq_stack[i] = NULL;
 		w->irq_ip[i] = 0UL;
 	}
@@ -491,7 +491,7 @@ static void destroy_ecxt(struct dept_ecxt *e)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++)
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++)
 		if (e->enirq_stack[i])
 			put_stack(e->enirq_stack[i]);
 	if (e->class)
@@ -507,7 +507,7 @@ static void destroy_wait(struct dept_wait *w)
 {
 	int i;
 
-	for (i = 0; i < DEPT_IRQS_NR; i++)
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++)
 		if (w->irq_stack[i])
 			put_stack(w->irq_stack[i]);
 	if (w->class)
@@ -665,7 +665,7 @@ static void print_diagram(struct dept_dep *d)
 	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
 
 	irqf = e->enirqf & w->irqf;
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		if (!firstline)
 			pr_warn("\nor\n\n");
 		firstline = false;
@@ -698,7 +698,7 @@ static void print_dep(struct dept_dep *d)
 	const char *tc_n = tc->sched_map ? "<sched>" : (tc->name ?: "(unknown)");
 
 	irqf = e->enirqf & w->irqf;
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		pr_warn("%s has been enabled:\n", irq_str(irq));
 		print_ip_stack(e->enirq_ip[irq], e->enirq_stack[irq]);
 		pr_warn("\n");
@@ -866,7 +866,7 @@ static void bfs(void *root, struct bfs_ops *ops, void *in, void **out)
  */
 
 static unsigned long cur_enirqf(void);
-static int cur_irq(void);
+static int cur_cxt(void);
 static unsigned int cur_ctxt_id(void);
 
 static struct dept_iecxt *iecxt(struct dept_class *c, int irq)
@@ -1443,7 +1443,7 @@ static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
 	if (d) {
 		check_dl_bfs(d);
 
-		for (i = 0; i < DEPT_IRQS_NR; i++) {
+		for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 			struct dept_iwait *fiw = iwait(fc, i);
 			struct dept_iecxt *found_ie;
 			struct dept_iwait *found_iw;
@@ -1487,7 +1487,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
 	unsigned int wg;
-	int irq;
+	int cxt;
 	int i;
 
 	if (DEPT_WARN_ON(!valid_class(c)))
@@ -1503,9 +1503,9 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	w->wait_stack = get_current_stack();
 	w->sched_sleep = sched_sleep;
 
-	irq = cur_irq();
-	if (irq < DEPT_IRQS_NR)
-		add_iwait(c, irq, w);
+	cxt = cur_cxt();
+	if (cxt == DEPT_CXT_HIRQ || cxt == DEPT_CXT_SIRQ)
+		add_iwait(c, cxt, w);
 
 	/*
 	 * Avoid adding dependency between user aware nested ecxt and
@@ -1579,7 +1579,7 @@ static struct dept_ecxt_held *add_ecxt(struct dept_map *m,
 	eh->sub_l = sub_l;
 
 	irqf = cur_enirqf();
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR)
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR)
 		add_iecxt(c, irq, e, false);
 
 	del_ecxt(e);
@@ -1728,7 +1728,7 @@ static void do_event(struct dept_map *m, struct dept_map *real_m,
 			add_dep(eh->ecxt, wh->wait);
 	}
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		struct dept_ecxt *e;
 
 		if (before(dt->wgen_enirq[i], wg))
@@ -1775,7 +1775,7 @@ static void disconnect_class(struct dept_class *c)
 		call_rcu(&d->rh, del_dep_rcu);
 	}
 
-	for (i = 0; i < DEPT_IRQS_NR; i++) {
+	for (i = 0; i < DEPT_CXT_IRQS_NR; i++) {
 		stale_iecxt(iecxt(c, i));
 		stale_iwait(iwait(c, i));
 	}
@@ -1800,27 +1800,21 @@ static unsigned long cur_enirqf(void)
 	return 0UL;
 }
 
-static int cur_irq(void)
+static int cur_cxt(void)
 {
 	if (lockdep_softirq_context(current))
-		return DEPT_SIRQ;
+		return DEPT_CXT_SIRQ;
 	if (lockdep_hardirq_context())
-		return DEPT_HIRQ;
-	return DEPT_IRQS_NR;
+		return DEPT_CXT_HIRQ;
+	return DEPT_CXT_PROCESS;
 }
 
 static unsigned int cur_ctxt_id(void)
 {
 	struct dept_task *dt = dept_task();
-	int irq = cur_irq();
+	int cxt = cur_cxt();
 
-	/*
-	 * Normal process context
-	 */
-	if (irq == DEPT_IRQS_NR)
-		return 0U;
-
-	return dt->irq_id[irq] | (1UL << irq);
+	return dt->cxt_id[cxt] | (1UL << cxt);
 }
 
 static void enirq_transition(int irq)
@@ -1877,7 +1871,7 @@ static void dept_enirq(unsigned long ip)
 
 	flags = dept_enter();
 
-	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+	for_each_set_bit(irq, &irqf, DEPT_CXT_IRQS_NR) {
 		dt->enirq_ip[irq] = ip;
 		enirq_transition(irq);
 	}
@@ -1923,6 +1917,13 @@ void noinstr dept_hardirqs_off(void)
 	dept_task()->hardirqs_enabled = false;
 }
 
+void noinstr dept_update_cxt(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->cxt_id[DEPT_CXT_PROCESS] += 1UL << DEPT_CXTS_NR;
+}
+
 /*
  * Ensure it's the outmost softirq context.
  */
@@ -1930,7 +1931,7 @@ void dept_softirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
-	dt->irq_id[DEPT_SIRQ] += 1UL << DEPT_IRQS_NR;
+	dt->cxt_id[DEPT_CXT_SIRQ] += 1UL << DEPT_CXTS_NR;
 }
 
 /*
@@ -1940,7 +1941,7 @@ void noinstr dept_hardirq_enter(void)
 {
 	struct dept_task *dt = dept_task();
 
-	dt->irq_id[DEPT_HIRQ] += 1UL << DEPT_IRQS_NR;
+	dt->cxt_id[DEPT_CXT_HIRQ] += 1UL << DEPT_CXTS_NR;
 }
 
 void dept_sched_enter(void)
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b9cff0bec6f2..3669b069337b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1365,9 +1365,12 @@ config DEBUG_PREEMPT
 
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
+config ARCH_HAS_DEPT_SUPPORT
+	bool
+
 config DEPT
 	bool "Dependency tracking (EXPERIMENTAL)"
-	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
+	depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && ARCH_HAS_DEPT_SUPPORT
 	select DEBUG_SPINLOCK
 	select DEBUG_MUTEXES if !PREEMPT_RT
 	select DEBUG_RT_MUTEXES if RT_MUTEXES
-- 
2.17.1



Return-Path: <linux-fsdevel+bounces-70780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 377EECA6C4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 09:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBA043134C7E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 08:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187A532A3C3;
	Fri,  5 Dec 2025 07:20:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993AC2F744B;
	Fri,  5 Dec 2025 07:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919249; cv=none; b=UGudJUu3gW5Yw5vkBJRk0bWntM6eVHIAx3D7QMzdkMv8VxlwpxzDbitPcBB28xIrQOXrnYdpz8jtaq2cjqe8Hk+xiqjTwi7zr+trByoMspTw//xlYfKrs+GYD0SKOQ+TFqa6353z97JrNM8h5UGaWrOhR7+rY1uM0MU/RTnIyT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919249; c=relaxed/simple;
	bh=U+cEpt47wB7+ls1g6+mCT3YTUPUBHz5JwGW5fBJJJYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=orRukqIMjm4uyLS2hHidxlD6JXa5axA1XNGlrGAHlmd5hNmdqfBqbJ2sCxG1VaM1NgVEKeA2QSDBdQAfqSQRqP8Gequ6x7OlkPykX5NTynaeFFqSdn/t9HOBhl9dlin8R0tHUIQelHng7t/2kEsZTL1q+cIje2/M0vaBXgnna4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-79-6932876fd8f6
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
Subject: [PATCH v18 21/42] dept: make dept able to work with an external wgen
Date: Fri,  5 Dec 2025 16:18:34 +0900
Message-Id: <20251205071855.72743-22-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxjF/d97/7eXjrqbivEKyZxN0GRxCILL49tCQrbcD9No/ODismgj
	d3JjS0kRkCVGhCJNg5U1qQzQUSBUJ8xiO5QKVd7GNAYBFSkIlo4Kw1JJoDBRaoc1fvudc55z
	Pj0MKR/GsYyYeVLQZipVClpKSQPRtV9mlWwTE222taAvPgOjHh+GhaCegku2Rhr09goMngU9
	gmJnmIKQqUcCwaVnEjCfRRB29SBw998lwd81h8Ds9dFQPn2WgllrKYLKySoJBDytGMJjUwT4
	2ksQhC6egOpaBw1ve/tIqPGOkTA3PY7AdbWQhhdlzSQ8WZilITBwiYBXTTRYCl0YiupsNFy8
	bKfAOX5bAgP+ZQIa7HvBY52koKr8XwLMf7QSYC2Ih6rexxiWvUkQtmjgeqAPg3/SRIPn73MY
	bhWMS8A+/BeC4BMvAfaJpxjaXPcp0IeCCHpa/iGgtKkZw/PGMIb+9gcYbFNuAh703KPgfuXv
	FNQPDRCwaIyD/l/OY3CXvUDgX7SSqen8NcdNgi9+FKL5xt8aEf/2jQnxwfoiki8uW5FdM7Mk
	r3Pk8a5FC8U7K8ckvO7OiIS32HN4XXcA83Vt0wRfM7eA+RH/nv0Jh6W70wWVmCtot359VJox
	MWgksjpTTw2OB3EBcqYYUBTDsSlc32wD/ZFvOK9HmGY3c273EvmeY9jPOcf5SWxAUoZkH2/g
	SpaMkWANu5e7qbtAGRDDUGw8p6tNfm/L2K+4y20NxIfNDVxDU3vkPGrFNw+9ibCc3c5VG/6L
	bHJsdRR35UIIfSis5zquuqkyJLOgVdeQXMzMVStFVUpCRn6meCrhmEZtRysPZz29/EMLmus/
	2IlYBimiZe15SaIcK3Oz89WdiGNIRYxsRpUoymXpyvyfBa3miDZHJWR3ojiGUqyTbVvMS5ez
	x5UnhROCkCVoP6YEExVbgHaqW6iX3+6aqBiuW/vJN6LGeiixPGwYuv3yu1GQfTpflBbcEl+T
	Mp+s+X7Zt1p3YD/p29edZtwkGU3+7M+pLlP1w4pfp2ML01hboWnH65/UfXE7Vql+zGk+Y5w/
	ijaqdu2Wzbzzpt44lhttPFeXisdOW16hZIe5u0MRHIl9vaZ0UEFlZyiTviC12cr/AUgBArZs
	AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+93XrqPVZQldih4selBo9j7Rg+ofL4IVRUUR5ciLDueDzbQF
	oXMuzfI12KSmaaaj3Cqf6bLZcGSlRdpcSmkaLsvUFNsUX9k0+ufwOd/v9xzOH4fGxbXkCloW
	E88rYqRyCSUkhEf3aQJi07bLggz6jZCuTYKuHjcJH9V2AryedALyn1gomDXWCiC98jYJrztS
	CGh9bEbQ401HMDFtxEFrnSNgVtckAM/kZwHo1QjmbE0IDG06HDpbX+BgqVZj8Lv8DwWDjjEE
	+q9uCvIG1ASMmG4huNNvFMDAy2AY7qknYa77OwYd40MITO4/GLjtaQhmDVFQWFzlGzeMUjD9
	7j0OefpWBPe+duMwNtCLoLrpCwLbgxQKvuXU4OB0L4F27wgFb/Q3KRhuy8fgVzkFRSk2Etre
	DiIoMOoQ9H+yYaC5/4QCQ0ElAdbeZwJoG5zBoMugw8BcGQo9pn4CWnKKMd+5vlTFcjDmaTBf
	+YGB/lE9BpOmMsGhUsRNaLMIrqzqKcZpP8xSnOWuBXHTUzrEeUo1OKfN8bWOoRGcS61K5Epb
	hihuyuuiONt4EcE1F7NcyY0pjMt9F8BZ73QLjh8+J9wfzstlCbxi68EwYWSfKwuLazx0xdXr
	IZORdWcG8qNZZidbYX1MzTPFbGQ7OyfxefZn1rJVmf1kBhLSOONcw6ZNZi0Yy5hQ9mlqNpGB
	aJpg1rOpxTvmZRGzmy14bsb+7VzDmsvtC3E/n67vmFpgMbOLLcyYIHOQsAgtKkP+spiEaKlM
	vitQGRWpipFdCbwUG12JfO9kujaTW4c8zuBGxNBIslhkT9wmE5PSBKUquhGxNC7xFw3Jg2Ri
	UbhUdZVXxF5UXJbzyka0kiYky0UhZ/gwMRMhjeejeD6OV/x3MdpvRTLaG5Jo+bTJ+fCAquHD
	q4lTEbuVZ1fVD46111ecb7h23d/sdVwYOaJ1IsmJ1RtOvj94+octylzeUtIXdq7OVZP6TD7t
	CA7JRIEBo+wW0brstynZ2vF4lSSzPfn1TJc9eEBsilv6M2l0T0W+zZUwGldXqHbYDteWNvel
	NR8rOeat00gIZaR022ZcoZT+BZditctKAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

There is a case where the total map size of waits of a class is so large.
For instance, PG_locked is the case if every struct page embeds its
regular map for PG_locked.  The total size for the maps will be 'the #
of pages * sizeof(struct dept_map)', which is too big to accept.

Keep the minimum data in the case, timestamp called 'wgen', that dept
uses.  Make dept able to work with the wgen instead of whole regular map.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 18 ++++++++++++++----
 include/linux/dept_sdt.h |  6 +++---
 kernel/dependency/dept.c | 30 +++++++++++++++++++++---------
 3 files changed, 38 insertions(+), 16 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index e70cbc6f41dc..7d5e01f56e8e 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -129,6 +129,13 @@ struct dept_wait_hist {
 	unsigned int			ctxt_id;
 };
 
+/*
+ * for subsystems that requires compact use of memory e.g. struct page
+ */
+struct dept_ext_wgen {
+	unsigned int wgen;
+};
+
 extern void dept_on(void);
 extern void dept_off(void);
 extern void dept_init(void);
@@ -138,6 +145,7 @@ extern void dept_free_range(void *start, unsigned int sz);
 
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
+extern void dept_ext_wgen_init(struct dept_ext_wgen *ewg);
 extern void dept_map_copy(struct dept_map *to, struct dept_map *from);
 extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l, long timeout);
 extern void dept_stage_wait(struct dept_map *m, struct dept_key *k, unsigned long ip, const char *w_fn, long timeout);
@@ -146,8 +154,8 @@ extern void dept_clean_stage(void);
 extern void dept_ttwu_stage_wait(struct task_struct *t, unsigned long ip);
 extern void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *c_fn, const char *e_fn, int sub_l);
 extern bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f);
-extern void dept_request_event(struct dept_map *m);
-extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *e_fn);
+extern void dept_request_event(struct dept_map *m, struct dept_ext_wgen *ewg);
+extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *e_fn, struct dept_ext_wgen *ewg);
 extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long ip);
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
@@ -174,6 +182,7 @@ extern void dept_hardirqs_off(void);
 #else /* !CONFIG_DEPT */
 struct dept_key { };
 struct dept_map { };
+struct dept_ext_wgen { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
 
@@ -186,6 +195,7 @@ struct dept_map { };
 
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
+#define dept_ext_wgen_init(wg)				do { } while (0)
 #define dept_map_copy(t, f)				do { } while (0)
 #define dept_wait(m, w_f, ip, w_fn, sl, t)		do { (void)(w_fn); } while (0)
 #define dept_stage_wait(m, k, ip, w_fn, t)		do { (void)(k); (void)(w_fn); } while (0)
@@ -194,8 +204,8 @@ struct dept_map { };
 #define dept_ttwu_stage_wait(t, ip)			do { } while (0)
 #define dept_ecxt_enter(m, e_f, ip, c_fn, e_fn, sl)	do { (void)(c_fn); (void)(e_fn); } while (0)
 #define dept_ecxt_holding(m, e_f)			false
-#define dept_request_event(m)				do { } while (0)
-#define dept_event(m, e_f, ip, e_fn)			do { (void)(e_fn); } while (0)
+#define dept_request_event(m, wg)			do { } while (0)
+#define dept_event(m, e_f, ip, e_fn, wg)		do { (void)(e_fn); } while (0)
 #define dept_ecxt_exit(m, e_f, ip)			do { } while (0)
 #define dept_sched_enter()				do { } while (0)
 #define dept_sched_exit()				do { } while (0)
diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
index 14917df0cc30..9cd70affaf35 100644
--- a/include/linux/dept_sdt.h
+++ b/include/linux/dept_sdt.h
@@ -25,7 +25,7 @@
 
 #define sdt_wait_timeout(m, t)						\
 	do {								\
-		dept_request_event(m);					\
+		dept_request_event(m, NULL);				\
 		dept_wait(m, 1UL, _THIS_IP_, __func__, 0, t);		\
 	} while (0)
 #define sdt_wait(m) sdt_wait_timeout(m, -1L)
@@ -49,9 +49,9 @@
 #define sdt_might_sleep_end()		dept_clean_stage()
 
 #define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
-#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__)
+#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__, NULL)
 #define sdt_ecxt_exit(m)		dept_ecxt_exit(m, 1UL, _THIS_IP_)
-#define sdt_request_event(m)		dept_request_event(m)
+#define sdt_request_event(m)		dept_request_event(m, NULL)
 #else /* !CONFIG_DEPT */
 #define sdt_map_init(m)			do { } while (0)
 #define sdt_map_init_key(m, k)		do { (void)(k); } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 519b2151403e..f928c12111fe 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -2172,6 +2172,11 @@ void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u,
 }
 EXPORT_SYMBOL_GPL(dept_map_reinit);
 
+void dept_ext_wgen_init(struct dept_ext_wgen *ewg)
+{
+	ewg->wgen = 0U;
+}
+
 void dept_map_copy(struct dept_map *to, struct dept_map *from)
 {
 	if (unlikely(!dept_working())) {
@@ -2355,7 +2360,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
  */
 static void __dept_event(struct dept_map *m, struct dept_map *real_m,
 		unsigned long e_f, unsigned long ip, const char *e_fn,
-		bool sched_map)
+		bool sched_map, unsigned int wg)
 {
 	struct dept_class *c;
 	struct dept_key *k;
@@ -2377,7 +2382,7 @@ static void __dept_event(struct dept_map *m, struct dept_map *real_m,
 	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, sched_map);
 
 	if (c)
-		do_event(m, real_m, c, READ_ONCE(m->wgen), ip, e_fn);
+		do_event(m, real_m, c, wg, ip, e_fn);
 }
 
 void dept_wait(struct dept_map *m, unsigned long w_f,
@@ -2602,7 +2607,7 @@ void dept_ttwu_stage_wait(struct task_struct *requestor, unsigned long ip)
 	if (!m.keys)
 		goto exit;
 
-	__dept_event(&m, real_m, 1UL, ip, "try_to_wake_up", sched_map);
+	__dept_event(&m, real_m, 1UL, ip, "try_to_wake_up", sched_map, m.wgen);
 exit:
 	dept_exit(flags);
 }
@@ -2781,10 +2786,11 @@ bool dept_ecxt_holding(struct dept_map *m, unsigned long e_f)
 }
 EXPORT_SYMBOL_GPL(dept_ecxt_holding);
 
-void dept_request_event(struct dept_map *m)
+void dept_request_event(struct dept_map *m, struct dept_ext_wgen *ewg)
 {
 	unsigned long flags;
 	unsigned int wg;
+	unsigned int *wg_p;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2797,18 +2803,22 @@ void dept_request_event(struct dept_map *m)
 	 */
 	flags = dept_enter_recursive();
 
+	wg_p = ewg ? &ewg->wgen : &m->wgen;
+
 	wg = next_wgen();
-	WRITE_ONCE(m->wgen, wg);
+	WRITE_ONCE(*wg_p, wg);
 
 	dept_exit_recursive(flags);
 }
 EXPORT_SYMBOL_GPL(dept_request_event);
 
 void dept_event(struct dept_map *m, unsigned long e_f,
-		unsigned long ip, const char *e_fn)
+		unsigned long ip, const char *e_fn,
+		struct dept_ext_wgen *ewg)
 {
 	struct dept_task *dt = dept_task();
 	unsigned long flags;
+	unsigned int *wg_p;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2816,24 +2826,26 @@ void dept_event(struct dept_map *m, unsigned long e_f,
 	if (m->nocheck)
 		return;
 
+	wg_p = ewg ? &ewg->wgen : &m->wgen;
+
 	if (dt->recursive) {
 		/*
 		 * Dept won't work with this even though an event
 		 * context has been asked. Don't make it confused at
 		 * handling the event. Disable it until the next.
 		 */
-		WRITE_ONCE(m->wgen, 0U);
+		WRITE_ONCE(*wg_p, 0U);
 		return;
 	}
 
 	flags = dept_enter();
 
-	__dept_event(m, m, e_f, ip, e_fn, false);
+	__dept_event(m, m, e_f, ip, e_fn, false, READ_ONCE(*wg_p));
 
 	/*
 	 * Keep the map diabled until the next sleep.
 	 */
-	WRITE_ONCE(m->wgen, 0U);
+	WRITE_ONCE(*wg_p, 0U);
 
 	dept_exit(flags);
 }
-- 
2.17.1



Return-Path: <linux-fsdevel+bounces-63240-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C461BB2FF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A1F188D95E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219AC30AAD7;
	Thu,  2 Oct 2025 08:13:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E461630101A;
	Thu,  2 Oct 2025 08:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392836; cv=none; b=qG2MKtC0xM/Ii3MfswAb4cxHH5l3cuOAp4LhxFbyCM+NqMO/V5nT8sF8gz/nm9txrumMFZw2BmXCt1dj+aTjpvcC0H7l1F34AwwJV850Ccp5IC34G7baMNcRRHzxCzQ4U9TOQxjDLD3ibBk5MDd9gTaaZXIOBDcGlDdVI5H4vqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392836; c=relaxed/simple;
	bh=kq6nzJCqCAUp+/7t0l3JPIm1vcvrQsYOUfRYA0jtEa0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=iANKv6wUa3G6SWA4wygIU32LWqn3VhSqPZO5BER30l9CGQV0Q+H8nDLunx7tGlSS5EB1yMa2fK+gbA0/XqOHU+TCppGieZ9J2jh/3RMJU5XvHm8zBjeFBxYoKB2t4AZaqesauFZV/Af5EFF+VXcdN0bhQPW5S+knaKLQ7m5bWzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-4c-68de3410abf8
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
Subject: [PATCH v17 24/47] dept: make dept able to work with an external wgen
Date: Thu,  2 Oct 2025 17:12:24 +0900
Message-Id: <20251002081247.51255-25-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSbUxTZxQHcJ97n3tvaWi865y7yuJLDTFBwWnYPMnYQvyyq7GJxi9GAqNZ
	72wFiiuCssyIgwpRVCSpxBYRQUuhRZo2btYBQdROrIRWCFYEoaJtHFa042VQFKHGb7/8z/+c
	T0dESh9RK0VqzSFBq1Fky2gxFodi6xI/S36q+vrsk3joP96BYXKiDEN1i5UGzzULguHJMgTT
	ESMJOuc8homZJwyc91aS8J/tPQ1jt8MI9P7nNIybyhEYAkYGXt79EULDf1PwvKMUwbvzWXCp
	zkFDpLuHhCq9B0Gb+Q8aXlRcJ6FLf4qGkLeagNc2Gi4aKxEU17fQ4By5yYB3bI4Ai10Ow6YA
	BmNVMQEzpiYGjN29FDwzGxiY82+G+dpccFmCDAyd1WO4FuqhYCxQScNfRSMM2B/fRTDR5yfA
	PtpPQdvABrh84gqGCzWDNLS2dWEot12n4Kl1ngJPh5uChxYPhpagjwC36x6GLkMjhp6bzRRc
	feQlwD/io2DqTBx4zp2mwFfxAkHz6zo6VclP685gvsnxJ8HrHr6jeWuNFfETV4tJXlexoNuv
	xkm+xHGYP9edyDsNQwxf0j7A8LX2fL7kTojiHeYEvr71JcEPjH2/K2GfOEUpZKsLBO2mHzLF
	qvr7Ow52ph5pKz+Oi5Az+SSKEXFsMmcbtVOfHI6Ukoum2fWczzcT9TJ2Dec4HYh2SNb9Fdfv
	3bjoz1k5V/d2LppjNp7z/x/Gi5aw33LP2g3kx5urOYutI+qYhbzX7452pOw3nG68hDiJxAud
	hhgu2B1CHxdWcLfMPlyBJLVoSROSqjUFOQp1dnKSqlCjPpL0c26OHS28m+noXNoNFPbs6USs
	CMliJZ74IZWUUhTkFeZ0Ik5EypZJMs2DKqlEqSj8TdDm/qTNzxbyOlGcCMu+lGyZOqyUsvsV
	h4QsQTgoaD9NCVHMyiK0PHxj26rAiQfBRmGp/BhWSp2jfXGZ71tCNe3p2/8JptldWYJ8q1lW
	MLtk3eAvpbGaKp+jd2trZOdGZdqBx9Z7jbvTi4+69+YbM3I2NXAbvCntJm1fkuu++9SF3LLZ
	0K/rrStSUvetW+v8PdYy/F3Xg8RRErmqv0jMkOsjbwqD/8pwnkqxOYHU5ik+AN+FRIpqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxTG/d/XUi3cVRLvUIOpIzNz+JKAOVFizGLkhugmJoPIB203btaG
	N9NiFbIlIFSJRYXGglBRLLEhbYUO0NiRMlKyTq1Eaxk6bcGSCigwFKlaKGJh8cvJ7zzPk5Pn
	wxHg4ptkgkBRWMwrC2X5EkpICL/fVZHMpAzJt9V2bYLB8l4CQrNVBFxut1JQ1dFAwsM2C4Lh
	UBWC9/MGHDT2RQIWdC4aZsPPaFh0uBDUeXQ4WLvKMXhr+0jBRN8MAn0gSEH9y3ICpk3VCBpH
	DTS8/Csdpoa7SVj0j2Hw+N0kAlPwIwbB3jMIFury4Kqxk4L5/gc41OsfIrgW8OMwbouaXa4h
	BI7WUxS8qLmJgzcYCwOhaQru6rUUTHkuY/CfjYLmUw4Smgw6BBUt7RTUNXUQYH/+Bw2eiQgG
	vjodBpaOAzBsGiXAXWPEov2iqd/XgKG+AouOcQz0N7oxCJvMNNxv8RFgKksCQ7+XhJHWRhoi
	ge2w2FwELssYDf4LegLaph6Qe/SIe685T3DmzlsYp3m0QHHWK1bEzc/pEDd7vQLnNDXRtW9y
	GucqO09w192TFDcX+ofiHO+aCe6ekeVq+5M5e6Of5ip7ntIHd+YI03L5fIWaV27dLRXKW+5l
	HHPuOemoLifKkD3lLIoRsEwKOzN/Bl9iivmaffIkvMzxzAa289woucQ4417HDnq+XeLVzAHW
	+CayrBNMEhv4MEMssYjZwY70NOL/30xkLbbeZY6J6t6AezkjZlJZzXQlVoOEzWiFGcUrCtUF
	MkV+6hZVnrykUHFyy89FBR0o+kym3yK1t9GsN92JGAGSrBJ5kvxyMSlTq0oKnIgV4JJ4kbTV
	JxeLcmUlpbyy6KjyeD6vcqK1AkKyRpSRzUvFzC+yYj6P54/xys8uJohJKEOSjdlN4z9uzqq/
	vSLT8mfm0QsRbborsXtAt6+vwXrph6zXXx02lb664/ZuHtnv+27X6dXOqbnqcPK2L+6e2Dlh
	kZaMkb+GjU1DIwmlcYd+WnXL9q9vpeVFqCdBn3lRm3bRu6C2a8M5cY/bgn8z4cGBWOmRuNw5
	9ZeHilP3mgNp5vVaCaGSy7Z/gytVsk/TNWVUSAMAAA==
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
index 49f457390521..236e4f06e5c8 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -372,6 +372,13 @@ struct dept_wait_hist {
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
@@ -381,6 +388,7 @@ extern void dept_free_range(void *start, unsigned int sz);
 
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
+extern void dept_ext_wgen_init(struct dept_ext_wgen *ewg);
 extern void dept_map_copy(struct dept_map *to, struct dept_map *from);
 extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l, long timeout);
 extern void dept_stage_wait(struct dept_map *m, struct dept_key *k, unsigned long ip, const char *w_fn, long timeout);
@@ -389,8 +397,8 @@ extern void dept_clean_stage(void);
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
@@ -417,6 +425,7 @@ extern void dept_hardirqs_off(void);
 #else /* !CONFIG_DEPT */
 struct dept_key { };
 struct dept_map { };
+struct dept_ext_wgen { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
 
@@ -429,6 +438,7 @@ struct dept_map { };
 
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
+#define dept_ext_wgen_init(wg)				do { } while (0)
 #define dept_map_copy(t, f)				do { } while (0)
 #define dept_wait(m, w_f, ip, w_fn, sl, t)		do { (void)(w_fn); } while (0)
 #define dept_stage_wait(m, k, ip, w_fn, t)		do { (void)(k); (void)(w_fn); } while (0)
@@ -437,8 +447,8 @@ struct dept_map { };
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



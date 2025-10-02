Return-Path: <linux-fsdevel+bounces-63255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A105BB3291
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C9919E2635
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91DDF319873;
	Thu,  2 Oct 2025 08:14:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF3B3101A0;
	Thu,  2 Oct 2025 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392853; cv=none; b=mFFz93rDSoUqexqgXl7nBoV1fImog2ik/8aReYUEfZGZS3hq8GqVfUrhCsdrulzhS9AZRbej9OxrG8b8mFT1PBWc61AJDoUL73hxmCz7JkYmQ59d6EJf1f12tUFZjeVR2aNJCjZuQJFZGNtyYlz3xfFaD+yDYFmZifISF5JaqV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392853; c=relaxed/simple;
	bh=I8KhMEPIcr4A0f+7gTSN0AEZZc6Q1ueGuS41Fi5lLxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ujbuZGcd5BFpqR+Le8S5ByY4YBi0ukfD9bMAGjrberw42JYCfBcfFUoNMEfb7Zlm/fFsqt9x7wYfti4Em4JgECJ7tSHmwBVFHBbWaAwRiDPHYc7O54NnyfBC/N/GvrIwJQ6YI+TtELEXsasZ1g201PwWPN4KegVO+cjC0vFiOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-1a-68de3414a6e0
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
Subject: [PATCH v17 38/47] dept: introduce a new type of dependency tracking between multi event sites
Date: Thu,  2 Oct 2025 17:12:38 +0900
Message-Id: <20251002081247.51255-39-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe2yLexzG/d5r16zOq5bstVnQZCGLsTHydb9E4nVyznFLJCNBoy9t7JbW
	xsRl7GLnGKbOJlObzqxqq5gWsVGZsYnU2IzqWG21rjMdZdrNMNVO/PPNJ8/3eZ6/HgEubicj
	BIqUXbwyRZokoYSE8H1oeWxYwmt5XHvFNMg3lpDQ6ctHkFvrJ2BE3USDd/gVDX5zE4LiVjUO
	hmuHMPhc84MC970BBEUOJwWn+w4RcMaloaGvcSX47b0Y6Jw/MHDWH0FQ7rDjYNYfpqCn8DoO
	bc6x8MznoeBh0VEK3reexUB72ExCqUaNILviCgXFpUYCqo1/g6XwPBboDihXw0FzOhsLnLcY
	FF2+hcGwrooGXVY0aJrbSPjuiAe/NhWaqntpsJ8oIsDtUlPQ+SCPBO8zBwaGAhcO+XU+Aozd
	VhLK8y4QUFLWQcFt80MC8ke8CNrqzlLw2uAnIUszRMLT6hYCrvTaMHhSd5mEyhetGDi6bCSY
	mh/hMHg8Ek59cCHQ+Tz0Uhk3lHuc4KpMNzDOUGZA3LevasR5K7Nx7l6/B+cqLf0U99X3nOLM
	g1qCO9kcy9WesdNczp2XNKc1pnMmfQxXcbsP48oHfOSa2I3ChTI+SZHBK2cu3iqU13S202mn
	ZHtGLGosCx1b+x8KEbBMAltc4aZ+89DFUjrIFDOVtdmG8SCHMZNZ0zEXGWScsUxkra3Tgzye
	2c4a7vePZgkmmm0svD/qETFz2Y5rd7FfnZPY6pr60Z6QgN7msBBBFjNz2FxPTsAjDHjOhbCX
	hirJX4EJ7F29jShEIi0aU4XEipSMZKkiKWGGPDNFsWfGttRkIwoMTrf/+6abaKBlfQNiBEgS
	KmqJtsvFpDRDlZncgFgBLgkTbdV3yMUimTRzL69M3aJMT+JVDShSQEjCRbMGd8vEzA7pLn4n
	z6fxyt9fTBASkYXof3tv9o1JDk1816Pv2SnYMjPCWv//vNmZOUfiDvyVtyay4EPZi93Wg6bw
	9V2LHr+5uM9jWbEiXu6Nyp6viFKkljX+8XZeQUI3tejBEjq+5E/t0f3uDd7VDd+meLv/SZ+9
	fFzcgn3tn6iuOVejPmq/uFW11lXOxGWu7s3WmrTnJ9bJ82QSQiWXxsfgSpX0JyI5+DFsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+59zds4crQ5T6JDRZSRFqSV0ebGo6EMegsoKukOudmrDa5u3
	BYU6V5Jd1mqTnJYZLXNLly7JzPBSg1qWa91zmrLMSLPLpnhZayv68vJ73+fh4fnw8nFRA28m
	X56WySnSJCliUkAINq9Sx4Qv65YtdT2Jh9f5LQT4vEUElNVaSCiqu8SDzhozgh5fEYLRCSMO
	msYAAX6dnQLv2AcKAs12BAanDgeLLR+DX9bfJHxt/4lA3+shoeRLPgHDptMISvuNFHx5lABD
	PU08CLg/Y/BmZBCByfMbA0/LSQR+QzJcqawnYaLjOQ4l+k4EV3vdOAxYg6LN3o2guaqAhE/a
	Ozi4PNPgpW+YhMf6YhKGnGUYfLOSUFHQzINyow6B+lotCYbyOgIaP96jwPl1EoMugw4Dc90m
	6DH1E+DQVmLBfkHX7RlgLFFjwTGAgf5WEwZjpmoKnl7rIsCUFwXGDhcP+qpKKZjsjYNARTrY
	zZ8pcJ/TE1Az9Jy3To/YUc1Zgq2ub8BYzQs/yVouWxA7Ma5DrPe6Gmc12uDaPjiMs4X1Oex1
	xyDJjvtekWzzSAXBPqlk2PMdMWxjqZtiCx+8pxLj9whWS7kUeTanWLImSSCz9ryjMi5Ic/0O
	HZaHzmw9hcL4DL2MGb1RToWYpBcwb9+O4SGOoOcy9Wf6eSHGaccs5rUzOsTh9CHG8nCQDDFB
	RzGPtA//eoT0CqbL1or9y5zDmK0tf3PCgndXr4MIsYhezmiGCzEtElSgKdUoQp6WnSqRpyyP
	VSbLVGny3NiD6al1KPhNpmOT5+8iryuhDdF8JJ4qdEa5ZSKeJFupSm1DDB8XRwiTqrpkIqFU
	ojrKKdL3K7JSOGUbiuQT4hnCjTu5JBF9WJLJJXNcBqf4r2L8sJl5aH607dOBDG5yl2ef6mqM
	PF+iPbS9tUZu2238Xrxqx3TN2s6Vi4/PXq9ov7m0b/cWwa3Ip++OzO/b583RlR0d8Z3Iwi5e
	zvBbHmjM0sq9kS0/zN1byuPiZa3b3jetnb5hnkodXhBYkmjvKN77LFub0J640BLe4Jbq7q+M
	UY3P3T5iuCgmlDJJ3CJcoZT8AQHlUXlJAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

It's worth reporting wait-event circular dependency even if it doesn't
lead to an actual deadlock, because it's a good information about a
circular dependency anyway.  However, it should be suppressed once
turning out it doesn't lead an actual deadlock, for instance, there are
other wake-up(or event) paths.

The report needs to be suppressed by annotating that an event can be
recovered by other sites triggering the desired wake-up, using a newly
introduced API, dept_recover_event() specifying an event site and its
recover site.

By the introduction, need of a new type of dependency tracking arises
since a loop of recover dependency could trigger another type of
deadlock.  So implement a logic to track the new type of dependency
between multi event sites for a single wait.

Lastly, to make sure that recover sites must be used in code, introduce
a section '.dept.event_sites' to mark it as 'used' only if used in code,
and warn it if dept_recover_event()s are annotated with recover sites,
not used in code.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/asm-generic/vmlinux.lds.h |  13 +-
 include/linux/dept.h              |  91 ++++++++++++++
 kernel/dependency/dept.c          | 196 ++++++++++++++++++++++++++++++
 3 files changed, 299 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ae2d2359b79e..704bb47ed843 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -700,6 +700,16 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define KERNEL_CTORS()
 #endif
 
+#ifdef CONFIG_DEPT
+#define DEPT_EVNET_SITES_USED()						\
+	. = ALIGN(8);							\
+	__dept_event_sites_start = .;					\
+	KEEP(*(.dept.event_sites))					\
+	__dept_event_sites_end = .;
+#else
+#define DEPT_EVNET_SITES_USED()
+#endif
+
 /* init and exit section handling */
 #define INIT_DATA							\
 	KEEP(*(SORT(___kentry+*)))					\
@@ -724,7 +734,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 	EARLYCON_TABLE()						\
 	LSM_TABLE()							\
 	EARLY_LSM_TABLE()						\
-	KUNIT_INIT_TABLE()
+	KUNIT_INIT_TABLE()						\
+	DEPT_EVNET_SITES_USED()
 
 #define INIT_TEXT							\
 	*(.init.text .init.text.*)					\
diff --git a/include/linux/dept.h b/include/linux/dept.h
index b164f74e86e5..988aceee36ad 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -390,6 +390,82 @@ struct dept_ext_wgen {
 	unsigned int wgen;
 };
 
+struct dept_event_site {
+	/*
+	 * event site name
+	 */
+	const char			*name;
+
+	/*
+	 * function name where the event is triggered in
+	 */
+	const char			*func_name;
+
+	/*
+	 * for associating its recover dependencies
+	 */
+	struct list_head		dep_head;
+	struct list_head		dep_rev_head;
+
+	/*
+	 * for BFS
+	 */
+	unsigned int			bfs_gen;
+	struct dept_event_site		*bfs_parent;
+	struct list_head		bfs_node;
+
+	/*
+	 * flag indicating the event is not only declared but also
+	 * actually used in code
+	 */
+	bool				used;
+};
+
+struct dept_event_site_dep {
+	struct dept_event_site		*evt_site;
+	struct dept_event_site		*recover_site;
+
+	/*
+	 * for linking to dept_event objects
+	 */
+	struct list_head		dep_node;
+	struct list_head		dep_rev_node;
+};
+
+#define DEPT_EVENT_SITE_INITIALIZER(es)					\
+{									\
+	.name = #es,							\
+	.func_name = NULL,						\
+	.dep_head = LIST_HEAD_INIT((es).dep_head),			\
+	.dep_rev_head = LIST_HEAD_INIT((es).dep_rev_head),		\
+	.bfs_gen = 0,							\
+	.bfs_parent = NULL,						\
+	.bfs_node = LIST_HEAD_INIT((es).bfs_node),			\
+	.used = false,							\
+}
+
+#define DEPT_EVENT_SITE_DEP_INITIALIZER(esd)				\
+{									\
+	.evt_site = NULL,						\
+	.recover_site = NULL,						\
+	.dep_node = LIST_HEAD_INIT((esd).dep_node),			\
+	.dep_rev_node = LIST_HEAD_INIT((esd).dep_rev_node),		\
+}
+
+struct dept_event_site_init {
+	struct dept_event_site *evt_site;
+	const char *func_name;
+};
+
+#define dept_event_site_used(es)					\
+do {									\
+	static struct dept_event_site_init _evtinit __initdata =	\
+		{ .evt_site = (es), .func_name = __func__ };		\
+	static struct dept_event_site_init *_evtinitp __used		\
+		__attribute__((__section__(".dept.event_sites"))) =	\
+		&_evtinit;						\
+} while (0)
+
 extern void dept_stop_emerg(void);
 extern void dept_on(void);
 extern void dept_off(void);
@@ -427,6 +503,14 @@ static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 extern void dept_key_init(struct dept_key *k);
 extern void dept_key_destroy(struct dept_key *k);
 extern void dept_map_ecxt_modify(struct dept_map *m, unsigned long e_f, struct dept_key *new_k, unsigned long new_e_f, unsigned long new_ip, const char *new_c_fn, const char *new_e_fn, int new_sub_l);
+extern void __dept_recover_event(struct dept_event_site_dep *esd, struct dept_event_site *es, struct dept_event_site *rs);
+
+#define dept_recover_event(es, rs)					\
+do {									\
+	static struct dept_event_site_dep _esd = DEPT_EVENT_SITE_DEP_INITIALIZER(_esd);\
+									\
+	__dept_recover_event(&_esd, es, rs);				\
+} while (0)
 
 extern void dept_softirq_enter(void);
 extern void dept_hardirq_enter(void);
@@ -440,8 +524,10 @@ extern void dept_hardirqs_off(void);
 struct dept_key { };
 struct dept_map { };
 struct dept_ext_wgen { };
+struct dept_event_site { };
 
 #define DEPT_MAP_INITIALIZER(n, k) { }
+#define DEPT_EVENT_SITE_INITIALIZER(es) { }
 
 #define dept_stop_emerg()				do { } while (0)
 #define dept_on()					do { } while (0)
@@ -472,6 +558,7 @@ struct dept_ext_wgen { };
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
 #define dept_map_ecxt_modify(m, e_f, n_k, n_e_f, n_ip, n_c_fn, n_e_fn, n_sl) do { (void)(n_k); (void)(n_c_fn); (void)(n_e_fn); } while (0)
+#define dept_recover_event(es, rs)			do { } while (0)
 
 #define dept_softirq_enter()				do { } while (0)
 #define dept_hardirq_enter()				do { } while (0)
@@ -482,4 +569,8 @@ struct dept_ext_wgen { };
 
 #define dept_set_lockdep_map(m, lockdep_m)		do { } while (0)
 #endif
+
+#define DECLARE_DEPT_EVENT_SITE(es) extern struct dept_event_site (es)
+#define DEFINE_DEPT_EVENT_SITE(es) struct dept_event_site (es) = DEPT_EVENT_SITE_INITIALIZER(es)
+
 #endif /* __LINUX_DEPT_H */
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 1de61306418b..b14400c4f83b 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -973,6 +973,117 @@ static void bfs(void *root, struct bfs_ops *ops, void *in, void **out)
 	}
 }
 
+/*
+ * Recover dependency between event sites
+ * =====================================================================
+ * Even though an event is in a chain of wait-event circular dependency,
+ * the corresponding wait might be woken up by another site triggering
+ * the desired event.  To reflect that, dept allows to annotate the
+ * recover relationship between event sites using __dept_recover_event().
+ * However, that requires to track a new type of dependency between the
+ * event sites.
+ */
+
+/*
+ * Print all events in the circle.
+ */
+static void print_recover_circle(struct dept_event_site *es)
+{
+	struct dept_event_site *from = es->bfs_parent;
+	struct dept_event_site *to = es;
+
+	dept_outworld_enter();
+
+	pr_warn("===================================================\n");
+	pr_warn("DEPT: Circular recover dependency has been detected.\n");
+	pr_warn("%s %.*s %s\n", init_utsname()->release,
+		(int)strcspn(init_utsname()->version, " "),
+		init_utsname()->version,
+		print_tainted());
+	pr_warn("---------------------------------------------------\n");
+
+	do {
+		print_spc(1, "event site(%s@%s)\n", from->name, from->func_name);
+		print_spc(1, "-> event site(%s@%s)\n", to->name, to->func_name);
+		to = from;
+		from = from->bfs_parent;
+
+		if (to != es)
+			pr_warn("\n");
+	} while (to != es);
+
+	pr_warn("---------------------------------------------------\n");
+	pr_warn("information that might be helpful\n");
+	pr_warn("---------------------------------------------------\n");
+	dump_stack();
+
+	dept_outworld_exit();
+}
+
+static void bfs_init_recover(void *node, void *in, void **out)
+{
+	struct dept_event_site *root = (struct dept_event_site *)node;
+	struct dept_event_site_dep *new = (struct dept_event_site_dep *)in;
+
+	root->bfs_gen = bfs_gen;
+	new->recover_site->bfs_parent = new->evt_site;
+}
+
+static void bfs_extend_recover(struct list_head *h, void *node)
+{
+	struct dept_event_site *cur = (struct dept_event_site *)node;
+	struct dept_event_site_dep *esd;
+
+	list_for_each_entry(esd, &cur->dep_head, dep_node) {
+		struct dept_event_site *next = esd->recover_site;
+
+		if (bfs_gen == next->bfs_gen)
+			continue;
+		next->bfs_parent = cur;
+		next->bfs_gen = bfs_gen;
+		list_add_tail(&next->bfs_node, h);
+	}
+}
+
+static void *bfs_dequeue_recover(struct list_head *h)
+{
+	struct dept_event_site *es;
+
+	DEPT_WARN_ON(list_empty(h));
+
+	es = list_first_entry(h, struct dept_event_site, bfs_node);
+	list_del(&es->bfs_node);
+	return es;
+}
+
+static enum bfs_ret cb_check_recover_dl(void *node, void *in, void **out)
+{
+	struct dept_event_site *cur = (struct dept_event_site *)node;
+	struct dept_event_site_dep *new = (struct dept_event_site_dep *)in;
+
+	if (cur == new->evt_site) {
+		print_recover_circle(new->recover_site);
+		return BFS_DONE;
+	}
+
+	return BFS_CONTINUE;
+}
+
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void check_recover_dl_bfs(struct dept_event_site_dep *esd)
+{
+	struct bfs_ops ops = {
+		.bfs_init = bfs_init_recover,
+		.extend = bfs_extend_recover,
+		.dequeue = bfs_dequeue_recover,
+		.callback = cb_check_recover_dl,
+	};
+
+	bfs((void *)esd->recover_site, &ops, (void *)esd, NULL);
+}
+
 /*
  * Main operations
  * =====================================================================
@@ -3166,8 +3277,78 @@ static void migrate_per_cpu_pool(void)
 	}
 }
 
+static bool dept_recover_ready;
+
+void __dept_recover_event(struct dept_event_site_dep *esd,
+		struct dept_event_site *es, struct dept_event_site *rs)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (unlikely(!dept_working()))
+		return;
+
+	if (dt->recursive)
+		return;
+
+	if (!esd || !es || !rs) {
+		DEPT_WARN_ONCE("All the parameters should be !NULL.\n");
+		return;
+	}
+
+	/*
+	 * Check locklessly if another already has done it for us.
+	 */
+	if (READ_ONCE(esd->evt_site))
+		return;
+
+	if (!dept_recover_ready) {
+		DEPT_WARN("Should be called once dept_recover_ready.\n");
+		return;
+	}
+
+	flags = dept_enter();
+	if (unlikely(!dept_lock()))
+		goto exit;
+
+	/*
+	 * Check if another already has done it for us with lock held.
+	 */
+	if (esd->evt_site)
+		goto unlock;
+
+	/*
+	 * Can be used as an indicator of whether this
+	 * __dept_recover_event() has been processed or not as well as
+	 * for storing its associated events.
+	 */
+	WRITE_ONCE(esd->evt_site, es);
+	esd->recover_site = rs;
+
+	if (!es->used || !rs->used) {
+		if (!es->used)
+			DEPT_INFO("dept_event_site %s has never been used.\n", es->name);
+		if (!rs->used)
+			DEPT_INFO("dept_event_site %s has never been used.\n", rs->name);
+
+		DEPT_WARN("Cannot track recover dependency with events that never used.\n");
+		goto unlock;
+	}
+
+	list_add(&esd->dep_node, &es->dep_head);
+	list_add(&esd->dep_rev_node, &rs->dep_rev_head);
+	check_recover_dl_bfs(esd);
+unlock:
+	dept_unlock();
+exit:
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(__dept_recover_event);
+
 #define B2KB(B) ((B) / 1024)
 
+extern char __dept_event_sites_start[], __dept_event_sites_end[];
+
 /*
  * Should be called after setup_per_cpu_areas() and before no non-boot
  * CPUs have been on.
@@ -3175,6 +3356,21 @@ static void migrate_per_cpu_pool(void)
 void __init dept_init(void)
 {
 	size_t mem_total = 0;
+	struct dept_event_site_init **evtinitpp;
+
+	/*
+	 * dept recover dependency tracking works from now on.
+	 */
+	for (evtinitpp = (struct dept_event_site_init **)__dept_event_sites_start;
+	     evtinitpp < (struct dept_event_site_init **)__dept_event_sites_end;
+	     evtinitpp++) {
+		(*evtinitpp)->evt_site->used = true;
+		(*evtinitpp)->evt_site->func_name = (*evtinitpp)->func_name;
+		pr_info("dept_event %s@%s is initialized.\n",
+				(*evtinitpp)->evt_site->name,
+				(*evtinitpp)->evt_site->func_name);
+	}
+	dept_recover_ready = true;
 
 	local_irq_disable();
 	dept_per_cpu_ready = 1;
-- 
2.17.1



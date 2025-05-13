Return-Path: <linux-fsdevel+bounces-48874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F2BAB5257
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 12:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2461639CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A90E293721;
	Tue, 13 May 2025 10:08:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5DC28BA9F;
	Tue, 13 May 2025 10:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747130897; cv=none; b=YxIPBulYU6xhK7dSfcwF1Wv+DrGeJHt1FDoDeM0efXWXmXM4mmKkaUbB4lbumiBMCcPvKNf/AW7Xd82t4mqP2zPXtviWai5GlGXlrFyMxFNYMGJQfYch4Dg0y3nEDbDCWwFk6cAdB91iu3USzHIVG8+4mQvIFpNiDx3Wv7kxO9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747130897; c=relaxed/simple;
	bh=YJ8xcmEE39aGVby1qjH5lpQQhezUmf8G4pJR1ncXYyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tUVAwzQKzMyYzg0JCZtU+amFgpYRuqPVOKCkmYY9HenZ/B9W7NLMi8ImApw0gNRxNANOqelG2F/3yuk6VBg6Yzeazm5QjAqPALhPCBzLVbNmwqhTKddtHE+6PDv+mHMu2wpsd4AGpdxtNGlF1vHovcHXXzyJLKyARk0qlPhQal4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-3e-682319f3ed9d
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
	yskelg@gmail.com,
	yunseong.kim@ericsson.com,
	yeoreum.yun@arm.com,
	netdev@vger.kernel.org,
	matthew.brost@intel.com,
	her0gyugyu@gmail.com
Subject: [PATCH v15 40/43] dept: add module support for struct dept_event_site and dept_event_site_dep
Date: Tue, 13 May 2025 19:07:27 +0900
Message-Id: <20250513100730.12664-41-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513100730.12664-1-byungchul@sk.com>
References: <20250513100730.12664-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0wTaRSG+b6Z+WZaqU7qbfAS3W6IWY0oBM2JUWNM1MmuJsbVP7qbtVlG
	WwUkRRDWNbZaTK1AoAYRQS2gpSkVsXWzriuKmFbwgqhQwQAKUSJShKBtRIvYSvxz8uR9T57z
	53CU0sPM4rSp+yVdqjpZReS0fDC6fPH7mB81S/X66RD4YKKh7LKTQEtNNQLnVQOGfs8GeBb0
	I/j88BEFxUUtCMp7uii46u1GUGc/QuDpq8nQGhgi0FR0gsDRyssEHg+EMHSesmCodm2CF7Y+
	Gu4XVGAo7idQWnwUh8cbDKM2Bws2fSz02s+wEOqJh6ZuHwN1zxdByblOAjfqmmjwXuvF8PR6
	GYFu5zgD972NNATzZ0NLYR4Dl95VEBgI2iiwBYZYeFJvxeC1zoBaY1h47P0XBu7m1WM4duEK
	htaO/xHcNL3E4HL6CNwJ+DG4XUUUfKryIOjNH2QhJ3eUhVJDPoITOadoMHYug88fw5fPfogH
	w/laGi6N+dCaVaLznBOJd/xDlGh0HxA/BdqIWBe00uK9CkH870wXKxpvPmdFqytDdNsXipU3
	+rFYPhJgRJfjOBFdIxZWNA+2YvFdczO7ec52+cokKVmbKemWrN4p1+RaXqO0gfVZw9f7sB5d
	WGFGHCfwicLJkNKMZN/w4oiZRJjwC4T29lEqwtP4+YI7r48xIzlH8b5JwrOzHShSTOV3CaP5
	OSjioflY4a49JRIr+OVC43g9mXDOE6pr6795ZOF8rKqZjrCSXyYUWKvpiZ2TMmHIIZvgGOG2
	vZ0uQAorinIgpTY1M0WtTU6M02SnarPi/tyX4kLh57IdCu24hkZafm1APIdU0YrG/h80Skad
	mZ6d0oAEjlJNUxj+DUeKJHX2X5Ju3x+6jGQpvQHN5mjVTEVC8ECSkt+t3i/tlaQ0Sfe9xZxs
	lh5ZTD0H52ybqa15A3HOtVeKhxcXruqqhCVbFsSZ5m6bEt2gkP9Olfb84/eGosYyb3WfPkxq
	YrQbkwJvq3xR/KOSwlfjCQkbt/5t/G1P6BdTCT380/q3uPXnnQ+yovnXVUpPbprD7/McPLyj
	bbCtd53jcceR0nlukkXFxzJordFiUNHpGnX8QkqXrv4KHlBP3FgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSfUzMcRzHfX/PHWc/CT9hOGIyD5n0mTB/GD+P8x/zj275cbeu4k4phk5X
	y9GplCbiSl2nu5S7RuiSmh48JEqpJRVarYdruWuuB9wx/3z22uu9vd//fBjc+z7py8gjTgvK
	CKlCQokI0YHg+DWj85fJ1r8wBoHTkUTA7WIzBY0PTAjMpWoM+l/ugtaxQQQTb9/hkJnRiCCn
	+zMOpTWdCGzGSxQ0fZsJzU47BfUZVyiIv1dMwfuBSQw6bqRhYLLshy+GXgJep+RikNlPwa3M
	eMx9+jBwGQppMMT5QY8xi4bJ7gCo72whoTq7ngRb+2q4eaeDgnJbPQE1ZT0YND29TUGn+TcJ
	r2vqCBjTLYDG1GQSioZzKRgYM+BgcNpp+FCpx6BGPxdKNO7WxB+/SKhNrsQgMe8hBs1tzxBU
	JHVhYDG3UFDtHMTAasnAYbzgJYIe3RANCVddNNxS6xBcSbhBgKYjECZ+upezHQGgvltCQNFU
	C9q+jTffMSO+etCO8xrrGX7c+ZHibWN6gn+Vy/FPsj7TvKaineb1lijeavTn75X3Y3zOqJPk
	LYWXKd4ymkbz2qFmjB9uaKAPLjoi2nJMUMijBeW6bSEi2dW07+jkwM6Ykae9WBzK26xFXgzH
	buTyR7WUhyl2Jffpkwv3sA+7hLMm95JaJGJwtmU615rdhjzBbPY459IluJlhCNaPqzWGe7SY
	3cTV/a6k/nUu5kwllX97vNx+qqCB8LA3G8il6E1EChLp0bRC5COPiA6XyhWBa1VhstgIecza
	0MhwC3I/kOH8ZGoZcjTtqkIsgyQzxHX9S2XepDRaFRtehTgGl/iI1Y/dSnxMGntWUEYeVUYp
	BFUVWsAQknniPYeEEG/2hPS0ECYIJwXl/xRjvHzj0JyAnQX7inzLU8MmQjfagzaMH76YrrDO
	Lf8ic5nK8tl0bdaKqb0dMaeW78uoWOW/ZaGxseFCYXdQ7azi547oN4HD597aIp8cvJ8+gvuc
	tXU6er7bc/qCraF7Fs6RyKrXN83InpqXkLY96lXX9dYdWfHK3b46+6NSNd2leXNt60r/oq8S
	QiWTBvjjSpX0DziDbA08AwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

struct dept_event_site and struct dept_event_site_dep have been
introduced to track dependencies between multi event sites for a single
wait, that will be loaded to data segment.  Plus, a custom section,
'.dept.event_sites', also has been introduced to keep pointers to the
objects to make sure all the event sites defined exist in code.

dept should work with the section and segment of module.  Add the
support to handle the section and segment properly whenever modules are
loaded and unloaded.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     | 14 +++++++
 include/linux/module.h   |  5 +++
 kernel/dependency/dept.c | 79 +++++++++++++++++++++++++++++++++++-----
 kernel/module/main.c     | 15 ++++++++
 4 files changed, 103 insertions(+), 10 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index b933f9d98c69..a97f34d62468 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -419,6 +419,11 @@ struct dept_event_site {
 	struct dept_event_site		*bfs_parent;
 	struct list_head		bfs_node;
 
+	/*
+	 * for linking all dept_event_site's
+	 */
+	struct list_head		all_node;
+
 	/*
 	 * flag indicating the event is not only declared but also
 	 * actually used in code
@@ -435,6 +440,11 @@ struct dept_event_site_dep {
 	 */
 	struct list_head		dep_node;
 	struct list_head		dep_rev_node;
+
+	/*
+	 * for linking all dept_event_site_dep's
+	 */
+	struct list_head		all_node;
 };
 
 #define DEPT_EVENT_SITE_INITIALIZER(es)					\
@@ -446,6 +456,7 @@ struct dept_event_site_dep {
 	.bfs_gen = 0,							\
 	.bfs_parent = NULL,						\
 	.bfs_node = LIST_HEAD_INIT((es).bfs_node),			\
+	.all_node = LIST_HEAD_INIT((es).all_node),			\
 	.used = false,							\
 }
 
@@ -455,6 +466,7 @@ struct dept_event_site_dep {
 	.recover_site = NULL,						\
 	.dep_node = LIST_HEAD_INIT((esd).dep_node),			\
 	.dep_rev_node = LIST_HEAD_INIT((esd).dep_rev_node),		\
+	.all_node = LIST_HEAD_INIT((esd).all_node),			\
 }
 
 struct dept_event_site_init {
@@ -478,6 +490,7 @@ extern void dept_init(void);
 extern void dept_task_init(struct task_struct *t);
 extern void dept_task_exit(struct task_struct *t);
 extern void dept_free_range(void *start, unsigned int sz);
+extern void dept_mark_event_site_used(void *start, void *end);
 
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
@@ -541,6 +554,7 @@ struct dept_event_site { };
 #define dept_task_init(t)				do { } while (0)
 #define dept_task_exit(t)				do { } while (0)
 #define dept_free_range(s, sz)				do { } while (0)
+#define dept_mark_event_site_used(s, e)			do { } while (0)
 
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
diff --git a/include/linux/module.h b/include/linux/module.h
index b3329110d668..3da466a2c705 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -28,6 +28,7 @@
 #include <linux/srcu.h>
 #include <linux/static_call_types.h>
 #include <linux/dynamic_debug.h>
+#include <linux/dept.h>
 
 #include <linux/percpu.h>
 #include <asm/module.h>
@@ -599,6 +600,10 @@ struct module {
 #ifdef CONFIG_DYNAMIC_DEBUG_CORE
 	struct _ddebug_info dyndbg_info;
 #endif
+#ifdef CONFIG_DEPT
+	struct dept_event_site **dept_event_sites;
+	unsigned int num_dept_event_sites;
+#endif
 } ____cacheline_aligned __randomize_layout;
 #ifndef MODULE_ARCH_INIT
 #define MODULE_ARCH_INIT {}
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index b7167ce4f647..bd46c2ce84eb 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -990,6 +990,9 @@ static void bfs(void *root, struct bfs_ops *ops, void *in, void **out)
  * event sites.
  */
 
+static LIST_HEAD(dept_event_sites);
+static LIST_HEAD(dept_event_site_deps);
+
 /*
  * Print all events in the circle.
  */
@@ -2053,6 +2056,33 @@ static void del_dep_rcu(struct rcu_head *rh)
 	preempt_enable();
 }
 
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void disconnect_event_site_dep(struct dept_event_site_dep *esd)
+{
+	list_del_rcu(&esd->dep_node);
+	list_del_rcu(&esd->dep_rev_node);
+}
+
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void disconnect_event_site(struct dept_event_site *es)
+{
+	struct dept_event_site_dep *esd, *next_esd;
+
+	list_for_each_entry_safe(esd, next_esd, &es->dep_head, dep_node) {
+		list_del_rcu(&esd->dep_node);
+		list_del_rcu(&esd->dep_rev_node);
+	}
+
+	list_for_each_entry_safe(esd, next_esd, &es->dep_rev_head, dep_rev_node) {
+		list_del_rcu(&esd->dep_node);
+		list_del_rcu(&esd->dep_rev_node);
+	}
+}
+
 /*
  * NOTE: Must be called with dept_lock held.
  */
@@ -2396,6 +2426,8 @@ void dept_free_range(void *start, unsigned int sz)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_class *c, *n;
+	struct dept_event_site_dep *esd, *next_esd;
+	struct dept_event_site *es, *next_es;
 	unsigned long flags;
 
 	if (unlikely(!dept_working()))
@@ -2417,6 +2449,24 @@ void dept_free_range(void *start, unsigned int sz)
 	while (unlikely(!dept_lock()))
 		cpu_relax();
 
+	list_for_each_entry_safe(esd, next_esd, &dept_event_site_deps, all_node) {
+		if (!within((void *)esd, start, sz))
+			continue;
+
+		disconnect_event_site_dep(esd);
+		list_del(&esd->all_node);
+	}
+
+	list_for_each_entry_safe(es, next_es, &dept_event_sites, all_node) {
+		if (!within((void *)es, start, sz) &&
+		    !within(es->name, start, sz) &&
+		    !within(es->func_name, start, sz))
+			continue;
+
+		disconnect_event_site(es);
+		list_del(&es->all_node);
+	}
+
 	list_for_each_entry_safe(c, n, &dept_classes, all_node) {
 		if (!within((void *)c->key, start, sz) &&
 		    !within(c->name, start, sz))
@@ -3348,6 +3398,7 @@ void __dept_recover_event(struct dept_event_site_dep *esd,
 
 	list_add(&esd->dep_node, &es->dep_head);
 	list_add(&esd->dep_rev_node, &rs->dep_rev_head);
+	list_add(&esd->all_node, &dept_event_site_deps);
 	check_recover_dl_bfs(esd);
 unlock:
 	dept_unlock();
@@ -3358,6 +3409,23 @@ EXPORT_SYMBOL_GPL(__dept_recover_event);
 
 #define B2KB(B) ((B) / 1024)
 
+void dept_mark_event_site_used(void *start, void *end)
+{
+	struct dept_event_site_init **evtinitpp;
+
+	for (evtinitpp = (struct dept_event_site_init **)start;
+	     evtinitpp < (struct dept_event_site_init **)end;
+	     evtinitpp++) {
+		(*evtinitpp)->evt_site->used = true;
+		(*evtinitpp)->evt_site->func_name = (*evtinitpp)->func_name;
+		list_add(&(*evtinitpp)->evt_site->all_node, &dept_event_sites);
+
+		pr_info("dept_event_site %s@%s is initialized.\n",
+				(*evtinitpp)->evt_site->name,
+				(*evtinitpp)->evt_site->func_name);
+	}
+}
+
 extern char __dept_event_sites_start[], __dept_event_sites_end[];
 
 /*
@@ -3367,20 +3435,11 @@ extern char __dept_event_sites_start[], __dept_event_sites_end[];
 void __init dept_init(void)
 {
 	size_t mem_total = 0;
-	struct dept_event_site_init **evtinitpp;
 
 	/*
 	 * dept recover dependency tracking works from now on.
 	 */
-	for (evtinitpp = (struct dept_event_site_init **)__dept_event_sites_start;
-	     evtinitpp < (struct dept_event_site_init **)__dept_event_sites_end;
-	     evtinitpp++) {
-		(*evtinitpp)->evt_site->used = true;
-		(*evtinitpp)->evt_site->func_name = (*evtinitpp)->func_name;
-		pr_info("dept_event %s@%s is initialized.\n",
-				(*evtinitpp)->evt_site->name,
-				(*evtinitpp)->evt_site->func_name);
-	}
+	dept_mark_event_site_used(__dept_event_sites_start, __dept_event_sites_end);
 	dept_recover_ready = true;
 
 	local_irq_disable();
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 7e569e1b4db5..1c439ed8c9ed 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2611,6 +2611,11 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 						&mod->dyndbg_info.num_classes);
 #endif
 
+#ifdef CONFIG_DEPT
+	mod->dept_event_sites = section_objs(info, ".dept.event_sites",
+					sizeof(*mod->dept_event_sites),
+					&mod->num_dept_event_sites);
+#endif
 	return 0;
 }
 
@@ -3249,6 +3254,14 @@ static int early_mod_check(struct load_info *info, int flags)
 	return err;
 }
 
+static void dept_mark_event_site_used_module(struct module *mod)
+{
+#ifdef CONFIG_DEPT
+	dept_mark_event_site_used(mod->dept_event_sites,
+			     mod->dept_event_sites + mod->num_dept_event_sites);
+#endif
+}
+
 /*
  * Allocate and load the module: note that size of section 0 is always
  * zero, and we rely on this for optional sections.
@@ -3408,6 +3421,8 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	/* Done! */
 	trace_module_load(mod);
 
+	dept_mark_event_site_used_module(mod);
+
 	return do_init_module(mod);
 
  sysfs_cleanup:
-- 
2.17.1



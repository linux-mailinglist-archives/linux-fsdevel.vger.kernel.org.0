Return-Path: <linux-fsdevel+bounces-63227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DFBBB2E61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C3219E13FE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4292F261C;
	Thu,  2 Oct 2025 08:13:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AE72ECD15;
	Thu,  2 Oct 2025 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392814; cv=none; b=BAE34Yxalb1iGjmlxj7hgn7RnfvCLEmHMDGCe88CiITZmYYKOPnGqgjtoF/ENIIqdrcCfOt0qfh+9Ic3UXha+32GTQudZQ1TYPMnM/EKAFpnOUCONpk7GPSJbB4zQrArKRD+gsvmFZRD9qP1YwJ4irDU3FxwUxyO5QalYfrS+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392814; c=relaxed/simple;
	bh=SjTd6in43c2T2VBHFIlrcV7kqjLgusqBbEVt/0h3s8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NbMibFEf9JJJFeAdkh5MSo5rBEOYYFrjs6fnEYKm67CywRQQpTabkQFb6an/V7Q1FSynFk0qaF5/rd9DZgPRiFZUP30QlgQcKhCntfR5Ny3H825X0kck90qbb58kJa8aWdV5731dQZ5/fBmja2ELdOA2K6nPGYDAwZjONQ+qdYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-70-68de340d7a14
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
Subject: [PATCH v17 11/47] dept: add a mechanism to refill the internal memory pools on running out
Date: Thu,  2 Oct 2025 17:12:11 +0900
Message-Id: <20251002081247.51255-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUwTaRDHfXaf3ZaGmrUaXUSjqRoTFHxDM2eU8HE9z2iiflBzOaqstrEU
	0gqKCTnAVhtQRM4eQhGLL6ShPeSKGlEriNhIKtJSg4AtBcSiwWqiIKK8uNT4ZfLLzH/mP5mM
	mJS9ohaKVZpjvFajUMtpCZaEo6viZyf2Ktf6RqOhM68Jw+iIEUPFTTsNRkcZBZ5aG4LgqBHB
	2HczCYaGaQwj469EMO10IfjXW0KC/VYeAZ/rpmgYfvwJgal/kIbSd3kYykNmEYSD9ymYDgwR
	UD04RcD3tnYSqvoDJDit+TS8Kb5Ngm9wNrSaCmkIeysI+FBHgyXfScFlc4ngcNmBoaHvngi8
	wxME2Bw7IFgdwuAuvkoILjSYS08RQnhLgOm/+wQ8u+bHYG7zUTBgLRe2tKSDyzYkgsB5E4ba
	cDsFrb2dFAyHSmhwdD9BMPKinwD72RAJjtdCwdmzCqpOX8fwwNmKwXV3gICzdbcp6LVPU5Br
	HhMu0uSmoMPmwXBzqIsAt+spTk7lxgxFmKupv0Nwho5JmrNX2hFnKBbC4/cfSU5ff5y74X5P
	c84vFsxdaIvnGsoDIk7/sEfEWRyZnL4lTHH11jju2oN3xK64/ZItqbxalcVr1ySlSJT+0moq
	43nyicrKPlEuqt1QgKLELJPIXvhWRv7iosYxPMM0s5Lt6hqP5OcxS9n6cyFqhknGvYjt9K6e
	4bnMITbYVxPRY2YFW3Q9P8JSZhNrvNSGfs5cwtrqmiJzooS8r98d0ciYjazho54oQBJBUxrF
	NpZP0j8bYthH1i5cjKQWNKsGyVSarDSFSp2YoMzWqE4kHEpPcyDh5apzJg7cRZ88u5sRI0by
	aKlnRUApoxRZuuy0ZsSKSfk8aYrVr5RJUxXZJ3lt+l/aTDWva0axYixfIF3/5XiqjDmiOMYf
	5fkMXvurSoijFuaiw7orZW55jCvxsGE8/HCi8WByQeGU/88cH58VlB2I3bHT3yLTZ8RV3Phb
	4z33tcXq/b+7Mbg31rNs+3Jpy56L3UnqOUm9L43Bpwv+KQz3TM5KWZJDWzxnAkc3izL/GBhh
	Okzx84O7Y/ZM/XZEvtKwjSkcfnmm8+DvVxcv3bqv/RmXIMc6pWJdHKnVKX4AW0hLvG4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+93nXK0ua+GlomxgQW/L4lARQUW36P2EwnLopQ3ng60so0Cd
	o/WyudhWzmxpLXHLzGVlYomRUOZjWSm15RbLimaLcsnysabRP4fPOd8vXw6HI8DF98mpAkXG
	EV6VIVNKKSEh3LpSs0CU+EG+eEg/A97mNRIQ6tcRUHLHQYGu5goJHVV2BD0hHYKBQQsO2roI
	AcOGZhr6w+9piDQ0IzC5DDg47uVh8Kt6hIJvT38iMPr8FJi/5hEQtJ1HUNxroeHrsw3Q11NP
	QsTzGYOu3wEENv8IBv7G0wiGTWlwrcxJwWBrOw5mYweC6z4PDl+qo+K95g8IGiryKfikr8Wh
	0z8RXoeCFDw3nqOgz1WCwfdqCqz5DSRctRgQaMrvUGC6WkNAnfcRDa5vQxi4TQYM7DVboMfW
	S0CLvgyL7hd13Y0Fi1mDRcsXDIy36zEI2yppeFnuJsCWGw+W1k4SPlYU0zDkS4CINROa7Z9p
	8Fw0ElDV106uMSJuQFtIcJXO+xinfTVMcY5SB+IG/xgQ139Tg3NafbR9GgjiXIHzGHezJUBx
	f0JvKK7ht5XgXpSxXFHrAq6u2ENzBY/f0dtX7BeuSuWVimxetWh1slDuNtvIrLY1x0tLvXQu
	qlp6FsUIWCaRLXwyQIwyxcxhu7vD+ChLmDjWeaGXHGWcaZnOvnXNH+XJTArb460c8xNMPFt4
	I3+MRcxyVne5Ff3LnMnaqxvHcmKi805fy5hHzCxjtcECTI+EVjSuEkkUGdnpMoVy2UJ1mjwn
	Q3F8YUpmeg2KfpPt1FDRQ9TfuaEJMQIknSByxXvkYlKWrc5Jb0KsAJdKRMkVbrlYlCrLOcGr
	Mg+pjip5dROaJiCksaJN+/hkMXNYdoRP4/ksXvVfxQQxU3NReWP8bklS98m68TPYHzbvvEkP
	qIM/TL4Br1O3dySSVHu0rX27Cm1+lKpUECn711XEbavautJxMSAMdu2Z5ExcS58J7RqXlFgi
	qU+Ju7VYY3cFzjgP9glF1uwDr2a1Lynv8u7cO/8s7Ag/KDLv88tvbLz83LM+emF3eHbtpSmZ
	bVJCLZclzMVVatlfqPDPkUkDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

dept engine works in a constrained environment.  For example, dept
cannot make use of dynamic allocation e.g. kmalloc().  So dept has been
using static pools to keep memory chunks dept uses.

However, dept would barely work once any of the pools gets run out.  So
implemented a mechanism for the refill on the lack, using irq work and
workqueue that fits on the contrained environment.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/dependency/dept.c          | 108 +++++++++++++++++++++++++-----
 kernel/dependency/dept_internal.h |  19 ++++--
 kernel/dependency/dept_object.h   |  10 +--
 kernel/dependency/dept_proc.c     |   8 +--
 4 files changed, 116 insertions(+), 29 deletions(-)

diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 953e1b81a81f..1b16a6095b3c 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -75,6 +75,9 @@
 #include <linux/dept.h>
 #include <linux/utsname.h>
 #include <linux/kernel.h>
+#include <linux/workqueue.h>
+#include <linux/irq_work.h>
+#include <linux/vmalloc.h>
 #include "dept_internal.h"
 
 static int dept_stop;
@@ -143,9 +146,11 @@ static inline struct dept_task *dept_task(void)
 		}							\
 	})
 
-#define DEPT_INFO_ONCE(s...) pr_warn_once("DEPT_INFO_ONCE: " s)
+#define DEPT_INFO_ONCE(s...)	pr_warn_once("DEPT_INFO_ONCE: " s)
+#define DEPT_INFO(s...)		pr_warn("DEPT_INFO: " s)
 
 static arch_spinlock_t dept_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static arch_spinlock_t dept_pool_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 
 /*
  * DEPT internal engine should be cautious in using outside functions
@@ -268,6 +273,7 @@ static bool valid_key(struct dept_key *k)
 
 #define OBJECT(id, nr)							\
 static struct dept_##id spool_##id[nr];					\
+static struct dept_##id rpool_##id[nr];					\
 static DEFINE_PER_CPU(struct llist_head, lpool_##id);
 	#include "dept_object.h"
 #undef OBJECT
@@ -276,14 +282,74 @@ struct dept_pool dept_pool[OBJECT_NR] = {
 #define OBJECT(id, nr) {						\
 	.name = #id,							\
 	.obj_sz = sizeof(struct dept_##id),				\
-	.obj_nr = ATOMIC_INIT(nr),					\
+	.obj_nr = nr,							\
+	.tot_nr = nr,							\
+	.acc_sz = ATOMIC_INIT(sizeof(spool_##id) + sizeof(rpool_##id)), \
 	.node_off = offsetof(struct dept_##id, pool_node),		\
 	.spool = spool_##id,						\
+	.rpool = rpool_##id,						\
 	.lpool = &lpool_##id, },
 	#include "dept_object.h"
 #undef OBJECT
 };
 
+static void dept_wq_work_fn(struct work_struct *work)
+{
+	int i;
+
+	for (i = 0; i < OBJECT_NR; i++) {
+		struct dept_pool *p = dept_pool + i;
+		int sz = p->tot_nr * p->obj_sz;
+		void *rpool;
+		bool need;
+
+		local_irq_disable();
+		arch_spin_lock(&dept_pool_spin);
+		need = !p->rpool;
+		arch_spin_unlock(&dept_pool_spin);
+		local_irq_enable();
+
+		if (!need)
+			continue;
+
+		rpool = vmalloc(sz);
+
+		if (!rpool) {
+			DEPT_STOP("Failed to extend internal resources.\n");
+			break;
+		}
+
+		local_irq_disable();
+		arch_spin_lock(&dept_pool_spin);
+		if (!p->rpool) {
+			p->rpool = rpool;
+			rpool = NULL;
+			atomic_add(sz, &p->acc_sz);
+		}
+		arch_spin_unlock(&dept_pool_spin);
+		local_irq_enable();
+
+		if (rpool)
+			vfree(rpool);
+		else
+			DEPT_INFO("Dept object(%s) just got refilled successfully.\n", p->name);
+	}
+}
+
+static DECLARE_WORK(dept_wq_work, dept_wq_work_fn);
+
+static void dept_irq_work_fn(struct irq_work *w)
+{
+	schedule_work(&dept_wq_work);
+}
+
+static DEFINE_IRQ_WORK(dept_irq_work, dept_irq_work_fn);
+
+static void request_rpool_refill(void)
+{
+	irq_work_queue(&dept_irq_work);
+}
+
 /*
  * Can use llist no matter whether CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG is
  * enabled or not because NMI and other contexts in the same CPU never
@@ -319,19 +385,31 @@ static void *from_pool(enum object_t t)
 	/*
 	 * Try static pool.
 	 */
-	if (atomic_read(&p->obj_nr) > 0) {
-		int idx = atomic_dec_return(&p->obj_nr);
+	arch_spin_lock(&dept_pool_spin);
+
+	if (!p->obj_nr) {
+		p->spool = p->rpool;
+		p->obj_nr = p->rpool ? p->tot_nr : 0;
+		p->rpool = NULL;
+		request_rpool_refill();
+	}
+
+	if (p->obj_nr) {
+		void *ret;
+
+		p->obj_nr--;
+		ret = p->spool + (p->obj_nr * p->obj_sz);
+		arch_spin_unlock(&dept_pool_spin);
 
-		if (idx >= 0)
-			return p->spool + (idx * p->obj_sz);
+		return ret;
 	}
+	arch_spin_unlock(&dept_pool_spin);
 
-	DEPT_INFO_ONCE("---------------------------------------------\n"
-		"  Some of Dept internal resources are run out.\n"
-		"  Dept might still work if the resources get freed.\n"
-		"  However, the chances are Dept will suffer from\n"
-		"  the lack from now. Needs to extend the internal\n"
-		"  resource pools. Ask max.byungchul.park@gmail.com\n");
+	DEPT_INFO("------------------------------------------\n"
+		"  Dept object(%s) is run out.\n"
+		"  Dept is trying to refill the object.\n"
+		"  Nevertheless, if it fails, Dept will stop.\n",
+		p->name);
 	return NULL;
 }
 
@@ -2957,8 +3035,8 @@ void __init dept_init(void)
 	pr_info("... DEPT_MAX_ECXT_HELD  : %d\n", DEPT_MAX_ECXT_HELD);
 	pr_info("... DEPT_MAX_SUBCLASSES : %d\n", DEPT_MAX_SUBCLASSES);
 #define OBJECT(id, nr)							\
-	pr_info("... memory used by %s: %zu KB\n",			\
-	       #id, B2KB(sizeof(struct dept_##id) * nr));
+	pr_info("... memory initially used by %s: %zu KB\n",		\
+	       #id, B2KB(sizeof(spool_##id) + sizeof(rpool_##id)));
 	#include "dept_object.h"
 #undef OBJECT
 #define HASH(id, bits)							\
@@ -2966,6 +3044,6 @@ void __init dept_init(void)
 	       #id, B2KB(sizeof(struct hlist_head) * (1 << (bits))));
 	#include "dept_hash.h"
 #undef HASH
-	pr_info("... total memory used by objects and hashs: %zu KB\n", B2KB(mem_total));
+	pr_info("... total memory initially used by objects and hashs: %zu KB\n", B2KB(mem_total));
 	pr_info("... per task memory footprint: %zu bytes\n", sizeof(struct dept_task));
 }
diff --git a/kernel/dependency/dept_internal.h b/kernel/dependency/dept_internal.h
index 6b39e5a2a830..b2a44632ee4d 100644
--- a/kernel/dependency/dept_internal.h
+++ b/kernel/dependency/dept_internal.h
@@ -23,9 +23,19 @@ struct dept_pool {
 	size_t				obj_sz;
 
 	/*
-	 * the number of the static array
+	 * the remaining number of the object in spool
 	 */
-	atomic_t			obj_nr;
+	int				obj_nr;
+
+	/*
+	 * the number of the object in spool
+	 */
+	int				tot_nr;
+
+	/*
+	 * accumulated amount of memory used by the object in byte
+	 */
+	atomic_t			acc_sz;
 
 	/*
 	 * offset of ->pool_node
@@ -35,9 +45,10 @@ struct dept_pool {
 	/*
 	 * pointer to the pool
 	 */
-	void				*spool;
+	void				*spool; /* static pool */
+	void				*rpool; /* reserved pool */
 	struct llist_head		boot_pool;
-	struct llist_head __percpu	*lpool;
+	struct llist_head __percpu	*lpool; /* local pool */
 };
 
 enum object_t {
diff --git a/kernel/dependency/dept_object.h b/kernel/dependency/dept_object.h
index 0b7eb16fe9fb..4f936adfa8ee 100644
--- a/kernel/dependency/dept_object.h
+++ b/kernel/dependency/dept_object.h
@@ -6,8 +6,8 @@
  * nr: # of the object that should be kept in the pool.
  */
 
-OBJECT(dep, 1024 * 8)
-OBJECT(class, 1024 * 8)
-OBJECT(stack, 1024 * 32)
-OBJECT(ecxt, 1024 * 16)
-OBJECT(wait, 1024 * 32)
+OBJECT(dep, 1024 * 4 * 2)
+OBJECT(class, 1024 * 4)
+OBJECT(stack, 1024 * 4 * 8)
+OBJECT(ecxt, 1024 * 4 * 2)
+OBJECT(wait, 1024 * 4 * 4)
diff --git a/kernel/dependency/dept_proc.c b/kernel/dependency/dept_proc.c
index 97beaf397715..f28992834588 100644
--- a/kernel/dependency/dept_proc.c
+++ b/kernel/dependency/dept_proc.c
@@ -74,12 +74,10 @@ static int dept_stats_show(struct seq_file *m, void *v)
 {
 	int r;
 
-	seq_puts(m, "Availability in the static pools:\n\n");
+	seq_puts(m, "Accumulated amount of memory used by pools:\n\n");
 #define OBJECT(id, nr)							\
-	r = atomic_read(&dept_pool[OBJECT_##id].obj_nr);		\
-	if (r < 0)							\
-		r = 0;							\
-	seq_printf(m, "%s\t%d/%d(%d%%)\n", #id, r, nr, (r * 100) / (nr));
+	r = atomic_read(&dept_pool[OBJECT_##id].acc_sz);		\
+	seq_printf(m, "%s\t%d KB\n", #id, r / 1024);
 	#include "dept_object.h"
 #undef  OBJECT
 
-- 
2.17.1



Return-Path: <linux-fsdevel+bounces-63254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE48BB3311
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDB64C8450
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E57A30EF9D;
	Thu,  2 Oct 2025 08:14:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC4431197E;
	Thu,  2 Oct 2025 08:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392852; cv=none; b=OH7lnxyBnprPXsnMvhlfsteSvSHYyqNHKqBE1MGqkXDib06tIqgGjfSijC2IrA3jdaeZH9JeLj6kr/UkRZhXWcmFKs2Mu89cyKQ+N751j6srQ5s5hlNX3daHmxTW/oaCsN2k1LTZ4RTurul/Mg1hb5SlhrBjcPw6CLxVoeijoKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392852; c=relaxed/simple;
	bh=MeohuwxKUYc7+9vQ4C+fi0LgjnyII/mMP+jCKZDgHoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=A9dPrtGJTP1ec3N5lmP1JXbXefcV+5aJtxMbCXq43D2B9pQICoY9GIyyHl7rpMELpfDXGJk3FK0HST0aYlcRtHF4dYFqjhnx7Ve+TvFdMRj390izrK+v+7zM87EjV41Qugqek4G5unWDi6/QXjR5U6N63Nimyz0NLtbpeCR13Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-78-68de3414d1c2
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
Subject: [PATCH v17 41/47] dept: implement a basic unit test for dept
Date: Thu,  2 Oct 2025 17:12:41 +0900
Message-Id: <20251002081247.51255-42-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe2xLcRTH/e6rd7XKVRPXvDsL5jUyHPGIBHGFPwQhGbE1dqPNuofuYZOQ
	LtZ5ZVhYy+qxsVV1E9YSQ2VTNptZtEEt6EZNN9FiVZ1pjZb45+ST7zmfc/45NC4uJWNpeWYu
	r8yUKiSUkBB6o6tmj07qkiX67NHgKGoi4Lv/EAEDQR0O6tu/CfAPvhZA3Y0iDLQfiwiocOsE
	8DLgQfBLkw4XLpop0JbbENxo6ULQVn6UAvunEAbdejcRFijQaQ9gMKg3CqD7UQkJ917NBMu9
	NgIO/fIjaGlwYaDSDZDQVnGFgKd3rpJg7niCg62slISTn90I3C9KMPBVBwgo+TZEwsG+uxSU
	VNdj8PDaLQxqDF4STHUOCnorzmHw4LsHg5+XmxG4jnkF4DsXNo6qNeFrDwM43GweEEDwx1kK
	/LVGakUiV3e+DnHqE+FSbN7D1bR7KO7xRZa7XeEUcJWmPM5sSOAuWT5inMl4mOKqgn0498Zh
	objW00GC63muxbgqVTnO9X94RWyISRYuTeMV8nxeOXd5qlD2/KBLkH1qTYHNY6FUqHnJERRF
	s0wS2xDyCP5z2Sk3HmGKmcZ2dg7+5RhmMmsudZMRxpn28azDPivCo5jVbM9Pb9ilaYKJZ73d
	KyOxiFnIuobOkP9WTmJrrzf9XRMVzp+9ayciLGYWsOovxdgRJAzP1EaxBqcK/RPGsvcNncQJ
	JKpEw4xILM/Mz5DKFUlzZIWZ8oI5O7MyTCj8JPp9oW0NyGfbZEUMjSTRIlu8UyYmpfk5hRlW
	xNK4JEaUangjE4vSpIV7eWVWijJPwedY0TiakIwRzQ/sSRMzu6S5fDrPZ/PK/12MjopVobUz
	Gp1xX0KLQptn3nm7JX7isN74RT/Sl7Z1bX2avjHFsL0ppkxn7eif4m+dcJ9nvtbo49Yla6zF
	x6dVGnd0aYTLWvbn2sem0CcnuPQdEz1TuerpqxJFG/JdvuHHkwre00OLLSPtI8uWx42o12qU
	6zt3O8S9Vt+nr6l+db2isfV6roTIkUnnJeDKHOkfaBiaayADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxTG93/vdFbfVBJfYcatCc4sgpKgnpRpSBbGuyUz84OpwWyjkVfb
	UMC0gGCyDSyNDNkGnQWhXgqEjlCmXREVtYpcmiig1KISoWCxVm4Vo1TD3dZlX05+53lOnjwf
	DoNLWskoRpWVI2iyFGopJSJEexJ1sZEJI8pt5/7eBI+K2gkIzpYQcOZiMwUl9moS+i9YEYwG
	SxC8WzDhoG9bIWDJ4KRhdm6IhhWHE0Gly4BD86UiDN7YlimY6nyNwOj1UVA1UUTAjKUMQY3f
	RMNEdwoERq+TsOJ5gcHjt9MILL5lDHztJxAsVWbA+boWChb67uNQZexHUOv14DBuC5mXnCMI
	HI3HKXhe3oqD27caBoIzFNwxnqQg4DqDwUsbBebjDhLOmgwIdPUXKag8ayeg7ek1GlxTixgM
	VxowsNq/g1GLn4Ce8jos1C909e86MFXpsNAYx8D4z3UM5ixNNPTWDxNgKYwBU5+bhLHGGhoW
	vfGwYs4Gp/UFDZ4/jQRcCNwnk4yIf6f/g+CbWi5jvP7BEsU3n2tG/MK8AfGzDTqc15eH1s7p
	GZwvbjnKN/RMU/x88CHFO96aCf5uHcdX9MXybTUemi+++YT+XpYq+jJdUKvyBM3W3Wki5cCJ
	MfrIqZT8/ukbVCHqTixFEQzHJnAVp/x4mCn2c25wcO4DR7Kfci2/+8kw42zPJ9wj15Ywr2WT
	Od98gC5FDEOwMVxg9KuwLGZ3cGPL1eR/kRs5q639Q0xESHd7e4gwS9jtnH6mGCtHIjP6qAlF
	qrLyMhUq9fY4bYayIEuVH3cwO9OOQs9k+Xmx4iqadad0IJZB0lViV4xHKSEVedqCzA7EMbg0
	UpzWOKyUiNMVBccETfZPmly1oO1A0QwhXSf+Vi6kSdjDihwhQxCOCJr/XYyJiCpEubJffm3f
	/NtkF8h3x97xynpLac221P2bFw17T8uGfliz45Z7fWfr7T3UePrO3isVDidLDKXmPzt/71VS
	8ONDth+rd61O6JRtralSl3Ul1xbK36wflPuiJxW5ZZ+d3qc71nfAbo3+2rhRkyNOH/tGHjcS
	58nsmBpwxPsb2KYDf4k2SAmtUhH/Ba7RKt4Dd+Nw7EgDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Implement CONFIG_DEPT_UNIT_TEST introducing a kernel module that runs
basic unit test for dept.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_unit_test.h     |  67 +++++++++++
 kernel/dependency/Makefile         |   1 +
 kernel/dependency/dept.c           |  12 ++
 kernel/dependency/dept_unit_test.c | 173 +++++++++++++++++++++++++++++
 lib/Kconfig.debug                  |  12 ++
 5 files changed, 265 insertions(+)
 create mode 100644 include/linux/dept_unit_test.h
 create mode 100644 kernel/dependency/dept_unit_test.c

diff --git a/include/linux/dept_unit_test.h b/include/linux/dept_unit_test.h
new file mode 100644
index 000000000000..7612b4e97e69
--- /dev/null
+++ b/include/linux/dept_unit_test.h
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DEPT unit test
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2025 SK hynix, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_UNIT_TEST_H
+#define __LINUX_DEPT_UNIT_TEST_H
+
+#if defined(CONFIG_DEPT_UNIT_TEST) || defined(CONFIG_DEPT_UNIT_TEST_MODULE)
+struct dept_ut {
+	bool circle_detected;
+	bool recover_circle_detected;
+
+	int ecxt_stack_total_cnt;
+	int wait_stack_total_cnt;
+	int evnt_stack_total_cnt;
+	int ecxt_stack_valid_cnt;
+	int wait_stack_valid_cnt;
+	int evnt_stack_valid_cnt;
+};
+
+extern struct dept_ut dept_ut_results;
+
+static inline void dept_ut_circle_detect(void)
+{
+	dept_ut_results.circle_detected = true;
+}
+static inline void dept_ut_recover_circle_detect(void)
+{
+	dept_ut_results.recover_circle_detected = true;
+}
+static inline void dept_ut_ecxt_stack_account(bool valid)
+{
+	dept_ut_results.ecxt_stack_total_cnt++;
+
+	if (valid)
+		dept_ut_results.ecxt_stack_valid_cnt++;
+}
+static inline void dept_ut_wait_stack_account(bool valid)
+{
+	dept_ut_results.wait_stack_total_cnt++;
+
+	if (valid)
+		dept_ut_results.wait_stack_valid_cnt++;
+}
+static inline void dept_ut_evnt_stack_account(bool valid)
+{
+	dept_ut_results.evnt_stack_total_cnt++;
+
+	if (valid)
+		dept_ut_results.evnt_stack_valid_cnt++;
+}
+#else
+struct dept_ut {};
+
+#define dept_ut_circle_detect() do { } while (0)
+#define dept_ut_recover_circle_detect() do { } while (0)
+#define dept_ut_ecxt_stack_account(v) do { } while (0)
+#define dept_ut_wait_stack_account(v) do { } while (0)
+#define dept_ut_evnt_stack_account(v) do { } while (0)
+
+#endif
+#endif /* __LINUX_DEPT_UNIT_TEST_H */
diff --git a/kernel/dependency/Makefile b/kernel/dependency/Makefile
index 92f165400187..fc584ca87124 100644
--- a/kernel/dependency/Makefile
+++ b/kernel/dependency/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_DEPT) += dept.o
 obj-$(CONFIG_DEPT) += dept_proc.o
+obj-$(CONFIG_DEPT_UNIT_TEST) += dept_unit_test.o
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 3c3ec2701bd6..0f4464657288 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -78,8 +78,12 @@
 #include <linux/workqueue.h>
 #include <linux/irq_work.h>
 #include <linux/vmalloc.h>
+#include <linux/dept_unit_test.h>
 #include "dept_internal.h"
 
+struct dept_ut dept_ut_results;
+EXPORT_SYMBOL_GPL(dept_ut_results);
+
 static int dept_stop;
 static int dept_per_cpu_ready;
 
@@ -826,6 +830,10 @@ static void print_dep(struct dept_dep *d)
 			pr_warn("(wait to wake up)\n");
 			print_ip_stack(0, e->ewait_stack);
 		}
+
+		dept_ut_ecxt_stack_account(valid_stack(e->ecxt_stack));
+		dept_ut_wait_stack_account(valid_stack(w->wait_stack));
+		dept_ut_evnt_stack_account(valid_stack(e->event_stack));
 	}
 }
 
@@ -920,6 +928,8 @@ static void print_circle(struct dept_class *c)
 	dump_stack();
 
 	dept_outworld_exit();
+
+	dept_ut_circle_detect();
 }
 
 /*
@@ -1021,6 +1031,8 @@ static void print_recover_circle(struct dept_event_site *es)
 	dump_stack();
 
 	dept_outworld_exit();
+
+	dept_ut_recover_circle_detect();
 }
 
 static void bfs_init_recover(void *node, void *in, void **out)
diff --git a/kernel/dependency/dept_unit_test.c b/kernel/dependency/dept_unit_test.c
new file mode 100644
index 000000000000..88e846b9f876
--- /dev/null
+++ b/kernel/dependency/dept_unit_test.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DEPT unit test
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2025 SK hynix, Inc., Byungchul Park
+ */
+
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/dept.h>
+#include <linux/dept_unit_test.h>
+
+MODULE_DESCRIPTION("DEPT unit test");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Byungchul Park <max.byungchul.park@sk.com>");
+
+struct unit {
+	const char *name;
+	bool (*func)(void);
+	bool result;
+};
+
+static DEFINE_SPINLOCK(s1);
+static DEFINE_SPINLOCK(s2);
+static bool test_spin_lock_deadlock(void)
+{
+	dept_ut_results.circle_detected = false;
+
+	spin_lock(&s1);
+	spin_lock(&s2);
+	spin_unlock(&s2);
+	spin_unlock(&s1);
+
+	spin_lock(&s2);
+	spin_lock(&s1);
+	spin_unlock(&s1);
+	spin_unlock(&s2);
+
+	return dept_ut_results.circle_detected;
+}
+
+static DEFINE_MUTEX(m1);
+static DEFINE_MUTEX(m2);
+static bool test_mutex_lock_deadlock(void)
+{
+	dept_ut_results.circle_detected = false;
+
+	mutex_lock(&m1);
+	mutex_lock(&m2);
+	mutex_unlock(&m2);
+	mutex_unlock(&m1);
+
+	mutex_lock(&m2);
+	mutex_lock(&m1);
+	mutex_unlock(&m1);
+	mutex_unlock(&m2);
+
+	return dept_ut_results.circle_detected;
+}
+
+static bool test_wait_event_deadlock(void)
+{
+	struct dept_map dmap1;
+	struct dept_map dmap2;
+
+	sdt_map_init(&dmap1);
+	sdt_map_init(&dmap2);
+
+	dept_ut_results.circle_detected = false;
+
+	sdt_request_event(&dmap1); /* [S] */
+	sdt_wait(&dmap2); /* [W] */
+	sdt_event(&dmap1); /* [E] */
+
+	sdt_request_event(&dmap2); /* [S] */
+	sdt_wait(&dmap1); /* [W] */
+	sdt_event(&dmap2); /* [E] */
+
+	return dept_ut_results.circle_detected;
+}
+
+static void dummy_event(void)
+{
+	/* Do nothing. */
+}
+
+static DEFINE_DEPT_EVENT_SITE(es1);
+static DEFINE_DEPT_EVENT_SITE(es2);
+static bool test_recover_deadlock(void)
+{
+	dept_ut_results.recover_circle_detected = false;
+
+	dept_recover_event(&es1, &es2);
+	dept_recover_event(&es2, &es1);
+
+	event_site(&es1, dummy_event);
+	event_site(&es2, dummy_event);
+
+	return dept_ut_results.recover_circle_detected;
+}
+
+static struct unit units[] = {
+	{
+		.name = "spin lock deadlock test",
+		.func = test_spin_lock_deadlock,
+	},
+	{
+		.name = "mutex lock deadlock test",
+		.func = test_mutex_lock_deadlock,
+	},
+	{
+		.name = "wait event deadlock test",
+		.func = test_wait_event_deadlock,
+	},
+	{
+		.name = "event recover deadlock test",
+		.func = test_recover_deadlock,
+	},
+};
+
+static int __init dept_ut_init(void)
+{
+	int i;
+
+	lockdep_off();
+
+	dept_ut_results.ecxt_stack_valid_cnt = 0;
+	dept_ut_results.ecxt_stack_total_cnt = 0;
+	dept_ut_results.wait_stack_valid_cnt = 0;
+	dept_ut_results.wait_stack_total_cnt = 0;
+	dept_ut_results.evnt_stack_valid_cnt = 0;
+	dept_ut_results.evnt_stack_total_cnt = 0;
+
+	for (i = 0; i < ARRAY_SIZE(units); i++)
+		units[i].result = units[i].func();
+
+	pr_info("\n");
+	pr_info("******************************************\n");
+	pr_info("DEPT unit test results\n");
+	pr_info("******************************************\n");
+	for (i = 0; i < ARRAY_SIZE(units); i++) {
+		pr_info("(%s) %s\n", units[i].result ? "pass" : "fail",
+				units[i].name);
+	}
+	pr_info("ecxt stack valid count = %d/%d\n",
+			dept_ut_results.ecxt_stack_valid_cnt,
+			dept_ut_results.ecxt_stack_total_cnt);
+	pr_info("wait stack valid count = %d/%d\n",
+			dept_ut_results.wait_stack_valid_cnt,
+			dept_ut_results.wait_stack_total_cnt);
+	pr_info("event stack valid count = %d/%d\n",
+			dept_ut_results.evnt_stack_valid_cnt,
+			dept_ut_results.evnt_stack_total_cnt);
+	pr_info("******************************************\n");
+	pr_info("\n");
+
+	lockdep_on();
+
+	return 0;
+}
+
+static void dept_ut_cleanup(void)
+{
+	/*
+	 * Do nothing for now.
+	 */
+}
+
+module_init(dept_ut_init);
+module_exit(dept_ut_cleanup);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 290563fa8b58..f0c58bee263a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1404,6 +1404,18 @@ config DEPT_AGGRESSIVE_TIMEOUT_WAIT
 	  that timeout is used to avoid a deadlock. Say N if you'd like
 	  to avoid verbose reports.
 
+config DEPT_UNIT_TEST
+	tristate "unit test for DEPT"
+	depends on DEBUG_KERNEL && DEPT
+	default n
+	help
+	  This option provides a kernel module that runs unit test for
+	  DEPT.
+
+	  Say Y if you want DEPT unit test to be built into the kernel.
+	  Say M if you want DEPT unit test to build as a module.
+	  Say N if you are unsure.
+
 config LOCK_DEBUGGING_SUPPORT
 	bool
 	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
-- 
2.17.1



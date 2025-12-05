Return-Path: <linux-fsdevel+bounces-70773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE956CA6C5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 09:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F8CF30DDC19
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 08:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C8A205AB6;
	Fri,  5 Dec 2025 07:20:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B742F5A2C;
	Fri,  5 Dec 2025 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919207; cv=none; b=FD01nRUUFJDnZetZn7/egnzpQPIupHhmi3kx+4lV4GX1kLvhjOfsFGa9KT/nWNPMLl1wRlFM2Fu4SdjVb9QNxEayvXzPYRu6hRVTaphNu1L1I8VmGFdHV1yXM5lZDWqWTkT0KIHoPu2Y1Jl/tWt9KgvjgNETjB27xD9z1QIB0As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919207; c=relaxed/simple;
	bh=yW1ALcC7bPCwFbqRz+6mmuQDDIHblscoPrutZVeTAJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=F27eYvTmjdEuFUTlQVjARnI6wN1kIfy5AfeLdYomj+3ed+kCA+Mgg6tnzxEwZXXdv7h7XScZKrPVq4VzaFJcTwKrICNCJrT0GcqaCohojDoOqzftPTR4GDqZJ+jp97FPFmDODbiR0YITT8YcG/vyqk+kKlu9pUPIB3RjiugZOUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-c2-6932876eb2d2
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
Subject: [PATCH v18 15/42] dept: track timeout waits separately with a new Kconfig
Date: Fri,  5 Dec 2025 16:18:28 +0900
Message-Id: <20251205071855.72743-16-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxiG957zng8aup0VFg8sma6JWeKCQ4fkiZlGF7OcLFl0W+KS+UMb
	ORknlpYUioBxFtRSTRzaraBtJ0WQ8VECtm5qobOwhWkKGaijFa0FNnGsVZRQkA7WlRr/Xbnv
	575+PSypuEtls5KmVNRpVGolLcOyx+mNOZqajVJu1X+bwHT8CIxW+TDYu5w0LNuuMGBynaPg
	RqAaQzhmQrBsHmDAUoUg4R1AUDdiJiE4fJ0E5+UqAqxTNgYeh3soSIQeERCYjyL4y1eTXNUd
	gIYLbhoidU9paJwIkTA7PY7gTmyGhifdNDiqvRSMDEYQfG8zI5ga8xJwtKmLhmvjHgbu15kJ
	6HB9AvXTNNjq/ybA0tlDwGJLOwODTfcxtBjWwmSrlYGEQwuhWguGmw9GKQj/ZqTgimGcgbk7
	EwSYPDEMrj+ThXfsXWg0NmPo9d7EYFqeQzBwdZKA2x47DQ+cCQoMtgUKhn1+Cm51DGPoehQk
	wD9wIym2tmG4GBghYGI8SIF7aJDcViAcv7VMC87zTiT8Gzcj4ZfoDClc9EdpIR77gxa88w4s
	NJ+IE8KZoRzhmjXECA6XXnC3rhOaeqcJoXE2RgljkS2Cq/0EvSv3S9kHBaJaKhN1723dJyvs
	XbJTxW1iuf/sKDYg666TKI3luTz+17mH6CU/ax6jVpjm3uGDwUVyhTO5Nbz71FQyl7Ekd3s1
	X7P4TarI4D7jLzf3pRhza3m7z02ssJzL5383nqZfSFfzHd2+1E1aMrcE4ilWcJv4hpMLKSnP
	/ZDGf1dby7wYZPF9rUF8Gskd6JV2pJA0ZUUqSZ23vrBCI5Wv368tcqHkw7UcXtpzFc0Of96P
	OBYp0+W+gxskBaUqK6ko6kc8Syoz5VF1rqSQF6gqKkWddq9OrxZL+tGbLFaukm+cP1ig4L5S
	lYoHRLFY1L1sCTYt24A6y/c89S2NfPxt3B9525ylktiHxzInQ20Le/VD9TveMHVrvibg+U+X
	oj1FYeOPWTnHEjsuZVS+36AtLbR0bn89/9A/2Z7d+UP3PrWTsfQLmxOv9r0lFZ+fwB0B6Uzg
	54Q278ipUZi5nrHZWPmaJxKvrjj8UVj/4Rc7J+kZvd2u0SpxSaFqwzpSV6L6H4z0u/dsAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0xTeRDG/Z9rqVs9qTWe6AOmWUVMYNEIjtEYNWY5MbsbIw8mXiKNHu0J
	pZBWQYxGSq0gsqQ0aVGKK8tCVUCpFFdYt7HWSFTkUlG5KAKxVpFqVW5puVkwvkx+833fTOZh
	RLi0gVwqEtRHeY1aoZJTYkL8x0Z9jDp3rRBXaJwPeYbT8KrPS8ILnYuA0ZE8AkprayiYst6m
	Ia/uIgkPO3MIaL9RjaBvNA/B+IQVB0PjDAFTpiYaRoIvaTDrEMw4mxBYPCYcutrv4lBTr8Ng
	2D5NwdD9rwjMA14Kigd1BARsBQhKfFYaBh8kwse+OyTM9L7DoHPMj8DmncbA68pFMGVJgcvl
	jvC45TMFEy1tOBSb2xH8PdCLw9fBfgT1Ta8ROK/mUPDWeAuHDu8CeDYaoOCR+TwFHz2lGHyy
	U1CW4yTB82QIwSWrCYGvx4mB/p9aCiyX6gho7P+PBs/QJAavLCYMqut+hz6bj4BmYzkWPjec
	urkErMV6LFzeY2C+fgeDoK2K3lKJuHFDIcFVOf7FOMPTKYqr+asGcRMhE+JGKvU4ZzCG2/v+
	AM6dcWRylc1+iguNPqc451gZwT0uZ7mKcyGMK2qJ4RpLeumdW/eINx3iVUIGr/llc7JY+f9k
	KZl+jT/efOEFkY1KduajCBHLrGO/VPSQs0wxUWxXVxCfZRmznHX86QvrYhHOdESyucHCOWMR
	s4utr7g3xwSzgi11ObBZljAJbNtZI/V9aSRbbXfNZSLCurkzNMdSJp69nD9OGpG4DM2rQjJB
	nZGqEFTxsdoUZZZaOB57MC21DoX/yXZqsqgBjXQkuhEjQvKfJK7MNYKUVGRos1LdiBXhcpnE
	r4oTpJJDiqwTvCbtgOaYite60TIRIV8i2bGbT5YyRxRH+RSeT+c1P1xMFLE0G+1YW5Ct3d79
	c1z8Sfvhtv59vzWX+bXJ569kntMPSFrLC64pb0iGf03aINwOqk8+iI7S7ldFrXyoutlzPWnZ
	tg359taYlqqGCzOVZ9efkPkCCa6Lscs3Kz1HurrdQkz8Qtnp/Xuj69/Q0UVmU6S7djhEf2n9
	0Lhi8aqxpGnd4exAYqSc0CoVa1bjGq3iG4vBg+RLAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Waits with valid timeouts don't actually cause deadlocks.  However, dept
has been reporting the cases as well because it's worth informing the
circular dependency for some cases where, for example, timeout is used
to avoid a deadlock.

However, yes, there are also a lot of, even more, cases where timeout
is used for its clear purpose and meant to be expired.

Report these as an information rather than warning DEADLOCK.  Plus,
introduce CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT Kconfig to make it
optional so that any reports involving waits with timeouts can be turned
on/off depending on the purpose.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h              |  8 ++--
 include/linux/dept_ldt.h          |  6 +--
 include/linux/dept_sdt.h          | 13 +++---
 include/linux/sched.h             |  2 +
 kernel/dependency/dept.c          | 66 ++++++++++++++++++++++++++-----
 kernel/dependency/dept_internal.h |  5 +++
 lib/Kconfig.debug                 | 10 +++++
 7 files changed, 89 insertions(+), 21 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 2343d8c392d7..e70cbc6f41dc 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -139,8 +139,8 @@ extern void dept_free_range(void *start, unsigned int sz);
 extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub_u, const char *n);
 extern void dept_map_copy(struct dept_map *to, struct dept_map *from);
-extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l);
-extern void dept_stage_wait(struct dept_map *m, struct dept_key *k, unsigned long ip, const char *w_fn);
+extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int sub_l, long timeout);
+extern void dept_stage_wait(struct dept_map *m, struct dept_key *k, unsigned long ip, const char *w_fn, long timeout);
 extern void dept_request_event_wait_commit(void);
 extern void dept_clean_stage(void);
 extern void dept_ttwu_stage_wait(struct task_struct *t, unsigned long ip);
@@ -187,8 +187,8 @@ struct dept_map { };
 #define dept_map_init(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_reinit(m, k, su, n)			do { (void)(n); (void)(k); } while (0)
 #define dept_map_copy(t, f)				do { } while (0)
-#define dept_wait(m, w_f, ip, w_fn, sl)			do { (void)(w_fn); } while (0)
-#define dept_stage_wait(m, k, ip, w_fn)			do { (void)(k); (void)(w_fn); } while (0)
+#define dept_wait(m, w_f, ip, w_fn, sl, t)		do { (void)(w_fn); } while (0)
+#define dept_stage_wait(m, k, ip, w_fn, t)		do { (void)(k); (void)(w_fn); } while (0)
 #define dept_request_event_wait_commit()		do { } while (0)
 #define dept_clean_stage()				do { } while (0)
 #define dept_ttwu_stage_wait(t, ip)			do { } while (0)
diff --git a/include/linux/dept_ldt.h b/include/linux/dept_ldt.h
index 8047d0a531f1..730af2517ecd 100644
--- a/include/linux/dept_ldt.h
+++ b/include/linux/dept_ldt.h
@@ -28,7 +28,7 @@
 		else if (t)						\
 			dept_ecxt_enter(m, LDT_EVT_L, i, "trylock", "unlock", sl);\
 		else {							\
-			dept_wait(m, LDT_EVT_L, i, "lock", sl);		\
+			dept_wait(m, LDT_EVT_L, i, "lock", sl, false);	\
 			dept_ecxt_enter(m, LDT_EVT_L, i, "lock", "unlock", sl);\
 		}							\
 	} while (0)
@@ -40,7 +40,7 @@
 		else if (t)						\
 			dept_ecxt_enter(m, LDT_EVT_R, i, "read_trylock", "read_unlock", sl);\
 		else {							\
-			dept_wait(m, q ? LDT_EVT_RW : LDT_EVT_W, i, "read_lock", sl);\
+			dept_wait(m, q ? LDT_EVT_RW : LDT_EVT_W, i, "read_lock", sl, false);\
 			dept_ecxt_enter(m, LDT_EVT_R, i, "read_lock", "read_unlock", sl);\
 		}							\
 	} while (0)
@@ -52,7 +52,7 @@
 		else if (t)						\
 			dept_ecxt_enter(m, LDT_EVT_W, i, "write_trylock", "write_unlock", sl);\
 		else {							\
-			dept_wait(m, LDT_EVT_RW, i, "write_lock", sl);	\
+			dept_wait(m, LDT_EVT_RW, i, "write_lock", sl, false);\
 			dept_ecxt_enter(m, LDT_EVT_W, i, "write_lock", "write_unlock", sl);\
 		}							\
 	} while (0)
diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
index 0535f763b21b..14917df0cc30 100644
--- a/include/linux/dept_sdt.h
+++ b/include/linux/dept_sdt.h
@@ -23,11 +23,12 @@
 
 #define sdt_map_init_key(m, k)		dept_map_init(m, k, 0, #m)
 
-#define sdt_wait(m)							\
+#define sdt_wait_timeout(m, t)						\
 	do {								\
 		dept_request_event(m);					\
-		dept_wait(m, 1UL, _THIS_IP_, __func__, 0);		\
+		dept_wait(m, 1UL, _THIS_IP_, __func__, 0, t);		\
 	} while (0)
+#define sdt_wait(m) sdt_wait_timeout(m, -1L)
 
 /*
  * sdt_might_sleep() and its family will be committed in __schedule()
@@ -38,13 +39,13 @@
 /*
  * Use the code location as the class key if an explicit map is not used.
  */
-#define sdt_might_sleep_start(m)					\
+#define sdt_might_sleep_start_timeout(m, t)				\
 	do {								\
 		struct dept_map *__m = m;				\
 		static struct dept_key __key;				\
-		dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__);\
+		dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__, t);\
 	} while (0)
-
+#define sdt_might_sleep_start(m)	sdt_might_sleep_start_timeout(m, -1L)
 #define sdt_might_sleep_end()		dept_clean_stage()
 
 #define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
@@ -54,7 +55,9 @@
 #else /* !CONFIG_DEPT */
 #define sdt_map_init(m)			do { } while (0)
 #define sdt_map_init_key(m, k)		do { (void)(k); } while (0)
+#define sdt_wait_timeout(m, t)		do { } while (0)
 #define sdt_wait(m)			do { } while (0)
+#define sdt_might_sleep_start_timeout(m, t) do { } while (0)
 #define sdt_might_sleep_start(m)	do { } while (0)
 #define sdt_might_sleep_end()		do { } while (0)
 #define sdt_ecxt_enter(m)		do { } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 1cd0e78f3323..385c5b3c5b0b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -870,6 +870,7 @@ struct dept_task {
 	bool				stage_sched_map;
 	const char			*stage_w_fn;
 	unsigned long			stage_ip;
+	bool				stage_timeout;
 	arch_spinlock_t			stage_lock;
 
 	/*
@@ -910,6 +911,7 @@ struct dept_task {
 	.stage_sched_map = false,				\
 	.stage_w_fn = NULL,					\
 	.stage_ip = 0UL,					\
+	.stage_timeout = false,					\
 	.stage_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED,\
 	.missing_ecxt = 0,					\
 	.hardirqs_enabled = false,				\
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index f4c08758f8db..519b2151403e 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -757,6 +757,8 @@ static void print_diagram(struct dept_dep *d)
 	if (!irqf) {
 		print_spc(spc, "[S] %s(%s:%d)\n", c_fn, fc_n, fc->sub_id);
 		print_spc(spc, "[W] %s(%s:%d)\n", w_fn, tc_n, tc->sub_id);
+		if (w->timeout)
+			print_spc(spc, "--------------- >8 timeout ---------------\n");
 		print_spc(spc, "[E] %s(%s:%d)\n", e_fn, fc_n, fc->sub_id);
 	}
 }
@@ -810,6 +812,24 @@ static void print_dep(struct dept_dep *d)
 
 static void save_current_stack(int skip);
 
+static bool is_timeout_wait_circle(struct dept_class *c)
+{
+	struct dept_class *fc = c->bfs_parent;
+	struct dept_class *tc = c;
+
+	do {
+		struct dept_dep *d = lookup_dep(fc, tc);
+
+		if (d->wait->timeout)
+			return true;
+
+		tc = fc;
+		fc = fc->bfs_parent;
+	} while (tc != c);
+
+	return false;
+}
+
 /*
  * Print all classes in a circle.
  */
@@ -832,10 +852,14 @@ static void print_circle(struct dept_class *c)
 	pr_warn("summary\n");
 	pr_warn("---------------------------------------------------\n");
 
-	if (fc == tc)
+	if (is_timeout_wait_circle(c)) {
+		pr_warn("NOT A DEADLOCK BUT A CIRCULAR DEPENDENCY\n");
+		pr_warn("CHECK IF THE TIMEOUT IS INTENDED\n\n");
+	} else if (fc == tc) {
 		pr_warn("*** AA DEADLOCK ***\n\n");
-	else
+	} else {
 		pr_warn("*** DEADLOCK ***\n\n");
+	}
 
 	i = 0;
 	do {
@@ -1579,7 +1603,8 @@ static int next_wgen(void)
 }
 
 static void add_wait(struct dept_class *c, unsigned long ip,
-		     const char *w_fn, int sub_l, bool sched_sleep)
+		     const char *w_fn, int sub_l, bool sched_sleep,
+		     bool timeout)
 {
 	struct dept_task *dt = dept_task();
 	struct dept_wait *w;
@@ -1599,6 +1624,7 @@ static void add_wait(struct dept_class *c, unsigned long ip,
 	w->wait_fn = w_fn;
 	w->wait_stack = get_current_stack();
 	w->sched_sleep = sched_sleep;
+	w->timeout = timeout;
 
 	cxt = cur_cxt();
 	if (cxt == DEPT_CXT_HIRQ || cxt == DEPT_CXT_SIRQ)
@@ -2297,7 +2323,7 @@ static struct dept_class *check_new_class(struct dept_key *local,
  */
 static void __dept_wait(struct dept_map *m, unsigned long w_f,
 			unsigned long ip, const char *w_fn, int sub_l,
-			bool sched_sleep, bool sched_map)
+			bool sched_sleep, bool sched_map, bool timeout)
 {
 	int e;
 
@@ -2320,7 +2346,7 @@ static void __dept_wait(struct dept_map *m, unsigned long w_f,
 		if (!c)
 			continue;
 
-		add_wait(c, ip, w_fn, sub_l, sched_sleep);
+		add_wait(c, ip, w_fn, sub_l, sched_sleep, timeout);
 	}
 }
 
@@ -2355,14 +2381,23 @@ static void __dept_event(struct dept_map *m, struct dept_map *real_m,
 }
 
 void dept_wait(struct dept_map *m, unsigned long w_f,
-	       unsigned long ip, const char *w_fn, int sub_l)
+	       unsigned long ip, const char *w_fn, int sub_l,
+	       long timeoutval)
 {
 	struct dept_task *dt = dept_task();
 	unsigned long flags;
+	bool timeout;
 
 	if (unlikely(!dept_working()))
 		return;
 
+	timeout = timeoutval > 0 && timeoutval < MAX_SCHEDULE_TIMEOUT;
+
+#if !defined(CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT)
+	if (timeout)
+		return;
+#endif
+
 	if (dt->recursive)
 		return;
 
@@ -2371,21 +2406,30 @@ void dept_wait(struct dept_map *m, unsigned long w_f,
 
 	flags = dept_enter();
 
-	__dept_wait(m, w_f, ip, w_fn, sub_l, false, false);
+	__dept_wait(m, w_f, ip, w_fn, sub_l, false, false, timeout);
 
 	dept_exit(flags);
 }
 EXPORT_SYMBOL_GPL(dept_wait);
 
 void dept_stage_wait(struct dept_map *m, struct dept_key *k,
-		     unsigned long ip, const char *w_fn)
+		     unsigned long ip, const char *w_fn,
+		     long timeoutval)
 {
 	struct dept_task *dt = dept_task();
 	unsigned long flags;
+	bool timeout;
 
 	if (unlikely(!dept_working()))
 		return;
 
+	timeout = timeoutval > 0 && timeoutval < MAX_SCHEDULE_TIMEOUT;
+
+#if !defined(CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT)
+	if (timeout)
+		return;
+#endif
+
 	if (m && m->nocheck)
 		return;
 
@@ -2434,6 +2478,7 @@ void dept_stage_wait(struct dept_map *m, struct dept_key *k,
 
 	dt->stage_w_fn = w_fn;
 	dt->stage_ip = ip;
+	dt->stage_timeout = timeout;
 	arch_spin_unlock(&dt->stage_lock);
 exit:
 	dept_exit_recursive(flags);
@@ -2447,6 +2492,7 @@ static void __dept_clean_stage(struct dept_task *dt)
 	dt->stage_sched_map = false;
 	dt->stage_w_fn = NULL;
 	dt->stage_ip = 0UL;
+	dt->stage_timeout = false;
 }
 
 void dept_clean_stage(void)
@@ -2479,6 +2525,7 @@ void dept_request_event_wait_commit(void)
 	unsigned long ip;
 	const char *w_fn;
 	bool sched_map;
+	bool timeout;
 
 	if (unlikely(!dept_working()))
 		return;
@@ -2505,12 +2552,13 @@ void dept_request_event_wait_commit(void)
 	w_fn = dt->stage_w_fn;
 	ip = dt->stage_ip;
 	sched_map = dt->stage_sched_map;
+	timeout = dt->stage_timeout;
 
 	wg = next_wgen();
 	WRITE_ONCE(dt->stage_m.wgen, wg);
 	arch_spin_unlock(&dt->stage_lock);
 
-	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map);
+	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map, timeout);
 exit:
 	dept_exit(flags);
 }
diff --git a/kernel/dependency/dept_internal.h b/kernel/dependency/dept_internal.h
index 4c4d7bacec15..aa1a588805b3 100644
--- a/kernel/dependency/dept_internal.h
+++ b/kernel/dependency/dept_internal.h
@@ -238,6 +238,11 @@ struct dept_wait {
 			 * whether this wait is for commit in scheduler
 			 */
 			bool		sched_sleep;
+
+			/*
+			 * whether a timeout is set
+			 */
+			bool		timeout;
 		};
 	};
 };
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 712514e2c149..540583425d8e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1394,6 +1394,16 @@ config DEPT
 	  noting, to mitigate the impact by the false positives, multi
 	  reporting has been supported.
 
+config DEPT_AGGRESSIVE_TIMEOUT_WAIT
+	bool "Aggressively track even timeout waits"
+	depends on DEPT
+	default n
+	help
+	  Timeout wait doesn't contribute to a deadlock. However,
+	  informing a circular dependency might be helpful for cases
+	  that timeout is used to avoid a deadlock. Say N if you'd like
+	  to avoid verbose reports.
+
 config LOCK_DEBUGGING_SUPPORT
 	bool
 	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
-- 
2.17.1



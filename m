Return-Path: <linux-fsdevel+bounces-63235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7C7BB2F36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EDD19E2A0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728E62FDC50;
	Thu,  2 Oct 2025 08:13:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E6F2FA0F5;
	Thu,  2 Oct 2025 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392825; cv=none; b=O8KRyDX6tvBu8jC97WNG69x8oBuPGjCyTk2+qPpBFas4yfPoIyNt1prv3m4Lg9DAS8/gVlaDNBvJlJ/Ee4YyivOv2c4esJVj3geqErZJ1F8kXd1Hg8UHyCjCS6V/lsQylzuka4vvdOS9/STlhpXgr9+u2nYc/puJktINZFjxUTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392825; c=relaxed/simple;
	bh=+sgRArYsTQ9aBTge+ApAEmLUJlq6T//mAevAIccDeAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LdATSW1fQke3PsMmY+41Xj4guhvkqEFBAnqeA22ubphalYpYEZLgwPQvSHs2cICLfHzdIOicG5dIYYe+Kh2U4nYiS4rqUiwEcPZYwXqSZ0Z6F8d+/EOPVqkuEHz/VIK39y+YG9Qq//rShxXDcl/f+apjuFJAf0+mQk/OwEZ+jp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-8e-68de340fa6fd
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
Subject: [PATCH v17 18/47] dept: track timeout waits separately with a new Kconfig
Date: Thu,  2 Oct 2025 17:12:18 +0900
Message-Id: <20251002081247.51255-19-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSb0xTZxjF99773veWSudNx+IdkMw0IzMqOBaGT7IF92Xbmyxxy5jLgh9s
	IzdrB7SuKIiJSY1UaxmMsRUHRS0QG4IoSMOUf1oRQVMJ/zJsthYtlH+BjoRBGSrWwuaXJ7+c
	5+TkfDgyVunl4mU6/VHJqNfkqogcy0Oxtclb08a171kq0mHslBvDyrIFQ01zEwFzewTD8tpf
	PES6+xD80/KCwPzdJQS2QJDAovNHBNXTdh7m7n0GocedHET8Mww8Ci8gcAZfMBB0n0WwXpkD
	l+pcBJ4NDLJQG/CzMNsS1afK21gYDb4OD2wlBELDNQz83ULggr0Cwen6ZgKVF1oxtD/p4MFX
	WcGAp7yOgfNzBOznTzPRM8uA7WonA2vORh4e1vswOE1JYB8Y5WCioZqH54FUiDgM0Hdlhgf/
	TzYM10KDHMxPVxB43H+GgxumJzxYOlYwVF30EejqfoCh7+YEA6MdNQTGmyIcmOyrHAy5PRw0
	z3ijFfruY7j8aJgB18BDFsJlCeAtn0IfZ9NVcxmmja7fGWoeWSe06WITosWuQnrZs0Do05U/
	CO0OOzD9eSCZtlf7eVp860+eOlqP0eLeEEddDTtpfdccQ2uXVrgvd2XJP8qWcnUFknFPhlqu
	vRFc5Y+UHD7+y8QUY0L9+60oRiYKaeLM1bP8K26bv403mAjvil7vGrvBccJ20VU6zW0wK3gS
	xbHh3Rv8hvCVWFXy26YHC0miY826yQohXTy37kT/Zb4tXmlxb+oxUX004NnMVwofiObFYsaK
	5FHPpRjxVKju/xJviXcavLgcKRzotUak1OkL8jS63LQUbZFedzzlsCGvFUX35jz5/OBNtDSU
	2YMEGVLFKoaS/FolpynIL8rrQaKMVcUp1A0+rVKRrSk6IRkNh4zHcqX8HpQgw6ptivfDhdlK
	4TvNUSlHko5IxldfRhYTb0LpbfdqLVsyZo3C95YvEvRa9vodW33igblf9fHJ6tZ9pQfcW9X9
	X48YngZY43i148zBwUbzt5NEPqkm3s8jhakp3ZP79y1mLm+RWX3/9n6zW5WYlfEp7CqdzrlV
	9cM7S1nzhnDcyDNzZ+bCXudYKPbN7b0fhk1ln0S8wg5q7Wo2q3C+VpO6kzXma14C7FECmmsD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+59zds5crU7T6FBRsZAkShMsXiq6U/+CovpSGJRLD22pM7Zl
	GRQ6XZl20cW0nNayHOLMbF5qlSlGi1KxtS5STlstu7hlpMu8LJtGX15+7/M8PLwfXiEpqRfM
	EiqUGl6llCVJaREl2r4yc8m0mC750tr2yfA6o4kC/0A2BcW3KmnItl4WwPMqC4JufzaCwREj
	CTrbGAUBvZ2BgaF3DIw12BEUOPQkVNZmENBf/YeG3kc/ERjcHhoKv2ZQ0Gc+i6Cox8jA18eb
	wdd9XwBjrs8EvPnlRWD2/CHA03QaQaAgEa6W1tAw0tZOQqHhOYJrbhcJX6qDZq29C0FDuZaG
	T3l1JDg9U+Glv4+Gp4ZcGnyOYgK+V9Ng0jYIoMSoR5B5/RYNBSVWCmzv7zHg6B0loLNAT4DF
	ug26zT0UtOSVEsH7gqnbM8FYmEkExxcCDDfvEzBkrmCg9XonBeb0cDC2OQXwobyIgVF3NIyZ
	UsBu+cyA64KBgipfu2CtAeFB3XkKV9TUE1j3IkDjyiuVCI8M6xEeKMsksS4vuD7y9pE4q+Yo
	Lmvx0njY/4rGDb9MFH5WyuH8tiXYVuRicNbDt8yOFbGiVQl8kiKVV0WtjhPJ73gGmcO58ccu
	fvhEpKMn23NQiJBjY7i63kZqnGl2IdfRMUSOcxg7n6s51yMYZ5JtmcO9diwe51B2F3c599JE
	hmLDOdNQzgSL2eXcmYAZ/eucx1mqmyb0kKDudLdM9EvYZZyuL4vIQyITmlSBwhTK1GSZImlZ
	pDpRnqZUHIuMT0m2ouA3mU+M5t9FA87NzYgVIukUsSPcJZcIZKnqtORmxAlJaZg4rrxTLhEn
	yNKO86qU/aojSby6Gc0WUtKZ4q27+TgJe1Cm4RN5/jCv+u8SwpBZ6cixMVTj/HnjPPb6n/jq
	zmpsRFRFf0yjd83J09e0czWxMQ/2uHO2NGvVa39fXG96trJjkSbfd2qnwvQGFnR0rZqxUbRB
	nJhwSLlOtOnA935r4+DufaiqmPj9TRXRtTV2ODbK5qBNV14a1u2163BEwNL2I9KyNKs9Gz4W
	tyaHaqdLKbVcFr2IVKllfwEi25wySQMAAA==
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
 include/linux/dept.h     | 13 +++++---
 include/linux/dept_ldt.h |  6 ++--
 include/linux/dept_sdt.h | 13 +++++---
 include/linux/sched.h    |  2 ++
 kernel/dependency/dept.c | 66 ++++++++++++++++++++++++++++++++++------
 lib/Kconfig.debug        | 10 ++++++
 6 files changed, 89 insertions(+), 21 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index cb1b1beea077..49f457390521 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -271,6 +271,11 @@ struct dept_wait {
 			 * whether this wait is for commit in scheduler
 			 */
 			bool		sched_sleep;
+
+			/*
+			 * whether a timeout is set
+			 */
+			bool				timeout;
 		};
 	};
 };
@@ -377,8 +382,8 @@ extern void dept_free_range(void *start, unsigned int sz);
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
@@ -425,8 +430,8 @@ struct dept_map { };
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
index 05c3f8a45405..95b1450f22fa 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -867,6 +867,7 @@ struct dept_task {
 	bool				stage_sched_map;
 	const char			*stage_w_fn;
 	unsigned long			stage_ip;
+	bool				stage_timeout;
 	arch_spinlock_t			stage_lock;
 
 	/*
@@ -907,6 +908,7 @@ struct dept_task {
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
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3669b069337b..290563fa8b58 100644
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



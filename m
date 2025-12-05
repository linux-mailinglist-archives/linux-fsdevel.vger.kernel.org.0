Return-Path: <linux-fsdevel+bounces-70759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40763CA662B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 08:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4CBC3240926
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8200E2F6560;
	Fri,  5 Dec 2025 07:19:20 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2962E1E991B;
	Fri,  5 Dec 2025 07:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919159; cv=none; b=a1IISogPiMsFqXA9QS4i1meMBPRKBYJFbP5xSOp2qtx0E0fVoHbV3t7TI2Qb8bFhLi+Lx9Ta+otgvYzkDgWlGijDou/METTAUQifXL8Hk+hcC283LN3Na6OmhvHYN0wYQNRgtrrYaUeKGna5LKg3r0bwp42x/wIgg+zThthjRME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919159; c=relaxed/simple;
	bh=UPgrUdj2zJuIcM2CRwF3Ndg48wh45GAuitrkG1THTag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Gog7LyH2r2u/CKkOdBp5Jy+GW55KRiPLoouF0Gsnj/LACtKUPBr5ZYC7tARYUaSQLj5GYP2BK63i3CHvl8WMcJ6xicHolEan8W0r++8LF2N2cztYQfEvKr1rgemSmh4y+kNqNf/hbLYRSfAescrcWDLAwncpOlaJ5BMz2q+xqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-2c-6932876ac927
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
Subject: [PATCH v18 02/42] dept: add single event dependency tracker APIs
Date: Fri,  5 Dec 2025 16:18:15 +0900
Message-Id: <20251205071855.72743-3-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSW0wTaRiG/efwz7ShcSxEZvUCbKISNh4Q1G+jEqMX/pp4SIxuwl6sjUxk
	0ha1nMS4CU1EKyoasCUcqiDSxba62IKiwi6yQlakCEoAXZA1casgBcWCFkQFjHdPvvd9n6uP
	p9Vd7AJeTk6VjMlavQYrGaU/pGyZ7uQqeeX1ZTBVfIuD7NtfGLCYEPS0/0WDq9pEQcGAiYER
	+xkERb5iDgaatoC//y4L3eNDCOwvP1MwZdVBdfNzBP+fr6Ghc2wEwwPLaQz+jhIKhqswdLS+
	QWC1uRnoteZR0G/3MWC9EQ5Bu4MDe9ZiaHa+4qDvnIUB99MmBIHOFxTUP/sRCi/2Yqirf8CA
	eSqA4GHzPwz86z3HwaM711jweFtpeFowxMHVei+G5tL5UHW8iIM83ygHFYFhGnpzBxk4ceUG
	BRWVfhbcri4MLX3vOch/XIrB47bQMNFXy0JX3iUM3pstHIzaPrOQfSbIgbODgWJTLgLz/XEa
	apo+cDD5sQRDbtsWsAViIOB04I0bicNzkyLZj6cwcV10IVLxcAiTlssiuXJqgiK3i/o4UupO
	I57KaFJeN0CRstExlrgdpzApm3xNk96uOkyG29o48rKzgNq1KEG5PlHSy+mScUX8PmXS+44/
	6EOt4pHLz6uYLOQJzUEKXhTiRNu9V/R3ftRQyMwwFpaKPT3B2XuYECl6zvrYHKTkaeFJhHgy
	mDsd8HyosFXMf7ZnpsMIi8Var5maYZWwWhxzFuJvzgjRWdUw61EIa0RL98Qsq6c7l3I+zDpF
	4XeF2F7fj74NfhDvVfYw55GqFM1xILWcnG7Qyvq45UmZyfKR5fsPGtxo+tvsv336pRaNtu9u
	RAKPNCGqhowYWc1q01MyDY1I5GlNmGpIv1JWqxK1mUcl48FfjWl6KaURLeQZTbhq1XhGolo4
	oE2VdJJ0SDJ+TylesSALbehW53DrB+fmm2NDFv55eFNNrK1ow2nl3eydx3SJafvaw6rlToVl
	XbzvaInh55rI+7Bn79jaOt3kClXGQMHVQfnJDjp+yTZncOStKc6lSLD+7Y1hVYfp7eay8ndr
	lkS5Xzf4d0D0bnLh0974hEpDZGjEPH3sNWFzVMhPUf8dO+vQMClJ2pho2pii/Qr8ylmIaQMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxScRTG+997uVxJ6o5c3VnNxlatF80y22m9zNaWt7ayVq3Wl2J1lwSa
	A7Os9aLGJCunNCAkyyiphNSkIjMmWbreXJKVzjdqEenUbAoaGhnW+nL2O3ue8+z5cChcZOdF
	UtLUdE6RKpGLSQEh2LIqJ/pQ7jJp7GBnJKhVp6HD7eHBxywnAX6fmoArFVYSgkY7H9RVBh68
	aMkmoKncgsDtVyMYGTPioKoeJyCoaeCDL9DOB20WgnFHAwKdS4NDa1MtDtb7WRgMVf4moffZ
	IALtZw8J+p4sAgbMFxAUeY186KlPhH53DQ/GO79h0DLch8Ds+Y2Bx5mLIKiTwTWTLXSu+0HC
	WONbHPTaJgTXP3fiMNjzCcH9hi4EjtvZJHwteIBDs2cKvPcPkPBSe56EftcVDL5XklCS7eCB
	600vgmKjBoG3zYFBzo0KEnTFVQRUf3rMB1fvLww6dBoMLFWbwW32EvC6wISF6oZc92aAUZ+D
	hUY3Btq7NRgEzGX8hFLEjqjyCbbM9hBjVe+CJGu9akXs2KgGsb7SHJxVFYTWZ30DOHvWdpQt
	fd1HsqP+DyTrGC4h2Fcmhr15bhRjCxuj2eqiTv7WdXsEqw9wcmkGp1iydp8gechVgae9YY6Z
	uiqJM8g2LQ+FUQy9nHnrNBATTNLzmdbWAD7BEfQcxnbRy8tDAgqnm6OY3EB+SKCoafRG5lLb
	zgkPQc9lHjWqsQkW0vGM32Ig/2VGMZZK59+cMHoFo20Z/cuikOda3givAAlK0KQyFCFNzUiR
	SOXxMUpZcmaq9FjM/sMpVSj0TuaTvwofIV9zYh2iKSQOFzqPLpWKeJIMZWZKHWIoXBwh7JPH
	SkXCA5LM45zi8F7FETmnrEMzKUI8Q7hpF7dPRB+UpHMyjkvjFP9VjAqLPIPu7diysnz5ne7n
	SWsSmPcyr2xF++LJCy/vnt59h1s/OGwyShLT9SvLtxu+747dekowZP8yZeRdftRsePJ0SWGc
	xndj1tRt+qBodrE9Zs18wyJLW239PEX95sjaqeF3b00PjO9Ns9d87IpLdnf/3PSt6PGCU3P7
	mQ3+uKSk9mjbiYoTVjGhTJYsXYgrlJI/9TaX10oDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Wrapped the base APIs for easier annotation on wait and event.  Start
with supporting waiters on each single event.  More general support for
multiple events is a future work.  Do more when the need arises.

How to annotate:

1. Initaialize a map for the interesting wait.

   /*
    * Place along with the wait instance.
    */
   struct dept_map my_wait;

   /*
    * Place in the initialization code.
    */
   sdt_map_init(&my_wait);

2. Place the following at the wait code.

   sdt_wait(&my_wait);

3. Place the following at the event code.

   sdt_event(&my_wait);

That's it!

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_sdt.h | 65 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 include/linux/dept_sdt.h

diff --git a/include/linux/dept_sdt.h b/include/linux/dept_sdt.h
new file mode 100644
index 000000000000..0535f763b21b
--- /dev/null
+++ b/include/linux/dept_sdt.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Single-event Dependency Tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_SDT_H
+#define __LINUX_DEPT_SDT_H
+
+#include <linux/kernel.h>
+#include <linux/dept.h>
+
+#ifdef CONFIG_DEPT
+#define sdt_map_init(m)							\
+	do {								\
+		static struct dept_key __key;				\
+		dept_map_init(m, &__key, 0, #m);			\
+	} while (0)
+
+#define sdt_map_init_key(m, k)		dept_map_init(m, k, 0, #m)
+
+#define sdt_wait(m)							\
+	do {								\
+		dept_request_event(m);					\
+		dept_wait(m, 1UL, _THIS_IP_, __func__, 0);		\
+	} while (0)
+
+/*
+ * sdt_might_sleep() and its family will be committed in __schedule()
+ * when it actually gets to __schedule(). Both dept_request_event() and
+ * dept_wait() will be performed on the commit.
+ */
+
+/*
+ * Use the code location as the class key if an explicit map is not used.
+ */
+#define sdt_might_sleep_start(m)					\
+	do {								\
+		struct dept_map *__m = m;				\
+		static struct dept_key __key;				\
+		dept_stage_wait(__m, __m ? NULL : &__key, _THIS_IP_, __func__);\
+	} while (0)
+
+#define sdt_might_sleep_end()		dept_clean_stage()
+
+#define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
+#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, __func__)
+#define sdt_ecxt_exit(m)		dept_ecxt_exit(m, 1UL, _THIS_IP_)
+#define sdt_request_event(m)		dept_request_event(m)
+#else /* !CONFIG_DEPT */
+#define sdt_map_init(m)			do { } while (0)
+#define sdt_map_init_key(m, k)		do { (void)(k); } while (0)
+#define sdt_wait(m)			do { } while (0)
+#define sdt_might_sleep_start(m)	do { } while (0)
+#define sdt_might_sleep_end()		do { } while (0)
+#define sdt_ecxt_enter(m)		do { } while (0)
+#define sdt_event(m)			do { } while (0)
+#define sdt_ecxt_exit(m)		do { } while (0)
+#define sdt_request_event(m)		do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_SDT_H */
-- 
2.17.1



Return-Path: <linux-fsdevel+bounces-63218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C55EBB2D05
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E714247FA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073002DE713;
	Thu,  2 Oct 2025 08:13:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020C62C1788;
	Thu,  2 Oct 2025 08:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392794; cv=none; b=cnMIHh4oB4a8qkStbCHM3UWukyxmyIOPQpUFU7syLmsTKJG7lNZl59LqDwIkJRDBNkHUoxNbsQn4rvUAhJJTNp1niAj3lM2f8Y1yI7s6kAAozp4Cw/twKvCU8FUbZA6PzE6aZuWAn0YioBxdmTkeE6Q0LUJSgDl8cVnQjvnFKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392794; c=relaxed/simple;
	bh=RX0BVWE27Cost6W7zXdbtvLSq8FC7lANMhyhh7fOZCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eOi7RJ1Zc6QlYQSztcPrDaw8om02YamLFuNusTUlra/tZ0Coa9U+I8zfkZdZTPNw6aVCftFh0RTshPU8oQvTV3sUmk4wP4optXwIcPgIH9fCekSal/iY5uxXFFvdhXDF4R5pvsokq7NicN0nuSbT8lQ6pk8tRzwtuv8bWb+1sas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-9e-68de340ba681
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
Subject: [PATCH v17 04/47] dept: add lock dependency tracker APIs
Date: Thu,  2 Oct 2025 17:12:04 +0900
Message-Id: <20251002081247.51255-5-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5/bLjk4LaOTF6qVVNJFQ+P9YJEUdCgC0Q92Az21Qxvqspkz
	o8uGE21lqDBFZV7TTF3KWUSlklok08hLtiy2JAstdYq3QlFrU/ry8ON9n+f59IhxuYn0E6s1
	13ithktUUFJC6vap2Lc+7Ksq5OVSBMzPZROQLRSRMP56BkHhLwMBUzX3ERSPlIjAPdRMwl/X
	KAY/2rIQLBckQFmljYJCcy+CySYKCiwCAc6CfAzqhdMwVDNCQElhBuaRnxiYrc0YLH0LBftX
	BwnCd48UlTopaGm1E6Av+UNC4+ggBvbixwT0vLSSYJ2spKBmfkoE/W3lGBjaqwiYefibgM6c
	NgycD8YIGPjcjKC61k3CaLEFgy7XrAhsghmHrsUuDDLvL4igafoRBYbZIQRGZzhY5kLBuuxA
	R0PYzP5lim0obUDsXHUGzr6emMJZoy2NXZz/SLEvil0itlxIZY1v3CRrqw1mq1p+YaxQd5di
	Te4BjHU6Wih28v17EVuhN+NRAeekEUo+Ua3jtQeOxEtV4/0Xky3MdcNYPalHA3ITkogZOoyx
	rBgpExKvsj5L4j1T9C5mcHAB97IvvY2x5YyQXsbp7gDG0bfXyxvpSCZrZRbzMkEHMfeGiygv
	y+hwxmHqQWv1W5n6prbVHgl9iPnwrZvwstzjyZwyerJSj6dEwky3TxBrgS1Me+0gkYtk5Whd
	HZKrNbokTp0Ytl+VrlFf33/pSpKAPAupubV0/jma6Y3pQLQYKXxkvUEulZzkdCnpSR2IEeMK
	X1l8rVMllym59Bu89kqcNjWRT+lA/mJCsVl28HeaUk5f5q7xCTyfzGv/fzGxxE+P8saZt35v
	Ahpz/aOPd/al7wkJP3s2Nd/xrv3PmdsbwgKju8tij9m5Hx+eTdzM19mtLkPSLcj7tON28r3D
	okuBpc+nTw3H+u/cWX315O5NLWM4ExWvjJxZUMYotp8obEgeznvS+jRCWNGk6U3hca9KBxa6
	L/jfeYE7OZ3OKhpK+GJWECkqLjQY16Zw/wD9QgOOHQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSf0zMcRgH8D7f33cc353GV2zZbc00oc2PB7H4py9z2BjDHzp8505d2V0i
	8+OuOqUjd7ddqdMPWSddkooJxy2TcVpOxOgkS6Jyxp2Wfpw7m3+evZ69nz17/ngYXNpMRjGq
	tAxBk6ZIlVFiQrx5dU7clKUflEsKXdHQpXcREPDnE3DpRh0F+Y0lJLyodyDoCeQjGBmz4WBo
	CRIwYWmjwT/6noagsw1BkceCQ12zHoNfDZMUDD76icDa20dB8Vc9AT77OQSl/TYavj5OguGe
	eyQEvV8wePN7CIG9bxKDPlcegomiFKioaqJgrL0Dh2LrCwSXe704DDSEwua2DwicNdkUfDbd
	wqGzbxq8CvgoeGo1UjDsuYTB9wYKKrOdJJTZLAhyrtygoKiskYCWj3dp8AyOY9BdZMHA0SiH
	Hns/AW5TFRa6LzR1cxbYinOwUBnAwHr9Hgaj9loanl/pJsCuiwFbeycJn2pKaRjvjYdgZTq0
	Ob7Q4L1gJaB+uINMtCJ+xFBI8LVNtzHe8HKC4uvK6xA/9seCeH91Ds4bTKH20ZAP53ObjvLV
	7iGK/xN4TfHO35UE/6yK483tcXxLqZfmcx+8o7eu2i1OOCCkqjIFzeK1yWLl4Mt9h8u4Y/pv
	DlKHXkkLEMNw7FJOlycqQCKGYudzb9+O4mFHsvO4pvP9ZNg4657LdXkWhj2DXcflTf7CwibY
	GM74qYQKW8Iu47oKOlDYHBvNORpc//aI2OVcZ6+bCFsamjH4cjETEleiiFoUqUrLVCtUqcsW
	aVOUWWmqY4v2p6sbUeiX7CfHzXeQvzOpFbEMkk2VeGK8SimpyNRmqVsRx+CySElyTbdSKjmg
	yDouaNL3ao6kCtpWNIchZLMkG3cKyVL2oCJDSBGEw4Lmf4oxoigdit/uW2C1V5y5RshXHRJl
	JExX+xasDETN/HjRhf/YNm+bUn5qzQ5TxchZMnlKpDlJUo4SnFcnuLidM9XxJXc2Hjpxf4XM
	aZSvH8g+9zki4kmi0eRPfBJMYHqOyNOtXXt0K9yCp9W8oSX2zS49fzpaPmqWG6s3GR/OPlq4
	Zcwwe4uM0CoV8bG4Rqv4C17aBwtHAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Wrap the base APIs for easier annotation on typical lock.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept_ldt.h | 78 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100644 include/linux/dept_ldt.h

diff --git a/include/linux/dept_ldt.h b/include/linux/dept_ldt.h
new file mode 100644
index 000000000000..8047d0a531f1
--- /dev/null
+++ b/include/linux/dept_ldt.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Lock Dependency Tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ *  Copyright (c) 2024 SK hynix, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_LDT_H
+#define __LINUX_DEPT_LDT_H
+
+#include <linux/dept.h>
+
+#ifdef CONFIG_DEPT
+#define LDT_EVT_L			1UL
+#define LDT_EVT_R			2UL
+#define LDT_EVT_W			1UL
+#define LDT_EVT_RW			(LDT_EVT_R | LDT_EVT_W)
+#define LDT_EVT_ALL			(LDT_EVT_L | LDT_EVT_RW)
+
+#define ldt_init(m, k, su, n)		dept_map_init(m, k, su, n)
+#define ldt_lock(m, sl, t, n, i)					\
+	do {								\
+		if (n)							\
+			dept_ecxt_enter_nokeep(m);			\
+		else if (t)						\
+			dept_ecxt_enter(m, LDT_EVT_L, i, "trylock", "unlock", sl);\
+		else {							\
+			dept_wait(m, LDT_EVT_L, i, "lock", sl);		\
+			dept_ecxt_enter(m, LDT_EVT_L, i, "lock", "unlock", sl);\
+		}							\
+	} while (0)
+
+#define ldt_rlock(m, sl, t, n, i, q)					\
+	do {								\
+		if (n)							\
+			dept_ecxt_enter_nokeep(m);			\
+		else if (t)						\
+			dept_ecxt_enter(m, LDT_EVT_R, i, "read_trylock", "read_unlock", sl);\
+		else {							\
+			dept_wait(m, q ? LDT_EVT_RW : LDT_EVT_W, i, "read_lock", sl);\
+			dept_ecxt_enter(m, LDT_EVT_R, i, "read_lock", "read_unlock", sl);\
+		}							\
+	} while (0)
+
+#define ldt_wlock(m, sl, t, n, i)					\
+	do {								\
+		if (n)							\
+			dept_ecxt_enter_nokeep(m);			\
+		else if (t)						\
+			dept_ecxt_enter(m, LDT_EVT_W, i, "write_trylock", "write_unlock", sl);\
+		else {							\
+			dept_wait(m, LDT_EVT_RW, i, "write_lock", sl);	\
+			dept_ecxt_enter(m, LDT_EVT_W, i, "write_lock", "write_unlock", sl);\
+		}							\
+	} while (0)
+
+#define ldt_unlock(m, i)		dept_ecxt_exit(m, LDT_EVT_ALL, i)
+
+#define ldt_downgrade(m, i)						\
+	do {								\
+		if (dept_ecxt_holding(m, LDT_EVT_W))			\
+			dept_map_ecxt_modify(m, LDT_EVT_W, NULL, LDT_EVT_R, i, "downgrade", "read_unlock", -1);\
+	} while (0)
+
+#define ldt_set_class(m, n, k, sl, i)	dept_map_ecxt_modify(m, LDT_EVT_ALL, k, 0UL, i, "lock_set_class", "(any)unlock", sl)
+#else /* !CONFIG_DEPT */
+#define ldt_init(m, k, su, n)		do { (void)(k); } while (0)
+#define ldt_lock(m, sl, t, n, i)	do { } while (0)
+#define ldt_rlock(m, sl, t, n, i, q)	do { } while (0)
+#define ldt_wlock(m, sl, t, n, i)	do { } while (0)
+#define ldt_unlock(m, i)		do { } while (0)
+#define ldt_downgrade(m, i)		do { } while (0)
+#define ldt_set_class(m, n, k, sl, i)	do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_LDT_H */
-- 
2.17.1



Return-Path: <linux-fsdevel+bounces-70761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC75CA674B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 08:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F31A23036515
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F27C2FE57B;
	Fri,  5 Dec 2025 07:19:26 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69362EA743;
	Fri,  5 Dec 2025 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919163; cv=none; b=e7TJeBdGRxtTwQhp3I5fl/mJy/laYa+YDnHrZzTZ/fZtSUQM2prQP3T/bz5RvhwqWY7JyecIq4tMcOGNlPiQextc82JecTE9J7F9aRnVR9wRC3BbpkHki6u2OKtqjvAT1gL86hcidIjNo0fbzN3gK1t+60bxBcqpXtVBPM6/3fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919163; c=relaxed/simple;
	bh=RX0BVWE27Cost6W7zXdbtvLSq8FC7lANMhyhh7fOZCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uSj4IZ870KGG2gRslvCFBswUWso3Sozoz6DWyQJ3MAacxSMsS5mlHwOKh2a3Tuw6oQzrrwAQhUTfhOMFyXFlJAfa48kehDl/C8NKCg6n7/Ik3R/nahVU3gi8PqBJoY932UyZGoVwIodMSIt6oV+aqI+vvz3FyAH2UPjtRa1l05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-4a-6932876ab33f
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
Subject: [PATCH v18 03/42] dept: add lock dependency tracker APIs
Date: Fri,  5 Dec 2025 16:18:16 +0900
Message-Id: <20251205071855.72743-4-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0wTaRSG/WbmmxmqxbFqHDVZtQm7rsELCOZoxFuMjn/IJm42m93oWuwo
	DQW0XAQ2mIog2lVEEjC0yh222goEVrkoEVFRxEpBTCcK4RLkYoU1KBAupVKMf06enPOc99fL
	kgoHXsVqIqJFXYRKq6RllGx4Uf7GsFR/zZZi+w/Q0dWH4UaZlQaXqYqB544kCuylFgQT0yYS
	UmrcFLgyGhnIPIfAXdeIIKs1gwTJ/pCEz+WzNDgfjyIw9psYGHp6EIa77mNwdw4QUNI3S0Bf
	fSoCV1YY5BZUzqlZn2iYtrWQMDrUjaDOnETD+/S7JLSP/U9D60sngv63dQTUdNcy0OqcIaA5
	vYCA60M0mK6fJ+bGIAEvCzsoKNH7gMn2GkOv2cjATI8fuPMiodEywEDn1UwKSodbMHQ9u4Dh
	S3sPAdbL/STkXyiiIDung4YHdU0UXHR9QdBY3UvA5fK7GPSmCQxlAxIBTcZbFLyzXWWgpfYO
	hmJHKwE93RKG8bTVIKW/R3BnpIDeoxYmUtIoIaXNRQvWHCsSpqcykDA19oYWii5NEUKNsZMR
	8ipihOQnw1ioNG8QCh8MEUL+6BgW3jqDhIrbl2ghf3qQFEZevWJ++fkP2U61qNXEirrNu47J
	Qp1tIadu8nHnPliwHrUrDMiL5bkA3jjQzBgQO89ZpbRnTXM/8ZI0SXp4GbeWr7zSjw1IxpLc
	6zV86mQa6fGXcnt548MTHqQ4H97oWOjR5Vwgb76SQn1LX8NbyuvnY7y4bXymY2qeFXNOrmFi
	PpLncr34d7PZ+NvDSv6RWaLSkTwPLbiNFJqI2HCVRhuwKTQ+QhO36XhkeAWaq1tJ4syf1WjU
	frgBcSxSLpLXn/HTKLAqNio+vAHxLKlcJv+o3aJRyNWq+ARRF/mXLkYrRjWg1SylXCH3Hz+j
	VnAnVdFimCieEnXfrwTrtUqPDv/zIti+3p28401OePX63063leibR/b4/XesqvjXhOMJ562L
	99PFIU0/SkUBNkwdCezhvAu9D/wubfu4dbJrtyJuycGqoNpA6dqzW+uyNx/6e/lKn8SzIWVH
	Qz4HR2cH25dsP+r/r+++xS1JOYmzZvWRQCdd47vW/WRc5a31vTdosNiUVFSoym8DqYtSfQWc
	ncjZagMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe2xLcRTH/e6rd61yU2M3Q0i9EvGa5xEiHn+4JFiICCFWXHate2gZE2Nd
	1Wq2qSZtWTdms1rWYi+PodFMLJ6x2lg9to7UmJXJtGabmVbin5PPyfmck/PHl8ZlNWQ0LSTt
	51VJCqWcEhPitYu00/dmzRZmWT3TQK87Bu+8PhJeaVwEBAN6AgquOSgYsN4Ugb7qHAkPmzMJ
	aLhqR+AN6hH09Ftx0NUOEjBgrBdBoPetCEwaBIPOegRmtxEHT8M9HBw1Ggx+VPyhoPN+NwLT
	ex8Flg4NAV22HAT57VYRdDxYCV+9d0gYbPmEQfNPPwKb7w8GPlcWggFzAlworg6tm79T0P/s
	OQ4WUwOCi+9bcOjuaENQU9+KwFmWScFHw3UcGn3DoCnYRcEj0ykKvroLMPhWQUFRppME99NO
	BIVWI4L2N04MtCXXKDAXVhFQ23ZbBO7O3xi8MxsxsFetAa+tnYAnhmIs9G7IqowCq0WLhcpn
	DExX7mDQaysXLS1FXI8uj+DKq29gnO7FAMU5zjsQ199nRFygVItzOkOove/vwrnj1Qe50id+
	iusLvqQ4588igntczHKXTvZh3Jln07na/BZR7LIt4sW7eKWQyqtmLokTx3e+2JFSyB7SfLGT
	GahJlo1ommXmsuarVDaKoClmCuvx9OJhjmTGs9W57WQ2EtM40ziOzerNw8P+CGYZm39vdxgJ
	ZhKb3ywJ61JmHluWqyPCzDLjWHuF69+ZCGY+a2ru+8eykHMhu4c0IHERGlKOIoWk1ESFoJw3
	Q50Qn5YkHJqxMzmxCoWyZEv/feYWCjSurEMMjeRDpa6DMYKMVKSq0xLrEEvj8kipXzlLkEl3
	KdIO86rk7aoDSl5dh0bThDxKunoTHydj9ij28wk8n8Kr/k8xOiI6Ax1t3SxZkeUuKd62PnfT
	x4Zu34Q5glY2akHwwfAVlpS4dZJB+9lVljbFxhKNfsrlAmVT3Inr6VLjwrEbXm2v/bUu53yU
	YWS8fP7YnPrYShQsu7LV2Loxln8Z4/HnjXDNuez5wDoQHEltfCsZXTnGluG9O/l0IPr1vj0T
	y5Yn56bPlMgJdbwiZiquUiv+AtJ/KdJHAwAA
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



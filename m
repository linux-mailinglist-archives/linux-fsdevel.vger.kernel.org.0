Return-Path: <linux-fsdevel+bounces-70768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9423BCA74E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 12:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C7B935F5A51
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 08:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDA630DD0E;
	Fri,  5 Dec 2025 07:19:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5707B3016FB;
	Fri,  5 Dec 2025 07:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919181; cv=none; b=UaobysgZjOuMRJFWLWDrHvlG0ivEAhXu0FQembBax6ghZK439imwwMrQcSoSlFWxE8bZnsRrSJ9MnLX1ShLvsnWu6a7hhumLW+/NNKxhR9n+HypmFySUdGgOihwinBiOAIHDuTKzYM1SjsJfvEgvPpK3mdQtOmSYJNkh5tIkNeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919181; c=relaxed/simple;
	bh=pLUSXjgVOyB6ewzDMD2B/aTj2n2b3ii/EXLHyurcTzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Co3tjKJFlj9RqlMSO/XqLhTYmAfhxtbF8Tz7JAwVKf6mUWE8o+xSzEO2JCEWXACTreNiVm8S2ib4V5UVUaMF0VtL2NtDw2TbgTSkyPcoP4/XiS/iORNe4mz+X0w4hqlSZHRk/8MG4YMgcMHsPguMljhAUwRrQAJ1yDLxVpLaeAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-45-6932876db4e0
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
Subject: [PATCH v18 11/42] dept: apply sdt_might_sleep_{start,end}() to swait
Date: Fri,  5 Dec 2025 16:18:24 +0900
Message-Id: <20251205071855.72743-12-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTZxTH99z73NtLQ5ObSuQRsrk0IUYNKEbNWeJePmzJ/SDLFmNi3Acs
	coXrWsCCCCZGEOVNRYZSIiAtFEh52dDia2djRUUrIDAGdFrs0AoSyth4lVrRUrMvJ7/8f+f8
	Px2OVrqYCE5KyRB1KWqNipVj+VRoXbS2YIu0eakiGlxuDwNDuXYM1W2tLLyruiGDQstFBuaW
	nsngva0Tgb6/jAZn3x0aWq/mUjB7eZmF8lEPCxUTuRim3L8z8H5knILhBS+CRs8yBR57AQJD
	XTsLk/p/WXjb00tDRXkfgtrRERpmJv5GcLXzOYJXpddo+HN+mgVH+WkWpvqrKTCesDHQ3z2J
	4FJVGYKxpzYK8kxtLOgvWTD0T/opcOnLKGixxIG7cQxDV2kdBfor4VBVkUcFxmsKuk0uDI05
	UfDCXCkD/2gsOJ4PMTA5VsaC+2E+A5a/HiAotM5jsLwMCNvTjVCbX4/hYo2Lhds2B4YBazUL
	OVWLDPTZuxhoG3dS0NX5CIOjsglDr/VX5ptEYfFUCRaa269Twqk/3rFCa00rEuYa8mjhnnea
	Fnzzg6xgWzBi4XEdEeqLfJTwS0+0cKtyRCYYLYeFk/enGKHdvEEw3Z6gfojZK9+RKGqkTFG3
	6at98uSZ0UEm7QGX5WywynLQE7YYhXCE30ryX//GFCMuyEWDO1dill9HnM4leoXD+M9J+9mx
	wIqco/mBtaRgqSQoVvFxZKB5Ga0w5qPIlTc9eIUV/HbSMXSe/ti/lrRctgc5JJCXD/uCrOS3
	EUPxYrCU8C0hxF3kkX08WEPump24FCmM6JNmpJRSMrVqSbM1Jjk7RcqK2Z+qtaDAzzUe8/90
	E8307epAPIdUoQr7kVhJyagz07O1HYhwtCpM4dVslpSKRHX2UVGXGq87rBHTO1Akh1Xhii0L
	RxKVfJI6Q/xZFNNE3f+W4kIictD3px1t4zc/i7OGxnvXxGZ+ffZlvHcwzT9x3hfVUB9n7k4S
	SYJ/5vHq/55lHC8+oN1/5t7uqBvTXEJE03e9F1YdI5/6kgpnTbsNcz8awp+kXoj81nDo5D8b
	m87cLzmqqt+RO/ulNKw6x6831/QYI/dEHsy6lUFqv0g4nn/gbZh3vanhhAqnJ6tjN9C6dPUH
	ZhZjZG8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxTG/d93OrtcK5EbHdE0mewNB2awY0YW/eSNGYZEE5LFqA3cwA0t
	Qqu8Jdso2AGdI1DTklERRNswQIEWhsg6mzqYwBCwvFQHK2wdGwHFIK+FgoVkX05+5zzPkzwf
	DoPL2sn9jJh+WVCnK5RySkJITn9WGKkqOipG9dowKNZ9A+NeHwmjWicBS4vFBNxoaqQgYG6n
	odj2AwmPxwoIGLzXgMC7VIxgZd2Mg65ji4CAoZuGxbU/aDBqEWw5uhGYhgw4eAYf4tDYqsXg
	dfMmBbOPFhAYp3wUVMxoCZi3XkNQOW2mYabrJLzwdpKwNfEvBmPLcwisvk0MfM4iBAFTGlTX
	2oNx0ysK1vsHcKgwDiK4NTWBw8LMJILW7j8ROOoKKPinrA0Ht+9tGF6ap6DH+B0FL4ZuYPCy
	mYKaAgcJQ7/PIqgyGxBMP3dgUHi7iQJTlY2AjskHNAzNbmAwbjJg0GCLB691moC+slosWDfo
	agkDc0UhFhz/YWC824nBmrWePm5B/IqulODr7T9hvO5pgOIbbzYift1vQPyipRDndWXB9dHc
	PM5ftWfzlr45ivcvjVC8Y7mG4HtrOf5OiR/jy/sj+Y7KCTrhxJeSuGRBKWYJ6o8/vyhJXZga
	ITO6mByP5QGdj55QesQwHPsJVzLyhR6FMBQbwXk8a/g2h7KHOPv306QeSRicdR/kitZKd4S9
	bDznrt9E20yw73Itq/3ENkvZWM41en3Hw7EHuYZm5w6HBO/GMf8Oy9gYrlq/QpYhSQ3aVY9C
	xfQslUJUxhzRpKXmpos5R5IuqWwo+E7WrzbK76NF90kXYhkk3y11ZkeLMlKRpclVuRDH4PJQ
	6ZwySpRJkxW5eYL60gX1FaWgcaEDDCEPk55KFC7K2BTFZSFNEDIE9f8qxoTsz0dvfX239KlY
	aYp471N3k3fZc+6MkLcrUec8G7WaKO/K+9ny23HpsL/ONyxWV4YnhDftaYH7rRl1ew9/S/0S
	09B1vs1r1Do/mqwKqz5QHmv/69fxwEjmY/rhOyVJkfGZNaqBiL8z9RXeDxf6evb8OD++75gl
	TsW/X/Us5ZALy0qYvdojJzSpiugPcLVG8QZ6wBFfSgMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Make dept able to track dependencies by swaits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/swait.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/swait.h b/include/linux/swait.h
index d324419482a0..277ac74f61c3 100644
--- a/include/linux/swait.h
+++ b/include/linux/swait.h
@@ -6,6 +6,7 @@
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/dept_sdt.h>
 #include <asm/current.h>
 
 /*
@@ -161,6 +162,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 	struct swait_queue __wait;					\
 	long __ret = ret;						\
 									\
+	sdt_might_sleep_start(NULL);					\
 	INIT_LIST_HEAD(&__wait.task_list);				\
 	for (;;) {							\
 		long __int = prepare_to_swait_event(&wq, &__wait, state);\
@@ -176,6 +178,7 @@ extern void finish_swait(struct swait_queue_head *q, struct swait_queue *wait);
 		cmd;							\
 	}								\
 	finish_swait(&wq, &__wait);					\
+	sdt_might_sleep_end();						\
 __out:	__ret;								\
 })
 
-- 
2.17.1



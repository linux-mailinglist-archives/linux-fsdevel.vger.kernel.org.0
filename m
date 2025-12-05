Return-Path: <linux-fsdevel+bounces-70799-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20110CA6A36
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 09:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 450933398776
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBE7344056;
	Fri,  5 Dec 2025 07:21:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEDDE337BB1;
	Fri,  5 Dec 2025 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919305; cv=none; b=NWWDsFNACr9Sc5cINI/k4wOuq4gzWalqbt+YHV0b8rAlK9TLtyMJLOoZZFUkNaxNPgv/Q0XbqjLU6IXApiCZnk6N8yqVP8NRcs2Zxz+xY4PCgsufm08F1UNJxaiQPOvVc2vXNsloEsfCcrXjd8Ye4qkA/SIucwscT/yBV522U2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919305; c=relaxed/simple;
	bh=IVs7UrTREahv4P4gaL8VNCv4Y1x1l3V8HrPMnx32xWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=qziJMEPLhOl6+7HirP10fqpjBOS75WWWxFZLIG1fJ1PJYsg2kam3WF4EDXWYolUZ7ynpI3ozcrH0UTIzaIG++/yio7SZ9vZPAIOZBFjnMfyiA3/152bjh8qnwna9tPtR7UQGeL/nX82HVmRRpNeuVfRSj950tb15oy7i+Qy1cl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=fail smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-fb-69328776f97a
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
Subject: [PATCH v18 42/42] mm: percpu: increase PERCPU_DYNAMIC_SIZE_SHIFT on DEPT and large PAGE_SIZE
Date: Fri,  5 Dec 2025 16:18:55 +0900
Message-Id: <20251205071855.72743-43-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxTG/d/7v/97Wym5qSZcXxKXJpsJURSj5sRsuGRbcvdhyZJ9cHEf
	ZpUb21iKaZHKlmW1QqiICpi2kSIWHE1Dy1sr42XWVWCMhhGLKO2QqrwEcUJIHIUAug5q/HLy
	y3nO8zxfDkcr48x2TqsvkAx6tU5F5Fg+n1a311R6QLvf0bsTrCU/w+iFEIbEohVDTYuPwFtn
	BwtW/w0GBqIWDJFmL4JnCSuC5TUnDYsrT1iwD1fREIv8ToPvzgUK/m39j4BtYprAgrscQTL+
	goLo0hyC6VApglv1AQJrQw9ocNgiCOom4jQEPRYCI9Pp8CixQCBsu0xgfriGApclyMBNZxWC
	mbEgBeP2Kgq8/q/gmXsGw2BFPQX2tgxwOi5S62OWAlvTbxT8dXscg3NohIFJTzULSVc+xK/Z
	MISfjjLwaqaKQIf5OQv+v/9AYO1OYPBPrQs3ascJ3A2GMfR3TlIw0l1DoLy1nYGnviQDkdAg
	Aw+9kfXW/gEMT4ausfCgu4mBhugwBRPPY8ynueJyyVUsNgZ+pURfrQ+Jiw0XabF3boEWiwMm
	sWFwjoiricdEDC65sFg5tFfsqo6zYvG9MVZ0+c+JxX3zjBjwZIq3776kvt5zXP5xrqTTFkqG
	fTkn5JpYX4w52y4732FNsmY0yZYhGSfwB4WBvivkPffXO/AGE363EIut0Bu8lf9ACFyZYcqQ
	nKP5kV1C6crVlLCFl4RZuzllxvyHQlN5OGVW8IcF28tJ9C50l+BtDaXuZRv76GqKlfwh4VbZ
	cipU4J0yYba8hH5n2Cbc98RwBVK40KZGpNTqC/PUWt3BLE2RXns+61R+nh+tP537pzffdaLX
	kW96EM8hVZoiZMrWKhl1obEorwcJHK3aqpjT7dcqFbnqoh8kQ/73hnM6ydiDdnBYlaE4sGTK
	VfKn1QXSGUk6KxneqxQn225G7potwyVjGhC8GTms55d9n3Vpej9J78xyN/dMOSrc1WnZqjbT
	yYKjdZUn9B+lWwQCx/484iGXfBa1S3XY3XI0Th0/FD0SzuHunPyn6HTbjkROx+iXjaXXN08t
	X+6yD67KpNrmH1vGVZWZyUdGs2J14Fv//fb0S19cn/h8bU93lwobNersTNpgVP8Pisz1+XAD
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa2yLcRTG/d9rVyqvGnszH9CwicxtMTlxJ2FvJERCIi4LxctqbdHabBLs
	olkNSzXa2boxZSW728VsNGZY3LWG1WXK1Gg2m0y3pe266Sa+nPzOeZ7n5Hw4Alx8mwwXyJRH
	eJVSKpdQQkK4YUnGnKTMaNn8CnsoaDUn4ZPTRcK7tEYC+jxaAvIrSikImOpo0FblkvC4NZ0A
	W3kJAmefFsGA34SDpn6YgIC+mQaP9yMNhjQEw9ZmBEa7HgeH7R4OpTVpGPypHKKg80EvAsNX
	FwU57jQCeixnEeR1mGhwP4qFX847JAy3/cCgtb8LgcU1hIGrMRNBwJgAl83VwbjxNwX+F69w
	yDHYEFz52oZDr/sLgprmzwisN9Ip+K6rxaHFNR7e9PVQ8MRwhoJf9nwMuispKEy3kmB/3omg
	wKRH0PHBikHG1QoKjAVVBNR/aaDB3jmIwSejHoOSqvXgtHQQ8ExnxoLnBl03w8CUk4EFy08M
	DGV3MPBaiumVRYgb0GQTXHH1LYzTvA5QXOmlUsT5fXrEeYoycE6jC7YPunpw7lT1Ua7oWRfF
	+freUpy1v5DgnppZ7tppH8adfzGHq89rozeu2iZcupeXy5J41bzlu4TxjocO8lBtSHKddphO
	Re10FgoRsMxCttmcQ4wwxUSyDocXH+FQZhpbfa6DzEJCAc60TGUzvdmjwkSGZ38aU6kRJpiZ
	bNnZJ6NhEbOINbjb0b+lU9mSysZRf8jIvNU3ymImhr2cNUDqkLAQjSlGoTJlkkIqk8fMVSfE
	pyhlyXP3HFRUoeA/WY4Pnr+NPC2xTYgRIMk4UePRBTIxKU1SpyiaECvAJaGiLvl8mVi0V5py
	jFcd3KlKlPPqJjRFQEjCROu28LvEzH7pET6B5w/xqv8qJggJT0WTFIH77pjV3rjT7mX73m+d
	3ss1dK/1r4xesSb5W/a4qN7N/gNXdksvSmyxm8oPM4P32/s9WkVuuG7D7O113f7oGWz4btOJ
	6/aauO4hItJ71//YnFtg8/AlLy+caytq3aFR7kkMy4xQRhCzJvgaFua9ipoxdrLhuPremkQn
	u1hdliAh1PHSBbNxlVr6F6fDGrJLAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Yunseong reported a build failure due to the BUILD_BUG_ON() statement in
alloc_kmem_cache_cpus().  In the following test:

  PERCPU_DYNAMIC_EARLY_SIZE < NR_KMALLOC_TYPES * KMALLOC_SHIFT_HIGH * sizeof(struct kmem_cache_cpu)

The following factors increase the right side of the equation:

  1. PAGE_SIZE > 4KiB increases KMALLOC_SHIFT_HIGH.
  2. DEPT increases the size of the local_lock_t in kmem_cache_cpu.

Increase PERCPU_DYNAMIC_SIZE_SHIFT to 11 on configs with PAGE_SIZE
larger than 4KiB and DEPT enabled.

Reported-by: Yunseong Kim <ysk@kzalloc.com>
Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/percpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 85bf8dd9f087..dd74321d4bbd 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -43,7 +43,11 @@
 # define PERCPU_DYNAMIC_SIZE_SHIFT      12
 #endif /* LOCKDEP and PAGE_SIZE > 4KiB */
 #else
+#if defined(CONFIG_DEPT) && !defined(CONFIG_PAGE_SIZE_4KB)
+#define PERCPU_DYNAMIC_SIZE_SHIFT      11
+#else
 #define PERCPU_DYNAMIC_SIZE_SHIFT      10
+#endif /* DEPT and PAGE_SIZE > 4KiB */
 #endif
 
 /*
-- 
2.17.1



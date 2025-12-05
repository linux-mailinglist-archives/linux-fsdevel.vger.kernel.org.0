Return-Path: <linux-fsdevel+bounces-70789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB45FCA69B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 09:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4A1B302BDB0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 07:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1735F33DED1;
	Fri,  5 Dec 2025 07:21:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347E52BD001;
	Fri,  5 Dec 2025 07:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919282; cv=none; b=RR85O1iVz/tPkzhAcemzLSWaqmheyh6a27DXYPd+eQEtMceqZVYHm+AIFLyCXNvaBtAFMUBb4hJ6X0gNxkoD83Du0N0ghp/Dh54+RJ+DjJGl1L3OZdGS3DQbav1h4hMKROUo2Mt1iWU6EK0XLytGZKVMyxqxayId32S5qsNMB0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919282; c=relaxed/simple;
	bh=d84wpX69Up+2Slr7QEqetnDG6V1J4VIb+bqVNe9ZHWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WRv+AbYyN7fE1qv2UHWNZEaDTkafnOytKAGznQsDVBZi+jInex1Svlok5pjfXQ/7LnMFfSrbIgcO5wNOzspcmkpjMHe9u5AKcpcrPAjHx/Yghvq7/cDGbKmgxSRyosA2bCfKO+jpvj//dCZQnDpolI6kE1M5OTnAsMnEwAa8Z7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-10-693287711aca
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
Subject: [PATCH v18 26/42] cpu/hotplug: use a weaker annotation in AP thread
Date: Fri,  5 Dec 2025 16:18:39 +0900
Message-Id: <20251205071855.72743-27-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxTG97+396WNNTcdc3egE5otJpo5IGrOMiJkfvCaaGJiNhOXOG7k
	xjYW1FZBNJvICi11ogNLQwGtA2otmGg7tCrFCisZQYoC0oISgREYWZGNFSqveiH67ZdzzvOc
	5ySHxhVBIpZWZ50QtFm8RknKJLKJVde+OG5IVife/nUdGAvOwnTEKAGjq5yAP4P5ElgsaaXg
	jbcVQf3v5zCwjlZQMPHyAQFvBsYwsI8sYTDiMyD4p+xfEizmJwimxgcReB35JLSZz5Mw8bQS
	A1u+l4A61x6wjJNQYfkbg1m7k4KKjm4Chh1WCu7mDVLg+quXAG//JrhWWCOBRm+bGGQxgqDV
	M4xB9/1KEp53XKSgNvgUA3fHYxxmiuOg9NWouH3GjkOfJUyBfXqSgi6fDQPHfxYCbng7SGi1
	rYFbenFL4f9LBBTW3Magp+8BgibjIAa1jgkCxqxVGLRMh0VflxmHuQEPAb0lV0mYu+4XL6oS
	ZeYFIwnnC8rETH/M4NDgj1Iw/1rMVBVJSkvjnO47GFfQtUhy9VfqETc/V4K4lvAkzundOVxt
	e5jk7lkHKE7f1E9xNtdJzu3YyFU3jmOcy1lEci96G0nuVSBAcfeGvtq79oAsJUPQqLMF7Zfb
	02Uqf8BOHBuUnjLfHMLz0AJlQjTNMltY57OU99hu1ZmQlCaZDWwoNIsvcwwTz7ovjBImJKNx
	pns9a5gtFhsU/SGzmw2i5REJ8znbs9RPLbOc2caWNo1gy8wy69m6W74VG6lYNwfnVljBbGWv
	mqIrlixTLWUNLb+9E3zCPnKEJJeQ3IY+cCKFOis7k1drtmxW5WapT20+dDTThcR3s/+48L0H
	TT3Z14wYGilXyX05SWoFwWfrcjObEUvjyhh5WJOoVsgz+NzTgvboD9qTGkHXjOJoifJjefJM
	ToaCOcyfEI4IwjFB+76L0dLYPBR3aP9C4LI/7dFUKLT48LvhzoRoQ2CHq8K2VMPP5yS/ZpMT
	+hJaOtvnBz6Sf/P1mbbRkl2PX8bYjxSf0+9O3xkt/eVMl6FQlRTrqCtPPBhp8GwaTszeFT/2
	Qpk65D8OOv2lNZ09qT/ti9LkQZ668rPq088iZ9c++za92uR5uNpZ5FNKdCo+aSOu1fFvASHz
	9bxqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRTG+793V4uXNfDFPlgju4GaXQ/dKPrQSze6QaVIrnzJ5TTZylph
	eWm5VslabJbTMssROtPULqtWYiWVZa5Vk3LpYi1Fa1GaeF0z6Mvhd87znIfz4TC45DYZwSjS
	DwqqdLlSRokI0aZledEZ+fMV864aloBOewLaO3wkfMhpIKC/T0dAcbWNglHLXRp0tZdIeO7O
	JaD1ZiWCjn4dgoFhCw5ae5CAUWMTDX2Dn2gw5SAIOpoQmJ1GHNpaH+Ngq8/B4HfNGAU9T34h
	MHl9FBR25xAQsJ5FUOS30ND9bC1873hAQtDzDQP3n14EVt8YBr6GfASj5lS4UlYXWjf/pGD4
	9RscCk2tCK56PTj86u5EUN/0GYHjRi4FXw23cXD5JsO7/gAFL0xnKPjuLMbgRw0FpbkOEpyv
	ehCUWIwI/B8dGORdq6bAXFJLgL3zPg3OnhEM2s1GDCprN0KH1U9As6EMC50bct0KB0thHhYq
	XRiYqh5gMGitoFeVI35AW0DwFXV3MF77dpTibZdtiB8eMiK+rzwP57WGUPukN4DzJ+sO8+XN
	vRQ/1P+e4h1/Sgn+ZRnHXz89hPHnX0fz9iIPvXl1vGh5sqBUZAqq2JVJopRnLVYyozPsiKnK
	i2ejEVqPGIZjF3LNRWo9CmModhbX1jaIj7OUncbVnfOTeiRicNYVyeUPFoQEmpnCbuDcaNxC
	sFHcu7GP9DiL2cXchUc+bJw5NpKrrGn4FxMWmpvcQ/9Ywi7irugHSAMSlaIJFUiqSM9MkyuU
	i2LUqSmadMWRmL0H0mpR6JmsWSPn76E+19pGxDJINknccDhOISHlmWpNWiPiGFwmFfcq5ykk
	4mS55qigOrBbdUgpqBvRVIaQhYvX7RCSJOw++UEhVRAyBNV/FWPCIrKRRbM1a8LOxDWBh9js
	yOT7XYnToxbOrNpeM9+7c/2p9kDWBq5F6uHKN7o++e2ap8EvJ7s82/BZ8T1JzJxtK5a+sb1t
	3x+ccVyqbY6dWBS97pJXcFtONVZHrAh3FVw8PeNLdrFr5WTl3jPdCxI6t8jWHIvak2ralaFL
	GG5xZtnjPAa9jFCnyOPm4iq1/C/j3+wqSAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

cb92173d1f0 ("locking/lockdep, cpu/hotplug: Annotate AP thread") was
introduced to make lockdep_assert_cpus_held() work in AP thread.

However, the annotation is too strong for that purpose.  We don't have
to use more than try lock annotation for that.

rwsem_acquire() implies:

   1. might be a waiter on contention of the lock.
   2. enter to the critical section of the lock.

All we need in here is to act 2, not 1.  So trylock version of
annotation is sufficient for that purpose.  Now that dept partially
relies on lockdep annotaions, dept interpets rwsem_acquire() as a
potential wait and might report a deadlock by the wait.

Replace it with trylock version of annotation.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index b674fdf96208..06ec3ae1446e 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -538,7 +538,7 @@ int lockdep_is_cpus_held(void)
 
 static void lockdep_acquire_cpus_lock(void)
 {
-	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
+	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 1, _THIS_IP_);
 }
 
 static void lockdep_release_cpus_lock(void)
-- 
2.17.1



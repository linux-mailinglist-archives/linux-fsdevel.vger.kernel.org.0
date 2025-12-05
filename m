Return-Path: <linux-fsdevel+bounces-70772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CF5CA6C8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 09:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C12E136FB042
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 08:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3964F315D57;
	Fri,  5 Dec 2025 07:20:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BE330507E;
	Fri,  5 Dec 2025 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764919198; cv=none; b=ZpyouSwVjMxRdxE9fIicDVlUXz/ERVWOTHrYUkC7qatDcq2qq4ry8PoadpK0DJ2k/UbjeVP95Bj8g3157jGRGQXdFJWtAe1TwhrTeFioBX6vhO4QRLJhqehdikxrnjVCnzKKmSBo37pqpRm4A+nXZWM02hsxi35SVux7l32t8go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764919198; c=relaxed/simple;
	bh=9t1sHMXhKTNZ11+nCqre6HMv27mPyrH9p28y+6gJZjY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=RJ+zknH5+crYDXzQGITIKT/l6CJgMpILr7rLs0Kg07CdG5M0K+opN8TAjUfzSo/bAFNd9hAl/IjrIVO0i0t/6w6BoOlvV3UACY9kUAgJi/FMZb5zYBq4QqOO1EX0j6J/IZ2sjffF6Mv7RORnxt65yl1Q4EzOdYJXNfQobSi536k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-a3-6932876e9065
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
Subject: [PATCH v18 14/42] dept: apply sdt_might_sleep_{start,end}() to dma fence
Date: Fri,  5 Dec 2025 16:18:27 +0900
Message-Id: <20251205071855.72743-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251205071855.72743-1-byungchul@sk.com>
References: <20251205071855.72743-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSb0xTZxSHfe997x86m1yrxjuXBdPMsThlluByXJZJshlvTJZsMTNGI7Ox
	d9JQKiu2gsm2ihZIdeIYLVFAarW1sSDYIgqKFhzbULpV2GhZQWQynKFFJaUGBLHW+OXkye93
	zvPpsKRsgFrOqrX7RJ1WqZHTEiyJLrSv0ZZmqNc2nnsHykw/wODwKAX9B30Y5qovM/B7sBhD
	4IIbwfBUGQJT6zyG2HSYgVDgBgnjNycRWEZGaah6eBDDw65NEB2+SsH80AMCgvEIglFfKYI5
	ay7U2b00jFsf03B6ZIiE5l/vIui2HKEheqeGAFtxOwW11RUIrLUeDK332hgYtFYQ4PZ8nnDT
	YL24DKqrDhGJ8T8BPWcGMTiNK6Ha30fBv66TDMyOKGCo3ILhQvRPCsbHKmgY/q2EgsvGewx4
	7vdTcLrkLIZr7d0YyuZiCPraamg42nSJgrv18xQEfLcp6HUHMDQ+CBEQ9pcz4AjeIcDr7yGh
	YcJOw88TYwjG404SBqoiDDinHjHQ67MRWSrhvLeFEEy9c7RQf6oeCTHHIVIwHU/QzcgjUnDc
	jtDCzNTftNAet2Hhlp0XfvKvEVpPDjHC4ev/MILNoxcO/xKlBK9r1Rfp2yUfq0SN2iDqPvhk
	lyTHVNZM59dIC7tHurARzUrMKIXluUy+rvk++ZoHW1qJl0xzaXwoNJ3Ml3AreO+PY5QZSViS
	60vlS6ePJYvF3Je8uc2EXzLmVvL+8i7GjFhWyn3Iu2rSXjlTeXeTL7mekogtwZkky7h1fJ35
	adLJc3UpfMlknHh18Cbf4Qrh40hqQwvOI5laa8hTqjWZ6TlFWnVh+u69eR6UeDjnd7M7rqDJ
	wJZOxLFIvlDq269QyyiloaAorxPxLClfIo1o1qplUpWy6ICo2/u1Tq8RCzrRWyyWL5NmxPer
	ZNwe5T4xVxTzRd3rlmBTlhuRPFuevQ2rvnny7G1jw+ZPt7hXhHP/si9q0j/Pn3mqcH6/+Yol
	y5Ch6Phq2+7Kis/a0sKORu0Jw3+rU2sd9nc3OPIyTxW37Fz9rKMnSy+BE8bC5wNP1vVe6ztw
	5v1Kecn6/k2Lg7E/3tO+MTZxtNIWzk/buPXS1qU9hcFbetf6j5Z+G1sgxwU5SsUqUlegfAHv
	nuzGbAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTYRTHfe599uw6Wl2W1KWibBBCoLmoOJCUEeGlKIqIXr7YTS853Ky2
	suyFUlvO9WazTWqWZjpCLW1auWokipap5LJSSjNhabKVUZo5t2wafTn8zvn/z5/z4TC04pFk
	HqNOOyzq0gSNksiwbMvq7GhtznJ1bH4rgNFwGnr6PBJ4l1mPYXTEiKGwqpJA0PZICkbHNQm8
	6MrC0HGvAkHfqBHB2ISNBoNzEkPQ3CyFkfEPUrBkIph0NSOwus00dHc8o6GyNpOCn9V/CHgb
	fyCw9HsIFAxlYhi2X0BwfcAmhaGmBPja90QCk72DFHT98iGwe/5Q4KnPQRC0pkJRSU1o3fqd
	wET7KxoKLB0IbvX30vBj6BOC2uaPCFx3sgh8zntAQ6dnJrwZHSbQYjlP4Ku7kIJv1QSKs1wS
	cLd5EdywmREMvHdRkH27ioD1hgOD89NjKbi9AQp6rGYKKhyboc8+gKE1r4QKnRty3Z8LtoJs
	KlS+UGC5+4SCcXu5NL4M8WOGS5gvr3lI8YbXQcJX3qxE/ITfjPiRsmyaN+SF2kbfMM2frTnK
	l7X6CO8ffUt4169izL8s4fjSXD/FX2mP5p3Xe6Vb1+2RxSWLGnW6qFu2Zq8sxWCsJQcL5cda
	+pvwGRSQmVA4w7EruJ6HTmqKCRvFdXeP01McwUZyNRcHJCYkY2i2cxGXM35pWpjNbuNMjw14
	ijG7hGu/3CQ1IYaRs6u4O4VR/zIXcRXV9dP28NDY0uWfZgW7kisyjUnykKwYhZWjCHVaulZQ
	a1bG6FNTMtLUx2KSDmgdKPRO9lOBK3VopDOhAbEMUs6Q1x9VqRUSIV2foW1AHEMrI+Q+Taxa
	IU8WMo6LugOJuiMaUd+A5jNYOVe+cae4V8HuFw6LqaJ4UNT9VykmfN4ZdJWPMQktUc72+O0d
	JZt2bV27eUPS7vPrcd33toC8ZZlT1TjxNFdFbgtFkXG/w9+5396bE5bfZT7tIYOJX7yDFd6F
	OaWO59dUL9cGXy04acqqyg0r1Z3wajuP7zs381ldoyYySXs5MZDUdndHfFxCCnNrYb551uLh
	TYf82OljYxkl1qcIqqW0Ti/8BQUTA21KAwAA
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Make dept able to track dependencies by dma fence waits and signals.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 drivers/dma-buf/dma-fence.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index b4f5c8635276..b313bb59dc9c 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -16,6 +16,7 @@
 #include <linux/dma-fence.h>
 #include <linux/sched/signal.h>
 #include <linux/seq_file.h>
+#include <linux/dept_sdt.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/dma_fence.h>
@@ -798,6 +799,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 	cb.task = current;
 	list_add(&cb.base.node, &fence->cb_list);
 
+	sdt_might_sleep_start(NULL);
 	while (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) && ret > 0) {
 		if (intr)
 			__set_current_state(TASK_INTERRUPTIBLE);
@@ -811,6 +813,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	if (!list_empty(&cb.base.node))
 		list_del(&cb.base.node);
@@ -900,6 +903,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		}
 	}
 
+	sdt_might_sleep_start(NULL);
 	while (ret > 0) {
 		if (intr)
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -914,6 +918,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	__set_current_state(TASK_RUNNING);
 
-- 
2.17.1



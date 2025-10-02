Return-Path: <linux-fsdevel+bounces-63233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F536BB2F81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F2E83A6872
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE772FC02F;
	Thu,  2 Oct 2025 08:13:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6982F7ABE;
	Thu,  2 Oct 2025 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392823; cv=none; b=LJDbw5/3EDCyfQ9ox0ZHxfWydBHEe2OAa6C7M7RZkzsIEwC112NZje9gvSj8KeblRpB/T/l6Chcfem87esPM/kUoovTWgzoCLjhwpVsjLBUZlK2Af5xY0WsP4ujTYaAMrh49KClKegSNApZsDU/Byhqmg7vZs4zCWSARhAU1YZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392823; c=relaxed/simple;
	bh=/eJEKpM6DvD7cP5eiSm/CQ1e5JaHdLSiARPtkWa6PhY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dFRpCH3l5iX+3Ok/wSiKyk+5yjScRD+QHDYuiUrTHvXvTKgKgf7lENq6dnJaHAthpot/351EBxbO9pGUGt0X3yfiEM55gmHoIMgtqC0+AXIrNL0vh99LKm7wgXL95XZcRWJ6scd92Kx+oUBhKTJNiMtlye5tw3KsPzn4scsDscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-6d-68de340f44eb
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
Subject: [PATCH v17 17/47] dept: apply sdt_might_sleep_{start,end}() to dma fence
Date: Thu,  2 Oct 2025 17:12:17 +0900
Message-Id: <20251002081247.51255-18-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSbUxTZxQHcJ9773NbGqrXauJVmC9VNL6AYtCdGbeoQb0LMTr9YKIxo4Gr
	bSxgWkAgmpQ3JQZRUUCkuiLaEVpobeNGWRFFRQ0irShWBWy11hBgqGtBFOwA47df/ud/zqcj
	JCWdeI5QkZzKq5JlSiktokQDoZWR02J65KvO5yyFgL+AAq3JSEOBpRyDo86AYPhLBQn5tiAF
	/pGXAgg2tiAodRaT8J/5Kw0lHi8NvXe3QrD7HQHPhvoR6L1fCfDePI5grPQg/HHZSkNjdQ4N
	b09fJ6HDOxWeBAZpGHBqCfjXTIMupxHDxYpiBLlVJhps7gYBOPtGCegqLSbAYNkGr/Q+Ckqv
	zYKKslwCSmr/IWBEXyOAh1VdFOg1ETDqiYagLgW6T5VQUDfQjqHPV0zDq3vHMPytcQvA/8RD
	gLHQR4LlTSeG8ktdNNgbH1BQMOZH0FL/moCOBi0NhebrGHqMQQyaimEMjw0OCkzvXAS0ttyn
	oL2hFsPVZ04CPG4XBmvbQxKGisI2JHLD+UUUV2P9i+CMl4yIu90/SHJ51sPc1dZ+mvsceEpz
	Z9oiOduFbgGXd+OFgNNZ0ri8OwOYs1Yv46rsvQRX+TGAuRd9P++I2iNan8grFem8auUv8SL5
	NYeGPKQVZ9gdj7AGjYpOoBAhy8SwtvtP6e8+U2maNM0sYV2uEXLCM5n5rPWkD0+YZFrD2U7n
	ignPYH5jgwE/NWGKiWDdpuzJvphZy3p8ZejbzXmswXxzMg8Zzzs8rZN9CbOGzR/MI04g0Xin
	LIR9/HYMf1uYzd6qdlGnkViHptQgiSI5PUmmUMZEyTOTFRlRCSlJFjT+bfqjo3vr0UfHrmbE
	CJE0VOyI6JZLsCxdnZnUjFghKZ0pjq/ukkvEibLMLF6V8rsqTcmrm1GYkJLOEq8eOpwoYQ7I
	UvmDPH+IV32fEsKQORr0p4HfPteV1RR1j1F++mlHhH16bmR9dmyBJKxtfxxGsdr2jHXtue8X
	pTWfi51xITzcvadj5xVHzssFS61F7uOnzEZ13JFC349vftUdsen3BcvOLs+aUlP7fKFr4yao
	89p+iH++5YM9bvPefPbolqHCJnGM3prgz05bvO9WVe/a3dGhUkotl0UvI1Vq2f+WFdoJaQMA
	AA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTcRTG+9/XOZpcluHNomJlRqQVZRxKoi/RpTcSo6IvuerWhlNjK9Mi
	2NSZlNYcTMtZ+ULDdDl1FlkZomTUsrZZFuXUlW2V2iC3ypyuzejL4Xee5+HwfDgCXHyPjBPI
	s07xyiypQkIJCeGezQWJ0RsGZWt9LZugX9NJQMBfTECVxUxBces1EuxNjQiGAsUIfk0ZcdC2
	hwiY1vfQ4J/8QEOoowdBuUOPg7lNg8FE8wwFo90/EBjcIxRUfNUQ4DOVIKj0GGn4+mQ7jA89
	JCHk8mLw9ucYAtPIDAYjnRcQTJdnwM1aKwVTva9wqDDYEdS4XTh8aQ6bbT2DCDrq8yn4rLuL
	Q99INLwO+Ch4ZrhEwbijCoPvzRRU53eQcN2oR1BQZ6Gg/HorAe3DD2hwjAYxGCjXY9DYuhuG
	TB4CbLpaLNwvnGqJBWNFARYeXzAw3HmIwaSpgYYXdQMEmNTxYOztI+FjfSUNQfc6CFVnQ0+j
	lwbXFQMBTeOvyK0GxP3SXia4Bus9jNM6pynOfMOMuKk/esT5bxXgnFYXXrvHfDhXaD3D3bKN
	UdyfwBuK6/hZTXDPa1murDeRa6900Vzh4/f03k2HhCnHeIU8h1eu2ZIulLXY1fjJKlHuI/tL
	Uo2CwosoSsAyG9iyGgsVYYpJYN+9m8QjHMMsZa2lHjLCOGNbxPY7Vkd4HpPKhgJ+IsIEE88O
	WzSzeRGzkXV7KtC/m0vYxubOWT0qrPe5bbN5MZPMan2FmA4Jq9GcBhQjz8rJlMoVyUmqDFle
	ljw36Wh2ZisKf5PpfLDsPvL3be9CjABJ5ooc8S6ZmJTmqPIyuxArwCUxovT6AZlYdEyad5ZX
	Zh9Wnlbwqi60UEBIYkU7DvDpYuaE9BSfwfMneeV/FxNExalRW8LwYufmbue+T4a5Eylpu++s
	XbZG6lTsWvnG3Jbi2QNpuh2p7xMpPPfqnONe70Tp+rTY/uffng7OXF1hj3+sUBO3zxlVitES
	x2/N2NudT5HTXPrgQHRqnKypvsS7y2pLXl50LrTgQ862IzXBpfMTajJPHNyvrXPkB4rEP2It
	SUUSQiWTrluFK1XSvylOh+5JAwAA
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
index 3f78c56b58dc..787fa10a49f1 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -16,6 +16,7 @@
 #include <linux/dma-fence.h>
 #include <linux/sched/signal.h>
 #include <linux/seq_file.h>
+#include <linux/dept_sdt.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/dma_fence.h>
@@ -800,6 +801,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 	cb.task = current;
 	list_add(&cb.base.node, &fence->cb_list);
 
+	sdt_might_sleep_start(NULL);
 	while (!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags) && ret > 0) {
 		if (intr)
 			__set_current_state(TASK_INTERRUPTIBLE);
@@ -813,6 +815,7 @@ dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	if (!list_empty(&cb.base.node))
 		list_del(&cb.base.node);
@@ -902,6 +905,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		}
 	}
 
+	sdt_might_sleep_start(NULL);
 	while (ret > 0) {
 		if (intr)
 			set_current_state(TASK_INTERRUPTIBLE);
@@ -916,6 +920,7 @@ dma_fence_wait_any_timeout(struct dma_fence **fences, uint32_t count,
 		if (ret > 0 && intr && signal_pending(current))
 			ret = -ERESTARTSYS;
 	}
+	sdt_might_sleep_end();
 
 	__set_current_state(TASK_RUNNING);
 
-- 
2.17.1



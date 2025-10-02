Return-Path: <linux-fsdevel+bounces-63216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CE3BB2CDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DBDB1C7B9B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165962D320E;
	Thu,  2 Oct 2025 08:13:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DFA2D248A;
	Thu,  2 Oct 2025 08:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392791; cv=none; b=OlmlhvuHZCw0A175LUM2ovfnZpV0ld0XD2irw3IhId07awyyQ+Yy1f2xcBgp+vWnifNr7yXkYhYnTZkAIGuaNbHQnRXNfbHpCw+fMzCQvUKuOBWZ6WDlAgbTYeHb6DyEwzgp6FrMBNm+OkxGsupZZ6KV8z9Qt8FQWmd708rmkMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392791; c=relaxed/simple;
	bh=3Zh+zlzRVCm9Hj+K3bqcWocG336nnF7TjoNWNl0DnFE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Kz6Qnt9RYqHqvBM3b1MXia5/Ib1c0Jj6fBTKcGD6Hnnkiljj0rnLNlgka2t+yT4Ic7yXZ8kciVezZL34EpaGWIAts/gGxntXVhqrdCD6+Z8ZD1TLMnCS9rxOkBRAFJEzNPc3lJr5h6WNrlQ/G9AN3rDe7sOURDAEFweu9VGtEAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-41-68de340a6dd2
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
Subject: [PATCH v17 01/47] llist: move llist_{head,node} definition to types.h
Date: Thu,  2 Oct 2025 17:12:01 +0900
Message-Id: <20251002081247.51255-2-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTZxjHfc9539PTSs1J58ZRFi9N0IjOK1sek2UaP2zHxHjZEhLlgx7H
	iW3kYoqgLFlWHHWdwQ3ZBlnpJlipDbSiLchF3bAoXpDRUqUF5TZEJKWyGFqi0GGB+O33/P//
	/D49LK3yk6WsNvO4pMsU09WMAitCcRUfLUzu02y0NC6CrvxmDOEJIwZzjZ0Bo/N3Ap7L1Qj6
	w0YEk1NlNBgaZzBEi1tlUOItpiHY8gpB6Wg+hnFrIYLRO19AqP86gZneEQr8kTEEz5p/QDDV
	3kFDbWsfguGiOhoehccZCHnNFJT84cTQONAkA29wmoqZGCi5Gg9lpS8o+M1xnYKHlqcYrPpE
	KGv3EZge3AQz5VlwOdRBoP/uaQL1+gEZOLvvIJh4NEiBvfA5DcamMAbnUBeBmz1roeL0RQw3
	bt7HYIxOIGht+JcCX5OZgcIrdQT67DME9GWTBDqrPRhqRgIUdDQ5CFT6vRQMDgQIuNof0hD5
	KQE8584SCBQNI3C8vMBAZ3M5Bfm3LHh7mlDlukYJhs4oI9j/tCNh6k0xEiYqv6cFQ1HsLHCd
	ECrbxhjhTfgxIzy4wAuNpl6ZUPBXj0wod+YIBbdDRHDZkgTLjVFq74YDik/TpHRtrqTb8Nkh
	habfXUOOVShOdoZeIz36mz2D5CzPJfNPPLXkHd8NmphZZrjVfCDwmp7lxdwK3nX2+dyG5to+
	5Lu862b5PW43b+64F8tZFnOJvGFq52ys5D7m+yxuPK9czldfaZ7TyLlPeN9g21yuim0M4wXU
	/KZUzrtP7ZznJfwtWwAXIWU5WlCFVNrM3AxRm568XpOXqT25/uusDCeKvZv12+nUBvTK85Ub
	cSxSxyk9ib0aFRFzs/My3IhnafVi5SHbU41KmSbmfSPpsg7qctKlbDdKYLE6Xrk5ciJNxR0R
	j0tHJemYpHvXUqx8qR5Z20h31gfnLSnq76LLV+n+o3ocjrhw4s9BeTTlSJXN9M+v8Qn+XXrX
	ly3mYJ5/t/jMZByqt61RRtSHl1lHIhcTfvz/VGoSGa9f2XB07IF46ZdF+z737YPcl6ny/XXw
	2LBj//tD27a0rOs2LkvduiZlz+bbG5nanLjJtaaVl3TDvoNqnK0RNyXRumzxLYONK9hqAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTcRTH+923q8ltCd4eUA1GEGUFPQ69KIi6PawgSIgil17acj7azDKI
	NDcSe63BtDYrmzVEV86pkYkli2ZlsubKopy2WGbMOShXrPloK/rn8Dnf75cv54/D4JJWcg6j
	zCsU1HlylZQSEaLd68qWilYOKJZfGpVBX2knAZGxcgKqG20UlDuuk/D6fgOCwUg5gl8xMw66
	tikCJgwuGsaiH2mY6nAhqPQYcLC1lGLwwz5JQfDpdwRGf4CCqm+lBIStFxGYhsw0fHu2DUKD
	7SRM+b5i8O7nCAJrYBKDQOd5BBOVOXDL0kxBrMeNQ5XxNYLbfh8Ow/a42eIaQNBRd46CL/pW
	HLyBZHgTCVPwwniBgpCnGoNROwU15zpIuGE2ICirbaSg8oaDgLZPj2jwBMcx6K80YNDgSIdB
	6xAB3XoLFr8vnmpKBXNVGRYfwxgY77VjELXW0/Cqtp8Aa4kMzD1eEj7XmWgY96+AqZp8cDV8
	pcF3xUjA/ZCb3GRE/C/dZYKvb36A8breCYq33bQhPvbbgPixu2U4r9PH16cjYZzXNp/k73aP
	UPzvyFuK7/hZQ/AvLRx/tWcp32by0bz28Qd679oDovXZgkpZJKiXbcwUKQadjWTBbdGp3lAU
	laAnTAVKYjh2JdcVNFEJpthF3Pv3UTzBKewCrvnSEJlgnO2ex/V5liR4Frubq3Y/j+sMQ7Ay
	ThfbnpDF7CpuoNZJ/KuczzXYO//WJLGrOa+/+68uiWd0YS2mR6IaNK0epSjzinLlStWqNE2O
	ojhPeSotKz/XgeLPZD0zfvUhGvNucyKWQdIZYo/Mp5CQ8iJNca4TcQwuTRFn1vUrJOJsefFp
	QZ1/WH1CJWicaC5DSFPFOzKETAl7VF4o5AhCgaD+72JM0pwS1PRFbsGDR1yz9+w7fw3vyjh5
	KD32JqN3+c5wptuSNb099czz4abrm/dvNejXR2ZOOtL9FX0bqi++NS107Jrh0arMXX5vLAjH
	PD77g3u9MdXB6M0t2JX6ztQTybKzhsJW8ZrRgkCJ7U5geqjvnWmXJauiJZjSRth1H1l38vFh
	rZTQKOQrFuNqjfwPFrroz0gDAAA=
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

llist_head and llist_node can be used by some other header files.  For
example, dept for tracking dependencies uses llist in its header.  To
avoid header dependency, move them to types.h.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/llist.h | 8 --------
 include/linux/types.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 607b2360c938..6bcdf378ebd7 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -53,14 +53,6 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
-struct llist_head {
-	struct llist_node *first;
-};
-
-struct llist_node {
-	struct llist_node *next;
-};
-
 #define LLIST_HEAD_INIT(name)	{ NULL }
 #define LLIST_HEAD(name)	struct llist_head name = LLIST_HEAD_INIT(name)
 
diff --git a/include/linux/types.h b/include/linux/types.h
index 6dfdb8e8e4c3..58882a3730eb 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -208,6 +208,14 @@ struct hlist_node {
 	struct hlist_node *next, **pprev;
 };
 
+struct llist_head {
+	struct llist_node *first;
+};
+
+struct llist_node {
+	struct llist_node *next;
+};
+
 struct ustat {
 	__kernel_daddr_t	f_tfree;
 #ifdef CONFIG_ARCH_32BIT_USTAT_F_TINODE
-- 
2.17.1



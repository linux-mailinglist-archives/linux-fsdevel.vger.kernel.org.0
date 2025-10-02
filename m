Return-Path: <linux-fsdevel+bounces-63229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43935BB2E8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBDD19E1E3E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6C32F5A0C;
	Thu,  2 Oct 2025 08:13:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4BD2F360A;
	Thu,  2 Oct 2025 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392818; cv=none; b=rCB+cW+20VO/YTymRG98bRmaKfOQ9nXmxo1lAxfHzNIVYYC69s+tRcCnOOaYO4n2rRB4F26lqZKBuNErwtkUTfbeOrfeZ5uQ6v4V8JPhyrvCuhvmaGQRyMfOTZ9ahAMft8C4zy0Ncbx5a7ytYHwSO7ra4x1cIoMuMCpm8m5/Yjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392818; c=relaxed/simple;
	bh=pNI3eGapaQs3nziYPiCTw39bLJ6s9RWr9dOeaQ3pi6g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=b3HbEn5Q3xQN7egxB5ePX/JIix1i/X34s2W4+LlvJVLtog09lWxqznKTGVfM39hS7XvV8yd10ZFSxzDUNsmpAbLSKgl0l3GJUofh89TeP8KTvyow9OhBf/r2t9rqXq49f2Eu5YbBugD29ulAL2FXRUXoJm0T1+CrvH71m8d5CLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-2f-68de340eaa25
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
Subject: [PATCH v17 15/47] dept: apply sdt_might_sleep_{start,end}() to waitqueue wait
Date: Thu,  2 Oct 2025 17:12:15 +0900
Message-Id: <20251002081247.51255-16-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAz3SfUzMcRwHcN/f0z3U5ecYP5Wna2EiZeEjZrZGvz9smKmNjW71m7u5Hnbp
	4VhcUgq1yoqcHk9Xq6PcZUm1HpyRq3YVOURiPY2urRxSosvDf699Pu/3568PHxdfIV358ojT
	nDJCqpBQQkI45ly8aaHfO5lP24gL3KrSU5BqyCPBcrcSQb89FcG3aQ0OyXW/CPj0aALB6ONA
	GOuvJ6GwxEhBY/kFCmzVFCRpqyjIzTcQ0JebjUG/bogAc2YJBrn3loHm+ggGU7oKHrRr+wjQ
	qT1B09FDwsyAL9Sq3/Pgy/MBDFIf2glofO0FDY1tBFytvk9C1bAVg9KXXRgYO9pxsGSlk3DH
	VkKBzj7Og8QWLQEpk7MklH6x4ZBy+x4GpqpaDIZv5mNwrbuIAqMhB4fe7EIKfpQ9RlDZRYAm
	MQPt8WGTu39SrL5Aj9hS82eKrbv5lscWGWJYY/kGVtswirHFE3aSNVSkUayts5PHPr0xTbDF
	6hycLWg7xDbl63nsm9mPOJueZKMOLj8q3BXGKeSxnHLz7hChzDSmJqIyBPF5Tx5SapTOu4wE
	fIb2Y/Qpdf/d/L5/3hS9jrFap3CHl9CrGWP6EOkwTpvdmd6ujQ4vpoOYS5k1mMME7cm8sGjm
	8yJ6G/OqKw39ubmKqaxunp8L5uY9A2bCYTG9lUkevzjXFc5lCgVMQZb9b2E501JuJTKRqAgt
	qEBieURsuFSu8POWqSLk8d6hkeEGNPciuoSZYw/QhOVwK6L5SOIssni+lYlJaWy0KrwVMXxc
	skQUUt4nE4vCpKoznDLyhDJGwUW3Ijc+IVkm2vI1LkxMn5Se5k5xXBSn/LfF+AJXNcLHTxV2
	e/q2yOL1OzyynHx27guIOhC7Ouu7dtJpxr+p+bh7cHzAIsV++7mNo+unpm8sbY7scdcfeZJj
	uj+zf98ra++H7lC71Xswrn77IZ3vgP/weJBb9eCzmsAk1dmVqsDrgeHtprUJcZ3nY/YWuHit
	bxvhmbwWmD1elvHX4ME1uhUSIlom9d2AK6OlvwHhkwOkHgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG+5/z3zlzNTssq5MV1UKimyVovFRE9aVDFymEigh05aEtb7WV
	aRB4G1mWzcG0uaylNMVZzltkMhlaVproUrturYVp5swuLjG1tRl9efm9z/Pw8nx4haTkviBU
	qEg+wyuTZYlSSoRF0Vuy1wdHvpdvvOZdCi8zbRi8Y7kYblRXUZBbqxdA9z0zApc3F8H4pIEE
	daMPw7S2jYaxiXc0+KxtCArtWhKq6jMJ+Gn5Q8Fw6w8EOnc/BUVDmRhGTVcQFA8YaBh6vAtG
	XE0C8DkHCXj1y4PA1P+HgH7bRQTThQlwq7SOgsnOLhKKdN0IbrudJHy2+M36tvcIrBVZFHzS
	NJDQ0x8Mvd5RCp7p8igYsd8g4KuFAmOWVQAlBi2C7LJqCgpLajE0fnhIg314igBHoZYAc+0+
	cJkGMHRoSgl/P3+qZiEYirIJ//hMgO5uEwETpkoanpc5MJgywsDQ2SOAjxXFNEy5I8BnTIE2
	8yANzms6DPdGugTbdYgbV+djrrLuPsGpX0xTXNXNKsRN/tYibuxONsmpNf611TNKcjl157g7
	HR6K++3tozjrLyPm2ktZrqBzPddY7KS5nOa39P7NR0Rb4/lERSqv3LAtTiR/NJKBT+UHpemf
	PKQy0FX6MgoSskwka/vgmmGKWcW+fj1BBjiEWc7WXR0QBJhkOpawL+3rAjyPOche1NQTAcZM
	GNvXbZjJi5lN7Bv7JfTv5jLWbLHN6EF+vcfdgQMsYaJY9WgOoUEiI5pViUIUyalJMkViVLgq
	QZ6erEgLP56SVIv832S6MFXwAI317GpBjBBJ54jtYU65RCBLVaUntSBWSEpDxHEVDrlEHC9L
	P88rU2KVZxN5VQtaLMTSheLdh/g4CXNCdoZP4PlTvPK/SwiDQjNQ0gPl6bXOdscS3jO5vCB2
	ZaqxOeaLNXZBxM89ZbZbBu/eho95MXnu/MiJGv3dceabqzxm6+ya+nKfdVtctLJvZ7AOO4rT
	Oo95jCuiQr9fXzb8RfE489Pg0/SS1fO9c4eI55fzsuZdMEZf793etNK+Rt910nLgQPvRvYcX
	DZj1O8qbpVgll0WsIZUq2V+wmf0QSQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Make dept able to track dependencies by waitqueue waits.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 09855d819418..65dd50f25e54 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -7,6 +7,7 @@
 #include <linux/list.h>
 #include <linux/stddef.h>
 #include <linux/spinlock.h>
+#include <linux/dept_sdt.h>
 
 #include <asm/current.h>
 
@@ -305,6 +306,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 	struct wait_queue_entry __wq_entry;					\
 	long __ret = ret;	/* explicit shadow */				\
 										\
+	sdt_might_sleep_start(NULL);						\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
 	for (;;) {								\
 		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
@@ -323,6 +325,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 			break;							\
 	}									\
 	finish_wait(&wq_head, &__wq_entry);					\
+	sdt_might_sleep_end();							\
 __out:	__ret;									\
 })
 
-- 
2.17.1



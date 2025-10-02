Return-Path: <linux-fsdevel+bounces-63224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E122BB2E43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E1DC4A31E7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2919E2EE5FC;
	Thu,  2 Oct 2025 08:13:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8257D2EB849;
	Thu,  2 Oct 2025 08:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392809; cv=none; b=slZS15mlPcUt7O7pozG6/brYr6mAWW/kXxpeyEPhEM90t1yxXlx9eQlgC5kEpxfU6tu64+6tMh1yrCMkOmPxZwVpwXlsxqHeETRKE45IRVtToJIMId+LvzrB9fLTDBqQ42UfO75u83PkziyEN/R1r4z/n1Hysp+1AVs2fe1QqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392809; c=relaxed/simple;
	bh=ARgkPBXeh3Qqcqmd0S+vaMsLgXB5DnOPrEodx89W1JU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UrPyVJA1dHJYBKJfjd6bpVGreLXt3jJI/Sv3ay4RGKsCcLT2LQrSUKK+muYwJIFlCs4E9quiBUptArd610675aqtoOwvMmdgiJ7QtVbe7xOovwzdN3Cr/KYzdvD9VMl0dwnt/5ZO2UtRtWQltbSei0IuMP15wuK2njpbTFKs+Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c45ff70000001609-5e-68de340df6e9
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
Subject: [PATCH v17 10/47] dept: distinguish each work from another
Date: Thu,  2 Oct 2025 17:12:10 +0900
Message-Id: <20251002081247.51255-11-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSa0hTYRgH8N5zzs7ZlqvTEjqVUCyki2kaFk8XpLDgDQqCgrI+5MxDW80p
	00yDatIF80ZZy/SoaV5aXrBm0XQT1NLKG/PSvLSZlmWZJllpucS80Lcf/+d5/p8eMSlPEa0Q
	q7VRvE6r1ChoKSUdccv1lvn3qnz7473AHldNQbwpXQQTLoGEqdR6Bqar6hHcaU0loeRJHAFf
	n48hmHYOEtA5PowgzWBD8PHGUxI6fo3S8NqQSENFXyUDxaYDcOfxMhDSLhNgKLUQIDS3i+C9
	MYOBZ/o+BkzddQiqerwg91o+BenZDhqsVa8paK/MpEEvTIigrdhGQdlgFwGN9a8oKOhsJaC8
	uYmEl8nVBDhShijo6LYgGMzIIqDB+YOBW205NJSbDCTYU+/RIMSlIIh/MU5C1k8/+FlcREPp
	lB2BUNfL7PLFJdklCLsmUxF+PjxK4oLGYRpP/npD44oMJ4NzTGdxuXEDzrN+IbCp6DqNc12f
	SeywW2n8raWFwRX92/BARxqBc/UG8qDHMenOUF6jjuZ1mwKCpaoBSw0d8Y2JuZaUzeiRlU5A
	EjHH+nMDnZnov9umyuZMs2u5rq4/5Kzd2dVcefIn0axJttGDs7dunPVSNpB7e3t6rodiPbmc
	OoGZtYzdyjW8u0vNd67iih9Vz/VIZvL2/sa5XM5u4a6OXiESkHRmR5BwBbYWZv5gOVdj7KJu
	IFkOWlCE5GptdJhSrfH3UcVq1TE+J8PDTGjmSwov/D1uRmO2Q7WIFSOFm8zm6VTJRcroyNiw
	WsSJSYW7LNjoUMllocrY87wu/ITurIaPrEUrxZRimWzz+LlQOXtKGcWf4fkIXvd/SoglK/Qo
	yRrSh2vzFrl+D6XsDw744CPprnI6913cK9csWXz/4Y6xpnUtHH0z38ys6Yk6mhyISo2C2TLl
	lqf0LjKPrPc+cvVSoCuo94Fls3kwseD0iLZnXLenM6r51sEQbXtN//bMD4UhcQ0Lv8te7K5U
	x5z6fdiLCwsNOu2kpt84OlCsh4KKVCn9NpC6SOU/yH4ksyEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTcRTG+99797/baHVZQheLipUVYS9CxbEieoNuRRF9KSrIUZe2nBpb
	WUaSb0upLB1O05u1lIa5paZl6VrZwlEtyWnvOpexNNFlpBambm1GXw6/8zznPJwPR0zK60WR
	YnXiCV6bqNQosJSS7lqbuVS2sku1wtUsg3fpTRSMDOdQcK3aiiGntlgErVUWBN6RHAS/xwQS
	9A1BCiYMThqGRztoCNqdCArdBhKs99IJGKoJYOh/9hOBsduHoagvnYJB8yUEJT0CDX3NW8Hv
	tYkg6Okl4P2vAQRmX4AAX1M2gonCeLhRVodhrOU1CUXGVgQ3uz0kfKsJmfecXQjsFRkYvubd
	J6HdNw3ejAxieGG8iMHvvkbA9xoMpgy7CEoFA4LM8moMhaW1FDR8bqTB3T9OQGehgQBL7U7w
	mnsocOWVEaH7QlN3Z4JQlEmEyjcCjHdsBIyaK2l4Vd5JgTktCoSWdhF8qSihYbw7BoKmJHBa
	emnwXDFSUOV/LdpgRNxv/WWKq6yrJzh92wTmrNetiBv7Y0Dc8K1MktPnhdpnA4Mkl1V3irvl
	GsDcn5G3mLP/MlHcyzKWy29ZyjWUeGgu6/Enevea/dJ1R3iNOpnXLl8fJ1X5bE/x8e/06fOX
	rtNp6BG+gCRillnJtk1UozBjZhH74cMoGeYIZh5bl9sjCjPJuGaz79zRYZ7BbGY7CoKTuxQT
	xZqaBTrMMmY1+9J7lfqXOZe11DRN5khCenu3a1KXM6tY/WAWkYekJjSlEkWoE5MTlGrNqmW6
	eFVKovr0ssNJCbUo9E3m1PH8h2i4fasDMWKkmCpzR3lUcpEyWZeS4ECsmFREyOIqOlVy2RFl
	yhlem3RIe1LD6xxolphSzJRt38vHyZmjyhN8PM8f57X/XUIsiUxDh/mOB1FnHZskuv5T+X6y
	6Llv+tX7e7Y1OlxO4es5Z0zpDv9zx8edkhw7J3xJjaX3WS1Zqi0FHfho9OwHT4VIZmFr6fyN
	Tz4XrCmO4zdWxV6x9QcCrkMSY5eKppgVgYPRP1Lb6g8UaOYcWxBL3m70qm1Nlt7s8r4tQ8WL
	c3uNCkqnUsYsIbU65V94koK6SQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Workqueue already provides concurrency control.  By that, any wait in a
work doesn't prevents events in other works with the control enabled.
Thus, each work would better be considered a different context.

So let dept assign a different context id to each work.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 kernel/workqueue.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c6b79b3675c3..0e05648b4501 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -55,6 +55,7 @@
 #include <linux/kvm_para.h>
 #include <linux/delay.h>
 #include <linux/irq_work.h>
+#include <linux/dept.h>
 
 #include "workqueue_internal.h"
 
@@ -3153,6 +3154,8 @@ __acquires(&pool->lock)
 
 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
+	dept_update_cxt();
+
 	/* ensure we're on the correct CPU */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
-- 
2.17.1



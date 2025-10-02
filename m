Return-Path: <linux-fsdevel+bounces-63230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF50FBB2EB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F41E11884E30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB512F6561;
	Thu,  2 Oct 2025 08:13:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF072F290A;
	Thu,  2 Oct 2025 08:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392819; cv=none; b=sjXGfd/vPm9jnXsYk+m4oTEbB4/LXJ0+LpU6EuOMNnoic6hERhhD3IBQA2gqB6Mro7fO3E2ghDs8aTeoW+tpRG9RYq4QVj6dlYfXXZKr1XPOcJ/yjqi0Nl/ihZDdhly5eRqmaYwaYMDqxt6OBNWIu1j38RwQoUTYglxFI1lp2to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392819; c=relaxed/simple;
	bh=pLUSXjgVOyB6ewzDMD2B/aTj2n2b3ii/EXLHyurcTzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=MULW9Ciag/764pOIQvtzONy9Z1IGstMWqh31yhwEUM6e7Q5fwkOehjpiliuAUHYDmjQDXQBXiT4LxqpywjQWO5FvnZiWq9keb+Es5RKotObzmx3GejMv6yDrO5s5iFGoF3koeLIVeHvRSSDzUeazBluisiSGVogy9TrQjkwpQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-fe-68de340e0ecf
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
Subject: [PATCH v17 14/47] dept: apply sdt_might_sleep_{start,end}() to swait
Date: Thu,  2 Oct 2025 17:12:14 +0900
Message-Id: <20251002081247.51255-15-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxTG+d/3Vq9eOxOvzETTBEmcomghJ/ElfplcjUYTP6j4QRq5s40t
	aKsoS5Z08iIqMqwCoSgWlFpbcNjKELSKKFXokJIK6xwFa2rRCDZBwCAqtjN+OfnlOec8T3Jy
	GFzWT8Yz6qwjoi5LqZFTUkI6OrtmxVzFoGqVPyKBifEiAooclSR4b9gRDE0UIfhsdNMwPvUf
	DeW9RhzeN36h4O3DMQRlwRAFFW9+JyBiKUZgClfR8KYjDWYCwxj8MzmCINR2EsHlWicF0909
	OFSUeRHUBAM43HIPInBZT1DgC82BzrIzFIz2XsTgXSMF5hMuEvKu/ElBy4tWGgbKjRjYHdtg
	yBImwFNai0H5zQVQVZGHRctrDKYsNhoshgSo6vaR8NJqouFTMBlmzNngtg/TEPijjIDOwX4S
	3oaNFAw9LiSh2fCCBse/HQjqi8M4uJ7/BDWFVwmorB6g4K6rM3qEz+MI3LdfYlDc2ESCx/0k
	amK6TkBPawMJzu6/cfCXvkLQ8K6W2pgpfCgoIQSb8y9MqK+uR8L0RyMSxuvycOHhSAQX8p3H
	hDrPCCV8nOijBNekmRC6anmhxRSghfx7z2nB7Dgq5D8aJQWnddmOFenSdZmiRp0j6lZuyJCq
	xoJ95KEO5ri/rpU2oKfUaSRheE7BT98MYt+5uuQVHWOKS+T9/ik8xvO5JbzzbJiMMc55FvH9
	vctPI4b5gdvG2236mExwCXxhVxMZk1kulb9QHf/NcTFvb2z730USlX1BDxFjGZfCF0Tyo6nS
	6EyVhA87HMS3hYX8A6ufKEWsGcXZkEydlaNVqjWKJFVulvp40v5srQNFv83y26e9t9GYd2c7
	4hgkn816EwIqGanM0edq2xHP4PL5bIZ1QCVjM5W5v4q67H26oxpR345+ZAj5Anb15LFMGXdA
	eUQ8KIqHRN33LsZI4g0ofnDr6g68MiVuKlLyIG1WXuovvFxuSH/8c4G3pSdx97mR1LjCSEjS
	tXxT+gA9er/Zub2tb82peSnBXe7kpWv3HN5c7HuUfue84v6maz7TUOWzPg2bod29ZfF6Yuay
	NnBgB9twr6GlnDOzSecUNYsWXorbdb47rTSJsx2E5J732pCc0KuUyctwnV75FVI6IPRpAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0iTcRTG+7/3LZcvy+jNimJhiand49CNvvV2t6gMQXTVWxvOWVuZGpI2
	Z3a30Sa6sqU4zJm3aWRmiJVUy3RZJuW0hZmSJngL89ZW9OXwO89zeHg+HAaXVpL+jFJ9WtCo
	5SoZJSbEezbqQmat7VCs7MtjoTW1joCR4QwCbpcWU5BRkU1Cc4kNQedIBoJf42Yc9NXTBEwa
	GmgYHvtMw3RtAwKT04BDcWUqBkNlUxT8eDaIwOjuoiCrN5WAAetVBDndZhp6X2yD/s4aEqZd
	3zH4ONqHwNo1hUFX3UUEk6YYuJtnp2C8sQmHLGMzgntuFw49ZR6zsqEDQW3hBQq+ZVbh0NI1
	C96PDFDwyniFgn7nbQx+llFguVBLwh2zAYEuv5QC050KAqq/PKbB+WMCg3aTAQNbxW7otHYT
	4MjMwzz9PFflc8GcpcM8owcD44MaDMasRTS8yW8nwJoSAObGFhK+FubQMOFeBdOWOGiwfafB
	dcNIQEl/E7nViPhf+usEX2R/iPH6d5MUX5xbjPjx3wbEDxfocF6f6Vmf9Q3gfJr9LF/g6KP4
	3yMfKL521ELwr/M4/mZjCF+d46L5tKef6LANEeJNxwSVMl7QrNgSLVYMuj+QJ18wCW0Fj+kU
	9Ja6jEQMx67lcq9/o71Mscu4trYx3Mt+7GLOfq2b9DLOOhZwrc7gy4hhZrO7OVuR1isTbACX
	/rqK9MoSdj13K9f/X+IizlZW9zdF5JFb3A7Cy1J2HacfSMMykdiCZhQhP6U6PlauVK0L1cYo
	EtXKhNCjcbEVyPNL1uSJm4/QcMu2esQySOYjcQa4FFJSHq9NjK1HHIPL/CTRhe0KqeSYPDFJ
	0MRFac6oBG09ms8QsrmSHeFCtJQ9IT8txAjCSUHz38UYkX8K8v05Idku7l+9+bNF9/VAdnpr
	eGNw2JaIofPzZgQNhvkcj7xFb+yt25VwP5ixD21flPT8lGZJTE1IunvBwf1zXkp2Ipv+Y4+6
	0KaeLQ0NrTycnp1kEPmEJC9dPjoVeGnvUGSg6NDDt8nnjjhUHTOj1lw5saN9oc/KXcpyX2R6
	si9JliAjtAr5qiBco5X/AYx6uolHAwAA
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



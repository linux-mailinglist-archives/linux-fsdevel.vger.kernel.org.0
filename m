Return-Path: <linux-fsdevel+bounces-63239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A07CDBB2FC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC67619E36C5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D367F3016F4;
	Thu,  2 Oct 2025 08:13:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CC32DA77F;
	Thu,  2 Oct 2025 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392833; cv=none; b=b8qb09bVwd0qs3PulX4qn2Y1vMLah61DzECPE93m8AsCUKxG+V5ecE4I9pIsI2k7g11l/mDY/OjENM8GiW2hiQORIHB30T8vlw3RXiFAcNHmL+wXgndGCOhnv4/JvpScQAyzwe6ftVNB4TZdDWo/LktudFmESqhjb6QwRnoFjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392833; c=relaxed/simple;
	bh=sXq6ZG2FCPgGrD/93i05yDVFGWV/kuOXrwRc2Zt22go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JV/EiM3l/tWvooZ0kdl+SEm9By5KbPtA4jwMt4Iim8KAIOzLVXp+HjRIp7wuLNMTpSqg/toW1GRTk17eZ3BdJPvb0neSi3pzQf+yWv23pt/vBNsZEg6GaEk+DAFdrevpTJ3Hdc0YoXiPA44g78GPsgn1leKGb89/tMKSMt3RUSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-10-68de3410e76d
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
Subject: [PATCH v17 22/47] dept: apply timeout consideration to hashed-waitqueue wait
Date: Thu,  2 Oct 2025 17:12:22 +0900
Message-Id: <20251002081247.51255-23-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSb0wTdxjH97v73V3prDkPEg9103QSjWwoG7onwcxtWeK9GAmJMQaNwcZe
	aEMBLUjBxaSZYAqiQwJoKE5WhCAtUltQQUuwjLpaDIVuyDr+C1WHhcSsgiBxLcY3Tz55nu/z
	efWVkJyP2iBRZ+eJ2myFRk5LsTS4xvTFuqQx1a5a58cQ+s+AobbVQoP3phnBeMiAYGHZSMJK
	hYuBdw4XgtmeVwiqJqdpmG8sQ1ATMDLwonc/BMfvUbBSnQnXTHYaLld5EbS5xhDMlLeT4Jte
	C3+G5mlwV52nIThQS8CclYa6nx0UnK1vpaH6qg1Dx0QnAyPVFQSYbSngKTcRUH1rPRgvnyXC
	4zkBffUjGBr1cfB2MhHe1eWAy/yMgdFfqjDcDPZT4B4bomA2UEHD+MNzFNzRTzBg+7sXgaUs
	QIKhM4TB9jQccfjj4bdz1zHcd7gxuO5OEeDrrKWhzNpOgd64QMGg2YvB4/oDg7vmBob+zhYK
	Gp4MEGB/3EfC64sbwXvpAgUtcyb6W6XQbL9NCMWDK7Rg+dWChOWlCiQUl4ep5+U8KRTZdUKD
	5yUtLIX+ooVHJl7oqBllhKIuPyPU2U4JRb8HKcHetEOov/+CSI0/LN2rFDXqfFG785tjUtXC
	+ZQTF5mCGeslSo8mqVIkkfBsEj/Xk1qKolaxb+IOijDNbuOHh9+QEY5ht/D2CwEqwiTr2cQP
	DXwe4Wj2IG9w3sARDWbj+PHQqkbG7uEd/jH0XrmZN1u7VzVR4b1v0oMjzLG7+eL5IqIUScOZ
	a1H8v3NP8PuHWP5B0zAuR7I69FEz4tTZ+VkKtSYpQVWYrS5IOJ6TZUPhqjWeeXvkLnrlPeBE
	rATJ18i8caMqjlLk5xZmOREvIeUxsmNNIypOplQUnha1OenaUxox14k2SrB8vezL1zolx2Yo
	8sRMUTwhaj9cCUnUBj062pd8PGB9Yx5Njs3bk3olb3HTZqp5LX2PMSZeme342rL1ZLe0Wadp
	O3y190B69/XK9JTbJWmGkv2hSvfuWO67xU8GY/ivkqeW/3leEs+4/aR/e5d9JvFQ5WdDP/R8
	37q3wfww+oz2xywf1ygk6DL6H3+asm8LlyZKOeVPS57hZzo5zlUpEneQ2lzF/0qFRe9mAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTcRjG/Z/zPxdHi9OSOllQTCwIzYSMl7LLtw7diC4EEeTIU1tOV5uZ
	BpW31SqruZiWs1pGw6bVmnYxW8iidTGpaTfKuRZqRi6pNsVbthV9efm9z/Pw8H54WVLWSMWz
	qpxcUZujUMtpCZasX1qSzC3qUi7seYzhbVELhnDIgKH6Zj0NBud5Cl7dqEPgDxsQDI1aSNA3
	TWAYN3kYCA1/ZGDC5UFQ4TWRUN9YRMAvx28avj36icAc6Kah8msRhgFbGYKqXgsDXx+vgqC/
	mYIJ3xcC3g32I7B1/yagu+UYgvGKLLhU00DDaNtLEirNrxBcDvhI6HNEzEZPFwJXbTENPcbb
	JHR0T4bX4QEanplP0hD0VhPw3UGDtdhFwQWLCUHJlZs0VFxwYmj6dJ8B77cxAjorTATUOdeB
	39aLodVYQ0Tui6RuTQdLZQkRGX0EmK83EzBsszPw4konBlthIljaOij4XFvFwFggFSasGvDU
	fWHAd8aM4UbwJbXSjIQh/Wks2BvuEIK+fZwW6i/WI2F0xISE0NUSUtAbI+uj/gFSKG04IFxt
	7aeFkfAbWnANWrHwvIYXytuShaYqHyOUPvzAbFiyTZKeKapVeaI2ZXmGRDl0ct3e00x+j6Oc
	KkQB6gSKZXluEf/i010UZZqbx79/P0xGOY6bwzec6v2bIbnWWfxbb1KUp3JbeIP7Gj6BWBZz
	ibw/vCEqS7nFvOtDF/pXOZuvc7T8rYmN6B2BVhxlGZfG6wdKCSOSWFGMHcWpcvKyFSp12gJd
	lrIgR5W/YKcm24kiv2Q7NFZ+D4U6VrkRxyL5JKk30aeUUYo8XUG2G/EsKY+TZtR2KmXSTEXB
	QVGr2aHdrxZ1bjSTxfLp0tVbxQwZt1uRK2aJ4l5R+98l2Nj4QpReusY6edfS8I6spw8SypKM
	6rl9M+5Mur9xGQQ2JVSnNAXPlrmOJ6wPZPoT3bI9aUdU22OC16uneqalJgeOHko5p7GP5cZf
	2i+nvUeGRpL2TRm0zmw/vGtLXLNz94/Q+AO7/N6y/BkrtxaPPJmtUayI6TdU6ds3b9ak58vS
	5iwxrj0vxzqlInU+qdUp/gDN8B3kRwMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to hashed-waitqueue wait, assuming an input 'ret' in
___wait_var_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait_bit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index 179a616ad245..9885ac4e1ded 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -258,7 +258,7 @@ extern wait_queue_head_t *__var_waitqueue(void *p);
 	struct wait_bit_queue_entry __wbq_entry;			\
 	long __ret = ret; /* explicit shadow */				\
 									\
-	sdt_might_sleep_start(NULL);					\
+	sdt_might_sleep_start_timeout(NULL, __ret);			\
 	init_wait_var_entry(&__wbq_entry, var,				\
 			    exclusive ? WQ_FLAG_EXCLUSIVE : 0);		\
 	for (;;) {							\
-- 
2.17.1



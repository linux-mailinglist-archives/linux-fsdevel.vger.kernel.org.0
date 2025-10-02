Return-Path: <linux-fsdevel+bounces-63237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 183ECBB3011
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0567B1C1F48
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FBB3002DE;
	Thu,  2 Oct 2025 08:13:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD4F2FF14E;
	Thu,  2 Oct 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392831; cv=none; b=q7UEcixXtUoVwDBD6MjskcJVrS+I8THfboiM243RUqXKvAjxfkqDgAk1VxiheYS7fGVJW92nc50VTSM5/l4IeQoKZwpIX953aGAtgYKfRhvZ+BGMfDfN49zJiwK9+MPMZc8Fe0MfeuK2n13C61IEgekHc/EOnuz+eO0ko+Yikcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392831; c=relaxed/simple;
	bh=iO2KW71ND81fGxMUwRQjjDiFJuENFPAoI9mwHgSPbpI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OEgMeSHl7og02yMfZhFTjc9k+vVF8Oa09Gr92ThaQni6MrwQ3rIiYegarX/+F9b+31QV/Qn31yN4ySdrlKPv7SBnXgC8QdqRKsN6C9dmpOaBIOhehPCWZ9tNvcOSCzmvFF0pPk4LRImKeQmLznESfjukG8whmfCSnIPQuBdh5o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-ee-68de340feceb
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
Subject: [PATCH v17 21/47] dept: apply timeout consideration to waitqueue wait
Date: Thu,  2 Oct 2025 17:12:21 +0900
Message-Id: <20251002081247.51255-22-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUxTdxTG/d/7v/e2nTV3HZE7ZyJpQkjw3TBzMrdl2ZfdLzNLluwDJmq1
	N2u1gLYKVF3GSzs6N5l0g2aUTV6EVFp5aUWlAvIyq6wSW8FSlReZ2EKQaYBKZIzulm1fTn7n
	Oc95zpcjIRUhaoNEm31C0GerdEpahmWza2u2vpkxptnxmIZQYTeG2IIFg8X9MwWBJieC8ZgF
	gbk9jmHh9WMG4p0+BBVBKwnzLSs0zPTNIbBNF2KYHb9BQXw0SkDD5AoBk90lCC7Uemj4a+Ae
	CVMtYnvFN4ag01FEw7PzbSQMTq6D/vLvaJgNVhHwZwsNv9itCIrrmmlof+JlIDizTMBIhZUA
	p/tTGG+IYKhoTQa7rZgQyxQB5ZdviOcKUsE+MEjBH45KBpYndkK8Ogd8zigDoz+UY+gfC1Ew
	E7HScK3gCQPuh7cQLAxNEOD6PkKCxRvD4H4qWjofbYaaby5i6OjsxzDoraJhzBWnoDkaJsDv
	uyMmVV7CcM97mYL64SABnoG7JATKzlEfqflFcynmGz1XCd58/2+ad/3qQvxCfTHJ9z1/QfIm
	Tx5f739O80uxBzT/ey3Hlw1s5dsrRxm+2n2SN/02S/EeRzpf1zFNfLY9U/a+WtBpcwX99g8P
	yjQB2xR5rI3JtztrmQJkos8iqYRjM7jhWJA4iySrbI5/kZBpNo0Lh1+TCU5iUzjPuQiVYJL1
	b+RCwS0Jfovdy02WxlZjMJvK+UMVRILl7G7OtBRm/o3fxDlbuldzpKI+OOHHCVaw73LmFybR
	LxM9TinXVtP138LbXI8jjM8jeTVa04gU2uzcLJVWl7FNY8zW5m87nJPlRuK3NXy1vO86mgt8
	3otYCVKulQdSRzUKSpVrMGb1Ik5CKpPkBx0jGoVcrTKeEvQ5B/QndYKhF70jwcpk+a5XeWoF
	+6XqhHBUEI4J+v+nhES6oQAdSTn1aDGZ2980/snDFev0lmvDeQ51z5GXOunSB/Ono3ct6/tS
	Wu9XnhmyFf1Y1r0psOfSdNpPpR2tdE3DoRSDd4/RNh+bicyR64eSGl8Vur5Nq2suORrNtB9Y
	cztk6C38eNdx7r2RN7q+dtzMTM+/rulZ3FtctbHr5SGhxFndVOQzKrFBo9qZTuoNqn8Ac/ga
	U2kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSe0xTZxQAcL97b797aazedExvUNQ0IRqjMDNYTnQa/zDziwY1RjFZ4qTR
	W9rxXMuYbFks0mqjm2JjS6SCBUPD2k5YC8uAlfDIyLaOQMUhKhUwHUIA8UFRXnatif+c/M4j
	J+ePw9HyJkkCp8krFLV5yhwFljLSQ7tKt69Ofaz+6ILzYxgoaWcgPGti4Ga9G4PJc0MCfXdc
	CIbDJgSvF200GJsjDCybu1mYnX/EQsTXjcAaMNPgbiyh4FXDWwyTXS8RWEZDGMonShiYcfyA
	oGLMxsLEH/therhVApHgUwruz00hcITeUhBqv4hg2ZoNt2q8GBZ7emkot/QhqB4N0jDeEG02
	dj9G4Ks7j+G/siYa+kOr4F54BsNflssYpgM3KXjWgMF+3ieBSpsZQentegzWSg8DzSMtLAQm
	lygYspopcHnSYdgxxoC/rIaK3hed+mUt2MpLqWgYp8DycysF8w4nC//cHmLAoU8CW0+/BJ7U
	VbCwNLoDIvZ86HY9ZSF41cLAneleyV4LIq+NVxji9P5KEePdZUzcVW5EFhfMiMzWltLEWBZN
	u6ZmaGLwfkNq/VOYLIT/xcQ3Z2fI3zUCudaznTRXBFliaHvIHtn5ufTTM2KOpkjUpuzJlKr7
	ysfpgib2rM1Vw+qRAV9CHCfwqYIxknEJxXGY3ywMDs7TMcfzmwTvj2OSmGnev14YCGyL+QP+
	kBC6EsYxM3yS4B+wUjHL+E8Ew8IgG7PAbxRcDe3v9sRF6/2jfiZmOZ8mGGcMVBmS2tEKJ4rX
	5BXlKjU5acm6bHVxnuZs8un8XA+KPpPj+6Vrv6HZ/v2diOeQYqUskBRUyyXKIl1xbicSOFoR
	L8usG1LLZWeUxd+K2vxT2q9zRF0nWscxirWyAyfETDmfpSwUs0WxQNS+71JcXIIejVSrPsMr
	H6hedOih+uizLwq+3L3meJtqzpK4oUPRtSj+mdWjYg+e3JbB6WQ+cnTnljeXPe6f2us7r7ec
	aP1uNaieHG9cvpDaWzUyaD+Xvuv3FKV5T1Jl8+FkF7E+T5xY410VkrGJRxKcX+07mGLyX0xX
	TfL6Y6evmj7cwD9PuD6vYHRq5Y6ttFan/B8Rux29SAMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Now that CONFIG_DEPT_AGGRESSIVE_TIMEOUT_WAIT was introduced, apply the
consideration to waitqueue wait, assuming an input 'ret' in
___wait_event() macro is used as a timeout value.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/wait.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 65dd50f25e54..902a2e5381db 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -306,7 +306,7 @@ extern void init_wait_entry(struct wait_queue_entry *wq_entry, int flags);
 	struct wait_queue_entry __wq_entry;					\
 	long __ret = ret;	/* explicit shadow */				\
 										\
-	sdt_might_sleep_start(NULL);						\
+	sdt_might_sleep_start_timeout(NULL, __ret);				\
 	init_wait_entry(&__wq_entry, exclusive ? WQ_FLAG_EXCLUSIVE : 0);	\
 	for (;;) {								\
 		long __int = prepare_to_wait_event(&wq_head, &__wq_entry, state);\
-- 
2.17.1



Return-Path: <linux-fsdevel+bounces-63228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38F6BB2ED3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 02 Oct 2025 10:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD235386417
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 08:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB1D2F49FE;
	Thu,  2 Oct 2025 08:13:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713DC2F1FE3;
	Thu,  2 Oct 2025 08:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759392817; cv=none; b=ogyzH1UiKsJoesRybd0b9SoR9cr3FIxvGIEjbngIDmTlQaeABLmVAVi8ye/7zF5MNIzAFlBzu9knmeVpEP42e8TJbxzSW6vejInUjxFr9hUr+JnKK/I4/vwpk/9EnXZb4e5TexM1cVMPh2a15S0EUwe7OAf1tqYWMgzHdqpMi2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759392817; c=relaxed/simple;
	bh=mVczWw5AJvTGaUa2k+kGuAdITLqzYAqLiO2CNQ+CNGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TeaRSiCUV+vRBa/DjPVxuBfXa/Z/V9nOZZRWOsQXH+nY3o58i+C9ryKG6vqWXDRuAj4Vl2Ve+BEiYo5hQ5MJyC3D9rOizZEq5p5wlMpaFam5wdx4oluD/EJBepblspkPypCD97j9/tXGJjFb6CsJkXwMbqGpvV/ARu1RHxu/npY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-c2dff70000001609-cf-68de340e8592
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
Subject: [PATCH v17 13/47] dept: apply sdt_might_sleep_{start,end}() to wait_for_completion()/complete()
Date: Thu,  2 Oct 2025 17:12:13 +0900
Message-Id: <20251002081247.51255-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251002081247.51255-1-byungchul@sk.com>
References: <20251002081247.51255-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0yTdxTG/b/X0ljyrmPhBWfcGnEJCg4H80QX4yf5f3DxQvwwTTaa9Q3t
	5GJaQNgColQlpCJUhQScFrBNpR0wuiE4XsNwa0AEyhxQxXIb1yGSEKhCLVgwfjn5Pc855zlf
	joSUu+lwiSY1XdCmKpMVjJSSzm2uigqOHVJ/Lq7EwNJiAQU36+wMuGptCIaXChC88lWQ4Dc6
	WVhcHmRhTXQisP92noDZhwsIboyOM1A2c56CeYsBQflkBQszf8fDmmeKgAHvCwSW8VUCxlsv
	I/CXnobbVQ4GfF09JFSOekgQrRcYeDIeDHO9NwkwXRBp+LnCiCC/uo6B5pH7LDwvNRLQWVxF
	QOmvoVBRlk8EyjQBy5YaFix5EfBmNAbWTGngtE2x4Ll6g4LauR4aOob6aZidNDJgN0yS0PBf
	QIrPdkLlpTsUtIgdFBT4FxE4m8YIMNT/TkPdlDtwyNlOQUf5XQrMA70EOLoek+At2gKukis0
	uIsnEPzysoqBWa+FBMvSPAv/tJqIgypc42gksP2WHWHfihHhRXM+iS8WB6TecRabO18weGWp
	j8Gi10Thkq4o3FzuYbH+wTMWmxoysP6vORo7rJG4umWGOBp5UvqVSkjWZAra3QcSpWpfWyFx
	Rvwga7rPhfKQI7gQBUl4LpafqG1m33PDUzu5zgz3Ge92L29wCPcJ77gySa8zyXV+zPf37lrn
	Dzk1X3S9hFpniovgp+63b+TIuC95i89AvcvcxtvqWzdyggL+k9HODV/OxfEX5/VEIZIGZmxB
	/IC1mnm3EMb/aXVTxUhmQptqkFyTmpmi1CTHRquzUzVZ0d+npTSgwL9Zct6cakILroQ2xEmQ
	YrPMFeFRy2llpi47pQ3xElIRIku0PlfLZSpl9o+CNu07bUayoGtDWySUIlS2x3tWJeeSlOnC
	aUE4I2jfdwlJUHgeqv6/Muk6PhYXu+/oD7I4/zfRD4d7zF98m7fqjLclOaJ0ezctGDL6clxj
	6dJDKdtzXoe3SJnweH33uUtHEm71ZjzOOvzK05+78rUs7EHwT2Jo06793SX3jk/8kXA1YmT6
	IyN+VB4iLfr3mn/Hp5Hdg2lHtg42T6w2luWeML9UKQbb2XkFpVMrYyJJrU75FrxKK/lrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0xTdxjG9z/nf84p1ZJjRT3qErZGYjTKJqn6RtFsHxaOzrsmRuOFBk5o
	xzUtICwaQWjkvtKsgBS1YmgIrVhbb8i6kJoRN8agAt6gYg0CahmJtioWZC2LX9783ud58+T5
	8IpI6U1qmUiVkS2oMxRpMlqMxbs2F62NlD9VftvQSsKDwg4MAX8JhoarVhpK7Oco6G21IBgO
	lCB4HzSSoG2bxTCj72TAPzXIwKyzE0GNW0+C9XohAW9tn2h4ffcNAoN3hIbal4UYJs0VCOpH
	jQy8/CMBJobbKZj1jBHw8J0PgXnkEwEjHWcRzNSkwsVGBw3B7h4Sag29CC55PSSM20Lm9c6n
	CJzNZ2h4obtBQt9IJPQHJmn401BOw4S7gYB/bTSYzjgpOG/UIyi6fJWGmvN2DG3P7jDgfj1N
	wFCNngCLfScMm0cxdOkaiVC/0NW1JWCsLSJCY5wAw5V2AqbMLQz8fXkIg7kgBozdfRQ8b65n
	YNq7DmZNmdBpGWPA84sBQ+tED/WdAfHvtVWYb3HcJHjt/Rmat16wIj74UY94f1MRyWt1ofWu
	b5Lkix0n+KYuH81/DAzQvPOdCfN/NXJ8dfdavq3ew/DFvz9h9mw6LI5PFtJUuYL6m62JYmXQ
	VUZkORfkjQ/0ogLkiCxDESKOlXP2x1YyzDS7knv0aGqOo9ivOEflKBVmku36knvgXhPmhayS
	q/q1GocZszHc2J17TJgl7AbOHKzA/2dGcxZbx1xOREjv83bN6VJ2PaedLCZ0SGxCX7SgKFVG
	brpClbY+VpOqzM9Q5cUmZabbUeibzKemq28jf1+CC7EiJJsvccd4lFJKkavJT3chTkTKoiSJ
	zUNKqSRZkf+zoM48rs5JEzQutFyEZUsk2w8KiVI2RZEtpApClqD+7BKiiGUF6GSpsXRLjmvh
	3thV+RPLV9ZJk3DK123T/pRzSYd+0Pmi4+TZg/MOHHGo1Nvk8yoPlB+qu1VHWf8xVSTc+FH2
	m+/U/eRF9mf9Oy2795YtJqo/bKytaGh6my23HcVT+3YMHju9+eyKuO/jT8a1/+RlspR1r5bu
	6AkkH2/V3Etpit+/qzxGhjVKxbrVpFqj+A/gRvS4SQMAAA==
X-CFilter-Loop: Reflected
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Make dept able to track dependencies by wait_for_completion()/complete().

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/completion.h | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index fb2915676574..bd2c207481d6 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -10,6 +10,7 @@
  */
 
 #include <linux/swait.h>
+#include <linux/dept_sdt.h>
 
 /*
  * struct completion - structure used to maintain state for a "completion"
@@ -26,14 +27,33 @@
 struct completion {
 	unsigned int done;
 	struct swait_queue_head wait;
+	struct dept_map dmap;
 };
 
+#define init_completion(x)				\
+do {							\
+	sdt_map_init(&(x)->dmap);			\
+	__init_completion(x);				\
+} while (0)
+
+/*
+ * XXX: No use cases for now. Fill the body when needed.
+ */
 #define init_completion_map(x, m) init_completion(x)
-static inline void complete_acquire(struct completion *x) {}
-static inline void complete_release(struct completion *x) {}
+
+static inline void complete_acquire(struct completion *x)
+{
+	sdt_might_sleep_start(&x->dmap);
+}
+
+static inline void complete_release(struct completion *x)
+{
+	sdt_might_sleep_end();
+}
 
 #define COMPLETION_INITIALIZER(work) \
-	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
+	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait), \
+	  .dmap = DEPT_MAP_INITIALIZER(work, NULL), }
 
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
@@ -75,13 +95,13 @@ static inline void complete_release(struct completion *x) {}
 #endif
 
 /**
- * init_completion - Initialize a dynamically allocated completion
+ * __init_completion - Initialize a dynamically allocated completion
  * @x:  pointer to completion structure that is to be initialized
  *
  * This inline function will initialize a dynamically created completion
  * structure.
  */
-static inline void init_completion(struct completion *x)
+static inline void __init_completion(struct completion *x)
 {
 	x->done = 0;
 	init_swait_queue_head(&x->wait);
-- 
2.17.1



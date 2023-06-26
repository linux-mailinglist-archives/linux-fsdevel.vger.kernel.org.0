Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D62573DFCB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 14:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjFZMuM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 08:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjFZMtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 08:49:35 -0400
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EEE872722;
        Mon, 26 Jun 2023 05:48:16 -0700 (PDT)
X-AuditID: a67dfc5b-d85ff70000001748-6b-64997d6ca482
From:   Byungchul Park <byungchul@sk.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel_team@skhynix.com, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org, will@kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org, joel@joelfernandes.org,
        sashal@kernel.org, daniel.vetter@ffwll.ch, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, jlayton@kernel.org, dan.j.williams@intel.com,
        hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com,
        42.hyeyoo@gmail.com, chris.p.wilson@intel.com,
        gwan-gyeong.mun@intel.com, max.byungchul.park@gmail.com,
        boqun.feng@gmail.com, longman@redhat.com, hdanton@sina.com,
        her0gyugyu@gmail.com
Subject: [PATCH v10 13/25] dept: Distinguish each work from another
Date:   Mon, 26 Jun 2023 20:56:48 +0900
Message-Id: <20230626115700.13873-14-byungchul@sk.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230626115700.13873-1-byungchul@sk.com>
References: <20230626115700.13873-1-byungchul@sk.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSe0xTdxQHcH/38bu3lZKb+rqiUVNDzPCFBuXojBpN9P7hazOaBTelsXej
        kSJpAUFDgloXaYUIUguCSymuNlBBCyGolADy9EUdhAEWBOILBUmYrSAIK6j/nHxyzsn3/HNY
        Ul5FB7HqmDhRG6OMVmApJR0KyF+tSc5RhU6dhoxLoeD9eJGCvBIHBndxEQJH2VkCBup3w7++
        QQTjT1pIMJvcCPL7ukkoa+hB4LKfw9D6MhDavMMYmk1GDOcLSjA8ez9BgOdqJgFFzr3w6LKV
        gOqxNxSYBzDkms8T/vKWgDFbIQO2lGDot19jYKJvHTT3tNPg6loJOX95MFS6miloqOgnoPVe
        HoYexxQNjxqaKHBnpNFw64MVw3ufjQSbd5iBf6otBNzW+4PeTbgI+PO/SRoa06r9unGHgLbO
        +wiqLvYS4HS0Y3jgHSSg1Gki4fPNegT96UMMXLg0xkDu2XQExgtXKWj50kiD3rMBxkfz8PYf
        hQeDw6SgLz0luHwWSnho5YW717oZQV/VxQgWZ7xQag8RCioHCCF/xEsLzsJULDhHMhnBMNRG
        CJ72Six8ePqUEZqyx6kDiyOkW1RitDpB1K7dGimNuuOexLEf5ySacv+mU1A5Z0ASlufCePvr
        GvTdI6/uktPG3Aq+o2NsxnO5ZXxp2mvagKQsyRXM5t801THTgzncTr7elzVjigvm6xr11LRl
        3EY+3VqMv4Yu5YtuV88ESfz9+4+tM8fk3Ab+nKf2284VCT95I/yrF/I19g7qMpJZ0KxCJFfH
        JGiU6uiwNVFJMerENcdPapzI/1W25IkjFWjEfbAWcSxSBMhCl2Sr5LQyQZekqUU8SyrmyuaP
        mlVymUqZdFrUnjymjY8WdbVoEUspFsjW+06p5NwfyjjxhCjGitrvU4KVBKWgVfd+GQ0xX38c
        H1kfYawJ2ny8axnbGfm7xmhR9YZLg7OLCnW2M1nil+d9B1MNOwIDUg9kZWQvDhyoWL3HuPzo
        VsmCFw3kLlOd5p0rvHz29n3HEonx/Zu6f2vd/6m8JO+nX1terMwvC+s0dHRqfz48z6RNDvih
        PNbRuynzunRb3NShJFZB6aKU60JIrU75Pw6yyNRRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAAzXSe0iTexgHcH/v5ffOt9Z5WWJvdmXnSKeijkbGE4UE3X4YWRBR+Ef10l5y
        OE02XRpFpqvMmmQ1l6lhs5aop3TaoYsT07x13UmxC9NqXcy8kTnL1Goa/fPw4fuF71+PglbZ
        2CCFNi5B1sdJOjXmGT5yRdoi3cEcTUi25y/IOhkC3sF0BvKulWJwXS1BUFp5mIKu+vXwdKgH
        wcjDxzRYLS4EF1+301DZ0IHAWZSKoeXtFGj19mNotpzAkFZ4DcP/3aMUuLNPU1Di2Aj3T9ko
        qBnuZMDahSHXmkb5zgcKhu3FHNhTgsFTdJ6D0deh0NzRxkJdfjMLzhcLIeeCG0OVs5mBhhse
        Clpu5WHoKP3Bwv2GJgZcWWYW/u2zYegestNg9/Zz8KSmgIIyk2/t46iTgqOfv7PQaK7x6VI5
        Ba3PbyOoTn9FgaO0DUOdt4eCCoeFhm9X6hF4Mns5OHJymIPcw5kIThzJZuDxWCMLJncYjHzN
        w6tWkrqefpqYKvYR51ABQ+7ZRHLzfDtHTNUvOFLgSCQVRQtIYVUXRS4OeFniKD6OiWPgNEcy
        elsp4m6rwqTv0SOONJ0bYTbPiuJXamSd1ijr/wnfxUeXu77j+MGpSZbcy2wK+k/IQP4KUVgq
        Dry7SY8bC/PEZ8+GJxwgzBUrzO/ZDMQraKFwktjZdJcbL6YKq8X6obMTZoRg8W6jiRm3Ulgm
        Ztqu4l+jc8SSspqJIX9ffvuBDY1bJYSJqe5afArxBcivGAVo44yxklYXttgQE50cp01avHtv
        rAP5Psd+cDTrBhpsWV+LBAVST1aGzD6nUbGS0ZAcW4tEBa0OUAZ+tWpUSo2UvF/W792pT9TJ
        hlo0Q8Gopykjtsm7VMIeKUGOkeV4Wf+7pRT+QSnILPfihUmfjvW1bEiIGcv55vXmbEoM3LP2
        0Fjj1k/lgV+uT34ZXD0z8clSV8n8sukR4d7wo+mh0sczUV+K3vBRkZ0kqN38Jz9pvpQanNXm
        xxxoT00e88uPWMPHTzN0xSy3zltXuSNs5M6WtdvFJZv+2GbUddvv+M8pNEYNWpgLf0d61Iwh
        WgpdQOsN0k8Tj+VLNQMAAA==
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Workqueue already provides concurrency control. By that, any wait in a
work doesn't prevents events in other works with the control enabled.
Thus, each work would better be considered a different context.

So let Dept assign a different context id to each work.

Signed-off-by: Byungchul Park <byungchul@sk.com>
---
 include/linux/dept.h     |  2 ++
 kernel/dependency/dept.c | 10 ++++++++++
 kernel/workqueue.c       |  3 +++
 3 files changed, 15 insertions(+)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index f62c7b6f42c6..d9ca9dd50219 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -515,6 +515,7 @@ extern void dept_ecxt_exit(struct dept_map *m, unsigned long e_f, unsigned long
 extern void dept_sched_enter(void);
 extern void dept_sched_exit(void);
 extern void dept_kernel_enter(void);
+extern void dept_work_enter(void);
 
 static inline void dept_ecxt_enter_nokeep(struct dept_map *m)
 {
@@ -567,6 +568,7 @@ struct dept_task { };
 #define dept_sched_enter()				do { } while (0)
 #define dept_sched_exit()				do { } while (0)
 #define dept_kernel_enter()				do { } while (0)
+#define dept_work_enter()				do { } while (0)
 #define dept_ecxt_enter_nokeep(m)			do { } while (0)
 #define dept_key_init(k)				do { (void)(k); } while (0)
 #define dept_key_destroy(k)				do { (void)(k); } while (0)
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
index 4165cacf4ebb..6cf17f206b78 100644
--- a/kernel/dependency/dept.c
+++ b/kernel/dependency/dept.c
@@ -1977,6 +1977,16 @@ void dept_hardirqs_off_ip(unsigned long ip)
 }
 EXPORT_SYMBOL_GPL(dept_hardirqs_off_ip);
 
+/*
+ * Assign a different context id to each work.
+ */
+void dept_work_enter(void)
+{
+	struct dept_task *dt = dept_task();
+
+	dt->cxt_id[DEPT_CXT_PROCESS] += 1UL << DEPT_CXTS_NR;
+}
+
 void dept_kernel_enter(void)
 {
 	struct dept_task *dt = dept_task();
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 07895deca271..69c4f464d017 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -51,6 +51,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/nmi.h>
 #include <linux/kvm_para.h>
+#include <linux/dept.h>
 
 #include "workqueue_internal.h"
 
@@ -2199,6 +2200,8 @@ __acquires(&pool->lock)
 
 	lockdep_copy_map(&lockdep_map, &work->lockdep_map);
 #endif
+	dept_work_enter();
+
 	/* ensure we're on the correct CPU */
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
-- 
2.17.1


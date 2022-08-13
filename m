Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 333C659194A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Aug 2022 09:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiHMHlz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Aug 2022 03:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiHMHly (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Aug 2022 03:41:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742CCB877;
        Sat, 13 Aug 2022 00:41:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id y1so2524503plb.2;
        Sat, 13 Aug 2022 00:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=1D5RARWYXeS4oCjrAmCqP8o9dG9mHPQT0/m3UahUHns=;
        b=VI3F+e9pMGWL+iyR48X7cugxAK3V4tQfHNtB3MveXTi1a5/dVydBn9tsVnRKmiqNaM
         Q6k+1NOh+Rpq7kcorcIs9q095sn+9moT4HI5Egr6Fwk9dtYdlYyAnG2rhjr1d88tqO5P
         q88RRk0sZP7yQHntGue2b3cgNK1kdmZHNfC9nd7yvv+pyo+RjCB+EX3w4f7/z030atmJ
         g9jwnwFfgU7ihfHoaraSnt5kAqfIlbiLkNN6XmeWOD2AJo1ZFr+3/y2IR9vauUtMviIN
         EMXjVE3EdIvVcrQBqeeNNBpj+BhiWn7jsfiqrPdA8hCJffaRI5z3s/PvLa94wVvk3xAT
         sw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=1D5RARWYXeS4oCjrAmCqP8o9dG9mHPQT0/m3UahUHns=;
        b=NtDr1A7kfeBUMcteYkVMmrY4nBsdmyDPvN/VYRJoAwExjnj5TJq+vE/+PaNfg+kmKJ
         uz1zL69vb8ADlS0Uqv/5yuyph55a6qQ/qs1+nFrCZWkc7rBHEb6OsP65Lze31QrWELzU
         cJBgfZfHFyJt4v0tBeA/4dOkDR8iRfDPDVHcT6p7xiiCUsjHX6yaewzKlUEhKOAl2KiU
         /CqATWsLlxozAuRnNyL9gmp9WTtqPrx8GCpm4ke23qoLtRSrtIs3r0WNYbTHnKUnGzwS
         jC4hazPt2lakRoDait2JNC03cJzLZWF3Pn+CPL8nT7LZesq6OsFf/kb41/5UC3uXI9XY
         7QaA==
X-Gm-Message-State: ACgBeo1yv9gDssj/jEmOs9T3YUuq6We+fqk5LPB7Nw0uV3n/AaiYhfae
        1l/LVv/3IqwJpe77/OhksFk=
X-Google-Smtp-Source: AA6agR4h+9nzNw60Ye/CFlyIFw5+N7xA+6SwLG/HbNj/y7ixCDz95LiWO8SBD/sjt5NXLMCaNJXLWg==
X-Received: by 2002:a17:90b:4b52:b0:1f7:2e06:575f with SMTP id mi18-20020a17090b4b5200b001f72e06575fmr17456202pjb.120.1660376512957;
        Sat, 13 Aug 2022 00:41:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 6-20020a170902c20600b0016d2d0ce376sm2981149pll.215.2022.08.13.00.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 00:41:52 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     bsingharora@gmail.com, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com
Cc:     mingo@redhat.com, bristot@redhat.com, vschneid@redhat.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>
Subject: [PATCH 1/2] delayacct: support re-entrance detection of thrashing accounting
Date:   Sat, 13 Aug 2022 07:41:09 +0000
Message-Id: <20220813074108.58196-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Once upon a time, we only support accounting thrashing of page cache.
Then Joonsoo introduced workingset detection for anonymous pages and
we gained the ability to account thrashing of them[1].

For page cache thrashing accounting, there is no suitable place to do
it in fs level likes swap_readpage(). So we have to do it in
folio_wait_bit_common().

Then for anonymous pages thrashing accounting, we have to do it in
both swap_readpage() and folio_wait_bit_common(). This likes PSI,
so we should let thrashing accounting supports re-entrance detection.

This patch is to prepare complete thrashing accounting, and is based
on patch "filemap: make the accounting of thrashing more consistent".

[1] commit aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: wangyong <wang.yong12@zte.com.cn>
---
 include/linux/delayacct.h | 16 ++++++++--------
 include/linux/sched.h     |  4 ++++
 kernel/delayacct.c        | 13 +++++++++++--
 mm/filemap.c              | 10 ++++++----
 4 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 58aea2d7385c..aeb76f1c894e 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -73,8 +73,8 @@ extern int delayacct_add_tsk(struct taskstats *, struct task_struct *);
 extern __u64 __delayacct_blkio_ticks(struct task_struct *);
 extern void __delayacct_freepages_start(void);
 extern void __delayacct_freepages_end(void);
-extern void __delayacct_thrashing_start(void);
-extern void __delayacct_thrashing_end(void);
+extern void __delayacct_thrashing_start(unsigned long *flags);
+extern void __delayacct_thrashing_end(unsigned long *flags);
 extern void __delayacct_swapin_start(void);
 extern void __delayacct_swapin_end(void);
 extern void __delayacct_compact_start(void);
@@ -143,22 +143,22 @@ static inline void delayacct_freepages_end(void)
 		__delayacct_freepages_end();
 }
 
-static inline void delayacct_thrashing_start(void)
+static inline void delayacct_thrashing_start(unsigned long *flags)
 {
 	if (!static_branch_unlikely(&delayacct_key))
 		return;
 
 	if (current->delays)
-		__delayacct_thrashing_start();
+		__delayacct_thrashing_start(flags);
 }
 
-static inline void delayacct_thrashing_end(void)
+static inline void delayacct_thrashing_end(unsigned long *flags)
 {
 	if (!static_branch_unlikely(&delayacct_key))
 		return;
 
 	if (current->delays)
-		__delayacct_thrashing_end();
+		__delayacct_thrashing_end(flags);
 }
 
 static inline void delayacct_swapin_start(void)
@@ -237,9 +237,9 @@ static inline void delayacct_freepages_start(void)
 {}
 static inline void delayacct_freepages_end(void)
 {}
-static inline void delayacct_thrashing_start(void)
+static inline void delayacct_thrashing_start(unsigned long *flags)
 {}
-static inline void delayacct_thrashing_end(void)
+static inline void delayacct_thrashing_end(unsigned long *flags)
 {}
 static inline void delayacct_swapin_start(void)
 {}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d6b0866c71ed..5fb942e29583 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -943,6 +943,10 @@ struct task_struct {
 #ifdef	CONFIG_CPU_SUP_INTEL
 	unsigned			reported_split_lock:1;
 #endif
+#ifdef CONFIG_TASK_DELAY_ACCT
+	/* delay due to memory thrashing */
+	unsigned                        in_thrashing:1;
+#endif
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 164ed9ef77a3..a5916196022f 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -214,13 +214,22 @@ void __delayacct_freepages_end(void)
 		      &current->delays->freepages_count);
 }
 
-void __delayacct_thrashing_start(void)
+void __delayacct_thrashing_start(unsigned long *flags)
 {
+	*flags = current->in_thrashing;
+	if (*flags)
+		return;
+
+	current->in_thrashing = 1;
 	current->delays->thrashing_start = local_clock();
 }
 
-void __delayacct_thrashing_end(void)
+void __delayacct_thrashing_end(unsigned long *flags)
 {
+	if (*flags)
+		return;
+
+	current->in_thrashing = 0;
 	delayacct_end(&current->delays->lock,
 		      &current->delays->thrashing_start,
 		      &current->delays->thrashing_delay,
diff --git a/mm/filemap.c b/mm/filemap.c
index cfe15e89b3c2..92ceebc75900 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1222,10 +1222,11 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	wait_queue_entry_t *wait = &wait_page.wait;
 	bool thrashing = false;
 	unsigned long pflags;
+	unsigned long dflags;
 
 	if (bit_nr == PG_locked &&
 	    !folio_test_uptodate(folio) && folio_test_workingset(folio)) {
-		delayacct_thrashing_start();
+		delayacct_thrashing_start(&dflags);
 		psi_memstall_enter(&pflags);
 		thrashing = true;
 	}
@@ -1325,7 +1326,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	finish_wait(q, wait);
 
 	if (thrashing) {
-		delayacct_thrashing_end();
+		delayacct_thrashing_end(&dflags);
 		psi_memstall_leave(&pflags);
 	}
 
@@ -1374,12 +1375,13 @@ void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
 	wait_queue_entry_t *wait = &wait_page.wait;
 	bool thrashing = false;
 	unsigned long pflags;
+	unsigned long dflags;
 	wait_queue_head_t *q;
 	struct folio *folio = page_folio(pfn_swap_entry_to_page(entry));
 
 	q = folio_waitqueue(folio);
 	if (!folio_test_uptodate(folio) && folio_test_workingset(folio)) {
-		delayacct_thrashing_start();
+		delayacct_thrashing_start(&dflags);
 		psi_memstall_enter(&pflags);
 		thrashing = true;
 	}
@@ -1426,7 +1428,7 @@ void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
 	finish_wait(q, wait);
 
 	if (thrashing) {
-		delayacct_thrashing_end();
+		delayacct_thrashing_end(&dflags);
 		psi_memstall_leave(&pflags);
 	}
 }
-- 
2.25.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C094592A3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 09:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240447AbiHOHPw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 03:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241462AbiHOHPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 03:15:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D82B61D325;
        Mon, 15 Aug 2022 00:14:36 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so6082166pjl.0;
        Mon, 15 Aug 2022 00:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=DTMT8hoLjJB/orrtWMlqwT6cn7CDgzNtrQnAm9ijTQg=;
        b=JKPUll07EKwOwZpZ+xuSWHHTA9Q/FAIIEApg5y/br8C6061slymiseOGFUaOhAtjqG
         MlhPgAAyeSXcjAnLKd3LdbtL8OEWr/EcEJOh39RwMNjI8EY/Uz4iYFdKBs2a2oGrzJj9
         bdIQpufHw6l9zOqUQeb8BbWAONVuWWxxBZ4dWELZ21cdxrgmqa44e5pvCmTapr0LZaJ7
         gVaiaHWaZfF+NI73BLrCkj3G2+yoQhEwXD2xU2JJHryv1RBwaqWsU5w1VYhx1M8bNlIJ
         qZ551UrRxuAGhzhSFfXf3gpEkPPriVPvF0VjKNTtV1NyESZ4JqWv7MEJ/0ap9fkFcjKo
         XBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=DTMT8hoLjJB/orrtWMlqwT6cn7CDgzNtrQnAm9ijTQg=;
        b=nS0EFh4Lo3oyZnC+JMr/zBcHiRVJEXeaBlciGpppKSxBglSGaeMlKZrEmqJy4fH+BU
         LWs4eQP0XbIKI00aCViiz+p9oTwtuedRKsTPjfhkgMNbOuq5qWlVDU10jzSySoAulPSz
         hu9KoMi5kcu2kj5cMl1Xl6NjHj7VqIW7qyguA0dLLX6672vyPwwe9MW2Ct7X0IhS0NRX
         +tiMIiDcPEYbDgt8xr5uGrXF5saNhY7XrHJiGAxfUp+pzKMyULvTNhYZaHP/L6hQnqyK
         qjwNkJ1HyfS1Hr7x0UACrPfxgivsxTjqeYmed+4SmtmhbhW+yKbfQof3MMVHdjoCyMYE
         ZZBQ==
X-Gm-Message-State: ACgBeo0bA7HGBDmgSu4JpCiGssYfUYIndnHYbDhZMCy7B/52NPlrfCJP
        U1l/RL5tT9GpGKGQ1Iexqt8=
X-Google-Smtp-Source: AA6agR4scsuaEt80ywtS9mg6M5jLafTWgBa9vOO9V2ztaIu1rJYKs9L+TG73N4VBawcF+LkHcraaXg==
X-Received: by 2002:a17:90b:3558:b0:1fa:7d01:4e04 with SMTP id lt24-20020a17090b355800b001fa7d014e04mr3632978pjb.5.1660547676359;
        Mon, 15 Aug 2022 00:14:36 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id m13-20020a62a20d000000b0052e82671a57sm6039527pff.73.2022.08.15.00.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 00:14:35 -0700 (PDT)
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
Subject: [PATCH v2 1/2] delayacct: support re-entrance detection of thrashing accounting
Date:   Mon, 15 Aug 2022 07:11:35 +0000
Message-Id: <20220815071134.74551-1-yang.yang29@zte.com.cn>
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
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Reviewed-by: wangyong <wang.yong12@zte.com.cn>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
Change for v2:
 - use bool *in_thrashing instead of unsigned long *flags
---
 include/linux/delayacct.h | 16 ++++++++--------
 include/linux/sched.h     |  4 ++++
 kernel/delayacct.c        | 13 +++++++++++--
 mm/filemap.c              | 10 ++++++----
 4 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 58aea2d7385c..0da97dba9ef8 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -73,8 +73,8 @@ extern int delayacct_add_tsk(struct taskstats *, struct task_struct *);
 extern __u64 __delayacct_blkio_ticks(struct task_struct *);
 extern void __delayacct_freepages_start(void);
 extern void __delayacct_freepages_end(void);
-extern void __delayacct_thrashing_start(void);
-extern void __delayacct_thrashing_end(void);
+extern void __delayacct_thrashing_start(bool *in_thrashing);
+extern void __delayacct_thrashing_end(bool *in_thrashing);
 extern void __delayacct_swapin_start(void);
 extern void __delayacct_swapin_end(void);
 extern void __delayacct_compact_start(void);
@@ -143,22 +143,22 @@ static inline void delayacct_freepages_end(void)
 		__delayacct_freepages_end();
 }
 
-static inline void delayacct_thrashing_start(void)
+static inline void delayacct_thrashing_start(bool *in_thrashing)
 {
 	if (!static_branch_unlikely(&delayacct_key))
 		return;
 
 	if (current->delays)
-		__delayacct_thrashing_start();
+		__delayacct_thrashing_start(in_thrashing);
 }
 
-static inline void delayacct_thrashing_end(void)
+static inline void delayacct_thrashing_end(bool *in_thrashing)
 {
 	if (!static_branch_unlikely(&delayacct_key))
 		return;
 
 	if (current->delays)
-		__delayacct_thrashing_end();
+		__delayacct_thrashing_end(in_thrashing);
 }
 
 static inline void delayacct_swapin_start(void)
@@ -237,9 +237,9 @@ static inline void delayacct_freepages_start(void)
 {}
 static inline void delayacct_freepages_end(void)
 {}
-static inline void delayacct_thrashing_start(void)
+static inline void delayacct_thrashing_start(bool *in_thrashing)
 {}
-static inline void delayacct_thrashing_end(void)
+static inline void delayacct_thrashing_end(bool *in_thrashing)
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
index 164ed9ef77a3..e39cb696cfbd 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -214,13 +214,22 @@ void __delayacct_freepages_end(void)
 		      &current->delays->freepages_count);
 }
 
-void __delayacct_thrashing_start(void)
+void __delayacct_thrashing_start(bool *in_thrashing)
 {
+	*in_thrashing = !!current->in_thrashing;
+	if (*in_thrashing)
+		return;
+
+	current->in_thrashing = 1;
 	current->delays->thrashing_start = local_clock();
 }
 
-void __delayacct_thrashing_end(void)
+void __delayacct_thrashing_end(bool *in_thrashing)
 {
+	if (*in_thrashing)
+		return;
+
+	current->in_thrashing = 0;
 	delayacct_end(&current->delays->lock,
 		      &current->delays->thrashing_start,
 		      &current->delays->thrashing_delay,
diff --git a/mm/filemap.c b/mm/filemap.c
index cfe15e89b3c2..bc37a93bb29a 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1222,10 +1222,11 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	wait_queue_entry_t *wait = &wait_page.wait;
 	bool thrashing = false;
 	unsigned long pflags;
+	bool in_thrashing;
 
 	if (bit_nr == PG_locked &&
 	    !folio_test_uptodate(folio) && folio_test_workingset(folio)) {
-		delayacct_thrashing_start();
+		delayacct_thrashing_start(&in_thrashing);
 		psi_memstall_enter(&pflags);
 		thrashing = true;
 	}
@@ -1325,7 +1326,7 @@ static inline int folio_wait_bit_common(struct folio *folio, int bit_nr,
 	finish_wait(q, wait);
 
 	if (thrashing) {
-		delayacct_thrashing_end();
+		delayacct_thrashing_end(&in_thrashing);
 		psi_memstall_leave(&pflags);
 	}
 
@@ -1374,12 +1375,13 @@ void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
 	wait_queue_entry_t *wait = &wait_page.wait;
 	bool thrashing = false;
 	unsigned long pflags;
+	bool in_thrashing;
 	wait_queue_head_t *q;
 	struct folio *folio = page_folio(pfn_swap_entry_to_page(entry));
 
 	q = folio_waitqueue(folio);
 	if (!folio_test_uptodate(folio) && folio_test_workingset(folio)) {
-		delayacct_thrashing_start();
+		delayacct_thrashing_start(&in_thrashing);
 		psi_memstall_enter(&pflags);
 		thrashing = true;
 	}
@@ -1426,7 +1428,7 @@ void migration_entry_wait_on_locked(swp_entry_t entry, pte_t *ptep,
 	finish_wait(q, wait);
 
 	if (thrashing) {
-		delayacct_thrashing_end();
+		delayacct_thrashing_end(&in_thrashing);
 		psi_memstall_leave(&pflags);
 	}
 }
-- 
2.25.1


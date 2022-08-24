Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0270659F3F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 09:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiHXHHv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 03:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiHXHHu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 03:07:50 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A4385FF9;
        Wed, 24 Aug 2022 00:07:49 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id pm13so7266819pjb.5;
        Wed, 24 Aug 2022 00:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PXafh5f+pigI8lTygHH0lurdqVrGUMub4Gos5atZnOQ=;
        b=HsdOV6X0ITgH2yGuQ3b98iiy8QNVcOLPz8ObGnZUz5a7ATRlrUzRTDHNLfsUrNG+qY
         OP3oKeKkjbewVjarYo1XUABAuOR+w9ye8pTUiHS8fCbP1GZv4J+DJw3HDWOij9WEXSID
         1WeLvvlf+oerfF8O8Iu1t/8mHftJVnGAceyjfudLCbcNHuidZJJCa0P9na4ZbABt6DGM
         WcIB0nGznps1CxEY3SbcdpH6vggWfQCKu+Rh41HIXsDoKAMYyiwHCW4xElaRqIqEXTMB
         Nuhfuo7VF6KOQqv4cCInEQCUZJP9g2Hjk4QYFxIRRasmj2jD/lQN5nYmfzynHEypu+W+
         FWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PXafh5f+pigI8lTygHH0lurdqVrGUMub4Gos5atZnOQ=;
        b=d2gHzjQkIuFqQnwj4KNmDUNUr4WrmufQdsLKnnZmDYQ55Ab0ldeL1KbJBT4olzbS2v
         DcxDMEk9stylU8JOFU8FzZva6WULWnHrfEPhJRRKra0lBv8+x+vOgMdYuchpAXFV3+9F
         8crYTungmMm3dvBGy6r2kF9ZRevdY5hZrODMKJSPf/439WtvTO2stxLHoxVu0vysUIqU
         vMYg5US2qB9ukMa2LSaOCbM09ZL5+g8fPlTxOvM576/LBkcAUuGfuC8ulwbAJyx9EgrJ
         SUEyv3uLniVcaHpnCYYIao0HBcgKDtNCEX7hbqFOG4cPVj2BAKOj/siHypvdFO9wzAqz
         2n/w==
X-Gm-Message-State: ACgBeo38/Bb0LHM6E4pZjyLebECP11+XyK8VXcWWTHBmKYKBZrXyGifS
        fNvmgDdWafYCP+c7FpArhXU=
X-Google-Smtp-Source: AA6agR4pw6w0HuTOmjtqzCYa/gYOpKO0DzmiYndqTYq3H/EuqbX7SSXSaG7zatYXeRMMNAu1UX7Kpg==
X-Received: by 2002:a17:90b:3149:b0:1fb:71ad:256b with SMTP id ip9-20020a17090b314900b001fb71ad256bmr4679326pjb.18.1661324869038;
        Wed, 24 Aug 2022 00:07:49 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id z12-20020aa7948c000000b00535c4b7f1eesm12118187pfk.87.2022.08.24.00.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 00:07:48 -0700 (PDT)
From:   xu xin <cgel.zte@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     akpm@linux-foundation.org, corbet@lwn.net
Cc:     bagasdotme@gmail.com, adobriyan@gmail.com, willy@infradead.org,
        hughd@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH v3 1/2] ksm: count allocated ksm rmap_items for each process
Date:   Wed, 24 Aug 2022 07:07:38 +0000
Message-Id: <20220824070738.220038-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824070559.219977-1-xu.xin16@zte.com.cn>
References: <20220824070559.219977-1-xu.xin16@zte.com.cn>
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

KSM can save memory by merging identical pages, but also can consume
additional memory, because it needs to generate rmap_items to save
each scanned page's brief rmap information. Some of these pages may
be merged, but some may not be abled to be merged after being checked
several times, which are unprofitable memory consumed.

The information about whether KSM save memory or consume memory in
system-wide range can be determined by the comprehensive calculation
of pages_sharing, pages_shared, pages_unshared and pages_volatile.
A simple approximate calculation:

	profit =~ pages_sharing * sizeof(page) - (all_rmap_items) *
	         sizeof(rmap_item);

where all_rmap_items equals to the sum of pages_sharing, pages_shared,
pages_unshared and pages_volatile.

But we cannot calculate this kind of ksm profit inner single-process wide
because the information of ksm rmap_item's number of a process is lacked.
For user applications, if this kind of information could be obtained,
it helps upper users know how beneficial the ksm-policy (like madvise)
they are using brings, and then optimize their app code. For example,
one application madvise 1000 pages as MERGEABLE, while only a few pages
are really merged, then it's not cost-efficient.

So we add a new interface /proc/<pid>/ksm_rmp_items for each process to
indicate the total allocated ksm rmap_items of this process. Similarly,
we can calculate the ksm profit approximately for a single-process by:

	profit =~ ksm_merging_pages * sizeof(page) - ksm_rmp_items *
		 sizeof(rmap_item);

where ksm_merging_pages and ksm_rmp_items are both under /proc/<pid>/.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 fs/proc/base.c           | 15 +++++++++++++++
 include/linux/mm_types.h |  5 +++++
 mm/ksm.c                 |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4ead8cf654e4..9977e17885c2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -3199,6 +3199,19 @@ static int proc_pid_ksm_merging_pages(struct seq_file *m, struct pid_namespace *
 
 	return 0;
 }
+static int proc_pid_ksm_rmp_items(struct seq_file *m, struct pid_namespace *ns,
+				struct pid *pid, struct task_struct *task)
+{
+	struct mm_struct *mm;
+
+	mm = get_task_mm(task);
+	if (mm) {
+		seq_printf(m, "%lu\n", mm->ksm_rmp_items);
+		mmput(mm);
+	}
+
+	return 0;
+}
 #endif /* CONFIG_KSM */
 
 #ifdef CONFIG_STACKLEAK_METRICS
@@ -3334,6 +3347,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #endif
 #ifdef CONFIG_KSM
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+	ONE("ksm_rmp_items",  S_IRUSR, proc_pid_ksm_rmp_items),
 #endif
 };
 
@@ -3671,6 +3685,7 @@ static const struct pid_entry tid_base_stuff[] = {
 #endif
 #ifdef CONFIG_KSM
 	ONE("ksm_merging_pages",  S_IRUSR, proc_pid_ksm_merging_pages),
+	ONE("ksm_rmp_items",  S_IRUSR, proc_pid_ksm_rmp_items),
 #endif
 };
 
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d6ec33438dc1..a2a8da1ccb31 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -656,6 +656,11 @@ struct mm_struct {
 		 * merging.
 		 */
 		unsigned long ksm_merging_pages;
+		/*
+		 * Represent how many pages are checked for ksm merging
+		 * including merged and not merged.
+		 */
+		unsigned long ksm_rmp_items;
 #endif
 #ifdef CONFIG_LRU_GEN
 		struct {
diff --git a/mm/ksm.c b/mm/ksm.c
index a98bc3beb874..66d686039010 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -387,6 +387,7 @@ static inline struct rmap_item *alloc_rmap_item(void)
 static inline void free_rmap_item(struct rmap_item *rmap_item)
 {
 	ksm_rmap_items--;
+	rmap_item->mm->ksm_rmp_items--;
 	rmap_item->mm = NULL;	/* debug safety */
 	kmem_cache_free(rmap_item_cache, rmap_item);
 }
@@ -2231,6 +2232,7 @@ static struct rmap_item *get_next_rmap_item(struct mm_slot *mm_slot,
 	if (rmap_item) {
 		/* It has already been zeroed */
 		rmap_item->mm = mm_slot->mm;
+		rmap_item->mm->ksm_rmp_items++;
 		rmap_item->address = addr;
 		rmap_item->rmap_list = *rmap_list;
 		*rmap_list = rmap_item;
-- 
2.25.1


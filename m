Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1E15AA26D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbiIAWFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiIAWEH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:04:07 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D5599B57;
        Thu,  1 Sep 2022 15:02:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q3so257813pjg.3;
        Thu, 01 Sep 2022 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=pWqS4ooFUTFHzhqRBDvFvbwutPU6GCzkgDePLKh0xDE=;
        b=ltbTUVZlF/Z87l55Zx7YIMdiSlF79NxCKA3kDzN/UdHnBbOhUkxYokZciUF5yB23IQ
         3aZV0dCORuNfmkqtB4Um8rih0THqW1I8+Kg6eCX7JtCSq0qK5FxY5JJ3W+WjbZVvFS/N
         SHzuRTNRkOZU91jiFJ75s3/HaNBfpPrOuW0Q5xjsFySVCqjGc+FQww/RxS0JKeXHhL7h
         kAOi4h68L/U7Zh4Cxk29fMBM+9NAxnpOY6BN4/Gy4hT5bv4ACVWiuAvUMQEQVyDUFGrl
         0WnCZ51DYlpojmaB5f2e+eBCMWO+Ah52Ft8Wrewyr1JSMgQJJeMlPU47Bp2sXDcRwEoX
         fJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pWqS4ooFUTFHzhqRBDvFvbwutPU6GCzkgDePLKh0xDE=;
        b=UfkecGaxjZv7mAsVAT9SC3xdrKQIMpQbceMCmbmYYZ8ezEBluAFLftvNYr/hIBIrdX
         YX2gmdj0bC6+T+7fD7HI8UwB+LKQZcy+qu4yDauedtB6PdjcA6gziyU1RWsHKiiSpyn7
         yjbnn6YHnPL5tKEuPg6nMMDkwYjHy86H8PJjeaGVXr+7rY3CZghHLXCF9QKPZbNm5RDh
         beph4jBj+/Coysm8jFcg0BN3zK8hDZNj96RuSDknLpXl9rdPoMZAvN8NnAGCj2HR8Npr
         xLioJoLeFHWhSQPjSH/y1Fnv8tg68Z5aymM4wX+ptIo2TJe9WjspKlUq9Pf4UvTzNhS4
         Z6HQ==
X-Gm-Message-State: ACgBeo0mJ9Qe94FQNzChnhGp6uDURfu3YuY8nNtnG5mHhudjnKXcG53E
        MFgHuFSTMe5Gp0xfJZO2sx1au2B5weYJaw==
X-Google-Smtp-Source: AA6agR51CwUjM/zXT+7/k4/OH1O/ysrX1I+7Yp9oSarGXCh3bpO5jidmIwe1Ndwhec8sTGheHCwaGg==
X-Received: by 2002:a17:90b:4b52:b0:1fd:ed88:967e with SMTP id mi18-20020a17090b4b5200b001fded88967emr1312967pjb.108.1662069773326;
        Thu, 01 Sep 2022 15:02:53 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:02:52 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 13/23] f2fs: Convert f2fs_sync_node_pages() to use filemap_get_folios_tag()
Date:   Thu,  1 Sep 2022 15:01:28 -0700
Message-Id: <20220901220138.182896-14-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901220138.182896-1-vishal.moola@gmail.com>
References: <20220901220138.182896-1-vishal.moola@gmail.com>
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

Convert function to use folios. This is in preparation for the removal
of find_get_pages_range_tag(). Does NOT support large folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/node.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index c2b54c58392a..cf8665f04c0d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1933,23 +1933,24 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 				bool do_balance, enum iostat_type io_type)
 {
 	pgoff_t index;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	int step = 0;
 	int nwritten = 0;
 	int ret = 0;
-	int nr_pages, done = 0;
+	int nr_folios, done = 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
 next_step:
 	index = 0;
 
-	while (!done && (nr_pages = pagevec_lookup_tag(&pvec,
-			NODE_MAPPING(sbi), &index, PAGECACHE_TAG_DIRTY))) {
+	while (!done && (nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi),
+				&index, (pgoff_t)-1, PAGECACHE_TAG_DIRTY,
+				&fbatch))) {
 		int i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct page *page = &fbatch.folios[i]->page;
 			bool submitted = false;
 
 			/* give a priority to WB_SYNC threads */
@@ -2024,7 +2025,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			if (--wbc->nr_to_write == 0)
 				break;
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 
 		if (wbc->nr_to_write == 0) {
-- 
2.36.1


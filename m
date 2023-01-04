Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57ADD65DE92
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbjADVP5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240344AbjADVPQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:16 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0DA1B9DA;
        Wed,  4 Jan 2023 13:15:15 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o21so7400111pjw.0;
        Wed, 04 Jan 2023 13:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x25JE3Kc6tv/CRPnK8Jr5HLS2sX0SCmIF/DAVcH2FqE=;
        b=GGaN80QXsh4J1YXL+CzIWsFbPtYnvqnUAuR7BlWM5cg7Fb96IUWkf9YKtYSUX4xJiv
         fdrgdThz8UL3P4MZ+eHMu/4K966siuQI6iAdHR2MVQjMjV6MN1GRnO6doH2uk5OhpsZO
         LY78o+yIQS4ow8RQaNkPfGCKMNJtGI3xD9tlc5jEE555TQyh8J94/Gr9HVriMtas67IH
         FB8OUwFz1Oy3rJJOCQeEa/ZHyPHJEdTE5f3SEzIDvxTL2bZ5bnEYjE/0AQom1yTmJR+y
         hcZ12FlAB2hAIMkIDGdKE9vHxFNU1VPWGBB3MfQllfkg7rnUYN+U0mQERs2+5ZkIr7zC
         Wx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x25JE3Kc6tv/CRPnK8Jr5HLS2sX0SCmIF/DAVcH2FqE=;
        b=MjE9J8wGpejHf1+x2KNhj4tzDryf+ZnOojYIGmZZtwc4eY5hqqLymeyBuoFk19+eU3
         4jUOvnW3PWKjj3f9rcQSfZj/5yqM+WsatrC2DpdcttulaVzIjD4T2yrg7jfKFNlv91Qk
         e2+gcz7f8E+ntOFM4YSciSXBciB5ZDEInsopXPxJ3DdEKc11dz0HQ9jGmgExkf7I6Oyp
         x4mNvuGbc25koULpNEcCAAxzhhHmMEp3+cI6VMqGQTGqBmHlAkmWmxceRkOala6hz3yG
         aqJyJ3XTOkcGUu/LnA1sLUNvKO+ZWZINVZAdYqRmOsZaQo0MviwWN5sj8Rh8KDnwkFFh
         rrfg==
X-Gm-Message-State: AFqh2komkFWLi6T5QPH4jO+FpX4Dzo5POh5Dn+cuZDNtWsO4V29rhLez
        XyuLZ40vsXMiEV8xGKvYfRZMTeEMCuDDDw==
X-Google-Smtp-Source: AMrXdXtcJ2y8j2tl71bGDNWcQ9VdexuFiNN6QmVTJEdgM9Lahf3FnPeatjjBv8JIR91dEL59PwjIKg==
X-Received: by 2002:a17:90a:930f:b0:225:be98:f5b5 with SMTP id p15-20020a17090a930f00b00225be98f5b5mr45592480pjo.23.1672866914778;
        Wed, 04 Jan 2023 13:15:14 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:14 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH v5 13/23] f2fs: Convert f2fs_sync_node_pages() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:38 -0800
Message-Id: <20230104211448.4804-14-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230104211448.4804-1-vishal.moola@gmail.com>
References: <20230104211448.4804-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert function to use a folio_batch instead of pagevec. This is in
preparation for the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1c5dc7a3207e..51e9f286f53a 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1938,23 +1938,24 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
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
@@ -2029,7 +2030,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			if (--wbc->nr_to_write == 0)
 				break;
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 
 		if (wbc->nr_to_write == 0) {
-- 
2.38.1


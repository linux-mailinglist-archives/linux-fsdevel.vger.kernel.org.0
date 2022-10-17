Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975FC601A1C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Oct 2022 22:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiJQU1i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Oct 2022 16:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiJQU0y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Oct 2022 16:26:54 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4137E30C;
        Mon, 17 Oct 2022 13:25:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f23so11819492plr.6;
        Mon, 17 Oct 2022 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OszXCtyBAOhtTfNS2VcED/PJCoIEbwhBnrXkCjtJV6A=;
        b=DlogKpHGuzxO+jQRFtRTRFNBhcjjfosVdGfz4vShoT5jbOvLmiulTdcKtHEFGwz5vi
         lfN8CyIsdDsnzLwlPsrwSNu7A69s5Fy0qqRQj2nA9AGm0yWGFBOpq6+hyWMx+nCdiEOf
         HOWv03XJMaxBzb3v/k5D8Tkgw8Rsjf1L9diV61pFglGBB5j0nFSq0gT1h245hSzueZGw
         Np3EM/UvXHrfuYbzgwORQStqJotyQYc3vhFcPkD+Oz9PUmc3lvU5n0m6WUynYqD8tTw7
         UZB5z88hHxb4eP2oFj6wehPTurmZRyd9zSlH8SoJqpqYDPStY4oaZoe1q3QYLoKSuu0H
         QHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OszXCtyBAOhtTfNS2VcED/PJCoIEbwhBnrXkCjtJV6A=;
        b=VQYDcRtPoQlwc06AWMRvrJlhxwAErbozmEZalHh/B5hlgN4A1QKvLZBslvmc4e2I6V
         asZLH2ywkGCXzXHIAqF6Ofbc/hVKlgNt5NWK1Ch0ZzbAyD0mKM8r5qrL82NtOawVMOu1
         EhwlYLSHG+dj3kqSDFm1S3SERz4QL+XhlJXpwpCrgiwqnaijFJPc3ZxqiwMsCrJ2Q/ub
         nNXc/lbmNkPnF57d0CZeWrDkqcWPauYYiBGwKEQKUjn9jVDICawTjb1oaglUEzMILBjg
         +IiMDv3vJ4XWekNldQc+0r5FW727Fq2J/OJ8bkEakyMQMcj8bMgmj0dZN1Pv+XU9KMQZ
         JXIw==
X-Gm-Message-State: ACrzQf1+YjuStaAR144kOolSf5Ub3rgSSsHGUq/x8nRM/yN7Firtsi/J
        /SNG/TWwIJFmsm9BREKsGu8Spx7eHFGmLw==
X-Google-Smtp-Source: AMsMyM5dOMLXhO4r9Hp/ovS4Nq60959rICPP1Z87znhDFezbM2jNPwSutoEbYZoR6vJvgAlXfg9V6w==
X-Received: by 2002:a17:90b:3847:b0:20d:c41f:de7a with SMTP id nl7-20020a17090b384700b0020dc41fde7amr18478400pjb.85.1666038300344;
        Mon, 17 Oct 2022 13:25:00 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
        by smtp.googlemail.com with ESMTPSA id pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 13:25:00 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v3 06/23] btrfs: Convert btree_write_cache_pages() to use filemap_get_folio_tag()
Date:   Mon, 17 Oct 2022 13:24:34 -0700
Message-Id: <20221017202451.4951-7-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017202451.4951-1-vishal.moola@gmail.com>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
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

Converted function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4dcf22e051ff..9ae75db4d55e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2960,14 +2960,14 @@ int btree_write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0;
 	int nr_to_write_done = 0;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	unsigned int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	int scanned = 0;
 	xa_mark_t tag;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* Start from prev offset */
 		end = -1;
@@ -2990,14 +2990,15 @@ int btree_write_cache_pages(struct address_space *mapping,
 	if (wbc->sync_mode == WB_SYNC_ALL)
 		tag_pages_for_writeback(mapping, index, end);
 	while (!done && !nr_to_write_done && (index <= end) &&
-	       (nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
-			tag))) {
+	       (nr_folios = filemap_get_folios_tag(mapping, &index, end,
+					    tag, &fbatch))) {
 		unsigned i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			ret = submit_eb_page(page, wbc, &epd, &eb_context);
+			ret = submit_eb_page(&folio->page, wbc, &epd,
+					&eb_context);
 			if (ret == 0)
 				continue;
 			if (ret < 0) {
@@ -3012,7 +3013,7 @@ int btree_write_cache_pages(struct address_space *mapping,
 			 */
 			nr_to_write_done = wbc->nr_to_write <= 0;
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 	if (!scanned && !done) {
-- 
2.36.1


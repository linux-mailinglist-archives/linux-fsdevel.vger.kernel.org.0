Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5062359F061
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 02:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiHXAmu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 20:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiHXAms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 20:42:48 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49D185FB5;
        Tue, 23 Aug 2022 17:42:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 67so6811441pfv.2;
        Tue, 23 Aug 2022 17:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7skDaFS+wO3x7T1TXAuYW/BptQcipesiqb0XDCtUEEw=;
        b=eHdJm85W11mqHe7iSlXRQz2ygLqKExb3lA40z8uFuGfbXq3WXeGy9DXultohRdLawo
         7Qd4RYcqXdiOD1jVazkFWrVfbcEpZLkLKiYEbbVNpAP6i1Nd7Enztpw0rco/HtfAgelS
         yXfeHGXyD3xjvUoNPjR0C5NtRVGRp7UlscxmNBTFPWt1x2OwLuMcANfed4zmLsZjT/45
         2+zuuS+rYfMhq3rXHITdzud7s/woaEpElOxkAQsM6OVktlhuI4CydOja6ok5+Q7WCPNx
         7UYV6GrwTNA8j6aGb/1ATFVVL0qJDsULOKYgFWsLu62kFPJLVN89ECVXY93Qo3YIHNjG
         RWfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7skDaFS+wO3x7T1TXAuYW/BptQcipesiqb0XDCtUEEw=;
        b=BRY0yZ1pRE+beGrrw3k7cjBTjIihwSXPiH2LRODQAGHyKQdwxVBogAQVryWcmIsERs
         LnEdnphPT2U0B/UxT7jB/qBPNxgLo+XHvKgO6JZQ2tz0qi0Yxt9FjnmZowsnYt91f1+H
         mdrQ+3pKfWlL+nYWYzZiXrWd1mVyuLdD1HdZ9CpoLWmGwKC0KahTFH3qP26ya/e4mObe
         5KO3Q0yNHRF/y/bnwF5JKe4RoNz3MRIclWLyca3Qae2pztaaEx2D1RKxBCvh7iFmwLDO
         b4z01Evi4BgQHkKM6MyNJ/aBP8jctoRjsCzgm8LmgtXGYYWg+RwnJjcBro0H6wQO/XQ9
         /FFA==
X-Gm-Message-State: ACgBeo3NNR4Yxy1yaG3EpNMCVoLvRVvm8KEtYdHKOry1CL9ZzYw+Qu5n
        ZQ3DzhuHijhHrbzAWn0ybCcESNsXnK1fmOdC
X-Google-Smtp-Source: AA6agR5Q1Wli3z1uHbV2YZ/D6eEz/caJjcTDDqR90x6WtSvY1gRmMDL8bMOFSbjugWK/cuKV+GsHyw==
X-Received: by 2002:aa7:9084:0:b0:535:ed0c:f401 with SMTP id i4-20020aa79084000000b00535ed0cf401mr25266450pfa.48.1661301767013;
        Tue, 23 Aug 2022 17:42:47 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id ij5-20020a170902ab4500b0016dd667d511sm11063319plb.252.2022.08.23.17.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 17:42:46 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v3 2/7] btrfs: Convert __process_pages_contig() to use filemap_get_folios_contig()
Date:   Tue, 23 Aug 2022 17:40:18 -0700
Message-Id: <20220824004023.77310-3-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220824004023.77310-1-vishal.moola@gmail.com>
References: <20220824004023.77310-1-vishal.moola@gmail.com>
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

Convert to use folios throughout. This is in preparation for the removal of
find_get_pages_contig(). Now also supports large folios.

Since we may receive more than nr_pages pages, nr_pages may underflow.
Since nr_pages > 0 is equivalent to index <= end_index, we replaced it
with this check instead.

Acked-by: David Sterba <dsterba@suse.com>
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/btrfs/extent_io.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8f6b544ae616..f16929bc531b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1882,9 +1882,8 @@ static int __process_pages_contig(struct address_space *mapping,
 	pgoff_t start_index = start >> PAGE_SHIFT;
 	pgoff_t end_index = end >> PAGE_SHIFT;
 	pgoff_t index = start_index;
-	unsigned long nr_pages = end_index - start_index + 1;
 	unsigned long pages_processed = 0;
-	struct page *pages[16];
+	struct folio_batch fbatch;
 	int err = 0;
 	int i;
 
@@ -1893,16 +1892,17 @@ static int __process_pages_contig(struct address_space *mapping,
 		ASSERT(processed_end && *processed_end == start);
 	}
 
-	if ((page_ops & PAGE_SET_ERROR) && nr_pages > 0)
+	if ((page_ops & PAGE_SET_ERROR) && start_index <= end_index)
 		mapping_set_error(mapping, -EIO);
 
-	while (nr_pages > 0) {
-		int found_pages;
+	folio_batch_init(&fbatch);
+	while (index <= end_index) {
+		int found_folios;
+
+		found_folios = filemap_get_folios_contig(mapping, &index,
+				end_index, &fbatch);
 
-		found_pages = find_get_pages_contig(mapping, index,
-				     min_t(unsigned long,
-				     nr_pages, ARRAY_SIZE(pages)), pages);
-		if (found_pages == 0) {
+		if (found_folios == 0) {
 			/*
 			 * Only if we're going to lock these pages, we can find
 			 * nothing at @index.
@@ -1912,23 +1912,20 @@ static int __process_pages_contig(struct address_space *mapping,
 			goto out;
 		}
 
-		for (i = 0; i < found_pages; i++) {
+		for (i = 0; i < found_folios; i++) {
 			int process_ret;
-
+			struct folio *folio = fbatch.folios[i];
 			process_ret = process_one_page(fs_info, mapping,
-					pages[i], locked_page, page_ops,
+					&folio->page, locked_page, page_ops,
 					start, end);
 			if (process_ret < 0) {
-				for (; i < found_pages; i++)
-					put_page(pages[i]);
 				err = -EAGAIN;
+				folio_batch_release(&fbatch);
 				goto out;
 			}
-			put_page(pages[i]);
-			pages_processed++;
+			pages_processed += folio_nr_pages(folio);
 		}
-		nr_pages -= found_pages;
-		index += found_pages;
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 out:
-- 
2.36.1


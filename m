Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C497D5AA21C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 00:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbiIAWC7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 18:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiIAWCm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:02:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384CE7B1D6;
        Thu,  1 Sep 2022 15:02:41 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mj6so280281pjb.1;
        Thu, 01 Sep 2022 15:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=67A/dC+jR6XpLGLC4ODkJ9hSQCj7SGuspJu+k6nnCZE=;
        b=Gaj0mMM9H3egxmzvqoNe1iEZ8hM4gGCuOLd4DrOQSPxMqktv1CzrXzVDyO8P2nyIk/
         yUBeUFPxBV3eXEeh6ja6r3jkoQsS04RG50Hnxubt2HmCGrtg5eKsV3UPlvUzZnUKawGI
         My9DzO3Xj8pL30ByGUnOEZVfKGDkHTQ2C4HIc/qJJANb+ptbCXEplLhDGKA3WFdXs9M8
         mS8cT1eLA3HlUfNc2XYawFkS2Pm3KnFAocu/vOFGqQPu2plQzBgCe9NVA8+UzmqDvFrB
         1wkufgXt46pAfuPf7/lCvGbjs1HcMTtdBZcKTuJGYsiDo4Y26ACLq07Wk/qpB89Wt8ju
         1+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=67A/dC+jR6XpLGLC4ODkJ9hSQCj7SGuspJu+k6nnCZE=;
        b=YEf+i206i3cFMz8V52U2kvsT7ghXAlnElo7K/sCEN4C2YUpCQRnZY0h3V9rcDME2hG
         q5B7MaHOwGM7PbKQJ3/U3qI1XzLELfrG8bZCiXhs6QX+M1+kgETR3RDyEG96wlsfiVMD
         uZaczCT3TBoo3WFChqfUNeohjF18NNxkqV6ceXHdMa8neRFM9KvVfqbBEYdYQYUFBDmh
         f+ZwJoo4zVz00ojlb72MXtP3v2CkrqfqbGSk4bOmEDCig3AFVOnowoj7Ui9EozA2fQV7
         m9oOGFMf//xUFPYNerjlsQN/giQ9TWosQzoFOyu/J1pbY/IRmeDDblHNqWLHXBxGEflN
         0eYw==
X-Gm-Message-State: ACgBeo25oOfgG2JQBm8bOyNtyToRW+FOeyvGhtVpjxLmo477y4LCDbwJ
        A8SGXuEC3TxpjTKDD8qF8pj6LyKkYYuNlg==
X-Google-Smtp-Source: AA6agR6dxA12uK+I+w8xC2CjqrYGTglG0dwrWM/V/jCpC1FZtdsk4I0wsfRIaHclHD4NelAUtre+yQ==
X-Received: by 2002:a17:90a:640c:b0:1fe:1763:e169 with SMTP id g12-20020a17090a640c00b001fe1763e169mr1291542pjj.35.1662069760287;
        Thu, 01 Sep 2022 15:02:40 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id fv4-20020a17090b0e8400b001fb350026f1sm128894pjb.4.2022.09.01.15.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:02:39 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH 04/23] page-writeback: Convert write_cache_pages() to use filemap_get_folios_tag()
Date:   Thu,  1 Sep 2022 15:01:19 -0700
Message-Id: <20220901220138.182896-5-vishal.moola@gmail.com>
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

Converted function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/page-writeback.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 032a7bf8d259..087165357a5a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2285,15 +2285,15 @@ int write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0;
 	int error;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	int nr_folios;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
 	int range_whole = 0;
 	xa_mark_t tag;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		index = mapping->writeback_index; /* prev offset */
 		end = -1;
@@ -2313,17 +2313,18 @@ int write_cache_pages(struct address_space *mapping,
 	while (!done && (index <= end)) {
 		int i;
 
-		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
-				tag);
-		if (nr_pages == 0)
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				tag, &fbatch);
+
+		if (nr_folios == 0)
 			break;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			done_index = page->index;
+			done_index = folio->index;
 
-			lock_page(page);
+			folio_lock(folio);
 
 			/*
 			 * Page truncated or invalidated. We can freely skip it
@@ -2333,30 +2334,30 @@ int write_cache_pages(struct address_space *mapping,
 			 * even if there is now a new, dirty page at the same
 			 * pagecache address.
 			 */
-			if (unlikely(page->mapping != mapping)) {
+			if (unlikely(folio->mapping != mapping)) {
 continue_unlock:
-				unlock_page(page);
+				folio_unlock(folio);
 				continue;
 			}
 
-			if (!PageDirty(page)) {
+			if (!folio_test_dirty(folio)) {
 				/* someone wrote it for us */
 				goto continue_unlock;
 			}
 
-			if (PageWriteback(page)) {
+			if (folio_test_writeback(folio)) {
 				if (wbc->sync_mode != WB_SYNC_NONE)
-					wait_on_page_writeback(page);
+					folio_wait_writeback(folio);
 				else
 					goto continue_unlock;
 			}
 
-			BUG_ON(PageWriteback(page));
-			if (!clear_page_dirty_for_io(page))
+			BUG_ON(folio_test_writeback(folio));
+			if (!folio_clear_dirty_for_io(folio))
 				goto continue_unlock;
 
 			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
-			error = (*writepage)(page, wbc, data);
+			error = writepage(&folio->page, wbc, data);
 			if (unlikely(error)) {
 				/*
 				 * Handle errors according to the type of
@@ -2371,11 +2372,12 @@ int write_cache_pages(struct address_space *mapping,
 				 * the first error.
 				 */
 				if (error == AOP_WRITEPAGE_ACTIVATE) {
-					unlock_page(page);
+					folio_unlock(folio);
 					error = 0;
 				} else if (wbc->sync_mode != WB_SYNC_ALL) {
 					ret = error;
-					done_index = page->index + 1;
+					done_index = folio->index +
+						folio_nr_pages(folio);
 					done = 1;
 					break;
 				}
@@ -2395,7 +2397,7 @@ int write_cache_pages(struct address_space *mapping,
 				break;
 			}
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
-- 
2.36.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4EC616772
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiKBQLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiKBQLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:14 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA422CDCD;
        Wed,  2 Nov 2022 09:11:13 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id 4so17056307pli.0;
        Wed, 02 Nov 2022 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvlibGQjIurNf1opibXHL1DiqttY5CNVP0rYORWfAjI=;
        b=Gia/2xQtP1i9ycPtinKOiQgjpYF1J9ACaFpAh075vwzsAAhLNjNjwXPx2+vTDRXHUZ
         bZE7LvXvcDHVHatbKpXZr47x9Hs9Q1h4xbF6TvxceMrMsSveweURXYIlV+R88gCZYv6h
         OGEJsEMDJZXdIqsZtg4BoAUnUIyyXd4KPqoF9+M3lG4fab9IdnhxaNtEY8oPI7ibVacD
         ytnjCKB0xNJmaRpuLXjDt8ASUH4+yIxaxOUP0/7p0CNQH+PRkBqmasgPL+jnoVzH3Fpb
         kUPkQn8no5XnSuKHBdcn1wPdHmAGeK2tyKCUjMCDEJu+yG2BBKFd+VDxMe7qKyNYVM+a
         EXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvlibGQjIurNf1opibXHL1DiqttY5CNVP0rYORWfAjI=;
        b=ZlQ4t5/QOZm+dHx+4xXW9AUNWcabo3i/IimAEKfav6I8nChDI17VLP0LyAF+AdiNAF
         zCPhT7NZj60GimamTR77OG+xnwVdib1XyDHu2w5g6Gz5HcK/2eqrb4fe5TN7Z+CNRTTS
         /coXbNElp0XMq9N/+YWePSGDYOMOgbh0S1JnDanEeMh8JM3UooejScUxAVOvlmbD6kYD
         Uo78Dh7Brwp07/7Sz03PSevMnzQyHnaIWXQQ3tF+QN0AtXPtAle+8JEOhQElo6b2QV/q
         9FsRIXN5JMq8XkqKYktpqMPRXGweKEd3k8QQNlU19+yYG/a1VvJso6QEkJOv/e4J8u21
         Z+7Q==
X-Gm-Message-State: ACrzQf2jrMJ/zrmtgusgJl2qkrGd6Sa8J4vwpOvaGW9eo5QAeImu9pkL
        CYzjGwkjjBXN3z54n9iEeRNk1PqAvZYU5Q==
X-Google-Smtp-Source: AMsMyM4X+/f3jD8XaEJ/tjjSk3Zq6RyoQeAhchq0GUaByf6a7jG0+un2QlQf44Fu6bHaytqq3rYlyA==
X-Received: by 2002:a17:903:2cb:b0:171:4f0d:beb6 with SMTP id s11-20020a17090302cb00b001714f0dbeb6mr25037165plk.53.1667405473165;
        Wed, 02 Nov 2022 09:11:13 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:12 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Matthew Wilcow <willy@infradead.org>
Subject: [PATCH v4 04/23] page-writeback: Convert write_cache_pages() to use filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:12 -0700
Message-Id: <20221102161031.5820-5-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102161031.5820-1-vishal.moola@gmail.com>
References: <20221102161031.5820-1-vishal.moola@gmail.com>
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
the removal of find_get_pages_range_tag(). This change removes 8 calls
to compound_head(), and the function now supports large folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Reviewed-by: Matthew Wilcow (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7e9d8d857ecc..aeec8b196232 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2286,15 +2286,15 @@ int write_cache_pages(struct address_space *mapping,
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
@@ -2314,17 +2314,18 @@ int write_cache_pages(struct address_space *mapping,
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
@@ -2334,30 +2335,30 @@ int write_cache_pages(struct address_space *mapping,
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
@@ -2372,11 +2373,12 @@ int write_cache_pages(struct address_space *mapping,
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
@@ -2396,7 +2398,7 @@ int write_cache_pages(struct address_space *mapping,
 				break;
 			}
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
-- 
2.38.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB92061681E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiKBQNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiKBQLa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:11:30 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305482CC9F;
        Wed,  2 Nov 2022 09:11:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h14so16689041pjv.4;
        Wed, 02 Nov 2022 09:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRHFvRATz/y8GqBUnd9mNnOud0frXSc+Rjf1hBP1wek=;
        b=d+XW6yxgXUY/dmps54gO3wO2PqfF8X3sDq8smHylpJ6nIBM4zBsMHva2qm9I5LqFL2
         QACM5WP55FNzn65wJVW4x0X2RQo6CyKMexU8FSBY8AG10ZNAulWmhqckyER1nkGiMspT
         ZqA37FmcbK1m4i2HkqGatmsrYga/1zR/iZHsdk5MofsLoef0pUwG1V2srcoch/HfEeq8
         Y3DYJ4onfq8FUAsSEfM43oAaV9FZAb2zY7fgjbbPkp3CBRQ6fMxNaaP0LxQZ0KDfWacU
         QL/qfoVB6iYB21fApOEhxGO+DRiBPMI/3V1bJAvtZeXMX4jXPeFp8lCyOrD8PwuvfwWa
         euXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRHFvRATz/y8GqBUnd9mNnOud0frXSc+Rjf1hBP1wek=;
        b=1PUFYcUREuLW4BDYiZkOddCNl+tJnM1lbEd1Isp76zMUwLB4ClSxJSfD1G/7O8IMvb
         EdJM7HWnkREhlNGwHx4QGHeUgDqHr0PWQSLJmDN9A+eEGEWUGTOIgpHTCoG9HoK57ru5
         Zud1G1gYiGWC/MB21AXoR1ZoMqaAwJnbBPqvd5Y+W6V5xT/d5lOhkxp9zIYQzeArmlwd
         R5LnHTiNy5s+OI2HSCrXDO6JHOPP9qUsOMh3yT5naz1DafspYXwFMDA/i1fCz7wYcoKW
         D8I1b9eprnQh0/AEukQN38pRSPz/pFKKR1c+Byzd+N0vjqkQY4atWtJ9JNmggxOoEy59
         B7SQ==
X-Gm-Message-State: ACrzQf3P3QLbvQ2dS5gynuq1qP/pQdw3duYutznAh4DQLXjZPVwk1aZ3
        2P/xbXkSLRr9I1widKppp9rm0ECVgGwrqA==
X-Google-Smtp-Source: AMsMyM5LdBAn65fV58RDcya59S76voFKa7sKrxzTyfWnCaf8L6hHgNBfM7eEbdAJBhgLDTjmpfKq+w==
X-Received: by 2002:a17:902:f786:b0:180:6f9e:23b with SMTP id q6-20020a170902f78600b001806f9e023bmr26013889pln.37.1667405482254;
        Wed, 02 Nov 2022 09:11:22 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:21 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v4 10/23] ext4: Convert mpage_prepare_extent_to_map() to use filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:18 -0700
Message-Id: <20221102161031.5820-11-vishal.moola@gmail.com>
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

Converted the function to use folios throughout. This is in preparation
for the removal of find_get_pages_range_tag(). Now supports large
folios. This change removes 10 calls to compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/ext4/inode.c | 55 ++++++++++++++++++++++++-------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2b5ef1b64249..69a0708c8e87 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2572,8 +2572,8 @@ static int ext4_da_writepages_trans_blocks(struct inode *inode)
 static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 {
 	struct address_space *mapping = mpd->inode->i_mapping;
-	struct pagevec pvec;
-	unsigned int nr_pages;
+	struct folio_batch fbatch;
+	unsigned int nr_folios;
 	long left = mpd->wbc->nr_to_write;
 	pgoff_t index = mpd->first_page;
 	pgoff_t end = mpd->last_page;
@@ -2587,18 +2587,17 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 		tag = PAGECACHE_TAG_TOWRITE;
 	else
 		tag = PAGECACHE_TAG_DIRTY;
-
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	mpd->map.m_len = 0;
 	mpd->next_page = index;
 	while (index <= end) {
-		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
-				tag);
-		if (nr_pages == 0)
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				tag, &fbatch);
+		if (nr_folios == 0)
 			break;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
 			/*
 			 * Accumulated enough dirty pages? This doesn't apply
@@ -2612,10 +2611,10 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 				goto out;
 
 			/* If we can't merge this page, we are done. */
-			if (mpd->map.m_len > 0 && mpd->next_page != page->index)
+			if (mpd->map.m_len > 0 && mpd->next_page != folio->index)
 				goto out;
 
-			lock_page(page);
+			folio_lock(folio);
 			/*
 			 * If the page is no longer dirty, or its mapping no
 			 * longer corresponds to inode we are writing (which
@@ -2623,16 +2622,16 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 * page is already under writeback and we are not doing
 			 * a data integrity writeback, skip the page
 			 */
-			if (!PageDirty(page) ||
-			    (PageWriteback(page) &&
+			if (!folio_test_dirty(folio) ||
+			    (folio_test_writeback(folio) &&
 			     (mpd->wbc->sync_mode == WB_SYNC_NONE)) ||
-			    unlikely(page->mapping != mapping)) {
-				unlock_page(page);
+			    unlikely(folio->mapping != mapping)) {
+				folio_unlock(folio);
 				continue;
 			}
 
-			wait_on_page_writeback(page);
-			BUG_ON(PageWriteback(page));
+			folio_wait_writeback(folio);
+			BUG_ON(folio_test_writeback(folio));
 
 			/*
 			 * Should never happen but for buggy code in
@@ -2643,33 +2642,33 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
 			 *
 			 * [1] https://lore.kernel.org/linux-mm/20180103100430.GE4911@quack2.suse.cz
 			 */
-			if (!page_has_buffers(page)) {
-				ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", page->index);
-				ClearPageDirty(page);
-				unlock_page(page);
+			if (!folio_buffers(folio)) {
+				ext4_warning_inode(mpd->inode, "page %lu does not have buffers attached", folio->index);
+				folio_clear_dirty(folio);
+				folio_unlock(folio);
 				continue;
 			}
 
 			if (mpd->map.m_len == 0)
-				mpd->first_page = page->index;
-			mpd->next_page = page->index + 1;
+				mpd->first_page = folio->index;
+			mpd->next_page = folio->index + folio_nr_pages(folio);
 			/* Add all dirty buffers to mpd */
-			lblk = ((ext4_lblk_t)page->index) <<
+			lblk = ((ext4_lblk_t)folio->index) <<
 				(PAGE_SHIFT - blkbits);
-			head = page_buffers(page);
+			head = folio_buffers(folio);
 			err = mpage_process_page_bufs(mpd, head, head, lblk);
 			if (err <= 0)
 				goto out;
 			err = 0;
-			left--;
+			left -= folio_nr_pages(folio);
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 	mpd->scanned_until_end = 1;
 	return 0;
 out:
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	return err;
 }
 
-- 
2.38.1


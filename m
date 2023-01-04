Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0209E65DE7C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240433AbjADVPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240335AbjADVPN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:13 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287D11DDD3;
        Wed,  4 Jan 2023 13:15:11 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p24so14704734plw.11;
        Wed, 04 Jan 2023 13:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHssniIq+RlTj6I0G4i7GbLR9EaGoRL5pu7+dnl0w2w=;
        b=O/D+NyPTy4M1sTh+3k/lC1rj/VKJWtCGwMlhTfn6qpBhtlxCb9k3sWDk9Z0oOhWhza
         3YwunlQmpmQxHIwc3slP5cWFOfArgatFhNuDOerJW0qUBaI5Zgn5t2tO2YQmHBKWt0/g
         MFSh/uQIxzlLLmgNa+OoXc3BzfvnfBPdtpNgXKui16mDPVeraZQtRKVUTS73rT71TPkz
         aIA4qX4NfhLb32N2QF9lXy9drDX9/rkV28NsYpAoVy0G5yfIgIIv+sWh1wOSNzvEDIG6
         wJ4oTDHW5KSfgFq7up1/6mIHSjyF7qj/i6841phIxUGWM6AsJ76lWkCXX+vMLrxxAo9V
         fPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bHssniIq+RlTj6I0G4i7GbLR9EaGoRL5pu7+dnl0w2w=;
        b=lHcZ2fbHOWZj7p18+C/oYZRDxWviM4/HylGSm1vcnE5/u2DDoQUfGhvCaK5mX6xq+X
         nz6gnfu7nKKFIVhpzLXV1daJbeMF5mnQMlvQ926WFJsmz9ck+xYaPkwDUv9mVTFS8SUi
         K9JZyB+6PINBkrXhScBJWQ4HnCRE7D9njsngnhj/shWcMh+kjhgdrbu1MfphnO4KQxOS
         LppnsUkw2LVaINtwSo1EcYnf0T5kn4u9hL3Q1O3/zI89/1XZ3ODjoBoRIwpT0hL4A4hB
         ZyEYzxPbYkX6/OO4lQjrwMe0a5OsdvvudJElC8JBVbWf2Dn9cCQFE3Gc+Wl3//IvLn63
         EOsg==
X-Gm-Message-State: AFqh2krXYo06zVQuyFV8hY+WFmZv+lRCEN5i+IXw0zjOoozz8SPwqbEA
        XsXMSXibu4EqeOVWZC/bnIcfTg3Smi1SfA==
X-Google-Smtp-Source: AMrXdXvz9PRTiN1Iw35FsCYmgqPK+8WXm1LuX9COnFA/dLcxFRJCp85h7YOKjNSg0G/oIOwdsOogTA==
X-Received: by 2002:a17:90b:3793:b0:226:744:d46a with SMTP id mz19-20020a17090b379300b002260744d46amr31270463pjb.41.1672866910524;
        Wed, 04 Jan 2023 13:15:10 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:10 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v5 10/23] ext4: Convert mpage_prepare_extent_to_map() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:35 -0800
Message-Id: <20230104211448.4804-11-vishal.moola@gmail.com>
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

Converted the function to use folios throughout. This is in preparation
for the removal of find_get_pages_range_tag(). Now supports large
folios. This change removes 11 calls to compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/ext4/inode.c | 65 ++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 9d9f414f99fe..fb6cd994e59a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2595,8 +2595,8 @@ static bool ext4_page_nomap_can_writeout(struct page *page)
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
@@ -2610,18 +2610,17 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
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
@@ -2635,10 +2634,10 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
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
@@ -2646,16 +2645,16 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
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
@@ -2666,49 +2665,49 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
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
 			/*
 			 * Writeout for transaction commit where we cannot
 			 * modify metadata is simple. Just submit the page.
 			 */
 			if (!mpd->can_map) {
-				if (ext4_page_nomap_can_writeout(page)) {
-					err = mpage_submit_page(mpd, page);
+				if (ext4_page_nomap_can_writeout(&folio->page)) {
+					err = mpage_submit_page(mpd, &folio->page);
 					if (err < 0)
 						goto out;
 				} else {
-					unlock_page(page);
-					mpd->first_page++;
+					folio_unlock(folio);
+					mpd->first_page += folio_nr_pages(folio);
 				}
 			} else {
 				/* Add all dirty buffers to mpd */
-				lblk = ((ext4_lblk_t)page->index) <<
+				lblk = ((ext4_lblk_t)folio->index) <<
 					(PAGE_SHIFT - blkbits);
-				head = page_buffers(page);
+				head = folio_buffers(folio);
 				err = mpage_process_page_bufs(mpd, head, head,
-							      lblk);
+						lblk);
 				if (err <= 0)
 					goto out;
 				err = 0;
 			}
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


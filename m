Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7059265DE68
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbjADVQE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240351AbjADVPU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:20 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE591B9DA;
        Wed,  4 Jan 2023 13:15:19 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o21so7400579pjw.0;
        Wed, 04 Jan 2023 13:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=95X87nsP2uu1g0tSzKPuV0qHzijMRAuzyWHPCNhVLfk=;
        b=JCPoNtFnRO14zsnrzATg9kL0JDP6tVcnKx3JUX6/3ncoBKAJOrdzAnqcJfisGtVG+1
         dpzq+dUPXHOKZJgfHr44JpBFeOtfbWmIahDTecFP0YCOZ21+b2HqR4qxtZ3cxCJVSUO4
         8VpfGyEp5nVdeztFirVOET5gBHXuwsM9pBvFeES2ux3EMo1g2WrhlgBtDP1DDvcKoyo9
         3cT+mvBMCWl/wiVX2MJDZxNZQbsgenI1tEgLnjzakrMYONEHe9y2YdlGpG40iclkX2Tz
         iSga8vy8hS5O8VIUTkiKp/uJ+L9iOcKcIjs79iMUkx4gTW6zOE9upSWw0xbISSOb+PNN
         TSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=95X87nsP2uu1g0tSzKPuV0qHzijMRAuzyWHPCNhVLfk=;
        b=GdRVqO5WKd9U73updKfVbwr24d5H+CSbzhmKgMF2w6Gew5k52fZlR72gVfM75OR8w9
         4+/t5mgN2bRM51PEWV0p52UQXQ+LU6qWs/aFaH22dr6aXf+ofO98FHRLJM96Fom+vKGO
         sQ0YwpHPKTfyQgqpwRWIf+c4JbFwh+7SJQZ9IYtEs83Da2e8vK+6cf03NGruDoScJbno
         j/FXe629exRHstYvBqTqd2x1uJ00/q9rAHPvQx3O8/aPibJA+N6oH3aPldDZSzurNs/9
         j4XQpOp0NM8wTRftKPZ9g7roufmWB3eWr2z83RMaewZ8F2217rp+L5+LM1fuOjzzO7yH
         U0mw==
X-Gm-Message-State: AFqh2kp9zJIAUN4euIKowJZPw94pJu7E2dGwBSrbsInZzSwaO7UtBNlx
        /vZzMVvud0qGXj4iJPeFGMY9H1KigjUmZA==
X-Google-Smtp-Source: AMrXdXv+IJ/1Onv1LqxAjAHLMrh9yjoD4TbJ2m1yweDywr0DpF1fsJfqACSUi/iDN1g4t8sjVOowxA==
X-Received: by 2002:a17:90b:268c:b0:225:c26d:4c52 with SMTP id pl12-20020a17090b268c00b00225c26d4c52mr47094486pjb.48.1672866918925;
        Wed, 04 Jan 2023 13:15:18 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:18 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Chao Yu <chao@kernel.org>
Subject: [PATCH v5 16/23] f2fs: Convert f2fs_sync_meta_pages() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:41 -0800
Message-Id: <20230104211448.4804-17-vishal.moola@gmail.com>
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

Convert function to use folios throughout. This is in preparation for the
removal of find_get_pages_range_tag(). This change removes 5 calls to
compound_head().

Initially the function was checking if the previous page index is truly the
previous page i.e. 1 index behind the current page. To convert to folios and
maintain this check we need to make the check
folio->index != prev + folio_nr_pages(previous folio) since we don't know
how many pages are in a folio.

At index i == 0 the check is guaranteed to succeed, so to workaround indexing
bounds we can simply ignore the check for that specific index. This makes the
initial assignment of prev trivial, so I removed that as well.

Also modified a comment in commit_checkpoint for consistency.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c | 49 +++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 56f7d0d6a8b2..5a5515d83a1b 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -395,59 +395,62 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
 {
 	struct address_space *mapping = META_MAPPING(sbi);
 	pgoff_t index = 0, prev = ULONG_MAX;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	long nwritten = 0;
-	int nr_pages;
+	int nr_folios;
 	struct writeback_control wbc = {
 		.for_reclaim = 0,
 	};
 	struct blk_plug plug;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
 	blk_start_plug(&plug);
 
-	while ((nr_pages = pagevec_lookup_tag(&pvec, mapping, &index,
-				PAGECACHE_TAG_DIRTY))) {
+	while ((nr_folios = filemap_get_folios_tag(mapping, &index,
+					(pgoff_t)-1,
+					PAGECACHE_TAG_DIRTY, &fbatch))) {
 		int i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
 
-			if (prev == ULONG_MAX)
-				prev = page->index - 1;
-			if (nr_to_write != LONG_MAX && page->index != prev + 1) {
-				pagevec_release(&pvec);
+			if (nr_to_write != LONG_MAX && i != 0 &&
+					folio->index != prev +
+					folio_nr_pages(fbatch.folios[i-1])) {
+				folio_batch_release(&fbatch);
 				goto stop;
 			}
 
-			lock_page(page);
+			folio_lock(folio);
 
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
 
-			f2fs_wait_on_page_writeback(page, META, true, true);
+			f2fs_wait_on_page_writeback(&folio->page, META,
+					true, true);
 
-			if (!clear_page_dirty_for_io(page))
+			if (!folio_clear_dirty_for_io(folio))
 				goto continue_unlock;
 
-			if (__f2fs_write_meta_page(page, &wbc, io_type)) {
-				unlock_page(page);
+			if (__f2fs_write_meta_page(&folio->page, &wbc,
+						io_type)) {
+				folio_unlock(folio);
 				break;
 			}
-			nwritten++;
-			prev = page->index;
+			nwritten += folio_nr_pages(folio);
+			prev = folio->index;
 			if (unlikely(nwritten >= nr_to_write))
 				break;
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 stop:
@@ -1403,7 +1406,7 @@ static void commit_checkpoint(struct f2fs_sb_info *sbi,
 	};
 
 	/*
-	 * pagevec_lookup_tag and lock_page again will take
+	 * filemap_get_folios_tag and lock_page again will take
 	 * some extra time. Therefore, f2fs_update_meta_pages and
 	 * f2fs_sync_meta_pages are combined in this function.
 	 */
-- 
2.38.1


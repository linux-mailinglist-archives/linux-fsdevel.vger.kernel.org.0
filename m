Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81EF5B60DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 20:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiILS3A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 14:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiILS2R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:28:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177BE4454B;
        Mon, 12 Sep 2022 11:26:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id go6so4703129pjb.2;
        Mon, 12 Sep 2022 11:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=YZ9m9PEte2VFIEg+ZjqrJWhRYr046qHZsEH0p4wP4bQ=;
        b=PzgRiXVE3yrxA/K+oDOKGWXJ1AL69iNVAX5Ct8UX0CAc07XinJWHOHoRdZO3Yau9YR
         c8vGsb0z95KFb6fVMII+ntFC6dzlS1BHKUcFlptsDc91LYeHSvmtg4Hbg8D/ORa1TF7p
         H8dLeiPvRIZeb6AVCdqBZ6yhgJRtkYSjfhTXN0xtP4ycbR9huzolwut/ABl161ypgBl7
         A6HA2HyiGQWO4YhdzlnWAwYFsURg5TPW+l4AjlG4i9JJBB/Fu99iXvsFjS4vMCIg2uAD
         gLJqXP5sgRQzYDD7eBdgtZtbPWgf1Vd/GBHerYBx8Yq7FaHBwo//n3qz9Gh4ToeeAwTC
         0N7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=YZ9m9PEte2VFIEg+ZjqrJWhRYr046qHZsEH0p4wP4bQ=;
        b=cf7ESeFl0UGtkDQT3q14fvMfypQyVaGLP3cMhwZl6ec9X9B7rWDE2AksVIh6+rmKpX
         JBlDZRABaDdfS2+EDjUQEP7D7RvOCdZKjSAu3mnGp9a6dM/7lziO6CpxIGEkbd1+X9jE
         EJMkAFLPgFz24u2SD/kj57KPFt5I9dI9jMvA5o/DxOlp/cGplr3TDsVWvpTE9k/CqEKE
         /XYM1OWlXtn9N9bDNGZ+6H4DNjIppg4U6ls3KcG7RRbgAPQsD2uSc8p8uCWtPJmH+h8V
         SscI7sYLia9qNHLc4f7rG6tcF1S15YjJQrQefKwQN6ms8VSMVhziD74F4xZ3C4it9zPD
         3FFQ==
X-Gm-Message-State: ACgBeo0oY/3r9K6F+mTnoTajFujO6liouup8ssEklJeo9NoS3gv9/W/h
        hr1f9nIRGN+bdIWQQREBvX2Tf3R3+QJKEg==
X-Google-Smtp-Source: AA6agR6vSFy+9kM45HEYmvJBMnXUggnIRCddt2JVkkB9zZi/qC2JZFNfFnJUz4f9ZFSD6bx6zCUCJA==
X-Received: by 2002:a17:902:8643:b0:172:e067:d7ac with SMTP id y3-20020a170902864300b00172e067d7acmr28154722plt.164.1663007149311;
        Mon, 12 Sep 2022 11:25:49 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm5916894pfb.39.2022.09.12.11.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:25:48 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 17/23] gfs2: Convert gfs2_write_cache_jdata() to use filemap_get_folios_tag()
Date:   Mon, 12 Sep 2022 11:22:18 -0700
Message-Id: <20220912182224.514561-18-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220912182224.514561-1-vishal.moola@gmail.com>
References: <20220912182224.514561-1-vishal.moola@gmail.com>
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
the removal of find_get_pgaes_range_tag().

Also had to modify and rename gfs2_write_jdata_pagevec() to take in
and utilize folio_batch rather than pagevec and use folios rather
than pages. gfs2_write_jdata_batch() now supports large folios.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/gfs2/aops.c | 64 +++++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index 05bee80ac7de..8f87c2551a3d 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -195,67 +195,71 @@ static int gfs2_writepages(struct address_space *mapping,
 }
 
 /**
- * gfs2_write_jdata_pagevec - Write back a pagevec's worth of pages
+ * gfs2_write_jdata_batch - Write back a folio batch's worth of folios
  * @mapping: The mapping
  * @wbc: The writeback control
- * @pvec: The vector of pages
- * @nr_pages: The number of pages to write
+ * @fbatch: The batch of folios
  * @done_index: Page index
  *
  * Returns: non-zero if loop should terminate, zero otherwise
  */
 
-static int gfs2_write_jdata_pagevec(struct address_space *mapping,
+static int gfs2_write_jdata_batch(struct address_space *mapping,
 				    struct writeback_control *wbc,
-				    struct pagevec *pvec,
-				    int nr_pages,
+				    struct folio_batch *fbatch,
 				    pgoff_t *done_index)
 {
 	struct inode *inode = mapping->host;
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
-	unsigned nrblocks = nr_pages * (PAGE_SIZE >> inode->i_blkbits);
+	unsigned nrblocks;
 	int i;
 	int ret;
+	int nr_pages = 0;
+	int nr_folios = folio_batch_count(fbatch);
+
+	for (i = 0; i < nr_folios; i++)
+		nr_pages += folio_nr_pages(fbatch->folios[i]);
+	nrblocks = nr_pages * (PAGE_SIZE >> inode->i_blkbits);
 
 	ret = gfs2_trans_begin(sdp, nrblocks, nrblocks);
 	if (ret < 0)
 		return ret;
 
-	for(i = 0; i < nr_pages; i++) {
-		struct page *page = pvec->pages[i];
+	for (i = 0; i < nr_folios; i++) {
+		struct folio *folio = fbatch->folios[i];
 
-		*done_index = page->index;
+		*done_index = folio->index;
 
-		lock_page(page);
+		folio_lock(folio);
 
-		if (unlikely(page->mapping != mapping)) {
+		if (unlikely(folio->mapping != mapping)) {
 continue_unlock:
-			unlock_page(page);
+			folio_unlock(folio);
 			continue;
 		}
 
-		if (!PageDirty(page)) {
+		if (!folio_test_dirty(folio)) {
 			/* someone wrote it for us */
 			goto continue_unlock;
 		}
 
-		if (PageWriteback(page)) {
+		if (folio_test_writeback(folio)) {
 			if (wbc->sync_mode != WB_SYNC_NONE)
-				wait_on_page_writeback(page);
+				folio_wait_writeback(folio);
 			else
 				goto continue_unlock;
 		}
 
-		BUG_ON(PageWriteback(page));
-		if (!clear_page_dirty_for_io(page))
+		BUG_ON(folio_test_writeback(folio));
+		if (!folio_clear_dirty_for_io(folio))
 			goto continue_unlock;
 
 		trace_wbc_writepage(wbc, inode_to_bdi(inode));
 
-		ret = __gfs2_jdata_writepage(page, wbc);
+		ret = __gfs2_jdata_writepage(&folio->page, wbc);
 		if (unlikely(ret)) {
 			if (ret == AOP_WRITEPAGE_ACTIVATE) {
-				unlock_page(page);
+				folio_unlock(folio);
 				ret = 0;
 			} else {
 
@@ -268,7 +272,8 @@ static int gfs2_write_jdata_pagevec(struct address_space *mapping,
 				 * not be suitable for data integrity
 				 * writeout).
 				 */
-				*done_index = page->index + 1;
+				*done_index = folio->index +
+					folio_nr_pages(folio);
 				ret = 1;
 				break;
 			}
@@ -305,8 +310,8 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
 {
 	int ret = 0;
 	int done = 0;
-	struct pagevec pvec;
-	int nr_pages;
+	struct folio_batch fbatch;
+	int nr_folios;
 	pgoff_t writeback_index;
 	pgoff_t index;
 	pgoff_t end;
@@ -315,7 +320,7 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
 	int range_whole = 0;
 	xa_mark_t tag;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 	if (wbc->range_cyclic) {
 		writeback_index = mapping->writeback_index; /* prev offset */
 		index = writeback_index;
@@ -341,17 +346,18 @@ static int gfs2_write_cache_jdata(struct address_space *mapping,
 		tag_pages_for_writeback(mapping, index, end);
 	done_index = index;
 	while (!done && (index <= end)) {
-		nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end,
-				tag);
-		if (nr_pages == 0)
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				tag, &fbatch);
+		if (nr_folios == 0)
 			break;
 
-		ret = gfs2_write_jdata_pagevec(mapping, wbc, &pvec, nr_pages, &done_index);
+		ret = gfs2_write_jdata_batch(mapping, wbc, &fbatch,
+				&done_index);
 		if (ret)
 			done = 1;
 		if (ret > 0)
 			ret = 0;
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 	}
 
-- 
2.36.1


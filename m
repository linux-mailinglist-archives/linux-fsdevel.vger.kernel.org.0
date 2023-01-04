Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629B765DE8F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jan 2023 22:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240553AbjADVQB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 16:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240348AbjADVPS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:15:18 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08A21CFEA;
        Wed,  4 Jan 2023 13:15:16 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id n12so24641316pjp.1;
        Wed, 04 Jan 2023 13:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geJwjn4yJKU06Ftbar/y+HcHHoAvhwpeBoUnwsGYEks=;
        b=Fd8n+f1/NPank65Zw/kHWJBXTOelusyND5cLXZf9F1s+KS4ORsP19uuv4siEdxBQJT
         10Ra99IFy6Oh1HDT1wvzP/oAFamJWd9Qb78Y7+Dr1J5qmNaV5uUh0D+BORnnhdkICTEi
         hvZ+N2BPjnPfx8nWabVIQ1bECzthUh6LIjPR0RUAG1DeoReFNu2ALc98+mFNSkzv5jSF
         7ilXbV6Nd18bsqHzZbqMVX3Ckh1Ya5P58tpex0qa/qLrNBKPcUgEHDw0n2jHxI1unlNg
         jnduvhRGFEBTsAEtI0NgpHNFrUDMt7WRZ2kUYfejbotDf+e3vgHq5Tkx9eaJHjgYE3BO
         Jn4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geJwjn4yJKU06Ftbar/y+HcHHoAvhwpeBoUnwsGYEks=;
        b=jiNi9ijJJvZRzoeKvWm1pQIQrf+dfqG1q3p8nnDJAOqcB5yTXOb63cCmUIKPQo7SI7
         PgCPo1SrmmArRM7tlkeLfnbhYq2SV97lrwqG+fMv9AXAY55YmFgH0Ho2QDZZGDZdHhK0
         0I5QNUffqb3DYGw4wMxXUeIPcaWvwvdbJNzbQthWj8qBUKEg0FLFv4q4uZ1OLGfkp/l9
         ZQWRlU8y4CpzdVaVJVXO0N7/nYPrg+HANH5FahdDniX3t26+oVo/X7rYr8pVG4G54FOm
         Bn8H/czSoyODSrxCAIohUprT4zoMLYCp8w2eOq3WUC/F+0DRkUyhWSPqejwD2ZGf/sUZ
         N76Q==
X-Gm-Message-State: AFqh2koZOBOQ4noojmq5EECfcl/YWX5si/FOP3Pvi+zfbZxwcDqheKAY
        h6is4sftgFcm3ofzTSzyA2A4wsgD3i+LKw==
X-Google-Smtp-Source: AMrXdXvBKEF5T2wnCoAj1IOJ4U73abN05uBfAh53KWBYn4m7hU5hHoJzlZNlJTGgGpr6V62AVrABGQ==
X-Received: by 2002:a05:6a20:8ee1:b0:ac:3f3f:9fbd with SMTP id m33-20020a056a208ee100b000ac3f3f9fbdmr49160604pzk.48.1672866916135;
        Wed, 04 Jan 2023 13:15:16 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::a55d])
        by smtp.googlemail.com with ESMTPSA id i8-20020a17090a138800b00226369149cesm6408pja.21.2023.01.04.13.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 13:15:15 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v5 14/23] f2fs: Convert f2fs_write_cache_pages() to use filemap_get_folios_tag()
Date:   Wed,  4 Jan 2023 13:14:39 -0800
Message-Id: <20230104211448.4804-15-vishal.moola@gmail.com>
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

Converted the function to use a folio_batch instead of pagevec. This is in
preparation for the removal of find_get_pages_range_tag().

Also modified f2fs_all_cluster_page_ready to take in a folio_batch instead
of pagevec. This does NOT support large folios. The function currently
only utilizes folios of size 1 so this shouldn't cause any issues right
now.

This version of the patch limits the number of pages fetched to
F2FS_ONSTACK_PAGES. If that ever happens, update the start index here
since filemap_get_folios_tag() updates the index to be after the last
found folio, not necessarily the last used page.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/data.c | 84 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 26 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6e43e19c7d1c..ee1256e4fd92 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2957,6 +2957,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	int ret = 0;
 	int done = 0, retry = 0;
 	struct page *pages[F2FS_ONSTACK_PAGES];
+	struct folio_batch fbatch;
 	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
 	struct bio *bio = NULL;
 	sector_t last_block;
@@ -2977,6 +2978,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		.private = NULL,
 	};
 #endif
+	int nr_folios, p, idx;
 	int nr_pages;
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
@@ -2987,6 +2989,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	int submitted = 0;
 	int i;
 
+	folio_batch_init(&fbatch);
+
 	if (get_dirty_pages(mapping->host) <=
 				SM_I(F2FS_M_SB(mapping))->min_hot_blocks)
 		set_inode_flag(mapping->host, FI_HOT_DATA);
@@ -3012,13 +3016,38 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		tag_pages_for_writeback(mapping, index, end);
 	done_index = index;
 	while (!done && !retry && (index <= end)) {
-		nr_pages = find_get_pages_range_tag(mapping, &index, end,
-				tag, F2FS_ONSTACK_PAGES, pages);
-		if (nr_pages == 0)
+		nr_pages = 0;
+again:
+		nr_folios = filemap_get_folios_tag(mapping, &index, end,
+				tag, &fbatch);
+		if (nr_folios == 0) {
+			if (nr_pages)
+				goto write;
 			break;
+		}
 
+		for (i = 0; i < nr_folios; i++) {
+			struct folio *folio = fbatch.folios[i];
+
+			idx = 0;
+			p = folio_nr_pages(folio);
+add_more:
+			pages[nr_pages] = folio_page(folio, idx);
+			folio_get(folio);
+			if (++nr_pages == F2FS_ONSTACK_PAGES) {
+				index = folio->index + idx + 1;
+				folio_batch_release(&fbatch);
+				goto write;
+			}
+			if (++idx < p)
+				goto add_more;
+		}
+		folio_batch_release(&fbatch);
+		goto again;
+write:
 		for (i = 0; i < nr_pages; i++) {
 			struct page *page = pages[i];
+			struct folio *folio = page_folio(page);
 			bool need_readd;
 readd:
 			need_readd = false;
@@ -3035,7 +3064,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				}
 
 				if (!f2fs_cluster_can_merge_page(&cc,
-								page->index)) {
+								folio->index)) {
 					ret = f2fs_write_multi_pages(&cc,
 						&submitted, wbc, io_type);
 					if (!ret)
@@ -3044,27 +3073,28 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				}
 
 				if (unlikely(f2fs_cp_error(sbi)))
-					goto lock_page;
+					goto lock_folio;
 
 				if (!f2fs_cluster_is_empty(&cc))
-					goto lock_page;
+					goto lock_folio;
 
 				if (f2fs_all_cluster_page_ready(&cc,
 					pages, i, nr_pages, true))
-					goto lock_page;
+					goto lock_folio;
 
 				ret2 = f2fs_prepare_compress_overwrite(
 							inode, &pagep,
-							page->index, &fsdata);
+							folio->index, &fsdata);
 				if (ret2 < 0) {
 					ret = ret2;
 					done = 1;
 					break;
 				} else if (ret2 &&
 					(!f2fs_compress_write_end(inode,
-						fsdata, page->index, 1) ||
+						fsdata, folio->index, 1) ||
 					 !f2fs_all_cluster_page_ready(&cc,
-						pages, i, nr_pages, false))) {
+						pages, i, nr_pages,
+						false))) {
 					retry = 1;
 					break;
 				}
@@ -3077,46 +3107,47 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				break;
 			}
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-lock_page:
+lock_folio:
 #endif
-			done_index = page->index;
+			done_index = folio->index;
 retry_write:
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
 
-			if (PageWriteback(page)) {
+			if (folio_test_writeback(folio)) {
 				if (wbc->sync_mode != WB_SYNC_NONE)
-					f2fs_wait_on_page_writeback(page,
+					f2fs_wait_on_page_writeback(
+							&folio->page,
 							DATA, true, true);
 				else
 					goto continue_unlock;
 			}
 
-			if (!clear_page_dirty_for_io(page))
+			if (!folio_clear_dirty_for_io(folio))
 				goto continue_unlock;
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 			if (f2fs_compressed_file(inode)) {
-				get_page(page);
-				f2fs_compress_ctx_add_page(&cc, page);
+				folio_get(folio);
+				f2fs_compress_ctx_add_page(&cc, &folio->page);
 				continue;
 			}
 #endif
-			ret = f2fs_write_single_data_page(page, &submitted,
-					&bio, &last_block, wbc, io_type,
-					0, true);
+			ret = f2fs_write_single_data_page(&folio->page,
+					&submitted, &bio, &last_block,
+					wbc, io_type, 0, true);
 			if (ret == AOP_WRITEPAGE_ACTIVATE)
-				unlock_page(page);
+				folio_unlock(folio);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 result:
 #endif
@@ -3140,7 +3171,8 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 					}
 					goto next;
 				}
-				done_index = page->index + 1;
+				done_index = folio->index +
+					folio_nr_pages(folio);
 				done = 1;
 				break;
 			}
-- 
2.38.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6828462EE5F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Nov 2022 08:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbiKRHbM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Nov 2022 02:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241118AbiKRHbC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Nov 2022 02:31:02 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0BD205EF;
        Thu, 17 Nov 2022 23:31:00 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 6so4298036pgm.6;
        Thu, 17 Nov 2022 23:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re0/IOxZf5Hx6BeFa9inJCF0a6cGKdlu1k/P2sxW8QU=;
        b=JbqHqUy5gwXZXXmeVcz1VjkFSML8VbgCJWNNoIeSydHy4Efkp/nj8IFLHy4/PRyQHV
         ZD3+lwCTNEDhNf9veaDSLhz7j3rTE4dSA4jeOiZEUCQyws3Y+MXRKm5Dx6naoty++WGj
         mgSMypdnxVTv66L8q6FElC2UoiRdmhg+l5LTbN2Cc3AqtbTaJnJbry0nqqNvt41WohIs
         ztjkEsGC3JY6Tb7yMLuQkZ4ruAJGVqCUBWYkGv/ejG/TxtUngfWOAkENVYlHfIHeipzE
         4EaQZm6twldEsxve4TG9hLLt2BHQD5Wol13hE8LCOU9klaLw9axg+PJfCy1uLkMcLHnC
         TDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Re0/IOxZf5Hx6BeFa9inJCF0a6cGKdlu1k/P2sxW8QU=;
        b=Ssipmmnta0bunipCbxktQBOE47EAyjYu+/r9/xdaWlKIeLIzCqiwiLisJUvIS0Xc8N
         3hJ2RVDMDHtBR67pBuI7TMvShOSzqTViLxI2F7LbjGSzs+rctjvSb6UegdNB34cVVAF/
         SUIqnku2xMDSj+s58iJZOXDQSoE/OWnCsHL0sDcTshnUupX1P0YqJ6zK7UYm7Dr8eHYP
         xptpf5/thfGXSy4+Pd9lUce5KQ1bRg0GKNzY8C5q1VoTXz3CyaeqetfN0ohA9f+HHabA
         HJHth5VXySsLH9pzpCV4g2cKZOhbjlQSwQb7s3PPA+1z0Skq5s94T89cLLRT9S+fEd/n
         qGIA==
X-Gm-Message-State: ANoB5pm5zyiwE8LghfEr3TAiLyTUQoEFVL1+zQvckmQo6v4SKzqKKZMk
        Bb2SkXBKW0ZUj6PnInIBOagaK/EVj/QzBw==
X-Google-Smtp-Source: AA0mqf74xy5zzCPkhfKsu8yk5H8M6NX2NwxmI1wq416bDYujVpUPBbKbSm4WAOvoHdM/PeGp3gUU1g==
X-Received: by 2002:a63:2117:0:b0:474:f7bd:9462 with SMTP id h23-20020a632117000000b00474f7bd9462mr5417655pgh.189.1668756660244;
        Thu, 17 Nov 2022 23:31:00 -0800 (PST)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::2c6b])
        by smtp.googlemail.com with ESMTPSA id f7-20020a625107000000b0056b818142a2sm2424325pfb.109.2022.11.17.23.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:30:59 -0800 (PST)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, naoya.horiguchi@nec.com, tytso@mit.edu,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v3 1/4] ext4: Convert move_extent_per_page() to use folios
Date:   Thu, 17 Nov 2022 23:30:52 -0800
Message-Id: <20221118073055.55694-2-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118073055.55694-1-vishal.moola@gmail.com>
References: <20221118073055.55694-1-vishal.moola@gmail.com>
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

Converts move_extent_per_page() to use folios. This change removes
5 calls to compound_head() and is in preparation for the removal of
the try_to_release_page() wrapper.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/ext4/move_extent.c | 52 ++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 044e34cd835c..8dbb87edf24c 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -253,6 +253,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 {
 	struct inode *orig_inode = file_inode(o_filp);
 	struct page *pagep[2] = {NULL, NULL};
+	struct folio *folio[2] = {NULL, NULL};
 	handle_t *handle;
 	ext4_lblk_t orig_blk_offset, donor_blk_offset;
 	unsigned long blocksize = orig_inode->i_sb->s_blocksize;
@@ -313,6 +314,13 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	 * hold page's lock, if it is still the case data copy is not
 	 * necessary, just swap data blocks between orig and donor.
 	 */
+	folio[0] = page_folio(pagep[0]);
+	folio[1] = page_folio(pagep[1]);
+
+	VM_BUG_ON_FOLIO(folio_test_large(folio[0]), folio[0]);
+	VM_BUG_ON_FOLIO(folio_test_large(folio[1]), folio[1]);
+	VM_BUG_ON_FOLIO(folio_nr_pages(folio[0]) != folio_nr_pages(folio[1]), folio[1]);
+
 	if (unwritten) {
 		ext4_double_down_write_data_sem(orig_inode, donor_inode);
 		/* If any of extents in range became initialized we have to
@@ -331,10 +339,10 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 			ext4_double_up_write_data_sem(orig_inode, donor_inode);
 			goto data_copy;
 		}
-		if ((page_has_private(pagep[0]) &&
-		     !try_to_release_page(pagep[0], 0)) ||
-		    (page_has_private(pagep[1]) &&
-		     !try_to_release_page(pagep[1], 0))) {
+		if ((folio_has_private(folio[0]) &&
+		     !filemap_release_folio(folio[0], 0)) ||
+		    (folio_has_private(folio[1]) &&
+		     !filemap_release_folio(folio[1], 0))) {
 			*err = -EBUSY;
 			goto drop_data_sem;
 		}
@@ -344,19 +352,21 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 						   block_len_in_page, 1, err);
 	drop_data_sem:
 		ext4_double_up_write_data_sem(orig_inode, donor_inode);
-		goto unlock_pages;
+		goto unlock_folios;
 	}
 data_copy:
-	*err = mext_page_mkuptodate(pagep[0], from, from + replaced_size);
+	*err = mext_page_mkuptodate(&folio[0]->page, from, from + replaced_size);
 	if (*err)
-		goto unlock_pages;
+		goto unlock_folios;
 
 	/* At this point all buffers in range are uptodate, old mapping layout
 	 * is no longer required, try to drop it now. */
-	if ((page_has_private(pagep[0]) && !try_to_release_page(pagep[0], 0)) ||
-	    (page_has_private(pagep[1]) && !try_to_release_page(pagep[1], 0))) {
+	if ((folio_has_private(folio[0]) &&
+		!filemap_release_folio(folio[0], 0)) ||
+	    (folio_has_private(folio[1]) &&
+		!filemap_release_folio(folio[1], 0))) {
 		*err = -EBUSY;
-		goto unlock_pages;
+		goto unlock_folios;
 	}
 	ext4_double_down_write_data_sem(orig_inode, donor_inode);
 	replaced_count = ext4_swap_extents(handle, orig_inode, donor_inode,
@@ -369,13 +379,13 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 			replaced_size =
 				block_len_in_page << orig_inode->i_blkbits;
 		} else
-			goto unlock_pages;
+			goto unlock_folios;
 	}
 	/* Perform all necessary steps similar write_begin()/write_end()
 	 * but keeping in mind that i_size will not change */
-	if (!page_has_buffers(pagep[0]))
-		create_empty_buffers(pagep[0], 1 << orig_inode->i_blkbits, 0);
-	bh = page_buffers(pagep[0]);
+	if (!folio_buffers(folio[0]))
+		create_empty_buffers(&folio[0]->page, 1 << orig_inode->i_blkbits, 0);
+	bh = folio_buffers(folio[0]);
 	for (i = 0; i < data_offset_in_page; i++)
 		bh = bh->b_this_page;
 	for (i = 0; i < block_len_in_page; i++) {
@@ -385,7 +395,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 		bh = bh->b_this_page;
 	}
 	if (!*err)
-		*err = block_commit_write(pagep[0], from, from + replaced_size);
+		*err = block_commit_write(&folio[0]->page, from, from + replaced_size);
 
 	if (unlikely(*err < 0))
 		goto repair_branches;
@@ -395,11 +405,11 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	*err = ext4_jbd2_inode_add_write(handle, orig_inode,
 			(loff_t)orig_page_offset << PAGE_SHIFT, replaced_size);
 
-unlock_pages:
-	unlock_page(pagep[0]);
-	put_page(pagep[0]);
-	unlock_page(pagep[1]);
-	put_page(pagep[1]);
+unlock_folios:
+	folio_unlock(folio[0]);
+	folio_put(folio[0]);
+	folio_unlock(folio[1]);
+	folio_put(folio[1]);
 stop_journal:
 	ext4_journal_stop(handle);
 	if (*err == -ENOSPC &&
@@ -430,7 +440,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 		*err = -EIO;
 	}
 	replaced_count = 0;
-	goto unlock_pages;
+	goto unlock_folios;
 }
 
 /**
-- 
2.38.1


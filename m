Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991FF596195
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Aug 2022 19:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbiHPRxz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 13:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbiHPRxs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 13:53:48 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1F763F22;
        Tue, 16 Aug 2022 10:53:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo295869pjd.3;
        Tue, 16 Aug 2022 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ktZvpNBWMB4uHfnE+rUfz2bXCBfYO0lBC7J3R+2mvIE=;
        b=Y8K6b0s6QKd7PDmeOTTWB0yaZC7vPIgwGzzFCr33S2koD2Hntvrnq7u4FuXXo/HcZq
         zOJXP7WABOm0/F8JoOxu3w5O28BiUfityQCQTOu48talUjvZ2uzLwzaLYlBZqfgCpuXb
         W48GTG76KuSrbXXSXAfZbviUi/yGPkLG2XT/lxnE4MpmaQzUgrUZiCPeXJwZntfFt/oL
         mkCmUofDKpauaS6XjX85u7K/o4bgJ0p8jxy1t4ohenGfwj881gRdEIXCjZYSV/zNX9J8
         43ndegoWjsacmVhWmeqxVCmQ7sY6A0TCms37AMmiyzer/lp6Tv/Shc9FvTA28/UL5C9w
         dm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ktZvpNBWMB4uHfnE+rUfz2bXCBfYO0lBC7J3R+2mvIE=;
        b=NwhvWkYiIMnShlMAkqGhBNpnsc26ym7WlPfzyD05IyLBrP8RiYip+uZ/EGcNpuAlIY
         1VYvg1p5S21EEwvr+ziSsMoAM+6wd4aAc7OOmlUnU7NZl7/gqh6mSzHaeePp7PbZ/Pv0
         Pq8BtADEURefeNk2nAxUtX+Cwc6+NTtyu3EN1CicEfJ0VfAWwo09kcWdU16K2haQFhZg
         ittBYDcJ+XwIIh2nCWXCbtMRqlYzNzxFRFV4VviVf1Y0K8IYVr0MuPkqhcLQ0DYVQckt
         88mgpuHvjTePE4SFTstP1GC0i/kRD2rUBfzK8S/Hw7kdN/OBpZTt/cRP6IB7FnYTmR8i
         nhLg==
X-Gm-Message-State: ACgBeo3w2+E1Ij8BOSfS3VhTInIFJb5tZkuGK0ndE8kSxP/VjZwFginu
        qwhu3lPJH8hPT9ejG1gaoRvVvppisZ9g9d5V
X-Google-Smtp-Source: AA6agR7JEo87hJmoTxC0nH2KSt1ALXhRO8ILO4fFMpA1/D1/pB03kDOtTk9YUU7NeUcbDA1g4yVvyQ==
X-Received: by 2002:a17:903:1209:b0:16b:81f6:e952 with SMTP id l9-20020a170903120900b0016b81f6e952mr23805936plh.48.1660672412339;
        Tue, 16 Aug 2022 10:53:32 -0700 (PDT)
Received: from vmfolio.. (c-73-189-111-8.hsd1.ca.comcast.net. [73.189.111.8])
        by smtp.googlemail.com with ESMTPSA id mi4-20020a17090b4b4400b001f52fa1704csm3379963pjb.3.2022.08.16.10.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 10:53:31 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [PATCH v2 5/7] nilfs2: Convert nilfs_find_uncommited_extent() to use filemap_get_folios_contig()
Date:   Tue, 16 Aug 2022 10:52:44 -0700
Message-Id: <20220816175246.42401-6-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220816175246.42401-1-vishal.moola@gmail.com>
References: <20220816175246.42401-1-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Converted function to use folios throughout. This is in preparation for
the removal of find_get_pages_contig(). Now also supports large folios.

Also cleaned up an unnecessary if statement - pvec.pages[0]->index > index
will always evaluate to false, and filemap_get_folios_contig() returns 0 if
there is no folio found at index.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---

v2:
  - Fixed a warning regarding a now unused label "out"
  - Reported-by: kernel test robot <lkp@intel.com>
---
 fs/nilfs2/page.c | 39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 3267e96c256c..14629e03d0da 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -480,13 +480,13 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 					    sector_t start_blk,
 					    sector_t *blkoff)
 {
-	unsigned int i;
+	unsigned int i, nr;
 	pgoff_t index;
 	unsigned int nblocks_in_page;
 	unsigned long length = 0;
 	sector_t b;
-	struct pagevec pvec;
-	struct page *page;
+	struct folio_batch fbatch;
+	struct folio *folio;
 
 	if (inode->i_mapping->nrpages == 0)
 		return 0;
@@ -494,27 +494,24 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 	index = start_blk >> (PAGE_SHIFT - inode->i_blkbits);
 	nblocks_in_page = 1U << (PAGE_SHIFT - inode->i_blkbits);
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
 repeat:
-	pvec.nr = find_get_pages_contig(inode->i_mapping, index, PAGEVEC_SIZE,
-					pvec.pages);
-	if (pvec.nr == 0)
+	nr = filemap_get_folios_contig(inode->i_mapping, &index, ULONG_MAX,
+			&fbatch);
+	if (nr == 0)
 		return length;
 
-	if (length > 0 && pvec.pages[0]->index > index)
-		goto out;
-
-	b = pvec.pages[0]->index << (PAGE_SHIFT - inode->i_blkbits);
+	b = fbatch.folios[0]->index << (PAGE_SHIFT - inode->i_blkbits);
 	i = 0;
 	do {
-		page = pvec.pages[i];
+		folio = fbatch.folios[i];
 
-		lock_page(page);
-		if (page_has_buffers(page)) {
+		folio_lock(folio);
+		if (folio_buffers(folio)) {
 			struct buffer_head *bh, *head;
 
-			bh = head = page_buffers(page);
+			bh = head = folio_buffers(folio);
 			do {
 				if (b < start_blk)
 					continue;
@@ -532,18 +529,16 @@ unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
 
 			b += nblocks_in_page;
 		}
-		unlock_page(page);
+		folio_unlock(folio);
 
-	} while (++i < pagevec_count(&pvec));
+	} while (++i < nr);
 
-	index = page->index + 1;
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	cond_resched();
 	goto repeat;
 
 out_locked:
-	unlock_page(page);
-out:
-	pagevec_release(&pvec);
+	folio_unlock(folio);
+	folio_batch_release(&fbatch);
 	return length;
 }
-- 
2.36.1


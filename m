Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53AE6167C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 17:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiKBQNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 12:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbiKBQME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:12:04 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6E82CDCD;
        Wed,  2 Nov 2022 09:11:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h14so16689559pjv.4;
        Wed, 02 Nov 2022 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6ro/4uwbCPgnPQoXYfWSXb0BSYdAvQsNHB7i1qmjGk=;
        b=q3y86Mqj0DeZyISqm/NEreuCkcVJdcqf1I2PppLIxLtCQkHnGzMeBPNGgV0nSBjZzo
         fx/DTafrePXLwXBlWJcD2VH7Lg0Z1T54Sz66MqXxFSFX63QD/buYFZb6ZlrEHmgkrvOG
         6wPPcdqdE3EZlG/p2W7Gyv6nIhwzWc745dpabg6QvsjYd3Xg4Tk5BqwdQJX7kCgd5AvR
         dfK69VeuJCj+LO3ABeT4hrA0BZJDXiABX+2axHpLqvGhX3vsUKYQ7PHDjkGX3xzT+y95
         L/VuMNGLM9kCQA0VEnLWnHg1PrMv390+X0DAi/s+IP/duC+XZLqgE8qsknuv46zXcBvg
         WCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M6ro/4uwbCPgnPQoXYfWSXb0BSYdAvQsNHB7i1qmjGk=;
        b=aRsQtJlX4l1WRXl1jOE4P83gVlgD+slY1nRG72K4x9/3bI4mv9Iid8f+13rnVasi8G
         eiV2v0uPccODH/+qeAUftqiPMW8WikQspETzYborkUUwXFlOeuGUjypiB6uN8MDAroja
         HFMFg3O6d+rqOUulzZ5Pi6vhiUnuwORpyxT9khXmgpahh2alaZlxjDk2j40D3GjCeCpM
         62PnvA29wbT9HjVTi/QQacdm5RwEZxY6B1+B/7d7TIWBUBKnpFaU/XCvdguJXW0++UPI
         ArIvLIYBvyfaBvWeUDKqsTMjIXZ+f7NWjQoiFDveS5hYkPO2uekrVPcODXiF144q9+8U
         1OGA==
X-Gm-Message-State: ACrzQf2vLcsjzQ2HtpJsSNPuOhDUVO+dn0pQQFLSBQ5po0IaUaBvF3YF
        z5/OECT2yzZWkJTE/0l09ySnGIQwehvwFA==
X-Google-Smtp-Source: AMsMyM5+yJKPsTCW+zHgZjbHbMaNzVKcqfalsqvaAr3+srXOWHJW6H/w5W+YIAenXiG0v4QRbNBUvg==
X-Received: by 2002:a17:902:b18d:b0:186:9bb5:a92 with SMTP id s13-20020a170902b18d00b001869bb50a92mr25445634plr.11.1667405494098;
        Wed, 02 Nov 2022 09:11:34 -0700 (PDT)
Received: from fedora.hsd1.ca.comcast.net ([2601:644:8002:1c20::8080])
        by smtp.googlemail.com with ESMTPSA id ms4-20020a17090b234400b00210c84b8ae5sm1632101pjb.35.2022.11.02.09.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:11:33 -0700 (PDT)
From:   "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>
Subject: [PATCH v4 18/23] nilfs2: Convert nilfs_lookup_dirty_data_buffers() to use filemap_get_folios_tag()
Date:   Wed,  2 Nov 2022 09:10:26 -0700
Message-Id: <20221102161031.5820-19-vishal.moola@gmail.com>
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

Convert function to use folios throughout. This is in preparation for
the removal of find_get_pages_range_tag(). This change removes 4 calls
to compound_head().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/segment.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index b4cebad21b48..2183e1698f8e 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -680,7 +680,7 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 					      loff_t start, loff_t end)
 {
 	struct address_space *mapping = inode->i_mapping;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	pgoff_t index = 0, last = ULONG_MAX;
 	size_t ndirties = 0;
 	int i;
@@ -694,23 +694,26 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 		index = start >> PAGE_SHIFT;
 		last = end >> PAGE_SHIFT;
 	}
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
  repeat:
 	if (unlikely(index > last) ||
-	    !pagevec_lookup_range_tag(&pvec, mapping, &index, last,
-				PAGECACHE_TAG_DIRTY))
+	      !filemap_get_folios_tag(mapping, &index, last,
+		      PAGECACHE_TAG_DIRTY, &fbatch))
 		return ndirties;
 
-	for (i = 0; i < pagevec_count(&pvec); i++) {
+	for (i = 0; i < folio_batch_count(&fbatch); i++) {
 		struct buffer_head *bh, *head;
-		struct page *page = pvec.pages[i];
+		struct folio *folio = fbatch.folios[i];
 
-		lock_page(page);
-		if (!page_has_buffers(page))
-			create_empty_buffers(page, i_blocksize(inode), 0);
-		unlock_page(page);
+		folio_lock(folio);
+		head = folio_buffers(folio);
+		if (!head) {
+			create_empty_buffers(&folio->page, i_blocksize(inode), 0);
+			head = folio_buffers(folio);
+		}
+		folio_unlock(folio);
 
-		bh = head = page_buffers(page);
+		bh = head;
 		do {
 			if (!buffer_dirty(bh) || buffer_async_write(bh))
 				continue;
@@ -718,13 +721,13 @@ static size_t nilfs_lookup_dirty_data_buffers(struct inode *inode,
 			list_add_tail(&bh->b_assoc_buffers, listp);
 			ndirties++;
 			if (unlikely(ndirties >= nlimit)) {
-				pagevec_release(&pvec);
+				folio_batch_release(&fbatch);
 				cond_resched();
 				return ndirties;
 			}
 		} while (bh = bh->b_this_page, bh != head);
 	}
-	pagevec_release(&pvec);
+	folio_batch_release(&fbatch);
 	cond_resched();
 	goto repeat;
 }
-- 
2.38.1


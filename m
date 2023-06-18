Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911D473489F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jun 2023 23:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjFRVgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 17:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjFRVgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:36:08 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA42E44;
        Sun, 18 Jun 2023 14:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687123984; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=nWSvTOOnO8ugSK6+/H307s3L5N4uQG5KOysBX2IgampHzUt/e1M7vWIgYdM3yVn8L6
    mF36Wi9H8fUj11MVYKe9B3JL/hDoWwgnzOa3dvcISkQQDSb2WEO0SpuCxbpl9ulC48VA
    6OTnqS/TmHNy3oQ4R2DtbjIhU7Nohg+aSNxXIW/hxT2ZMWnTYP5q+8lRRwhkjZdu7w8l
    M4LdL+lzkB6WNMIUSREXZKPuCvrGYQZzoo743PqH5qMBYNux3lLCwnXbWxglyfCgKp9d
    JjMRY3fdgtxXhCanLp8cu/y+YDIQJYd/ZKZOPMXDY0KPjjpxCPe64ikJHtlBMzm9mmqZ
    c3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687123984;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FiS5DxAChRRX4k3Ho2cvADBUbEW2Co/dwGRsyJUkQbY=;
    b=F1UqAkcdL/glDaJ1655WMMKUY52RDJgVOqcvh+cD7JNw7DLTJekAmQP9YVLy8YWOBF
    guSVfoSeB8n1uU731qyZ+2YC7+WmUd1aoBptm75em2DG7A0I9YV9NJuGRMXnCNnXU294
    CmwqbHfbRSHFnlCjWqWsUA4Re7ELTkbddNyG3e3F5zHhnCOKvViEuF728C4h3kfIP49z
    ceyU8ATRHqXtto6Jx7yx/Q4/a+0El45664DLB5wW80ELr1N0KPFG7lCoJLDTbf+1GuWJ
    bW5Tks8uPB7H4X+tPVl3XNjIVDIDbVkrwfOqq5JPKciLf00llz8zYQ8HIq0h2A0FypH/
    mlmA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687123984;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FiS5DxAChRRX4k3Ho2cvADBUbEW2Co/dwGRsyJUkQbY=;
    b=PRWXw8CAKoV3Zc0FbJ0k+sd2UEx2mwQS5sPlJ1IMvyUGGrk2/AECJxgw8T9H60V+iT
    kf2EVFWyYPiH5njS6Yr90PInkPm3bbiSsQOqbEO3o/gQzIMpb4DzqVJRw1SE5b/I2uAx
    GSla28BN0VEmJRltrEOtfGQvTP6/b2mojhwgA0OmUOhsbDzMpCc4A+/k5f6NOjxIhOLF
    Yi7snDkMa2CTQrMtS6p8Q0vIAV7Bp+2QT1be6BQJY8RJX9ie+m1vSjmzrnqH2QF5a1vo
    KuOIRvcXk1STDH86GatVeyNvviTymJ46nAkmGMH1fwNUrLcbDWtT2GXSU5bV+yN964xt
    5s8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687123984;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=FiS5DxAChRRX4k3Ho2cvADBUbEW2Co/dwGRsyJUkQbY=;
    b=t62gJy/K2AlLeFVlbN8g/Eh1wVR4obWhlmtyT/E4D34lZw5GOWaD5/PPUg52sfahSL
    IphcxhR520CJ6vjmIdAw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1EQ33bneoxgmq5ARfEwes1hW/CxwfjqKzP/cKnUXGNs35zouFQhI="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5ILX2AHJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 18 Jun 2023 23:33:02 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: [PATCH v1 1/5] fs/buffer: clean up block_commit_write
Date:   Sun, 18 Jun 2023 23:32:46 +0200
Message-Id: <20230618213250.694110-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230618213250.694110-1-beanhuo@iokpp.de>
References: <20230618213250.694110-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Originally inode is used to get blksize, after commit 45bce8f3e343
("fs/buffer.c: make block-size be per-page and protected by the page lock"),
__block_commit_write no longer uses this parameter inode, this patch is to
remove inode and clean up block_commit_write.

Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 fs/buffer.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index a7fc561758b1..b88bb7ec38be 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2116,8 +2116,7 @@ int __block_write_begin(struct page *page, loff_t pos, unsigned len,
 }
 EXPORT_SYMBOL(__block_write_begin);
 
-static int __block_commit_write(struct inode *inode, struct page *page,
-		unsigned from, unsigned to)
+int block_commit_write(struct page *page, unsigned int from, unsigned int to)
 {
 	unsigned block_start, block_end;
 	int partial = 0;
@@ -2154,6 +2153,7 @@ static int __block_commit_write(struct inode *inode, struct page *page,
 		SetPageUptodate(page);
 	return 0;
 }
+EXPORT_SYMBOL(block_commit_write);
 
 /*
  * block_write_begin takes care of the basic task of block allocation and
@@ -2188,7 +2188,6 @@ int block_write_end(struct file *file, struct address_space *mapping,
 			loff_t pos, unsigned len, unsigned copied,
 			struct page *page, void *fsdata)
 {
-	struct inode *inode = mapping->host;
 	unsigned start;
 
 	start = pos & (PAGE_SIZE - 1);
@@ -2214,7 +2213,7 @@ int block_write_end(struct file *file, struct address_space *mapping,
 	flush_dcache_page(page);
 
 	/* This could be a short (even 0-length) commit */
-	__block_commit_write(inode, page, start, start+copied);
+	block_commit_write(page, start, start+copied);
 
 	return copied;
 }
@@ -2535,14 +2534,6 @@ int cont_write_begin(struct file *file, struct address_space *mapping,
 }
 EXPORT_SYMBOL(cont_write_begin);
 
-int block_commit_write(struct page *page, unsigned from, unsigned to)
-{
-	struct inode *inode = page->mapping->host;
-	__block_commit_write(inode,page,from,to);
-	return 0;
-}
-EXPORT_SYMBOL(block_commit_write);
-
 /*
  * block_page_mkwrite() is not allowed to change the file size as it gets
  * called from a page fault handler when a page is first dirtied. Hence we must
-- 
2.34.1


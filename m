Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE8E735EF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 23:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjFSVVn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjFSVVm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:21:42 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D334D10E;
        Mon, 19 Jun 2023 14:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687209521; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LFVXYnZJP3AC4ueU5OSFywkBghrWBMJoaPp1Nr786WBT4H25sdRZekQJto2nthGHHl
    1omr2W+S6zVlnSVtcyAW/YdVI9zlNiyjATrEYkcU71j6CtA346ESRbk3UwBGZjHTUo/a
    JiCy1BwEWoief1uGdfq0aJGOJR/1llf87lIJtGUFoNVkEj/0qxY8x4yYZ/ZwKxa2z/89
    vJyUkfkTLHe+Yw+4c6ka4IzxyuTPz68FbAytIlF9/75kd23AQIpmnMIZkt2pQ4Pl1ZUV
    mUWumFY6Fp4wNkrzM/Sdfod2a1ui+wZkE7jsZVtrhZkUvIQkQyCd4q4Cx+qPd0jZJNK+
    eMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687209521;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NGBMcxhHLHH11bvOk7/wD+Xn9RcgMORp7BCVCyG5YE0=;
    b=AmoXSgTVG1F6LCKvW6LHTtlBOukQR3A7nuDxN8+LBG7M15CyW1KdJuR42QHlzHEqJx
    hXvHMHoYFOEsxZ/bZJwDcnxhl06tuw8EXsmoShxmel3WkGFQjzbeMpdGeeeVHTdM2RZ1
    rrLB1+BQ8gVcW4CUd8f9ctiUTuDCfQsRgWabhYkfge5JLkttFrQXxtEd+tXWVtGbSzo5
    qDd5sZAD1xBsZEdIFb4x5VyJEs8msvDVbzNTkDWFQomAx19x4CcI2x/rA8ZDTh8ZS6YL
    RuxWZeeT/2J8qRAa/JvuPLO7ls1FKeb39iIi0p4SARtsnVoIcGUpgFjhiFF+z6pBENyB
    eL0w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687209521;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NGBMcxhHLHH11bvOk7/wD+Xn9RcgMORp7BCVCyG5YE0=;
    b=fjfTtql55O5eGJWVBFn9vZgvbB6aFpEsu1u1CJBfw2sCVF2CQyHS3QTOcEIoaUef/m
    DMmTxrRdiKmdgn6f3t8nMGFmUoLZhaKk429s3JuidosIF4uHOc6bQCBd+BkuHbJQZBUJ
    6oW7TZEbzK+myWi7R+bRHSYM5fUxTQsFFc9Hz0ozKdCv7zAtUv4caiswcOCNFAYxUC5B
    BTBfEMTo3gx/EbJamvuYWrMR1gyXSO2UsS8Ack7H3oYCUi7ZA9bfC394OoesAXpaOUl5
    KyRJozJ1VZLUcTjInUbe/Xk+g/o3J9w2RYq6B4tpd8PoiL23dVlHBwCaEX6Vq5X4b227
    4tvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687209521;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=NGBMcxhHLHH11bvOk7/wD+Xn9RcgMORp7BCVCyG5YE0=;
    b=jHNcYo6tA2Qyd2g4wy+0S9wCS4sVfUGddQdOOD7Ivi00xskuQrYie0D6cGE0F9UYt0
    edZbZL70/elm5QDN0fBg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1EQ33bneoxgmq7ABeEwyjghc0WGLJ+05px4XK4px0+bSzE8qij5Q="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5JLIfDvg
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 19 Jun 2023 23:18:41 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: [PATCH v2 1/5] fs/buffer: clean up block_commit_write
Date:   Mon, 19 Jun 2023 23:18:23 +0200
Message-Id: <20230619211827.707054-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619211827.707054-1-beanhuo@iokpp.de>
References: <20230619211827.707054-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
Reviewed-by: Jan Kara <jack@suse.cz>
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


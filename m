Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33AE73D73E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 07:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjFZFmP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 01:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjFZFmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:42:13 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE78D133;
        Sun, 25 Jun 2023 22:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687758123; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BLsPKXmVGveNz1cWfRhdc45UhP+767VVGi141W8RVA4ZEZZP2JgAB7tkOyloadHPea
    0m8yVuCv2OM2Ww/pKkTRGeq5+h6R+6PtU9AlyZeLz7CSeofmO/tplJEPdE5jQFqK8zPr
    A2xHXfLEvKepgABVVft3avmi0JZwzM1dTSnXFqI0JgiOft/xbF5P5+U709b9gNebW8X4
    6Q2RtPXYx4ntxvsqHajtQBtDOrvb6IU//Ep5CLUlO85BnH1IeTqr/Eki+cElugzSE6Lj
    kvb7wqHdXV60ZjL5zS/x8J4jtFqaDk22YveWArqxNOIgQs92yJbmF6aYgg7XuqFbnDMs
    Tlkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687758123;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mhoN52NrOJrJXRtOmObH8v06ZrNecZha/sBxCLu1zqg=;
    b=ZCsWMe2TXHMNkB9FaqP7W1Xr9DE2eQO0B3JLwm7wWM+OpaeyxV3s8fnwOVtU6U2znq
    sOZ97vbok1ZltiWjDNWwOwvX6gL7W+MS+oc6jmXNRnrh3f9aPeTL7sd3Dgi9VBlS8pGI
    mjBfWJTzszyhPSzT4nnQNtq73xv77mIzop6oAmjcUCO48LxQiSs4UU4Uw4M6d08ocKSv
    mjpA+gOcMbFedY+Z3FRwfbI2/NMyo3LtKRmlLN6N9FsbnLvQUTaIchVUSKe5uZ7+6Nh9
    6qaCupaSCFzFOajM87SnnUOejjWtLcFw52IflFKsJMDC4k5Fj70Vjl3QRn9V+hWTvf08
    /BMw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687758123;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mhoN52NrOJrJXRtOmObH8v06ZrNecZha/sBxCLu1zqg=;
    b=dn38vfl83FJAEJOE40CVxkpykk4kWCRRj+jGqEk4ue0L6B+wq4eRyadOJMt/7fuYgE
    Ebr4Z95t5+LdRzbdf2OThbZFWcPfDh5bbrdsK+uPwPEjY8zMuU2VvNTgMwXrCxyJAkOP
    dhZfYU+D5eKk07vPzSiJzrPf/sGSSj+6gL6c51Qx/mGXnhUm3EKn+gy2WYdtX37Pvnmo
    Hd6Od+VbbmxgcG3KQooJa8VG/k/OFxd7rCDSCLDysv3EeTU/QNOcoz+18yDb6jThitLc
    vX+8ASVpvg+5uzTA4/zW+Oxg6CzKjhuaNW7GSfznKVoyEPIEqoVk1bWIy6LynEphYsVb
    LSFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687758123;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=mhoN52NrOJrJXRtOmObH8v06ZrNecZha/sBxCLu1zqg=;
    b=7QCQPusEOW3XxIMInpXpKbXXPNiNqkdAG/j4EsA3IiOrCjdXQit8tl8J7yBwJznqtG
    TXhSJI8/Zw5kTNmmRyDA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1RrW5o+P9bSFaHg+gZu+uCjL2b+VQTRnVQrIOQ=="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5Q5g2Vv9
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 26 Jun 2023 07:42:02 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        willy@infradead.org, hch@infradead.org
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com, Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v3 1/2] fs/buffer: clean up block_commit_write
Date:   Mon, 26 Jun 2023 07:41:52 +0200
Message-Id: <20230626054153.839672-2-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626054153.839672-1-beanhuo@iokpp.de>
References: <20230626054153.839672-1-beanhuo@iokpp.de>
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

From: Bean Huo <beanhuo@iokpp.de>

Originally inode is used to get blksize, after commit 45bce8f3e343
("fs/buffer.c: make block-size be per-page and protected by the page lock"),
__block_commit_write no longer uses this parameter inode.

Signed-off-by: Bean Huo <beanhuo@iokpp.de>
---
 fs/buffer.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index bd091329026c..50821dfb02f7 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2180,8 +2180,7 @@ int __block_write_begin(struct page *page, loff_t pos, unsigned len,
 }
 EXPORT_SYMBOL(__block_write_begin);
 
-static int __block_commit_write(struct inode *inode, struct folio *folio,
-		size_t from, size_t to)
+static int __block_commit_write(struct folio *folio, size_t from, size_t to)
 {
 	size_t block_start, block_end;
 	bool partial = false;
@@ -2277,7 +2276,7 @@ int block_write_end(struct file *file, struct address_space *mapping,
 	flush_dcache_folio(folio);
 
 	/* This could be a short (even 0-length) commit */
-	__block_commit_write(inode, folio, start, start + copied);
+	__block_commit_write(folio, start, start + copied);
 
 	return copied;
 }
@@ -2601,8 +2600,7 @@ EXPORT_SYMBOL(cont_write_begin);
 int block_commit_write(struct page *page, unsigned from, unsigned to)
 {
 	struct folio *folio = page_folio(page);
-	struct inode *inode = folio->mapping->host;
-	__block_commit_write(inode, folio, from, to);
+	__block_commit_write(folio, from, to);
 	return 0;
 }
 EXPORT_SYMBOL(block_commit_write);
@@ -2650,7 +2648,7 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 
 	ret = __block_write_begin_int(folio, 0, end, get_block, NULL);
 	if (!ret)
-		ret = __block_commit_write(inode, folio, 0, end);
+		ret = __block_commit_write(folio, 0, end);
 
 	if (unlikely(ret < 0))
 		goto out_unlock;
-- 
2.34.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AE673D746
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 07:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjFZFpH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 01:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjFZFpG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 01:45:06 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB67134;
        Sun, 25 Jun 2023 22:45:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687758123; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bnJRzWfzHwjyB7ocNXxbvZ76SzDqFZN/I4n6xQ/j31yApH1TFFzJoqny3ZUswsXekA
    dEfeYFs0XkDl08jamZyv7Q17VemdpiIe7idJ9r7c7kRMDmRDBspOSdwIRW1d/S9LIa9k
    EQDLecC+wWw22gX2nDwWCw++AOgqpDvAzThjbuv9fTEhb7yDkHz7TfFjPPSWJl2Sf6e8
    4cGxoikplIRjy5lQrzuSpSQc0nAV8nk76h+7+s9latytYAd5EJTyU4gz9nP7KtHCsVPl
    VTSo/N38sS2SB5CkLpm5kIlNz4Y3lNey5Fs4QziOjjkiN272YIQumuuPN+B8aU32l0jm
    kTUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687758123;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=A/OYsWzLIZKxnT1gYGuMS7er5Q0yQLzWN1fJj1HH19U=;
    b=RIl8OAFYRJ7KsB1WkyllCOnDwVeEU/vor31scEtqwExfEomdiUlgO78z0dilwdLgls
    qo9jMu35Is7LYXO49JsxWy4fK8hYoZEhSH/8oyK7EySOPBqNwz+2ujnLLWDXuIQG8giJ
    6U56Qwf3UPkJutNlkZ13wskz4bcs5JJg31gDTZ4FtH7cDCDnP12fAB8nmMolrC3f2I1n
    CMDsfIIwBBTnWLuzekbvzyYpVSuMwJ+s3Dl50VcXxJI00pdb2puaHqA990yPqE0PpBnQ
    PyH2J1Hu3RoTh/oG/X8DxcvEWChQY/oAqfrvNO1akiRN/QC2BN/LzpRGqiJGG7XPwvEI
    R79Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687758123;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=A/OYsWzLIZKxnT1gYGuMS7er5Q0yQLzWN1fJj1HH19U=;
    b=NfcZcgTIIC8nSgDtlQSSa/VC0elwH/QlqHg71C486VKy72d36LtSjg9h1Jj4rHJnYZ
    QXUVsE30iG4+Qqx/pTlHI8PJdDwWv9S4ylRm2pUujvLRhmKKNlG4kElEbQYvgV+kqBFQ
    0I/MbWxALI2QqKHmgy3uQVeRd9hbyjUke/3P4DY3qAMFa6vBJP0hai0mqEYZP1++YQc8
    YMiWMxbiQZz03BatPwROeGyPG3krTB6pPFHdMpSaYmek8ML9RqxrxNI8991xSrtwwJno
    c5bs6usNL532qxfxnnYxusV3a88v/zAKC7cpTbiM/hoVhE+9nFJJcm2/vvpXcWKJkOrU
    JQKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687758123;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=A/OYsWzLIZKxnT1gYGuMS7er5Q0yQLzWN1fJj1HH19U=;
    b=SF1SPiN2eE0txi4FPUdYG5FT1wVWtyEx21AJODjSRBmvV7KGi6Vt+/ekcbZhmVZLju
    7KjrV69IoWMcH5mtFTBw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1QLj68UeUr1+U1RrW5o+P9bSFaHg+gZu+uCjL2b+VQTRnVQrIOQ=="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5Q5g3VvA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 26 Jun 2023 07:42:03 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        willy@infradead.org, hch@infradead.org
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com, Bean Huo <beanhuo@iokpp.de>
Subject: [PATCH v3 2/2] fs: convert block_commit_write to return void
Date:   Mon, 26 Jun 2023 07:41:53 +0200
Message-Id: <20230626054153.839672-3-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626054153.839672-1-beanhuo@iokpp.de>
References: <20230626054153.839672-1-beanhuo@iokpp.de>
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

From: Bean Huo <beanhuo@iokpp.de>

block_commit_write() always returns 0, this patch changes it to
return void.

Signed-off-by: Bean Huo <beanhuo@iokpp.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/buffer.c                 | 14 ++++++--------
 fs/ext4/move_extent.c       |  7 ++-----
 fs/ocfs2/file.c             |  7 +------
 fs/udf/file.c               |  6 +++---
 include/linux/buffer_head.h |  2 +-
 5 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 50821dfb02f7..1568d0c9942d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2180,7 +2180,7 @@ int __block_write_begin(struct page *page, loff_t pos, unsigned len,
 }
 EXPORT_SYMBOL(__block_write_begin);
 
-static int __block_commit_write(struct folio *folio, size_t from, size_t to)
+static void __block_commit_write(struct folio *folio, size_t from, size_t to)
 {
 	size_t block_start, block_end;
 	bool partial = false;
@@ -2215,7 +2215,6 @@ static int __block_commit_write(struct folio *folio, size_t from, size_t to)
 	 */
 	if (!partial)
 		folio_mark_uptodate(folio);
-	return 0;
 }
 
 /*
@@ -2597,11 +2596,10 @@ int cont_write_begin(struct file *file, struct address_space *mapping,
 }
 EXPORT_SYMBOL(cont_write_begin);
 
-int block_commit_write(struct page *page, unsigned from, unsigned to)
+void block_commit_write(struct page *page, unsigned from, unsigned to)
 {
 	struct folio *folio = page_folio(page);
 	__block_commit_write(folio, from, to);
-	return 0;
 }
 EXPORT_SYMBOL(block_commit_write);
 
@@ -2647,11 +2645,11 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 		end = size - folio_pos(folio);
 
 	ret = __block_write_begin_int(folio, 0, end, get_block, NULL);
-	if (!ret)
-		ret = __block_commit_write(folio, 0, end);
+	if (unlikely(ret))
+		 goto out_unlock;
+
+	__block_commit_write(folio, 0, end);
 
-	if (unlikely(ret < 0))
-		goto out_unlock;
 	folio_mark_dirty(folio);
 	folio_wait_stable(folio);
 	return 0;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index b5af2fc03b2f..f4b4861a74ee 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -392,14 +392,11 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	for (i = 0; i < block_len_in_page; i++) {
 		*err = ext4_get_block(orig_inode, orig_blk_offset + i, bh, 0);
 		if (*err < 0)
-			break;
+			goto repair_branches;
 		bh = bh->b_this_page;
 	}
-	if (!*err)
-		*err = block_commit_write(&folio[0]->page, from, from + replaced_size);
 
-	if (unlikely(*err < 0))
-		goto repair_branches;
+	block_commit_write(&folio[0]->page, from, from + replaced_size);
 
 	/* Even in case of data=writeback it is reasonable to pin
 	 * inode to transaction, to prevent unexpected data loss */
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 91a194596552..9e417cd4fd16 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -808,12 +808,7 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
 
 
 		/* must not update i_size! */
-		ret = block_commit_write(page, block_start + 1,
-					 block_start + 1);
-		if (ret < 0)
-			mlog_errno(ret);
-		else
-			ret = 0;
+		block_commit_write(page, block_start + 1, block_start + 1);
 	}
 
 	/*
diff --git a/fs/udf/file.c b/fs/udf/file.c
index 243840dc83ad..0292d75e60cc 100644
--- a/fs/udf/file.c
+++ b/fs/udf/file.c
@@ -63,13 +63,13 @@ static vm_fault_t udf_page_mkwrite(struct vm_fault *vmf)
 	else
 		end = PAGE_SIZE;
 	err = __block_write_begin(page, 0, end, udf_get_block);
-	if (!err)
-		err = block_commit_write(page, 0, end);
-	if (err < 0) {
+	if (err) {
 		unlock_page(page);
 		ret = block_page_mkwrite_return(err);
 		goto out_unlock;
 	}
+
+	block_commit_write(page, 0, end);
 out_dirty:
 	set_page_dirty(page);
 	wait_for_stable_page(page);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6cb3e9af78c9..a7377877ff4e 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -288,7 +288,7 @@ int cont_write_begin(struct file *, struct address_space *, loff_t,
 			unsigned, struct page **, void **,
 			get_block_t *, loff_t *);
 int generic_cont_expand_simple(struct inode *inode, loff_t size);
-int block_commit_write(struct page *page, unsigned from, unsigned to);
+void block_commit_write(struct page *page, unsigned int from, unsigned int to);
 int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 				get_block_t get_block);
 /* Convert errno to return value from ->page_mkwrite() call */
-- 
2.34.1


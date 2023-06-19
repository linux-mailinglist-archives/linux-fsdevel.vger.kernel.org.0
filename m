Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7DC735EEB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 23:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjFSVTa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 17:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjFSVTV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:19:21 -0400
Received: from mo4-p03-ob.smtp.rzone.de (mo4-p03-ob.smtp.rzone.de [85.215.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309E61701;
        Mon, 19 Jun 2023 14:19:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687209526; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=m14ydInAO32RSNeBAEUmo5VtS9IdNsIE1lEAXPUqN3jpWhmRIQgK47Y/rbAT3wMzzQ
    zFtEMz7KVxS3NSfPnKVhU8xUFPgcXLrgGIWN2Mu6997FuL8lqVsKbxqkA5fE3gv3MDvZ
    JWD0zt4m7taKUiiTj/MHW/kGwq6EOfjUlaUH7tbWkr4Af8BIy7xIimnnWnFOzHZDScLt
    3eQQywEXNYQ+IC988XlH/CzjqwE7RWPjci5ZMT3eKpmQ4AYgRzTbVvGQ14Z3slHIt375
    Yy3e8mWPjZSUhmyrItczO8JH8++rOTMjFybtj/1ToabmROD6JBE3b3hIRI6t4sFE0TtU
    aoQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687209526;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4VoCJCkUkGyuMs9ktPD9dGvwPKJ6aIyifN3L5LWABx8=;
    b=JvbswYT1Nxu/3JVFow4AGCMKUY/2XH05O3KHS/AN8d5uMp/6ohrS1PkKNW1d/qNfgx
    ehqaHoKJtUwJelBXbn8r72WycTsEtzleB3hRsAdSOiMxKKKUyyzM1b0QCThREEAj4AVl
    q5Zch4h3R7Uu5hmKzx0c67sYBQ7RCDzOg2GeGoQXN0rqERPliWUQ7yvIll/pNLS86+kk
    ycpoPF2xhfADP3mWfL3TWsU3V7nm1cIVk4/xiq4xy4rgcMqi+C1ZDffmzSuCPuUy2QbM
    /SnVisX5HcQFQW9BMmEdDPGdYuiBwFgNDv/UpoVl9iqq0weeChmJvaYg58IuIMlqC5Qo
    pzxA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687209526;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4VoCJCkUkGyuMs9ktPD9dGvwPKJ6aIyifN3L5LWABx8=;
    b=GQuLI20iuo/3e3+FcTWN+gW33eL6iyjV5edlrwBquBLU1yKxMk3gJO7CkF6DC8eUq6
    gHTqB7hfa+ATxhvaPSMfQF2q1ieLcDoBiT59Fsr1IPCYkHAsKStHGpL5+2bmwDdUy5o6
    wWcaHwSe4L7bsjHTc+Z2xsLCyrvZnNGEpGXihjQrDj+pGs7x89Ywj1dSAEhZdOzDw30X
    xBQqWzsXqNbS7+ugJ5EL0MiFGcZuz8DhcDB1mRCCRnQFkCb9JzLKyz9t7rn+bd+LO1cC
    bPTxr2ni/HsxkQCdCwk6SUJrBKWPg4dVvZ6emoZsJFm5HNNbg2fpUBWqLP/n/eSdf1Eq
    JkWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687209526;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=4VoCJCkUkGyuMs9ktPD9dGvwPKJ6aIyifN3L5LWABx8=;
    b=Fi7GsifBZj+G9wnlO1nTmf1xXDrGLocv0iS6G3hKSGfd89rdXROo90SMzMsF39I5um
    2ld4NTWy8oTessFRFiCw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1EQ33bneoxgmq7ABeEwyjghc0WGLJ+05px4XK4px0+bSzE8qij5Q="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5JLIjDvk
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 19 Jun 2023 23:18:45 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: [PATCH v2 5/5] fs/buffer.c: convert block_commit_write to return void
Date:   Mon, 19 Jun 2023 23:18:27 +0200
Message-Id: <20230619211827.707054-6-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619211827.707054-1-beanhuo@iokpp.de>
References: <20230619211827.707054-1-beanhuo@iokpp.de>
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

block_commit_write() always returns 0, this patch changes it to
return void.

Signed-off-by: Bean Huo <beanhuo@micron.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c                 | 11 +++++------
 include/linux/buffer_head.h |  2 +-
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b88bb7ec38be..fa09cf94f771 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2116,7 +2116,7 @@ int __block_write_begin(struct page *page, loff_t pos, unsigned len,
 }
 EXPORT_SYMBOL(__block_write_begin);
 
-int block_commit_write(struct page *page, unsigned int from, unsigned int to)
+void block_commit_write(struct page *page, unsigned int from, unsigned int to)
 {
 	unsigned block_start, block_end;
 	int partial = 0;
@@ -2151,7 +2151,6 @@ int block_commit_write(struct page *page, unsigned int from, unsigned int to)
 	 */
 	if (!partial)
 		SetPageUptodate(page);
-	return 0;
 }
 EXPORT_SYMBOL(block_commit_write);
 
@@ -2577,11 +2576,11 @@ int block_page_mkwrite(struct vm_area_struct *vma, struct vm_fault *vmf,
 		end = PAGE_SIZE;
 
 	ret = __block_write_begin(page, 0, end, get_block);
-	if (!ret)
-		ret = block_commit_write(page, 0, end);
-
-	if (unlikely(ret < 0))
+	if (unlikely(ret))
 		goto out_unlock;
+
+	block_commit_write(page, 0, end);
+
 	set_page_dirty(page);
 	wait_for_stable_page(page);
 	return 0;
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 1520793c72da..873653d2f1aa 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -284,7 +284,7 @@ int cont_write_begin(struct file *, struct address_space *, loff_t,
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


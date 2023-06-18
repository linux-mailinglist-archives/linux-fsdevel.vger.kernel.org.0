Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73187348A1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jun 2023 23:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjFRVgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 17:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjFRVgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:36:08 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF51FE47;
        Sun, 18 Jun 2023 14:36:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1687123985; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LAE7q86rzAmU2pmXqjpSY5LwGTLo9P9aKtp2cfOqbFI7RHUOCTI1MF8XsU9Xo1JDhB
    x0VW2OQuZbbIMP+ZN0+3pA5GjoydH5L1RIvFShJdJEy4b7CGTKYCR6jFoKDOk11jrXZA
    gt7bkgHWcCWa7txlU32h5nil+W8SXK5ICLKy5RZ5AsKthjcYLuvhFl5JV1AvWGzkMx1j
    hVxh/DWjuM8m2y+JNcU3ulC+yELs1eCViYbY7BKrvhbLo0bI0iXYEhnmUOH/1R/E3B8U
    FtVhrMYMxm4Tzr8OyTwl0UWD9NZez1bAbH91ZbcNoP7QV2ZZ0LB+HY1uY6PdTfy7QRrB
    61Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1687123985;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5B5W+5M4yQ6bKG+vVuzoT4Vp+ARdlHL0dQxj+aWT0y4=;
    b=EkKDqpIujVv3I9++MhPh7JUlKKRJ0pywsM2CI93xwU/UvZDUWISWNdraw42ycr1XV6
    s4n5FghXNYSo6FE0C4bAtzHTCkxqyB/GGm6mZs/FmS2IEYw6pmYcDYsCTRA/i17Z8sZ4
    ACN4NQhvgXJV2zGPCbsgVKQ/6zCQOHsigwk3nwUsf63ZUl5Bxz1A8KSELEMsC19dFafT
    IBXoY5RDjbdYcdoYHFBSBAXXW09I1mvZI4e2USLcxhyRCtafdnBkhtGKDY4oR+ftOkYO
    OtRjyRH0jMnq1ZNUTH9BPlkyj87JUOfRKilqHUFVNTyE9H6uFNGfW9/u4kGIWQ25UxMy
    dluA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1687123985;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5B5W+5M4yQ6bKG+vVuzoT4Vp+ARdlHL0dQxj+aWT0y4=;
    b=URFyVNhQkk1WjaPApLrqX+adaZWYjOiIlbBXdl5kGUI1gANR/SZnEzs0y7UwoLUMyz
    2CaLiyiOFD21kVRK4dj+u4WgDsU7x/8t4/a2tX+vB0v8b8VSaS+9fFzh/beuQlggg1Kq
    2FOYq9d0EJJT4OaD21oNgY/KXWHuExtzJnG3ir73wn/H1yHplydNUlu5FoM5KZC7w+3e
    ngGjAcdydG/4fvpL0Rfv7QZxi3EBnbdw9rBtXN3XPV2vn15NRvNCJVDO7Q9JFOC5vpDT
    sfFBhipbowiV+iE9Tg0Xu7lf8cgTz8FDJ78kpOnSPsVPnf9H1KQ/1F/3mK7fgw2Hav3y
    XyLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1687123985;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=5B5W+5M4yQ6bKG+vVuzoT4Vp+ARdlHL0dQxj+aWT0y4=;
    b=rXH0HnCIuKZMAhQT/dfven9avZ8tIBFI/MJ5WxYXnufXmubYzYnocg+OMHaFyQiJjL
    zL5crck9utfsfqmr1GAA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD1EQ33bneoxgmq5ARfEwes1hW/CxwfjqKzP/cKnUXGNs35zouFQhI="
Received: from blinux.speedport.ip
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id zb0c8bz5ILX4AHK
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 18 Jun 2023 23:33:04 +0200 (CEST)
From:   Bean Huo <beanhuo@iokpp.de>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.cz, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        beanhuo@micron.com
Subject: [PATCH v1 2/5] fs/buffer.c: convert block_commit_write to return void
Date:   Sun, 18 Jun 2023 23:32:47 +0200
Message-Id: <20230618213250.694110-3-beanhuo@iokpp.de>
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

block_commit_write() always returns 0, this patch changes it to
return void.

Signed-off-by: Bean Huo <beanhuo@micron.com>
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


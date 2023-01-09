Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79089661C59
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 03:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjAIC3W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Jan 2023 21:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjAIC3V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Jan 2023 21:29:21 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE899FCE;
        Sun,  8 Jan 2023 18:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kaMCTOcUvTU23khT1M5FZYZ1J/m4B8hsn47snTUtPXI=; b=jJcsqHvc+Dd04fVEdjS5iUGmev
        XQ0FG/720D5yEaCehNpwcWnmQSojsIgjrT/MTahCSntyyMSCLEkSqz0ZIY26yuszAd2hAh7lZnFKM
        PnUNIagO6DK0ZDMwfEY6KH+1krRv2wY6+Z9fpIaXCDRroTlD2u6WSofpdq0LpHjqd0Y1V+q4HoF8u
        d2ED5tJ8K8tXDVbtvsiNWHd50PnbfwTjo/3u66l2iqTPJj2JbAWApXou7d7GXVIWAbyYtx5bHqKnq
        tX71rnTf4Ax0FGiT5iG9zuDq6tjlB4TIVZpSEqOZdS1J08GSsxvAl+pns/Z2OwYR8Q4/4TjIHvl7p
        OvZgVJNA==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pEhuX-00GnlC-0p; Mon, 09 Jan 2023 02:29:17 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] freevxfs: fix kernel-doc warnings
Date:   Sun,  8 Jan 2023 18:29:15 -0800
Message-Id: <20230109022915.17504-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix multiple kernel-doc warnings in freevxfs:

fs/freevxfs/vxfs_subr.c:45: warning: Function parameter or member 'mapping' not described in 'vxfs_get_page'
fs/freevxfs/vxfs_subr.c:45: warning: Excess function parameter 'ip' description in 'vxfs_get_page'
2 warnings
fs/freevxfs/vxfs_subr.c:101: warning: expecting prototype for vxfs_get_block(). Prototype was for vxfs_getblk() instead
fs/freevxfs/vxfs_super.c:184: warning: expecting prototype for vxfs_read_super(). Prototype was for vxfs_fill_super() instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/freevxfs/vxfs_subr.c  |    6 +++---
 fs/freevxfs/vxfs_super.c |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff -- a/fs/freevxfs/vxfs_subr.c b/fs/freevxfs/vxfs_subr.c
--- a/fs/freevxfs/vxfs_subr.c
+++ b/fs/freevxfs/vxfs_subr.c
@@ -31,7 +31,7 @@ vxfs_put_page(struct page *pp)
 
 /**
  * vxfs_get_page - read a page into memory.
- * @ip:		inode to read from
+ * @mapping:	mapping to read from
  * @n:		page number
  *
  * Description:
@@ -81,14 +81,14 @@ vxfs_bread(struct inode *ip, int block)
 }
 
 /**
- * vxfs_get_block - locate buffer for given inode,block tuple 
+ * vxfs_getblk - locate buffer for given inode,block tuple
  * @ip:		inode
  * @iblock:	logical block
  * @bp:		buffer skeleton
  * @create:	%TRUE if blocks may be newly allocated.
  *
  * Description:
- *   The vxfs_get_block function fills @bp with the right physical
+ *   The vxfs_getblk function fills @bp with the right physical
  *   block and device number to perform a lowlevel read/write on
  *   it.
  *
diff -- a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -165,7 +165,7 @@ static int vxfs_try_sb_magic(struct supe
 }
 
 /**
- * vxfs_read_super - read superblock into memory and initialize filesystem
+ * vxfs_fill_super - read superblock into memory and initialize filesystem
  * @sbp:		VFS superblock (to fill)
  * @dp:			fs private mount data
  * @silent:		do not complain loudly when sth is wrong

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F94D5C555
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 23:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfGAV4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 17:56:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44814 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGAV4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 17:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3O/U/4AQOMxXmGfcYOMDxy9wX1nV3bStMeoJTdaUSfY=; b=NxqYEBSBndwOeobM/sO5dbo/4i
        19D7EGVxnlGCPznwgfnPweqH08blWIt5IcBnO990Ag45QoNpcSNDtJP3sl958uS5/TurghTu+VKvA
        9SYu74AixnUkkUffaBKh1LINJV+WmHIwQ9A7saE73fXbh3jIA1G0/lbIa+DZ2FfT7XLij1uoxDctE
        qrvmOSay6pIIN/OxrQkON+TJBNHdRkkrOphdyBB6D+2TtzGl+hZ0nM4ZWRq9HMmBW10BINqguG0ls
        HwuUSkp0w40dMHI/uDi4bwC0vCmWnkZh8Guo/60vwFitHDC9nR7K3/xteojEJmLv93543sXlQMSLX
        8hQMCPgg==;
Received: from [38.98.37.141] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hi4HS-0001sy-KX; Mon, 01 Jul 2019 21:56:11 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com
Subject: [PATCH 11/15] gfs2: mark stuffed_readpage static
Date:   Mon,  1 Jul 2019 23:54:35 +0200
Message-Id: <20190701215439.19162-12-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701215439.19162-1-hch@lst.de>
References: <20190701215439.19162-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/gfs2/aops.c | 3 +--
 fs/gfs2/aops.h | 1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index d78b5778fca7..030210f1430b 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -434,8 +434,7 @@ static int gfs2_jdata_writepages(struct address_space *mapping,
  *
  * Returns: errno
  */
-
-int stuffed_readpage(struct gfs2_inode *ip, struct page *page)
+static int stuffed_readpage(struct gfs2_inode *ip, struct page *page)
 {
 	struct buffer_head *dibh;
 	u64 dsize = i_size_read(&ip->i_inode);
diff --git a/fs/gfs2/aops.h b/fs/gfs2/aops.h
index 3a6d8a90d99e..ff9877a68780 100644
--- a/fs/gfs2/aops.h
+++ b/fs/gfs2/aops.h
@@ -8,7 +8,6 @@
 
 #include "incore.h"
 
-extern int stuffed_readpage(struct gfs2_inode *ip, struct page *page);
 extern void adjust_fs_space(struct inode *inode);
 extern void gfs2_page_add_databufs(struct gfs2_inode *ip, struct page *page,
 				   unsigned int from, unsigned int len);
-- 
2.20.1


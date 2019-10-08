Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 119DECF34C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 09:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbfJHHPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Oct 2019 03:15:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730057AbfJHHPh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Oct 2019 03:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lur3By6L9t3k5sGyYS0aphvzqONJlWJ+jh1eabSGYwk=; b=omnPmtgXTnlgbJ4o9RzGTvZjG7
        3Mb0KWhCyvRoETN4vff5rAp/FIarvPQRbn/zG/HkgULpkc5sADUwtwZG0EsoZYmymqp4GYVSrXP0q
        bBlTa4lJAyJsOC/A/pR5RmzCWv15O3dgM+sFsNhpcGNUeZMgLpKCOq6Oi4Pizv8YkTMgl/tH1KFXg
        K7kbJrXw9ghmwQOqsLdaMnL0Z0lJ3ZyTjmEadlD78BqLDAiutXOC0o3LPXfNayFm9dv4YE5DPFpYO
        zOQi1VWk6FCjUcEgn7ia70e36VBtIdcgx3/57acA4Wohnyfjr8MSge/tLxyVoLY703GEIBvZA8Epz
        HJFBkruQ==;
Received: from [2001:4bb8:188:141c:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHjia-0005YV-IV; Tue, 08 Oct 2019 07:15:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     Allison Collins <allison.henderson@oracle.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Subject: [PATCH 02/20] iomap: remove the unused iomap argument to __iomap_write_end
Date:   Tue,  8 Oct 2019 09:15:09 +0200
Message-Id: <20191008071527.29304-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008071527.29304-1-hch@lst.de>
References: <20191008071527.29304-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Allison Collins <allison.henderson@oracle.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/iomap/buffered-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 35c93f72c172..672f5d8efdbe 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -693,7 +693,7 @@ EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
 
 static int
 __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
-		unsigned copied, struct page *page, struct iomap *iomap)
+		unsigned copied, struct page *page)
 {
 	flush_dcache_page(page);
 
@@ -746,7 +746,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
 				page, NULL);
 	} else {
-		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
+		ret = __iomap_write_end(inode, pos, len, copied, page);
 	}
 
 	/*
-- 
2.20.1


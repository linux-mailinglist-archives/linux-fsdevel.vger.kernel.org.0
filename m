Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4160DADED3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Sep 2019 20:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbfIIS1d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Sep 2019 14:27:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35770 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfIIS1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:27:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:Content-Type:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=g1Nbwo0MsIPbydbmvP1trrk+Typ6KEdQts3v8M3jq00=; b=VGwmetYjyPjkfcyy2d2G/PzTw
        PnfAjGpHwSLtW3xK9HqYdJoAmN0uvLhBLTAFdWXdmRJaAGvUe0PNlZIJ3gmAWkFJsFQ8lobeMcShn
        Fo/vU2OAoqNpAgjjH7JPTUalgRZTtjQ3zGLWo9IS9bzCFzdb8RdKEaJ462Fh4wzlgaMwDkH6HXqtF
        4kxWxHHjhNd4gZ8VgZBqbK5tj7WFJMNNTx09Ts7McmmullugDk3M5V84nP9juzo7E1j/pNkD5ZDLW
        EU1wXM+1MSFdyl4Wag3YzCv1IP2EpKr/DZI4FgznhiGuoaLuhV9nCOoEyjbcIUlqfpCW87HUmzq92
        rZMFmFhyw==;
Received: from [2001:4bb8:180:57ff:412:4333:4bf9:9db2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i7ONw-0001uF-T6; Mon, 09 Sep 2019 18:27:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/19] iomap: remove the unused iomap argument to __iomap_write_end
Date:   Mon,  9 Sep 2019 20:27:05 +0200
Message-Id: <20190909182722.16783-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190909182722.16783-1-hch@lst.de>
References: <20190909182722.16783-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 051b8ec326ba..2a9b41352495 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -678,7 +678,7 @@ EXPORT_SYMBOL_GPL(iomap_set_page_dirty);
 
 static int
 __iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
-		unsigned copied, struct page *page, struct iomap *iomap)
+		unsigned copied, struct page *page)
 {
 	flush_dcache_page(page);
 
@@ -731,7 +731,7 @@ iomap_write_end(struct inode *inode, loff_t pos, unsigned len,
 		ret = block_write_end(NULL, inode->i_mapping, pos, len, copied,
 				page, NULL);
 	} else {
-		ret = __iomap_write_end(inode, pos, len, copied, page, iomap);
+		ret = __iomap_write_end(inode, pos, len, copied, page);
 	}
 
 	/*
-- 
2.20.1


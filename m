Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5854580C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 12:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfF0Ksu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 06:48:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbfF0Kst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HQGA55iBIlnfSpo7RGtYHFeLgxg4m3+DxR8LyklEcd8=; b=FJSPU6aKkzdbofrAxIZKxSSWrg
        OtRHzO+IHWR4NIQWnbllYlMR8v8YcvnmyZDFtZzPNin04P0rM6ArytwDaHDmrwu9OBD3R7gvhzv+c
        28Du1Uw9x6JvyG1YvQCeLVUyrGUoOTRRRisGd528flUB8OPCLpauwrkaTbKf6C/iYgLticDVfY4iw
        /QOLR3hkl3jP3EN9ugiEnt+AQw5xU9zUj5WXxYCgUZXXN8YRA8BUoYgLjSwJ0HCnvLHeR3FP+YO5K
        1TefKcLLxqbaaT2Gl1C2z5vYlq6rcLnVnqg9NCdZY6fb0ebYaMrg0q8KXkuu7CJ3h2hy8k+FOZEzk
        9bym2HMg==;
Received: from 089144214055.atnat0023.highway.a1.net ([89.144.214.55] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgRxO-00053P-GP; Thu, 27 Jun 2019 10:48:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] xfs: remove the unused xfs_count_page_state declaration
Date:   Thu, 27 Jun 2019 12:48:25 +0200
Message-Id: <20190627104836.25446-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627104836.25446-1-hch@lst.de>
References: <20190627104836.25446-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_aops.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/xfs/xfs_aops.h b/fs/xfs/xfs_aops.h
index f62b03186c62..45a1ea240cbb 100644
--- a/fs/xfs/xfs_aops.h
+++ b/fs/xfs/xfs_aops.h
@@ -28,7 +28,6 @@ extern const struct address_space_operations xfs_dax_aops;
 
 int	xfs_setfilesize(struct xfs_inode *ip, xfs_off_t offset, size_t size);
 
-extern void xfs_count_page_state(struct page *, int *, int *);
 extern struct block_device *xfs_find_bdev_for_inode(struct inode *);
 extern struct dax_device *xfs_find_daxdev_for_inode(struct inode *);
 
-- 
2.20.1


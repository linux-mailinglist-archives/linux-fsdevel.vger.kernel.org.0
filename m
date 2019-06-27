Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC9F5580E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 12:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfF0Ksz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 06:48:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52038 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfF0Ksv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 06:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TGc9yLWYMRKUlmT5Jk1NJHMqo8d/maIMu2xcm8St/gc=; b=gSWBeDz261P2c7rK9N9ZPqrL6W
        1a8MdRl52KGmnzBgaOaeXLt27Ll3bMPBuYkvkeolv9yhyjThm0OZflhaM5/+XKdjoKszr6PzpwAGX
        jIvx36JG2i1zpIuyMRRCFfkKlnML4efpAl1KU65rnH23EqvxHbadPJkQg0axJbooKUzPnk6LVmn9Z
        dRTOxj0Z7sm8z55Hydf13mP2UZefLsdGL5tiTysf+ak3uY9HXwOhZhQFaViSTJkGKLF2W9JeoL92J
        kTtVOkEq/Hp+wOpT7ONthyHQBGwxQOqg4m67DPlCxSPxD7LvDQZelxM+58helHmjB6SivYpXOWkhE
        YLaYo9xw==;
Received: from 089144214055.atnat0023.highway.a1.net ([89.144.214.55] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgRxR-00053b-4m; Thu, 27 Jun 2019 10:48:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] xfs: fix a comment typo in xfs_submit_ioend
Date:   Thu, 27 Jun 2019 12:48:26 +0200
Message-Id: <20190627104836.25446-4-hch@lst.de>
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

The fail argument is long gone, update the comment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_aops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 73c291aeae17..8f7b2d91d9a4 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -626,7 +626,7 @@ xfs_map_blocks(
  * reference to the ioend to ensure that the ioend completion is only done once
  * all bios have been submitted and the ioend is really done.
  *
- * If @fail is non-zero, it means that we have a situation where some part of
+ * If @status is non-zero, it means that we have a situation where some part of
  * the submission process has failed after we have marked paged for writeback
  * and unlocked them. In this situation, we need to fail the bio and ioend
  * rather than submit it to IO. This typically only happens on a filesystem
-- 
2.20.1


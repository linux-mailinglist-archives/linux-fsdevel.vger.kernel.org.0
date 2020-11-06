Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCB82A9D24
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 20:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgKFTEx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 14:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgKFTEv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:04:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2A2C0613D3;
        Fri,  6 Nov 2020 11:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=1TxDi4JZHiUiFIihFWdfLGUjoSsTps8w2H/ZcwkuUgM=; b=Nn+BVDYVvQjkrPNv/cuyIRiZPT
        3lEBXr+QivjMh5e4l/ao1VWygxVyXgb1GaEszoEv7k0V4mDQl4Q558fFjWlIp5zja4skDHErGtVSp
        UazzhRWUeqOaZF3BD6OBDPLbIVX8kVtVQNkhl1fmu2B68Gte2LOkphKfMcyhwK+VcOtW25btBkWV6
        zqDCSn9jzGsf/k9VbPpmVDu9CIfQvBntbCmhNM15v0xLxzXvs5anzeTd73+N0ndrVdf3GlCLjFmvi
        5AEKf4IRVxwZE6cQKKKLk7ce4QfJMaGBbLCFQqB8pdhqsPi3eteFIE5suw4d4lzdD5Ph0CyZ2P7Z4
        CljTjCVw==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb72J-00017x-7W; Fri, 06 Nov 2020 19:04:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 24/24] block: unexport revalidate_disk_size
Date:   Fri,  6 Nov 2020 20:03:36 +0100
Message-Id: <20201106190337.1973127-25-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106190337.1973127-1-hch@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

revalidate_disk_size is not only called from set_capacity_and_notify,
so drop the export.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 66ebf594c97f47..d8664f5c1ff669 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1362,7 +1362,6 @@ void revalidate_disk_size(struct gendisk *disk, bool verbose)
 		bdput(bdev);
 	}
 }
-EXPORT_SYMBOL(revalidate_disk_size);
 
 void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
-- 
2.28.0


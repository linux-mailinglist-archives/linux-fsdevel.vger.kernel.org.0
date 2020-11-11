Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0032AEB64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 09:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgKKI1q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 03:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgKKI1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:27:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B544C0613D4;
        Wed, 11 Nov 2020 00:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=qTvXuSKxmUERuRhycJyctBDf7GzVXaeOz2hEmG1jnCY=; b=StdRHq9eqGBzFFXpMKfN8ot2yd
        jPC1U+22bkuUiJFL3H0mb/9/1vlelGLQvG1hCH467eSdVW15dn8Pibm3EIxJwicffJfGSFU2WZAlL
        tM76FQA8Mhz7J0Dt012NqxGVof6CBWaiq+71e7SWBXxgz9PGD/HSjyzrq5laC3bHahSJjAdt/YgSg
        VK5FG4/KAjlBjCF1Mxk5ErE82Aw6rkXyhTwsy/FUzDELWaBKzEkjqbZ7oRMK+Qd8mrTJBHvgsXqEQ
        R94YnaXqfp4e3S0Qk0xduyFHl/C3X5yAr/DgMPQvmpUp8si6GBSW2z68gBmwcJiLLaIwE1WsQpe7C
        3Of9U5JA==;
Received: from [2001:4bb8:180:6600:bcde:334f:863c:27b8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kclTY-0007gX-LB; Wed, 11 Nov 2020 08:27:33 +0000
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
Date:   Wed, 11 Nov 2020 09:26:58 +0100
Message-Id: <20201111082658.3401686-25-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201111082658.3401686-1-hch@lst.de>
References: <20201111082658.3401686-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

revalidate_disk_size is now only called from set_capacity_and_notify,
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


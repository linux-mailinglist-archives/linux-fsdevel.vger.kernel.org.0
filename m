Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6162FB062
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbhASFZZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:25:25 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51811 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731297AbhASFJN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032953; x=1642568953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cfu0m5VKAuNxHu1l31PcK7nm7GIw08f0wSHX5FdYb7w=;
  b=iYFUMZ5nJ/NgEsOW13Y5XXMfg6KU1P9gYgac8AhHobnTzdSax74U3g+b
   Fh5ugf5zARboBIHrv9nOH+Vq8LmdGoqWIQDjhcLLVhsdOw9eEOsdrPyo+
   WdrkAPcaYvMFAXIoK4ZL5m/1hGQmHf9yWAlMDaozobW622cxYJ3uqHagG
   Fpvq601uDpj0nOaF7aoQ7q+G3lHgFpXQWAG0cn4nCv2b43bI3YVjGQ3Mq
   4v6SH+1uzv2/6N7w5fA+zj31wVHLc7dcHkTrAwiySPUTe5fx03FprdJt0
   +3/3sGUVdwH1kZTIDhV/0FrHGUKURAArfdPIjNe4FOldhXPo8QdAKPch4
   A==;
IronPort-SDR: liDG1hKh42MQ6U3S48Vok6OUfJLb610ifmDoPQp+Ah7Y/ZT8+9QcX+GyUpnLaEYQnPEaKmGv9O
 5CviWgExD5vFxvTVd0PcH+WU/J+BXmoI4xjKceqWLCEmbalXlniwDFeh9FFpVwmIxOOV4IWAX+
 YPwb6RIRVvgrNqgXWqsWykzAd/wYKCerIjChutpH0+T4WafZYrkDCMrmxX121W19rbz5Kgq41K
 BMI6lsYUUuXB/Q6/15Ri9sNWsphw+At0JHrq0gNB2uCKwEftapo/GCAFWoIvO5pROj96e5IcF6
 nmE=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157763878"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:08:07 +0800
IronPort-SDR: 2/TJw+Jrlr1n2V9gPM6mMJ/8oylQO2evDaFwRWUgfgiUW6EQdQZPEc5fxg+L2UA+ztLemncULU
 F7iYIXB6FfV06yFvHQjNk/0Q8VXsSW05BufH3wOhQNNHcfzzvQcQauF0UZbqeF9uOFLyWhyoVp
 I30BAfWrIdCMquIoHV8DVh8pj3DcCMrntvvCjKhk8rdH/4HoNfTaNl0ZYyMCFr/UgP5iI6l2p9
 QyKF/rtP3lAfh7eBiLPfArC0yTUr7oxDVKWdXUh2O2Svm4wHXH/Ug1/OMSKbgrhzNjiuT4P1qF
 OdNQKQ6Twg+CX7oK4Q0KAvJS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:50:42 -0800
IronPort-SDR: BI4IRRImuMT37W/0fgUHv+jo9/cFXOLHBSkHLB71uXGRhjXdqsMAnoeLSicBDzNjCtXE6Dh3IX
 0CYkAjVxbNezhsYqTHeC7O5MKiUI+nte0sRu7g2EHJnUc9MH1BYN8otchvz0lbdHnJk4iU7F4c
 WmfRkOrAtQMZI0QoGyPGUddwOVe1ADf9CPub9wyiRWCIGto1nEeON+Wfy1+NBrAsdMrCFgxnqp
 vom68oJ4IlK86VNF+Hzp5EiJIZpEBG12SHeKkbAPc06Spul2+gAW8LkpVcP5k8qn/tXfmApHrz
 H7o=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:08:07 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com
Cc:     jfs-discussion@lists.sourceforge.net, dm-devel@redhat.com,
        axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, efremov@linux.com, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, snitzer@redhat.com,
        song@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        darrick.wong@oracle.com, shaggy@kernel.org, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, tj@kernel.org,
        osandov@fb.com, bvanassche@acm.org, gustavo@embeddedor.com,
        asml.silence@gmail.com, jefflexu@linux.alibaba.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 13/37] drdb: use bio_init_fields in actlog
Date:   Mon, 18 Jan 2021 21:06:07 -0800
Message-Id: <20210119050631.57073-14-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/block/drbd/drbd_actlog.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/block/drbd/drbd_actlog.c b/drivers/block/drbd/drbd_actlog.c
index 7227fc7ab8ed..733679cf456b 100644
--- a/drivers/block/drbd/drbd_actlog.c
+++ b/drivers/block/drbd/drbd_actlog.c
@@ -139,13 +139,10 @@ static int _drbd_md_sync_page_io(struct drbd_device *device,
 	op_flags |= REQ_SYNC;
 
 	bio = bio_alloc_drbd(GFP_NOIO);
-	bio_set_dev(bio, bdev->md_bdev);
-	bio->bi_iter.bi_sector = sector;
+	bio_init_fields(bio, bdev->md_bdev, sector, device, drbd_md_endio, 0, 0);
 	err = -EIO;
 	if (bio_add_page(bio, device->md_io.page, size, 0) != size)
 		goto out;
-	bio->bi_private = device;
-	bio->bi_end_io = drbd_md_endio;
 	bio_set_op_attrs(bio, op, op_flags);
 
 	if (op != REQ_OP_WRITE && device->state.disk == D_DISKLESS && device->ldev == NULL)
-- 
2.22.1


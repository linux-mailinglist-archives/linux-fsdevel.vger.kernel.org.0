Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6CB307014
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhA1Hr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:47:26 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51464 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhA1HOS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818200; x=1643354200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g8HJbcPmpqxtxJgQpVgZEQpuhn8q+oe36W4m3E0vxow=;
  b=mzPkbe/E93KGhEpy5z0MbdgeNicUwvOLjGBBu6ozXJF4NaizpUvCynhU
   HAygpbh6L92cawNQ8Juy/USOonqluHMWrkfmLnGGrbMpQJXgx1QRKe/fk
   upMJtwgRbYIr+sxjIRgQ9Qf0+q1fn2rF88yt0wzP342I9+odImzpov9D0
   XNnKhgREHZcGBMhyjPxL+xH7tMmaagXH82hMZJTYm5POKjeepfGaYLMSV
   Cs3zv6Vb5BVxkg8jJTQyY2OLuf07TZeaKq9u1ZvIzhkVZSsZYiAsyu7db
   QcNyokhB3FjvlVH1nHsylCxok4j0rohXJGaUofsVSta6Z/+Gnsk5uqf9n
   w==;
IronPort-SDR: nBo2YCNknXHmtMPRQuIO4KAfWfGeqA6uck1BQD9JfufC5HgzoEEcB1X4Sj24VYgnn8H3M2PysO
 RUCjtpxPvJhYZ0T4lscfpyc8S9OtQ2IUeXJuzaOK4tdHhi4NOMmwNkq+//nvKIOX9CBpmsZVFM
 WQjMxWp4X4RsCjp+fXPzpsxGnDVO3RBp7+U+L199J1lrFpzEznO0V2ixP1PK2DMWNafqlJaYWJ
 +i4eaYy57NQrWPxLf822AkJZgRgcLMRpiQKwZ8NbQx7DgzmNGZCSWfuYReERddJuZ/Km2EP8L5
 It0=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="262548982"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:15:18 +0800
IronPort-SDR: 8uRtmtQ6dIrH8p7m3RozWKU685yyc1qPWWh0Sv8nAPd2vXVO5xFD+5u4U+ejNRi2a/Z43QxlMu
 xXFrwXflfX5glQh/Rb9/TIMFKsSsmQs2YjF8AABNm2TJc+ntINwbchjA9a6FogNHGR12HrtEyY
 XUN7Ctkdgns9yr4lfm8CsGtzE4bDUWCpEjTyjEdHhUFi2qFDZZIsKtv8BGmCl8eSQx7MT+V9iS
 5seOOqC2KdCxMc1plODtMVxJ/WtKzTYbOxjz3ASFL4okYl2mOxASP9yK2e4kHwtI5dY8LP6jJZ
 vS6TYyT6/f3x0ZAQ1ai3Gt3o
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:57:43 -0800
IronPort-SDR: S7K4kJLXzJBN+TtdhPMN6TP/Dffs+zSa3G/de5+S1/PIJxe5GMDYhILg7ObwZaeQtAx8NJxvkl
 nIc5LC+mPpv7TI+pptGOuvqvgXc2tzfVFCEyc5+LFgl+ipYQILMS5NCsDr+0Wgl54XSWETlfzh
 gHkg4ZggWJkUuTGFtq5ayNdqurKZ4tOlkNjJtnTH4tbAn7NSWqg+Ok++T//Bdn23FoUZxk+NbJ
 AQUU7LKb9NmxAxDMj2VCc1ROkgf8sOKgTR+MW0zxXzuua4VhN6N1CvrlPe6fa6RhDqhXPf7MuT
 aTA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:13:23 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        xen-devel@lists.xenproject.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, linux-pm@vger.kernel.org,
        linux-mm@kvack.org
Cc:     axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, konrad.wilk@oracle.com,
        roger.pau@citrix.com, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, agk@redhat.com,
        snitzer@redhat.com, hch@lst.de, sagi@grimberg.me,
        chaitanya.kulkarni@wdc.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org,
        ebiggers@kernel.org, djwong@kernel.org, shaggy@kernel.org,
        konishi.ryusuke@gmail.com, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, rjw@rjwysocki.net,
        len.brown@intel.com, pavel@ucw.cz, akpm@linux-foundation.org,
        hare@suse.de, gustavoars@kernel.org, tiwai@suse.de,
        alex.shi@linux.alibaba.com, asml.silence@gmail.com,
        ming.lei@redhat.com, tj@kernel.org, osandov@fb.com,
        bvanassche@acm.org, jefflexu@linux.alibaba.com
Subject: [RFC PATCH 11/34] nvmet: use bio_new in nvmet_bdev_execute_rw
Date:   Wed, 27 Jan 2021 23:11:10 -0800
Message-Id: <20210128071133.60335-12-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
References: <20210128071133.60335-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index bf6e0ac9ad28..f5fd93a796a6 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -225,6 +225,7 @@ static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 
 static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 {
+	struct block_device *bdev = req->ns->bdev;
 	int sg_cnt = req->sg_cnt;
 	struct bio *bio;
 	struct scatterlist *sg;
@@ -265,7 +266,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	} else {
 		bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
 	}
-	bio_set_dev(bio, req->ns->bdev);
+	bio_set_dev(bio, bdev);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
@@ -290,11 +291,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 				}
 			}
 
-			bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
-			bio_set_dev(bio, req->ns->bdev);
-			bio->bi_iter.bi_sector = sector;
-			bio->bi_opf = op;
-
+			bio = bio_new(bdev, sector, op, 0, sg_cnt, GFP_KERNEL);
 			bio_chain(bio, prev);
 			submit_bio(prev);
 		}
-- 
2.22.1


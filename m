Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE9C306F89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhA1Hce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:32:34 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51464 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbhA1HQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818380; x=1643354380;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1876bf0CQ4oKwKjrcbLTUHkm2JuWaJTsdB558+rHPRs=;
  b=cqzVmiOW3Mbpe8I5ph9JJR5MoftxOFAwO5bKFTx6pVfns0BIj/yrcb1y
   yRvFS0bVcrpH0jgmIqIt68SYprvjXoxstfnK5alP1wal7fK65Y3ia9crs
   m7p99vD1gQL1Xq+WGluj6vAUpsgzoGqUKkpcS3K8TC1VrwLFIKe4kF7cM
   jwUJmmNmEskeACnjM8WsDCx5y+S3c2EWGpjISu8yUv+suPKSiPvBHQEV4
   Js83XAeph3q/yxJ1SkmMKwarTFf6yK9PW1+H1UFnvr7790TbzGOG+ZsoW
   RqMbaMLBWAbYHB6Aeqsgt4MEk85tYRo/2aHZpVp5g8GrlXTXAWNODswf9
   Q==;
IronPort-SDR: zAro/a7yim/dBdF8kR62NOWFV1RIotndtZ9eIl7KK3CbT49Q0nXc5Uhws8ndWOb+c0I/DOpABV
 Xo/yyYBHZruqF6HGPMhOxz6Uipz9QpNM1gMSBhbUKU91M/vwg1HYdmpnehludqYoSIikGkRGPA
 uDSOLdO8jt5zqoKnjeR9FyCEbB4TBG349cU8R3lDv7eEVYPtH2tSgfJQI1/lj4G34XSw8pWXT/
 H7U3r17fDjYpuQ0UV3dDT59Rdoi5/YmfiRjGnu9CUUK7i4Ov/AvbbouQBpTnSND6uXevTqLj92
 hew=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="262549098"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:17:15 +0800
IronPort-SDR: y3zovJvbbbFII1ZsLnYJ9YyMZ6SCTg27zGiHDkVwh1R7J5gx5QtxUGzQyjhxgGc/DEr6IIH3as
 zGgjdFqw9HisUiEVEiQ9NtqviCRc0hhbiIMfyw1z1fXN9T713qL0I9fOlZHZY2RxNI2HGgSxTA
 9rY6ff/jL2OMR/LZacQmwjY5lwUFgEi0wmxaDhvFm0/ZtO1/XUFr41x1QWKKXf23jBwTSkZkWa
 c6+pu8YiMGlXsfDS+3UusPOdGCYy9JWyfmxWaoQZleNyfM6z4n2imoy/7va4DNN0enrbFVzoai
 OjhmrQ0uGtZPVcUT10p/GpmQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:56:58 -0800
IronPort-SDR: AZlMO6gj0EkPLCOgk+c5DT4WNDhjCfw45MtadZ5/GiFEmQsvwhsbRFXpLpdTLbQmQEemYM6EDm
 tOJGHTOsUuwCnKWQp1EvZsc2vVv2mGBlVwctpi8EDm1Wy6X1cWP44qswXm3cNGjgKR2lWgrabH
 PKyOztqBt3vFXNBi+4zXssLa4rCI5pehsTeRPvX3Q8KhjR216EOs3fiNJCh3n7IcfWfe8KNrrp
 msksZa1Bq+VYcOk7PDniLMLHnLtDMI1z0ihKaVt3jNoNuACs7lGXhymeE4zWEV78rp7w4D786X
 hJ8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:14:40 -0800
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
Subject: [RFC PATCH 21/34] fs/jfs/jfs_metapage.c: use bio_new in metapage_writepage
Date:   Wed, 27 Jan 2021 23:11:20 -0800
Message-Id: <20210128071133.60335-22-chaitanya.kulkarni@wdc.com>
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
 fs/jfs/jfs_metapage.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 176580f54af9..3fa09d9a0b94 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -416,12 +416,11 @@ static int metapage_writepage(struct page *page, struct writeback_control *wbc)
 		}
 		len = min(xlen, (int)JFS_SBI(inode->i_sb)->nbperpage);
 
-		bio = bio_alloc(GFP_NOFS, 1);
-		bio_set_dev(bio, inode->i_sb->s_bdev);
-		bio->bi_iter.bi_sector = pblock << (inode->i_blkbits - 9);
+		bio = bio_new(inode->i_sb->s_bdev,
+			      pblock << (inode->i_blkbits - 9), REQ_OP_WRITE,
+			      0, 1, GFP_NOFS);
 		bio->bi_end_io = metapage_write_end_io;
 		bio->bi_private = page;
-		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		/* Don't call bio_add_page yet, we may add to this vec */
 		bio_offset = offset;
-- 
2.22.1


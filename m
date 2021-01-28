Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB51C306EA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhA1HQm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:16:42 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbhA1HO7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818263; x=1643354263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OdHsUuhLqy4MrzmNdd/tdpH4dcVzXnQrrHk/wuqLVYg=;
  b=RtmeRjjK0YJ444OWdobYYgwFHOVls7blAjqpmsLVe7IJn4nhfTBnKubE
   M7YqO2PIsKNufIAeS2JTbipUq7PGoy3spY68RKMAloWkaW7/XmRZKKmge
   z9jnSE5SQQcAP8zzt1Xn5NPosQlHoNcLvFT2FA+nfDMvKq4m8Uv2sZgiG
   f5JMnvJ0KOvvFsXlWb/JiQyt+hVqGFYIXaEdtMPvyW8ykZAnInLlepFqq
   WsyNrX+fgIAeQZXJVmPRQD/Iwb0G1BSaxE19g66pc/gsO8mlge++O72Tr
   wCAA7vJcAmaLPV0UQy2G6w7vlBrPpZTQNr0CAMFo2a3U9mdXXvC0vzHkk
   g==;
IronPort-SDR: LfJ4JLhhHVdXp1cvPJTo1ftvY2DeWF83ozPRFqNsH1a5jtHBlAgv0BqBcUD9tGuhIzxkVlcp5o
 IEWe3De0To4AS/w04q8p7ul0vqMoZ6fJEEp6945RQCLu62xgvmnYhMx7uCc4OGp5I8I3Hp1Rlp
 qVUz+xFVuEpdrlkGwHeDvEtkuXKCUT42pyihz3gNE7mhEjdgDFZ3xo+j9H8QMujAbfRPjIpbiw
 th9+yUJxVvJXnfPn7+IWWIVqISObNxswk8x4RnpL96Z5TGHRQrrfiqStRohgEXgQ2h8WfEFgDz
 66w=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="262549015"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:15:41 +0800
IronPort-SDR: sGvKLNi8TvX47sSSbUOvwspM2nmzABkQ/LMatD0iblYu9ZRp5SWSOEy6z06BlkO94Hu5j0I8vf
 IkiWOXAWC17odUxUvWIbfrY4RblOI3HPVrgnPS3RfIQWtvtEPcAZG0uwObmdI0MiYFdJXcMMNn
 d+qBGDS5ohmmL7gE346406blFx2QT75mI0js34CJBFtqhKtRu+pcGj0+IlD3JkOU596X+VFI9n
 EIcaJzh8DEAO8EY2X1VGGI1wLc61OnmVAxF+DKng4UWX6401Gl3sBlTV50ya66yqdiBMj19do6
 6E59cdT515MRqNZXW+fl+hp9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:55:56 -0800
IronPort-SDR: Soam0z/hZs1yuoqW7i6jx5roOoHAapZwcG8+RboeMSicIzBmOYiX0n71yThGE0I1AnlhuM1di0
 VAe/ab59Zj3d54HqeQwwCvYowNBZyfmch3v7Oy4azaqst0BpJQIg4rXG9R5IU/X7180i4BamQI
 Pdm6cEOWuqZT053sZGwqRvhtwriLsaGVJTX83nQ+r2PwZZdfIXxXkXEJoScfk1suUPevohY8gp
 ghp78Zzi9GkjGDnNvz6HqiAkBvVb/9awaEDn2T+13/9ul6gQjwyqb4x2IkJNU2l4rR1clxPnay
 0k0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:13:38 -0800
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
Subject: [RFC PATCH 13/34] block: use bio_new in __blkdev_direct_IO
Date:   Wed, 27 Jan 2021 23:11:12 -0800
Message-Id: <20210128071133.60335-14-chaitanya.kulkarni@wdc.com>
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
 fs/block_dev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9d4b1a884d76..f3e3247894d7 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -367,6 +367,8 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		return -EINVAL;
 
 	bio = bio_alloc_bioset(GFP_KERNEL, nr_pages, &blkdev_dio_pool);
+	bio_set_dev(bio, bdev);
+	bio->bi_iter.bi_sector = pos >> 9;
 
 	dio = container_of(bio, struct blkdev_dio, bio);
 	dio->is_sync = is_sync = is_sync_kiocb(iocb);
@@ -389,8 +391,6 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		blk_start_plug(&plug);
 
 	for (;;) {
-		bio_set_dev(bio, bdev);
-		bio->bi_iter.bi_sector = pos >> 9;
 		bio->bi_write_hint = iocb->ki_hint;
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
@@ -446,7 +446,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		}
 
 		submit_bio(bio);
-		bio = bio_alloc(GFP_KERNEL, nr_pages);
+		bio = bio_new(bdev, pos >> 9, 0, 0, nr_pages, GFP_KERNEL);
 	}
 
 	if (!is_poll)
-- 
2.22.1


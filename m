Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977B6306EFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhA1HVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:21:35 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57290 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbhA1HTA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818340; x=1643354340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y9+Mnjxua+V7f2wybPN6k7Lk3+3v11itMxG4MZ3QMkM=;
  b=D8Lf58isT4tO+ZqWCDov+/9wpJaDfthIekt4f1gcRkM7TXulFX3N66uE
   qYARWilUxfAaoRBboavkY+imFd4pSqVsr5ioZLLZSRBL6ogfzH+bzy1AV
   eqGKDPScPogvq75qKAz7BUDQKh8LinCn0zt0woZ7V2NpNpuOq/EJwZPjt
   xphH/7ftXJNjR1/aaet6yJC12KI2Jbybvc6EBHLqnwCWdH6PZMhn0/e6v
   ojHhANebRYkJwTAhmiWikL4o5fwKmJxlOsGlazICa1TizXm+PYlUkOeQK
   E5VnEvoaR9MmWSv4wox4q0Inisn3lei/lb1pKxdBkJeuIJrlVpxcR4g3D
   Q==;
IronPort-SDR: BEOT6T0S0JHif5Zht8zGfgNYtkvaRTuVAF2eQEM8BtpqcpsRUl8+RQG1rH0Gx6hJMgILsM4TZG
 PD4pv600QfiHVpNHy13n4U/t3s7hs+rbItNB/2gnMpgVUrHW+GPRC8hEsWDW3x+rqN0jKOtz2f
 3zwotWw6rgawP9hIrG3y7d48I2vlEPjVKiZQzgWWtg43alSDh8LTGAgXywnNeL13GJsuw3ivNJ
 0N5XEvWMI8UFuddGSCqBKV8ZwhhDyT3+RC3hTxnFlA3HBmT2onh76QzcFsEU7crfp7kIl/E1Sz
 oo4=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="162963489"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:15:56 +0800
IronPort-SDR: hbecLVCywuig10fnW9UamuqOmBTZsuxtI69DAuuoMxBB3mr5/0rJYjVbndQJn5ysIx+R7dbGao
 snxNqWqunZOCg5PpNUChl0tXPGrzySwkm/ophB/xIuEJM6EMgJ19P9a1/qNcDyiLMwMtuk7Ua+
 v4kMBUdA5SVrIHuggLfTQwN+agVx2yOIUHrpe/b77oHjDPo26X7PR0Orm86E5d87YX0J5ASXDC
 jvJp8Xvnya5PU2IvO9VfaS3mwL/XvLLi9rgneCqXsML0N/PIKL+1e1IvaqN1SQKvfhoDjO0QXb
 NXN6v5PPtlRgTI6fE943lILI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 23:00:15 -0800
IronPort-SDR: MJghY7CI3VIGR5/IaW1FKfL3TP8YTcGZMlKgwb78Me3B/B/3apRuuzh9zoIBvsafPZo8P1zI7O
 tvlMLEPWxNEsao+d+OWmeAfzkHQtyrR4CezWVDYJlrvLmf+2864qvNG9WiZqHSu38lUOwqOgWr
 BwUEJ5wQyzZ3OCyeIORv7uUc6VzLa9ZZ6RiC/IlKAQuXNbiGRl7btRhvnWciISjEw6c6WHvSr7
 U7MWRK7LEz7DNkLYA3LIdhi5N4PJW+ftjhgTNZ5eyVeVGIhgT6If8NwOmXnpUTI7IymY6dp08v
 5GE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:15:56 -0800
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
Subject: [RFC PATCH 31/34] iomap: use bio_new in iomap_readpage_actor
Date:   Wed, 27 Jan 2021 23:11:30 -0800
Message-Id: <20210128071133.60335-32-chaitanya.kulkarni@wdc.com>
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
 fs/iomap/buffered-io.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 16a1e82e3aeb..08d119b62cf5 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -241,6 +241,9 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 	struct page *page = ctx->cur_page;
 	struct iomap_page *iop = iomap_page_create(inode, page);
 	bool same_page = false, is_contig = false;
+	struct block_device *bdev = iomap->bdev;
+	unsigned opf = ctx->rac ? REQ_RAHEAD : 0;
+	unsigned op = REQ_OP_READ;
 	loff_t orig_pos = pos;
 	unsigned poff, plen;
 	sector_t sector;
@@ -285,19 +288,14 @@ iomap_readpage_actor(struct inode *inode, loff_t pos, loff_t length, void *data,
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(gfp, min(BIO_MAX_PAGES, nr_vecs));
+		ctx->bio = bio_new(bdev, sector, op, opf, gfp, nr_vecs);
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
 		 * avoid having to deal with partial page reads.  This emulates
 		 * what do_mpage_readpage does.
 		 */
 		if (!ctx->bio)
-			ctx->bio = bio_alloc(orig_gfp, 1);
-		ctx->bio->bi_opf = REQ_OP_READ;
-		if (ctx->rac)
-			ctx->bio->bi_opf |= REQ_RAHEAD;
-		ctx->bio->bi_iter.bi_sector = sector;
-		bio_set_dev(ctx->bio, iomap->bdev);
+			ctx->bio = bio_new(bdev, sector, op, opf, orig_gfp, 1);
 		ctx->bio->bi_end_io = iomap_read_end_io;
 	}
 
-- 
2.22.1


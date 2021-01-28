Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679C7306E88
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhA1HPV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:15:21 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25502 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbhA1HOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:14:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818050; x=1643354050;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OzcT2XWni+wbNY2uowp8HTdSyU1JsS57dIOzGLP71ak=;
  b=hajdvK0ZiDQtDkd6I8nLkkJDYsXmKEFUoxwHVDCau5fDpmVNE20YIIWi
   JotZ1Ixit3LVq4LjMkfRFrECOO9MEBK71mV+j/PWZ5GvqJaa80Stcm/XP
   /0clIiHA+mW2ONsrhurzCAr5g6TkTFXr/gwFUgLk8T5zcxQptT85Cnw1K
   8smwNnKyOVDANbw68k9wO9OLlksFukkUEXVa8f/97EyI2PS8+qdal2I8i
   /acKfqUfnu1Jn5MqPiaA7rCh0ZOUlGO56eKvn5/6IHgW/tyA5V7DwVJed
   C5+HPAlyzpiJpLR709FPHPnq4Y/a8NI1+qVZCO4OxQzFr0x0Tnxee8xKQ
   g==;
IronPort-SDR: ips+qcbHgDovI66x7IazOAW8unTTwMuBCO3DLBbgsGevCGbPVO0rNtVvqvB79ytHFBjbIcXQLw
 tKOqF+xByrXDRPlhhCAej+myhwsK4Y8HvK/kav4wIJlZgiM17rXuZxa5XeqQkoRfLi3QUh9byZ
 w+BR9csKJDQFWQ2omiYM0JoVhr7sBcKi3Yb7dgODAT27dfj8maW4bxwFGJZYwzoC1HXI+VSPbg
 sPKJaMAb6W1/Tbu8q6fX3ILOwFO8skQSYIWQjHDncWbgu0DI+5qFYtX4bgUNVFJHYbIqZH1w2l
 DaQ=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="268892424"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:13:02 +0800
IronPort-SDR: MG2ERFEkA4mlL0lFT8NLsb2e6DFhVVRqB+IA5oCVIHXZcss05Vy6lTjpMJpiqCktzY57GMpYzv
 rszBymD49vU1leR1F5Gy3Yjc76IekQXnx0fbgXq4q0aZjEm/u7IDO3xEyEHGBGucdCzRLsxd4x
 MEb2W8VL4nHH1jeJZtB0IjnlBFA6yZJRoL1kCDQHzjlf477R/ofs8a+Fo5XXOsvZG7QwA3kJFl
 fDlxxa2j7d4s9wo8PiIP1RJltpG4SqlD86O6uKpk9Fa6dXIjjlJ5RPsA6I6R6HmnLxfL882+QO
 AwFSnaAcqcKHdyXK2VDLW7An
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:57:22 -0800
IronPort-SDR: m8MWhLly+Q/ggpFQoQazEvRAK79hMprrsJeibomNIX1/4xtKgak83IDhV3hY33IYYgETWfckla
 12cflgJcZOLhtYF332W1ZeqMwkaZsc7uQahEN2f8ydynExvlY4KkvRqWC31LBbVv2+B3KXuSeg
 s9mXwdZWg1TGYc2w+IbnJALYEzC776WPgdLPtLGdrMUnCNPoz5WeDSYQd/QZ1Y+MzxJurZd/eC
 94O7CZ/ZfohxaTfsL58Np58+H9TOWMfDJbBI8BFZ4728SkC4ncTHu1ybMvyhjmP7gPrroYjKqQ
 UWE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:13:02 -0800
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
Subject: [RFC PATCH 09/34] dm-zoned: use bio_new in dmz_write_mblock
Date:   Wed, 27 Jan 2021 23:11:08 -0800
Message-Id: <20210128071133.60335-10-chaitanya.kulkarni@wdc.com>
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
 drivers/md/dm-zoned-metadata.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
index e6252f48a49c..fa0ee732c6e9 100644
--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -723,7 +723,8 @@ static int dmz_write_mblock(struct dmz_metadata *zmd, struct dmz_mblock *mblk,
 	if (dmz_bdev_is_dying(dev))
 		return -EIO;
 
-	bio = bio_alloc(GFP_NOIO, 1);
+	bio = bio_new(dev->bdev, dmz_blk2sect(block), REQ_OP_WRITE,
+		      REQ_META | REQ_PRIO, 1, GFP_NOIO);
 	if (!bio) {
 		set_bit(DMZ_META_ERROR, &mblk->state);
 		return -ENOMEM;
@@ -731,11 +732,8 @@ static int dmz_write_mblock(struct dmz_metadata *zmd, struct dmz_mblock *mblk,
 
 	set_bit(DMZ_META_WRITING, &mblk->state);
 
-	bio->bi_iter.bi_sector = dmz_blk2sect(block);
-	bio_set_dev(bio, dev->bdev);
 	bio->bi_private = mblk;
 	bio->bi_end_io = dmz_mblock_bio_end_io;
-	bio_set_op_attrs(bio, REQ_OP_WRITE, REQ_META | REQ_PRIO);
 	bio_add_page(bio, mblk->page, DMZ_BLOCK_SIZE, 0);
 	submit_bio(bio);
 
-- 
2.22.1


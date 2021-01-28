Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CE0306FBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbhA1HjM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:39:12 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22489 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbhA1HPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818124; x=1643354124;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SCctODBcoMVRMibJjtR9kI3GnL0tVZIiIK8qwMLhuQk=;
  b=TGUe4Pc/1x3dbeHkcTL/0Rk/1RWf7L+Z4pdzg31CWfSqTpplX61wRH2I
   YhQ90yfL6YCIOQMJ8Oh6pSV+sPBkt90eUgmL2cb4K4vhkNtwt3wxjG+nf
   cgfHdLAsEFgY+avaE/1iB9SMZS9AwKJ4USzjM6+WPEU0NQxhrEFbutYAs
   cYHpM0WQF5fB7KA+Oj5/zjRYcQSgyoea3ObmiI1uLAFMfp4wdT5jN1CPN
   eCsHczmudyuh6rzh7gZFHkOkQmKJyB4ImzyguuEQnHRWmSVyQuXovGxiW
   hgGgaT2qnJ0rw05KLmLOZWfauK5mWv0nSwOqV+yEPgokO1iG3LPVvGgiO
   g==;
IronPort-SDR: XbkADgbJBn6bLZsIf9CN/f4wj7ABwJBTgZEuRARxHRXes0w/Nmxuatot6v8AFABWCJWH02hyF2
 mvD9UG6UpLcRvT2NhMq1Q5QjoL2Ciqf4jWZk4gAADbE4M9gOMpA659gkhKHak8+aWenHSZU97J
 twctV72IIoAT+Sgr6xaSQL0yxxsSVPOh1bgb5WnrFSBmj/3EuYi1/gSpoOmgX+q9zhrtpr2Hl/
 hbH8CiAJSs3vSyI8zDjxFGgyfrU6p06B7hZao0vkldk66do9VrEVI6oO00t6rDGW4/BIwpF5jT
 LlU=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="158517421"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:14:18 +0800
IronPort-SDR: m6rXUMLgWfLvaxhHzbJ73eWwS0SxAT21y86BgOnXk16BZTIeffi7b1XaeYw/30gld0maFGQjwI
 SX1i3Y/oHRIjwH9yELf3wgRrOPPkpg3CuNGSSm3w1kQIwGwtoJaus6/jnsdkDx/BkfaZS4pKa4
 gR2SyLECNq1dEXSZayYnKYLBxoy+mrX3FN1O8I/quOSgQIrhsDmsUBHSW7kQmnXiJ0noSjZ1w+
 fUlWsXQeLeWn0RZrlUCOCxEkw1QA+wJd2lRMBE1WZpeaDe/rl/wH8Qdcb5Mv+rPCwY1sjCcT26
 P4VRgKbUuqsUkQvYVtbBZM82
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:56:36 -0800
IronPort-SDR: SE/7jhzj8mUN4IuNpOkC3snrZ8NJ1clnXy6y5ds9FsX94ZBtriQ4uRa7QWKdGcnXbjLMCBoUCV
 muTlW54Qa3qPh6fwMtXMlfwP2+yfKLqOcAu45V7pI+dpenWI0L1OM9udcXtJMTQueAmHig5gDN
 d6OcRwyGrT7GxH48PliS/P58sqmLq3e242QCy6iyXTMgFXRd2EClUAs64FPFphS/GBkZYgQLMx
 xAByTj3G42kPYoeBIsWoRZMAgUwhHcuqehcOxGoJkKVhb66+D9X5hujEyFAgPHDC4Sd1jNsKev
 N7A=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:14:18 -0800
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
Subject: [RFC PATCH 18/34] iomap: use bio_new in iomap_dio_bio_actor
Date:   Wed, 27 Jan 2021 23:11:17 -0800
Message-Id: <20210128071133.60335-19-chaitanya.kulkarni@wdc.com>
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
 fs/iomap/direct-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f6c557a1bd25..0737192f7e5c 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -267,9 +267,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
 			goto out;
 		}
 
-		bio = bio_alloc(GFP_KERNEL, nr_pages);
-		bio_set_dev(bio, iomap->bdev);
-		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
+		bio = bio_new(iomap->bdev, iomap_sector(iomap, pos), 0, 0,
+			      nr_pages, GFP_KERNEL);
 		bio->bi_write_hint = dio->iocb->ki_hint;
 		bio->bi_ioprio = dio->iocb->ki_ioprio;
 		bio->bi_private = dio;
-- 
2.22.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA4306EDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbhA1HTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:19:20 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57181 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhA1HRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:17:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818251; x=1643354251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MfH3EN2qKmNoDMJp2ceJniIXfb1rQ8RA/+9VrY6oRvA=;
  b=S812DaT5dNFMTZM6mTYUywIA4Jt0bfIA9X6YyM50dVlq6vG1eBnKXeeb
   CIwXfBMWRt8xeFQfEozSf9Jo7aRuMs722dpubbdmbsgsIPYbm07F5W3qN
   N/VuJpfpvv1kNZvyMrPT/+tqO3jX9AGIpfhN0859e5ZCeimi17rCjYKDc
   ttDU5S6rtRCfxRcBt+N+v7tOEZf1es3TWG66+sekaFcEY/izQGvjeekYu
   0dtt4gQYAGeZaFjDs8j0Z326+1FC3a3+Rg1DrLpRTnJ9pTrmIB7xM512+
   Tcx7rf19iD0U64PzvqQjlCbezr/QvuDInnzibccPU87qtWWULe2d8RUpp
   A==;
IronPort-SDR: GlGP9xUUqzhnLgCrFwUyf/m0tGv3QGr3/SI9QFn+PxDHEAvwEoPKy7t+t2TR2KerGlU2Sw0ACH
 aAKbnKK6RbAWOU9HTbAUbv5wFgX1TsHt1fV09zWOIFDoG4611EX5psaC+pdMEGFhRC+s5ORVwF
 esw+W6OeDQM46IeFfVP06CVqzZs0ZWhOgGzjojXpzrLAiXHhPxnS3bDjf+R5RtOaAZq4pO9XaT
 0/podBQWLHkyvbZva2E6P1/aeHEvXYIOe/lFhwsYu020iBIMiAeGrMuQ4U0cSCYqVQgs1sr6sH
 iHc=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="162963424"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:15:08 +0800
IronPort-SDR: QIBK2IZGYxS5hXEaV3tW7htdfBWPEr6h2Uv1qKVLhlTfVSUFlbqdNlYfJFMjyJyJwDYPv0OvUG
 YbHJAnJvrRy2ZnpXjfAgxBo+RSwsdcVFRx/eGzZ6fUn/kmVF3utNLQOan6Ma/UDB70b37RUGdA
 ItNOYTNvPQmKgRdT6KYfJC/Qza4omOBXZjhgSGZGKHVnH10BMyLLwDLC9wzd+169arrvSTzzME
 1t07X0l6cZpdvvDg87KqJPN5+gMhUHgsX4W9omC8DOd/mcva75CFXDmiqWjr78g8xoH29VrqDm
 89qLFGJ4kWKIQjT1LPwCBTQ9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:59:28 -0800
IronPort-SDR: +1TgXZ9HjoaS+86zh+aLwx6S7ZpAYQ4FpPhwS5t1uQfka+31mML1LQsLKCwFYYGr030vY+BCmC
 AGfrPosPVl95WjEssU5DCDJZAyR1khEX1jpqrqTT8P7u968xhLua2/lVUN5jQ7ABVZJAwAp2MY
 3XKOPyoMsT52VNuagfol6rCenkg2OIsIErUkF58mfwGPLsAlDeR+kVK0eqUX532NsUF4ctVre4
 Iqd0vyO+udw10x//vZBdiK4usAo9yvQxvOxxYG203IoYDBmyGC3oa9VGSQBs+2yVysQ7ZPCJPH
 kDc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:15:08 -0800
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
Subject: [RFC PATCH 25/34] ocfs/cluster: use bio_new in dm-log-writes
Date:   Wed, 27 Jan 2021 23:11:24 -0800
Message-Id: <20210128071133.60335-26-chaitanya.kulkarni@wdc.com>
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
 fs/ocfs2/cluster/heartbeat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 0179a73a3fa2..b34518036446 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -515,12 +515,13 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 	unsigned int cs = *current_slot;
 	struct bio *bio;
 	struct page *page;
+	sector_t sect = (reg->hr_start_block + cs) << (bits - 9);
 
 	/* Testing has shown this allocation to take long enough under
 	 * GFP_KERNEL that the local node can get fenced. It would be
 	 * nicest if we could pre-allocate these bios and avoid this
 	 * all together. */
-	bio = bio_alloc(GFP_ATOMIC, 16);
+	bio = bio_new(reg->hr_bdev, sect, op, op_flags, 16, GFP_ATOMIC);
 	if (!bio) {
 		mlog(ML_ERROR, "Could not alloc slots BIO!\n");
 		bio = ERR_PTR(-ENOMEM);
@@ -528,11 +529,8 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 	}
 
 	/* Must put everything in 512 byte sectors for the bio... */
-	bio->bi_iter.bi_sector = (reg->hr_start_block + cs) << (bits - 9);
-	bio_set_dev(bio, reg->hr_bdev);
 	bio->bi_private = wc;
 	bio->bi_end_io = o2hb_bio_end_io;
-	bio_set_op_attrs(bio, op, op_flags);
 
 	vec_start = (cs << bits) % PAGE_SIZE;
 	while(cs < max_slots) {
-- 
2.22.1


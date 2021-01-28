Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5A3306F5F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhA1H13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:27:29 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57290 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhA1HQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:16:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818179; x=1643354179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hTRBelY7PTDZbFRPdQdHgUhYseaoF0bY2tLyF8ypbSg=;
  b=MR4/Iae6SqQcHNtvKmTIeaPfY8MBQQxd4OvUkOQeqLrkEWKm+OuRUDs1
   LdnySIasC3TGTrtsrJWwGUm6rYh7lyZQCIk9U9E1m/4gWXrbwob4ByO/j
   jJwbU5i3RRLKiW9orvE4LIWICwdtRgxFFUnJVa3oc/IDCW5EobTFBBHYI
   fE1rT8+F04QQYh1AQWS7NXawMD4jPsAtoAHCHuXvlCIvOs0SF9Acv6QB5
   xPXzcKOWPQjx6nu8+ZHl9gwKXnIa2PigBTTjWiphNFfAUiSNvh2g4Zj9e
   c7Ue4TrpQDL0SH+uWzJm7pb9e9x3+cqhh3LXt0oTu3eVShlNqG+IzNssh
   w==;
IronPort-SDR: 1iPLAwuFAvhaoaOhxIKxQzuMbC+N1b8e9fmYZtJ74cRTpEgM0v3u+i+BCmzbEw792/cHIqfGWx
 zfn9mw5ytgwqDRBQruUaCzsUKIqlE04eW058FvdQ4/5KzxqGs0kCkt6Ev1gtt0r9MXCCchD98n
 adkDvUrPSXUa61G8N1IVAt+iy72iGdt8wxBhblsQBfSfkRxF8NaDwezSr3j8NCs/hJY/+LzDXY
 BJe9Jr0SeK0bcCtU/boxjSZ6Jd6t3lyksFCLAfLNNbyjTdG1I0HQWGHGr56N3Ozk3SxiGjhIeu
 bLU=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="162963406"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:15:02 +0800
IronPort-SDR: rBLGRSpa1L4IN+0/zJ9EkmyM3Rl0LtTJDDFnCrXDZ7sHoIw4PLMFJTiWic5MpYRayvrDH9z2Ad
 jmAEjmuABBbF2cP1ntHNAlEvhHVWXr8LgHtW91GtwXd9BjBy7Tp0xxTqnKZPyts3ByEgGrVyvu
 btKHMFp7ygMctNhz6alG+uvdeG7hIVJKd5xC8uPG4IbcX0ddcdOf37KPyHaisQaw/Lk1PYrb22
 z+XMAydnNPIk9MQFen4J7pihuXouqmaTF43oaBxEJWJJsQP63UGX/c6MBSRzswgcY+AgOHjT3p
 qjjHG3gAZLbhEeg4Ain2T/ha
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:57:20 -0800
IronPort-SDR: RvbuIrKpOmmqZ+oQPbnvg4P9b6yDctCj11PDSHseFUe3NzGe7aNswGzNT7aYrNNymGc7RRLBwA
 EyS5TC5ya2f1DBzchV289rrRJN4G30R6UcKQHWHLCT1EqyVYm8BdK2p8B74xj927ubYpSXJJYX
 yqNCzY6cgWt8a45E/OUvNDiMBg+lmhS8FA2ZqgTfl/62S3ZiS0x0JS7q7oikS9hfGQV2kW1Mb+
 vR4fnDhlmPbHKapqq2eTmDAeG1Ipck513pFwPBeDtMk5IkG3qgl83KvWp5povuzxSWxrnJjDon
 5kw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:15:02 -0800
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
Subject: [RFC PATCH 24/34] fs/nilfs: use bio_new nilfs_alloc_seg_bio
Date:   Wed, 27 Jan 2021 23:11:23 -0800
Message-Id: <20210128071133.60335-25-chaitanya.kulkarni@wdc.com>
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
 fs/nilfs2/segbuf.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 1e75417bfe6e..df352cab7a93 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -383,15 +383,9 @@ static int nilfs_segbuf_submit_bio(struct nilfs_segment_buffer *segbuf,
 static struct bio *nilfs_alloc_seg_bio(struct the_nilfs *nilfs, sector_t start,
 				       int nr_vecs)
 {
-	struct bio *bio;
+	sector_t sect = start << (nilfs->ns_blocksize_bits - 9);
 
-	bio = bio_alloc(GFP_NOIO, nr_vecs);
-	if (likely(bio)) {
-		bio_set_dev(bio, nilfs->ns_bdev);
-		bio->bi_iter.bi_sector =
-			start << (nilfs->ns_blocksize_bits - 9);
-	}
-	return bio;
+	return bio_new(nilfs->ns_bdev, sect, 0, 0, nr_vecs, GFP_NOIO);
 }
 
 static void nilfs_segbuf_prepare_write(struct nilfs_segment_buffer *segbuf,
-- 
2.22.1


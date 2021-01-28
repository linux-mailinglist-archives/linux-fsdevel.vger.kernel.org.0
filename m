Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFB5306E9B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhA1HQP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:16:15 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:25542 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhA1HOi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:14:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818077; x=1643354077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5eayPzy70EKVB5mFbuCcXtyHCS4v72l8k3GegXWivXI=;
  b=M5NejGxTQar86nZSy4L5QOAVHjjG/w5TLg8xwW8XVsEyGhBgsGrNDV4x
   fFJVs12Q4SOXvq1dMmpIZtfT99iA2gQkE8b5SUzBbBOJTIjIHnPwTHsRC
   0ugSJv+E0excCh/xj6PxDXbScOmVFk9HOoyQ5A5G5yqwYj6SIPNgWDC6M
   EERyn6OzuKQrWJv2v7NKN7TR9J0hu4FiRWV9GE2UTdHLCTyqrU96GzLzM
   gZN8jjLMGi4YNR4Az8FtLCHM72Tw7GKHDOqUHuWDGwVQd2oEZyXgbKDsT
   pMqGSZVt9UiH2VpsIQMeLTi6VpRGXY+n/d/805SqiYPvcHN8PBOkAWQmX
   Q==;
IronPort-SDR: +lfvjmDL+7NyqSEDH8PBNuE0lBb5jjbNrkJ/lUTvqNrtuR5NjNvigyGg6VGHXtF8/jqCOVy7kP
 YRg5GyBaSwRxG559odnXIzpkybnqDnBaoATtlS0gn2/WJ3CvbfRqxLLHQa8asRuc78A/PlnmYz
 l4qhbXXgAbY1FOcUdinBdiuoiAfW0cuoDTWQG7AY0LqTVKVTJ5dk3G4gWJI71G09qMc8dQKxjg
 dSap4xQNCNHlbJXs5XGIlPbVDIzhq6w87507ZHUwjoyTG0kRtno1qwMIWprIpxqo/oY5GoxHmn
 t8E=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="268892470"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:13:31 +0800
IronPort-SDR: l5eVFBQGPYZIdwtgTrOlivEHQ4u9Nw6/Gl+9AAhvwHfvWFVG+nCog76rxTCho1ENBUA4cSJd81
 l5lnYVRJoP1EGgMYUKTxZu3YXWzHxVmz0qKAoFHfK8TxjHDQN6wAhte4BkRYaF30xvJ6Eq1NTD
 iHWlphjKIwvSwPAC3uYdj/iC/K133EoQ1ay+rlGmxcqHuFRwoODKSggzp1a49TXRJLNeJKtzyz
 yVeDopGGk65drRI/kFS1Tl46/tdriumc4kxyWhlxOWQ6s/PabHU4RM1ASbFACNzGRNuf3iVl8s
 05F91hwAr/2XWUw1Y9NHjSIx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:55:49 -0800
IronPort-SDR: VOVmzSzF+PFJ5cIlwEfer9zopXRJVevtkqTAdV/vkmWi5tqY25x0d3LuGTyYENdxWXzay1z5UI
 3lglUXeUdXrgV2kjosRDVsxHgPX3JmYCMkybSp7dVFiY2NtJizGeP3Ns2Zua+ztPSx29L5AtLA
 s1r4WqMcMEF5NenjfW/yptNoTwylDj+qb8oKvyina3WsNVkg0wovZeJk89NSPRf5yUzOMPXVB7
 hd4QqToWmHIoH7o5yPqPfXS+LYwCHRus+XuP8hoEESu425XNxiI+t6Xi0EnlRBN9AYDyemp/IQ
 NGk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:13:31 -0800
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
Subject: [RFC PATCH 12/34] scsi: target/iblock: use bio_new
Date:   Wed, 27 Jan 2021 23:11:11 -0800
Message-Id: <20210128071133.60335-13-chaitanya.kulkarni@wdc.com>
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
 drivers/target/target_core_iblock.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/target/target_core_iblock.c b/drivers/target/target_core_iblock.c
index 8ed93fd205c7..f1264918aee1 100644
--- a/drivers/target/target_core_iblock.c
+++ b/drivers/target/target_core_iblock.c
@@ -379,10 +379,9 @@ iblock_execute_sync_cache(struct se_cmd *cmd)
 	if (immed)
 		target_complete_cmd(cmd, SAM_STAT_GOOD);
 
-	bio = bio_alloc(GFP_KERNEL, 0);
+	bio = bio_new(ib_dev->ibd_bd, 0, REQ_OP_WRITE, REQ_PREFLUSH, 0,
+		      GFP_KERNEL);
 	bio->bi_end_io = iblock_end_io_flush;
-	bio_set_dev(bio, ib_dev->ibd_bd);
-	bio->bi_opf = REQ_OP_WRITE | REQ_PREFLUSH;
 	if (!immed)
 		bio->bi_private = cmd;
 	submit_bio(bio);
-- 
2.22.1


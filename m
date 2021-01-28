Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38391306F24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhA1HXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:23:44 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:20080 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbhA1HRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818225; x=1643354225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NNQh//SoJS4GqMqJS7HaqIWs/nAFaMjGpU2K0hvKGW0=;
  b=gvfotP0RwFBJqCXqMZ+ZKGM191kUg25EU6MK8yv3WQ0V/snj6gO89p3J
   h+XgNTXnBSDKn9sVdo/brk4CHsYcfR1FHgktQQwmxZcRXPYEzGIiRr5oL
   Z8v7fX/DrdBbZaJz5SD2hdvN/QJljTxgqDFPAn8eI3LX5bw9Efol1ifGB
   6+HIiGLTfey68aJ8RuZBvtU0pg+Pv5Kl8aFoAWGw0HTdrhhw0z/9BT6Vc
   GHPVDh+REdiUHiEqaJS2LO04+EQUiJ2Ae5MH8NovD0So9om9Bvz33AZfB
   X+qCIg4TQeU6pbiwX2uy/39s1GfxEOmDtRUKzIQNf4PIlH/sCDqRHm5ya
   g==;
IronPort-SDR: T8cN/SXMGXs01AM3btMmAlP2SoYkUicsWVAABXP2iQU2x8JpoqKTUJx1q5qphxJjCMBNKk/IPP
 wcodnznz7X6ITvHGg6I4G9xwDnZbaJVvXmFLn+Nj482O/ABalHVq1f8x18M4VpFZa77mrfTBo0
 MukhsN1D8OeDHOtVvD2LCAoH3bwM3fbduBL5+hFwNkixJGxih35xHNpMt4QB8nxooz9Z++wY6t
 zjUUuacLny/qIwc5aOeFlEEj7Aid+scIfUTbneyQtWIpa49b2M3P8kMH/VvA40e+d3WWaqSvQO
 P+c=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="159694047"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:15:48 +0800
IronPort-SDR: qAU03RrSdOiwnJjFFrvvUjM72ZP2hpgiroryL03FcPC++SaJdvC1G7sBvSLTTocT4Dp5GtXvYN
 rSZAWUUD3qQA0AVRYNz0VCTqYAB5Dwjne34oC7XF65gdeKx9azUnSeSZRqyc2cOvrdg9+iyLt9
 QRxIlkUDki5MdLOPS11ob0V33gSuhsD3vcnFN/21chgPF38p1HwsH6Kglgjb0D16WCUthYpL/7
 cZJCU5jYvyEG0uk46CGNddwXNqPr37v8nU/TvbY+Oj1DwnI2WpGje0RcWVBZzUS/Lo5LUs4Qcd
 o7WyY60qBjCA7BvtTcu+4EoO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:58:06 -0800
IronPort-SDR: QLHAdyBGhpMGQ+9sBMvXF0omk88B/E7BRqUoQLtstkadK8XTqcLBOvZ/pjpZSQe5Fab6+IJLIs
 ck58Xl2YqFxcQH934VbGmHAxVZYNpxUZEqIAo35K+cwpiHURts0rCHDJ2TNufJwwd/0szVEfZu
 V2kbFpOqLyVucrhtvqpRhrkBznCSCkx3a3rZqsYu2xJ2ZrJKihugfXyvxYjD/F6eNL2QYyPhq5
 GySOsYgZ6Jfrk4o/qsLABBe1b7+pVB/jDQ0aaMBZEhc+3I3KzSll4D3O/V1q5DDbYD+ht9Zxf5
 kSQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:15:48 -0800
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
Subject: [RFC PATCH 30/34] hfsplus: use bio_new in hfsplus_submit_bio()
Date:   Wed, 27 Jan 2021 23:11:29 -0800
Message-Id: <20210128071133.60335-31-chaitanya.kulkarni@wdc.com>
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
 fs/hfsplus/wrapper.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index 0350dc7821bf..8341ee6c9b31 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -64,10 +64,7 @@ int hfsplus_submit_bio(struct super_block *sb, sector_t sector,
 	offset = start & (io_size - 1);
 	sector &= ~((io_size >> HFSPLUS_SECTOR_SHIFT) - 1);
 
-	bio = bio_alloc(GFP_NOIO, 1);
-	bio->bi_iter.bi_sector = sector;
-	bio_set_dev(bio, sb->s_bdev);
-	bio_set_op_attrs(bio, op, op_flags);
+	bio = bio_new(sb->s_bdev, sector, op, op_flags, 1, GFP_NOIO);
 
 	if (op != WRITE && data)
 		*data = (u8 *)buf + offset;
-- 
2.22.1


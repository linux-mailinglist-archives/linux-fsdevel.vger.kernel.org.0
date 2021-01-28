Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CA4306E6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhA1HOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:14:01 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56994 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbhA1HNX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818002; x=1643354002;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H5WYNiBvrNWIzR/dDsyAI0RzKPxZxlDuB4vWYUDlMrE=;
  b=Iim5nwTGI7yhSjWqgCP9AnvImgBcpQAxBkfzAuq0ppTUFAIPudxpDELI
   L08+VwxtTU7Jm9nC402MDzUtPP7EG6W+wY7om9GQdWFB7wf84s3GdChjh
   pcTma2sUSG/2knixQKW38Ci5GuFAnPvgMaRKO+hMswAEQyUGOaYv1H1N5
   ZQyHbygrBQbaIF568wGBw0jHqD19TAI5KPib8Sm8j0etT5ocqkWUvh65d
   k1nuA2ohR4/a/0dkH2NbFgpn7QrlqrU1w1YAISwwMi8dzm95pRgzw+5Kn
   xMHT8QCW3pHydAEfrZzF6yFPkjbBqwUbEgngzq3r2Y3iwpxUV2FFsSHpR
   A==;
IronPort-SDR: E9JrzyeQqe1pQFSde2SOQOK0XNlbDCUvLxewlnS1WtOFgxiUtsKegOXv/Mk3pz30DVu+yQBvUS
 UHCqVUPHXlFiYZ7LBFVTvMIvK/WtSuh7miKHhwAvehpGByCK5berzCtGLhphias34o15GcZKLA
 AcCe5g+pL3jvKhh+98SCfRtTbkF5cX2Uv99bemWfo6KnYMtuUNDWsydXC86vPvAj4OTavgFbN3
 u37jr4rHTPwu5kiEj0vLZXT/488OtAjjfKZ/lUCVylJM3JjZPYT6CDp3ZUJdxH/S1Zw+2zO0DG
 Xmg=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="162963137"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:12:16 +0800
IronPort-SDR: 2pclH1G0KEXMBdYyJXwGIaiNxvPd8YeJd7/cw8NzdW/uA4XEF2scdf7sw8QvdtcnNzWWhRikAO
 rWD6sAP5mbN4ArPNu1kHS9i0WXu+Dt7wTDtCpGgIsdzUH63GucwPYvntzjU2Oz80TTe60grf3T
 OB+yjfwhmnzJaQo4ASI9jMkEXCQePbbFzD/wXC3yyPl4PlujZsT4Avyw2edMGHmqh2ROTGWZWZ
 Q4tOYIjAALAIwRmgGTAIbGFo0FE6LPaiNqvWkgFx5oE65sYn64X5y9P60fQsy3Xk2Q9aqObdv7
 x3ZbEeUVDgpOBVOT/ms9aKtB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:54:34 -0800
IronPort-SDR: sJ1sB4+NIXrk86BqB2mBiNRkLb2CtaUtTUjLUptuVolKqncgiWgms0hBmEnyXBHOe2LGJgTWAc
 Mtkqx7/Ji/KEF3P2zVgoCc4AZmvUpaw07sB7pwwqNDwBZIjeJgdIawB6xDKz7hKZuinbJ6FPFN
 v+digmuqEID+qvvg+Pvdb6mLkPbYX8es6TqyRNtA6iTBnQbrstI0JA9CgrvLf0RhQ0DnF83KdI
 QwpSDAYi/vWthDgyxzldo4sKChZfQfmY/MjRYeTOvpJG4q5JRSujoZAO3KJfZIMHz0OJMVK9L1
 YPQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:12:16 -0800
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
Subject: [RFC PATCH 04/34] drdb: use bio_new() in submit_one_flush
Date:   Wed, 27 Jan 2021 23:11:03 -0800
Message-Id: <20210128071133.60335-5-chaitanya.kulkarni@wdc.com>
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
 drivers/block/drbd/drbd_receiver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index e1cd3427b28b..b86bbf725cbd 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -1277,8 +1277,10 @@ static void one_flush_endio(struct bio *bio)
 
 static void submit_one_flush(struct drbd_device *device, struct issue_flush_context *ctx)
 {
-	struct bio *bio = bio_alloc(GFP_NOIO, 0);
+	struct block_device *bdev = device->ldev->backing_bdev;
+	struct bio *bio = bio_new(bdev, 0, REQ_OP_FLUSH, REQ_PREFLUSH, 0, GFP_NOIO);
 	struct one_flush_context *octx = kmalloc(sizeof(*octx), GFP_NOIO);
+
 	if (!bio || !octx) {
 		drbd_warn(device, "Could not allocate a bio, CANNOT ISSUE FLUSH\n");
 		/* FIXME: what else can I do now?  disconnecting or detaching
@@ -1296,10 +1298,8 @@ static void submit_one_flush(struct drbd_device *device, struct issue_flush_cont
 
 	octx->device = device;
 	octx->ctx = ctx;
-	bio_set_dev(bio, device->ldev->backing_bdev);
 	bio->bi_private = octx;
 	bio->bi_end_io = one_flush_endio;
-	bio->bi_opf = REQ_OP_FLUSH | REQ_PREFLUSH;
 
 	device->flush_jif = jiffies;
 	set_bit(FLUSH_PENDING, &device->flags);
-- 
2.22.1


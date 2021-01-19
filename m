Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288402FB257
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 08:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbhASF3Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:29:24 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56996 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389475AbhASFLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033107; x=1642569107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SfOR1N23M96OkPDJoP/n7nGLStD8Ilx5NPXdrP89w9Y=;
  b=YyX/u76WNO0pS65R5V48l3IbniQIqglCDjrjWSJ8eM9sZ4glxuIM4nTH
   4VAc+KzDpmfAnmDDYL5CMMddG6S43+wmxogcZ+6GYDTsB0Lb0NM+YK8R+
   WBDne7erIxu5yY674eSQd0H+qC6wtZWndDWiK76YoMBEiUBzNyJnMjyJ5
   dTpiFubZ73I9ZcLU3lVRzDt4EepcucrPjj+cfFGRcJnoe/LCPg2FoB2cU
   CIJwhpJh4WMS8fgdyKlM6zg7VWnOL0Wo7yBiDPraq2ccxsFeUDypgymcu
   Lw7TXNtj+KCcn7MZYSGRNmF7Ma0CMpdaDpGBXZ9WPwWbqSgFBd0wmeFR5
   Q==;
IronPort-SDR: HQTgYhAoZ4tYd77NZiLK3COP1sj1lPWeSOsm4X8wrg1DXUaPjgx6qglxqbQTvYGvdkhltImUnM
 nucy2TBgcqhz0wAeY0a1K6Am2erZqHeL+twXPsqLQrfJa21epcjCxlfN3gyIinjeWnJeWom9My
 XPRYxPbrtNuXNllwOd+Vb2Nr5Atnzq+44RLVGwe+ZWxNzslII+si6PumPd9BAEd2WVxadqM7cM
 N9yqz0lHnMdXi2MXKLMjPiugKHCRVCHDudMf65fXhDk5zMtDF7LJSC3K2U9Zjga0xf7C0XRG0T
 H/U=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="162201280"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:10:26 +0800
IronPort-SDR: VRpUQ6wr/8EF1IU6Nn7pfiDajyMpa3mofqiUanwTEd3E4H9Zpf3CLoS/NSRdbnZwXBE82bqYSB
 VcgyUqaKArnAa9SNJJnOheS323EkvDXp3k92Chbfk6KikpCPC/76w49UT4vjP+jNQSEKzqtcih
 D+tQeylXncn10aYSHgm/1g/+3uqGhPlqvicMqpWnT+/8nMYU+S0L0tUAKWXzmO+cbUHABgXD4x
 Fv9CZPFtRuUoNBknUmUOpsegXugy3uK2htDrwO7CpcMKoR29LHuD8gsaLjvoVTq9ay5GdaJ/y6
 ZXqHHKzewSxqDnwJ2CJcqRwc
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:53:01 -0800
IronPort-SDR: g+cwRIOSTQKlHz0TlzGiv0v8k42MLuyBePoSPu+3wmyOXSjTG0meJZ3HNMEsZPrUSxEzx4+lF4
 FYsGsM8Atqm4KFkngm6kvE4QJEllDZ5asdg1mlTg0nU6MTigdf/l2fufhP5Dl7cUEXrLWJHA4M
 i1hr5sj5wFf0lV2dBD1wzV0FFnhC0FI0FF05HNG+z9KgIFkwL1XTF/q4l1wSPXPSYwzrtYoVOq
 9diXh4xtcenoTU75CyxNQYMQeVt6zVGgTEkE1aGBQ3BRhKLM/ozH18RVsbfAAMJYj8MbBfck/x
 vIk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:10:26 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com
Cc:     jfs-discussion@lists.sourceforge.net, dm-devel@redhat.com,
        axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, efremov@linux.com, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, snitzer@redhat.com,
        song@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        darrick.wong@oracle.com, shaggy@kernel.org, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, tj@kernel.org,
        osandov@fb.com, bvanassche@acm.org, gustavo@embeddedor.com,
        asml.silence@gmail.com, jefflexu@linux.alibaba.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 32/37] eros: use bio_init_fields in zdata
Date:   Mon, 18 Jan 2021 21:06:26 -0800
Message-Id: <20210119050631.57073-33-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/erofs/zdata.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 6cb356c4217b..f7cdae88982a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1236,12 +1236,9 @@ static void z_erofs_submit_queue(struct super_block *sb,
 
 			if (!bio) {
 				bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
-
-				bio->bi_end_io = z_erofs_decompressqueue_endio;
-				bio_set_dev(bio, sb->s_bdev);
-				bio->bi_iter.bi_sector = (sector_t)cur <<
-					LOG_SECTORS_PER_BLOCK;
-				bio->bi_private = bi_private;
+				bio_init_fields(bio, sb->s_bdev, (sector_t)cur <<
+					LOG_SECTORS_PER_BLOCK, bi_private,
+					z_erofs_decompressqueue_endio, 0, 0);
 				bio->bi_opf = REQ_OP_READ;
 				if (f->readahead)
 					bio->bi_opf |= REQ_RAHEAD;
-- 
2.22.1


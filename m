Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91242FB05B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389604AbhASFZA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:25:00 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34587 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbhASFJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032947; x=1642568947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M0Lda0zS+SL7SE0DDozfWug6B1E4kFe/5QgiyTYkgeo=;
  b=gBKkty7EvKEuqb71GF+ryOndspp3GoZHMNe9hlTMGz0Y0px3wKg5Xyoc
   /U0sFq86W4Nv6bEOVEmfFAsKyg+wroj4jvMh97mRk11Ev9nAbbz8GnNim
   I7nRHnNmcYDo0k2VZHA+GQUaQrs7s9HCAta1S1hf8Q4lpRH0MuC5o9zfY
   SshxQn71654JSyFFn5F5cAOheZUdxn9wTqiVL0apAzHvhPR2LSFoH7kM1
   w1QQm7FFPCCN6Fq8cRIa71hdOndiFPsN5JQNAc1Nt4Yj5ISeyZgJJrn+V
   +Wg0xwB0w3nz810rZ2JFK42q2HzKi7co3HsBP4Mi+z20bZrlBnCqdRlNI
   w==;
IronPort-SDR: UQWruiD78H7N4Gkqst/8tOPl2dR7Ggxtam5DUriWi6xcoodRN+tvxqacOU3dOhfPiuUHuxclAQ
 73z0Q8nmhI+a3ldbRXrfoDbLHAm9Sx8E+O1CsUdqOkUzQBsmjlyjWd/9mp9bMS/cqkV4lD2MhB
 LsRymbgHALot1Dcjc6HK+E0Yb42MTP+nPHogAblwKJ/ecxRAIBbIIqNNKgkimVFOhfKvTTo25S
 Wb+axlef6NsO2TMdk8yMTWnYu3MBBJYtUAIQ3+BpI2ptLEEE0GYb8Lf9IqZCeS6183F+LTL+WV
 bDE=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="268080941"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:07:19 +0800
IronPort-SDR: KiNvTzdfh0qM0zmFbJFhmfQuJC42fBwQJLXltFbmaLB1OvXxwaGf/DXulHxbdXwgW7ghAgQEwb
 8lxDRDInE6vhwk5bie7sDgShBORVrt7eBsloUXTmMLsXgS32KbSqhxwZbOjQ09LciyRS3qtGgj
 9puiFwua2qXS3jervxVR5ZLzhP8VfChUP27ovMOQdFaU+1/MrEy7OwoVbQPVFojgqmqQalGnvG
 LJPyUh7vxSVHNBeJsMtvs+Bt705eIBKWECRsyGkYLrQQFqfCmvqn5kUwvOyMPpZoldE+Hzw7Te
 wQ5wz2ue31xkO7HgDJ4V5Xe8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:51:56 -0800
IronPort-SDR: QBnDS7DVrddQpcsFsBzx6dUP1vCou2zr2+U/E8LncZi1HXSOtDax3BLEkAh4fkXsMSmQFWPGFy
 i9c3j/giOOU39nkkPY4ax6KBgaPpzPJAoufKOchG2Ou0rmyaYFKJUhk8ZPDWpGoP3x51bQeso4
 ExxBU/jV033SF8Q+teRhuDUjl9XHjbBJkEt8Ba8a4jICbdKDHOxkWO7MzEPD0dB8h3reWZeWBh
 KVK+JCC1W+90P0+/EdNiEnUM8xRZsi0+PwhkhSGTp7e4x6m4p6jDgQlTHPkRvWkNPGtHl7ZAoZ
 Mec=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:07:19 -0800
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
Subject: [RFC PATCH 06/37] gfs2: use bio_init_fields in lops
Date:   Mon, 18 Jan 2021 21:06:00 -0800
Message-Id: <20210119050631.57073-7-chaitanya.kulkarni@wdc.com>
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
 fs/gfs2/lops.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 3922b26264f5..9f8a9757b086 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -264,10 +264,8 @@ static struct bio *gfs2_log_alloc_bio(struct gfs2_sbd *sdp, u64 blkno,
 	struct super_block *sb = sdp->sd_vfs;
 	struct bio *bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
 
-	bio->bi_iter.bi_sector = blkno << sdp->sd_fsb2bb_shift;
-	bio_set_dev(bio, sb->s_bdev);
-	bio->bi_end_io = end_io;
-	bio->bi_private = sdp;
+	bio_init_fields(bio, sb->s_bdev, blkno << sdp->sd_fsb2bb_shift,
+			sdp, end_io, 0, 0);
 
 	return bio;
 }
-- 
2.22.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C06D2FB3FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 09:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389622AbhASFZH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:25:07 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63871 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbhASFJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032947; x=1642568947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jmrSa8deAEe1LJieS4GwadhMznrvItaU1cHEcGf0nvk=;
  b=AJ+kLfsSJ4s07yDnlseG1ISGGXpWVyUnFL49c/GKPrU9mkELI+wPkQgM
   k0Sr307YGaCRfbszrgkwae6u4u5+PF2WExHyAS4niMtdGlrMpa96wgYxX
   3B0iiRd5Lc60P2FsQOBYgGRYjZm9V9hMjqd4Te2OvXkHRwWVSZtNQJOJB
   JNXadhODsrLaKmZNKUfkCxPlcFBeFKDpkdXVEYsoMyhMUgE5f+rz/FEOZ
   QrrGa3U4KHbx5KQn9l7nbpESN4LFl80EcDp8IwgB9ACrppt+nwnD/2f8Q
   3T2DuSkwQOUY4qLxFZUMpfozg94uu1qvD1VFpy0wfzT+/1zw6lapxdyl6
   A==;
IronPort-SDR: 9IH0QRgyJGceub+HSw+OAYsR5g1UCjXvkRmOE7pb+OJfE20FELHvx3qtZPekjvtw1i86u9sDa3
 Wd0vMOjW/VERMIeI5SKgiRawxhPaPi/nZJw5T3lIfIG+Vk3Auy9ROAiUG3v+gA4sqD+fkQ5+ue
 JEhP0wVRB4xHIpobUtJZSI3/HPc9vV3NoBDJQ/aTDYgMjsXV1LJFK1j+d917YlZJLeZVrdT5zd
 1sCjSjLnqohrvTxj99NK/iKEHCJgpMxZIsRb021sQpVIGrQQSIKFfY+Lw/VPCAO9vMjo96CS2G
 1dA=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="162200901"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:06:57 +0800
IronPort-SDR: kcItOcwBlllKPIE0vRa1+mRTFZtJJbvDNuhgcrhd9IY4m04UCBUhtKuaMVVVeVxRMd6HO5zug3
 NgoC8qBAlLOMdyKTOOvvsgp3JuNwOZ07vKUS8lQ6idDPGzTYsTX+PSMu7GqHzaa4R1uPAE8ACO
 Ps/fy9eWrwsAhY7/XR2JujFhlqthtEncw9UDL1Tq1zwcd2Mpn9k9H7jHVp7VmhTh+3iq2/8/+D
 rf8Ne1JB2PAWp7CI29odNbqyNjraTVnhvazDXd+z11HyHdIIDMYRdWDlzm8FelWaFQITFdCccg
 pwvzAfSCO3v9OcNpwX+7iJEC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:51:35 -0800
IronPort-SDR: 2QvgFwKv1l58qACx1LkMFx25aQa2SIK+nja25KW+g1fGCIsFCI2aDBEoSVRt5vd+mstvmW96a+
 737tI66XYa3YGuNZc7mhzaBx90mzE+7INtx21d/7HVJL8Fs4lXsY46xoeP6qPWvnDZ3ihPj4yc
 0PHxNbwk5lPXU8GKWjmU1O8sK8W4HyOAc9WnAAEnbKb4wGAIm+2gNrXPeVygtgzGsA4DXXJ+Yd
 mrqI036gzbWwtshapKuKgeKERGx47y7vTXELUquL2fc2urlWZF3SUiFLdWMNhtGfvEB6B//WSB
 xEk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:06:57 -0800
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
Subject: [RFC PATCH 03/37] btrfs: use bio_init_fields in disk-io
Date:   Mon, 18 Jan 2021 21:05:57 -0800
Message-Id: <20210119050631.57073-4-chaitanya.kulkarni@wdc.com>
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
 fs/btrfs/disk-io.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 765deefda92b..9a65432fc5e9 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3637,10 +3637,8 @@ static int write_dev_supers(struct btrfs_device *device,
 		 * checking.
 		 */
 		bio = bio_alloc(GFP_NOFS, 1);
-		bio_set_dev(bio, device->bdev);
-		bio->bi_iter.bi_sector = bytenr >> SECTOR_SHIFT;
-		bio->bi_private = device;
-		bio->bi_end_io = btrfs_end_super_write;
+		bio_init_fields(bio, device->bdev, bytenr >> SECTOR_SHIFT,
+				device, btrfs_end_super_write, 0, 0);
 		__bio_add_page(bio, page, BTRFS_SUPER_INFO_SIZE,
 			       offset_in_page(bytenr));
 
@@ -3748,11 +3746,10 @@ static void write_dev_flush(struct btrfs_device *device)
 		return;
 
 	bio_reset(bio);
-	bio->bi_end_io = btrfs_end_empty_barrier;
-	bio_set_dev(bio, device->bdev);
 	bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH;
 	init_completion(&device->flush_wait);
-	bio->bi_private = &device->flush_wait;
+	bio_init_fields(bio, device->bdev, 0, &device->flush_wait,
+			btrfs_end_empty_barrier, 0, 0);
 
 	btrfsic_submit_bio(bio);
 	set_bit(BTRFS_DEV_STATE_FLUSH_SENT, &device->dev_state);
-- 
2.22.1


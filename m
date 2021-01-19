Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE6A2FB0C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390488AbhASFaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:30:46 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51811 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389700AbhASFM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:12:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033178; x=1642569178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aM7JQIyW0SiKsSN5jKrINUGLCUPGl+Twv+vS/lM3j18=;
  b=I+0R9kFTByjN8HhYmfs2snGrda8O+EleMIdOgAMcJGfW6b40ZAbVamia
   eieH5+tsDZz/8gNjGejAcOCkTf4sShA42hLoZuItXUjwv/0ZndClBqWc1
   6rEcHL3oO4e2SZd8pvH8zU4hvSCkfTB5HlximWtzaLm0T0sV2E3qvYH+1
   qMiWTxtZ3zc3a1oz+oSDzoV4QKILHJ9TESREbDvpP+K0usrEX3rHYYx9p
   1h9GrbyMv83RDMuiCnhPKE6qHZIDnBI9YUfTNxaJvGPc4vCd5lQgYpDZF
   jauDIQlNZ0ncGeglEKLL0zZknUgms72YtQ16T4hZbxzjNJbU+rvisjPs5
   w==;
IronPort-SDR: WmLlzAFOCCK7ebyOIFjPaJxTBseeb/A6EOI93syS1UhhgBGkFyfek12qu1gNMzWE0H3qWgoA23
 WiNqLEJ6ZF7SewyaC1E25ZE3cSa9ZzXoXPFnc2wvy+NezfIbr7/kE+pIvUWdenkLHlus+8bHsD
 V9a6vEapvtgANSMYpDuZK7w5DlH0z81gDhaftOJ+IyQhig/S65JHC30aL0joTvKCUmkPhrcn35
 byTpFYd5siD1vNDhpCo48Q6qA4HIkAYFKoXxSA597TAq1GxzUYzlJZyN07U9XTM/8xKqTklrbh
 B98=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157764092"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:10:41 +0800
IronPort-SDR: G/wwn44rqxqM6nGo5TO3sRS8YTPeKYm8qIfwmtXQQE1FzKPlE1QM+hp3zez0DOTDGlyqBCbmko
 Uwa8ggIAxucx0Hgf1riU7XZcHseJyE2+8tjEXuTJaPZNNXazrWvxKuqqSd4l/deYRIIrYqEjDW
 upX5HtT1YQ+I4K8SnnbD5HNMtSjjPF1IDAtvW3VKW0dzeRVDYDvq1PTwVM5mFc3WlZ4+63Vtau
 7aI0ir3NtpmZpr1d/0oeMfZtUenOlggVtQtGuRxXDyRmPOUVfRgCZ974aWkyXKeynWazuZvjaL
 2RJ3z89UoZrWz5ZyKsWAdJeb
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:53:16 -0800
IronPort-SDR: oklSZwC4T98igITkHvUN5/cFLVu1yS+dVuRFw1rj6Sypghilpv1dq004ftoRiIcXr+1cvb1C+g
 e1+GCw894PQkPu1QcGSBSC17BzbJVdUoKLEKnb23R5ToJPinuljlR2aaNZBBxuQfj4BqaudRJa
 XDGeUKlYGqrX0PkiJf+ZiBwJ6Ik8t4zeEDjdqLOFU05xrby1lNOvGG7JThAaPObtceSdxUj1c7
 /m5QwBatTkcZcWmVuIDWjsPnj5ACeHofJxm9d2p07oDQHlNegcWml37RbpxW8gEnNxSajg/OqB
 c4E=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:10:40 -0800
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
Subject: [RFC PATCH 34/37] nfs: use bio_init_fields in blocklayout
Date:   Mon, 18 Jan 2021 21:06:28 -0800
Message-Id: <20210119050631.57073-35-chaitanya.kulkarni@wdc.com>
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
 fs/nfs/blocklayout/blocklayout.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 3be6836074ae..7ac96519c8b7 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -128,12 +128,8 @@ bl_alloc_init_bio(int npg, struct block_device *bdev, sector_t disk_sector,
 			bio = bio_alloc(GFP_NOIO, npg);
 	}
 
-	if (bio) {
-		bio->bi_iter.bi_sector = disk_sector;
-		bio_set_dev(bio, bdev);
-		bio->bi_end_io = end_io;
-		bio->bi_private = par;
-	}
+	if (bio)
+		bio_init_fields(bio, bdev, disk_sector, par, end_io, 0, 0);
 	return bio;
 }
 
-- 
2.22.1


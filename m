Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E7C2FB407
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 09:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389466AbhASFYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:24:42 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40916 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbhASFJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032947; x=1642568947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xUOVrFleGb+eYEs5Yq2ctnwrCXH8hkiRL46tj+d0DVI=;
  b=SgerIOQY1u4ZuHb3hrgXlm89lRSCpe4nyZChcPEhOVKfq07WeYDpFdHI
   dFqoTs5v9ZVyRx/y5NMqcnO4qSFcEZpS9vja2r9nmrWVvD62Otqwsst0d
   s3X+01h0/O+62uvplmznRYDkDgVzSgevu609gQWB9AC14WFvPsRQbdBYj
   jglpYpcR43Bi5g+WAFxkrEhOUC4RX99dnUhe2UerabUp/RIKhje0Du17P
   nbduwlIc7HO/aY8NHl51ZLZvsRySueJYoDwXS1gpdNqT3fjF4U1GCDqE1
   E3VTD0HIrCJZbIyHz5O3Tk9A2T6MC78K0ejT7sGwbTMdW9geuc6WHvS2L
   w==;
IronPort-SDR: n4OZNf/d9ls/PledLjKpOa1ItGyRx/+Cs3F2IzQV/e413ntRum4xgIf5gV2kpTve3o6zxr2E4N
 o6fDNHVDoOdEnqe5acXJZ7UfRzfN58aZ7eDJh0tCjYeFGYK+KlN+sI8aQgnPhk5uoS9UEZiM0a
 c4kWW1cLimsojsw8uxd9qMILsVL6yv1QsAWr3SeXbRwRBHTowZdck8JfsVSuW7OxSz7XKQqyBd
 w78h0s9aMT+wv0tylvjObPfjA/pZIUKwVzGGOu7atffk1kpkUQzhe26DgnWUmvBjzpLb6DBSvQ
 zBA=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157758552"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:07:40 +0800
IronPort-SDR: kv9JJ63tZBM+0AnBjYhE2/cqh45kPVjnBFND+rTGrXRd5b1PD/gjKHbTAv5xI/BccPnpZj6SZJ
 sTliytzWisL1tnXx9uFEqUhx98fR7P/UDK6px90mBtN2ZqeBdFHn651vC4vusLgHtWbiUD8Uhu
 JN0w9fS2n46H4KAe7JzdHD7xIYr8f+zJmipMIDuL7kqIkzOpGlRCyNxOSHDXSPiq2Buma2dYqP
 /vZIUHSOrTH4dqrl8bFOIi0mhBJe2reqgmoKTevNsyWekbJu/m37n8U7MFnyyrt9Dx6GpN8ovK
 ud+naIy58NZiUYfz5YtowXfI
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:50:15 -0800
IronPort-SDR: TM9dpxhc1bBjOypQU+TCA1+JHS3X6tbyUfX7CLJp8sH85tB99xJFscHBDCLFq2/sTR23LiC3TM
 J8KKwbkNN7jjvKISe7zzGqpFWELclGi38nUt/LvFQapcIN9YFp8DZRQ2izF3uYGZWxHnRIgtO2
 WhlQFVHRjq0w2Sygnwa63xoEK9fTLJNmudOASmzr+o1zZ38TO1TOJzzBzvspEDTXWPVaZigUus
 O1/x342A0NXQzCNMPt4Ly8HseHr0drZDIxn0r08WsOUedcj3h8TiQqY/1oiIV4nQx5hppaJXgU
 55M=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:07:40 -0800
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
Subject: [RFC PATCH 09/37] iomap: use bio_init_fields in buffered-io
Date:   Mon, 18 Jan 2021 21:06:03 -0800
Message-Id: <20210119050631.57073-10-chaitanya.kulkarni@wdc.com>
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
 fs/iomap/buffered-io.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 16a1e82e3aeb..d256799569cf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1222,10 +1222,9 @@ iomap_alloc_ioend(struct inode *inode, struct iomap_writepage_ctx *wpc,
 	struct bio *bio;
 
 	bio = bio_alloc_bioset(GFP_NOFS, BIO_MAX_PAGES, &iomap_ioend_bioset);
-	bio_set_dev(bio, wpc->iomap.bdev);
-	bio->bi_iter.bi_sector = sector;
+	bio_init_fields(bio, wpc->iomap.bdev, sector, NULL, NULL, 0,
+			inode->i_write_hint);
 	bio->bi_opf = REQ_OP_WRITE | wbc_to_write_flags(wbc);
-	bio->bi_write_hint = inode->i_write_hint;
 	wbc_init_bio(wbc, bio);
 
 	ioend = container_of(bio, struct iomap_ioend, io_inline_bio);
-- 
2.22.1


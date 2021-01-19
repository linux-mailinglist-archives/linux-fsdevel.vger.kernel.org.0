Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986882FB403
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 09:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389424AbhASFYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:24:36 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:33649 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbhASFJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033608; x=1642569608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HPCbLSlGMOVA8XHM+WRUVNKbwgmkWpn/wLxwGOm9s4Q=;
  b=RPPlvozoDCJdTVns1KcZSaHPam9OVBLhva2mfs8B69vt6uDjHRqXVQD7
   QaKM8lyZRvhzWY+Y2qLi3jv+u3GbtQi7qGxrzp2cG0nw/y5Bod0RJiCxF
   C9mv/86Jx6wZTez6KtATpIIV+qwGqcUNZ2y6nHcS+voUL2Dbw12ij7rni
   0QXx7UNoYnsSyPqiH/o//xrlhQtzA1eH3CywFoQzCS7kpVmXcZW5el+sa
   rY9Yj8zvCOkkNrUCgcLje6Jbacb3gi0nfzrX1HdX2FCmvIk6b+HnH0+UY
   eDxrWRlSHIT7sHWxQ1b1snvfWy0MnHTd8ZLv/rlQZ3mzilPl01aUL98z4
   w==;
IronPort-SDR: km2iUNq0Jgb0tUCK3qbAnKpVdRvl7Q4MwotRq+ZNheSgE15+fBM4XMH8JjCk3wp3ocsLIO1zFP
 4kSIIoWoaWSjaJfp46LRT8260pV44DUznc0aWophG8dcoDx4PxGGKWF8WBst1MfHFPhZuComEd
 RCVLa3d8Oe/f6a7ipuLlyGBQI8YeEU6D0Z1oaK04lPzWxBWW2QS5BfSpCliO9qFkRgSNq4Gh+D
 celdGvvJJZi+Gl6UP0xCB9XlhplF8nIcXwjC5rt5MurQN/PpHl2IcuGdAqeXkpa+lxrB1vPxuz
 xOo=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="261722213"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:18:28 +0800
IronPort-SDR: WmuNh79Oy1Kx9QyT/g/Q/HyRq4oF6gbwo9Oy/xDqgauOdd78318GxRByBS6uHf0tqbzoUzQJgG
 o1hHxXyHAWhjmMo36PtPLIOd9HlvjT40IehqZcy7utC4PVxqfKL8PS/jmgEw/1FXHtfrYTn6mX
 lqa7HR4odJ1jiHUJhKXVuM0JukzmcC7nRjDCyI4ICzbPTG/hAH4tX/dT45ftJ8eArjL7pidIZf
 vMdXWkGri433X01kGGt6iaWrYb6a6ULsPItkyTH/kew+TSoOWv92cRdPUlByFC3JeKOKxMgT2E
 HfvP0qK+HQdgLcSO0AO2IbcR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:50:36 -0800
IronPort-SDR: Cc2iHwjkEjqCebjYIHV37DmzL2JFDCj0LnxjeYf49PHxyiTP2NZ8nzuGBtZ09ViDWUZ8vTYdRm
 J7nrWhdEN+gCgWv2vDuDE922rCxDY7IuzkLO5tibQ98c7vYRFbD3A74b0I3+FCkHZc9iInjMsk
 ttUysIH9YFkoboXWQTeupwDS6z808YvuNNjY8dANldh5XCHFY3B8WggCGXLgt0OA8lWiQ/lzA1
 Zb3dL/Uummd9+zxAUamqnmJw4K9zg4dg1fijcGrmDnJua/9hMwt6DOXhCDJInxE1KS7iThFeH9
 9Eg=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:08:01 -0800
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
Subject: [RFC PATCH 12/37] zonefs: use bio_init_fields in append
Date:   Mon, 18 Jan 2021 21:06:06 -0800
Message-Id: <20210119050631.57073-13-chaitanya.kulkarni@wdc.com>
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
 fs/zonefs/super.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bec47f2d074b..3117a89550f6 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -682,10 +682,9 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 	if (!bio)
 		return -ENOMEM;
 
-	bio_set_dev(bio, bdev);
-	bio->bi_iter.bi_sector = zi->i_zsector;
-	bio->bi_write_hint = iocb->ki_hint;
-	bio->bi_ioprio = iocb->ki_ioprio;
+	bio_init_fields(bio, bdev, zi->i_zsector, NULL, NULL, iocb->ki_ioprio,
+			iocb->ki_hint);
+
 	bio->bi_opf = REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;
 	if (iocb->ki_flags & IOCB_DSYNC)
 		bio->bi_opf |= REQ_FUA;
-- 
2.22.1


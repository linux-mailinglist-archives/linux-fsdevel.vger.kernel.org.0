Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DB02FB283
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 08:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388385AbhASF17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:27:59 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63871 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388594AbhASFKv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:10:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033051; x=1642569051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BDROplFBhH1R4EEGILjaJK5BhqTJ1siF7I5dea87B68=;
  b=HrRbP4ax+orGLB9pZ48LfB0wjemH1f2yEbpW2blcUUlmYVglWOoPjFwI
   SUf2KqVX69RlweIkZe/oWnJ0Z8lihs4yagAcfDjwI48XsxxIKiZvGQdf4
   acgpbbXzk6t5HB9vzTfbnXdnhq/Sk/Cu4Ev7sPYQrqP6rLFvU9tbPqaU2
   vh24KseQjXsGcg3f4AU7zcrwPOOxJUiTfppHfX60blPUUUJs9EFPx9EI6
   wjLja4IO4+DCvF8PGq15qJ1TEv1BRMh46xn2qGeJRmQSdOfz8sgAytgHl
   +rFnB5sk/qMpPzd1d3oeQYxOqtGU60SBBtIClYubcBUSgNSxhjFSdeROR
   A==;
IronPort-SDR: J1g6e4O1cfTB1RqEx+V50ULR4qkQVcXnmAFYCurG6KhYm9NwLhwGkdGLATzdJcqC/Lh2LpN5rw
 +hNjD0HMsO+ceGJnwsJJnzOmyDd6zRGSzB3QGk4DmdsWQberwJNc529Kwa7+mNnIgwJpIA6fEg
 k8IJkTo+XtqDDf8MglXf1VDCRaz4IikvgfjJnDMt9IQRbSbIKde1Wi2AIa5ljyQtEBKrOpJZIA
 nxtiHszXXjN1QtiSnC0ASdTLzYJVgIPWVKhPuKfPMG4vlT2DB9bX7oefBzMDeI5DbDqkOIDceT
 Kcw=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="162201168"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:09:14 +0800
IronPort-SDR: zz4JPeqCGnF3zt0AKeemtieh9VHcEMwN760z6I9OKyQlHoVG1z3J3nuPFn5Ej9Xt68Wmjf29tf
 64YJzOhy548ZYDpb8pjJColGvdez2by3OzVCopSYiGC9bbIMHrMULEFfLdW2zUarxG/rQ+DPDk
 iBgMyGc11mouzT+NaBLvXAtzvIwfu2BfG9IfuTqZgHVvS+yr39EWf9aoOMDfA8DLiPxCXF0o/p
 07YKc++LnY5wV35FaPIIvJJgIgKNmHtFg6KVLHPAhPDRsWoZrZa7E1o6pIfQI5kzyS9fNiO4Yh
 V8yUsGLEgWtA6A1mz8Qy3LI9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:51:50 -0800
IronPort-SDR: TUB4fUCiZmYYR74Zcq3vSkW9sI4g+StmmNi9bjrhbbXw9jVqPyfJUUEFsMQdyN9Xq4K6n7Gn8a
 Xr6vVD5OtZEwhLTDm6sJ+DJHPnZcY1k4fpGLKffcDnsEbkcmhWxrNLKyN/hbblQkxxwTcZE2KU
 qYtpp06Bbo/MdAwTBedKhVuo+MaJ3eMXDG6FXDQH5gjW129P5pemibZ8rtfa1SbEY1fp51cPiu
 ZnsBDBB15dkF/zopQoBN7n0qT3SGiHxK3hsHzU8k+P+0nyNJdJcQLu/AX3kBJLLH5SuOOpZND1
 ur4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:09:14 -0800
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
Subject: [RFC PATCH 22/37] dm-crypt: use bio_init_fields
Date:   Mon, 18 Jan 2021 21:06:16 -0800
Message-Id: <20210119050631.57073-23-chaitanya.kulkarni@wdc.com>
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
 drivers/md/dm-crypt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 53791138d78b..b03dbcbff491 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1764,9 +1764,7 @@ static void clone_init(struct dm_crypt_io *io, struct bio *clone)
 {
 	struct crypt_config *cc = io->cc;
 
-	clone->bi_private = io;
-	clone->bi_end_io  = crypt_endio;
-	bio_set_dev(clone, cc->dev->bdev);
+	bio_init_fields(clone, cc->dev->bdev, 0, io, crypt_endio, 0, 0);
 	clone->bi_opf	  = io->base_bio->bi_opf;
 }
 
-- 
2.22.1


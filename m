Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7EA2FB25C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 08:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389263AbhASF3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:29:32 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57027 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389479AbhASFLu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033109; x=1642569109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cW+SY0F4uLtssGzI42l+SJRJJ7OOq+Ii5A3v3sT7Yes=;
  b=Y2d2D4oPfN8X6+6qjUizRevGL0KpGYKqXxsoOfTrW7V5ZXCLjrQbs6+1
   3EFYjncxwSm3Jm1SFX+VjA2z43vWJYb2q2xdbfdYT0uQBrq6jQGsTW/4P
   jG9YhwopOibRpY0UnFxVdpqsikwdM/D+lSvMxp+r28VR6oFEtAqEvGVhM
   +NDNQLboEz3ZJ6Tk8uN8eoO01vqfrvI3p+n4jZMCITbAxIBb8ib9T8jKX
   EEgpIdkypy5qQKtPdFJQSru3q5zaVpql7n7qwjrPM3p42ZTO19RJoshiP
   vRosT8qQNJ7NcvCHQZPFhk+ZUE8EwPw9t1Zos6uAIHwyz0lcF7yo1kuRT
   g==;
IronPort-SDR: qKGHfO9zN7A1SHGD0sJgeLXKtsxCWCZQCBMta+7tC9HjPa0iIdgq06stafZjSUOuGrWgzH6/Zs
 qrnOgaWyHIH5wPnOEfNlBrg61+ELtLuy8MVfUmBIrKkY/vrVUQG7KR5YeotmEBAgOpMmT0oPtH
 4bhhS/DClbRNw5+WwuKwkC/liLbtp7IJ1QJi8MA4XFdTyf4m9NaN1djmN/HBN1U63o0nBSdZCr
 hc8ttQjeYcu14uBj4dURdwnwRJd8G/vefW2dPVCvY3WQkIKSvUpsP5tyvHfytQhm5DW0FTqE89
 Mxc=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="162201332"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:11:05 +0800
IronPort-SDR: Jxwf3i9x1B0RHCIROtDE/iuDAINqBt2F/RuDwWDEmyByP2X7eHHcF6VYOb5pX3bjB98MQOBY/k
 EE7/XY0VHY25Xrc3u2aWXZDj/vhyZzri+REe7jdepimEkX/LSD5BHLSu2lgFdY0PUwWpTUV+wS
 g0AMlGBKhMvJzUbhNknog1IYhJUgz90bASkg7Nfrls4FH661MmIBfGkT+K0k46pqDk1Gc4u8uP
 uOawWWUbGxnsrJmwxL+1TtwCKD4GoWRA+UE75WfzG0WxSOHGUYc9zXiaXHV3Kqjokf1MtXYWF1
 z2f/O4DCt2Qar7cdiXh2oQLW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:53:41 -0800
IronPort-SDR: JhXhgWS0+e3HTDStYfAXJ39RQBEk0euVnqe58ziJOnn1c9Zev+zyQZ1feT8Pf3jy1k/0jfejeB
 9eRQsJQYlpsXL/MQdwG+RKeojvlhwZb7/kK3K8LYVIUeWuWwf4teK/xrJ6FiTzChv1xe4/bY5+
 eWHUFZ+nWTw4YtzlPxnn6S3DZ4LcVreyfhizYCPM9a4WY7tqwq6bMPlFdYm38BooiwkcJvUlM2
 jto6KJJwnZYWpzG78qeBvec0imqsf+1kIqtJBGsfGtjSerNFR4ZUCja3e3hANc2sx71Lno1zNp
 h1M=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:11:05 -0800
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
Subject: [RFC PATCH 37/37] xfs: use bio_init_fields in xfs_log
Date:   Mon, 18 Jan 2021 21:06:31 -0800
Message-Id: <20210119050631.57073-38-chaitanya.kulkarni@wdc.com>
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
 fs/xfs/xfs_log.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index fa2d05e65ff1..062ee664a910 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1702,10 +1702,8 @@ xlog_write_iclog(
 	}
 
 	bio_init(&iclog->ic_bio, iclog->ic_bvec, howmany(count, PAGE_SIZE));
-	bio_set_dev(&iclog->ic_bio, log->l_targ->bt_bdev);
-	iclog->ic_bio.bi_iter.bi_sector = log->l_logBBstart + bno;
-	iclog->ic_bio.bi_end_io = xlog_bio_end_io;
-	iclog->ic_bio.bi_private = iclog;
+	bio_init_fields(&iclog->ic_bio, log->l_targ->bt_bdev,
+			log->l_logBBstart + bno, iclog, xlog_bio_end_io, 0, 0);
 
 	/*
 	 * We use REQ_SYNC | REQ_IDLE here to tell the block layer the are more
-- 
2.22.1


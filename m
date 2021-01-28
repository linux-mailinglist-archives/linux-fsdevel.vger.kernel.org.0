Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57286306EA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 08:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhA1HQr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 02:16:47 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:20217 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbhA1HPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611818100; x=1643354100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wUwjN0vBouMAu1m5itQWMc9ceGIiyWjYqyXKNeHEsnQ=;
  b=WibUlWMJVngk4AOYZRxPfkqtcfVcMLioDeet/ZSSKMY53IALWWdHs1Yf
   7mhFXjVNG1YkUiBeBWGx6rAX3/owMhXL+YvvHz89tA3h9VrPBFjDTNbkL
   yZQDX+imf22V7eKIFe0CPYLP30j16vMxmX5+Cq3fHFEJYX9P68xYH+wBr
   8X+rb0bpUAFsmadoLWVuy/Bs/IhaTm3sA9TV1igKy+yPPUvK9BQdm4lbC
   zBZPOqg0Kar0uf0uHRuktfRquXwPzQFUR7kO4MdCSW95D1MwnuIcd0FuR
   XzyEYNln18o9fC7Fi6dLpfzmVe0rhka96Lb6kKkZi9Wel6u33E16Imp7E
   g==;
IronPort-SDR: tdWyFRxd620XWJuFvawJmxTWw9+7c+QjczKG+1obuVW++kUAeNuu+mDrnaG91IpUgCPtFkJbzz
 JTTsV+b2C93MtaS8YTXCyBrCW1VgBGaq6t+lR6WBOuQJW7i+f8w2FWjdnW5QhpbQZdvxc0m1mq
 FNXlimwFBLCYFm/UVLSY8+KDSV+l3Zlpb3RUeDvdj6496jLXYZJtDDV8Be67m2SMw6MQO0fMOt
 7u4fNY/6o3iRmTu6uE5KUd/BUDhylzgIi1BQVrM5Z0p7GgPvVQbgvgmb6VpnF+pGfo1LT2mVVL
 j9o=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; 
   d="scan'208";a="159693878"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 15:13:54 +0800
IronPort-SDR: 7sG0ExNAA/Ej8af2uVQUSyD/z7nXcYmxX8mM9G4zbSfthkVJ/XTotk0mpQXJ0QcWDncyXPv85n
 VHtFcIVl4rFAhCKPTGl5SnvdXeucliOtTQmIgiNtCA4cGgUw7bktH8CYS2tnBda7A3PfrJGb88
 onQStzzmI8j091bD49Z8TZvh171YJgSlbXmpFHF8qAyA0DvT89NPdEmMWmjpNxpGhpNRFuG6ME
 gSrrWo4JMjF1VO4jX7Krdu/oUrW2nnWAsnSzAo/zjfxSMa18lLEw9+E/NqsmJ3S5RzVXuq0pTn
 QlY9RKgbpdzQl1RziaqVXNYX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 22:58:14 -0800
IronPort-SDR: pB2cXSth9j9iO8qI9kro9aUnzxe7uC+CM4R5ezhi5mkNe3QJ3MeSZh+GGUOxW9ROBr/hgtgk35
 3kQYC2KUTB+4qbQnoUg89GyqXiUICL6Lbb6/fLgPHrp+IuvY60iwR3VPtR6IrHib1STZYvjFII
 G0U9LFUNwbOn5ju9S5MOKHMAKhFoQxnYNKdJKA68HgaqnFN4j9YRc5HgIY3H1XVVcQBHwY13od
 d8yfo6WXgScVxvO/+aDCj5bBUi8Qq8LHMuAKgJFuukK9k/tSzy9sPaWEv7Xl8jluo8DC44HSzF
 bXE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2021 23:13:54 -0800
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
Subject: [RFC PATCH 15/34] fscrypt: use bio_new in fscrypt_zeroout_range
Date:   Wed, 27 Jan 2021 23:11:14 -0800
Message-Id: <20210128071133.60335-16-chaitanya.kulkarni@wdc.com>
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
 fs/crypto/bio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index b048a0e38516..20dab9bdf098 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -148,12 +148,11 @@ int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
 		return -EINVAL;
 
 	/* This always succeeds since __GFP_DIRECT_RECLAIM is set. */
-	bio = bio_alloc(GFP_NOFS, nr_pages);
+	bio = bio_alloc(inode->i_sb->s_bdev, 0, REQ_OP_WRITE, 0, nr_pages,
+			GFP_NOFS);
 
 	do {
-		bio_set_dev(bio, inode->i_sb->s_bdev);
 		bio->bi_iter.bi_sector = pblk << (blockbits - 9);
-		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		i = 0;
 		offset = 0;
-- 
2.22.1


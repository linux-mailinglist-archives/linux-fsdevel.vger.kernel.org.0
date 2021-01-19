Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD2A2FB221
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 07:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389487AbhASF3v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:29:51 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34800 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389639AbhASFMN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033133; x=1642569133;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dUZxU7BncWFawkbUm0QHtY0n6f/CWqD/WEdprzvrR/c=;
  b=AKdtC2aQNZWlFCcYQfBOe6NnQcL1SZJVNqeuEJ8ptO/anYcuSp8PJu9y
   SxW2VlHmJ0kQmYvwX3t+Dm4jPkS+1n9BuNS5RDREhclD7Ev5824ayZmjX
   tlx5rTY/ArxPlvREeJxT+gyXAWGOZ4xJjFr2SgowgqlD9lgnuXon16Oiv
   jLAPFa56TlPCn45+rLBL9ritEO4dqtO8XLdkaICXG1V/cs5+H1xFcD/mS
   gyM8uV8v+x2bIveU39dfxqmQd5TbEWONT2c/RuXAD3z7NOThJXbj75Fb5
   Ly3VCOK4Eo0TzxrU0K8SMBNI9OTDSTf4lm75XJUckZg4gw2KaV2FML70y
   Q==;
IronPort-SDR: JP0alpLEC0vMZMoZwPiMHKQ3Xj1uWdOzPnHRZBpG6TC55DH59JGWS+qNxthHoVw8suHWiauinf
 8P/xM6OHiAXDnF7ccY5awEndQlKQdq7LBWUMGoQOuqT3BhQjLFX1dlqBcg2WMavpqgCHDzQgXF
 TExxo66RGIi+ojAsQNDmPcSSthOHzx/w3wZSIZ8jtniblkdtoQP0lXXdpu8s0i39W1gwJiahVC
 XXXzf3k9dVJHhUBUHTUX9E7WC9OzEuHeoF1Rm3kEVn8u1NlKN9jChElz8F/f5y567IU3Q1zoi3
 i9Y=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="268081267"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:10:50 +0800
IronPort-SDR: GqRmntH3EzIBuVlongsEqZJi73xPWdydc3YPt0D+L5i2WAr5bzL/xMEBTOsY67NobISzpRSVmF
 L77jN3qDl/ttxD26gapA04YvTji2TUd8Z2kuhOTLqnwEie4NycPK0viQoPm794JZkqPN05cAwB
 uNxJdnfX75YAIOgTPJOMXtrUTprvIflKLgPdES1Er64CyXcT1Jcrwc8n/Jv2exSKcfDjXFjXSy
 n2wzI8vjiNMkVx6Ilo7OIk44437uJQ0SHkL4Pj+L54pPN9xsMWEX1dhXsCptcFB8WY5Qx+VBCG
 cWpeW6aPt2lfLMcGxHEIgl1C
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:53:25 -0800
IronPort-SDR: l/PshN71cWYbTK1WTMMOJErnyUYZ9w/R4z1nl3IAFxlbXv4liArup+WsFD5ickHhD3utQPm1yk
 sDJR5xYPW7Rk4AOBaj9ddtkrfHNoDjxcLvYwqKoJ+zSMrb2LgwmOyjvRLWCwQh66m+L31DF3GG
 cbQQZKVcF02VZtZcPCLoG656Pl8BFav/PRzS4RekqjE2nR1vtzK5A4F7XeBguGBUnZrVICH30u
 hENXcQH2DncOb3p9BCQrIXCeB58uVf13+u9S+duV8v8olXF+1fRyqTUCKPFMBWOtqHC+TvB1s2
 T2w=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:10:49 -0800
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
Subject: [RFC PATCH 35/37] ocfs: use bio_init_fields in heartbeat
Date:   Mon, 18 Jan 2021 21:06:29 -0800
Message-Id: <20210119050631.57073-36-chaitanya.kulkarni@wdc.com>
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
 fs/ocfs2/cluster/heartbeat.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 0179a73a3fa2..dd37aaac4f32 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -528,10 +528,8 @@ static struct bio *o2hb_setup_one_bio(struct o2hb_region *reg,
 	}
 
 	/* Must put everything in 512 byte sectors for the bio... */
+	bio_init_fields(bio, reg->hr_bdev, 0, wc, o2hb_bio_end_io, 0, 0);
 	bio->bi_iter.bi_sector = (reg->hr_start_block + cs) << (bits - 9);
-	bio_set_dev(bio, reg->hr_bdev);
-	bio->bi_private = wc;
-	bio->bi_end_io = o2hb_bio_end_io;
 	bio_set_op_attrs(bio, op, op_flags);
 
 	vec_start = (cs << bits) % PAGE_SIZE;
-- 
2.22.1


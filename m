Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F363B362CE9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 04:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhDQCd6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 22:33:58 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:17957 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235502AbhDQCd5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 22:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618626812; x=1650162812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1bt8pdRaO5fUcGqSEgkOZzZgAvMQ4pvkgiTI/HOypSk=;
  b=HE+6rLF3zUS3FAkqXJtiUoPTGDT4XOsThUwuo2Pd0tiDZGGMk/Sv91LY
   sBzmgHDN/b9sns7Ld+C+nlPsvXnHhdZteQ6EvVJlrW04nJffK/WyGvk1D
   sLWAfthg2fNWsHDTL2N4sjlOF64Hg/PfegRveoiXJElk0QlVflNxeLZQ/
   TJWmwdLCdO2lgPyKxfe7XGbFFt0JklEO9ye483WcVcd4wuIeMtBYsyXjO
   jkYKhVsWZnwyEpuJYekAqcg5lgEHOYCDVVYIy6WdajlsUkhgmHgP2ynoY
   AMjdK1c/BkXkeb9FDvk2pBNpP+92q0loXmz7Fnj4LrqsWz2RYy4vc/Amm
   Q==;
IronPort-SDR: eQFqlBTv+6YqQHs8SD2OxFSGsCIeL22Vns0GZmM68nilCN4ee3LixawNMknP+mjsSPizpP1fxN
 XqqzfEgLwn2/X7iP+cL4bqjDZteJ6qlCPzcnCo0ysHG946TlCGkb9MnScf5ORXPce7W7RuFfZ6
 x5ClhlUiAILrqyDcIkfMFHC0d2NyjoIHo1bQPe9/Brmbsm+J3x4GkZVndDITtoDo5uZv3195ae
 oofvJsChf3ZrmcAmMpvewPADauSJXJxPptuQb3eUkl3gJX2mFLeCUI756hmDBcbzuwwB9Ovb1f
 s/A=
X-IronPort-AV: E=Sophos;i="5.82,228,1613404800"; 
   d="scan'208";a="165193277"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2021 10:33:31 +0800
IronPort-SDR: EA0GwqVOc5QzZUO4660rt9CIAk4Rmg/yzraTuABX8mJl7FAFMM/sCgouVAoQOhniLP4gx8aCVm
 yaBvjbf0s6vLSgEyuDE1m5O4Cd+yR3Ak7LmhcE3sj9fH+8osHSDaf113VE4BwqauDJG8D9dR5k
 q3+sHxneEbPTmVpLgi2Z1qejtx1Nw6Hk+I0typO8DhqkMU0Qxy3we0DdHmgf3ImAZoMqNZ6AVC
 TO+Na131IKoD4T5Ubg+WEJQtDLdpAPGrIBAd60J5phM4mV83ej/pHftZaul3/TMQpry8Ko0gVX
 wsNPzu9MbL8fXVD+aBbm7hDY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 19:12:45 -0700
IronPort-SDR: ffwDuNJdgpDyZs+F+I7hb5tSfdWh7H3NQY/F8KVBqjx1K+WoPrmksYPHiqq3maw5NfYpqZctE9
 gWv+C7z7BiidjMOBh+0BeZRwHA5xPSD1s6Kg3GUZiliiyyBB0i0Uv2nQz0774FLe8UiAoCUSqt
 e+5ZqS22Z3zk1jmc+G8LVLkZJk8bruBBF+amRb69DmiJ5Lq6G3GvG7tTV6S+KC5sTAewBEgA84
 hAnkDYwYNQCOL+1UEM6V12/EMZYtLQG3IrKQoLYYc5WTTO5MKtF+ZIu3Pf8XRj1vqGFTTgE1HH
 LWc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2021 19:33:31 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 3/3] zonefs: fix synchronous write to sequential zone files
Date:   Sat, 17 Apr 2021 11:33:23 +0900
Message-Id: <20210417023323.852530-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210417023323.852530-1-damien.lemoal@wdc.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Synchronous writes to sequential zone files cannot use zone append
operations if the underlying zoned device queue limit
max_zone_append_sectors is 0, indicating that the device does not
support this operation. In this case, fall back to using regular write
operations.

Fixes: 02ef12a663c7 ("zonefs: use REQ_OP_ZONE_APPEND for sync DIO")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/super.c  | 16 ++++++++++++----
 fs/zonefs/zonefs.h |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 049e36c69ed7..b97566b9dff7 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -689,14 +689,15 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
-	struct block_device *bdev = inode->i_sb->s_bdev;
-	unsigned int max;
+	struct super_block *sb = inode->i_sb;
+	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
+	struct block_device *bdev = sb->s_bdev;
+	sector_t max = sbi->s_max_zone_append_sectors;
 	struct bio *bio;
 	ssize_t size;
 	int nr_pages;
 	ssize_t ret;
 
-	max = queue_max_zone_append_sectors(bdev_get_queue(bdev));
 	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
 	iov_iter_truncate(from, max);
 
@@ -853,6 +854,8 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 
 	/* Enforce sequential writes (append only) in sequential zones */
 	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ) {
+		struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
+
 		mutex_lock(&zi->i_truncate_mutex);
 		if (iocb->ki_pos != zi->i_wpoffset) {
 			mutex_unlock(&zi->i_truncate_mutex);
@@ -860,7 +863,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 			goto inode_unlock;
 		}
 		mutex_unlock(&zi->i_truncate_mutex);
-		append = sync;
+		append = sync && sbi->s_max_zone_append_sectors;
 	}
 
 	if (append)
@@ -1683,6 +1686,11 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->s_mount_opts &= ~ZONEFS_MNTOPT_EXPLICIT_OPEN;
 	}
 
+	sbi->s_max_zone_append_sectors =
+		queue_max_zone_append_sectors(bdev_get_queue(sb->s_bdev));
+	if (!sbi->s_max_zone_append_sectors)
+		zonefs_info(sb, "Zone append is not supported: falling back to using regular writes\n");
+
 	ret = zonefs_read_super(sb);
 	if (ret)
 		return ret;
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 51141907097c..2b8c3b1a32ea 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -185,6 +185,8 @@ struct zonefs_sb_info {
 
 	unsigned int		s_max_open_zones;
 	atomic_t		s_open_zones;
+
+	sector_t		s_max_zone_append_sectors;
 };
 
 static inline struct zonefs_sb_info *ZONEFS_SB(struct super_block *sb)
-- 
2.30.2


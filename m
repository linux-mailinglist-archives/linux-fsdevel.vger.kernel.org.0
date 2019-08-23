Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F388E9ACB2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404257AbfHWKL2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:28 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47768 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404232AbfHWKL1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555086; x=1598091086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1hRmT3DiraCeVKIIORgGvc4tSO1ifK7iXDzxtKkod9A=;
  b=bUgUuhUoCyMkJp4r1/nD6H9Lf2HoGxbzsL0xsQVcuKbgE4y6X0s0KWqR
   muJytkkVH2D5CbitJ6msE7xmYpEyjl9No5Rz239w2qwqElYnQd36xD0k+
   tOobBqlVfKhECMVIDiHjAeKkz5lcxrNUjH822bQxgL83zZxEt9AM4O6zA
   fq9vTWieCifDcez8hgzPc8R2K1Q0zfBEczbRWeHr8CgvC/tS0IABNi0mE
   FvHQZhIv+BP2mTED9b5tQhYz2zuSF96fFaQWE+HeEs6RvYI+T+TZWS6Vm
   UeDEvNqr8tRaddtUho4SpwraLlpw/SUH/6mBPJtH71Rw0L4hT1/lCRdIP
   Q==;
IronPort-SDR: aEQpX13Svh20uQRxB8tgzGXj4uyJxupBNZEHafqV7fZK86i9HhiOO1iVKoxjnaXghPXZJn7tPG
 fy6/0hwEC7cl6UEDuivbWFNhYaTQjqUYkidJxr5yybALxTMDlI0QCHnK9YNNUGCUNwPb2dMZAY
 ZS05XcyOuQiGIbr4lJMGpnF54K+52cnw6Eyz3hfYiTQqtkDHhDfG4zWv84z6OYGJjVA6Ee+S2U
 /m2OWGjQ1Nablxo4xDcvMD2fT13zZkptTkolrAsSaIzWTIQP5aPQkuyVrq6UJ3vKQeNYRKyTL9
 D2g=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096242"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:26 +0800
IronPort-SDR: 4CiJ/6N6bogUko1ukkw04ZFPhTnT9yIj268UwQP9KnMb5ajNHuQ8wPF9IDB2J+Yo5FR15HxQv2
 kRoi2rY/Ck4e18V8PoI2rLqgJZuKVq7KAfzyW9F4wZYOyPtSo/la3s9GZwb5Z3GMrUXyE80JJ2
 VD5e5yPMUPjlhTuBu1QzSiB5GuDaeVFomDoUR1gjHGUl7g33H1ctBXblDuSzRn3kzGPda7NQ8P
 +aFCnlsy39hP6dbTm5mEpCFs4d5cc5hyNlyM/2Pd7Oq7JhY/Np1CUPHf4B2xz4TFcAeu1LKzEY
 BQFeM3z+HDtAZB+PNMBRpZqO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:08:44 -0700
IronPort-SDR: kYZlLB/Cq4tgx7IuBi5fFoBkyvFHputZ515in7tsKikF3n2QKzeO2HH+OoWeiYHXJ23WkWiie1
 mSJRwihbNaONeJoYzyJqjFjGYj7uCG4hP21TTYQZBGRWk0Atwdkyyqk+rZJwC1cHyCxdZdoyyW
 racjC1D2bDoYz7AEl/Vuen5lZan5i/9I9AZT7WI9OAGb/hdwLlqqcqwW9R6qi22SLOkOjJAQ7W
 0gDwBRTcMZH1pnFdQxeL64H2mOEBLtUUsB4b+89x+Z9sZq5u+ZWLpIdbWQChYI9TLrVethV0sn
 TCI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:25 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 08/27] btrfs: disable fallocate in HMZONED mode
Date:   Fri, 23 Aug 2019 19:10:17 +0900
Message-Id: <20190823101036.796932-9-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fallocate() is implemented by reserving actual extent instead of
reservations. This can result in exposing the sequential write constraint
of host-managed zoned block devices to the application, which would break
the POSIX semantic for the fallocated file.  To avoid this, report
fallocate() as not supported when in HMZONED mode for now.

In the future, we may be able to implement "in-memory" fallocate() in
HMZONED mode by utilizing space_info->bytes_may_use or so.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 58a18ed11546..7474010a997d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3023,6 +3023,10 @@ static long btrfs_fallocate(struct file *file, int mode,
 	alloc_end = round_up(offset + len, blocksize);
 	cur_offset = alloc_start;
 
+	/* Do not allow fallocate in HMZONED mode */
+	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED))
+		return -EOPNOTSUPP;
+
 	/* Make sure we aren't being give some crap mode */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
-- 
2.23.0


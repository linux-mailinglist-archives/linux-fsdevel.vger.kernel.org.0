Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5494D2E04F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgLVDwv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:52:51 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46382 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgLVDwv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609171; x=1640145171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ehiyT/rjXF+jKIzQjKxIWcDbNp9RE+AwX6W27HgSZwY=;
  b=lItX+ZGuMe8xIHR9jr3fNAxcBzfVyHutPn+S5eXjX+wdX7dSqDzZym9z
   EMoKYoEe3+XEupKBbDvCPY5F6zpQXnQkZw/XqopSSg/4HYT39z9clMkst
   78LZyXoAO9kTZwo6vROBEwCpVkKMYeivdU5qQg1SCX1Y6tEk97EKOapEM
   Cxb2emAj/T9pfY8dghcHBsj5pNCpUK6DuCjO8kUPvU/Y8K0LGxjK5mFxN
   ndEvmEh/HwwktArQlGmXuQwv1VTOnBlVO6eF+cvsHwFahlGuEDhuvkq8P
   8lkYUoZ6WkWoS8Ttta0YvmovDl2roUJd2ctU2XMTaSyniEmcBdmhUNIsU
   A==;
IronPort-SDR: JGOascXF/QbtG57cX/0dVDyJz+sSI4FoWGtNpuPbzsa189r5wn+YgfBvtyFdhy2sqNpdv9hmzz
 0ltCMYOKiu+88lS8Qvur2hpKl3U5TGCFz6jPIfOztx7WtKiMgM4kUYa2c2TANRxykLsHOiE45a
 YY2ypvV2p8hrUNuvz8paS5IoZ0n32m9d5UrTComwkA5hFWAMUr5VNat+vbORnb051QSxezBWgz
 Oo+C8/Kc+3iKha03K7eMN7Q2Un+AIcBlUb9aCy0RHm0j9hYaMAXZC+T8+0IRR6DgH4BbQ4qEgw
 Vvk=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193750"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:39 +0800
IronPort-SDR: R2vZfqVHGD4QpWJuawansrST7LKH9jjgpNCvB3TonWXnIH0K4RoScBLMpyLjZJMf97mCxJ/QzZ
 V4nGBGNUEwnS6sMTJ4JjMDVfDOWG+KMYbfnOMN5BdogB40xIY6Fy5yiRRShbm72L4mUtYbGXKl
 w3LOpSCcPCzNeMDrbTUMxAkF+R+edBfOKiCM+GlxI2TEPtMj5tOYBLY14RS149SefWowT8aYoh
 AA2xccVYil3WqGbmwDhEf2ShhHr6ZNChkeHWfsDfOcSobOGaePEk2mpYyrKU+crp1LoQx7aei7
 cGG3DHqdTbdvOme7D1qOZmHq
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:35:51 -0800
IronPort-SDR: Te9kFLbjGBCHHOiQW6K2U6zfV/qU/iBdkHlkKBRfrC8WT6BnZQarIgo8l+hDQSYeSrCpPUACbH
 x0WZ/l3haI6bjv50ozzSuUzNdfAKY+eKY+DjDdgWHZrxK1aaLkyLZ1idTsqjI6diJj0Jxt+END
 7mDDNrq5enk1zEoBlZKFC+aBIgZGDlfjK9L1t6TxDGXbZPU9R0nIWpO7s+foIm8t6l5ZNFfFNm
 1X9RsIorjt8C+NcRmXNtHYw3akinYRoL/r1w+/UmgGNnzYyA/yWm8D67m7W92K1BpU2w0op5hC
 Xzo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:39 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Anand Jain <anand.jain@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v11 10/40] btrfs: verify device extent is aligned to zone
Date:   Tue, 22 Dec 2020 12:49:03 +0900
Message-Id: <842b11a0724845c3710943d9eb7c707eedad569a.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a check in verify_one_dev_extent() to check if a device extent on a
zoned block device is aligned to the respective zone boundary.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 19c76cf9d2d2..e0d17e08a46c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7790,6 +7790,20 @@ static int verify_one_dev_extent(struct btrfs_fs_info *fs_info,
 		ret = -EUCLEAN;
 		goto out;
 	}
+
+	if (dev->zone_info) {
+		u64 zone_size = dev->zone_info->zone_size;
+
+		if (!IS_ALIGNED(physical_offset, zone_size) ||
+		    !IS_ALIGNED(physical_len, zone_size)) {
+			btrfs_err(fs_info,
+"zoned: dev extent devid %llu physical offset %llu len %llu is not aligned to device zone",
+				  devid, physical_offset, physical_len);
+			ret = -EUCLEAN;
+			goto out;
+		}
+	}
+
 out:
 	free_extent_map(em);
 	return ret;
-- 
2.27.0


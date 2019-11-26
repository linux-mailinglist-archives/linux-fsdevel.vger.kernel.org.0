Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69591099C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 08:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbfKZH5W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 02:57:22 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:55644 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfKZH5W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 02:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1574755041; x=1606291041;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WIegTzF55RGNat3aWcqEAV5DxrfODFbYbMq1bip5hAU=;
  b=VBNNkiX8V2GCKZqW8IQ1Ec9A7TXJPKbzmlMFbXiY9MNoV9TYoPrOT/sZ
   yasksKiFbIVpKpeahYGocAi3smlQZmmSnbwtf1gZ03/Ol8ZxZFb0OHySM
   qREnarxcNVmrH5yoZaPFAcwgMMnt3YGqBEdEktHdjS+/2mZM99W8T1oir
   F0Ev7Pio+EZO9ZgxrXn42FwS2Y8Q7NsFCCQft9vBWEPBCN7BkNdmlTjJI
   +4YwOvii80l7Bxp5JJ0RMMsLh+LAeZZ3k8OnyQAjh5yvu56BSiaQAaYyL
   CetFwFp5bpiKk/87+g/spKzdtU5MFxgUKqIbtJ+ND6M64uhEs68PVSjq3
   Q==;
IronPort-SDR: R4kmXRcaj591iUOU4yCeGI5QuQ6c4y1TjOikg4B5Uz7oNoP6WujatY5NP8OwaMSzFhbt46xrm0
 a8oIbeKmhThXKZZVWLoK4BRPlTjO8H8KnqPaqUPJY63sy/Y7SjL1VSxgDmuLIwNYEbEWTTCf5y
 B9I/Fr3GKn4cymjMHuSji+kSnoqZ6UtjL5ByFlhc7Z1ZbqERniv3nEuwMjcR4YramBpaIxZL+p
 vqo69iUb5ZoGwj/tfQsN1zHFVor/wQG9lvMc0mEqC/D99VlDgWWby/uh6+Vc47BU8Wb/r+fM4k
 TG0=
X-IronPort-AV: E=Sophos;i="5.69,244,1571673600"; 
   d="scan'208";a="124004069"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2019 15:57:20 +0800
IronPort-SDR: WvTKzuOd12GujAB85hs7+PVG2OVR6fjGYCgKFbamx25KzPWW7DJwK+/1mi8s1KaCJzUBEEH7Uq
 03CtdDMCsxklQyDrnsV2scNBplcyxJxbpmuBInMwp7qS415EiAL65ud8wmtsXoyjkugG9hO1QN
 3Aqo4AZXb7rNmQxzosPGYzkslO3UHgxvwgoWXBLFuFgpkMxv8c1WYMbZzAizbzWCQ5MfuYwZnO
 FJYz2/pZ2UBx/v/iXho3aPNIS06uiblY6ysuUgnpOWqvRNn3PwT6jVo49dAEWh6PoIKi0vrTHL
 iSpoZAim+hAS4S8vV6hkklBh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2019 23:52:22 -0800
IronPort-SDR: sxuwJ1p2iDmM5pXbjUF/DAx9OEkWJeCr7QyVHAX6TIUSkZSZpWZ+Pesxagx83phxenScE1wNk/
 mRIeItZUHcbUkhQ/J3eL88a62UAuwtlIRaLBNIbjdcKr+aPk8xUtoO2mU9EYUovW3sut6ngT3Z
 tx8edEQc8mOaatEK6eLtY/HoQ5aip5dEqqcx8YMJVoG0OMZgUEcZnkp/J3hPxAXLJwFfzaZ9L+
 cvJyT4QZ3h8nq/oE7t/wbdEnN/lcX4msHc+k+lkhJ1Ut0qLxdXePjX7PmLgmTiLQE1+HdgysYc
 XSM=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Nov 2019 23:57:20 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Javier Gonzalez <javier@javigon.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] f2fs: Fix direct IO handling
Date:   Tue, 26 Nov 2019 16:57:19 +0900
Message-Id: <20191126075719.1046485-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

f2fs_preallocate_blocks() identifies direct IOs using the IOCB_DIRECT
flag for a kiocb structure. However, the file system direct IO handler
function f2fs_direct_IO() may have decided that a direct IO has to be
exececuted as a buffered IO using the function f2fs_force_buffered_io().
This is the case for instance for volumes including zoned block device
and for unaligned write IOs with LFS mode enabled.

These 2 different methods of identifying direct IOs can result in
inconsistencies generating stale data access for direct reads after a
direct IO write that is treated as a buffered write. Fix this
inconsistency by combining the IOCB_DIRECT flag test with the result
of f2fs_force_buffered_io().

Reported-by: Javier Gonzalez <javier@javigon.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/data.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5755e897a5f0..8ac2d3b70022 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1073,6 +1073,8 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 	int flag;
 	int err = 0;
 	bool direct_io = iocb->ki_flags & IOCB_DIRECT;
+	bool do_direct_io = direct_io &&
+		!f2fs_force_buffered_io(inode, iocb, from);
 
 	/* convert inline data for Direct I/O*/
 	if (direct_io) {
@@ -1081,7 +1083,7 @@ int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *from)
 			return err;
 	}
 
-	if (direct_io && allow_outplace_dio(inode, iocb, from))
+	if (do_direct_io && allow_outplace_dio(inode, iocb, from))
 		return 0;
 
 	if (is_inode_flag_set(inode, FI_NO_PREALLOC))
-- 
2.23.0


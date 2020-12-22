Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1D32E051A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgLVDy4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:54:56 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46466 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgLVDy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:54:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609295; x=1640145295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/CovWTmDimoUKmByImuI2MgnWsjIyjtgTlqwHlnPpPQ=;
  b=QfijF8Ih+mHXplSuRs95muo7w3LHOolECgc52FanK/jzRwV0+ZqVWZOt
   5eRbd0PprmtcfXwqQsSe/pEC77VizLubogVjUvGXEMnD8lZD3zgQXlaIm
   xuADtt305wuMG8Zv3tocxfRklXilWooLKsoWU4b8cCevzK8nD6oDFd1r5
   IHLFAtiPtfujq9RQ4LTNS21dsJJiTDuiZ76DmwR7d0ac6rCTmj2P+3asS
   PHsL0HsxfQvauKJIbwAUVoCaQAKtMBVcq5JSyGec49O1u5nMzNKEIGVID
   KDuDhBePZAclKk6EERjdNciu1JdDEjelQ5ql+Wq00O/MF92RRhd4nP+qn
   Q==;
IronPort-SDR: v5Amq28hF/Mlit3770iCwArIZbMfTDCLp7is1gdZHpJWcsje+oNY9B/u7I34DSFRp+lQAUy3MQ
 Z+tYOl77zKoxJPiAHKom6VTUgSH7vBxtvIY9iJKWDVobX59Awbr3iIiA4agD6QCNl58UwAZmr8
 1hHC77b+HrLpgQQqG/FHLddFJfsFVBLrWtB7fWOrHBryY6X3azDL3POxKEPycTNvxp8L3BsSt9
 aXKldi9SDYFiaaEqS2nt9eXuOinKlnx7U96VIY41uyA08+aQg8pJys7o6d9GgCMrqiXXLFUR7h
 77I=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193838"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:11 +0800
IronPort-SDR: UShBFw8GB5pfStahL3+ESJ8WyVrDqhXlJMMIGItHiXnaEinZ+eF8CZ/fJR/dwonSXIC2ZniX4l
 4Mnoo1+ccKmL2hY9f3dEtr5qlRhrVmNfnPqzz7fVBCfcmi3iAm5HipKgyrFoaS7t/3tKZvqLEo
 mTWZP9MmXKeDZTpMZXILSMoabY3y3etx3hYbaNIWw5tSLseKy+5QyUCxeZlS1tQQWm17bYlNgf
 rBgGOfWPNei4PfhlYPTp4X+Ya7O5GOLIfvi7vwEs2mW6eQjN7NR15L/CodLFEoIKo4J85P2WJ3
 zOTgQAlDoogy+tWoNnVOtPld
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:22 -0800
IronPort-SDR: TtipgX++M9XinyIjILi9e1my06L6Imq8Stl0HsIIDJ7Kv8GVoXvhk9AZekiCsENZIFa7qXloub
 GePYEMOKpuXzdWlqtOKkzLBhEYhwemzqzURPTnPqagL5NcSV8/SA2O3DzKlX/tYGiTdvCzOIj4
 nX13k5KqPy9myUI0Ei0Wop2qX551xXkJ3eog9U3CHSSmIER5GCIk3GVHNS3idL9N7dXi6XSDJw
 I9g5vaBo3QDufJewJuv4ILUhg3sBzywLkbb8O1DU/bpco03FJrt+qClIxCGfpDoyyGD2ilcmSg
 oiw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:10 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v11 29/40] btrfs: wait existing extents before truncating
Date:   Tue, 22 Dec 2020 12:49:22 +0900
Message-Id: <ae84624cf7d9ae06c780f3e9e9a8ee7e062c124e.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When truncating a file, file buffers which have already been allocated but
not yet written may be truncated.  Truncating these buffers could cause
breakage of a sequential write pattern in a block group if the truncated
blocks are for example followed by blocks allocated to another file. To
avoid this problem, always wait for write out of all unwritten buffers
before proceeding with the truncate execution.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5f4de6ebebbd..04ca49504518 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5134,6 +5134,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 		btrfs_end_transaction(trans);
 	} else {
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+		if (btrfs_is_zoned(fs_info)) {
+			ret = btrfs_wait_ordered_range(
+				inode,
+				ALIGN(newsize, fs_info->sectorsize),
+				(u64)-1);
+			if (ret)
+				return ret;
+		}
 
 		/*
 		 * We're truncating a file that used to have good data down to
-- 
2.27.0


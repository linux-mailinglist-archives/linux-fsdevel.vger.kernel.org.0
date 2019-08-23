Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2CBE9ACCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404616AbfHWKLw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:52 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47806 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731760AbfHWKLv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555111; x=1598091111;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=It5/Lg5mTDTXfibuvpFKsVVhaXqA0aPNL3v2S0DwPNo=;
  b=ali5hAXSuhUEFzcZVCW2NyQdqqxqdE0OWI6flH5KyCd0PwgYCUWZ0DPX
   9QU683Pk1rvbKg/EdsZGAzd6y8u9N0FeLOL0FJ4CjlJrruR4e7vS55Bzk
   0Ui+D3JlxkOf++Jjdd0Anoo38h+3eXSMnGe3seOPAMca4Nd8AIDYNnYDC
   OjwDPC2yP99oZ378nMA5YG0Wdo7Xa0R5Re/mtbB9iCNCLDI0vlz5xZDeb
   18PBGpvv///3/rnBiUjPat4Cme/vonNLlE68lbHGzEy53T4WSrJeOXLwO
   oYqZIV8aINH/q838ciRW5IVjXMh0T4jTLM9OMAO8qpQKtc8/ZlO68nwS7
   g==;
IronPort-SDR: dIoqCXSmmht3fjHgkOpL/gI10FWzuGijrYemJuInv8Vd5+KZzn3vEFV9iB4ny+ETUdjBdx1xDo
 ALvzzV80rgZ6oCskPBvv7fOW7VfC5PYaY6dhF4p1FECaw1Y051fui3OOVl/3r4cbDtOLGGwydI
 lyv+6ZGrWG2CphFBpM+WXTsjp9valXgt7r77KOpLl/Wtsj++tH/4079SwbivKJE1h0Vjpp0P38
 iGtBStwwTcRbX7zJ5MWXg1LNC+hnbRMj4HRIBr60hxJUZ9b65ywJropsY2tI/GxLlx+1IFvldf
 798=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096266"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:51 +0800
IronPort-SDR: jT1HskHn2ZRpBW9s2AaRHp80cjdLwDOOESMTHMuEsh/8yvE0nM9jKSHDAVLzmjeLlpa4y1YMu9
 5o2R5XOuFklAZz1f8qpVQK3Gf9Vagb/IcSOswI4Jlg1omLh78vw02ys/n+MczrFIerqLjujFV0
 HU/R1XmXdgdeY5GCqslPgItX2yzeyWvlhD91UuIpmHFNrEyt4uAxjcPkKHxqQ8bM0dEgTUsDNx
 APE1sDNbZT5L6qYaDWbXu4Vr/6Ekmv1W6sDVhSryccYWOsLx7TTnH9fVST3Nr4EjSImdmf13i5
 tCs7LFafQssQxg29sLHcArxe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:09:09 -0700
IronPort-SDR: lpYiKXHTImWpbXrp/PILasuHEiN1B23MbKvqTEoWaHKn8rIANLnBhTjOzPnVOmvqapjY3V9QLk
 sIAWoTfJXceRAFeyM8GO9qLtLvbG0b9OwO3hXU7WlloFLUFOzrymzbkzqYgjah3KkSF5GxhmzB
 9FHJCECIJ1+Ng9OwZLGF/qzpJOMsPnSGVXpuMrXSR6pSy4U9h8Hpea1Ffmco22SOpz14s/+dB6
 PuE2Srkqj1wImg/xPUWGTgC3xMGw7rDRSZy3fiy/KDONodt8cT+4COsjxl+3OTvLwxYylVPEYk
 kRA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:49 -0700
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
Subject: [PATCH v4 20/27] btrfs: wait existing extents before truncating
Date:   Fri, 23 Aug 2019 19:10:29 +0900
Message-Id: <20190823101036.796932-21-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
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
---
 fs/btrfs/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d7be97c6a069..95f4ce8ac8d0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5236,6 +5236,16 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_end_write_no_snapshotting(root);
 		btrfs_end_transaction(trans);
 	} else {
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+		if (btrfs_fs_incompat(fs_info, HMZONED)) {
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
2.23.0


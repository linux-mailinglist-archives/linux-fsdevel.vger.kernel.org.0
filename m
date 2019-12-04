Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20DBB11247E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfLDIUP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:20:15 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32779 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727272AbfLDIUN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:20:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447613; x=1606983613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/19Q0PhgS90q+im5kYYWHaU2pK5prWUE7U1i/KWl9dI=;
  b=NIiKh+GLaETpioFg6E7HS34a9Wo6ee2njBfiU0MSwxJU8Y0J1NaPcrwi
   Bwlbp2JtI6Oq8ITvZMiC09jsn6UNSHiZvgj4ldsW0wG2Z+ZzFUH5vucBM
   fUNhSWVCbwPIUePNb2U9gJGYcTEpTFp07CYwkxr8xuVJJQWMMGyZqhpKN
   EH9tMObcqTDA/FiC1xCqF+OyZfwwDr+reBjlv5cm8IChsQxvlxKRyH9nU
   ssyK06ax89/Xoe15y3QDKSAiB9SljEyi3ohLbc9FPBas1g12p3klsDrMS
   vD/E++gIgLANuL/fhS7PRZ4uEpxpD/xmzefKClQ9fb7rZ5TZwyRtigXBv
   A==;
IronPort-SDR: 1Vr81wcylnfVJqvVfg8VcjQfeyfxn2PEh9n87Zh9B2bPWfg13E3gZnaq2PmvI2Fmmkztb1ttq+
 J3K1hVczrlRZHUBHTFeOtNPciNiuTVE/uRyXD15tyQUD4F4hXuSGJYUXJwFWRoqGNxTMCB3xBB
 52PElA5sBmAt6+5bIFjYVBidWa3FjsS0Cw1qOicB2j1ARPDSpxucMb3Gdn6f03DkFgpftNHIAv
 NjHJh4InEnNxHlZA1cN+cuycl5feQsMO7IF43+cHv0IjirCqLqV4CM/aLgHSJx2O+cnTasQdhw
 Oro=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355111"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:20:13 +0800
IronPort-SDR: 1idgBIE+tIBdaBuY11IryJrcBxB4BBa/atPB/yyiRUKZF1G0WndYMv8Boif45mogOuIUc7w5Rm
 vaZrhaIVUOXe8DWkwoI1gJoSohbUTBrheqitsjNiLYDD49+fzetbo+JXfnu0Rzp+BD8o7m4JZg
 5XBxr1H2DYLPcukL0gphvBEel9vXyOl7qMw2XWIT9wC1ifRdnUTN6Mmer28+tGMB7F1r95NcMX
 HOJzlwmks1DSaqQuNy3oKeAOZrDu4lSQQkEjGwEZkHRr6hDqfVicEppB4xLtBivh+zlygsbDpT
 gybtnP4AzfV7+x6aOS5H2e6d
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:38 -0800
IronPort-SDR: i2syMJO2RLKQqx/IeVJMCVgiTuyVVdNSHWYR2/noR+QxYVE8mxG6OY2Gzr6S1vvsbdrzVASke9
 CTtxZuXq/+c18lI5LmuAStoZon0jXF7+E8bNWdzv5l9RCA3Q+11Nuke7U6aY2UPaDUwVvXYuSt
 2PuqiNZE800d8BLqpWG5uPrsyY6Q3J8TRe+JDQhhlySgw2w909HZVDk1RogeoFRQ0LU5DHuEmp
 pV7JIVEqnGrWkWmfn9eVcbHsdErd3r8P0Fc12d39y1i8ll1vFTuUD5fkb8a6+k9L/+lUtFwxTU
 Cbk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:20:10 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 22/28] btrfs: disallow inode_cache in HMZONED mode
Date:   Wed,  4 Dec 2019 17:17:29 +0900
Message-Id: <20191204081735.852438-23-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

inode_cache use pre-allocation to write its cache data. However,
pre-allocation is completely disabled in HMZONED mode.

We can technically enable inode_cache in the same way as relocation.
However, inode_cache is rarely used and the man page discourage using it.
So, let's just disable it for now.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 1fdc5946715a..55530782c1b1 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -345,6 +345,12 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
 		return -EINVAL;
 	}
 
+	if (btrfs_test_pending(info, SET_INODE_MAP_CACHE)) {
+		btrfs_err(info,
+		  "cannot enable inode map caching with HMZONED mode");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.24.0


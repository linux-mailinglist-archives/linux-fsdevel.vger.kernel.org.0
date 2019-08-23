Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7517F9ACD9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404878AbfHWKMG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:12:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47806 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404700AbfHWKMF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:12:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555125; x=1598091125;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HcDSXOw0tTC0Jygeox0zndTzcDgQ/3fMv19yC9YUu5o=;
  b=JRy3+XbkmJJay0Cx0FoQgjm76/rsViwDukkWwAAkqqsjojuIJrC5JDBC
   eRcr6ex4qkpNtB2L+yHttma9QKd+RMDyLWXzvAss7nGBnF06TjqJk9m7n
   f6ZMEX9DRiCe+tVH1y5vMYv4sYrlL8nHUgmUI2Q5bx14XnWfFTV470B9O
   c8T5sv+MEDplED5gbc9yBfdW8nuFOofBbxKfmLx77iKfik8plKI8vcr81
   p+3KOfkqSFVu9dTF7BhNooPWynewlmZQEWH+9NZ1jRCSVWNGes/k+Od5D
   ASJ1z7iHRA9JbPCVAXq//cD8fQRMdY/pJcxX7JXmQ/P/SOZUVUu+9CXM4
   g==;
IronPort-SDR: K/9/w1J/dKY2sv5X4szTXdZ46WmskHNX5DrwUWGUYhanxveGopMSfyWRk6S2RYClkD8IpALp49
 pR/PzbbTa9oEqH1y1wI8o8JhsYB5ty+Wlza6BUU5pgmM2MHkZSviqbfvyeYeJGk/cVGo2c1BT0
 0tgI8o5fu0YSNjNjfQP/OqKMee7RyMCTJzxwxarbhV1ZIl4V5dwBWj8VcivJeMBIUbxNMzHiZc
 EVEbLmBLIvaBc3ZJZWLaXplWNnnp/wB78Yj4ocu06QYUn0gyeere/If8DtCvXS2x4T2u1y1QF4
 cFg=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096286"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:12:05 +0800
IronPort-SDR: RpF7vT9uPnGHWfWWKEWNt9T6SwkgxEoK8a6esoNviYyUuLSFTfzG0uWTP79MNf4HZS1sc0J8Gy
 sDut+CyQ2GBWCJrzuZbvYPMFdNi1SLoVEHauIrEf/NdaHZBtZkW3ZHNm5giJCzPXMpD5SPzy21
 fRsxzGPZJFUjf2rm44O/gb0LydckGxqGCkoBMZTUDt+3zeAuwJu3cLOcaLKB1WZuzjmDGNRSGz
 A+l75w/zue2RXPOU8rebB1l2nKEZJDi/FKrHz8DLqauxG0nhlwiL1zzz2LAsg3tg+VG1czthVj
 Xr2b39ui3TlG2oqZBy6r9u9Q
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:09:23 -0700
IronPort-SDR: gcuyCgHP8qV2R//TijUJvCdqMkR/g8NajFGxL0BBjTHldCmOlJ2cXp/DHsRMWwrCTb0vAenWpi
 V2yMG/r3ukthiv16cxgGS+sYSExWMamcdB/x8pZZ9lhPBA4UvfaFy1Y+wGW+wINnHT9IpDZaU2
 gdxVmt3vUCgI1vqmmj+x5lyx+agBDTpAgHNejHZIhK5Ly7Bt4+kePZ5xqSUXzXRs+qHogdTIuA
 zgR7Ma0EYoJsrMgavBQcOL1askGWVs6kc2zgps6aDodCybHGSEjc8uA5Zp10OL3XGaY/d9Bw4T
 N0o=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:12:04 -0700
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
Subject: [PATCH v4 27/27] btrfs: enable to mount HMZONED incompat flag
Date:   Fri, 23 Aug 2019 19:10:36 +0900
Message-Id: <20190823101036.796932-28-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This final patch adds the HMZONED incompat flag to
BTRFS_FEATURE_INCOMPAT_SUPP and enables btrfs to mount HMZONED flagged file
system.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 8b00798ca3a1..597159c2b6b0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -294,7 +294,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF |		\
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
-	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
+	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
+	 BTRFS_FEATURE_INCOMPAT_HMZONED)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-- 
2.23.0


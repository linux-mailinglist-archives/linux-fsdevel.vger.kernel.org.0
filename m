Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EE232C526
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357249AbhCDATY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:24 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11621 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378454AbhCCKuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614768613; x=1646304613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hT5t8N9+1eafwIxw5Z/2lU8vPYtbe54WI5/O9RtLDqQ=;
  b=r3onRhWraccP8NtIfMo/pmi4+jFQt7zxFag2uZUo+423coegr+dsf+fn
   8Y8+QFgYmm+NWcWckI8k1SNIrM0yEJdu6R1MGBxR7iHEOudjCasgEjdMR
   LqjvaWEI/C6VFj3CLHz0D3O95pi8SMfaL3vbGpPiHmQE4EKp7eCZwdI6z
   P7zLp2y7/Qv29tst2cYDijVfbGbLjbzwRzy+KZgE4eRXfTY50pgnvE1GA
   Kwg6JyaR9afgTVDS+4zGGisDtT/pdW8SgvD5D9AfwCV/s/p7xvvn+25ci
   saTfnlFDQ/LOx2dW+4HNgPVyGe8gTSMd0MZLuonMlXUD39YpLxdbBPhE9
   Q==;
IronPort-SDR: jhyTxsC2MffB0Gz96Lk43wYm88FzsSQWJxpkFyBulAJ/TSpGJZM+eRQm9IzBUXuBl6EV+XbpVK
 ZEzRW5Qwtun3YSpN0iPILAdKvDYL6gi8PN3GZYJIhV6ARdqH53szfKxhE5GAmBLSPilktk54X6
 FIAMNgcC4qlt3bw/OYSX2DBdHM5DnEWmmOi3neoyWABHqLsy+6qFTAr4V3Nkowh2KGWWWu9emq
 iVoy++sU0W7MiLn6hYhqFgxPAgfGjIg0A26tnvnbri9PDiIiJtHfMJRAvBt4Yd4LeDyI0r+wYM
 GoA=
X-IronPort-AV: E=Sophos;i="5.81,219,1610380800"; 
   d="scan'208";a="271857773"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2021 16:55:56 +0800
IronPort-SDR: xOaPvzZflYV/TvHvT9Ki0qRJUfb18FBwgodMtrPMmsZyRncYNEznkAOtJTZGaGk3MwZeThBVFq
 1Iy3WlyaOVCO0UvjFUpSzETW82BJ+JQpGRMYSg7G9JF+4LYBZB7uai3XLYRMj9UszBswvDqNPI
 TGWSEoyVVKDtmdU37EuNE8W5hzfZ8C+ryroUBIc3yYU74i/zjQNWvMRDBY9byX5POctA2+XOtg
 QAymv/v6Fa++8mJx03eO6AeHeUFUDaF8/YPsTfqWuFWs3UQMYeHUHKeRIwC5+G2VT+Z2ryd/4E
 mjNXhYVGhE8hW283UTDx3ygc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 00:37:11 -0800
IronPort-SDR: DB1WoSh8PWnnFqVj03JC+stgK7jcvRhtLjJwqM7pOlB13+nJI8JMe1C7R27zQkuoLayls0D+12
 0o+ayc/3urcnvZvRpQkIM50sG7DolxU0Lk6UU9B3/XfsoyFxj49prY/NLvATNxsRliiWQwiI/s
 vk1sZKJda2LsF5dEEfWW2GZBFRQlnvX99AGPAoPZV1SXUY95PxxubWt1dFcXPYtmh+JMAfwMpz
 t41Rb5NQ55nRACAlszwYCtjcs83pKZi/KjjGY7Bou78a75Ch8h8uuevTKuP+M2hqgfso0/rFQX
 SrU=
WDCIronportException: Internal
Received: from jpf010014.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.91])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2021 00:55:55 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 3/3] btrfs: zoned: do not account freed region of read-only block group as zone_unusable
Date:   Wed,  3 Mar 2021 17:55:48 +0900
Message-Id: <1ce4bb0b205a2068770ca310f9217e761c0916c7.1614760899.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614760899.git.naohiro.aota@wdc.com>
References: <cover.1614760899.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We migrate zone unusable bytes to read-only bytes when a block group is set
to read-only, and account all the free region as bytes_readonly. Thus, we
should not increase block_group->zone_unusable when the block group is
read-only.

Fixes: 169e0da91a21 ("btrfs: zoned: track unusable bytes for zones")
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/free-space-cache.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 711a6a751ae9..81835153f747 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2555,7 +2555,12 @@ static int __btrfs_add_free_space_zoned(struct btrfs_block_group *block_group,
 	to_unusable = size - to_free;
 
 	ctl->free_space += to_free;
-	block_group->zone_unusable += to_unusable;
+	/*
+	 * If the block group is read-only, we should account freed
+	 * space into bytes_readonly.
+	 */
+	if (!block_group->ro)
+		block_group->zone_unusable += to_unusable;
 	spin_unlock(&ctl->tree_lock);
 	if (!used) {
 		spin_lock(&block_group->lock);
-- 
2.30.1


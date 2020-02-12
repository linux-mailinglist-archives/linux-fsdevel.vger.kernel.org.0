Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590AB15A1B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgBLHVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:02 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31629 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgBLHVA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492105; x=1613028105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sg3sw0GwYM5quUvcsTSk5b2keVv2g1tE2y9XafdPsiQ=;
  b=rXZn3K3AEjZdpqsrEIze6M+GlJ73S+ql2YEV460su3HugjuNf7OtfRst
   dNRExq3EZ6v7FtaiiuW2sE2C/QpnI+Z8R6InvokMRV2aUixfH9FS6TcTN
   KNqM0QlAOJfd0D449mzb2ZHa8H7lcOkMHJwBqivmETEIOkyGyRD7mLgrJ
   GiDb3HPLzB2H9MS3c7M185N0HuqWPdYC6Nluv01Sc6D7+d4FRgwceCV/v
   x61y2U2ALbzV3Khvu4dAotRDhib3+Hb061HltzQBZA3x+VRxZQQ0b/q+i
   8dsaIpv8lTeDDojd2fKMEiimJcUi5lQPP3IyR5HZ3SxG329MhGMslcaQU
   A==;
IronPort-SDR: 5foFczpggHzay0f8OWCbmt38SRxPM5ghg6Q9tX2HuBnM0YilUD/R1v6UcbQ8DcwKxUB440VH+R
 9xwF4hUKCJi9n8E+xw1g7fKUJhdGqLaCdHw65yH/EWAcCbMxAsAUh8pZvrtd8D0XmkvWNwgzp4
 SvNmKx/lsY2lXbFed2vNNKghVhDGHAoEE2nuWraYyWqtbJIOAwpu4WYYBgo0VLdSUKmEO+GfYK
 br8CYhyqCXAsePzUWY0UEsmQNYtVkqBlva9AkdM6EEnDKqzoZzBaoiUvmFDGxHcyWsOaz1nGJX
 gAg=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448889"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:45 +0800
IronPort-SDR: 773n2juG0ihvzeyJGobH9bURr8YLqu8Q/8bjrg3leSthwpVxIlxeExow3SnAPDT2QEQhsKkXtc
 UVil69CahpgFmqYsjZtQjAE1LiuRHtyAQMDh1jf6sHxCypJqwcYjIDg4VVuag8zPjOMg05wEqF
 MKTkQdVyxc44FD8A1YUfnC4Q/1FegsKh7HzDU1Crn41voJa4IiZyamEgdjiX0vZTh0E0y7o92Y
 PhHqf3KywwUF6FS/0bqgHXYc/Daoia+2VOfSvVjrIN4CZEUabg1jytZea/xUl1EAhxkk4mdeXc
 HvXOqG52JIbxAtHTxRpkySw4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:13:49 -0800
IronPort-SDR: g4S4aosLn0WZQChAyQ15wsyAz91PX9T83SFra3sB2KZ7Yk99+Z3nCMPteEhweUu8+j9a3NgVm/
 gfk7ET5yb17oqK+6w1z78lxNP7QlOrHNGYOsUA0V2ajTjLF6UPxd7BFZK1tc2cVyDBzVlhxwyN
 fsEQMswO5zQb9zJi5jwGA8vDQ+7tu4TNv71q/dvdF4FooAKXmCXUWLiK9fGLPbDmmbM1mMNkje
 +eBdUnDqfJVQXe34kDfD52nJTR3wA6YRGlwfGbfmwVgANG6kh+J0RzVGFD7dxEYV2nJZXgN7BC
 nCA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:20:58 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 02/21] btrfs: do not BUG_ON with invalid profile
Date:   Wed, 12 Feb 2020 16:20:29 +0900
Message-Id: <20200212072048.629856-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Do not BUG_ON() when an invalid profile is passed to __btrfs_alloc_chunk().
Instead return -EINVAL with ASSERT() to catch a bug in the development
stage.

Suggested-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/volumes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9cfc668f91f4..911c6b7c650b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4809,7 +4809,10 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	int j;
 	int index;
 
-	BUG_ON(!alloc_profile_is_valid(type, 0));
+	if (!alloc_profile_is_valid(type, 0)) {
+		ASSERT(0);
+		return -EINVAL;
+	}
 
 	if (list_empty(&fs_devices->alloc_list)) {
 		if (btrfs_test_opt(info, ENOSPC_DEBUG))
-- 
2.25.0


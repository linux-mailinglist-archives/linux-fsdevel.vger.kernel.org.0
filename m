Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F562A06D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgJ3Nwf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:52:35 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21988 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgJ3Nwd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:52:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604065953; x=1635601953;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KmhEYe4FQn2hKciTrSoqULPqx/1dV3UQO8AYYi+tRAQ=;
  b=gHFi3o9vVvqyhOr/ZEZcXEXRhsD7i7d1XWiUc/x9TrT0Pjz4V5dbAnjg
   0E2fhd7degGXywlNPk8VeOn45/UVFneBcRzllqhzq9uOFyyqDn5WOErVG
   mJGpnHU92suoetlxtkv6N/Hk4yXAej2tcULnE/GPRU+2AR+8pXYAvXMWH
   rPhm2CNBP9iPmJT9rqWOOIBw2xOU5LRtnmO5JhSsg6vJ1ksPaKibar8TN
   prZA8+oxkKGTxVNDZarMeHUSH5ymMB9pbxUC+t9+UIEqqoxDmXAS/+8z6
   ykbYF+xhMXHLAP2i5LGUJLL5ZMl4rn0bHfTQYhmm0eVwuvbBfKD4mGWwy
   w==;
IronPort-SDR: 1oMKUq/6Kiw8Ssc+nkL3KiWw7nCeU7PdL6WNfbsxGII1AwS22sFGHJPOHcFI8/9wRFrTpkzHJS
 EZ75zs2qG7us2aD1bXSLoKmF35SRmpJ01AZiad7WtMM70AgBTd1/LCG6Pg7/N12qF0f+nW4Sse
 iVMAzlmOHXF2Mt0AC+2V2Pzp95HDYbyuRBGVa66MoLFCa6GIu2xmgEtWNP/6z2GdSVcOHtOj0U
 zi6m2z33SnY2S9XtEi3kUvpo8symaWC/lAg3pEIzk5q6xABjTnKqNv2nkceXQ5PvNf2Nb8HdSl
 gSA=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806591"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:52:33 +0800
IronPort-SDR: k4x707tpW2gQHX53FtZFdqpOTtCtgQO8Lg7AIiSIMwOMJEYhTdlWgPvZGqG0Ih9XRBFZkRz9HS
 q0wLH9jqHrhUFdq6+Vh+tOy4KwmXp4nxfWNXaJg2ODxeNSO9wNCOGXBe312Bb8zdTRgj9t0iYb
 IsC1qV/kXAHqyMIAF4BvCUfAUXMmAmiziOolku3QUXrpR0HDSDuXhD3WLFmVwP+1r9BYUtz+Xx
 oGGwio4g3V3ugDrMMFY2qh7GmM4TtXFGQeiJsIH6pr4Nl8BriPG4aRaQn3gwrOnO+/Z0VRoGx5
 b+/0tDCsWw5TL13cAtqRmEjf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:38:47 -0700
IronPort-SDR: 18u/5xNev/RDuATJ+EkUQ389/Eq/fmMcbrMDMsEDyQcx9J0vaRezJ7ZssTNCjmCrWYIw1saZQv
 T+6BdDlHODFVoCaR/flSKYXGaubRobwZYH0DISxDEgNwfhe9vflxjCaL6Xm5hlFIRjSmXZZaFN
 x/VqAiOnUYbYUOkQGra/T/AQ6fhzVCJ20orGFNyYmomTm8b1yEvOipHReSPnagdTsI5McrAtnP
 jUgnpwzwrSLgJse3uJegoPqsov6eS/qvGjSl6ZymwRLfnNM24VjraX50adIstAKh2Cfgpi6boE
 kfw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:52:32 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v9 09/41] btrfs: disable fallocate in ZONED mode
Date:   Fri, 30 Oct 2020 22:51:16 +0900
Message-Id: <51d6321cf98f8176e6214aea5ab83325832194a7.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

fallocate() is implemented by reserving actual extent instead of
reservations. This can result in exposing the sequential write constraint
of host-managed zoned block devices to the application, which would break
the POSIX semantic for the fallocated file.  To avoid this, report
fallocate() as not supported when in ZONED mode for now.

In the future, we may be able to implement "in-memory" fallocate() in ZONED
mode by utilizing space_info->bytes_may_use or so.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0ff659455b1e..68938a43081e 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3341,6 +3341,10 @@ static long btrfs_fallocate(struct file *file, int mode,
 	alloc_end = round_up(offset + len, blocksize);
 	cur_offset = alloc_start;
 
+	/* Do not allow fallocate in ZONED mode */
+	if (btrfs_is_zoned(btrfs_sb(inode->i_sb)))
+		return -EOPNOTSUPP;
+
 	/* Make sure we aren't being give some crap mode */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
-- 
2.27.0


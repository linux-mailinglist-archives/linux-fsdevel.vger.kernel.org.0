Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFA79ACD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404732AbfHWKL6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:58 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47806 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404700AbfHWKL5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555117; x=1598091117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JQnGemSRC9GgoTrBYbP+B/iabFUV/w8ISdNPJGyqlWg=;
  b=TnY+Xqlw/omb1Avo0+pGY+hSRSo+xIo8lLvUm1gJ+ajyFgCI3FCx+BpK
   tvDahfWgH/c7/6GfkLbjG+tNpY6SsECgFSoQXRpFcV9UPWo4cvZL4YKEW
   kjVI+6WUAxb2GRJh/4Pt3WQwlq+5JcddpgibSDeE4i3qHbgXEdSXkTbFw
   CiAVyvCWFX7qRpyyag1v/KXK8SVpoZUGbI2U9IBNNvJvOYqDYBPDJ1biC
   LmOdEKAC4ZOkQvcuYCyuyWJrCFuihMEJF+uIZJw3S8AUcXwI4gHW2nYrz
   p1AJWY30GmDOVRgUV9VFu2p0QMDfLdV+R35+v+08gl2FtJ+2ex5cSpIKh
   w==;
IronPort-SDR: IYlqaXEzx010cLDNmz7SQorswWeHwrxmvRmuPl1IgWKbsLlD/PrH/qYAYuE5qbahM3aJ25lxtf
 r1T7i7e/8FIs/VndLoEQZm/DWjlqnfJZVqRfUofd5mexU27a5U8WKuB0w79U8JzU7/mopgnJO2
 OmF7EOvLnjVq+8Wm0GNQtrpRVuWltXhuFag6K9rQIdpbNfbaiKEd4gfjpMdGSSKMBqp7JfWgil
 O6zJ7Jh962bk2hzWXOElh2HLUd3R8ConsBMri5qzS4QTBnSqBBLPZ4T29xzycIXEB+aJFmbI47
 rdA=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096271"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:57 +0800
IronPort-SDR: Ni9XqinKvU1ONUlnH/frLO6oHUOpo463UdBcv0zcGZJ1ErNsNpZVGm/yr3lyGpgcGvHe5vUPer
 d36dmQAxB8jNl6CDbDfwCACP8Rn4t1U2XB6ElpKhJc5fFINAHtXArgxi//uxbJBEu+krmoMiDh
 YzO53mPLAE7FrZXvSuprTnd4duLDNrVIFqT3/+9FgTQTq6gQzrHcHx8y7mw73+Z+zysSeeSlTq
 bBzwhNZE86q2iQOHon/TFzIgFeRTBjCohrlBm7LlKlmJ7N2nfYzXATlcuvpnbIDJWjgUKkofNs
 B6cAJ+KgGnwcTM8zFoJMqLXa
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:09:15 -0700
IronPort-SDR: eDqlaZk5zLrflJaJrt0MbYIuH+LmUUEyNrviosmSVyOYs73th87r4R7vyv1CgZRt1mYFVINOSY
 ZMDFJoOVwWbY7X6u/jG295LzX6LBWMY799JtR9EE0iiNIQ9KYkUIuSMeBCgFLaQfS9UCgSJTlI
 VNv/IlCXiN0L+275WjNiXw52PtJpVVOWejodGGVID0CzM+wu0bNZJiW/vrakv1395ho35h6va+
 xq+7Irf7QY44T+dtrugEdfgxNcLlT6p7VbKP1a/RF8f0qH+e3hPIoCW/+UPauO6jv/ZISZUnC9
 Ggw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:55 -0700
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
Subject: [PATCH v4 23/27] btrfs: disallow inode_cache in HMZONED mode
Date:   Fri, 23 Aug 2019 19:10:32 +0900
Message-Id: <20190823101036.796932-24-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
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
index 871befbbb23b..f8f41cb3d22a 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -272,6 +272,12 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
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
2.23.0


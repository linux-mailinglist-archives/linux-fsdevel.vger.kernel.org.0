Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE6D2E0500
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgLVDxf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:53:35 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46466 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVDxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609214; x=1640145214;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dbW14dbO41wF1P19H34BLRQ31vBlOrekBYTwdSWavus=;
  b=gVR4VWDgjV1zrqUvnglex1HF7eOvsqJ2FhecqX8z/NFygV37PNnEGItd
   fKR94GFzXqJaMwc/Z6wpaWdi/9ydvFOAMJX4Kx68smWLxNtGZ7qYzz5JT
   TQS4aLmJW8ZqSsqBZbo0WOSsShJpaBwRAwDvCVXeMTioaPEc++FNNMkn7
   RzA41pEyb2ZB7mg/BaZ4VZ/sLNd90KHSJPIYSxfZX56cTxhfpbeB/uWkM
   tvGjCwZ5avwmu87fW6HEaDeA0JoX30yd+dutFby838nt2VWI4mHfxnj7a
   nKnvD0yCrTwaZTv05NvaYDu8ekOl7oGbYDTagmgEnxN3GPy5H4Z/+clP4
   Q==;
IronPort-SDR: aF+NF0b8Z4K0fYfxA3cg1shoZzhhqbPnj1H7nnUrAYyEK64zKECf1foOPPUDKTK68AzQtccVVo
 uqSQUqHIK2IwXTsMxvhsB310DH3cTgCZfvRvRF+Ys1hh/TyB+lYeR608KObKJ6BT+CJTBx2j11
 coNDIBHGmgrXY+98lljRs9a/DdSy5guN5xY5bE8yDMtUi5RGP7pnT2nk+rmjWM5343w+uevlxb
 j+OD3wlw99vnUL2IPCcSWZgn722cdJ10yql86DT2WvGL01yowJBbeOpqxYU9Fs8IdpcIxMSTDu
 roI=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193780"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:50:51 +0800
IronPort-SDR: aj8AhSj9FbHZko0NcYimCzVv7k7Owl7HiCueXUdMwvmjMX9oKbFJ2YnoE733bL0mlwkLiq/Bqx
 qbOg3kznYImlyTWoasQQYVB/E/8FC/Km8rLEXSxaq7Ssi5Cj7mQCqH3RBnjXZy9tcQbbAVkDgC
 L7fRqX96bwu2apRqg/mA4Q3xgVrhvvWVUAuqpNh4D1OS5ag8NZiVMUVZC1oY8ffVzaObj9F82e
 7hcXovq2I15kpqCF9ZDYUwAxntXB5dTz+t6uLNUlMO9/N0CtjnWfI+dfRAvcP9lIsM7w8NWsD4
 kzOapYcaPK6LyfneIEyGvTZn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:02 -0800
IronPort-SDR: rRLTkVlMwfxnRQMEZOSEErtj+4BFh7bCuGjFYVydqut3u4EQjZ4PQgo6uHzxB/e6XplU5jyisv
 M+oJEwyqeCv6S8VytQcXMiUiY3kZk9WDsPTnQU99ZuTZpTtuxUuPTM9SJpm2KLt7qScFvSb6ik
 RPcPxHLu/3s8dhttebtRLPkQ6BGcEQ2YDslN1Kaw7pz6psJzhfWhOS0jII+jBPVAR8HtQeuhvG
 KWi9kTxhXBGK05okWXk1ljMte72LreB2JYQU70izMWed1epUFCgX7o7X/8MzoeB7cmcD7RUvAN
 kpA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:50:50 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v11 17/40] btrfs: enable to mount ZONED incompat flag
Date:   Tue, 22 Dec 2020 12:49:10 +0900
Message-Id: <b90b8ddc67765f56b097b35a2ef78b3c86d8db9f.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This final patch adds the ZONED incompat flag to
BTRFS_FEATURE_INCOMPAT_SUPP and enables btrfs to mount ZONED flagged file
system.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index e80ce910b61d..cc8b8bab241d 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -299,7 +299,8 @@ struct btrfs_super_block {
 	 BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA |	\
 	 BTRFS_FEATURE_INCOMPAT_NO_HOLES	|	\
 	 BTRFS_FEATURE_INCOMPAT_METADATA_UUID	|	\
-	 BTRFS_FEATURE_INCOMPAT_RAID1C34)
+	 BTRFS_FEATURE_INCOMPAT_RAID1C34	|	\
+	 BTRFS_FEATURE_INCOMPAT_ZONED)
 
 #define BTRFS_FEATURE_INCOMPAT_SAFE_SET			\
 	(BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF)
-- 
2.27.0


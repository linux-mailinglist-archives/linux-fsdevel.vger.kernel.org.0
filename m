Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE87B2F7338
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbhAOG6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 01:58:39 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41680 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbhAOG6i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610693917; x=1642229917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dbW14dbO41wF1P19H34BLRQ31vBlOrekBYTwdSWavus=;
  b=HyDKfCtLDdvoUXSewtYs0C1HoqUTHhNrn9E5LbPjxa61m2aJP7oSxTS1
   YTB6ULfY67j+k4hMYRarVFtQ8yiTYJarP3KIBsS2xme4bqiFpIi/d8V+C
   T8JVTyFN84LXzBgHIq7IymoCEd+++XgBvy3s8xegW5ctq0doLbJyuRFg+
   BkhRlagnkXEtQ3DBPkpqy/lrA9oj9mqzWRQiqbELDpE37JH24Aq1DPZJQ
   F2LqHumhh5aqhho3xAq00gH+/5jvkkEoPKMTmO3MwZl4WiWx/sZshjOFK
   jJRz4RPZ6howhjO16axYmKgk49NhRzASQYaCjrNf5iwPeJlOowYXnvUZ4
   w==;
IronPort-SDR: 8ifOq/HkPt58Xg5bkf4W5k+/zlZY2rSuUiM2BPrAUPUtIq0Pwa6UbRHE+6RNOqEPdU0NsNfKja
 KDnsFguNlDaRLuE/gv3wBk/paKazqfFPlt7ZlN4ICL6A0QXoxE12S53ruBDIg1gjAW8oP/AWTg
 0whaEp6x59EjQZiOgPwbwgJIOMH8/O7JkGj7h16dCFiHkErO/5NFLRU/82dCDFNmO10MampPfC
 l69v5Xe9BT83NNkHt5BIEZkchDDGSjfzRgtkNLeDYTff2gV3bNPlmyCFfurbK2JL7oQ5/2ZPXo
 MeE=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928254"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:55:39 +0800
IronPort-SDR: m7ad8OwxLSEXPaFa8G8qBecG2KWjIpi1KEr1CrYKTvyzc+R6T2vv7RkqovtZzlqj3g9cahWrGE
 aoK2X+QS5W59zLqJduvbIQMzhdLRO//0JcteJ1oAwo2UQeROlhQnSwXAgqicUfg0GiIR//ZerZ
 hvnVDb0h0b2FmOkTyb8lMgcXTlXtOTsxTev8dz3NFdgF/UkvfP+boyAWLSQKYj5bYWifAD3n62
 IXbV6GGqE7XKBE6Lwr6r+cmLkOD4UISsctKPhY5Ee4c8jhZ8qa6v08bxeaEecgcCzzYp04aWwJ
 OZWs5/1kWFbMLsWkIy/mLlzT
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:21 -0800
IronPort-SDR: 6b9YLNTxg9QKdW372dg2fOoiPL6Xd7/4ayPi5xaZNEEc0Nid47veFnLEYjxXHhBE5ypEvhL1yo
 9+scVPBC0gvwIFL8Pk6s2Y31+cAG8L/exIHg5vbLB07CjHQ62ChUZhKoMmhAJrTxOH0OWeLmNa
 35DflqsLAKHMLD19qPd/Q68niZQtCeGFz5QHlTXdSdJrsqrSBSr9Mm+ENxBT4082+rb7PTU4cC
 dA1pha8VQuZTYmZvWQgEy5oL/WbGAZez5VD79EqcZSibDMxNZd8nfNqVqezWKVRyMM5j8hC/X5
 FD4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:55:38 -0800
Received: (nullmailer pid 1916454 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 17/41] btrfs: enable to mount ZONED incompat flag
Date:   Fri, 15 Jan 2021 15:53:21 +0900
Message-Id: <6a0e5aaae5714f7693fa5ff58ee4d24a84a60718.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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


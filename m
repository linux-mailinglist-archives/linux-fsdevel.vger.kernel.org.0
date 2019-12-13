Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDC3811DCF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbfLMEL3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:29 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11924 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbfLMEL2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210288; x=1607746288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5g5FFyvLuO6DkQ2HFrt9iiEh61bIQwNKiFjyU7DlwLA=;
  b=DflqSxCLohXqoD0c/oPSk4cJ26uo6qBobbtGutP7K1DuiSXWulA2jnkh
   RSsJit/mITS0f+pNGwjwChx48gzXQ2pDiEAhOGdxi89pAS9FcQN4YMDke
   TQf6ZgdPKiNvFPllhA8VElk9+LXA6G1xg+E4tdRG1bgTfaGRz24Yhfw5P
   rzLX6KNaqcQXPVMiLON/jM/K+2CtBw8le9oWw4kBs7vWteJjmhpRfKDs1
   Bw+u9SxJkFjJv2eOM/1HQGRt97JxQfqReJ795PyZ2dPciX0b52XNISFlR
   mPG8r79KDHVGY96KN/zrZz5E1EFiDQMJ6KOdoFNq25fjS3Yymo9qrYG5m
   Q==;
IronPort-SDR: NA4+JwzQZlSU3t830Ta2Dqy4gZ5uH6Du8XY+mPLEYAfthpptyW8pmVv9s24nZQ71esUW23/Pvf
 pyBBeDooXcU7bpb9azG/2YUTxYr0v9SM/30QPHK3IUsELBX66OSyjgYh7fcEgS9n9Xie53Pwhx
 rj41vboxJO9dGN3W8Y07kluLbaOSMFOSUZDHrmXWuLmQBisQUs0ZJVjfZvJEZvU9I9ShVWdyET
 gop0Lzk57Fn/9xN9j0rQFusi6wWyHEY3NzDzCfFcAFN6sdlVQIgl2R6SKeYmjTfMlaQqupUZte
 63g=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860160"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:28 +0800
IronPort-SDR: gfCQOtIqq7Z57yYIDwxANx+C9e7DAdSerd7nIsCMklLfRXQzKZ1bcfag1xDuMsB/58y9zJV1AP
 d9jkKGoxy5rsPm6Msr4c9bony+xKkTL5PSDrwXOMBL2ZAIhYiJcZcoXTmCywP9RFoxBuqBScuA
 +eoBx7sf0aRlFViA+p7yvH/X5g9oseaa/Grmj/fnINPSTyxiCa2AXLI83I2HXzc9GYAZX2Q/Cc
 b6o36WB18FiHaRid46aLY1lcizpzU6pzxQ6yjTHJC7G4+29MwBR+ghAoDwnKDaQagd3V+1JFh7
 QjM+LfLlJ1udiBhpjF3yd/oR
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:59 -0800
IronPort-SDR: wpPP0zZa4YfnTDHsQ3XsBLdy6U973JnxDt2Ud37euL3emdekozweHotBCA1QSmcnEY9nh7IGhG
 HOXPNRcHuRubGCRukI2uVBECTknsaxyCcSDtwsvslvvlguRidV8S5xmLFohTG0/fsPvbOWOsaU
 /8UBMtnthHW7m+RIAaBD8qxIIyPM3X+4aUJkw+GdlBc5IRv3sRt5zJhpMOjH33mp9bqN/RkRQM
 W3ueEmqTeMcqJ63oaO8yQOE+driPZMGrgz7X99XglJ0gymLMt/Lb+zLdn/SJR3awLc54IMlqwB
 V24=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:11:26 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 22/28] btrfs: disallow inode_cache in HMZONED mode
Date:   Fri, 13 Dec 2019 13:09:09 +0900
Message-Id: <20191213040915.3502922-23-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
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
index c779232bb003..465db8e6de94 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -342,6 +342,12 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
 		return -EOPNOTSUPP;
 	}
 
+	if (btrfs_test_pending(info, SET_INODE_MAP_CACHE)) {
+		btrfs_err(info,
+		  "cannot enable inode map caching with HMZONED mode");
+		return -EOPNOTSUPP;
+	}
+
 	return 0;
 }
 
-- 
2.24.0


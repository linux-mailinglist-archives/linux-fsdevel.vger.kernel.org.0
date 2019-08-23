Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA1F29ACAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404253AbfHWKL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47768 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404232AbfHWKLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555085; x=1598091085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZaUosXTmKmM8IeUHHpz+YywFJlkZxMCcI0gK1Q+modc=;
  b=GSYm0+ufa46clO1qF3r37+Isui6QpgI1OMDPD6ZuLddsLu8VtEC60IMu
   3OO09fyOT7r48ZMBwXsgwxuBb3w8hCtB4l/W07tpil3ZmXsTzQpJH2Djb
   VrmqWB8JBK0dbL3zSnjhfcOsBsWRvNIkez2/v/ozOkgRfJwpbtBTKP6Re
   RAtM6QWOcsX6mkceSJve196XV7uaJ/2mhTiNdMiUxZhgZKG1xD5EuhS1k
   hb5nctWhGJplwZQ3WbTSXF4SvVrsxYiUOaJdG6SZE9/9wXT3NmNqNw2xZ
   nxhbUc2TG3IIh/XNfD+2Cuy7HlnzZpdsYNMi3y2fQBWoBiL0r17lMaf+/
   w==;
IronPort-SDR: 5aWX/bZBtkc50ZDvAHJPAOJlZ7lEF6UeFcncB47w41RXY/v7XfAM2+Tw4yPuoVO7C3/+78cvpv
 +HZZXqhpCL/y53Djw+qAnP/9BDHmagS21wKHxpMC8ETk8HczatIUJp3PcKrO+MgC03HNHKiiCA
 toyshoIToKqC9ZI2OAJoQoSd/ghbrvDiSoYWMdyIqGP7bpYWYrLqrwyPfr3WKUYDUlJnSZdANU
 jlitYZ9XZM769VxWCSO6Dt1zB/boPNHDunZSr+F8BiAcnzz1N5lLM+EcG1RTDMxAQP86u9duF7
 9CA=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096239"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:24 +0800
IronPort-SDR: P3qOMvksrrHEUu/fq8lvfrS/81pv2rT5cUbSzjCXis8pEtZ+NuID6KnbtiEAHULyQuE//PEsa9
 2Xhj4obyQ7v4iC5ty0O2nPJ1/eIBbk4S/3gaxFlQIjULqQ5zJcVbGAIRJpgXO2tEFkMS7vFAd0
 ueQzkmmel2ZzsGrEfI6VNOX/ujfHpbrDobOaGY3duOr8a+cQcE9VHAjxD6g+qTmfQCzWEU1lUn
 fgNLcX6bz6NtTLzWvM5Xc2ZxBqa1frQO3ZG1BLrmDBp+6jPTH1dANJA4tOTSuVNh1CQ3Czu7jM
 YLsMCKDn/zz0p6w1DlKXk4Mh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:08:42 -0700
IronPort-SDR: nNK7UsncfKSxEzk/j74pCF/JBHjDbxbNqp/NljQpnqzNKP1A9MZ4SQ/NeIXjp9f94mLwBW+59N
 PZMctSHoTIIt1BE9975xO0PLdaGgd3B6u+fFJCNNeL9KP+t/NzuW4oCY1qhQMkzjAyUlIopLkW
 yC1Y5QR5dmauhmH7qMcYh33yFSC3FkrwLPTvwgTaJ7XeTob8EiEzkvTPQbBcjxlP/liMyW3Yh2
 SiEO1reeC1PwKOss8bzpn2ROk8PZE6ylNdyr+jMCF3zNO1eI1ud7qiJVACS9lr0J84FwP1kage
 /bQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:23 -0700
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
Subject: [PATCH v4 07/27] btrfs: disable tree-log in HMZONED mode
Date:   Fri, 23 Aug 2019 19:10:16 +0900
Message-Id: <20190823101036.796932-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extent buffers for tree-log tree are allocated scattered between other
metadata's extent buffers, and btrfs_sync_log() writes out only the
tree-log buffers. This behavior breaks sequential writing rule, which is
mandatory in sequential required zones.

Actually, we don't have much benefit using tree-logging with HMZONED mode,
until we can allocate tree-log buffer sequentially. So, disable tree-log
entirely in HMZONED mode.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 6 ++++++
 fs/btrfs/super.c   | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index edddf52d2c5e..4e4e727302d4 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -253,5 +253,11 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
 		return -EINVAL;
 	}
 
+	if (!btrfs_test_opt(info, NOTREELOG)) {
+		btrfs_err(info,
+		  "cannot enable tree log with HMZONED mode");
+		return -EINVAL;
+	}
+
 	return 0;
 }
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 496d8b74f9a2..396238e099bc 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -447,6 +447,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_set_opt(info->mount_opt, SPACE_CACHE);
 	}
 
+	if (btrfs_fs_incompat(info, HMZONED))
+		btrfs_set_and_info(info, NOTREELOG,
+				   "disabling tree log with HMZONED mode");
+
 	/*
 	 * Even the options are empty, we still need to do extra check
 	 * against new flags
-- 
2.23.0


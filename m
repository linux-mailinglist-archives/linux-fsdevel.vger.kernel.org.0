Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B129D9ACCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404676AbfHWKL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47806 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404630AbfHWKLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555115; x=1598091115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xx7dT/vkpGscmmJ0xyUOSuzu4Kzk5ohT4mXKP6xnGEQ=;
  b=d7MVJHMQ0GYNNqz9g1gysHryrSGHsMoSVH6PDu9731+yRupJmh7PhgR4
   jVQEo8Kn7aBRLYsE2kT018maf0/+Ye6D/0Gc+p/xbRyHRlbYa6x/xBClt
   yzFe599lo05vk1SmNd81wd9iLQMcUPYNNuqG5LiO8jz6tJtifVZZFerzw
   5g0Vhaa+9P6cwPziRV1Q7D6mshlytNaN/6e8G12clUQUtZog0+gUYlCnJ
   ou5FeIv7JTgMDQ+hWcN0eqry++38+QeuLK8eIpfnYBfvNwd9scphb4S7j
   5cPLuzNACTruf/f83NumP0LyM/nX/nS5KgTXOov0q/MJ8yyUuUl52tCoP
   g==;
IronPort-SDR: ZDgZq4flClcj0wJBTAU314vQII1rF5qAJ84V+KcRB/ewguT2VYz5JtmS/pkJdczrZ10kZ0QlNE
 hyO6Snc6R4uWT9bVn2UvLpkYPl3pv1qKeqYcrNLpXIrD+jyljd3S/a0OhUToMi3EKMnrrNYsm/
 ZZWJ9dgF7kt7ysyWyfWM6DSn4CrSrnuYjygk5lYVW3Vfr5IgjnlYVuuN0tV08max+CjD7c44Ui
 J4ISfg/GHDgdKZP3a1PvCDgA1IzwZ2TKM/1oSQC0wBu2D+HvqYyEwVuDAIC0dDgJaSssDUt7er
 f9M=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096268"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:55 +0800
IronPort-SDR: vooSTlLdlNQlS4LoWbG3tRkXolSDPu4ZxkYMtBcPMoZqlJsrZaHiiuvrDwS/OpWLcpptS0Qegx
 oV0WniZt2Bm+Oy7nnzEEqzmeVl692Ui5vgc7/wixPt0SOA2zgqMRQr26WbL6PcHAXJKAhnKrMc
 bBEmtXiXrlSjEm6rxBWPw3JAXUOji3Vx/njArIUPIGjAht1LWMbRTJ/32pg1w+XdVZluopPzgZ
 Gh22nVBKOBf/DhA6PLNnXPbDg8D4Aiu1DlCyv+kwZwKEHXmkGFAQLPVCRsHfavxdIx0K6VGQrm
 sLibL5pmP6tugOqFywI4L4HV
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:09:13 -0700
IronPort-SDR: T6jVN2CsppX/nU0j9qWivVWDcQmAtJdUYTUnWhribShJDHEtTytI7C16NMyUkSiCQ1Mguygup8
 XHTLwZ/aFtoEzO/l599x9VgT7iTXzkSMlMOnOWC9CsBShMNzqQmqG0V5Z+GsjpnEVQVl9q7qPX
 8ZqoxGER7IAfTrODaisDqk+ihVriosDW9IeOsPpoEHc7VSKLBPV8RusqLDd6bnZCV2qwFKNsCm
 eIzbauGdEAZN0OCfUSkPqen8qcOAR38+SKyAvKdI3Y+8sI/j7fPocmM+fNi9Q7pHrHNxXQZPcp
 yxc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:53 -0700
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
Subject: [PATCH v4 22/27] btrfs: disallow mixed-bg in HMZONED mode
Date:   Fri, 23 Aug 2019 19:10:31 +0900
Message-Id: <20190823101036.796932-23-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Placing both data and metadata in a block group is impossible in HMZONED
mode. For data, we can allocate a space for it and write it immediately
after the allocation. For metadata, however, we cannot do so, because the
logical addresses are recorded in other metadata buffers to build up the
trees. As a result, a data buffer can be placed after a metadata buffer,
which is not written yet. Writing out the data buffer will break the
sequential write rule.

This commit check and disallow MIXED_BG with HMZONED mode.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index bfc95a0443d0..871befbbb23b 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -232,6 +232,13 @@ int btrfs_check_hmzoned_mode(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
+	if (btrfs_fs_incompat(fs_info, MIXED_GROUPS)) {
+		btrfs_err(fs_info,
+			  "HMZONED mode is not allowed for mixed block groups");
+		ret = -EINVAL;
+		goto out;
+	}
+
 	btrfs_info(fs_info, "HMZONED mode enabled, zone size %llu B",
 		   fs_info->zone_size);
 out:
-- 
2.23.0


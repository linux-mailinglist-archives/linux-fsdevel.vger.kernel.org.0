Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C52E95657
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfHTExb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:31 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbfHTExa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276810; x=1597812810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B9zte2SolvEF+uy9agb4M60jeVVydpnM5oPQWx6WUZE=;
  b=g281ck/4lNUlkLsLPVXtAIku1pJWzHl9gF+ENtNHYeJphlPjjJfrAaee
   mkBV24LLAkLVKexmb19tVAor3nV6yzabCtrmmV7pM1IKGWpm4kSFQfhNe
   adFTt1WoMrQ8g/2DdaibUOLUrxEDFpRuQfmsuveqkY5i6f/l6ujBTJJWq
   guLnto4QJjyKs5WEm+f/4WAK2sdcRdwNy4uWS8GG/tgvvYTJxvCG986Rw
   BhdVyMKzWEV6iBkIeUJfh/84i7MNgrx52+/29WfchV5HU05yaIkZmima4
   sIpOqjO40KV6oU0mskLYS9RRmHiJzcrisHQyILXkd4K3GJhgN9wG4Bxqp
   A==;
IronPort-SDR: +xaMGDsWBRxU/7CxZfnVpC90iaHAftvo78VftjP9SOxzEcoi3rat0J/7y40Ch2gJftU/gu6aaP
 oaXQJkEf3cLYtV94cbU0jer2BDsH9Lbxcbn816vSPsiQmNVk3pNRysB+wjPy7+UDBiLHE1DizL
 h+zhbVX3LEev4M+BpA5WKknpoG5E/RprLuGtg+i+gnSPsIsf/sSL7WK3vlGky+fRvotVQxCQ7g
 80RXvOy+s8zJ3n9SUn2JQtEmdcpoasUVAgB5OrIW7lDVNFTJ8iwtqRYjiBhs34JA05rzAaiYZV
 9WI=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136321"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:30 +0800
IronPort-SDR: EJldSskBrn/pICaiSWp5CAyynC8+INYx1nLY3z9W+vQ9L4/k3JOE8KHb99zulq66ZzarwAUtXY
 AI2/1kYI/WhLv2MTpOL0KV4+cNTEs/FBqgfJ370pBuQo8fIkxq2GK2pHfDA5ehUBFyQx0jt9n7
 4QxT+lHsVvjZbhqA2LEWZb3t0M4VfARnqrA3zvb6rGL2CMRGRMaAAR12OKNkskBPD525zZYsQi
 WUtOetAf+1FsfOHDK2bc1zGy6fTePB914DGRXfz9fKhoJXrXo4E8toIHf/OjZKQY8TieYWBxqO
 +sXc/kLqUhTFhhd0s177cZ/b
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:54 -0700
IronPort-SDR: FcN/AhKeWFszuQHYkBAwjyRRNBouxDHxo4+aLGgaoiOexfTctM1UF9wBM6SjlwqZzhLxPwgJcA
 BE1d+yvtqR12x/1CsQn038n5oFXPuEN45x4e/GY8yxRygmkm48DOXEfZNuOOtuY/bRgo8awOA+
 Uf6hfw7QV4Fb1nmLJ3YuxQpWqWYEPnFOf9JA78tMaemPJTNwu6X+nSgvoYb9v/BlX+20J7sxyf
 De+YSgcgWorITk+KEv1zO17BXx252yJtoO8ulplXJJ1Z6fr9H8z4Tvej9xAs74jnU8xv9p6lVl
 ORk=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:26 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 14/15] btrfs-progs: device-add: support HMZONED device
Date:   Tue, 20 Aug 2019 13:52:57 +0900
Message-Id: <20190820045258.1571640-15-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820045258.1571640-1-naohiro.aota@wdc.com>
References: <20190820045258.1571640-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch check if the target file system is flagged as HMZONED. If it is,
the device to be added is flagged PREP_DEVICE_HMZONED.  Also add checks to
prevent mixing non-zoned devices and zoned devices.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 cmds/device.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/cmds/device.c b/cmds/device.c
index 24158308a41b..9caa77efd049 100644
--- a/cmds/device.c
+++ b/cmds/device.c
@@ -61,6 +61,9 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 	int discard = 1;
 	int force = 0;
 	int last_dev;
+	int res;
+	int hmzoned;
+	struct btrfs_ioctl_feature_flags feature_flags;
 
 	optind = 0;
 	while (1) {
@@ -96,12 +99,35 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 	if (fdmnt < 0)
 		return 1;
 
+	res = ioctl(fdmnt, BTRFS_IOC_GET_FEATURES, &feature_flags);
+	if (res) {
+		error("error getting feature flags '%s': %m", mntpnt);
+		return 1;
+	}
+	hmzoned = feature_flags.incompat_flags & BTRFS_FEATURE_INCOMPAT_HMZONED;
+
 	for (i = optind; i < last_dev; i++){
 		struct btrfs_ioctl_vol_args ioctl_args;
-		int	devfd, res;
+		int	devfd;
 		u64 dev_block_count = 0;
 		char *path;
 
+		if (hmzoned && zoned_model(argv[i]) == ZONED_NONE) {
+			error(
+		"cannot add non-zoned device to HMZONED file system '%s'",
+			      argv[i]);
+			ret++;
+			continue;
+		}
+
+		if (!hmzoned && zoned_model(argv[i]) == ZONED_HOST_MANAGED) {
+			error(
+	"cannot add host managed zoned device to non-HMZONED file system '%s'",
+			      argv[i]);
+			ret++;
+			continue;
+		}
+
 		res = test_dev_for_mkfs(argv[i], force);
 		if (res) {
 			ret++;
@@ -117,7 +143,8 @@ static int cmd_device_add(const struct cmd_struct *cmd,
 
 		res = btrfs_prepare_device(devfd, argv[i], &dev_block_count, 0,
 				PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE |
-				(discard ? PREP_DEVICE_DISCARD : 0));
+				(discard ? PREP_DEVICE_DISCARD : 0) |
+				(hmzoned ? PREP_DEVICE_HMZONED : 0));
 		close(devfd);
 		if (res) {
 			ret++;
-- 
2.23.0


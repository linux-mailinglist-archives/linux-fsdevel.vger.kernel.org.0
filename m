Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5966995659
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729258AbfHTExd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbfHTExc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276812; x=1597812812;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nBu49akIyAGHh9SzymnOJF+LRH5iJJ7A21f9W33xnCM=;
  b=k+4OK7dptRKwYSCKSm+bPv9ph2KffdeZ6MfYQ8rQ4zjXi0PmWn3HN5DR
   exZIHgSnqsewSuBkYTzXgsezosp4Yz6Xb8AbY1EadMv345n129hbaTq84
   mdx97V/lVKVtyUf3aHR2XIigJGOfHrwwgcR4eGGyg87XGVxhSvuxJOMko
   dpifrmnSqy5BCU6p6mKSSU3UtN61kS0T00Wn+iEccKds+IAhcWJT1Vz4e
   0/p9usp0IAiq3ThtJC5aZmf+jpol+NTa2CNyNIc+PIHcPcxnw8R7qo/rF
   OJVxxZEgayDYZUZitCMhQVCUl//y11SJlw014CQe3UU8TkYAdAFY/bpa8
   A==;
IronPort-SDR: 0kLPT1oFo6IybCzxEYd9iEDvtsooJanuZdCkf/ucljFCogmhWf3atRvYO0Am3U03ErqxW5/VsK
 v346Lr5yBPTFba2CjMT0gTlZYldP3cAbf2iL3eFsHkaU/b01qkpOfy+VezcAdeU1AfRzRCCzNf
 7xR6nAXaNE8KCWiR7LA0uljNiA64grF2aRpk+0pP7daoHOxA5rMq7d5H97R+t/xGYQGZ8759f0
 AdDwrEQPzmowNUBXdkSf1kI3kAOZhJyOMIj90S0PwaXeA25FUQ6JKzkq5ScQz+He5oZPMwpAyG
 ZI4=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136322"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:31 +0800
IronPort-SDR: A5sUlv4knqi2FYYSI07ulUPNU5sUQL6mEPz8Cp2tGZEgEoIpmywShaESxaq4d/ExeZsdpSyDly
 ivz178Q81gdcmT0JNhbxmoFo4WxciYiKH/XVvo+FFgL6MU/N4Fgmrp+iNnMq3xKUhfx4GLggDZ
 TcGuvsv87EcTLJcVwvXbEiLGB0T+uXmpRuL6bjfrJcX7tBwO9XOaOlSnC5RiJFuctHLfmRwUj2
 TU4MAf9qlgyhQz7spDyVuYN/saoiQN6/ol4RkTNibtJv9I3cgayx8lQKC9Oftts3GbX+vU7Adc
 Xeww0i/FZTee+QlN8p8iCfz7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:56 -0700
IronPort-SDR: e45tWBCatkTPegpC8zgJzlFpe5247SQUcy9uu9jSi8S9fXoR9XXTkAUrwdj/uJBNhw20UQCKn5
 AGGZknKw655lB6h+7ndhZ7fWMt3K91zkR50ylXpViD2kumnvFhZo/FTX89myw5G0meWvxoDvVs
 rM1nYDdO46v+Zy5+Sn1Jqc4UjxDzEcTLLx6EwzVA35s6aJ/LmQGGjtoT37PqFyylwjfYUT4k0+
 s3fndlD8A6k8XIjjh8uPMs3J8q+Y6foquKF692vP19QwXCto55p2VIFewRG88/0BsGSb4fSpqw
 AJo=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:28 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 15/15] btrfs-progs: introduce support for device replace HMZONED device
Date:   Tue, 20 Aug 2019 13:52:58 +0900
Message-Id: <20190820045258.1571640-16-naohiro.aota@wdc.com>
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
 cmds/replace.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/cmds/replace.c b/cmds/replace.c
index 2321aa156fe2..670df68a93f7 100644
--- a/cmds/replace.c
+++ b/cmds/replace.c
@@ -119,6 +119,7 @@ static const char *const cmd_replace_start_usage[] = {
 static int cmd_replace_start(const struct cmd_struct *cmd,
 			     int argc, char **argv)
 {
+	struct btrfs_ioctl_feature_flags feature_flags;
 	struct btrfs_ioctl_dev_replace_args start_args = {0};
 	struct btrfs_ioctl_dev_replace_args status_args = {0};
 	int ret;
@@ -126,6 +127,7 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	int c;
 	int fdmnt = -1;
 	int fddstdev = -1;
+	int hmzoned;
 	char *path;
 	char *srcdev;
 	char *dstdev = NULL;
@@ -166,6 +168,13 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	if (fdmnt < 0)
 		goto leave_with_error;
 
+	ret = ioctl(fdmnt, BTRFS_IOC_GET_FEATURES, &feature_flags);
+	if (ret) {
+		error("ioctl(GET_FEATURES) on '%s' returns error: %m", path);
+		goto leave_with_error;
+	}
+	hmzoned = feature_flags.incompat_flags & BTRFS_FEATURE_INCOMPAT_HMZONED;
+
 	/* check for possible errors before backgrounding */
 	status_args.cmd = BTRFS_IOCTL_DEV_REPLACE_CMD_STATUS;
 	status_args.result = BTRFS_IOCTL_DEV_REPLACE_RESULT_NO_RESULT;
@@ -260,7 +269,8 @@ static int cmd_replace_start(const struct cmd_struct *cmd,
 	strncpy((char *)start_args.start.tgtdev_name, dstdev,
 		BTRFS_DEVICE_PATH_NAME_MAX);
 	ret = btrfs_prepare_device(fddstdev, dstdev, &dstdev_block_count, 0,
-			PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE);
+			PREP_DEVICE_ZERO_END | PREP_DEVICE_VERBOSE |
+			(hmzoned ? PREP_DEVICE_HMZONED : 0));
 	if (ret)
 		goto leave_with_error;
 
-- 
2.23.0


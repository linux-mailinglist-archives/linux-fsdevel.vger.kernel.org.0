Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7C7311245F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfLDITi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:19:38 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32758 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbfLDITf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447575; x=1606983575;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wWVf0lcmjygoveqYvU8ay6sHk4wiR0WqOto3mwXnybY=;
  b=gljjA7dVOv74sBvLC+T1MRbW+zKqel3i/bwNXa59eCgs06RsEOiubbgk
   UzrlDVMe71EQ/tckYQA205E4Xa5O+6Uxq3Pb6tl0bz4jCnzoO2Qj1lJS7
   Pp7rEANZXBOsu+WVtQjOsIXl/MtmQAagkFtUFtL/bj92IOPyNCg+ACJ7z
   RsVH/1SfMZcXyZFxt/f4TI61ifLr6kyaMC2jtnibtDQtJddy1w9YpFtaV
   7F+a8cR2fMjOeYiWfN3gqAhilnE6x4oEjfdGHKuIB/1buHOmJgrw+6Et6
   DyJVan7ES1EWb2aH7OXoZfOxGnyWsL6DOq3zBOBCkiRZX3AvkYVjC2Yig
   A==;
IronPort-SDR: WWucve8mRjCpO0j13mjqY+4YL0ebsFzOgVxc7OIW5lVpfz/Ucfpmcchu1Pnq2TRWbQl/G69rch
 SGInYeElQ26bYVKyc2oiTK65gav5wyl1Ax2MZtX6AZ11FJxx6ADVTyy9Bgk625jGNhHb4HU1YN
 dbmLQscFEUzoZy/xwTBv8a2O9L8FwQ4V/W0u1K3Y+uJh/kOT2vzXYZE4XBbKfhyusbO/4kB0d6
 1vhSSZuO//wNOy0x+3uw5YajO5UJ3ZZg8jI+NexBHLDPgS55UsnWw2jh2sYn5qzX0mXcOWXdrT
 n/k=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355044"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:19:35 +0800
IronPort-SDR: Vss65OUv2CM64D4zQu6tkVs5Oj7qWcpfrPhRo6ReDblC9gwI4c38gQP+AIB2CrFMAuuqWi7KBu
 KbKOVL2k0XkQ/4r9YWvWUA80RTeuQgMCd34ZWEtCPRVI00Jh93Sgu6bSRaPLqiaG1uKaj6r5fL
 sjl9M0Bc6Ps8IV4vpTbAG56Ms71urEsLQ2Sir0IHlCAo92aDyazAM61L2P2JWBKe1joqnY1qZU
 muqQZPFZ5vneNHPfH/93M3kUAHOkNnPCE9xPmgSWfzZdEkjEduXxvlwxoQg2ahPOKETJwvsSd/
 f55+WfwYC+ezdJsHB5thmsCT
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:00 -0800
IronPort-SDR: ZL5KajSgX7aCIrTA0Jj6luvtF/ZgsEX+3xTFLBB91aWQKJr5BwIBGcu4/U29ziKvKIBvt8Otoi
 1KfO444CNVtdvizlT4Jv6P8v4Bpj4dkcImNptmu00rVuSu7DMBVflTxA9H3mkmXUj1K9J4xGZx
 q+f4VK8MRaVFfZRYouN81ia8vIK6vblT9KwaFzevOwfn8hjeeEvkoKL3DVj8gdtpYXMbso7Bv0
 IrXAuiNq5iJiITaz1BVTRTWEsfPcSygH05BYeKwjYtUTwMzKzRtev6JK+uSGtAqGQg+EG1NewG
 zq0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:32 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 06/28] btrfs: disallow NODATACOW in HMZONED mode
Date:   Wed,  4 Dec 2019 17:17:13 +0900
Message-Id: <20191204081735.852438-7-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

NODATACOW implies overwriting the file data on a device, which is
impossible in sequential required zones. Disable NODATACOW globally with
mount option and per-file NODATACOW attribute by masking FS_NOCOW_FL.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/hmzoned.c | 6 ++++++
 fs/btrfs/ioctl.c   | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 1c015ed050fc..e890d2ab8cd9 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -269,5 +269,11 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info)
 		return -EINVAL;
 	}
 
+	if (btrfs_test_opt(info, NODATACOW)) {
+		btrfs_err(info,
+		  "cannot enable nodatacow with HMZONED mode");
+		return -EINVAL;
+	}
+
 	return 0;
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a1ee0b775e65..a67421eb8bd5 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -94,6 +94,9 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 static unsigned int btrfs_mask_fsflags_for_type(struct inode *inode,
 		unsigned int flags)
 {
+	if (btrfs_fs_incompat(btrfs_sb(inode->i_sb), HMZONED))
+		flags &= ~FS_NOCOW_FL;
+
 	if (S_ISDIR(inode->i_mode))
 		return flags;
 	else if (S_ISREG(inode->i_mode))
-- 
2.24.0


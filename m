Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBABE112454
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbfLDITa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:19:30 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32747 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfLDIT1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447568; x=1606983568;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dI1kCb/VRDJYiFLG8VGEf67pizlAWg6fFeBbRKlx4yk=;
  b=DDMuTaAPb8pGBIEI+aLUstPXAn8tb0kIJctDxktP7H6jL/F3z93EIB1c
   Ejmk7M/9lu6DIo/jEE3TymovpCwh0tEobw8bxDuxBORp2W0uUol1JZQ/h
   Vb3rbWTndvK1F2yIE5G1dLpMJh9PD72dBS8GV+23s6K9vWCpQb8tR3oCc
   jEx0/WfBzqw4P3OMUqznlAmrFfaZycDY6WtUWSiJXnaWSMckvGNrvkOpA
   hJAZPKGWzJUWXERI1zg+U9syZxd7ISFLUxPmoQd+O21N1nstBOSyRBriS
   J4MGGjZEpyUU7AfiOtKJbCLZtoOtbur49AV43gwZS0RORK0d5zH5FZGqO
   A==;
IronPort-SDR: 18vFp6JOygJk5TLDdy92KlCP6hL1ES2vYLFM1EjuVQUZ9VDGbi5BohQ1nI2n4pJwqcNcTEt6p/
 eMx8FJssmI5WFDZQVUwbj+sQQ8gAPeudwBpIiOKOdNkYU4R6ohRlK26UQ+bqqnUSlWpfjsnWak
 l296Kjgh2OoSMLLNUi34VFSvHsrSJVmVa6CUQIbEfDuP95wIQVnbsw0xRd12jUxEp77nBRbnaV
 dBEpOJ23/YRkGpgFw/B2X5Kc6gFWZqhRWpeM6JJFh+6aj/3gMjjxbnCsI71c8exJzFtL3Hx9Cl
 Zbo=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355014"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:19:23 +0800
IronPort-SDR: fisbZhC2jFdkMZIGCsCJaFxa5jTmgnUpwsfiu37ZFfybYlOOjBrt6XAKFvUhauZB5yeSUdwnmq
 5djD3mlgr9gHGQrmvaxzYHu4u7VKTKoWWHsYfZD2d0veXWFtoKK2l+F5+JJVA6LVLI6hHRTWo7
 f3xcEOI9Esi/VIxm7roVbovhLdIYimllLwSH72ShJARscLYZt7J21d/P1k5YiRXAA31tAdqW/x
 IszNEGOPIsFwLJXuT6cZOcLaBYbNiZd68jqSJvvO58QxfjrL1DlcUQ0i/lJl7Ht9M0mxyYVkN9
 7p5lgZgC+ElJFvE3XE8tTHih
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:13:47 -0800
IronPort-SDR: 2S8WF8yotesq/tOZmauvDM8LFCh9GaPYxsXEribcHXnlK3r026mSOqQ0ZvJuNTpINQfAgOH+dF
 yrjaOC8yhddUT+9Cl0Z3/MEIzt7Yg+SxtLm9AD453OUQLo++kjqCZrersZkhtOqMSkugPq0aIk
 3+4XLJuoVCps7lGWMaQNzEI0xl580pqLUFUv922z1WOsVMM5YImLOfkEonc9tGGnF0z7urwoxH
 fvyoL9GuWO0VBdqoqjtH0MqQ6XMGf0hEabyIn8tOUopqcJaHlF+leLoVKJOmMfq31ZModLDneH
 KsI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:20 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 01/28] btrfs: introduce HMZONED feature flag
Date:   Wed,  4 Dec 2019 17:17:08 +0900
Message-Id: <20191204081735.852438-2-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduces the HMZONED incompat flag. The flag indicates that
the volume management will satisfy the constraints imposed by host-managed
zoned block devices.

Reviewed-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/sysfs.c           | 2 ++
 include/uapi/linux/btrfs.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 5ebbe8a5ee76..230c7ad90e22 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -260,6 +260,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(no_holes, NO_HOLES);
 BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
+BTRFS_FEAT_ATTR_INCOMPAT(hmzoned, HMZONED);
 
 static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(mixed_backref),
@@ -275,6 +276,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(metadata_uuid),
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
+	BTRFS_FEAT_ATTR_PTR(hmzoned),
 	NULL
 };
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 7a8bc8b920f5..62c22bf1f702 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -271,6 +271,7 @@ struct btrfs_ioctl_fs_info_args {
 #define BTRFS_FEATURE_INCOMPAT_NO_HOLES		(1ULL << 9)
 #define BTRFS_FEATURE_INCOMPAT_METADATA_UUID	(1ULL << 10)
 #define BTRFS_FEATURE_INCOMPAT_RAID1C34		(1ULL << 11)
+#define BTRFS_FEATURE_INCOMPAT_HMZONED		(1ULL << 12)
 
 struct btrfs_ioctl_feature_flags {
 	__u64 compat_flags;
-- 
2.24.0


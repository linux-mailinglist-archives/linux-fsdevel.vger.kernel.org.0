Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3A3B14A174
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 11:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgA0KFY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 05:05:24 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51835 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgA0KFY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580119524; x=1611655524;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pEiBy0/1gxtwKsVjJCWqnNuQe23b5IP2jxA7ZCDT+Z4=;
  b=HZF2gJMo7WQUNNh92a+FWB/48ngcp3yhRbBa2t50itqNzKcMjB738nsO
   Q4KW5/rPPFKWgnRUuKqllN5QjzYUMf1rVBcK03Jzw5EL0xa+FYF2kfAbd
   PzsuC+vzkW2nuq11YsN8ssTTvQKqJHrzDA2EUG0Mum89Z2a4yXVRzIRZp
   2U0BS1NpCsoRuNyP3cZZMn338XLEQCAM8/f3Mm/fWtuGd7zXqPLBglsAf
   CEVmXAeiELLh98Ym0ySWozSJ6gPdQYPVuUISCDs5uUvNe1EMzNu/gIfXO
   M0UeoNwfPjYKz/SLIpgbzgrGKRCPU7gL7pRmwwQ1J62PcYpv/APHGwsLm
   A==;
IronPort-SDR: 86VdYkwchWFRCVhc5pYZP0F7x+ESzaVYp4vrGSSDOKu3S6xZC24igmdZIiHPlln4YZXh0c/QKy
 nAAKxDwi3TNYUDbWpyj6LBUFMm+z1lEVjKJSF5KeDXCVWietRPUFYA0agW+o2Hqu532tGBZR46
 HQE/+12XjI5gE1tARyTmqBNwfhVDreF41GPZTa2G0hTFWMpB7sSr3xFtBZiIKqPOaXZUVhw56O
 Hnxk/iGeHCoOhH4GVcf0vo/7aHyY2nbkhyEzJ4ELAPGUzxVQ91fShiH9tzj+4LUeqkjnD1HXRM
 uMA=
X-IronPort-AV: E=Sophos;i="5.70,369,1574092800"; 
   d="scan'208";a="236370278"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2020 18:05:23 +0800
IronPort-SDR: F+I4MwcEstzyjXXCAAbm4mg0aze0UeF9AwQwYHQqW4Qbch9V3FEwbXyvOZtat0z46BG1wQBQv1
 D7kCe/aG+7hhTW+3iuUyJapACA/shBaZqFJ3Q1h2JC4CB9ODcezgW+loDZTDWZeKCOKgPXWeFb
 R8Q7b4+Rmjrhs9gZGDnY6C9o7zDE/XLZltO0JniTKoIXw5Hbf6wGobuKpS0nbCBrzuV1EmZQfB
 poFFDNia3gyrTsMvgaqXi5Xf6e2+6jjxzP/s6e5YrhClOyPXFvdOlSIoYIe0wXIrBlwbT2N0A/
 aSA1svQt/xHF5lia8t7FFGb6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 01:58:39 -0800
IronPort-SDR: nSL08Pnm1XKeZY4BMmzJQ8RhxMi7j0wi7gACcOOCZWMcMxDr8Ggv8z1Xt2yR9TSTbA2CLJtOT5
 VrkDXeJ58OIyNpJJpIAt29bUPaZl4WLnNm8T4TbiPt4WixoiOdz6uS+V9pt0xao6RVKThbrGV0
 PtUWJ7gAvuWQXLGo3mGpYDf8Nluj9PTAjKqGRugHnyXKtSeR1mj7jWTykCJQB/nggKdaKEeSW/
 zI89dHpgtGyFMa4zjZqsIg7HFTfd9xFdLPZzld5d8kgF5U13nroq/nF0YCwMLmtuS+d9j0pGAW
 8GQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 27 Jan 2020 02:05:22 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v9 0/2] New zonefs file system
Date:   Mon, 27 Jan 2020 19:05:19 +0900
Message-Id: <20200127100521.53899-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

zonefs is a very simple file system exposing each zone of a zoned block
device as a file. Unlike a regular file system with zoned block device
support (e.g. f2fs or the on-going btrfs effort), zonefs does not hide
the sequential write constraint of zoned block devices to the user.
Files representing sequential write zones of the device must be written
sequentially starting from the end of the file (append only writes).

zonefs is not a POSIX compliant file system. It's goal is to simplify
the implementation of zoned block devices support in applications by
replacing raw block device file accesses with a richer file based API,
avoiding relying on direct block device file ioctls which may
be more obscure to developers. One example of this approach is the
implementation of LSM (log-structured merge) tree structures (such as
used in RocksDB and LevelDB) on zoned block devices by allowing SSTables
to be stored in a zone file similarly to a regular file system rather
than as a range of sectors of a zoned device. The introduction of the
higher level construct "one file is one zone" can help reducing the
amount of changes needed in the application while at the same time
allowing the use of zoned block devices with various programming
languages other than C.

zonefs IO management implementation uses the new iomap generic code.

Changes from v8:
* Comments typos fixes and improvements as suggested by Darrick and
  Dave.
* Improved IO error handling:
  - Better sequential file write pointer checks on write IO error
  - Extended zone condition checks on IO error to all types of IOs
  - Added mount options for controlling the FS behavior when a zone
    write pointer corruption is detected.
* Cleanup zonefs_iomap_begin() and its use in zonefs_map_blocks()
* Ignore RWF_NOWAIT to avoid out of order writes on sequential zone
  files.
* Improved documentation file

Changes from v7:
* Fixed static checker warnings:
  - Set-but-not-used variable in zonefs_file_buffered_write()
  - Use S_ISDIR() in zonefs_inode_setattr()

Changes from v6:
* Fixed documentation as suggested by Randy.

Changes from v5:
* Added simple description of zoned block devices to the documentation,
  as suggested by Johannes.
* Added a 64-char max label field to the super block to allow label
  based identification of volumes using libblkid (checked with a patch
  to libblkid).

Changes from v4:
* Use octal values for file and directory permissions
* Set initial directory permissions to 0555 (no write permission)
* Prevent setting write permissions for directories

Changes from v3:
* Fixed many typos in the documentation
* Use symbolic file permission macros instead of octal values
  (checkpatch.pl complains about this)

Changes from v2:
* Address comments and suggestions from Darrick:
  - Make the inode of OFFLINE and READONLY zones immutable when
    mounting. Also do this during zone information check after an IO
    error.
  - Change super block CRC seed to ~0.
  - Avoid potential compiler warning in zonefs_create_zgroup().
* Fixed endianness related compilation warning detected by kbuild bot.

Changes from v1:
* Fixed comment typo
* Improved documentation as suggested by Hannes

Damien Le Moal (2):
  fs: New zonefs file system
  zonefs: Add documentation

 Documentation/filesystems/zonefs.txt |  258 +++++
 MAINTAINERS                          |   10 +
 fs/Kconfig                           |    1 +
 fs/Makefile                          |    1 +
 fs/zonefs/Kconfig                    |    9 +
 fs/zonefs/Makefile                   |    4 +
 fs/zonefs/super.c                    | 1366 ++++++++++++++++++++++++++
 fs/zonefs/zonefs.h                   |  187 ++++
 include/uapi/linux/magic.h           |    1 +
 9 files changed, 1837 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h

-- 
2.24.1


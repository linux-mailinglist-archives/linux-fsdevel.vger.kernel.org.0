Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCCB143754
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 07:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAUG6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 01:58:51 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:58166 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgAUG6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 01:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579589929; x=1611125929;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C9Oazg/Dlz/0TV2QFeIaW8exkStFXLR+uu/hhmATpTk=;
  b=fXpXGrsiP4+zOU12NPKjZOU5scRV925XdhXVJscb+PXTy3CJG6N9jU+I
   daosbK4qQXBrc1IQx777feSkIVGBkVA4I4Shp1NyDWX0Jc7xe+F8eig4B
   QSj9mstysrU/PaVSJGTvQa3UHPFDXMUKXlaPpw86a1ey8ull5aaZZG66T
   50zjv7fg2POXfucpwuc+Vy+uKTXegtiEgQoEYyuCPW3x4Npfu5C85/iah
   cN8bWdKbQhIgRWgE3DcE2hJJ5u26TJAKbG3v4PT/8QF5r5wkUBK1jDsCn
   s33RWd2eeYbcHJtqWGqifp431qQVyK+xeROb1wt6nk6QWSMYj+gZAqQa2
   g==;
IronPort-SDR: E6SXDf3VxRNPjNIFHKHBah9JfopvyAWyBVbpebjvNOO2mtY+UmHOxSDSKzAsCktaXl/jVQdNp+
 qWn6vAU3IcLNqFEVXOhi4zbumpNbeAz2T81oh/L8QGJOBurXm3XoLZxmSbDr0EnkNVBH0BvPIQ
 s6REWbcSHfxto6p8P8tt6t+T3n6c340mo+ukolI9zmfQxu0J9J1HpsZC3OpQVls97c33zsPSEO
 CyHoqWHU7PdsmpnsYku7Lt9rP/AmJ7hlVegg9DdOIw6/xve8qsDgvco5g7+ls4542E0uBM9qtm
 AzU=
X-IronPort-AV: E=Sophos;i="5.70,345,1574092800"; 
   d="scan'208";a="128665445"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2020 14:58:49 +0800
IronPort-SDR: CVT1MsF6VBbZWyPQHM39feSivsC7f+i40AtvCEHhLBryWvW7Wwh44H2hiscZcUEdR9S0jF8/WJ
 vWMmHNWLKd0C1VSRw3NynhhKub9nKfS2wDguJ2Cw+9DvHrhnMhY+LYX7nrWdk0ewkSmjVXBxm9
 Xe4KXXhzb8/8dg1/t5oMmAZS/jQoJ5zqKpOjbeEsFSmophfLkf9vzUAI1LJSDsuvjbbOLljVG2
 uyBCVtVX5nf9OBbffKGKUDDDEPrRms5/pNiH1cZjve0zE1s2oRR22ra1n6v+yJEErGDwelYXyw
 GTjl7Ckp60UGL4McqUgprEsu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 22:52:15 -0800
IronPort-SDR: gFCd7JZ1NWxCFZYAwKSqwLTIlQyQjolRxw9FmgVuGRZMuj4VnFhO8XtP1uDo704FKYML6B+9RJ
 oeDhjJ55ssVljy+zbMbaMfZVCHAB89TaoIpUwhOyl3W8++zX7omebz5r7P3Uw6OLLFwOqSFT2U
 oWaTStWGiekgJsjj5nFdcdXy3POLgvzrEqB0BFCu4ez5aBCJ5RSupqygYiOY1u17F5vnJSxQAM
 1515LAAMnu5tD3PlWST3nDhi5LK9utN2ZSasJ+ry1AjqglzC4IwaHIhT42mHad8AFOQUNA4kiU
 YfQ=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Jan 2020 22:58:48 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v8 0/2] New zonefs file system
Date:   Tue, 21 Jan 2020 15:58:44 +0900
Message-Id: <20200121065846.216538-1-damien.lemoal@wdc.com>
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

 Documentation/filesystems/zonefs.txt |  241 ++++++
 MAINTAINERS                          |   10 +
 fs/Kconfig                           |    1 +
 fs/Makefile                          |    1 +
 fs/zonefs/Kconfig                    |    9 +
 fs/zonefs/Makefile                   |    4 +
 fs/zonefs/super.c                    | 1178 ++++++++++++++++++++++++++
 fs/zonefs/zonefs.h                   |  175 ++++
 include/uapi/linux/magic.h           |    1 +
 9 files changed, 1620 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h

-- 
2.24.1


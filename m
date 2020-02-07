Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB811550E2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 04:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgBGDQb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 22:16:31 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:60812 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgBGDQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 22:16:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581045391; x=1612581391;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+2WThEHHt7KIj3oLeCAAyyJaZ7DMkUYjvDAOAA8HZAk=;
  b=NNiVUrQt7bTJKqpSZht0O1nGX/oVCfTBNfMqL7u5XHDtcmQySeoEOlkE
   dR8s3/wWLarOfzvSYgVT7wjc4HQqDPAQ/Inoci8ICYMNbexo3ACGM+q/8
   Bt+No1B9WYw0xnRckvNrYHhLOsddnN4BEp2K168/q1dYKliIcLUG6uCYy
   qqfagcHmgyBMyLFEwFKrIE5gf5Et3PRa9PE2wbVihuunl+iRrOy/gbcv6
   sESDTyJe2W+8hOxPuSHT4BeJV5PO/RaXT8MbQ2y1nE4sGvgsLmPNuiSYy
   UxmOhmm+hq3UTFmgZ2xKI7ANwJ9VdOirPDUL/7oNjTIco4EPlMTGrAfc2
   g==;
IronPort-SDR: io1EHGFE89rsDYAKAV9j+NBMXhFhrEoovalbjbqjm/mbX/x2vRNx4kNzCYDNxBCXt+uYCJRwba
 SDtbAREEdhSxb5nyTv984sQF+x7Nznd2yo4YQL/r4pzkQb27aT4erMCWrU2ZrgLKJ4q3R6jwKT
 OiQKxv6QZ44K3PrGfaotu15kbY5rbGFH/Q15U3me6x8/Er2nlr6g8gEFFs0HqLPO2nkuEVdP2v
 v0h+mf6sq5K9CTWkEO/3xSzhbfx3OPZ6/LUjJeWFkmowvDVpnluMY2MXC5QBy/X3FI2Jz0xiq3
 x7k=
X-IronPort-AV: E=Sophos;i="5.70,411,1574092800"; 
   d="scan'208";a="129872400"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 11:16:09 +0800
IronPort-SDR: aAiAO+4dawkc+vhw2b2mCGGrDe8aI3v6QCBuiKD1R9eM50TP5W9eowcWHVVbBcTZv/MsKwbmh+
 eZWilZy3FIKdGsYUzK6bbC9Bvm5iVxT/RChjaykhjBzXGsKGgLic0BW4J9v6DuRuTcl+KLoj+H
 bs6tGkzvcmcaUy16IIlhs3omn9Tk17eU+GoCvWnAvhsVU4RSXQQBarQ9L+SdDmEgDCAK1pvqeo
 2+c2igj+/bERAT75XGwvLA7zebd/DgJab9bU+EPV8e168zM//GZRyv7LVz/FZoWEGkU838nPG9
 cqMoXmsNGIZSkLhaORDKkKMl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 19:09:06 -0800
IronPort-SDR: if/YQ/NuTEIOUnUVY7azHUN7FU8kpnJ4jJp6ioyJkgElM6L2CG0xlp1Dlka11OL2PyDQAjok/R
 01urtmcrMd0+Jvoqs1og6HzatK2l873zRACy6b6YnfDNAq+YpVAPF9T2tEa6WJNUDCm0gLVRvE
 ZTdDeqyzktxCy3dKFZhdgv4+oX2TZRNsZp6qmexaZo1CGsiCOAakKYbVMIju1hJp+P12ezezv6
 +ByUNqCYGka54YWIZ5NbnPs5Hkk3ozY8QFN4Raiv7dtirBhGTdz32dEJERYIyPgw/fv7fujPw8
 9tA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 19:16:05 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH v13 0/2] New zonefs file system
Date:   Fri,  7 Feb 2020 12:16:04 +0900
Message-Id: <20200207031606.641231-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zonefs is a very simple file system exposing each zone of a zoned block
device as a file. Unlike a regular file system with zoned block device
support (e.g. f2fs or the on-going btrfs effort), zonefs does not hide
the sequential write constraint of zoned block devices to the user.
Files representing sequential write zones of the device must be written
sequentially starting from the end of the file (append only writes).

Zonefs is not a POSIX compliant file system. It's goal is to simplify
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

Zonefs IO management implementation uses the new iomap generic code.

Changes from v12:
* Removed sbi->s_blocksize_mask and use ALIGN/ALIGN_DOWN macros instead
  of open coding alignment to blocks.
* Small documentation fixes from Dave
* Added documentation patch review tag

Changes from v11:
* Improved I/O error handling description in the documentation (thanks
  to Dave Chinner for the suggestions).

Changes from v10:
* Simplify zonefs_io_error() while extending I/O error and corruption
  types coverage.
* Reworked zonefs_create_zgroup() to avoid the use of on-stack file
  name string and the need for the array of zone group names.
* Fixed a bug in zonefs_file_buffered_write() (incorrect call to
  zonefs_io_error).
* Improved comments throughout the code.
* Fixed documentation to describe I/O error handling as implemented.

Changes from v9:
* Changed mount options to a more useful set of possible actions for
  zone corruption handling: repair, remount-ro, zone-ro or zone-offline
* Check IMMUTABLE inodes to prevent write operations
* Documented mount options

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

 Documentation/filesystems/zonefs.txt |  404 ++++++++
 MAINTAINERS                          |   10 +
 fs/Kconfig                           |    1 +
 fs/Makefile                          |    1 +
 fs/zonefs/Kconfig                    |    9 +
 fs/zonefs/Makefile                   |    4 +
 fs/zonefs/super.c                    | 1439 ++++++++++++++++++++++++++
 fs/zonefs/zonefs.h                   |  189 ++++
 include/uapi/linux/magic.h           |    1 +
 9 files changed, 2058 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h

-- 
2.24.1


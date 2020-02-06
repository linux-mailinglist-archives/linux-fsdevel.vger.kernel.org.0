Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75412153E36
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 06:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgBFF0e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 00:26:34 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4155 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgBFF0e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 00:26:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580966807; x=1612502807;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1T+w740ykI10ZDV6hTKeCe7BYKMezk8PL/Kewm+bFRw=;
  b=RQ1G6AlQgvHgJufvX0O2WH9x6Uk3MSo+6fHLFlCPgIJUvcgBYR4Erzrz
   yp7KLMIPNYOVbEfVCN7uKe/eBjTD5jAhYVIl+uyN0Mj0VTm8hr13R47NH
   j1MsT8jJ8yFdNkRJisHWNroBh+Md4J+3e7fJcd4wyinl+Bgf0UJkrm14T
   tAQEddV4mb2VN11+mki4HkjwjgSPnKhR8Yin6Nc08W/xe55os7Eitytum
   g9TehiinPEj0W6cgrJE1e2oEGriY6eGxf5p5LbyHsv8bAR/g/7f62V6Ld
   VL0nJMGvMjuoAsp9SK2yqv4nTeHWaUwdeRLf7hw9oHoMZaGl3+Sdiyb8L
   A==;
IronPort-SDR: C3dBBN6VPO1yjt45SCI6WS0vncsKGZXMpt/pgSdtyT2AHvMKM5VSkAmn7A9Qvxak4N+0Wg/mW+
 0DXW9xRuyBYCB8AcDaygeghitO/ugszbFer/H2pzc4+yxEzbo32NJuQ2iFbmQxghjpk8azzg4Z
 yFYorTc5x5hVn5XEJZokjrteiCZQqaBVXfMNdOkblGgpVqpfeKzsyB9CWY6TUueoYBYh3IJrh8
 Okwyirn0euz2l5XNURoqQw9xiIra6jvfefIzZ5nIaPN5KBKvZ9TVOAj7IgiVHuQnY9dPr8kc4w
 paw=
X-IronPort-AV: E=Sophos;i="5.70,408,1574092800"; 
   d="scan'208";a="230968086"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 13:26:47 +0800
IronPort-SDR: HSxSLWxa16fTaeHX0l/sLSV0VMExC36HyErQ0f+Smnel8VjFJlUzuVU8L4RBGJnwH4ovZVDa1N
 D2TdhtYKsxwv0Z7GSocSJR0TozAHwC5KKkQXVs0/ExCKhEvPvKYEdIjv9mTvvBNVAbJDKp+ofH
 rktjqKBlglOFkezziyHPjp7OKvCEjRJLzzstkRgtlZY8mkHCjVIha2mepg9qIoPhazOMRBWVYS
 Fvt1e7LxGRcxrJcWgJH6fJuinNsu24CKFLlxEHbFGvcPZfsDrdV4x9cQnlm4p1TtMruOdGpYMp
 K+Xr6NeHt4EkhhhQZG7FfGVJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 21:19:33 -0800
IronPort-SDR: d/H1pp9P7XmAOxl4lWntem8FwnARUkOivWqvpNbEthRyj/Fe1T2VE3AftHZA1m+9J4gqq3SyDi
 XQfwbTA125P5YxeTOuTM1S9T94yBEZnQnz9ppvlm7DgCBX9jkECmBwZOFNOrUG0FGCxU/tu6an
 JrPHBWqTjSDfCS9lTLlvAs9AFB2UE2QLoMotUAGpMc02MWRp9/RtQwLGi886j2v4/ls0y80CUE
 ccydPHObZZ5N1BxNfh3ymTLOgw50HqnazJvqYumSjBjdsD45cwG1Zno9SB1rlv1NdL+Saak8Xp
 cOA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Feb 2020 21:26:32 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH v12 0/2] New zonefs file system
Date:   Thu,  6 Feb 2020 14:26:29 +0900
Message-Id: <20200206052631.111586-1-damien.lemoal@wdc.com>
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
 fs/zonefs/super.c                    | 1441 ++++++++++++++++++++++++++
 fs/zonefs/zonefs.h                   |  190 ++++
 include/uapi/linux/magic.h           |    1 +
 9 files changed, 2061 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h

-- 
2.24.1


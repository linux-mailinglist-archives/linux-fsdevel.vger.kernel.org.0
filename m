Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D717C153064
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2020 13:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgBEMIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Feb 2020 07:08:43 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:60741 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgBEMIn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:08:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580904546; x=1612440546;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5nseEPYtjLdM+sI7lpq+YtHxkIrsbNc4+ej5OZqdF0k=;
  b=YTTPEsljbscykbfzo5ZzYR3TSleCUOnLnKajRLabsEN5UIxG82iGYVqN
   QoHF1vOErfz6fySuTdvWNySIZY0jD6N64FRCOAps3lum3lm9Pe6jgnyXH
   ssuv66gckYQoX4Do3e4GZk5xEQkK4EThI/zwT6A+rDkwH5YelJ9WycqYs
   63PJkeveOgO7QHJ21XHGyO7aUuJPSSTbeB8W56Z3a1vPFVAKmefuLY5rT
   dQp52meRtHGbG2hFPrMlmQoOHibCW6SnqAgag8w0msR3LwyDWzGFxdF64
   1mESCFxcgtHxFRc26Q9BeOl+i7cC2KBEX8tbTX8A+ZI9nUIXnRw+ZfC4x
   g==;
IronPort-SDR: m6yz31Nk9Du/2L+KJAZHHRJ1rvcsQOeCzi5/HF83B0Y0BpDm48pua+U64Ml0iUuFn7GCx8HNhp
 m7cbFFW0yWGkeiWj13DWQyv8ivUdoZZd9ctwY1PcMyB1xxA3s2/fmtLOmXovAv8Ahd601IyWEm
 NObvWJpZjfkyNatW9+HRPnDGnBxXXQIpXPpX/XAynRIex0yZ+YZijlufNpPKR90squjuM6z/Sh
 n1+eaVaERBFbCKWHuOWNJZPnC2wrH3hpNc3RmYAfUYYzM/KMnOvXVnJK/eVWuTthP4n5rAAIyP
 lbg=
X-IronPort-AV: E=Sophos;i="5.70,405,1574092800"; 
   d="scan'208";a="230892086"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 20:09:03 +0800
IronPort-SDR: v2sJLRXzR0OrLOG3Mvx7pBcpyY7qVASqWI9wFsjt9F5AIC6CChYtFPutY7wbiWnFJT9sD/hdAE
 UvxLMP//9PDDUN6eaNzn6MnpyG2kSqSrTcV45tEsTpPLTw13d3LVPSGS3AMBvH5dIW/1mBeSim
 O1RIdaEpVp5KZ5FR2FVZC74JGvz/XCR4bkS/AXieXkNeB0gV440jXnUREIWv2XuhcZN95GwyFd
 cVF3lYL1HWP320uMi0Acbm5z46rTJCusK4Mavg0YeFn3VnLTtlbHQ/qjCLSO4MJ6x+sCp8GVHp
 ozFkRnCk9OD4tcXDR8bUDG6Q
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2020 04:01:40 -0800
IronPort-SDR: iZx9L3wIvhBoCUDs3UXDHpLyOjsVnhi60mL6W2G4Mh5RCenJoeiWlqRDns7S0yfT+JudNePC3c
 1psd7p4KuS5JYSbVLgycki9Rp4NDmKcnJQkOvwjJY9aCSNDhv6S+Xj4lIrDi1HaZVPfsTOPYga
 9fVLITuodEMUF+EeMFFse0fT5mfQ77eBA84YvIKARmoLV3Amqxg9mW2YILoDpdlFB66+yb/mEK
 3uu4zQ3/jczt+saOWLyHoPSFXp2QE/x9xAOgIZCSYxiv2UtiUdSUUY9H0R6Y3CpnS0M8XT/oi2
 5Yw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 05 Feb 2020 04:08:38 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v11 0/2] New zonefs file system
Date:   Wed,  5 Feb 2020 21:08:35 +0900
Message-Id: <20200205120837.67798-1-damien.lemoal@wdc.com>
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

 Documentation/filesystems/zonefs.txt |  310 ++++++
 MAINTAINERS                          |   10 +
 fs/Kconfig                           |    1 +
 fs/Makefile                          |    1 +
 fs/zonefs/Kconfig                    |    9 +
 fs/zonefs/Makefile                   |    4 +
 fs/zonefs/super.c                    | 1441 ++++++++++++++++++++++++++
 fs/zonefs/zonefs.h                   |  190 ++++
 include/uapi/linux/magic.h           |    1 +
 9 files changed, 1967 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h

-- 
2.24.1


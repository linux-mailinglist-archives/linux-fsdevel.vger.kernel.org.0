Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C5314CB36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 14:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgA2NLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 08:11:24 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26879 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgA2NLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580303484; x=1611839484;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kaXbQ3VnyLKhAOOw7SmGiwrO5BRWfXbeUMYSdvwgVDE=;
  b=lmlYOn760xTAXVXygnWi4y0/btyN27HOm4acXhXxUT+dEpHIeTjro8y9
   o/v5OIzRnNQo6uK5DdkQBKyFIELJyVFe32W7t9Eix7PlaH+P/CumZ9lCJ
   mIDN0lI/obGdYX7Cthj4tZe7aWoZbNoMIP/N/LX3vhdCPuI6Rqan2vobR
   y/n5H3hMo4r2G7kOjbGDrmPuVIwrRE2TtzVM10r0XqcaBFHyN/sODYMEi
   Andw3MNP3u6qRbEVL+nwDLuJB704b6ZAG/IP9cS36KZJy/EDMzW/yRCF8
   ah8B1U21E2o43JSlEamTWNg7SsrGG7yQSc4488TwpgDU8Lf4bZ8yP2QoO
   A==;
IronPort-SDR: zGSgqjxPBoMBDj4UvVwnC+Hd4dsj0nmN7urzfrqHIqn4vYSwzupEAekcDuDLH94YBlLixbpa24
 gWpi9GmU7i1ouxzWHg2jyX2Fv29GIiwjx9kw4aOu/SL0NUXP+/c2psRV202ganQkfuto1X8VWA
 5UxA2C/DCBqbzColZOYXHuzA5QGuqIdEUvJWczq0RBuVG+2/uB+qAEt18Ry4UMoiAuYSSklWDe
 508Tg0WiWnFyD5nYjhxFSl7Nzu6vOBQoGE2+0P/Q6j7LA6jXtHPJkXhrPaO+wyTDv/dNg5HSn0
 l+0=
X-IronPort-AV: E=Sophos;i="5.70,378,1574092800"; 
   d="scan'208";a="133015486"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2020 21:11:21 +0800
IronPort-SDR: e2GORArXlfk71oZu87mud0q3siLFLxoxQ9Kn5dGG3aQzq2dLl96qiC1MHJ5kX2p+bUgE7Js3U3
 ThUIIS9xJcEcyUZ+Vun0qAW8D3gd/BpIytSw30tXoXrLE568Yn4rkfYMasw85E/RnwAtkygIm5
 jfmLVL8xYAMI8ADJcNl+UzxYG40heeFXk6GfGsEgGZVhkULXAlJYO9cs3xiUSaKVhkH3l0jPRV
 gIKdCkEq30ybLdg/r14w7ZfZs2akeqDkuv/RDYHBvqFxNBFKWiPbq/cMOAC2wgnDNXdawLDNtS
 gm/T344+WJpW5WmtzenhpCVq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 05:04:33 -0800
IronPort-SDR: CqDzV+jhUfE70hV9Hd1ksIudoG992u7Ybs4z4GkZz4kh8NmifeotyTHsMxxuPxxrEQp8bculEy
 OOhpa9plbeHX7W98gPh9IgGDkHlwFPYasJeozeNN4ImQGk+6xB2IxrtmR5mg9sI3Dl2ye5dGhw
 A5q0s+Gw7WrXZ8fKH1mWVePH9dVGuZtjA8pxFYAXLpBtKbwVsvAE688calcNczMr//xNHLtvRp
 EPw50iJf39XD+KwquiBiGPArsG9Fq1V65V5G/VxGJ4YTY3Wgh0FtkC3li98ZJbsdwPyMb0a0IG
 5CA=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2020 05:11:19 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v10 0/2] New zonefs file system
Date:   Wed, 29 Jan 2020 22:11:16 +0900
Message-Id: <20200129131118.998939-1-damien.lemoal@wdc.com>
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

Changes from v9:
* Changed mount options to ia more useful set of possible actions for
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

 Documentation/filesystems/zonefs.txt |  301 ++++++
 MAINTAINERS                          |   10 +
 fs/Kconfig                           |    1 +
 fs/Makefile                          |    1 +
 fs/zonefs/Kconfig                    |    9 +
 fs/zonefs/Makefile                   |    4 +
 fs/zonefs/super.c                    | 1427 ++++++++++++++++++++++++++
 fs/zonefs/zonefs.h                   |  192 ++++
 include/uapi/linux/magic.h           |    1 +
 9 files changed, 1946 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h

-- 
2.24.1


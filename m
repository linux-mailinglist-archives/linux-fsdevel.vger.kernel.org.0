Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF707133D4B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 09:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgAHIgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 03:36:52 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:42733 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgAHIgv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:36:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578472612; x=1610008612;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RZw4fJRDKODBrpS77sy6ig8sTH7XmTRBFGi4XjXTMsk=;
  b=gpkqejkdT3XXAWvO6kT682FWVPUtWd7y2YTEn8fGA0/geRPEd9GVsKu2
   pg4rI+Jo2t8SUWhnCWcRMmpGZeQ5eL+O8vsbi7oRkaTEJgLV0uibKfU+f
   qgFrHpTxtGGHGfpk6C2xwiPpqHtwJdEXKyS+po9Ck4nOrehLRB6849ZfB
   1j5GvmmryoL7uPYAi08BxpQjeS3rWYrxjWc59fku24MOG3QWBhUuedq8O
   2JnRDJT0RqZJBFttNrTw8apMKPv07+z9G0fMxnxLOybq8s7uv41+Y80Tw
   hje4x+adXMmT4fDFdDTYRELUVtnReK9bIAEYHEvtFBuGp94OojrVMRpm5
   Q==;
IronPort-SDR: e+zhfgWskNTyYkcTJgtC2m/mz3an8VoyJEnvQnXIueGBYX0eMkxIfzgelvoUCqo3yA4Q4lOSDH
 zPvvCLGs83g3rCHmISfakNKphdkN7KTlvlb06mi2GbU6lIeGjtv4yQqD+75pg0ghWNqpspeFQR
 vL15RTnduX2GD6Z1lYvdBXxo/7/sepO0dobn3JfIvJDXIo7ZDkXMczB5PDazSPy9cgN3rzy2Vw
 Vde2l79x0yhAJui6Qt27316eYXcQvSk3lEZ2WJ7IcNtYNyycqPBbdtpv6bpOddHuy/GHdjWgNT
 VpU=
X-IronPort-AV: E=Sophos;i="5.69,409,1571673600"; 
   d="scan'208";a="127676480"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2020 16:36:52 +0800
IronPort-SDR: HJJzXmMFBp52Ku24qwUxdPKfbxzgxS5Ws1Vo8cvs7FSoL6tsp9Fn2Nw9s6qRsy5XZfC55TiESl
 mYiO6VznSFM9kHsEahRW6gBu5lxjfx5H5BOOFBeJGpLVgGn8zs3LHKZCkHx8UgJMMq6vDOAKnz
 lTFWXru+XTDkykLarXQW945M4d35399j+85QSXFx6Vz6A5k4OvSU6ERd7gM9I+HEllKiQMiGwC
 njYpzVWrcuGcc85x6//Ocj2EcqSh//cJ7ahQnCohlJIlhK9V3v67MZNSAVQrCuA/zfvAEgvhoV
 4skb4h2M1fcb3Y1lEDxGaUlH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 00:30:39 -0800
IronPort-SDR: pxymLGGSXSPFok/kU5jddnoc1zcxAubGflpW+wAAt53PVY57/SBZ+8butsKsB+Zj7scFuAG5Fg
 YNiTS1plRgtTagdW5CXRA8Ugh7YIZ/utF0LOzVSNbAFiZ9HtC0tSjyaky2Sns5ZIt3JwwOuF4i
 Mw4SMtnB8mUHUOKr3ouljLyCI41w/5SW0Nho/lxZgMK5+Nj83GAZjapoucQtfrZyc9abfW01/b
 TVI3JBsajHubea53QGQ8E8eNlm9NFa+edcrynaKwxzJCa0ZrpJzcaQDVXr3DZUJ8WwiT7k7M8y
 yWk=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 08 Jan 2020 00:36:49 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v6 0/2] New zonefs file system
Date:   Wed,  8 Jan 2020 17:36:47 +0900
Message-Id: <20200108083649.450834-1-damien.lemoal@wdc.com>
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
 fs/zonefs/super.c                    | 1177 ++++++++++++++++++++++++++
 fs/zonefs/zonefs.h                   |  175 ++++
 include/uapi/linux/magic.h           |    1 +
 9 files changed, 1619 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h

-- 
2.24.1


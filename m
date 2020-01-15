Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4D9613B992
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 07:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgAOG3C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 01:29:02 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10526 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgAOG3C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579069743; x=1610605743;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SCsTcYRzZqT1XjwZdj77fGQo772pNnre0Wi0mSnjoFI=;
  b=M3gPje0UpgYrxz7TdZ29P4qVW/OxA1Vq3T6ASLJX3tZ1xcpwn5uE3gia
   DoNFouVdVg9DjS3zUb3plNrup3gt3k84mitREVLMaFmDAyprkRqnA31uu
   lXmv6h8nen2xueXi/5vp/ogkxoIxvUahQ1JNhmufiS1+KWnqXNkMpGEU2
   aBnDl6X964cn3fUlvF9kI1DreLysWc3AfKuBvprlRBrqBxhCTxEtaFf8L
   I0grFrpRJY4wV65TEQGeSvHiTXZZea1RjG5xHhO2/wXyXrLwgFGolQJdk
   kEJ3lnYrW4BGthQxTEPwd63yIveJUxSwnty1qQ9FynltfQ5QU3QJY9Ajg
   g==;
IronPort-SDR: UeMichHTGOKgD2xukcc1A62+Mr9SCQtkDbzdQqKtPQF9KsaYxYaXfColzrafPITPRSMMSP+DKx
 8hwFUIg+ty1v9/2Qb9AH4IwZASFZMf8isYF/HVZ27Rs3F0MZhYsucZvgXAfwpPapX2WVuFwV23
 XyqnN7/4Ea/F/o1/qXOIsoQvQUL8d8hPDUq9IzoikHX3DvVrscyjB+teaOqpBtDZ8yGFnoSj/0
 eS2jMA+YXBHrLx61U03YOXZZ6nrBPV2YjXg6ze5ri3LHxlAhJ4S2Y6z1j8YiwTu6uEtxxRCuXi
 DRE=
X-IronPort-AV: E=Sophos;i="5.70,321,1574092800"; 
   d="scan'208";a="128190374"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2020 14:29:02 +0800
IronPort-SDR: givL/56iYs/HOTFjt0iwtB2ypPrM6PoAAC8pCpCbUOQUpWOvsuZnxfYaIb+GMKTXBr8vrkKQg+
 3zUhRoKOaz+CUvsasj/hGgCIMgshwHFOZKUXOuDwgZGqAaprp4EVOffgHv7vnkCGKHnEkq3aZM
 LN+0ouQ0i4mFfoXCrPvXqmgKl1jnhddMiF4MN75muzf6U/YNh56XS9H/I8jSNNm0TqAJAEaghP
 8SVqY9C84qkTFez3p1f0dUn1yXyaklTonkNknDvTbL3zlGqNLGRgOdpMXsIllkRgwOWO1XACcb
 nIu6YcjtuajHms8rqdKmkTAC
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 22:22:38 -0800
IronPort-SDR: ebK4vff9IG1+U4hC0i3SfKYsOxq5FDoQuOFO5/NrWEcCyGIj3loJfyDrTcN1b9aUmdKHOfvIUJ
 vDOmCuazfJ0hfgz4mPwc2s+JGMuRXPgrIvW72GvnC6zijgP2EGBH6N6NCGndHe761VRpoosFs7
 Wfu1jGztqsvu1YqwRM1H7MklI9l23z/SCACLKFy6LYeckwOOhGJTQ1XCEExFRrKeopNM5j7U/W
 sOn2HR8UFLvizs8InyuE/J7sjdDf5Jg5liH+t4UhjFLi9WwVZCGz0QeZnQujkTzsOhNj7ZidfC
 A3w=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Jan 2020 22:29:00 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v7 0/2] New zonefs file system
Date:   Wed, 15 Jan 2020 15:28:57 +0900
Message-Id: <20200115062859.1389827-1-damien.lemoal@wdc.com>
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


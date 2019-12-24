Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61449129C93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 03:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfLXCGT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 21:06:19 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53366 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfLXCGS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 21:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1577153180; x=1608689180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rJyFssg2r/VXKtVcX1vzyYSq44mKspPdAlg9fnzFV8E=;
  b=Ml6PTl96/EhHdZnoAZAzWd69l+6UQCdYAFCXG/VzdRClA1d3cHR4srDS
   lD/fnM/KBdeaE1V5hYMMbNAOTBkvLQbpsDxWByI9Q6TEOXtCKF/VGiH17
   rY6/u8LPUVel7I5rgfQpa4mu8HHA8GKjHQF5cWjPWybmMtOr5LmGnhsrn
   0XPSKcQDXsXBZSCsj30GhKV2NfZcFaSTjmWLHhbBlUcS6nB4WTbckH5V+
   X4IcTAkRfDI5KscrLEQEDQ5Ts3C0t1pIvG1gj19KCUqyRb7feinTE6ELs
   D8cW1oh3Qo8FsW5/Gqaswp8W1t+Y9OL3PwPHC5+dEj/d+anmItygmNnJq
   A==;
IronPort-SDR: w2d3fvTuzMgB0CcpZ8dreoaF+cqpKTQmmyZxTxwY4T07HO2IZdk24Crvihl4+yl/08vvmSKavE
 K9cFObOz3lGcR9dwSCjg4+YTc1jQa9m8doVg6a7MnhTgk64ydXPjCp56TwnskhGXx85RHWK/mM
 u08VrWo3AHX3pUvX9OzS7v+TNio+oRen/nPPtkeaYxEEfgtPz0+i5V2gpQHCif2dc8698zbMfw
 Ivd37MyJeqyVPfMyjmYpLMoyMH343QXM6MkdQ0lnykhOo2XenhgInCYcmSGTq08Cpn9CtxfW5V
 LGI=
X-IronPort-AV: E=Sophos;i="5.69,349,1571673600"; 
   d="scan'208";a="227655365"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Dec 2019 10:06:20 +0800
IronPort-SDR: ELObOa0HkakgkAWaGpVHiiqQTNKU3t0qdw3e9gbK12ZoKvDxWlJCFOsjg6JsP+mZ9QfjO8Cc5x
 szxQvTaMRs7guHXANViTFzC2DyKyZi8siiorkoppdCUfiLLW1DVnp6M4cA19yqR44211XJqhmk
 Fyr+tLt2IC5aGjjj2qV7Pi78pcf8Ec46yUBUSYQiXyw5JX4GjWoFY5j3XkkzSJdOG2JgbmBTWD
 TBht8RPkdQMqMgsbB8zY/O56pRiE52hKOjsTlxOTb1BkgkWSrnBzrWYCCb6z/UFZFRQfsKHPKX
 cdzcHwOJO4Ad47aKIBY9jZoR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 18:00:10 -0800
IronPort-SDR: yAD7UckSSHKpGggA95egBfqrmtfFFE1xmyOfIYjrZD8l4yKeD94PaKyQz4UxUOzo/US1JlChyV
 4PdVDxpoM9354mGD82og6YPUF+hiQIUSuPzfmBQg8ThH6O3nZxOSplUp7YrYIYFhC3NChW+Njw
 mtuedUzQFOYKWSuuny9t6josxX3f087VqZvydrtHO25HZUKIC7rRc9Fvu3RMXvnIJNM5Q1wiRZ
 XzdEKbaoWlWtBm8r3BVK3OU+qtVEKnGRcI99iQRNRirJZfqkURrLoAsKT1JMikwUMTfvYoaq0H
 zSM=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Dec 2019 18:06:17 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v3 0/2] New zonefs file system
Date:   Tue, 24 Dec 2019 11:06:13 +0900
Message-Id: <20191224020615.134668-1-damien.lemoal@wdc.com>
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

 Documentation/filesystems/zonefs.txt |  215 +++++
 MAINTAINERS                          |   10 +
 fs/Kconfig                           |    1 +
 fs/Makefile                          |    1 +
 fs/zonefs/Kconfig                    |    9 +
 fs/zonefs/Makefile                   |    4 +
 fs/zonefs/super.c                    | 1166 ++++++++++++++++++++++++++
 fs/zonefs/zonefs.h                   |  169 ++++
 include/uapi/linux/magic.h           |    1 +
 9 files changed, 1576 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h

-- 
2.24.1


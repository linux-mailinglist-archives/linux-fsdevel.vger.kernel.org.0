Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2B11D5E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 19:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfLLSiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 13:38:20 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21723 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730427AbfLLSiU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576175900; x=1607711900;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yzq8zYld7NGqoSLiavkVyh+2krjFk621+a8Vx86muSs=;
  b=lk6Af0r5QHNPnZywdik5aVsJ5U402Z60vT/4ZDvMsnSsw3CvOLpHJxzu
   K686/z07AH7xvJamJH/zlRFF/rJIcHVEaNKO3MTSAtrSvIFzRyVaxO/xe
   TC+8iqYnkYeE6oyOBHsxe+EhpHTpueBXrCvznyNI87D7+ykSa7iKVeAks
   OhbLb5jcnBS5Du2OplJevFlD3s9iOTmnBRUX0pd6yjv4Zs61S4c3nLnAA
   YtDur1Fcq+91GOvm2Dcfoq82cRvteyC/KAkxiysXvI5/++Hkn27/FyypA
   ZrcjXDcUdS36aO6BEhMcmzMgjuor58GsDzpTWKz4XJjcoFWJyEURq61uz
   A==;
IronPort-SDR: b1+aXZ0u+ZtqMHzrn0UtVKKE4WBEFJIXMOpotz+lXEQ7bCS7aiUDbf+4AUTGd0lk6fouvBgVbS
 XR7rrxL4yNF9ORM5H6hFSgywrfJ1zQnhVOIuj70h90ahXa4ZWWNdxlfilSW/MZv7bhgfesA7Ls
 pWi1Pf6Nk700v3vcP1eY5ogedFtyhhCWIVsep9+sSJy+6qw/xcnzEE+QI8tNSbpya5U4hceeeZ
 RqnL0WxQOr+/KxNXJs6HUkSmxSlPAdh8sYmaDPEzXmF/760+XWkEZFARbqiHquJ/6BsJBMpjUx
 sGw=
X-IronPort-AV: E=Sophos;i="5.69,306,1571673600"; 
   d="scan'208";a="129654454"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 02:38:19 +0800
IronPort-SDR: h7N+v+recdJeZQ+8I9uh2pthv01QyUGCqOzB+zAKHySt+TYWGYTCZjttLbnxnoNF5Y+TRBUAvS
 NIplnhOhg/77XBSKxkLZcmPkG39x8uUCSEYs1Z5d9DcVvuvoCrtTgntEdyWVZ3qZvTMvPehNEr
 Qdydgebxd2jt1VCmudxkulkKK0up/evQt8QAZSABo8K153IfqgSh1+/7qXr7/EYS2sCHR0+3s7
 h9YwuiiQFxZH8i6h8BN56U8M25Sco4oUOoKutKHqcUSwQd4o9wCmlbLYMBj9/z/hSRaZfvFJf6
 Z+nnqP4Gfus4rQdDptKnYKjx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 10:32:52 -0800
IronPort-SDR: TPgPTPQlHtvgIqj7eK2+O+Gg7txK7Lf/sg7RxKrMHrZnCyjUL7PaTX1kLoGO2r1Jv9yXoOoYIw
 53KvuTynalDHC4MQPD5z75DqS42pwnELCFtSTSVdf/P1awUo+DD9ZJu+dRYckR2oW0dAYWWt3n
 0inWPL5vYCtjpSsTl1cuNlY0UEGzL5L2MiUmhH8CJg7z+SXOB1cYcHReT3Ew0utcM8wsMKdTzl
 UOnCm0V712HkojiW0BUmeEvqIMHn+NGB2lNDfRFrePjpFJFNbrARDxwiTcI3jJwueYYQIO+vVR
 ef8=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 10:38:17 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/2] New zonefs file system
Date:   Fri, 13 Dec 2019 03:38:14 +0900
Message-Id: <20191212183816.102402-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.23.0
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

Damien Le Moal (2):
  fs: New zonefs file system
  zonefs: Add documentation

 Documentation/filesystems/zonefs.txt |  150 ++++
 MAINTAINERS                          |   10 +
 fs/Kconfig                           |    1 +
 fs/Makefile                          |    1 +
 fs/zonefs/Kconfig                    |    9 +
 fs/zonefs/Makefile                   |    4 +
 fs/zonefs/super.c                    | 1158 ++++++++++++++++++++++++++
 fs/zonefs/zonefs.h                   |  169 ++++
 include/uapi/linux/magic.h           |    1 +
 9 files changed, 1503 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h

-- 
2.23.0


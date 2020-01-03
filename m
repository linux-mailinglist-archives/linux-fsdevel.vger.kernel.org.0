Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99CF12F2F9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 03:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgACCes (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 21:34:48 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:40683 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgACCes (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 21:34:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578018888; x=1609554888;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PAtfvcekb89WlhaRaXkFsHmkw4Pc81MON3+237beqVY=;
  b=BEro2kZIa6bEW+fj8qcTjK/2/3W5D3uyPz7D7fLLPhTg4Sc+uiSSk53e
   TUYSZ0sh/dBJqJNPwDdhNb7sohLJRo+VukEMYzOmKkvB8UhCJRj8C5NAP
   pr9JzA9RlQ4KI0WudZ+WXu/nqi2EFerQU6PhOl9WU1rEEuSGb5tUdpnoN
   emS6mIpKiLKauY1jbFhr336v7uJxW7dW3mCuLlYlgP7iHsAJ3R6VJ83Uy
   yuMCIDfF2mTcNKDIhSiunA4o73eBQJfPehPUuYs6YJ90PgMLoa7OkDAxp
   qu1S7JVfKDrnmxbMf4vY9qwaNhgT4SHQSxcZDSdP+wG4zCNheEdfr2kUW
   A==;
IronPort-SDR: zfTUjUpqhSotskcQbT1OlhfVpfBOKW/9TTm64bkg/fYOUX04Fbhy1E7zhvMKt9UfWSOUU+mzHA
 58oS7RBGnzXRzDmWV8D1oT3YUgTp6nrqAO60cSwm+ZU13nhcw1vdwhe25jDp1hY73KttpNHYvP
 4nYEAI6zIOWIeh7j3OKZpep26DfcSiRDicpL1Om+K5eE9jY6Hk5TSwlt9RK2rXuX7BerO6JT2v
 rb0/0IQUSoJ3cBAzykui2T6AsceSGjULBlyiKrON2ERCrKYEATWD4VDY7MVhws2TQkZggdglae
 dXU=
X-IronPort-AV: E=Sophos;i="5.69,389,1571673600"; 
   d="scan'208";a="131113639"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2020 10:34:48 +0800
IronPort-SDR: FKDtZ1bwSdzN6LmX6SPdSgFd6Lehxk4Aorq5/gMcIrznr5bMw0OsOagKvr4JUu/RBX+TW6Sluk
 DPxUeyVezlAcCpTULWnYcCJRUB4vDUDvr6jHHWBbUtBTWzlp8OyV0hYwwZ127AbTG7HN6rJlBb
 yIuOO4kxU0uLNO3TjAZswNvjrT6FgNIa1/ED8Z/wGIga2kAXlO3OQu1XbRuxjp4VDKe3lFZw6u
 qlf5L4eq5xzbdrgBasiFI8q/5bkxp97Z5E+t5p3xuoVRcOB80t2jSlVf4+LunWXf76E91I3arN
 kVznDmmtbt7WPcsesUN5myvq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2020 18:28:44 -0800
IronPort-SDR: rJkCrLV7XHrw38Tp0OG3c6E2T0D77WsvWVf1rY3y8+OFwjZ3gTIOPijGHCpmb4RbonEy6EykMF
 XWrbU7ukCtDCOnK8Ul204EbyvI96L9LN8RGDZ2QpovPEpQGAThS7/bwjyXt5wqnY5Dvp6syaFo
 wCllZFyJPVQu0dawoVqHVx3s8GJZiEgdu2ZJLUd0c7NNgMjYh1bcyYgenOGeuTfNyMwRAMugKh
 xwoUBeQvLjnFGR4t3MyQDnUnr/uobCX7Ug23cMcqgvgQVA1LP7B0ERy3YygN8ufiumhpc7I6kL
 TMY=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Jan 2020 18:34:45 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v5 0/2] New zonefs file system
Date:   Fri,  3 Jan 2020 11:34:43 +0900
Message-Id: <20200103023445.1352524-1-damien.lemoal@wdc.com>
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

 Documentation/filesystems/zonefs.txt |  215 +++++
 MAINTAINERS                          |   10 +
 fs/Kconfig                           |    1 +
 fs/Makefile                          |    1 +
 fs/zonefs/Kconfig                    |    9 +
 fs/zonefs/Makefile                   |    4 +
 fs/zonefs/super.c                    | 1175 ++++++++++++++++++++++++++
 fs/zonefs/zonefs.h                   |  169 ++++
 include/uapi/linux/magic.h           |    1 +
 9 files changed, 1585 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h

-- 
2.24.1


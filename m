Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F019312A6AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 09:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbfLYIRU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 03:17:20 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57094 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfLYIRU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 03:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1577261839; x=1608797839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hQSC1EpdWNIGIeM/LWhhe+AvxG97v20xEiXNGSC0PNI=;
  b=HMWBaFXPWBWOV6bTwu6FIcbsl7dli92Aer4+R2b+ZSbYsifXn65QSTne
   6Ucr5UA/ce9WAuD90RmyBs2KLBQZw0Ziej/mQ8zIwlePoMt0Kwj1r2wgM
   yITwBzWVB5RiM0ypC5OY+EGWlGfRrdy5nPtjJjbnYTg3fdHllzNYcQpvt
   Gy5TOB7Lp8lPscXFL8UJurvRGc5FxXVlPIqs5QXWT5p1ubj8AlWOawqcC
   beAcTMpZWiR1swl7DllUqWaScWjV/eCpJaPWO89IG1g4dBdDtAQ6JG71y
   i1bBqUXtsnfDoHJznfesqhbk9KdjE4U/QD3AhFYOdIHxxPrqphcj4durq
   A==;
IronPort-SDR: aAVzk4ZlXqo1J6ld5l2JMnfb1fuc2+G199zSh4TjMFFwRZzDvc43o0qz2SN+EdG/2PgSs6bK55
 DNy+Wls3tdCTYc5jFJjFQkf47uabZdR/HgVLnBvCqkDg5wfW8f48QkXQfzz6EFNpWQdZ8h5sux
 GSAiHyhmxiTilHsptx2aPP/Lf6QXGBkh979aVizwioKPevujlZ+Mab3O9eN7Oskv04psNx4R2k
 ZutmjYqN0OLedt09uFz1mBj0gH/DNNEYA8fhXkHtTWSHgfRuBeZORlyAwGDVdrvz3/bwwHHPma
 7zA=
X-IronPort-AV: E=Sophos;i="5.69,353,1571673600"; 
   d="scan'208";a="130541476"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2019 16:17:18 +0800
IronPort-SDR: 8SXxj/MF6eTQ/v5Y12AfnE1Pe/IxC5sfUVXm5WYDWIpav0U7oKfAcZ5R782AnooXtHQgAJ0mXy
 c7KarEaAxfUU64tu8KY9BVLOs+UyXVSh+DLPDnrVYXsErsvwLVkaZwNxeSruA3ky3FMUdMS017
 sXa49qQL8axRn3SJV7nWmSX7oqm/Dr7X+Agy3uiV35R7eApqHr1FdLjj6DgoBUV+jmxyn525fj
 iB5jYAaIYdK4B0kLNeLrVRapBoUWu3XXaGIE69iv/zZ/8lcIGuLAJ0Q47QL+HHavLod7JYluY4
 J+BQC1sQz0cyglKo4XJ1OYC3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2019 00:11:30 -0800
IronPort-SDR: 2QzkjoRoIHJzJkX92tvBLhGFN2647oJTjiVwOGBDf2925Su9JLcA3WKVLQ/PFoJ4hr22MBHIRc
 LOtMO92rPtkozgY49RCuZHff9rGJs88S1QfjmRFkwLLnw02X07X773EHRNorHDSJ4yOZ51zTVj
 bYELiFBHmR82OAxYGn6Z9yWlVq7pHYEi9BDDirfftCC5t0B/f9F30II4Z5rUtu/lEIoWu8uYxv
 VI6OBHRKfLGK8HwFbRZMXvbj0ovBJPHoapTrGm+zrDcxnpHjOazZCkibXyVyFAizROR5riomxD
 ruc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Dec 2019 00:17:15 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 0/2] New zonefs file system
Date:   Wed, 25 Dec 2019 17:17:14 +0900
Message-Id: <20191225081716.327348-1-damien.lemoal@wdc.com>
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








Damien Le Moal (2):
  fs: New zonefs file system
  zonefs: Add documentation

 Documentation/filesystems/zonefs.txt |  215 +++++
 MAINTAINERS                          |   10 +
 fs/Kconfig                           |    1 +
 fs/Makefile                          |    1 +
 fs/zonefs/Kconfig                    |    9 +
 fs/zonefs/Makefile                   |    4 +
 fs/zonefs/super.c                    | 1165 ++++++++++++++++++++++++++
 fs/zonefs/zonefs.h                   |  169 ++++
 include/uapi/linux/magic.h           |    1 +
 9 files changed, 1575 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h

-- 
2.24.1


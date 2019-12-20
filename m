Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 396661275F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2019 07:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfLTGzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Dec 2019 01:55:33 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19956 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfLTGzd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Dec 2019 01:55:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576824933; x=1608360933;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p6HW/orEkeI98IrIWa8f4t4rBCRPzGJFpoAOyyMNc2M=;
  b=rGj3AAtLMrMgpCCnUWlpbpDEE1zpDqV/u9nF9EGEONMtQGFO5jkTnMA6
   x8SYBl/Ttc5VIv7NfObpUyPWWJs49NhnDUU2UNjIi71D1KTyj+V2b3IAV
   VXy9Mr+uhg4j7/g+zMqPyUohAqM7qP8EcTtiuAzuwKaDSqMoy/zC17NJw
   Un3l17VrtIC70ddrWnt5dtXDOkmQ5WNqlsq+r5PC8k8NEghdPLt6zLveB
   TqXqqe+/yMqVwImCcRopciH2xtqgAw2Q8En7Ytmre3bzy1EjIr9Lb1oVh
   hE3eKsgPy/N6XwJEVNhajaThs9RIeQY2dxOHPzbivkASVhxRTpj7Osrlf
   g==;
IronPort-SDR: ylKh6rP8ht3FOkzOXs2dy7oyWSCUrfzg3cfeWOFlZWHXv503X+LBV6vKJK4zycD21BxzoMzkYj
 q3I932bieVb1VTDuM7VlN+IYE25ZTZ6xejBnBLnuDNYFDzuReC4aViLqbyIzkjWdQOC0vb1w9d
 KFtxzIiQhrcF1LtBYBPiH0BecdBw9dhTxDoS2RTvmy0xdZVX7QSaz9YyUCbGEDoBvYUNeVD8km
 /hfstGopmxFMW2/FcgRd/WapJ1IQ7TzQafvgUpsS9t7GCUy4022q0kLUpWml1pOC1nly6lqdiM
 1hg=
X-IronPort-AV: E=Sophos;i="5.69,334,1571673600"; 
   d="scan'208";a="127398471"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Dec 2019 14:55:31 +0800
IronPort-SDR: 4PXrd4EuGXV+zbKrMfRWLWdRx32z+abq9aM0d7JMRQVfzlxRUyCF7yy5YoBL56StQxggsZG5ef
 H0cvHAMUvfY9VIwACK16G5dk+cZxO80PhWsRcSK37fmW/5sk3j2RYWQQu1c5+F7JHHG5WBwwFc
 q/cOZ7sAxLnE7XnLjNyhxOruHhpMXFoFdU/BvE25c3cFolkeuYEmJEnwKCtt9vwPbYNWTf0sej
 iTVJuab/Iy9PAGQqW2yingqD84GHzZHPV3qWQ9HQlK5SAqM7daHkPR6loLw4fLlc56phkY9vUa
 e6hsSdmPNV8B+AU0nO5T6s7N
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2019 22:49:51 -0800
IronPort-SDR: L7HvcAQ+HMUl93BipiIfarinR6wnhTbw2ma7EZvOF11W8maIOUUuBQfMmutesNXshr2PJJuijT
 MMp6n85ndE/Xs7K3al14/qXScLex4BBqCBxdmY6/uO6O9veC8/In1KdiZ/Oyk/2mO6dayAGH52
 bIJYeyEUJyIUQOQ7Z+VKigH/TZLCbbkeqQbu/qtNFiHJhpXMu3pyRvj2eIXwEiENKDMRxPS6ih
 VpmqYUgfrz7fylBQBZ9n4smDwKaKf8FsIixPEsjC/0wT3+VPWwRRCRVgn0wGYCG97Y75SOLlH1
 x3Q=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Dec 2019 22:55:30 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 0/2] New zonefs file system
Date:   Fri, 20 Dec 2019 15:55:26 +0900
Message-Id: <20191220065528.317947-1-damien.lemoal@wdc.com>
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
 fs/zonefs/super.c                    | 1158 ++++++++++++++++++++++++++
 fs/zonefs/zonefs.h                   |  169 ++++
 include/uapi/linux/magic.h           |    1 +
 9 files changed, 1568 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt
 create mode 100644 fs/zonefs/Kconfig
 create mode 100644 fs/zonefs/Makefile
 create mode 100644 fs/zonefs/super.c
 create mode 100644 fs/zonefs/zonefs.h

-- 
2.23.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDABF3617FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 05:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhDPDF4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 23:05:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63371 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbhDPDFz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 23:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618542330; x=1650078330;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vUztHQeoC7q+dlfBS4+pbWv7aImp+UXJRbacb2BFxI8=;
  b=DqNG00SIyRf5dUHR46SUfQZXuQVOwuY2+kATozprSlGw0ax3NRa8hKjW
   ZRUdEfTJqQ65qDsNxTZPqyaofawIHXYEfnWmNnTfD6ruXF1x4r9pHmKl6
   GdZx2EtJDWeuzj1k85SAs6KbzqjKWwINPeqdBVJhAtvNN4+NMozSlSNfK
   kY86hGSah7Hld25qLt91ra56Wl8X63TKXHcRj8Aa8Pien8eEmXx+4KGa6
   S+G5gxOuRu8fRi7sRoju2thqd/04+NCb1nGn/fCeJmldlHxJHtssqYb8e
   kzPACSSOvFZsiUYscIVeILz9YMzGOOypZPlHQjq+M/UirrCj0YkamcVmR
   g==;
IronPort-SDR: BlLgXTtMDWfeVwZUUPg2+J3v5fhkcbdHXJ5N017M7Ar9ucFN1ynHUyTFGxF6OhodK5gZCcT204
 9UOd37heNlCeFiF67xDuj6dxAMCv2HpL+gRh28thl27Qdry2pcs+bQ3zulBb5t2uBLv5c7pYuz
 trkhFAd/KGuo6bf2g+99YsF4YnhavvmKOI8VB6yPqK8+69LhLajDr76Wvn3s1qgBrf2kST6yIv
 iJyHR6jiKtzKGEpwLEqzWQvrnkxt6/QM/Kb3pSUyNB9uvGOqwwCdRSZVCDNwJbom7ls3J9qLwm
 9rc=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; 
   d="scan'208";a="169567850"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 11:05:29 +0800
IronPort-SDR: 4hIfWk7dqM1i6o8CppCZiRBg+JyZk0DZ0y9DXTzSl4da20/Doi1EWrYf6F03TfFRyHr/Wc7v9u
 X1KRPm9Tkk2+2sVUrjQn+vmcgDOFttHK1qCsXjS836YFLnUwO9NKeU7w6N/VN33bbqH2EUJGZG
 4bWwQ+6smbMegX2hQQjyehB/t+hyKorOpX5JUO3Szs1aNP3fllqhbF8n/j2UHgbzz/m1Z4B1rM
 YI/11ukia/3ylImRsA2APdOomTYbuWfc7M2zT8Zpjp9Icld7NYhSsnfXt27O9EvEC5S8WERpN8
 DauQ5ZxEYMjfkWkoJ8qfY6oH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 19:44:48 -0700
IronPort-SDR: 5uaHx0ME4yfxIf/TiutCrTMnLjb2kBOpJtRTKSLg4tH5AbhRWHekMEEGKLa3AXqEYy3a31snCo
 ElUXAQxKJQa6aOhWFDCPzlc/IpBsAx5KR6EDXe2ZmlnAA88cCbpAMSRLACPaVf/fHSYLQd8IgO
 DxavW3RSuugPmrGUFvYDSFHbIBbCHilMvHw4PQpzJEgqusd0uGMzfwXRxK2a2urB4I+6r1cg8f
 s/TX9LXikk5YOZaAYTcUE+pTyB5gwDGLNtSP+JbbsKm5Z1xjY+x4TV2Bu/ZpK3jUK5XA0aSsC7
 IoM=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2021 20:05:29 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/4] Fix dm-crypt zoned block device support
Date:   Fri, 16 Apr 2021 12:05:24 +0900
Message-Id: <20210416030528.757513-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mike,

Zone append BIOs (REQ_OP_ZONE_APPEND) always specify the start sector
of the zone to be written instead of the actual location sector to
write. The write location is determined by the device and returned to
the host upon completion of the operation.

This interface, while simple and efficient for writing into sequential
zones of a zoned block device, is incompatible with the use of sector
values to calculate a cypher block IV. All data written in a zone is
encrypted using an IV calculated from the first sectors of the zone,
but read operation will specify any sector within the zone, resulting
in an IV mismatch between encryption and decryption. Reads fail in that
case.

Using a single sector value (e.g. the zone start sector) for all read
and writes into a zone can solve this problem, but at the cost of
weakening the cypher chosen by the user. Emulating zone append using
regular writes would be another potential solution, but it is complex
and would add a lot of overhead.

Instead, to solve this problem, explicitly disable support for zone
append operations in dm-crypt if the target was setup using a cypher IV
mode using sector values. The null and random IV modes can still be used
with zone append operations. This lack of support for zone append is
exposed to the user by setting the dm-crypt target queue limit
max_zone_append_sectors to 0. This change is done in patch 1 and 2.

Patch 3 addresses btrfs-zoned case. Zone append write are used for all
file data blocks write. The change introduced fails mounting a zoned
btrfs volume if the underlying device max_zone_append_sectors limit is
0.

Patch 4 fixes zonefs to fall back to using regular write when
max_zone_append_sectors is 0.

Overall, these changes do not break user space:
1) There is no interface allowing a user to use zone append write
without a file system. So applications using directly a raw dm-crypt
device will continue working using regular write operations.
2) btrfs zoned support was added in 5.12. Anybody trying btrfs-zoned on
top of dm-crypt would have faced the read failures already. So there
are no existing deployments to preserve. Same for zonefs.

For file systems, using zone append with encryption will need to be
supported within the file system (e.g. fscrypt). In this case, cypher IV
calculation can rely for instance on file block offsets as these are
known before a zone append operation write these blocks to disk at
unknown locations.

Reviews and comments are very much welcome.

Damien Le Moal (3):
  dm: Introduce zone append support control
  dm crypt: Fix zoned block device support
  zonefs: fix synchronous write to sequential zone files

Johannes Thumshirn (1):
  btrfs: zoned: fail mount if the device does not support zone append

 drivers/md/dm-crypt.c         | 48 ++++++++++++++++++++++++++++-------
 drivers/md/dm-table.c         | 41 ++++++++++++++++++++++++++++++
 fs/btrfs/zoned.c              |  7 +++++
 fs/zonefs/super.c             | 16 +++++++++---
 fs/zonefs/zonefs.h            |  2 ++
 include/linux/device-mapper.h |  6 +++++
 6 files changed, 107 insertions(+), 13 deletions(-)

-- 
2.30.2


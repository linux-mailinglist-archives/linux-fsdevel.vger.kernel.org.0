Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C529362CE1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 04:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhDQCdw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 22:33:52 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:17957 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQCdv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 22:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618626806; x=1650162806;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/zdC0mF6U3RynH3N4WrC5BU1TgJS0HECRdezkU53JhM=;
  b=Bkga4+cZNk0e6Pb34iKyZDbWrJe2zP/BmZ6rgZDOPnTiM6SLZOQ/0RB2
   392QfJgtWCQ9UuufFLcD14FUfu6iomMMtmQifKaNXH5GBDWA7hf95UAge
   7oUJXJxoNsMIk9Fu2QR4EFoxOVlxazRmy1zudtKPkFJcXk0lBIrdsVxZ2
   K/Hh0/jgQzAsWQ2k6MwK9zeC9sgQkC8L5QCW0+sDHVdLSJH3S13d9eMm2
   /QssNSoV5IUrgG4HVWTbACjseLRjxbVfjplli1R/FPH5q9GjWI4twY1iV
   U2aHk1OvgjDhTo+4tyy2Qn2swP1H2JBr8EaciMu2kkd71q4Rw1YSZU4gu
   A==;
IronPort-SDR: 6H6+YEZeCveZwLyIbUtdxMGOiz1aVvYr+l+xR6Yhx0JdIfFtjHVaZy+Bn1ydyZUT2iSlQX1C6m
 gvuU5+N0vGuuQh6IvTTDnf1TDP1Z76Pv9oMxxDzjYhUbRpTur43jicOEtSYBGpvtITfT6ncqH4
 byH/i7Bj6CMwclwd6L17ylzmG2n7AjJJPAuJ7JuqKj0GhOIypl9VBYBrOGLWB4w/bD9+VNMnkN
 oUS+ly0WKIzqefkq0cpsUzMiFX7UgTQXwmYgdClAq9CPrzdTzIOIcdAVkI/FWEgs1w8AbSLbur
 2L0=
X-IronPort-AV: E=Sophos;i="5.82,228,1613404800"; 
   d="scan'208";a="165193271"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2021 10:33:25 +0800
IronPort-SDR: Es3jIhybGxi6Mq9I3WuFh0H6yH0YUDV6vjnfmn26lhol1Vn1FiR7F26Mjg35FfpRa31nbvMF9b
 xjS6GnuZNdEYGUxmdbZr4X9rCU3miGn2w2ejwqYeTta5ktQCfTS+8dUhIqGgeK/b5IDuLelQoV
 xA3zpx0E3HALrc688oq0dPd+dleuBS9q5yT/44jhw0rrrrEQ4iNVq+qJ4BMCDKQf5JzwPbC3Rx
 tJpa0+NDsUsBTb82oydAmcZttpl3+PhWx+6fq51s9mG1uBf5B7R11KwABX9GYCxWLzellp47wm
 Iaqh8x+WgdDSfLkz1q5Poka5
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 19:12:39 -0700
IronPort-SDR: 16C8yH8D/rdxr7PuzxuUa8rWesM6KtsM3HDeoMg5sHjMNQvboeWQIps+YwRvcomtoPwI1MlqpW
 jtUKTWfjkpWaBLNjN5xtPZuKGF4EOTxwjzXBqX1pWi0R8zPmCngifSjkXAeqAvXMy9NAI4LKZT
 f9KAxP0v20dDFF1Ae8+mSXucvh3MQe66TKjwZTiapM7cpv7MSLw49bM8YbT4PQ5+coB0yQiIBP
 Nf6yxq7YFcTDZpXsZ740QZx0uXdp4NshbQe/QyHeTBtItwgM4/uiFWqOvW+Hfb4m7ddW6kfsUA
 efs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2021 19:33:24 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 0/3] Fix dm-crypt zoned block device support
Date:   Sat, 17 Apr 2021 11:33:20 +0900
Message-Id: <20210417023323.852530-1-damien.lemoal@wdc.com>
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
max_zone_append_sectors to 0. This change is done in patches 1 and 2.

Patch 3 fixes zonefs to fall back to using regular write when
max_zone_append_sectors is 0 (Note: I can take this patch through the
zonefs tree. But since I have nothing else for an eventual rc8 and next
cycle, you can take it too. No chance of conflict).

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

Changes from v1:
* Addressed Johannes comments by renaming the CRYPT_IV_NO_SECTORS flag
  to CRYPT_IV_ZONE_APPEND to avoid a double negation with !test_bit().
  This also clarifies that the flag is used solely to check zone append
  support.
* Removed btrfs patch (former patch 3) as David is taking that patch
  through the btrfs tree misc-next branch.
* Added reviewed-by, Fixes and Cc tags.

Damien Le Moal (3):
  dm: Introduce zone append support control
  dm crypt: Fix zoned block device support
  zonefs: fix synchronous write to sequential zone files

 drivers/md/dm-crypt.c         | 49 ++++++++++++++++++++++++++++-------
 drivers/md/dm-table.c         | 41 +++++++++++++++++++++++++++++
 fs/zonefs/super.c             | 16 +++++++++---
 fs/zonefs/zonefs.h            |  2 ++
 include/linux/device-mapper.h |  6 +++++
 5 files changed, 101 insertions(+), 13 deletions(-)

-- 
2.30.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A89A1124C6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfLDI13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:27:29 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1547 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfLDI13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448066; x=1606984066;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Ejdop1/bERrog3u8s22dYbma5KyzgH9SIscROeWDd2o=;
  b=CFkwvS2P/QWn+eoccl4/KlX83M84yQ59xt6t7MgOnR32xxgSaRVWy6iY
   Dk2GRoPtXkZ7ZdPVTmV460jDfWet5OMn4iC/TvsPQB6lzl5fMLbbycRUp
   1OkhDDxymldONNsTrZvzrh2UKzAmzGF+ZYHdIQMguTqs1yIRoeFEmWJU9
   VqoDqFyth8eRHhnar+5oksg/hJhW3e3M0BISBpY3pKK+30S9nkIcYB1s+
   tTaH6D2RJSBLurR4sxv83+b9yFcwVsu8670x21evNt3iZYahL6p1I5yVb
   O4xiutydp9hGaMC2sT1hZqAldAx7wgyummq5CqvugLY2NnEr/BQZjdjfl
   Q==;
IronPort-SDR: VJ2riIpSavL1Ihp+0UDJM6mXTQl7DK569jkfrb+da0pjFGRayej67E9GGoumts0OH+/JMx9F6A
 YVzHEIvnnrCcX3duUZMHQr9y5XV2S1K2tn2OV0P/W6fOLILXMItCMZXq+jXWAPgfOMuPMHYrPb
 Haujs08eOUovflaib7PMRjXa4M+mLQV8asfyqPwO180HheHuMlZOdIMq6U4gK+Q0cY1cHgrhoa
 qJNxsDAmmguoBJcb7im2JNnCwJzLAQZV23IHNu+K5CGiTD/Ae4bKdBrlVilxR9F4smo8Cih4w5
 pfg=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031714"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:27:45 +0800
IronPort-SDR: i712O/j2C+5hVtIxqkLhMkOi3+ElCVNjdXBUpPZfy75ZqPkhZqXrIQusg5WB0Z6pX55ijIZSi7
 ftijhoZMkjFkFsbrBCrax9lugdJQ3jTTa7ccTE8UPuuLYy8sBDKRZQLUVFb1Q62ppB+wE3HahK
 RGBWi1VpfhBxB9KLdPbUgYoEsb9SxocG5mcOoxK3jN06M4GqAVJiexhVYfRxIM96Yc8soEoi6O
 sgdXI1HcM4EpOE5qnCKktTVx87i436SkCP4C+afWO9I5pcsMraC2tKMRyb0IlTogFlgYlNXwDI
 hz6VprR/q2EybvAtImFif3PI
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:15 -0800
IronPort-SDR: nVUxJqs/SfmEVRjZJIXZ0LAlG/+M+DJ+uMC3cX2ntya0ubGGBUqQv2HQj+yXgLj2X0lBipwIkQ
 eUe47sgNUTaZxA7SRzGiMQ/Yt7h+p+vEJh8tH0dLpFRHXoEZtBQipm1g8iyotcVWlHoEx9n+S8
 qbQMcyEX0qw8BA+A8apOsypzgGiQHfJIWo/c9ufu5zGUziKeym7UlK9qC2kl21fiNTBhTOye8y
 X83gpZFuo1FKI4k1MTBuHCzuS0OUzj6lNooD/Yhqq0r7d8brgO76JaqegHWXJp4U4FN639Bf3O
 QKQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:26 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 00/15] btrfs-progs: zoned block device support
Date:   Wed,  4 Dec 2019 17:24:58 +0900
Message-Id: <20191204082513.857320-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a userland part of supporting zoned block device on btrfs.

Since the log-structured superblock feature changed the location of
superblock magic, the current util-linux (libblkid) cannot detect
HMZONED btrfs anymore. You need to apply a to-be posted patch to
util-linux to make it "zone aware".

Naohiro Aota (15):
  btrfs-progs: utils: Introduce queue_param helper function
  btrfs-progs: introduce raid parameters variables
  btrfs-progs: build: Check zoned block device support
  btrfs-progs: add new HMZONED feature flag
  btrfs-progs: Introduce zone block device helper functions
  btrfs-progs: load and check zone information
  btrfs-progs: support discarding zoned device
  btrfs-progs: support zero out on zoned block device
  btrfs-progs: implement log-structured superblock for HMZONED mode
  btrfs-progs: align device extent allocation to zone boundary
  btrfs-progs: do sequential allocation in HMZONED mode
  btrfs-progs: redirty clean extent buffers in seq
  btrfs-progs: mkfs: Zoned block device support
  btrfs-progs: device-add: support HMZONED device
  btrfs-progs: introduce support for device replace HMZONED device

 Makefile                  |    3 +-
 cmds/device.c             |   32 +-
 cmds/inspect-dump-super.c |    4 +-
 cmds/replace.c            |   12 +-
 common/device-scan.c      |   19 +-
 common/device-utils.c     |  109 +++-
 common/device-utils.h     |    4 +
 common/fsfeatures.c       |    8 +
 common/fsfeatures.h       |    2 +-
 common/hmzoned.c          | 1009 +++++++++++++++++++++++++++++++++++++
 common/hmzoned.h          |  139 +++++
 configure.ac              |   13 +
 ctree.h                   |   11 +-
 disk-io.c                 |   14 +-
 extent-tree.c             |   24 +
 kerncompat.h              |    9 +
 mkfs/common.c             |   38 +-
 mkfs/common.h             |    1 +
 mkfs/main.c               |   90 ++--
 transaction.c             |    7 +
 volumes.c                 |  116 ++++-
 volumes.h                 |    4 +
 22 files changed, 1582 insertions(+), 86 deletions(-)
 create mode 100644 common/hmzoned.c
 create mode 100644 common/hmzoned.h

-- 
2.24.0


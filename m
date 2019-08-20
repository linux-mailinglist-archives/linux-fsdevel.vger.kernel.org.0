Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C42DF9563B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfHTExF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:05 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728878AbfHTExF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276784; x=1597812784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=J4IkaPi2/fKBKdWUzcFOMidaPEbQwNSncdrnPOPxOsY=;
  b=lCcX4jxsGLsC5qMSIrrNGMtnqesMDBvflrsau+s5L7prmxhUOrjnuMgc
   vd5rfZLXdaqmwQuFLHmsHREfUEC3gSSgqK2Gy6Mg09Y6J5BbLXPnsrvxf
   tJkBu+/V9M+iccjyRey/XdURICEv1WoNDgiOCH9OhGNjyEg3dEs1kVNso
   AMBGUK/nMbk4TZ+uUKx/R7jTdLbl3tFrtuVgVIuIQyYYbIWRqUsKsBCiR
   aSNITI5jE7dd41t31COg+3Rq7yL82GiC7kAoNV9mckirFsuy55K8+GEWc
   TXNrWMmbjm0hymp2Szi8zMcOSpn3DGHE5ZQswWsBrG1YEIzHJygr6vDlU
   w==;
IronPort-SDR: f00GOZAdq6DjaRAYfbgqAAO69c8aksRh4aN9+8ab41dCCKDW/b5E5b8pjJoQZGOUHARfaY36ig
 XV5xHwzOs0h2UIo+zyxV6jsBKwEu11wb+CGOwQEluiKTcDlt41MqFMcxE/Jd8DKVm8KCFn2cVO
 LTNtwQFeZhCP30lFW48HibuNzJX6vLHE0Ye0EEqZH18mc7r0evhYpIBjAl7rQFHzOeIVTHEtfq
 WHaXQ+wxHsVZECW09XGEIbksgejMimTs+DLKBaFZQ8qISdMHPSs16x8TxawWsqVPn1aVG4DFDw
 ApU=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136281"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:04 +0800
IronPort-SDR: w/hgzmy2dXwUtNUpmJCnaOXLulvxbPsNDTInHmXwlCbZT3/e9kYgFeCkhA9/UDIno09FM4vuvm
 /dh4x63YgSTkv/nBKKZRSvQ8ntZQqQAY1wuW/UOSEHBD8R+y6uBWW+oarIytg5Vt80S9AwBMcq
 7CHyhl5t6omJ2HxPSA1UbQNsdpacw/JJtcb2Rv1mjSbqyk1iJelekplAVLjBiVUJqNHWd3yNHn
 oRGaoP5AYFYT79GGatJvuAFkda8L9APfKqjR/Xi5juxdsZTt8djjXNo3+Cpx3Kx3CSR54Vwdvk
 X+v1aiiLa8V7+dzOtL+jC5Fo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:28 -0700
IronPort-SDR: hF8b08Mx2NV4y2eRsBqCO9seBcnVnKJmWBEW5oxKZV69LEeV+1YJjpPMDSjEI0wPTrB7mK4qzP
 9a9i4KX1qe3CLCxF1sTDeG95f9yD9StGvERmwVt/OpRWdcayFHgdutpJVsv1vJEjVrX0GKGTkN
 uR9vaGorSRowXag+BUL0LOchokXe3WLVOzGSxA8omUu4X4xmqIlzF1ovGKQWJvQC5cCmc/mqxC
 W2t3ZHs/5MP0B2HjhSH7K5AyraTFxaqdq2aWSJSPtIvIb7CHWc4v5KE2w69q63R3C+/3aMgQn2
 cUQ=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:00 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 00/15] btrfs-progs: zoned block device support
Date:   Tue, 20 Aug 2019 13:52:43 +0900
Message-Id: <20190820045258.1571640-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a userland part of zoned block device support for btrfs.

Kernel side patch series:
https://lore.kernel.org/linux-btrfs/20190808093038.4163421-1-naohiro.aota@wdc.com/T/

Please see the kernel side for general description of zoned block device
support.

Patches 1 and 2 introduce some modification to prepare for the later
patches.

Patch 3 enable zoned support for the configuration script.

Patches 4 to 6 introduce functions to retrieve zone information from a
device and call them when opening a device.

Patches 7 to 12 adopts current implementations e.g., extent allocation for
HMZONED mode.

Patches 13 to 15 enables HMZONED mode in various sub-commands.

v2 https://lore.kernel.org/linux-btrfs/20190607131751.5359-1-naohiro.aota@wdc.com/
v1 https://lore.kernel.org/linux-btrfs/20180809181105.12856-1-naota@elisp.net/

Changelog:
v3:
 - Unified userland code and kernel code
 - Introduce common/hmzoned.c and put hmzoned related code there

Naohiro Aota (15):
  btrfs-progs: utils: Introduce queue_param helper function
  btrfs-progs: introduce raid parameters variables
  btrfs-progs: build: Check zoned block device support
  btrfs-progs: add new HMZONED feature flag
  btrfs-progs: Introduce zone block device helper functions
  btrfs-progs: load and check zone information
  btrfs-progs: avoid writing super block to sequential zones
  btrfs-progs: support discarding zoned device
  btrfs-progs: support zero out on zoned block device
  btrfs-progs: align device extent allocation to zone boundary
  btrfs-progs: do sequential allocation in HMZONED mode
  btrfs-progs: redirty clean extent buffers in seq
  btrfs-progs: mkfs: Zoned block device support
  btrfs-progs: device-add: support HMZONED device
  btrfs-progs: introduce support for device replace HMZONED device

 Makefile                  |   2 +-
 cmds/device.c             |  29 +-
 cmds/inspect-dump-super.c |   3 +-
 cmds/replace.c            |  12 +-
 common/device-scan.c      |  10 +
 common/device-utils.c     |  85 +++++-
 common/device-utils.h     |   4 +
 common/fsfeatures.c       |   8 +
 common/fsfeatures.h       |   2 +-
 common/hmzoned.c          | 590 ++++++++++++++++++++++++++++++++++++++
 common/hmzoned.h          |  90 ++++++
 configure.ac              |  13 +
 ctree.h                   |  21 +-
 disk-io.c                 |  10 +
 extent-tree.c             |  15 +
 kerncompat.h              |   2 +
 libbtrfsutil/btrfs.h      |   2 +
 mkfs/common.c             |  20 +-
 mkfs/common.h             |   1 +
 mkfs/main.c               | 107 +++----
 transaction.c             |   7 +
 volumes.c                 | 101 ++++++-
 volumes.h                 |  17 ++
 23 files changed, 1081 insertions(+), 70 deletions(-)
 create mode 100644 common/hmzoned.c
 create mode 100644 common/hmzoned.h

-- 
2.23.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F6235EA6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 03:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349074AbhDNBeU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 21:34:20 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:18400 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhDNBeD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 21:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618364023; x=1649900023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hjtWjVnd8LBzcYZ2wF1wMh5Hdif41Xd33y9c7QtTtPk=;
  b=K8CS2hz6cVCALJ+awJljA/77OQhAR2Clla0rsxk7qDVn0v0iKe44kmUW
   Nh8g+NeddWOTtgNfDRnxE+b+FbKXa+OIzAxj3HgBEfGxuYUM0COJb8VA9
   OFD6dcnkGLpRVuT2wCwc0a6gnFZW4Lwh093zcJedR3QzDf/QGLMPXVrq1
   p4DqNMuprEiwWjFy1J6iL5554qeTDPoFFaDevZlx82D3hFznUIlbHdoZb
   d9BiYWO7bsqORNZtTmH4+LKhM6W/V7lkxv1AgQjMN6Rt4GrhRPaay53Lx
   QQsYjdpya38RXBpzGdnTgarKYsHlIMxDyiRI06+1smtklnVueRWeJ4RXi
   Q==;
IronPort-SDR: Ho3dvZUD4xjlTemi92f77QeM2ccpsZztEFW05q6BSCl3tljGeG6u1vA2ZPDSZIbgE2gu958Uzo
 RtWSg7O5XkJAhmXkkIk4h8uOEZEUiX52HCSrt1WSD7wswFAigvqmkkAyxSkZH/d3yXiy5OoEKN
 HrG8/a96Q5eSCfylMT13Hf0l/EVigRmhHrRzs5i47ADoHrRdtnM8E/W6XyVQs9n89j6uQfo8cp
 KCNM0D6138RpjyM0/AMalZZheUliNx2X/Py2f+fPAS2bWSaL4CyK3bpGeQfFHPI8AxL8BB6sue
 6hc=
X-IronPort-AV: E=Sophos;i="5.82,221,1613404800"; 
   d="scan'208";a="169210798"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 09:33:42 +0800
IronPort-SDR: hTxjpI3ItPn7atl8nvGNAvC45Nv37fuWURpUkbut7HrJZAdexnl71Xj3R+6DoTVPqtwSSDmT1l
 /Ve9FU7rjI8M2mkMbN31syZudiA4w9zEi0GMmXD7YItVf6ubWh7+cfQJr8PsMZ8n98HIb2GA/J
 Oqp9JoOnJMBtLY5Gz0axrl4P4kbPJOXgATIfiI1e5Zk/RPBfMuZXqlqIExh1+LpusNjEExu1Gk
 FTVGdkj3peVA4Kk8+FVLNoeP+kdcYqI5ZPbDFMm44L65LOtv94zP1CGYTXxMmxBSltjmfZqrcn
 dbkbfIdg9Ry99lvBlSsIY9Rw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 18:14:45 -0700
IronPort-SDR: BuI3/rL+am8WEEvXiemFxtvTqKk4V8APgaDMeAHWtiBSeMzRhe38ZY33Xq4ZKFzVntHbaQBiNK
 o3hnrezqCbt0MXepAKt9q3N11N9ordCOJzDgMOx2pl5DRYOZF0cGbdGwDhlPvBAYbt88y2+wT/
 Tm3ykVPkzCuxgSaLw41jfjzuVA52k2cRrm4EWt1E/RDo/xjfpjk10qYdK/d3JRgZonB9PDcxOy
 Vf3wx36nqYejD7zklFODyVaiTJRpyCFcCPz8ggbo1/hFYnlNLI5PgE/P+xIikBSWmaHwigp1T5
 2K4=
WDCIronportException: Internal
Received: from jpf004864.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.142])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Apr 2021 18:33:41 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 0/3] implement zone-aware probing/wiping for zoned btrfs
Date:   Wed, 14 Apr 2021 10:33:36 +0900
Message-Id: <20210414013339.2936229-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series implements probing and wiping of the superblock of zoned btrfs.

Changes:
  - v2:
     - Fix zone alignment calculation
     - Fix the build without HAVE_LINUX_BLKZONED_H

Zoned btrfs is merged with this series:
https://lore.kernel.org/linux-btrfs/20210222160049.GR1993@twin.jikos.cz/T/

And, superblock locations are finalized with this patch:
https://lore.kernel.org/linux-btrfs/BL0PR04MB651442E6ACBF48342BD00FEBE7719@BL0PR04MB6514.namprd04.prod.outlook.com/T/

A zoned block device consists of a number of zones. Zones are either
conventional and accepting random writes or sequential and requiring that
writes be issued in LBA order from each zone write pointer position.

Superblock (and its copies) is the only data structure in btrfs with a
fixed location on a device. Since we cannot overwrite in a sequential write
required zone, we cannot place superblock in the zone.

Thus, zoned btrfs use superblock log writing to update superblock on
sequential write required zones. It uses two zones as a circular buffer to
write updated superblocks. Once the first zone is filled up, start writing
into the second buffer. When both zones are filled up and before start
writing to the first zone again, it reset the first zone.

This series first implements zone based detection of the magic location.
Then, it adds magics for zoned btrfs and implements a probing function to
detect the latest superblock. Finally, this series also implements
zone-aware wiping by zone resetting.

Naohiro Aota (3):
  blkid: implement zone-aware probing
  blkid: add magic and probing for zoned btrfs
  blkid: support zone reset for wipefs

 configure.ac                     |   1 +
 libblkid/src/blkidP.h            |   5 +
 libblkid/src/probe.c             | 108 ++++++++++++++++--
 libblkid/src/superblocks/btrfs.c | 185 ++++++++++++++++++++++++++++++-
 4 files changed, 290 insertions(+), 9 deletions(-)

-- 
2.31.1


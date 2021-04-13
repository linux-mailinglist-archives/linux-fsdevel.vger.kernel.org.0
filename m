Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432D535E8DA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 00:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348610AbhDMWLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 18:11:45 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61117 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbhDMWLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618351882; x=1649887882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0hE7/Kl+QIZYZ5kypr/FWojB38Oj+PUM9iVW4sj9xbg=;
  b=mUwG8sErpcAYiPl6/+wg0hU+VRE0rhqEiKe/0uYio5elfYv9d2oQhzR5
   A8bnbLM+VTBUVkB8feotn7XOIlG9Lm/BMoH2w7rg3k/qvVs6ftYY8Nge3
   GSkI8zQX5EgYeX6cKbVsWWXWlRlzi493o5P+Zm1jVVyMDUtgtLNSakPBg
   X0/tx8/BnRl8WKW5Sndx5DsM4p6ANVVuq0foSxGR0CzvviMpU2RNvDlbS
   kGVocuTAIN8yeMVONl6Pbx4ao39JCE4P37CkPJCYvpakARnw136gRhXkI
   bzd7LoCEWkjnsIbfWLtN0qOBRbLwoTags5DaYSyTgMSel1L1iZW6InWIB
   w==;
IronPort-SDR: ZWUaJ3JIX5XkUj+579qm0KNyhbIWrSYb4DdlxtRIW/9xPahPplc7+B7K8BWLWXNYvKq8pJcAbM
 JbHZaVrawRkcBdLEhEU64P4/C83SBvdD0xNpFDbEjImj1+smknNARipzN5iAhcE8uNZVd2xMbG
 C6DsCLXd1dRSNaxFGHzMKpvvkMEs+Tgv9BF80LEx9EGLuVX4f52ggEtltACQhgj2QnauWEZPbo
 ksnTZLtrCBBifZxt+NJgfxoa8lLl7iz1gPTSu6tNOEGiUhqOBvtMowZdkE5V2pKh9S9JZMsiDa
 6wI=
X-IronPort-AV: E=Sophos;i="5.82,220,1613404800"; 
   d="scan'208";a="164254956"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 06:11:02 +0800
IronPort-SDR: q+UcltWfB5+3uoHMjJEfYYZyLdjnp3qmiYioMvO+XJ2O4MCFN6sn9o0qNduagfSgLGkPtH4//o
 9F41O9WevJNcB1xxzc5mRBQmlSjSIN72Ib7Ieqr+NXAYbgOeWuMOXHG7cEAPE54jDgDhX2+g/v
 vA2bgXtNAFGv8Mh9FC26Q50QAHFE1aynicYRqwOYm00X6csf7cHbkC+PvtHwhO9pBz+uQ7pawQ
 hKFVq5iPa2jJcBFTa464ogjRzSfPLbimWoPWWm2pdkQ2amzvgF7gaHlR102HbsqXb88/ttaLxP
 6k/fyDw6jL3WqOch0iInfGp+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 14:51:59 -0700
IronPort-SDR: 6d5jGTMXi9fvfUPGviLl5Bn/9rBQTmHQWJUsll8VpwyPpvLGd6a+zuOXmQQ/IDXQUwaQKPY4K5
 98beR1T1klWQ+S1eD0R4PSv9x8896zo1wTyPLVDg1THSx0Zd9ZKtqhnJ8eqe7I2Vz8EKppmDKf
 bVyFS28VwOp0FrrgoNXflpgTg1OS8+2WgxkJiIGapudcl9ALDjBriN1VkYYLqLinJYmSA1HOwt
 9KoWQa/oxsrRvXqLq9w7Wz1H15rb/7mXctuqooAvyVw6t+PgqQdF/ZzUXN3oKX2fHs6wsB59Mb
 NtY=
WDCIronportException: Internal
Received: from 39xlxy2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.108])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Apr 2021 15:10:55 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 0/3] implement zone-aware probing/wiping for zoned btrfs
Date:   Wed, 14 Apr 2021 07:10:48 +0900
Message-Id: <20210413221051.2600455-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series implements probing and wiping of the superblock of zoned btrfs.

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
 libblkid/src/probe.c             |  91 ++++++++++++++--
 libblkid/src/superblocks/btrfs.c | 178 ++++++++++++++++++++++++++++++-
 4 files changed, 266 insertions(+), 9 deletions(-)

-- 
2.31.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C199A36ABE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 07:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhDZFvq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 01:51:46 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39184 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhDZFvo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 01:51:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619416263; x=1650952263;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NlQsWQprKXe08pKCMfx5H2ZABkT/fuegOYXmH2aKQSY=;
  b=ktIB8PXI1m2JatvWLOZ/XHwOSACOsdNIwSDeL8zNimkERfgY2ESpyT1I
   ShP4GD5iz4Z3Kfi1RxdbEFVeTs4AxF8htxspsrHU0tGUqbsLuXvGeEAFc
   wfLlS+B+qIOoa6/wWv5FqdCqIBLmnxebCnKhVZ4D3S+72jpnYsfe445cQ
   eHSMSNrIJiPPFn3aTULDqbeh1xAfuuqE9ctbL+j+RlQXtt1QFHun/pO/k
   Fto+nX1+l2BodUeG9Bi8+J5wyiQbSCNJQYwSITOxn3X0gA/HltQZA1MPR
   jU0+ZKKMswPafSB42Hmgi9w8FjbbskEGMOBZo4X3WbZ8IXeFayXJfz9bm
   w==;
IronPort-SDR: myDcoxKq+1TFMRidxfJSKAknOBos9RIyA1iCuV9/5mEdsC8QgHOQs8G8XhOAI701zdmtrg3kly
 oxMIWEfwqrNGAQlRz7mb3gBo3xnegGmatVstRm+gEidxO55F179ZDfIw+nPttjgVK+YKPt9yd4
 pkRRSYjDppWAMubFqO1aWk5Ihu3UYLnKX6jI4xreZlRY85mVR1r7OUSE3RGfUhna4ynFO7vNy8
 BTx58FPFr+ZoC80GrBzHZoGOgGavO51mvbSmySR/gAHAQrGTspC0LOTelMGh6vJDNXRMk4u9Er
 HiA=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170785777"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 13:51:02 +0800
IronPort-SDR: U5jv1aoCPmB4uzsVXbmQMhODp3QA9pGKWBkN9sXV/793L1SccvgmTzIlzfXb2090e+0HPb/G1a
 j8txgySFgY58apDP/rRS14Giut/6FgXIaheH1eWL8stkjZIiwGTNHAINufq7M7tNlyw5PtBWQx
 6X4tVhQBonszs1Q9ScBRbSsAaEUygMgCBFiopWUsxJW2xzYruNr9ggF2J62222m6Cf7Hc5zi/0
 8osbqZNy+sl0Bo7N8oV6OO9jO94FKVTe7+i2nry/v7qL2w26R895z18wunt4kHuH5hgtYH875j
 fjXlbIZSo30A0Iy48IivVwTj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 22:29:59 -0700
IronPort-SDR: ZfLcDBbbz23w4NpYewaf5X484NWgf89guZ1z3L0GYaLFgIEARKgxYuDqXRBykY50UEEZ4NL9bE
 qZsd5d1VVs4KU1UIFcDr+/vy9oLRWRYlBr5h493EdJbIFJkrhCbMOJ1cVuj3OAdbgKM3FOcxvN
 5TkEkiMR/Wz6Hq41ExsvaIAI4+HPVWqMhMxKneUw/NLHFBfQOmAZMVCbRqQzJFzhHJIMxAN/LV
 f9fGS3gfV+QFx4CCDzUxFjn+HcDTmkEj+dnDwXYYg+RVJjw91igtV+1ppba4Zuw1kUCDSgU5lf
 uEo=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Apr 2021 22:51:03 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 0/3] implement zone-aware probing/wiping for zoned btrfs
Date:   Mon, 26 Apr 2021 14:50:33 +0900
Message-Id: <20210426055036.2103620-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This series implements probing and wiping of the superblock of zoned btrfs.

Changes:
  - v3:
     - Implement and use blkdev_get_zonereport()
     - Also modify blkid_clone_probe() for completeness
     - Drop temporary btrfs magic from the table
     - Do not try to aggressively copy-paste the kernel side code
     - Fix commit log
  - v2:
     - Fix zone alignment calculation
     - Fix the build without HAVE_LINUX_BLKZONED_H

Zoned btrfs is merged with this series:
https://lore.kernel.org/linux-btrfs/20210222160049.GR1993@twin.jikos.cz/T/

And, superblock locations are finalized with this patch:
https://lore.kernel.org/linux-btrfs/BL0PR04MB651442E6ACBF48342BD00FEBE7719@BL0PR04MB6514.namprd04.prod.outlook.com/T/

Corresponding btrfs-progs is available here:
https://github.com/naota/btrfs-progs/tree/btrfs-zoned

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

* Testing device

You need devices with zone append writing command support to run ZONED
btrfs.

Other than real devices, null_blk supports zone append write command. You
can use memory backed null_blk to run the test on it. Following script
creates 12800 MB /dev/nullb0 filled with 4MB zones.

    sysfs=/sys/kernel/config/nullb/nullb0
    size=12800 # MB
    zone_size= 4 # MB
    
    # drop nullb0
    if [[ -d $sysfs ]]; then
            echo 0 > "${sysfs}"/power
            rmdir $sysfs
    fi
    lsmod | grep -q null_blk && rmmod null_blk
    modprobe null_blk nr_devices=0
    
    mkdir "${sysfs}"
    
    echo "${size}" > "${sysfs}"/size
    echo 1 > "${sysfs}"/zoned
    echo "${zone_size}" > "${sysfs}"/zone_size
    echo 0 > "${sysfs}"/zone_nr_conv
    echo 1 > "${sysfs}"/memory_backed
    
    echo 1 > "${sysfs}"/power
    udevadm settle

Zoned SCSI devices such as SMR HDDs or scsi_debug also support the zone
append command as an emulated command within the SCSI sd driver. This
emulation is completely transparent to the user and provides the same
semantic as a NVMe ZNS native drive support.

Also, there is a qemu patch available to enable NVMe ZNS device.

Then, you can create zoned btrfs with the above btrfs-progs.

    $ mkfs.btrfs -d single -m single /dev/nullb0
    btrfs-progs v5.11
    See http://btrfs.wiki.kernel.org for more information.
    
    ERROR: superblock magic doesn't match
    /dev/nullb0: host-managed device detected, setting zoned feature
    Resetting device zones /dev/nullb0 (3200 zones) ...
    Label:              (null)
    UUID:               1e5912a2-b5c3-46fb-aa9a-ee3d073ff600
    Node size:          16384
    Sector size:        4096
    Filesystem size:    12.50GiB
    Block group profiles:
      Data:             single            4.00MiB
      Metadata:         single            4.00MiB
      System:           single            4.00MiB
    SSD detected:       yes
    Zoned device:       yes
    Zone size:          4.00MiB
    Incompat features:  extref, skinny-metadata, zoned
    Runtime features:   
    Checksum:           crc32c
    Number of devices:  1
    Devices:
       ID        SIZE  PATH
        1    12.50GiB  /dev/nullb0
    $ mount /dev/nullb0 /mnt/somewhere
    $ dmesg | tail
    ...
    [272816.682461] BTRFS: device fsid 1e5912a2-b5c3-46fb-aa9a-ee3d073ff600 devid 1 transid 5 /dev/nullb0 scanned by mkfs.btrfs (44367)
    [272883.678401] BTRFS info (device nullb0): has skinny extents
    [272883.686373] BTRFS info (device nullb0): flagging fs with big metadata feature
    [272883.699020] BTRFS info (device nullb0): host-managed zoned block device /dev/nullb0, 3200 zones of 4194304 bytes
    [272883.711736] BTRFS info (device nullb0): zoned mode enabled with zone size 4194304
    [272883.722388] BTRFS info (device nullb0): enabling ssd optimizations
    [272883.731332] BTRFS info (device nullb0): checking UUID tree

Naohiro Aota (3):
  blkid: implement zone-aware probing
  blkid: add magic and probing for zoned btrfs
  blkid: support zone reset for wipefs

 include/blkdev.h                 |   9 ++
 lib/blkdev.c                     |  29 ++++++
 libblkid/src/blkidP.h            |   5 +
 libblkid/src/probe.c             |  99 +++++++++++++++++--
 libblkid/src/superblocks/btrfs.c | 159 ++++++++++++++++++++++++++++++-
 5 files changed, 292 insertions(+), 9 deletions(-)

-- 
2.31.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67803EEB9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 13:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbhHQL3P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 07:29:15 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:27423 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236781AbhHQL3O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:29:14 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210817112840epoutp03a7ffba8fbb56635f1fe05aab6b0022d4~cFIN1YYhI2784027840epoutp030
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 11:28:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210817112840epoutp03a7ffba8fbb56635f1fe05aab6b0022d4~cFIN1YYhI2784027840epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629199720;
        bh=i+k6jOqZcfHbKagRSdAPINcrkFCKVp0wtCshif8Pr7s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BghHJLugqzPlvRCB12ErRoFvorT7/lrHPnlSDYERkHMOb93d9nLQWVEFp0Ahde5BA
         Ci/2I76TCm3yebPOOBIOS0Zx4NS6xsZFmpsdLU8rPPdTEahZ66w4bJOJ10tgTNyTF4
         IpF2WrIucRZUIwePJeG+soIk1qJusSK3oG5d7Txs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210817112838epcas5p21338d9c0ef062267eb2040ab031bd46e~cFIMNd93W0777607776epcas5p2B;
        Tue, 17 Aug 2021 11:28:38 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Gppgj5KL7z4x9Pr; Tue, 17 Aug
        2021 11:28:33 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        96.9D.41701.16D9B116; Tue, 17 Aug 2021 20:28:33 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210817101741epcas5p174ca0a539587da6a67b9f58cd13f2bad~cEKP9y0_02631326313epcas5p1c;
        Tue, 17 Aug 2021 10:17:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210817101741epsmtrp26a0379bab088ae56ec8f47e6ad8d8222~cEKP8c5xc2759327593epsmtrp2Y;
        Tue, 17 Aug 2021 10:17:41 +0000 (GMT)
X-AuditID: b6c32a4b-0abff7000001a2e5-a8-611b9d6119d3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DC.09.32548.5CC8B116; Tue, 17 Aug 2021 19:17:41 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210817101737epsmtip298bff510fdfdc21ccde8562e9550e71c~cEKMJYzD20079500795epsmtip2f;
        Tue, 17 Aug 2021 10:17:37 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
        mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org,
        snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com,
        joshiiitr@gmail.com, nj.shetty@samsung.com,
        nitheshshetty@gmail.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [PATCH 0/7] add simple copy support
Date:   Tue, 17 Aug 2021 15:44:16 +0530
Message-Id: <20210817101423.12367-1-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1CTZRz3fd/xblDz5oB6ApM1TjyIH5uO9eCBJiL3Ep7HFf+o0XgZb0CM
        bbd3RHrXgRExQA2SHwkKpDuUkS6H/Ag3oy2BoR2X/Apq5sGgO0vAVk4jqI0Xzf8+z+f7+Xw/
        z/f73MPB+Dp2ECdPqaU0SlIhxP1Y3bbwbVHk2WBS9Pe8EBqHBzB4xtCNwA7HpzisX3qMwbLy
        hygcdW6EloUmH9jecQOFsz+72HCl8g4Kb/x7H4cj920o/Mw6gUCzqZYFO906HFqmX4Vmi50F
        W9rm2LBqsheHFwZXUVijG0dhr/MYAruXWzA4VnsOg3cXJ9nwt0d2HH5y5S8ELj86g7++mRgd
        SyW+bnSwic6LEcTo94WEyVCBE536YuLaVAlOPJibZhGL18dx4uRVA0K4TFuI8v4qNO35Q/nx
        uRSZTWkElFKuys5T5iQIU9+S7ZXFSkXiKHEcfE0oUJIFVIIwaX9aVHKewrMMoeB9UlHoodJI
        mhbG7IrXqAq1lCBXRWsThJQ6W6GWqKNpsoAuVOZEKyntTrFItD3WI8zMz10qnWGpzZIPWj6+
        iZcgZRGViC8H8CTAWNqDViJ+HD7vGgJWrb/6eAt83h8IcFzAmYILAbX/TGBPHFML9xCm0IeA
        lW/c7KeqSxYH4lXhvCgwoTexvDiAtxu0Pzb4eEUYb5gFGhbPsb0Ff14k6D1uXmvL4m0FJ/uv
        rxm4vATw+fnf1+NCwOnbbjbDbwL20841DebhS7uaMG9TwOvwBW01057LcjyHJDA0rmK8/uDe
        4FU2g4OAa8GCM7gIzFfUowwuQcDJxSIG7wY/mFdQbxuMFw6MfTEM/TKoG76MMrEbwYll57qV
        C3qbnSiTGgaGe6QMvRks2frWkwigb7OymY1mgO65HlY1EtL4zDCNzwzT+H9wK4IZkJcoNV2Q
        Q9Gx6h1Kqujpu8pVBSZk7UtEpPYiM3eXoq0IykGsCOBgwgDuNk4Qyedmk0eOUhqVTFOooGgr
        EuvZcA0WFChXef6UUisTS+JEEqlUKonbIRULX+S+vT+Y5PNySC2VT1FqSvPEh3J8g0pQaSbx
        LWqXnXKlL2Q2GPdskEV/qDO8d7auJT1w4fKEz7th6V2XbPo7BV/U1R91Zhazy3Y1N4U3V7T/
        1FOmOHC4HL21mDIwNALdB7OOuLXdt3XFKxczu0b20erBLdYiuykgf9PNRNtkVpl0WjS8elzu
        b98QFsud/zFGIUfj02i/fbPvJLpSTgmy9EPQmFQtTzXvqcHd3F9a588fPBRyZeGrRHu/JXBn
        jaZ6r1KQcfhE+pusKrbe5nCIsCjB1rFXQkNzP9LxU1gNzyUvjU5NNkYbiZUMvwPyyNZOSzw9
        ECIa4859mTzTcawuueuF2VDVreAHf8LA7Q+/S/TrSHsjEYsUsuhcUhyBaWjyP7vMBuybBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCSvO7RHulEgyuXlSzWnzrGbDFn1TZG
        i9V3+9kspn34yWzR2v6NyeLyEz6Lve9ms1qsXH2UyeLxnc/sFn+77jFZHP3/ls3i/NvDTBaT
        Dl1jtNizaQqLxebvHWwWe29pW+zZe5LFYv6yp+wW3dd3sFksP/6PyWJix1Umix1PGhkttv2e
        z2xxZcoiZosH76+zW7z+cZLNom3jV0aL3z/msDnIeFy+4u2xc9Zddo/NK7Q8Lp8t9di0qpPN
        Y/OSeo/dNxvYPD4+vcXi8X7fVTaPvi2rGD0+b5LzaD/QzRTAE8Vlk5Kak1mWWqRvl8CV8aH5
        EUvBHpOK+S2n2RoYW7W6GDk5JARMJG6+e8XYxcjFISSwg1Fi05fNrBAJGYm1dzvZIGxhiZX/
        nrNDFH1klPiw7jczSIJNQFfi2pJNLCC2iICjxOlP25hAipgFXrFI3Lu7G6xIWEBHYkfPHjCb
        RUBVou/APrAGXgFbiRmL3zBDbJCXmHnpOztEXFDi5MwnQDUcQIPUJdbPEwIJMwOVNG+dzTyB
        kX8WkqpZCFWzkFQtYGRexSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHOFaWjsY96z6
        oHeIkYmD8RCjBAezkgivOodUohBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeC10n44UE0hNLUrNT
        UwtSi2CyTBycUg1M2VtPu+m/kMj4/HfrDOOK5aUqF9cHLi9/nt96vHqJw6RXjYxPbu7Nckr4
        WrJoQppjGE/k5xe7RW+cKZvdtTNtu+bb933ey5IzTs652L89SP3/Rr/fbVpzD1xOk5WJ/hFe
        oPBURHLlSietPOE/Z2sel8c59l7bob0mufZd0PHL+3b0rYk5s0tjKcMr5SNsoZfPcLgaH7q4
        L4eJe36/oNqBC5evnZvosofpn47aPDdFlyaRJ9474+2lFhjuvSv7ZJ1/4d+63ZEv3ptXPnv7
        mls2S2XF0YuzFU5uE/iw62zXuy2TX5Vx6lVmGc08dp/NLFnu1B/fPZNMJp+a+/hm/KK8VpXF
        36QO7mV78TbtUECU8h4lluKMREMt5qLiRABGhdCFXwMAAA==
X-CMS-MailID: 20210817101741epcas5p174ca0a539587da6a67b9f58cd13f2bad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210817101741epcas5p174ca0a539587da6a67b9f58cd13f2bad
References: <CGME20210817101741epcas5p174ca0a539587da6a67b9f58cd13f2bad@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This started out as an attempt to support NVMe Simple Copy Command (SCC),
and evolved during the RFC review process.

The patchset, at this point, contains -
1. SCC support in NVMe driver
2. Block-layer infra for copy-offload operation
3. ioctl interface to user-space
4. copy-emulation infra in the block-layer
5. copy-offload plumbing to dm-kcopyd (thus creating couple of in-kernel
	users such as dm-clone)


The SCC specification, i.e. TP4065a can be found in following link

https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs.zip

Simple copy is a copy offloading feature and can be used to copy multiple
contiguous ranges (source_ranges) of LBA's to a single destination LBA
within the device, reducing traffic between host and device.

We define a block ioctl for copy and copy payload format similar to
discard. For device supporting native simple copy, we attach the control
information as payload to the bio and submit to the device. Copy emulation
is implemented incase underlaying device does not support copy offload or
based on sysfs choice. Copy emulation is done by reading each source range
into buffer and writing it to the destination.

At present this implementation does not support copy offload for stacked/dm
devices, rather copy operation is completed through emulation.

One of the in-kernel use case for copy-offload is implemented by this
patchset. dm-kcopyd infra has been changed to leverage the copy-offload if
it is natively available. Other future use-cases could be F2FS GC, BTRFS
relocation/balance and copy_file_range.

Following limits are added to queue limits and are exposed via sysfs to
userspace, which user can use to form a payload.

 - copy_offload:
	configurable, can be used set emulation or copy offload
		0 to disable copy offload,
		1 to enable copy offloading support. Offload can be only
			enabled, if underlaying device supports offload

 - max_copy_sectors:
	total copy length supported by copy offload feature in device.
	0 indicates copy offload is not supported.

 - max_copy_nr_ranges:
	maximum number of source range entries supported by copy offload
			feature in device

 - max_copy_range_sectors:
	maximum copy length per source range entry

*blkdev_issue_copy* takes source bdev, no of sources, array of source
ranges (in sectors), destination bdev and destination offset(in sectors).
If both source and destination block devices are same and queue parameter
copy_offload is 1, then copy is done through native copy offloading.
Copy emulation is used in otherwise.

Changes from  RFC v5

1. Handle copy larger than maximum copy limits
2. Create copy context and submit copy offload asynchronously
3. Remove BLKDEV_COPY_NOEMULATION opt-in option of copy offload and
check for copy support before submission from dm and other layers
4. Allocate maximum possible allocatable buffer for copy emulation
rather failing very large copy offload.
5. Fix copy_offload sysfs to be either have 0 or 1

Changes from RFC v4

1. Extend dm-kcopyd to leverage copy-offload, while copying within the
same device. The other approach was to have copy-emulation by moving
dm-kcopyd to block layer. But it also required moving core dm-io infra,
causing a massive churn across multiple dm-targets.
2. Remove export in bio_map_kern()
3. Change copy_offload sysfs to accept 0 or else
4. Rename copy support flag to QUEUE_FLAG_SIMPLE_COPY
5. Rename payload entries, add source bdev field to be used while
partition remapping, remove copy_size
6. Change the blkdev_issue_copy() interface to accept destination and
source values in sector rather in bytes
7. Add payload to bio using bio_map_kern() for copy_offload case
8. Add check to return error if one of the source range length is 0
9. Add BLKDEV_COPY_NOEMULATION flag to allow user to not try copy
emulation incase of copy offload is not supported. Caller can his use
his existing copying logic to complete the io.
10. Bug fix copy checks and reduce size of rcu_lock()

Changes from RFC v3

1. gfp_flag fixes.
2. Export bio_map_kern() and use it to allocate and add pages to bio.
3. Move copy offload, reading to buf, writing from buf to separate functions
4. Send read bio of copy offload by chaining them and submit asynchronously
5. Add gendisk->part0 and part->bd_start_sect changes to blk_check_copy().
6. Move single source range limit check to blk_check_copy()
7. Rename __blkdev_issue_copy() to blkdev_issue_copy and remove old helper.
8. Change blkdev_issue_copy() interface generic to accepts destination bdev
        to support XCOPY as well.
9. Add invalidate_kernel_vmap_range() after reading data for vmalloc'ed memory.
10. Fix buf allocoation logic to allocate buffer for the total size of copy.
11. Reword patch commit description.

Changes from RFC v2

1. Add emulation support for devices not supporting copy.
2. Add *copy_offload* sysfs entry to enable and disable copy_offload
        in devices supporting simple copy.
3. Remove simple copy support for stacked devices.

Changes from RFC v1:

1. Fix memory leak in __blkdev_issue_copy
2. Unmark blk_check_copy inline
3. Fix line break in blk_check_copy_eod
4. Remove p checks and made code more readable
5. Don't use bio_set_op_attrs and remove op and set
   bi_opf directly
6. Use struct_size to calculate total_size
7. Fix partition remap of copy destination
8. Remove mcl,mssrl,msrc from nvme_ns
9. Initialize copy queue limits to 0 in nvme_config_copy
10. Remove return in QUEUE_FLAG_COPY check
11. Remove unused OCFS


Nitesh Shetty (4):
  block: Introduce queue limits for copy-offload support
  block: copy offload support infrastructure
  block: Introduce a new ioctl for simple copy
  block: add emulation for simple copy

SelvaKumar S (3):
  block: make bio_map_kern() non static
  nvme: add simple copy support
  dm kcopyd: add simple copy offload support

 block/blk-core.c          |  84 ++++++++-
 block/blk-lib.c           | 352 ++++++++++++++++++++++++++++++++++++++
 block/blk-map.c           |   2 +-
 block/blk-settings.c      |   4 +
 block/blk-sysfs.c         |  51 ++++++
 block/blk-zoned.c         |   1 +
 block/bounce.c            |   1 +
 block/ioctl.c             |  33 ++++
 drivers/md/dm-kcopyd.c    |  56 +++++-
 drivers/nvme/host/core.c  |  83 +++++++++
 drivers/nvme/host/trace.c |  19 ++
 include/linux/bio.h       |   1 +
 include/linux/blk_types.h |  20 +++
 include/linux/blkdev.h    |  21 +++
 include/linux/nvme.h      |  43 ++++-
 include/uapi/linux/fs.h   |  20 +++
 16 files changed, 775 insertions(+), 16 deletions(-)

-- 
2.25.1


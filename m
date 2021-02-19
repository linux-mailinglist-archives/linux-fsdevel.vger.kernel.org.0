Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B30693202C3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 03:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBTCC0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 21:02:26 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:39167 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhBTCCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 21:02:09 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210220020124epoutp01e4e387f27f639b8a84af61f9f1252783~lUkHi848h2237722377epoutp01l
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Feb 2021 02:01:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210220020124epoutp01e4e387f27f639b8a84af61f9f1252783~lUkHi848h2237722377epoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613786484;
        bh=Sg6u9R7wuTrC6qu/sR45hhAulZyBxBVXurw2sMPG0wo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=gV9fcEXTZV0+RDj+gGLJek8v45UgM6BEn4zaPKGz5MGTe+WpZIQdxsQjrBJ9Oveec
         x/tYud9/dWkjDASYciaq5W5nNltb8hRRRfE1uoc/vJzMNwOCvcuRPmoO81kJbIzPao
         VkJtXTicj5uAknM7jWVEJzceTklLKHGYHbUWt+74=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210220020123epcas5p1c327f1b7ff5d162b2dca52ad015f78ad~lUkGX4WTT2719627196epcas5p1v;
        Sat, 20 Feb 2021 02:01:23 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.F7.50652.37D60306; Sat, 20 Feb 2021 11:01:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44~lJtkMhXjv2749327493epcas5p1u;
        Fri, 19 Feb 2021 12:45:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210219124555epsmtrp1ccc5c622dae5027b8b45fc1018db96c7~lJtkK0wzL0509805098epsmtrp1S;
        Fri, 19 Feb 2021 12:45:55 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-75-60306d7353dc
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.7A.13470.203BF206; Fri, 19 Feb 2021 21:45:54 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210219124552epsmtip2cf3293ca4764412dbf28ed31c627485a~lJthXbBGC1677516775epsmtip2v;
        Fri, 19 Feb 2021 12:45:51 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        snitzer@redhat.com, selvajove@gmail.com, joshiiitr@gmail.com,
        nj.shetty@samsung.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, kch@kernel.org,
        linux-fsdevel@vger.kernel.org,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [RFC PATCH v5 0/4] add simple copy support
Date:   Fri, 19 Feb 2021 18:15:13 +0530
Message-Id: <20210219124517.79359-1-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7bCmum5xrkGCweN1LBar7/azWbS2f2Oy
        2PtuNqvFytVHmSwe3/nMbnH0/1s2i/NvDzNZTDp0jdFiz6YpLBZ7b2lb7Nl7ksXi8q45bBbz
        lz1lt9j2ez6zxZUpi5gt1r1+z2Lx4P11dovXP06yWbRt/MroIOyxc9Zddo/z9zayeFw+W+qx
        aVUnm8fmJfUeu282sHm833eVzaNvyypGj8+b5DzaD3QzBXBFcdmkpOZklqUW6dslcGXcvtHK
        XNCrW7H7wG22BsZ5Kl2MnBwSAiYSS04eZO9i5OIQEtjNKHFw7jk2COcTo8SKy/+hMt8YJe6s
        +8sK09I+ezsrRGIvo8S6M0eYIJzPjBKvHs1jB6liE9CVuLZkEwuILSKgJPF3fRMLSBGzwARm
        id7rc5lBEsICxhI9W64DJTg4WARUJe6/4wIJ8wrYSrzZ2Qy1TV5i5qXv7BBxQYmTM5+AzWQG
        ijdvnc0MMlNC4AaHxLHeTWwQDS4SPWt+M0PYwhKvjm9hh7ClJF72t0HZ5RLPOqcxQdgNjBJ9
        78shbHuJi3v+MoHcwyygKbF+lz5EWFZi6ql1TBB7+SR6fz+BauWV2DHvCVi5hICaxKntZhBh
        GYkPh3dBXeMh8eHnBLBrhARiJSYcOM8ygVF+FpJvZiH5ZhbC4gWMzKsYJVMLinPTU4tNC4zy
        Usv1ihNzi0vz0vWS83M3MYKTn5bXDsaHDz7oHWJk4mA8xCjBwawkwrv9uV6CEG9KYmVValF+
        fFFpTmrxIUZpDhYlcd4dBg/ihQTSE0tSs1NTC1KLYLJMHJxSDUyrFZxuqF8TzEgr/iDf6/VO
        68hirbch3gJi8q3/X+4+buN8a9txBuaNptt+nX7x+tYq/yI9RbZpX6a9vnFjss55BYtnV9pf
        PX/J7yRxaltDOg+XfYvkwvL3cQ9zX3nm37jLXiPb82m3YrHVNbv8J9OfTPTI7Pk67/qsalmu
        g02Hv/nme/7b9L39C9fGV+ETStaqNEl/3m9c9+VW523d6bMO6V3QOvLVYE2SnrhaxB+WKTur
        Pm45aGTK0y8Z2H58T+ibOb/s4q+m6Go1aj3y2/+3zbJyF2vCmZqgJw8efLR/nbLwTYBIhcAG
        B1dnjRKplJUHvZZwhevflpUUu7/xYWJzIqOAiJMtZ41d2+ML1ziUWIozEg21mIuKEwFwqUAo
        7QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsWy7bCSvC7TZv0Eg9MnLCxW3+1ns2ht/8Zk
        sffdbFaLlauPMlk8vvOZ3eLo/7dsFuffHmaymHToGqPFnk1TWCz23tK22LP3JIvF5V1z2Czm
        L3vKbrHt93xmiytTFjFbrHv9nsXiwfvr7Bavf5xks2jb+JXRQdhj56y77B7n721k8bh8ttRj
        06pONo/NS+o9dt9sYPN4v+8qm0ffllWMHp83yXm0H+hmCuCK4rJJSc3JLEst0rdL4Mq4faOV
        uaBXt2L3gdtsDYzzVLoYOTkkBEwk2mdvZ+1i5OIQEtjNKPF+5h02iISMxNq7nVC2sMTKf8/Z
        IYo+Mkos3PWFESTBJqArcW3JJhYQW0RASeLv+iYwm1lgGbPEo5mKILawgLFEz5brQHEODhYB
        VYn777hAwrwCthJvdjazQsyXl5h56Ts7RFxQ4uTMJ2DlzALqEuvnCUFMlJdo3jqbeQIj/ywk
        VbMQqmYhqVrAyLyKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM46rQ0dzBuX/VB7xAj
        EwfjIUYJDmYlEd7tz/UShHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBa
        BJNl4uCUamC6tKRTslYqM1uwsG8ux8Kpcmv2/Ojx16r994Xd+g6v5En5rb8yvi1k6Jpy4Uve
        N+UFM1smGvAx5Z0S8Hpa8GTl2hO3OVTzunJa2z4GaTMd+7sk5ushybyiNHPldY0aflVnPr+S
        N77MuTveuMOU7yk319U3Omf9TnSyBa9YuC9KN2Vr3reabtnv277d+1u349Pf35dSNULWfNry
        pe7suxlMuUv5H0xM3irkk/By35qpW3inNMr9P15op/tLRSSrwDg7pX+Xm8jkPuPc+zc402+o
        Hyk9/uL8/6kVTrM+T9xcov1L6KHf2r/G2hPDtx94pHaFb97EwsNB96QL8t6fUT9/4NTttsr5
        h2zCLh6MMBBmVGIpzkg01GIuKk4EAJSLJQwpAwAA
X-CMS-MailID: 20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44
References: <CGME20210219124555epcas5p1334e7c4d64ada5dc4a2ca0feb48c1d44@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset tries to add support for TP4065a ("Simple Copy Command"),
v2020.05.04 ("Ratified")

The Specification can be found in following link.
https://nvmexpress.org/wp-content/uploads/NVM-Express-1.4-Ratified-TPs-1.zip

Simple copy command is a copy offloading operation and is  used to copy
multiple contiguous ranges (source_ranges) of LBA's to a single destination
LBA within the device reducing traffic between host and device.

This implementation doesn't add native copy offload support for stacked
devices rather copy offload is done through emulation. Possible use
cases are F2FS gc and BTRFS relocation/balance.

*blkdev_issue_copy* takes source bdev, no of sources, array of source
ranges (in sectors), destination bdev and destination offset(in sectors).
If both source and destination block devices are same and copy_offload = 1,
then copy is done through native copy offloading. Copy emulation is used
in other cases.

As SCSI XCOPY can take two different block devices and no of source range is
equal to 1, this interface can be extended in future to support SCSI XCOPY.

For devices supporting native simple copy, attach the control information
as payload to the bio and submit to the device. For devices without native
copy support, copy emulation is done by reading each source range into memory
and writing it to the destination. Caller can choose not to try
emulation if copy offload is not supported by setting
BLKDEV_COPY_NOEMULATION flag.

Following limits are added to queue limits and are exposed in sysfs
to userspace
	- *copy_offload* controls copy_offload. set 0 to disable copy
		offload, 1 to enable native copy offloading support.
	- *max_copy_sectors* limits the sum of all source_range length
	- *max_copy_nr_ranges* limits the number of source ranges
	- *max_copy_range_sectors* limit the maximum number of sectors
		that can constitute a single source range.

	max_copy_sectors = 0 indicates the device doesn't support copy
offloading.

	*copy offload* sysfs entry is configurable and can be used toggle
between emulation and native support depending upon the usecase.

Changes from v4

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

Planned for next:
- adding blktests
- handling larger (than device limits) copy
- decide on ioctl interface (man-page etc.)

Changes from v3

1. gfp_flag fixes.
2. Export bio_map_kern() and use it to allocate and add pages to bio.
3. Move copy offload, reading to buf, writing from buf to separate functions.
4. Send read bio of copy offload by chaining them and submit asynchronously.
5. Add gendisk->part0 and part->bd_start_sect changes to blk_check_copy().
6. Move single source range limit check to blk_check_copy()
7. Rename __blkdev_issue_copy() to blkdev_issue_copy and remove old helper.
8. Change blkdev_issue_copy() interface generic to accepts destination bdev
	to support XCOPY as well.
9. Add invalidate_kernel_vmap_range() after reading data for vmalloc'ed memory.
10. Fix buf allocoation logic to allocate buffer for the total size of copy.
11. Reword patch commit description.

Changes from v2

1. Add emulation support for devices not supporting copy.
2. Add *copy_offload* sysfs entry to enable and disable copy_offload
	in devices supporting simple copy.
3. Remove simple copy support for stacked devices.

Changes from v1:

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

SelvaKumar S (4):
  block: make bio_map_kern() non static
  block: add simple copy support
  nvme: add simple copy support
  dm kcopyd: add simple copy offload support

 block/blk-core.c          | 102 +++++++++++++++--
 block/blk-lib.c           | 223 ++++++++++++++++++++++++++++++++++++++
 block/blk-map.c           |   2 +-
 block/blk-merge.c         |   2 +
 block/blk-settings.c      |  10 ++
 block/blk-sysfs.c         |  47 ++++++++
 block/blk-zoned.c         |   1 +
 block/bounce.c            |   1 +
 block/ioctl.c             |  33 ++++++
 drivers/md/dm-kcopyd.c    |  49 ++++++++-
 drivers/nvme/host/core.c  |  87 +++++++++++++++
 include/linux/bio.h       |   1 +
 include/linux/blk_types.h |  14 +++
 include/linux/blkdev.h    |  17 +++
 include/linux/nvme.h      |  43 +++++++-
 include/uapi/linux/fs.h   |  13 +++
 16 files changed, 627 insertions(+), 18 deletions(-)

-- 
2.25.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE1950318
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 09:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfFXHXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 03:23:24 -0400
Received: from sonic306-19.consmr.mail.gq1.yahoo.com ([98.137.68.82]:35741
        "EHLO sonic306-19.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726793AbfFXHXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1561361002; bh=+ljCyW+vRKro5RELDhkKeYWyWrn99Hdrg58DZS2JHRE=; h=From:To:Cc:Subject:Date:From:Subject; b=lrwBN9ezCr6UuMRr0BN6VLdF+8DrPlNn55x7yYUYZUmXN163kcForezSzFKQgXl7ttkOHz7TE1iDDx4L/KyEwiUjcWTNR7ioBoxl6FD3KExpXF2d6DOEQINBbClvPU9ul5KVgiqpyL0Pj8/Dc8+GzE3qfi3SjrD999p6fAPBvsizPXvKjE1OBi3T9NO99vkgOTo0lRWbt+QqM75z5sqg660r/SWpl5viD2dW2gohvmeGn47IpSRyZWGYfFV9lTcW6HQc5N4n4i0RCGrvNtTvTqihdALUDjHxNSptrDiG81Mhx4gnrBXC9XmKoZ7ef29yf7rZvQcT1Lk4/LyfFeFW6Q==
X-YMail-OSG: 8pyX03AVM1k63EuvChAh_6MbmnJTPicDjKQG3jKmJ_.4o8T3ZLHsCIzs.KnInx8
 KdE75i8Bqh4KWZhRJLSDOzb3svG5.5oE3gPjYFo_mJ2beUh2YKbcbCFFzAMz2m.kCAqi.Yl153tc
 PNZavS1iMZELK2LXX7w0IVl_tUNMYkzQlUgjFo0reRCmr8203VS6DCIq98SIAbPjO06OjE_QQirK
 mm0XyjElFiQVEBsDFnts0jP2V3kgi_uEKLvybFNIuop7a04k.scdDb.wvKyFMQdvK2ZHVp3qbDdL
 IUcVhUpEXjQfE3Y0J8NAw8Y0ctdqyYxYPd841b1bByAbYYFJ78fPuoNHmMwVQsi5paCXM1phYts9
 svC6eIxOUZq32S7ejK5xd5AzzHiGAmBSMJAu4H.osjsQV7pf5xiFRsct4kWuYkGbi8a4i4Awz27A
 Fmm8Lq5PyCrztyzsOZEJxpZHegBBAM2GQ0YBfG78i7sgP0RG051.2cWY.Yf3T6zoBGpMs_fmY.95
 MzkUNFU.XuuATN.sK9SHJ4sVbCxmDu5VjoswbSuDeZbW25FIhzErPsFlqetMWHNmZF1YBUZ8z3GP
 6_fIdM7r9leNG77gIKZowlBKu6PjccBuz_1Idc8gHSdfbGEkkeAFJjXYjKvP0g4Qw4OhWWwpPat0
 BPjflEPCBaCUzopOpdjWNoxCvm1_Ideq1LDThdzeVUxOWredPwBRQHGDvBtt7_FLiiAA0s7is3rn
 kieOBynSk0cbQdCCftXJtdbptRFkbrV5JTdA7jf5nd8FKAZNJYTZpI1mFfpoE0BNQUjPQeY_M2HJ
 r.lWDlr84JUs.go_rxZ8ZBIXFEH5w5avUfLpstPAq405ETYUOb3LLH0gVZn60jAA4wF1r3p_5z9O
 566hPwT8S6ti.nWpKivGV2JJn5j8zZuTZmdM_I8XkBPAgCMSS6GdHnTEevA7el748cJU9VHc5ete
 niyydWVYy4FK4Gka7s2vEBQ7Sk3pdCb5NVISDTKSUCm2J7mmTTfBGi3olIgEM.2Ug3kQndXZIJkf
 qENPdEuoxlgICzmNKzu_i__v.U4.6uHLQN_5NK1ffr_HZg_wA9CqzZIANvbvolCHQgW2UryTh2S6
 c1Fya5B8SkqitYcPU4k0e1.BeXxc_fykjjozSHGzwcxm1_iku3RqX6qPCyObHspHfTufq1O_IS9_
 L0W2oSn1lm5PAEFAhyUC_S7aO2IHX.lfKGiNtlk8PcAdD_mF4Pc5JK0bhvBxUsw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Mon, 24 Jun 2019 07:23:22 +0000
Received: from 116.226.249.212 (EHLO localhost.localdomain) ([116.226.249.212])
          by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6d1878af4efb7cadb69856afeea1b125;
          Mon, 24 Jun 2019 07:23:19 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Du Wei <weidu.du@huawei.com>,
        Gao Xiang <hsiangkao@aol.com>
Subject: [PATCH v3 0/8] staging: erofs: decompression inplace approach
Date:   Mon, 24 Jun 2019 15:22:50 +0800
Message-Id: <20190624072258.28362-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is patch v3 of erofs decompression inplace approach, which is sent
out by my personal email since I'm out of office to attend Open Source
Summit China 2019 these days. No major change from PATCH v2 since no
noticeable issue raised from landing to our products till now, mainly
as a response to Chao's suggestions.

See the bottom lines which are taken from RFC PATCH v1 and describe
the principle of these technologies.

The series is based on the latest staging-next since all dependencies
have already been merged.

changelog from v2:
 - wrap up some offsets as marcos;
 - add some error handling for erofs_get_pcpubuf();
 - move some decompression inplace stuffes from PATCH 5 -> 6.

changelog from v1:
 - keep Z_EROFS_NR_INLINE_PAGEVECS in unzip_vle.h after switching to
   new decompression backend;
 - add some DBG_BUGONs in new decompression backend to observe
   potential issues;
 - minor code cleanup.

8<--------

Hi,

After working on for more than half a year, the detail of erofs decompression
inplace is almost determined and ready for linux-next.

Currently, inplace IO is used if the whole compressed data is used
in order to reduce compressed pages extra memory overhead and an extra
memcpy (the only one memcpy) will be used for each inplace IO since
temporary buffer is needed to keep decompressing safe for inplace IO.

However, most of lz-based decompression algorithms support decompression
inplace by their algorithm designs, such as LZ4, LZO, etc.

If iend - oend margin is large enough, decompression inplace can be done
in the same buffer safely, as illustrated below:

         start of compressed logical extent
           |                          end of this logical extent
           |                           |
     ______v___________________________v________
... |  page 6  |  page 7  |  page 8  |  page 9  | ...
    |__________|__________|__________|__________|
           .                         ^ .        ^
           .                         |compressed|
           .                         |   data   |
           .                           .        .
           |<          dstsize        >|<margin>|
                                       oend     iend
           op                        ip

Fixed-size output compression can make the full use of this feature
to reduce memory overhead and avoid extra memcpy compared with fixed-size
input compression since iend is strictly not less than oend for fixed-size
output compression with inplace IO to last pages.

In addition, erofs compression indexes have been improved as well by
introducing compacted compression indexes.

These two techniques all benefit sequential read (on x86_64, 710.8MiB/s ->
755.4MiB/s; on Kirin980, 725MiB/s -> 812MiB/s) therefore erofs could have
similar sequential read performance against ext4 in a larger CR range
on high-spend SSD / NVMe devices as well.

However, note that it is _cpu vs storage device_ tradeoff, there is no
absolute performance conclusion for all on-market combinations.

Test images:
 name                       size                 CR
 enwik9                     1000000000           1.00
 enwik9_4k.squashfs.img      621211648           1.61
 enwik9_4k.erofs.img         558133248           1.79
 enwik9_8k.squashfs.img      556191744           1.80
 enwik9_16k.squashfs.img     502661120           1.99
 enwik9_128k.squashfs.img    398204928           2.51

Test Environment:
CPU: Intel(R) Core(TM) i5-8250U CPU @ 1.60GHz (4 cores, 8 threads)
DDR: 8G
SSD: INTEL SSDPEKKF360G7H
Kernel: Linux 5.2-rc3+ (with lz4-1.8.3 algorithm)

Test configuration:
squashfs:
CONFIG_SQUASHFS=y
CONFIG_SQUASHFS_FILE_DIRECT=y
CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=y
CONFIG_SQUASHFS_LZ4=y
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
erofs:
CONFIG_EROFS_FS_USE_VM_MAP_RAM=y
CONFIG_EROFS_FS_ZIP=y
CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=1
CONFIG_EROFS_FS_ZIP_CACHE_BIPOLAR=y

with intel_pstate=disable,
     8 cpus on at 1801000 scaling_{min,max}_freq,
     userspace scaling_governor

Sequential read results (MiB/s):
                           1      2      3      4      5      avg
 enwik9_4k.ext4.img        767    770    738    726    724    745
 enwik9_4k.erofs.img       756    745    770    746    760    755.4
 enwik9_4k.squashfs.img    90.3   83.0   94.3   90.7   92.6   90.18
 enwik9_8k.squashfs.img    111    108    110    108    110    109.4
 enwik9_16k.squashfs.img   158    163    146    165    174    161.2
 enwik9_128k.squashfs.img  324    314    262    262    296    291.6


Thanks,
Gao Xiang

Gao Xiang (8):
  staging: erofs: add compacted ondisk compression indexes
  staging: erofs: add compacted compression indexes support
  staging: erofs: move per-CPU buffers implementation to utils.c
  staging: erofs: move stagingpage operations to compress.h
  staging: erofs: introduce generic decompression backend
  staging: erofs: introduce LZ4 decompression inplace
  staging: erofs: switch to new decompression backend
  staging: erofs: integrate decompression inplace

 drivers/staging/erofs/Makefile        |   2 +-
 drivers/staging/erofs/compress.h      |  62 ++++
 drivers/staging/erofs/data.c          |   4 +-
 drivers/staging/erofs/decompressor.c  | 329 ++++++++++++++++++
 drivers/staging/erofs/erofs_fs.h      |  68 +++-
 drivers/staging/erofs/inode.c         |  12 +-
 drivers/staging/erofs/internal.h      |  52 ++-
 drivers/staging/erofs/unzip_vle.c     | 368 ++------------------
 drivers/staging/erofs/unzip_vle.h     |  38 +--
 drivers/staging/erofs/unzip_vle_lz4.c | 229 -------------
 drivers/staging/erofs/utils.c         |  12 +
 drivers/staging/erofs/zmap.c          | 463 ++++++++++++++++++++++++++
 12 files changed, 1006 insertions(+), 633 deletions(-)
 create mode 100644 drivers/staging/erofs/compress.h
 create mode 100644 drivers/staging/erofs/decompressor.c
 delete mode 100644 drivers/staging/erofs/unzip_vle_lz4.c
 create mode 100644 drivers/staging/erofs/zmap.c

-- 
2.17.1


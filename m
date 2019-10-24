Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D36E28EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 05:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437304AbfJXDdb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 23:33:31 -0400
Received: from sonic306-21.consmr.mail.gq1.yahoo.com ([98.137.68.84]:45356
        "EHLO sonic306-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437292AbfJXDd3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 23:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1571888008; bh=MUzNlJKVHsdOf5x4Tno5rHvOy1PcgxZhaxQfuSoCL8w=; h=Date:From:To:Cc:Subject:From:Subject; b=YXWvEZJbfG+PO9/IsK/qG3dNJ4dS2Qaa4zeTaIgc5hI8LrcXlnYGzXe49/tCU4ACl0YKPoteJHaRfjUKo2y48lGURe+QRbHT62PIZf66cg6vXax47r3M5l5WT+7K+IZWdgT6++c6jT4KY6DEL44f9aSlaaLt1GW9y+xDbHvSSjnuu9wq0PYeT6Hu31mw6l/Dxi5aB2jJebAUXPe24KeZrRy1cZumje/yyzbNAGjDRmvjOwIP9OBjVH8985ACOGHyNPbzuGx7hPQdwESpC09EpcncJzDlGUCVikgqFOp2+/AA9yCr5MsrjP2uHAL39QF1Z5M9QznK9e9OnXucvjhB8A==
X-YMail-OSG: iu4b2QQVM1k4kDgIw2_rp4EYA4aVCmI7mZT4VfFqbxRRW6Z..zQWkZ8RfaD0YOO
 ErjAC7IB4LG4Tf.LNfmz516wZG_l2yfcbpBegy6tY0MlhT_L6xKtR8XkFTi_bkH97uobk1tsGIXd
 0wJgNCp5hXJHqhsgwRbZIAZFZGzcJxBzhEJbOAzEmD3EmT8SjENE8HUbKpURKFlK.kDmsHsFBe7z
 H275feQybXR.TeVsRwp8d.Ku3NtMjuya7EyhOUpuQiFZMrDt4iylik.ay10HXlegQEUX8d7jCbUf
 GOvxA7jVIm7s3fCfpgHtyB_DPSBWRmCW1Lnyf1nzHwSLJ0IYpjiK2f4OxYmNd5MTE3cRc_WPDVyx
 Fj0WOfp0RbPKb4JiT4TeylVEh9G_sI03zctIK4YEJCMUwK60MJzsF4_8j.UkLzE75R8pVuj0yN80
 WMzLuCrIbr4IYSQbd9WjrNLp6.Sy.X2WSPnB0bRV775QasXEkGjMcdtf8gUK4sr_CD0hqb8xuvXq
 6xJRfXnjN.w9aOq9rQXts0qNCrMUyC0pfBPPanYzaJMNaEDL1YZgaYEXq5CnK0vCRsOs95lLLC4Y
 3571qjZ_y6WccceBBkO9ZG2RmLh3oJIk.F.WOyfjITxD4x4Qs3TTWBM7rnLS5UdQfxo_zB4eHx8F
 9U5EqtObRZDShCwOdY9Dp.NgTWAPyhDs6QkDTydlthzCDLx2F0.1pFL3UE0ZL2iezPUF0E23uJ8k
 ik45BMCkdIZqZZqGupZX1jLQm7U4iH_oMS9VTfXv7iYuS.93NOtCYR8Nbo8MNbCNwFjc_3xG5bbd
 ZwUt.0OcQ_l076EV8BljyC1Wllz.XLvfwoW3BVsSVd70p0AbNKLrWPy.qOXpIFEyMLgZ8LJv_vVd
 OTu3xHdFtJu9NqgTRKR6vyBQfRGqLObV5hHgU4wxZIiplpzgCLXtnzzq8.8wCra7E56u1xtkNKNc
 sis3cVA2SV90nBAl2KyQog84BGA.P.p0JKrHHkV5zQ7xwmgb5yvf9d2tetMV0sXZgUaXgycabhU0
 H9Jkr4JxjfdDUbqEynOZUiLkqr10lfuXJfOe3cieVQx9JbV8b_uI0gEaQdrVNYf5yXtfLjuKjqo_
 ejJZ6RjQ8eUfB9Y.5rv85ugV.DYVWs2IMmg.DSILd885RyuYhy4JpSgOnMHtfU1ugRyLskien7OP
 DNEUqOcRMGUKKGfb.KtstpUAKYGbir5nYRglIZfJNNzUe6u3nEZBT7XLLCd0fVwo_sUBfe7Oc_gk
 9qUoHgv6c1YKmPQU2SwDf2vCvCfAlwuwHMsaF2CTW8T2hWMVoptIkjoioNl7zyjCLxLKc1IdvISj
 H2S1lvDIY3zq5slTZumnwOq_snH.45fka3doFbX8f8xAV4bQRJfk-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Thu, 24 Oct 2019 03:33:28 +0000
Received: by smtp425.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 827f6da61f2baf0698881a00456dc1d7;
          Thu, 24 Oct 2019 03:33:24 +0000 (UTC)
Date:   Thu, 24 Oct 2019 11:33:10 +0800
From:   Gao Xiang <hsiangkao@aol.com>
To:     linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Cc:     debian-devel@lists.debian.org, opensuse@opensuse.org,
        kernel-team@android.com, devel@lists.fedoraproject.org,
        gentoo-dev@lists.gentoo.org, arch-dev-public@archlinux.org,
        ubuntu-devel-discuss@lists.ubuntu.com,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Coly Li <colyli@suse.de>,
        Yann Collet <yann.collet.73@gmail.com>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Zefan Li <lizefan@huawei.com>, Li Guifu <blucerlee@gmail.com>
Subject: [ANNOUNCE] erofs-utils: release 1.0 and package inclusion requests
Message-ID: <20191024033259.GA2513@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

I'm here to announce erofs-utils 1.0, which is userspace utilities of
EROFS file system and available at,

git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git tags/v1.0

 * first release with the following new features:
   - (mkfs.erofs) uncompressed file support;
   - (mkfs.erofs) uncompressed tail-end packing inline data support;
   - (mkfs.erofs) lz4 / lz4HC compressed file support;
   - (mkfs.erofs) special file support;
   - (mkfs.erofs) inline / shared xattrs support;
   - (mkfs.erofs) Posix ACL support;

It's also a package inclusion request (I've noticed a openSUSE package)
and please kindly read README first before starting.

As related materials mentioned [1] [2], the goal of EROFS is to save
extra storage space with guaranteed end-to-end performance for read-only
files, which has better performance via fixed-sized output compression
and inplace decompression over all other compression filesystems
based on fixed-sized input compression. It even has better performance
in a large compression ratio range compared with generic uncompressed
filesystems with proper CPU-storage combinations.

EROFS has been widely deployed to all HUAWEI smartphones for Android
system partitions from EMUI 9.1. In other words, if you buy any new
HUAWEI smartphones this year or upgrade your old phones with recent
EMUI 9.1+ releases, you will surely get an EROFS commercial copy.
EROFS is stable enough proven by 200-million+ devices [3] on the market.
In conclusion, it's highly recommended to try it out now with latest
code for all similar scenarios.

What we are recently working on are
 - demonstrate a new XZ algorithm in order to prepare for high CR
   compression, which is the next step of the generic approach;
 - prepare for releasing erofs-utils 1.0;

The roadmap of EROFS was discussed in China Linux Storage and File
System Workshop 2019 [4] shown as the presentation [5].
And it's still an open discussion as well since we are quite happy
to hear, implement and enhance any useful feature requests from
communities with proper priority and provide more complete and
competitive solution to all interested users and enrich related
ecosystem.

In the end, feel free to feedback any comments, questions, bugs,
suggestions, etc. to us for better improvements and welcome to join
us as well :-)
 linux-erofs@lists.ozlabs.org

Best regards and have a great day,
Gao Xiang

[1] https://kccncosschn19eng.sched.com/event/Nru2/erofs-an-introduction-and-our-smartphone-practice-xiang-gao-huawei
[2] https://www.usenix.org/conference/atc19/presentation/gao
[3] https://www.huaweicentral.com/huawei-exceeds-200-million-smartphone-shipment-64-days-ahead-compared-to-2018/
[4] Here are some past year annual report:
    https://blogs.oracle.com/linux/china-linux-storage-and-file-system-clsf-workshop-2014-v2
    https://blogs.oracle.com/linux/china-linux-storage-and-file-system-clsf-workshop-2015-report-v2
[5] https://github.com/hsiangkao/erofs-roadmap/raw/master/erofs-roadmap.pdf


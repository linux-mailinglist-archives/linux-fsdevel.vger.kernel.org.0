Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F0753F348
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 03:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbiFGBVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jun 2022 21:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232939AbiFGBVl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:21:41 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5298E1A3
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jun 2022 18:21:39 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ec42eae76bso160332797b3.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jun 2022 18:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Ld7rffB2zM0P1L5Muws5rr5XFvlh7I9fPWlnoLfiEY=;
        b=PuDUQdj3k5JzUdrWtsn57sBlmcMedekZSDyGA5yl2nVOwm1wib5/UMKaLaX0B4kgud
         Fe02Q8sELDv1qdv6NXGdG4YHAPGWqNOVZkoazfAr0i6ek0CiCONdnmIxvvM994xWJo/U
         1rImxR80rrn0F2vuH6GkoQ4+8/dIcIUiflUO9VQyeI4O+MVuHLdas6b7mXXMB/t/+UOm
         FIzkw9b5pzm1r+C1pcdRqg4oV59hJIDz/MlMcSNGfYyAKrX8VsPDJ9zFq9sqjpcg6nEe
         aamB1wztAA6YzZwXVwvp2QoMYPzqUQqfrD4KRfJ2MhupWtodQNKUYF6+MNugJrBXuFhJ
         5ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Ld7rffB2zM0P1L5Muws5rr5XFvlh7I9fPWlnoLfiEY=;
        b=XNPT3wfLjMf5Kfu3Sjv2X/gtXEXZ9xdSRZs2hRnvetYAhXVx6PJikpZZ8iTeOqMmbV
         c3s2Uc6pmnmdjq5Cz0krTySUUKvtJnI+kdHzDMSPH+NDOGjcM7jhI5QPuy+2DPv4rhYY
         5yWPvD6Otq8dARqcVv9oRuzybsHbW+fBIU3LgHH34UIp2unmBfrq6Oz2Fm1NFcQDIZnk
         eLvBWgx2uiABVaNKyk+aOUOVsLu1uLfH5vfihxmhO/Ne35PTBVKD67hinWjkONmm3mo+
         qzRdt5eKZCTSyzahMXNS7oJ9CRN+NokUXAOBRBrhjrcuDDXgHl46jRKbd6nasJDRsFkl
         AapQ==
X-Gm-Message-State: AOAM533dIhNqKUs8VE9xXQ/WkekJMBc7qhNOPcQkBaVjh4xmE3CQ/xw1
        OMQnoYel3cNCykE3o/BhlIPyTpF3bqTddaFPkHO+bg==
X-Google-Smtp-Source: ABdhPJwOEbQvUXK2zbhJ/RyjOVoJhvGmYn/P4I+zJ60e/dsXVROieVlz2v4124GGuj1BXyCUegvRD3t0vhZ23yuqwXA=
X-Received: by 2002:a81:1a43:0:b0:30c:78b1:f23d with SMTP id
 a64-20020a811a43000000b0030c78b1f23dmr29325800ywa.166.1654564898296; Mon, 06
 Jun 2022 18:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtVOfWWpx96fa3zzKzBPKiNu1w3FOD4j++G8MOG3Vs0EA@mail.gmail.com>
 <Yp47DODPCz0kNgE8@google.com>
In-Reply-To: <Yp47DODPCz0kNgE8@google.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 7 Jun 2022 06:51:27 +0530
Message-ID: <CA+G9fYsjn0zySHU4YYNJWAgkABuJuKtHty7ELHmN-+30VYgCDA@mail.gmail.com>
Subject: Re: qemu-arm: zram: mkfs.ext4 : Unable to handle kernel NULL pointer
 dereference at virtual address 00000140
To:     Minchan Kim <minchan@kernel.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        regressions@lists.linux.dev, Jens Axboe <axboe@kernel.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nitin Gupta <ngupta@vflare.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Jun 2022 at 23:06, Minchan Kim <minchan@kernel.org> wrote:
>
> On Thu, Jun 02, 2022 at 02:19:34PM +0530, Naresh Kamboju wrote:
> > The following kernel crash reported while running selftests: zram: zram.sh
> > test case on qemu-arm with Linux mainline v5.18.0 kernel version.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > Started noticing from kernel crash from
> > BAD: git_sha: cdeffe87f790dfd1baa193020411ce9a538446d7
> > GOOD:   git_sha: babf0bb978e3c9fce6c4eba6b744c8754fd43d8e
> >
> > # git log  --oneline
> > babf0bb978e3c9fce6c4eba6b744c8754fd43d8e..cdeffe87f790dfd1baa193020411ce9a538446d7
> >   -- drivers/block/
> > 98931dd95fd4 Merge tag 'mm-stable-2022-05-25' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > 6140ae41effe zram: fix Kconfig dependency warning
> > b3fbd58fcbb1 mm: Kconfig: simplify zswap configuration
> > e7be8d1dd983 zram: remove double compression logic
> > a2ad63daa88b VFS: add FMODE_CAN_ODIRECT file flag
> > 30226b69f876 zram: add a huge_idle writeback mode
>
> Hi Nalesh,
>
> Thanks for the reporting the bug!
>
> I locally ran the test in my x86 KVM machine but couldn't reproduce it.
> How is it easy to reproduce?  Could you help to bisect it?

It works on qemu_x86-64
It is always reproducible in qemu arm32 environment.

steps to reproduce:
# Please download and use this rootfs and kernel zImage

rootfs: https://oebuilds.tuxbuild.com/29zhlbEc3EWq2wod9Uy964Bp27q/images/am57xx-evm/rpb-console-image-lkft-am57xx-evm-20220601222434.rootfs.ext4.gz
kernel: https://builds.tuxbuild.com/29zhqJJizU2Y7Ka7ArhryUOrNDC/zImage

Boot command,
 /usr/bin/qemu-system-aarch64 -cpu host,aarch64=off -machine
virt-2.10,accel=kvm -nographic -net
nic,model=virtio,maaacaddr=BA:DD:AD:CC:09:04 -net tap -m 2048 -monitor
none -kernel kernel/zImage --append "console=ttyAMA0 root=/dev/vda rw"
-hda rootfs/rpb-console-image-lkft-am57xx-evm-20220601222434.rootfs.ext4
-m 4096 -smp 2

# cd /opt/kselftests/default-in-kernel/zram
# ./zram.sh

Allow me sometime I will try to bisect this problem.

>
> >
> >
> > metadata:
> >   git_ref: master
> >   git_repo: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline
> >   git_sha: 54eb8462f21fb170a05ad64620f0d8d0cf2b7fb5
> >   git_describe: v5.18-11934-g54eb8462f21f
> >   kernel_version: 5.18.0
> >   kernel-config: https://builds.tuxbuild.com/29zhqJJizU2Y7Ka7ArhryUOrNDC/config
> >   build-url: https://gitlab.com/Linaro/lkft/mirrors/torvalds/linux-mainline/-/pipelines/553652229
> >   artifact-location: https://builds.tuxbuild.com/29zhqJJizU2Y7Ka7ArhryUOrNDC
> >   toolchain: gcc-10
> >
> >
> > # selftests: zram: zram.sh
> > # --------------------
> > # running zram tests
> > # --------------------
> > # create '1' zram device(s)
> > [  637.356319] zram: Added device: zram0
> > # all zram devices (/dev/zram0~0) successfully created
> > # set max_comp_streams to zram device(s)
> > # The device attribute max_comp_streams was deprecated in 4.7
> > # test that we can set compression algorithm
> > [  637.494965] zram0: detected capacity change from 0 to 4096
> > # supported algs: lzo [lzo-rle] lz4 lz4hc 842 zstd
> > # /sys/block/zram0/comp_algorithm = 'lzo'
> > # zram set compression algorithm: OK
> > # set disk size to zram device(s)
> > # /sys/block/zram0/disksize = '2097152'
> > # zram set disksizes: OK
> > # set memory limit to zram device(s)
> > # /sys/block/zram0/mem_limit = '2M'
> > # zram set memory limit: OK
> > # make ext4 filesystem on /dev/zram0
> > [  637.601876] 8<--- cut here ---
> > [  637.603507] Unable to handle kernel NULL pointer dereference at
> > virtual address 00000140
> > [  637.607417] [00000140] *pgd=fb433835
> > [  637.609482] Internal error: Oops: 17 [#1] SMP ARM
> > [  637.612210] Modules linked in: zram zsmalloc crc32_arm_ce
> > sha2_arm_ce sha256_arm sha1_arm_ce sha1_arm aes_arm_ce crypto_simd
> > fuse [last unloaded: test_user_copy]
> > [  637.620508] CPU: 0 PID: 1841 Comm: mkfs.ext4 Not tainted 5.18.0 #1
> > [  637.624068] Hardware name: Generic DT based system
> > [  637.626863] PC is at strcmp+0x4/0x34
> > [  637.628970] LR is at register_lock_class+0x420/0x990
> > [  637.631865] pc : [<c09a55b0>]    lr : [<c03d2750>]    psr: a00d0093
> > [  637.635534] sp : f8ddda08  ip : 00000001  fp : c223c860
> > [  637.638621] r10: 00000000  r9 : ee4d62b4  r8 : c4bfd8c0
> > [  637.641668] r7 : ee4d62b4  r6 : c2b1b468  r5 : 00000140  r4 : c296e298
> > [  637.645436] r3 : 00000028  r2 : c223cd14  r1 : 00000140  r0 : c1ce4c99
> > [  637.649203] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
> > Segment none
> > [  637.653360] Control: 10c5383d  Table: 44ba406a  DAC: 00000051
> > [  637.656672] Register r0 information: non-slab/vmalloc memory
> > [  637.659948] Register r1 information: non-paged memory
> > [  637.662879] Register r2 information: non-slab/vmalloc memory
> > [  637.666158] Register r3 information: non-paged memory
> > [  637.669080] Register r4 information: non-slab/vmalloc memory
> > [  637.672359] Register r5 information: non-paged memory
> > [  637.675297] Register r6 information: non-slab/vmalloc memory
> > [  637.678576] Register r7 information: non-slab/vmalloc memory
> > [  637.681866] Register r8 information: slab task_struct start
> > c4bfd8c0 pointer offset 0
> > [  637.686367] Register r9 information: non-slab/vmalloc memory
> > [  637.689643] Register r10 information: NULL pointer
> > [  637.692425] Register r11 information: non-slab/vmalloc memory
> > [  637.695753] Register r12 information: non-paged memory
> > [  637.698763] Process mkfs.ext4 (pid: 1841, stack limit = 0xf5a44654)
> > [  637.702444] Stack: (0xf8ddda08 to 0xf8dde000)
> > [  637.704993] da00:                   c4bfe180 c03cb19c c223c80c
> > c250fde0 00000e9c c2966278
> > [  637.709779] da20: c21955d0 c2212b38 c298c1e4 c2969ce8 c223c80c
> > 000004cb c223c860 c298c1ec
> > [  637.714547] da40: 00000000 00000000 ee4d62b4 44aaea53 c4bfe1a0
> > 00000000 ee4d62b4 00000000
> > [  637.719313] da60: 00000000 00000000 c4bfd8c0 c21955d0 600d0013
> > c03ce488 c4bfd8c0 c2212b3c
> > [  637.724079] da80: 00000000 c2b1b468 00000001 c2212b38 c21955d0
> > 00000001 00000001 00000000
> > [  637.728872] daa0: fc90bff3 695acb4d c1cd9994 c2212b38 c03c9c78
> > 00000081 c278cf1c 00000000
> > [  637.733663] dac0: c4bfd8c0 c4bfd8c0 00000000 c03f543c c24c8120
> > c298c054 00cd9994 00000000
> > [  637.738484] dae0: 00000000 00000000 000325c8 efe7b070 c2211fd0
> > 00000000 c4bfe180 00000001
> > [  637.742919] db00: c4bfe1a0 44aaea53 c4bfd8c0 c4bfe1c0 c298c180
> > 00000002 00000003 00000001
> > [  637.747712] db20: c4bfe1a0 44aaea53 c4bfd8c0 c4bfd8c0 c21955d0
> > f8dddb50 2c337000 00000000
> > [  637.752446] db40: 00000000 c21955d0 600d0013 c03d1f0c 00000001
> > 00000000 00000000 bf03b20c
> > [  637.757225] db60: 00000000 00000000 600d0013 00000000 c4bfe1a0
> > 00000003 c4bfe8c0 c03d1bf8
> > [  637.761947] db80: bf03b214 00000000 efe7b070 00000001 00000001
> > 44aaea53 c5a2a45c c4bfd8c0
> > [  637.766631] dba0: c219f2b4 00000000 efe7b070 c4f67500 00000000
> > c5dc4480 ee4d62b4 bf03b284
> > [  637.771341] dbc0: 00000001 00000000 bf03b20c efe7b070 00000001
> > 00000002 c4d6c000 44aaea53
> > [  637.776474] dbe0: 00000041 c4b87400 c4bfd8c0 00000008 00000001
> > 00000000 c5ffd000 c25096d8
> > [  637.781409] dc00: c4bfe8c0 bf05db68 00000001 ee5d05bc ff7e1b00
> > c08d4100 00000041 44aaea53
> > [  637.786573] dc20: 000083db 00001000 c4b7ab40 c4b87400 00001000
> > 00001000 00000000 00000001
> > [  637.791837] dc40: 00000000 bf05e694 00000001 c4b7ab40 00000000
> > 00000000 c4bfd8c0 000083db
> > [  637.796665] dc60: ee5d05bc 00001000 00000000 44aaea53 f8dddef0
> > c4b7ab40 c5b6a200 c488ca50
> > [  637.801628] dc80: 00000000 c488ca50 c0637bf4 f8dddef0 ee5d05bc
> > c08d3434 c4bfd8c0 f8dddcac
> > [  637.806855] dca0: f8dddcb4 c08d384c f8dddef0 00000000 00000000
> > 00000000 00000000 44aaea53
> > [  637.811925] dcc0: c57e1900 c4b7ab40 f8dddef0 00000001 c15a0678
> > c063690c c2b805e4 00000000
> > [  637.816901] dce0: c57e1900 c57e1900 c57e1900 00000001 00000800
> > c063ae74 00000001 00000000
> > [  637.821961] dd00: c063b460 c21955d0 c388b60c ee5d05bc c08ca7b4
> > 00000800 00001000 c03d1b80
> > [  637.827194] dd20: f8dddef0 c1d0be34 00000000 c388b568 ee5d05bc
> > c054b91c 200d0013 c08ca7b4
> > [  637.832004] dd40: f8dddef0 00000001 c388b60c c063b460 c0637bf4
> > 00000000 c054b91c 00000000
> > [  637.837231] dd60: c054d370 00000000 000003bf ee5d05bc c388b6e0
> > 00000000 f8dddef0 c388b6e0
> > [  637.842190] dd80: 00000001 c1cec1c8 c4bfd8c0 c054b91c ee5d05bc
> > 00000002 00000000 c054c3bc
> > [  637.846933] dda0: 00000002 c2b1b468 c295c3a8 0000000f c24c87a0
> > c054b900 c388b6e0 ffffffff
> > [  637.852066] ddc0: 00000002 00000000 c24c4d16 00000001 c1cc76d0
> > c056c994 000001f4 c054000f
> > [  637.856917] dde0: ee5d02ec ee5d05bc ee5d0f70 ee5d0574 ee5d0550
> > ee5d0604 ee5d0628 ee5d064c
> > [  637.861861] de00: ee5d0670 ee5d05e0 ee5d0598 ee5d0310 ee5d0334
> > ee5d0358 ee5d037c 44aaea53
> > [  637.867225] de20: f8dddf10 c388b6e0 f8dddef0 c4bfd8c0 c24bec40
> > c5a29040 c2205d40 c054b900
> > [  637.872597] de40: c4bfd8c0 c054c754 600d0013 00000000 00000000
> > 00000001 00000000 f8ddde5c
> > [  637.877550] de60: f8ddde5c 44aaea53 000083db f8dddef0 c388b6e0
> > c054f870 00000000 c03c94bc
> > [  637.882533] de80: c4bfd8c0 c21955d0 c388b5e8 600d0013 c053df8c
> > c03d1b80 f8dddf10 c388b5d8
> > [  637.887577] dea0: c388b6e0 00000001 00000000 44aaea53 c388b5d8
> > c388b568 c388b6e0 f8dddef0
> > [  637.892439] dec0: c4bfd8c0 ffffffff 7fffffff c388b6e0 bee70850
> > c053df98 c4d8d140 00000000
> > [  637.897445] dee0: 00000000 c053f8e8 c05e6a9c 00002000 7ffffffe
> > 00000000 00000000 00000000
> > [  637.902564] df00: ffffffff 7fffffff 00000001 00000000 00000000
> > 00000000 00000000 00000000
> > [  637.907597] df20: 00000000 00000000 00000000 00000000 00000000
> > 00000000 00000000 44aaea53
> > [  637.912524] df40: 00000000 c4d8d140 c388b200 ffffffff 7fffffff
> > c03002f0 c4bfd8c0 00000076
> > [  637.917404] df60: bee70850 c08caa6c ffffffff 7fffffff c4bfd8c0
> > c4d8d140 00000000 c4d8d140
> > [  637.922414] df80: 00000076 c062dea8 ffffffff 7fffffff 00000000
> > c0484968 0003b930 0003b828
> > [  637.927508] dfa0: 00000000 c03000c0 0003b930 0003b828 00000005
> > 00046ac0 00000064 00000000
> > [  637.932747] dfc0: 0003b930 0003b828 00000000 00000076 00000000
> > bee70858 bee70848 bee70850
> > [  637.937624] dfe0: b6dcc5ec bee707f8 b6f0e0d0 b6dcc614 600d0010
> > 00000005 00000000 00000000
> > [  637.942533]  strcmp from register_lock_class+0x420/0x990
> > [  637.945907]  register_lock_class from __lock_acquire+0x6c/0x3160
> > [  637.949593]  __lock_acquire from lock_acquire+0x110/0x368
> > [  637.953086]  lock_acquire from zs_map_object+0x114/0x338 [zsmalloc]
> > [  637.957120]  zs_map_object [zsmalloc] from zram_bvec_rw+0x254/0xa58 [zram]
> > [  637.961317]  zram_bvec_rw [zram] from zram_submit_bio+0x1a0/0x3fc [zram]
> > [  637.965458]  zram_submit_bio [zram] from __submit_bio+0x50/0x80
> > [  637.969232]  __submit_bio from submit_bio_noacct_nocheck+0xb8/0x218
> > [  637.973158]  submit_bio_noacct_nocheck from submit_bh_wbc+0x150/0x184
> > [  637.977451]  submit_bh_wbc from __block_write_full_page+0x3d0/0x6d0
> > [  637.981234]  __block_write_full_page from block_write_full_page+0x148/0x18c
> > [  637.985521]  block_write_full_page from __writepage+0x1c/0x74
> > [  637.989230]  __writepage from write_cache_pages+0x1b4/0x4f4
> > [  637.992870]  write_cache_pages from generic_writepages+0x58/0x84
> > [  637.996662]  generic_writepages from do_writepages+0x7c/0x1b8
> > [  638.000211]  do_writepages from filemap_fdatawrite_wbc+0x6c/0x8c
> > [  638.003882]  filemap_fdatawrite_wbc from file_write_and_wait_range+0x90/0xec
> > [  638.008430]  file_write_and_wait_range from blkdev_fsync+0x20/0x44
> > [  638.012599]  blkdev_fsync from do_fsync+0x44/0x78
> > [  638.015687]  do_fsync from ret_fast_syscall+0x0/0x1c
> > [  638.018753] Exception stack(0xf8dddfa8 to 0xf8dddff0)
> > [  638.021970] dfa0:                   0003b930 0003b828 00000005
> > 00046ac0 00000064 00000000
> > [  638.027005] dfc0: 0003b930 0003b828 00000000 00000076 00000000
> > bee70858 bee70848 bee70850
> > [  638.032283] dfe0: b6dcc5ec bee707f8 b6f0e0d0 b6dcc614
> > [  638.035336] Code: e3520000 1afffffb e12fff1e e4d03001 (e4d12001)
> > [  638.038967] ---[ end trace 0000000000000000 ]---
> > [  638.042059] note: mkfs.ext4[1841] exited with preempt_count 3
> > [  638.045764] ------------[ cut here ]------------
> > [  638.048739] WARNING: CPU: 0 PID: 1841 at kernel/exit.c:741
> > do_exit+0x89c/0xabc
> > [  638.053078] Modules linked in: zram zsmalloc crc32_arm_ce
> > sha2_arm_ce sha256_arm sha1_arm_ce sha1_arm aes_arm_ce crypto_simd
> > fuse [last unloaded: test_user_copy]
> > [  638.062016] CPU: 0 PID: 1841 Comm: mkfs.ext4 Tainted: G      D
> >      5.18.0 #1
> > [  638.066616] Hardware name: Generic DT based system
> > [  638.069774]  unwind_backtrace from show_stack+0x18/0x1c
> > [  638.073014]  show_stack from dump_stack_lvl+0x58/0x70
> > [  638.076068]  dump_stack_lvl from __warn+0xd4/0x1f8
> > [  638.079207]  __warn from warn_slowpath_fmt+0x64/0xc8
> > [  638.082237]  warn_slowpath_fmt from do_exit+0x89c/0xabc
> > [  638.085673]  do_exit from make_task_dead+0x64/0x108
> > [  638.088805]  make_task_dead from die+0x4c8/0x4e8
> > [  638.091686]  die from die_kernel_fault+0x6c/0x7c
> > [  638.094593]  die_kernel_fault from do_page_fault+0x260/0x4d0
> > [  638.098154]  do_page_fault from do_DataAbort+0x44/0xb8
> > [  638.101252]  do_DataAbort from __dabt_svc+0x50/0x80
> > [  638.104195] Exception stack(0xf8ddd9b8 to 0xf8ddda00)
> > [  638.107270] d9a0:
> >     c1ce4c99 00000140
> > [  638.112202] d9c0: c223cd14 00000028 c296e298 00000140 c2b1b468
> > ee4d62b4 c4bfd8c0 ee4d62b4
> > [  638.117497] d9e0: 00000000 c223c860 00000001 f8ddda08 c03d2750
> > c09a55b0 a00d0093 ffffffff
> > [  638.122444]  __dabt_svc from strcmp+0x4/0x34
> > [  638.125046]  strcmp from register_lock_class+0x420/0x990
> > [  638.128479]  register_lock_class from __lock_acquire+0x6c/0x3160
> > [  638.132377]  __lock_acquire from lock_acquire+0x110/0x368
> > [  638.135805]  lock_acquire from zs_map_object+0x114/0x338 [zsmalloc]
> > [  638.139633]  zs_map_object [zsmalloc] from zram_bvec_rw+0x254/0xa58 [zram]
> > [  638.143938]  zram_bvec_rw [zram] from zram_submit_bio+0x1a0/0x3fc [zram]
> > [  638.148313]  zram_submit_bio [zram] from __submit_bio+0x50/0x80
> > [  638.152092]  __submit_bio from submit_bio_noacct_nocheck+0xb8/0x218
> > [  638.155933]  submit_bio_noacct_nocheck from submit_bh_wbc+0x150/0x184
> > [  638.159978]  submit_bh_wbc from __block_write_full_page+0x3d0/0x6d0
> > [  638.164067]  __block_write_full_page from block_write_full_page+0x148/0x18c
> > [  638.168468]  block_write_full_page from __writepage+0x1c/0x74
> > [  638.171927]  __writepage from write_cache_pages+0x1b4/0x4f4
> > [  638.175439]  write_cache_pages from generic_writepages+0x58/0x84
> > [  638.179326]  generic_writepages from do_writepages+0x7c/0x1b8
> > [  638.183127]  do_writepages from filemap_fdatawrite_wbc+0x6c/0x8c
> > [  638.186969]  filemap_fdatawrite_wbc from file_write_and_wait_range+0x90/0xec
> > [  638.191265]  file_write_and_wait_range from blkdev_fsync+0x20/0x44
> > [  638.195170]  blkdev_fsync from do_fsync+0x44/0x78
> > [  638.198082]  do_fsync from ret_fast_syscall+0x0/0x1c
> > [  638.201275] Exception stack(0xf8dddfa8 to 0xf8dddff0)
> > [  638.204268] dfa0:                   0003b930 0003b828 00000005
> > 00046ac0 00000064 00000000
> > [  638.209369] dfc0: 0003b930 0003b828 00000000 00000076 00000000
> > bee70858 bee70848 bee70850
> > [  638.214332] dfe0: b6dcc5ec bee707f8 b6f0e0d0 b6dcc614
> > [  638.217355] irq event stamp: 8301
> > [  638.219375] hardirqs last  enabled at (8301): [<c056b870>]
> > inc_zone_page_state+0x5c/0x64
> > [  638.224163] hardirqs last disabled at (8300): [<c056b860>]
> > inc_zone_page_state+0x4c/0x64
> > [  638.228961] softirqs last  enabled at (8066): [<c0301f40>]
> > __do_softirq+0x300/0x538
> > [  638.233533] softirqs last disabled at (8057): [<c035a19c>]
> > __irq_exit_rcu+0x14c/0x170
> > [  638.238189] ---[ end trace 0000000000000000 ]---
> >
> >
> > Full test log link:
> > https://lkft.validation.linaro.org/scheduler/job/5121436#L1583
> > https://lkft.validation.linaro.org/scheduler/job/5123008
> > https://qa-reports.linaro.org/lkft/linux-mainline-master/build/v5.18-11934-g54eb8462f21f/testrun/9879010/suite/log-parser-test/test/check-kernel-oops-5121436/details/
> >
> > --
> > Linaro LKFT
> > https://lkft.linaro.org

- Naresh

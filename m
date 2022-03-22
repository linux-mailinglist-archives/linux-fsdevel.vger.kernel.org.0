Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60EB4E485F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 22:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiCVVkF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 17:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiCVVkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:40:03 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0002E1E7;
        Tue, 22 Mar 2022 14:38:34 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2d07ae0b1c4so205756697b3.11;
        Tue, 22 Mar 2022 14:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhLarTeeHq9Nw1QHwQ6lX7PivjIpiPg5RT82IKgrTQg=;
        b=QWPcc9K6kzpiWSg9bHLC5Ux6pTX071FsZCtYcVlnRLs8JJwtJ/ac0IRalJyb1gFY56
         hViyubD+HNdafzHy5Qz3FFcJpGRXNix1sXy2MRg1th11yXiDzC1q/YhcakyMmedpM/MX
         QLlSQZIk9Wmc7M51DdE4pN8MFJitd6EJOqN75Ygi/YGCa+D5yg/V6G2V04YueUTt9snG
         Rqbwz9gEOsw6btamKuqw+UBaG4ttR1SzG8LdH1jU0rRf09UomDnAx+xzdQDjMcFzcmY2
         c+QMYpXmDvodY1c19bSYMQ2Ux8egAVrEefZLoPNjtPi8yHTUeSgb7BUgyq76+9YNObBn
         OZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhLarTeeHq9Nw1QHwQ6lX7PivjIpiPg5RT82IKgrTQg=;
        b=Dqlvp/TtsK9kFwekFJiYv+VU5V/CWMuQynvmYsxTUSpriQk5ZtUUjLWNW8K31fkGdQ
         K3KESNBIf8VSgdXAxFEHPwSWMFLwy/8pfUdjrw84kV654NQgIZjYzSOcyot8a/3jNZbR
         5iu+pU+8/a6g3RQcLN9cQFDYfm+Bu2lqHrDhRTSPFY1TvkmpBvSyJAtkHiAbMsAixnAG
         PH+51Gqg86zpjxpSxUBIaY8wBpt/iMFJLT4bfAjXB5oBspgxc7vnxV5x4wBpcTbH3b0j
         V4uyj4womdwMklsK4vAMdA5/qhmEkSqd0EUOn2vquElwbzeJZIISB9xOYc8iBSBorx5c
         BVqg==
X-Gm-Message-State: AOAM531WNzUyJJA+hf5CD22V7WX+3Do+QBa8hjb+QKdADmPWyfjZ2jC/
        knzCVt8BQ/Ld49aGghfN+HVv1PD0dVLgHHtIPco=
X-Google-Smtp-Source: ABdhPJw0CYtdti1wVV2bzL0irqt0sBusP9ofAFMscIeoyKl0lzXWGgn2B6cpzjxnKIOUPgO6Hm94TeUp8pnZ5ssFqRM=
X-Received: by 2002:a81:148f:0:b0:2e5:d8d9:5116 with SMTP id
 137-20020a81148f000000b002e5d8d95116mr25793876ywu.111.1647985114087; Tue, 22
 Mar 2022 14:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220124091107.642561-1-hch@lst.de> <20220124091107.642561-2-hch@lst.de>
 <20220322211915.GA2413063@roeck-us.net>
In-Reply-To: <20220322211915.GA2413063@roeck-us.net>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 23 Mar 2022 06:38:22 +0900
Message-ID: <CAKFNMonRd5QQMzLoH3T=M=C=2Q_j9d86EYzZeY4DU2HQAE3E8w@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH 01/19] fs: remove mpage_alloc
To:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nfs@vger.kernel.org,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.co>,
        device-mapper development <dm-devel@redhat.com>,
        "Md . Haris Iqbal" <haris.iqbal@ionos.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-fsdevel@vger.kernel.org, xen-devel@lists.xenproject.org,
        Andrew Morton <akpm@linux-foundation.org>,
        ntfs3@lists.linux.dev, Jack Wang <jinpu.wang@ionos.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 6:19 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Jan 24, 2022 at 10:10:49AM +0100, Christoph Hellwig wrote:
> > open code mpage_alloc in it's two callers and simplify the results
> > because of the context:
> >
> >  - __mpage_writepage always passes GFP_NOFS and can thus always sleep and
> >     will never get a NULL return from bio_alloc at all.
> >  - do_mpage_readpage can only get a non-sleeping context for readahead
> >    which never sets PF_MEMALLOC and thus doesn't need the retry loop
> >    either.
> >
> > Both cases will never have __GFP_HIGH set.
> >
>
> With this patch in the tree, I get:
>
> [    1.198134] Unexpected gfp: 0x2 (__GFP_HIGHMEM). Fixing up to gfp: 0x1192888 (GFP_NOWAIT|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_NOMEMALLOC|__GFP_HARDWALL|__GFP_MOVABLE|__GFP_SKIP_KASAN_POISON). Fix your code!
> [    1.198783] CPU: 0 PID: 1 Comm: init Not tainted 5.17.0-01402-g8565d64430f8 #1
> [    1.199165] Stack : 0000000000000042 0000000000000000 0000000000000008 dae882cc7dea7ec4
> [    1.199563]         a8000000014f0c00 0000000000000000 a80000000146b2c8 ffffffff80d3a920
> [    1.199750]         a80000000146b0e0 0000000000000001 0000000000000000 0000000000000000
> [    1.199936]         000000000003087f 0000000000000000 ffffffff806d9f54 0000000000000000
> [    1.200121]         a80000000146b16f ffffffff80da0000 0000000000000001 000000000119288a
> [    1.200306]         ffffffff80da0000 ffffffffffffffff 000000000119288a 000000000119288a
> [    1.200491]         a800000001416f00 0000000000000000 ffffffff80774d30 ffffffffa0042718
> [    1.200676]         ffffffff80ec2158 a800000001468000 a80000000146b2c0 0000000000000000
> [    1.200861]         ffffffff80b55730 0000000000000000 a80000000146b3f8 ffffffff80d3a920
> [    1.201046]         0000000000000001 000000000119288a ffffffff80108fa0 dae882cc7dea7ec4
> [    1.201236]         ...
> [    1.201548] Call Trace:
> [    1.201622] [<ffffffff80108fa0>] show_stack+0x38/0x118
> [    1.201960] [<ffffffff80b55730>] dump_stack_lvl+0x50/0x6c
> [    1.202105] [<ffffffff80b4d8a4>] kmalloc_fix_flags+0x60/0x88
> [    1.202249] [<ffffffff802b40f8>] new_slab+0x2d8/0x320
> [    1.202375] [<ffffffff802b6844>] ___slab_alloc.constprop.0+0x33c/0x5e8
> [    1.202528] [<ffffffff802b6b24>] __slab_alloc.constprop.0+0x34/0x50
> [    1.202675] [<ffffffff802b72b8>] kmem_cache_alloc+0x320/0x368
> [    1.202811] [<ffffffff805e2a68>] bvec_alloc+0x78/0x128
> [    1.202936] [<ffffffff805e2fac>] bio_alloc_bioset+0x194/0x340
> [    1.203073] [<ffffffff80325bd8>] do_mpage_readpage+0x540/0x6e0
> [    1.203213] [<ffffffff80325e38>] mpage_readahead+0xc0/0x198
> [    1.203346] [<ffffffff802583a8>] read_pages+0xc0/0x2e0
> [    1.203472] [<ffffffff802589a4>] page_cache_ra_unbounded+0x1cc/0x290
> [    1.203622] [<ffffffff8024e2fc>] filemap_fault+0x4f4/0x7e8
> [    1.203753] [<ffffffff80282b2c>] __do_fault+0x44/0x190
> [    1.203878] [<ffffffff80288e0c>] __handle_mm_fault+0x7e4/0xcd0
> [    1.204015] [<ffffffff80289408>] handle_mm_fault+0x110/0x258
> [    1.204149] [<ffffffff801220e0>] do_page_fault+0x110/0x4f0
> [    1.204278] [<ffffffff801288d8>] tlb_do_page_fault_1+0x108/0x110
> [    1.204421] [<ffffffff8035eddc>] padzero+0x64/0x98
> [    1.204538] [<ffffffff80360618>] load_elf_binary+0x1808/0x18d0
> [    1.204677] [<ffffffff802d9f40>] bprm_execve+0x240/0x5a8
> [    1.204806] [<ffffffff802db49c>] kernel_execve+0x144/0x200
> [    1.204937] [<ffffffff80b4a658>] try_to_run_init_process+0x18/0x58
> [    1.205085] [<ffffffff80b5ecc0>] kernel_init+0xb4/0x10c
> [    1.205220] [<ffffffff80102558>] ret_from_kernel_thread+0x14/0x1c
>
> with some qemu emulations. Bisect log is attached.
>
> I can not easily revert the patch since an attempt to do so causes
> conflicts, so I can not test upstream without this patch.
>
> Guenter

This looks because the mask of GFP_KERNEL is removed along with
the removal of mpage_alloc().

-static struct bio *
-mpage_alloc(struct block_device *bdev,
-               sector_t first_sector, int nr_vecs,
-               gfp_t gfp_flags)
-{
-       struct bio *bio;
-
-       /* Restrict the given (page cache) mask for slab allocations */
-       gfp_flags &= GFP_KERNEL;
-       bio = bio_alloc(gfp_flags, nr_vecs);

In read ahead mode, do_mpage_readpage() uses the gfp flag of page->mapping.

        if (args->is_readahead) {
                op |= REQ_RAHEAD;
                gfp = readahead_gfp_mask(page->mapping);
        } else {
                gfp = mapping_gfp_constraint(page->mapping, GFP_KERNEL);
        }

The default value of the gfp flag is set to GFP_HIGHUSER_MOVABLE by
inode_init_always().
So, __GFP_HIGHMEM hits the gfp warning at bio_alloc() that
do_mpage_readpage() calls.


Ryusuke Konishi


>
> ---
> # bad: [8565d64430f8278bea38dab0a3ab60b4e11c71e4] Merge tag 'bounds-fixes-v5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
> # good: [f443e374ae131c168a065ea1748feac6b2e76613] Linux 5.17
> git bisect start 'HEAD' 'v5.17'
> # good: [5628b8de1228436d47491c662dc521bc138a3d43] Merge tag 'random-5.18-rc1-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/crng/random
> git bisect good 5628b8de1228436d47491c662dc521bc138a3d43
> # bad: [69d1dea852b54eecd8ad2ec92a7fd371e9aec4bd] Merge tag 'for-5.18/drivers-2022-03-18' of git://git.kernel.dk/linux-block
> git bisect bad 69d1dea852b54eecd8ad2ec92a7fd371e9aec4bd
> # good: [b080cee72ef355669cbc52ff55dc513d37433600] Merge tag 'for-5.18/io_uring-statx-2022-03-18' of git://git.kernel.dk/linux-block
> git bisect good b080cee72ef355669cbc52ff55dc513d37433600
> # bad: [22027a9811349de28f81e13e20e83299099acd3a] nvmet: replace ida_simple[get|remove] with the simler ida_[alloc|free]
> git bisect bad 22027a9811349de28f81e13e20e83299099acd3a
> # bad: [672fdcf0e7de3b1e39416ac85abf178f023271f1] block: partition include/linux/blk-cgroup.h
> git bisect bad 672fdcf0e7de3b1e39416ac85abf178f023271f1
> # bad: [b42c1fc3d55e077d36718ad9800d89100b2aff81] block: fix the kerneldoc for bio_end_io_acct
> git bisect bad b42c1fc3d55e077d36718ad9800d89100b2aff81
> # bad: [4b1dc86d1857f1007865cab759f2285280692eee] drbd: bio_alloc can't fail if it is allow to sleep
> git bisect bad 4b1dc86d1857f1007865cab759f2285280692eee
> # bad: [f0d911927b3c7cf5f9edb5941d0287144a602d0d] nilfs2: remove nilfs_alloc_seg_bio
> git bisect bad f0d911927b3c7cf5f9edb5941d0287144a602d0d
> # good: [e7243285c0fc87054990fcde630583586ff8ed5f] block: move blk_drop_partitions to blk.h
> git bisect good e7243285c0fc87054990fcde630583586ff8ed5f
> # bad: [d5f68a42da7a4516e7503c281a54a58727f07dc3] fs: remove mpage_alloc
> git bisect bad d5f68a42da7a4516e7503c281a54a58727f07dc3
> # good: [322cbb50de711814c42fb088f6d31901502c711a] block: remove genhd.h
> git bisect good 322cbb50de711814c42fb088f6d31901502c711a
> # first bad commit: [d5f68a42da7a4516e7503c281a54a58727f07dc3] fs: remove mpage_alloc

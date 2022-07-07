Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19F5A569DAC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 10:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235174AbiGGImv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 04:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbiGGImu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:42:50 -0400
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5D5421AD
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jul 2022 01:42:48 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 23F7720CA8
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jul 2022 17:42:48 +0900 (JST)
Received: by mail-pf1-f200.google.com with SMTP id y37-20020a056a001ca500b00528bbf82c1eso2702355pfw.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jul 2022 01:42:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3KNJ0jvCuSTCRCLb61BgOL0HuOp/dDIh3Ds4jE5/Wd8=;
        b=F4kvpR0SprEtNMkL0SY5eUDVLwG4hBN2JpcRLl4UoAyZGIgz+e2FaHLFgVATnhYO5l
         Gu8eyocQB+iuLuDq4gpO8t07X4elHHn3GpJjxSOtuRhIkStqpYVaYwcaEhpyWAT0Ua/C
         d0CrGHJoxKRpIHpEzcqNnE9YxRWv2CTMYL28jJo4P3bB3l46FZNQtpkSg4vLF8lMouLb
         2CQdT86WwdQXafCbBR7bE7uDFW6IebIw+52WGagSs4jWZQjIweDLTjvF5v8ph7txGAMV
         L3Mrj6rKMI5a6U5nsDCf5/+UWC1HRaiM2ykWg4D4zL1Yj5AARkxNzrse3oPRdn1/Xv/T
         Pnrw==
X-Gm-Message-State: AJIora8B0YPoLrwOTDtRhYJPlZnfQuKv7etWoipVdMc2u+Q1ATZXFx5E
        lEfm3jVbQ0ZOpArq9lSlD8xiSHhVwVpR8U++JfEBtYQIKBftK27tNPV8zKBk/e0vHe1sF9xPfuf
        WXo1bHv2SwaL1w4BLdPp2jzzk2SY=
X-Received: by 2002:a17:902:ce8b:b0:16c:66d:c455 with SMTP id f11-20020a170902ce8b00b0016c066dc455mr6226720plg.41.1657183367154;
        Thu, 07 Jul 2022 01:42:47 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sl6xaortDRQF+TsW10UlLhtxNJzNhgEA9NhVfM/GsCZojFjHwA/fsAEiLsvbH+YtNDguJMYA==
X-Received: by 2002:a17:902:ce8b:b0:16c:66d:c455 with SMTP id f11-20020a170902ce8b00b0016c066dc455mr6226682plg.41.1657183366698;
        Thu, 07 Jul 2022 01:42:46 -0700 (PDT)
Received: from pc-zest.atmarktech (103.131.189.35.bc.googleusercontent.com. [35.189.131.103])
        by smtp.gmail.com with ESMTPSA id n7-20020a170903110700b0016bfa097927sm4308856plh.249.2022.07.07.01.42.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jul 2022 01:42:46 -0700 (PDT)
Received: from martinet by pc-zest.atmarktech with local (Exim 4.95)
        (envelope-from <martinet@pc-zest>)
        id 1o9N5x-009Ogn-2d;
        Thu, 07 Jul 2022 17:42:45 +0900
Date:   Thu, 7 Jul 2022 17:42:35 +0900
From:   Dominique MARTINET <dominique.martinet@atmark-techno.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: Major btrfs fiemap slowdown on file with many extents once in
 cache (RCU stalls?) (Was: [PATCH 1/3] filemap: Correct the conditions for
 marking a folio as accessed)
Message-ID: <Ysace25wh5BbLd5f@atmark-techno.com>
References: <20220619151143.1054746-1-willy@infradead.org>
 <20220619151143.1054746-2-willy@infradead.org>
 <Yr1QwVW+sHWlAqKj@atmark-techno.com>
 <8cffd985-ba62-c4be-f9af-bb8314df8a67@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8cffd985-ba62-c4be-f9af-bb8314df8a67@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(added btrfs maintainers in direct cc)

Yu Kuai wrote on Fri, Jul 01, 2022 at 09:55:31AM +0800:
> With this patch ctive_page() will be called the second time that page is
> mark accessed, which has some extra overhead, however, 2GB/s -> 100MB/s
> is insane, I'm not sure how this is possible, but it seems like it has
> something to do with this change.(Noted that it's problematic that page
> will not mark accessed before this patch).

I honestly don't understand why folio being marked as accessed affects
how fiemap is processed...
My guess would be that this indeed "just fixes" that pages didn't get
marked as accessed -> were dropped from cache -> it kept the inode
io_tree small -> fiemap was fast ; and it really just a problem that the
fiemap algorithm doesn't scale, but I haven't really checked if I'm
right here.


So I don't think we should focus so much on the regression part as to
figure out what's actually different the second time around and make
that faster.


checking with 'perf script' btrfs_get_extent_fiemap() spends most of its
time on this:
 delalloc_len = count_range_bits(&inode->io_tree, &delalloc_start,
                                 end, len, EXTENT_DELALLOC, 1);

I have no idea what delalloc is supposed to be, but I can guess there is
just way too many nodes in the io_tree: why is that and why wasn't there
so many the first time around? I would assumed that as the file gets
read it is put into cache, so the end of the first read should slow down
as well but it didn't, so I'm sure I misunderstood something and I'm
wasting everyone's time. Feel free to ignore me and find the issue
instead :)


> BTW, during my test, the speed of buffer read in ext4 only fell down a
> little.

For "normal" files that don't have ~200k extents full of holes and
compression changes and whatever else this has gone through, I can
confirm the slowdown is not as bad -- almost unnoticeable when few
extents.
but I still have my laptop cashing when I'm copying this file twice
(well, I -could- just turn off panic_on_stall...) so it can go from a
little to infinity...


Thanks,

(Leaving rest of the message for anyone catching up now; if there's
anything you'd like me to do feel free to ask.)

> > I've taken a moment to bisect this and came down to this patch.
> > (5ccc944dce3d ("filemap: Correct the conditions for marking a folio
> > as accessed"))
> > 
> > [1] https://lore.kernel.org/all/YrrFGO4A1jS0GI0G@atmark-techno.com/T/#u
> > 
> > 
> > 
> > Dropping caches (echo 3 > /proc/sys/vm/drop_caches) restore the speed,
> > so there appears to be some bad effect to having the file in cache for
> > fiemap?
> > To be fair that file is pretty horrible:
> > ---
> > # compsize bigfile
> > Processed 1 file, 194955 regular extents (199583 refs), 0 inline.
> > Type       Perc     Disk Usage   Uncompressed Referenced
> > TOTAL       15%      3.7G          23G          23G
> > none       100%      477M         477M         514M
> > zstd        14%      3.2G          23G          23G
> > ---
> > 
> > Here's what perf has to say about it on top of this patch when running
> > `cp bigfile /dev/null` the first time:
> > 
> > 98.97%     0.00%  cp       [kernel.kallsyms]    [k]
> > entry_SYSCALL_64_after_hwframe
> >   entry_SYSCALL_64_after_hwframe
> >   do_syscall_64
> >    - 93.40% ksys_read
> >       - 93.36% vfs_read
> >          - 93.25% new_sync_read
> >             - 93.20% filemap_read
> >                - 83.38% filemap_get_pages
> >                   - 82.76% page_cache_ra_unbounded
> >                      + 59.72% folio_alloc
> >                      + 13.43% read_pages
> >                      + 8.75% filemap_add_folio
> >                        0.64% xa_load
> >                     0.52% filemap_get_read_batch
> >                + 8.75% copy_page_to_iter
> >    - 4.73% __x64_sys_ioctl
> >       - 4.72% do_vfs_ioctl
> >          - btrfs_fiemap
> >             - 4.70% extent_fiemap
> >                + 3.95% btrfs_check_shared
> >                + 0.70% get_extent_skip_holes
> > 
> > and second time:
> > 99.90%     0.00%  cp       [kernel.kallsyms]    [k]
> > entry_SYSCALL_64_after_hwfram
> >   entry_SYSCALL_64_after_hwframe
> >   do_syscall_64
> >    - 94.62% __x64_sys_ioctl
> >         do_vfs_ioctl
> >         btrfs_fiemap
> >       - extent_fiemap
> >          - 50.01% get_extent_skip_holes
> >             - 50.00% btrfs_get_extent_fiemap
> >                - 49.97% count_range_bits
> >                     rb_next
> >          + 28.72% lock_extent_bits
> >          + 15.55% __clear_extent_bit
> >    - 5.21% ksys_read
> >       + 5.21% vfs_read
> > 
> > (if this isn't readable, 95% of the time is spent on fiemap the second
> > time around)
> > 
> > 
> > 
> > 
> > I've also been observing RCU stalls on my laptop with the same workload
> > (cp to /dev/null), but unfortunately I could not reproduce in qemu so I
> > could not take traces to confirm they are caused by the same commit but
> > given the workload I'd say that is it?
> > I can rebuild a kernel for my laptop and confirm if you think it should
> > be something else.
> > 
> > 
> > I didn't look at the patch itself (yet) so have no suggestion at this
> > point - it's plausible the patch fixed something and just exposed slow
> > code that had been there all along so it might be better to look at the
> > btrfs side first, I don't know.
> > If you don't manage to reproduce I'll be happy to test anything thrown
> > at me at the very least.

-- 
Dominique

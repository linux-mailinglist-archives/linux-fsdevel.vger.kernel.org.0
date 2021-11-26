Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D42D45ED9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Nov 2021 13:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbhKZMN3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Nov 2021 07:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377237AbhKZML2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Nov 2021 07:11:28 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C308BC061D79;
        Fri, 26 Nov 2021 03:36:19 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id k2so18198139lji.4;
        Fri, 26 Nov 2021 03:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YwchqcLp4vuWkP53NqIQryr+Cx6rF4LvbCWU6gG8vgs=;
        b=Wx4C6KctFZg7aqSyKW+5+/sbQhhBjaUfjiH74wowUy/K6HSWCuCDM7VOY9VqbnmvKA
         UM4eGn95CuRCRfYKXzdLqbHNiNvlWX+kM3hoLmDwsJlpoE5OWoOdY5rApuDlp5HbetZy
         +25hea9st2iqjThXTwqUrO7lXT9SyYVYMPfHBecz7hSsskk04t/+RlaY5R1Xk3kRnWiM
         d00+D8VKXzttb3URv6kH2eAKfN1oHCdv2L8DxGQJfWlOohi9IEGWfVOUxl/oJWv9FaZM
         /uoMbZQBu3QNp0le87EDcovGewCvWN44pvCby93xViSPs2a4SgY30hSjneBeBMCWemFz
         jLIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YwchqcLp4vuWkP53NqIQryr+Cx6rF4LvbCWU6gG8vgs=;
        b=ZFawKg8LNvazXRaEf2G/D/2voGGt3WEcAQMvzjdHCMAE5PE2+U6RwKUk8t/h/Bfmiv
         gbnGkJJLyIhLtBZK3ucGNkAF8W3hot6ND5D/Ri1iIS94AHRfSeBX71SsOeLBrxhi1zJd
         xK1YWa5e69viBLBXyJvf9HWD0VblIFFipCnIchPy3Mqp5bpNmXXn9Hk9S1DWJeToAEhg
         nW/R+hAxAnGT1fxjRbgd6s6jl9ptnlwNLA07t3cGiJ6pfbPx+C8OQ8vKfn1fabUE6sF6
         abHmaF7XYvrajvjiNceXuC04xfuxDAvWI69LeyapB1G6eKp2TOrAszl/darevB/3tWza
         0DHA==
X-Gm-Message-State: AOAM530NsV9qFQwM/IGBoS3JH4uSZPpw0syomlpT67VhVlVjwG3wLSgB
        aifMZu6GfvLdFux2kAZhrccjbdX3QEk=
X-Google-Smtp-Source: ABdhPJytBhhNePIUfAl1MAlNnjKZMQsdxRpfRZWlULulpz+FR6PPbXkhKwOOp3vvUBd3DN2P3l00gA==
X-Received: by 2002:a2e:9450:: with SMTP id o16mr29615658ljh.444.1637926577785;
        Fri, 26 Nov 2021 03:36:17 -0800 (PST)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id f14sm552842lfv.180.2021.11.26.03.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 03:36:17 -0800 (PST)
Date:   Fri, 26 Nov 2021 13:36:15 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     yangerkun <yangerkun@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>, ntfs3@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [ramfs] 0858d7da8a: canonical_address#:#[##]
Message-ID: <20211126113615.nmegssvcrmjlodku@kari-VirtualBox>
References: <20211125140816.GC3109@xsang-OptiPlex-9020>
 <CAHk-=widXZyzRiEzmYuG-bLVtNsptxt4TqAhy75Tbio-V_9oNQ@mail.gmail.com>
 <68587446-fb74-b411-ba19-dd52395567c9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68587446-fb74-b411-ba19-dd52395567c9@huawei.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 26, 2021 at 09:54:56AM +0800, yangerkun wrote:
> Cc ntfs3:
> 
> Maybe it's a problem like this:
> 
> do_new_mount
>   fs_context_for_mount
>     alloc_fs_context
>       ntfs_init_fs_context
>         sbi = kzalloc(sizeof(struct ntfs_sb_info), GFP_NOFS);
>         fc->s_fs_info = sbi;
>   vfs_get_tree
>     ntfs_fs_get_tree
>       get_tree_bdev
>         blkdev_get_by_path  // return error and sbi->sb will be NULL
>   put_fs_context
>     ntfs_fs_free
>       put_ntfs
>         ntfs_update_mftmirr
>           struct super_block *sb = sbi->sb; // NULL
>           u32 blocksize = sb->s_blocksize; // BOOM
> 
> It's actually a ntfs3 bug which may be introduced by:
> 
> 610f8f5a7baf fs/ntfs3: Use new api for mounting

Yeap. Thank you very much. Will send patch for this in within 24h.

> On 2021/11/26 2:03, Linus Torvalds wrote:
> > On Thu, Nov 25, 2021 at 6:08 AM kernel test robot <oliver.sang@intel.com> wrote:
> > > FYI, we noticed the following commit (built with clang-14):
> > > 
> > > commit: 0858d7da8a09e440fb192a0239d20249a2d16af8 ("ramfs: fix mount source show for ramfs")
> > 
> > Funky. That commit seems to have nothing to do with the oops:
> > 
> > > [  806.257788][  T204] /dev/root: Can't open blockdev
> > > [  806.259101][  T204] general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN
> > > [  806.263082][  T204] KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> > 
> > Not a very helpful error message,a nd the KASAN comment makes little sense, but
> > 
> > > [ 806.267540][ T204] RIP: 0010:ntfs_update_mftmirr (kbuild/src/consumer/fs/ntfs3/fsntfs.c:834)
> > 
> > That's
> > 
> >          u32 blocksize = sb->s_blocksize;
> > 
> > and presumably with KASAN you end up getting hat odd 0xdffffc0000000003 thing.
> > 
> > Anyway, looks like sb is NULL, and the code is
> > 
> >    int ntfs_update_mftmirr(struct ntfs_sb_info *sbi, int wait)
> >    {
> >          int err;
> >          struct super_block *sb = sbi->sb;
> >          u32 blocksize = sb->s_blocksize;
> >          sector_t block1, block2;
> > 
> > although I have no idea how sbi->sb could be NULL.
> > 
> > Konstantin? See
> > 
> >      https://lore.kernel.org/lkml/20211125140816.GC3109@xsang-OptiPlex-9020/
> > 
> > for the full thing.
> > 
> >               Linus
> > .
> > 

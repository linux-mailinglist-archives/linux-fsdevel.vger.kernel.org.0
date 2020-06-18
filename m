Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7221FF035
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jun 2020 13:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgFRLFa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Jun 2020 07:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgFRLF2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:05:28 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F65C06174E;
        Thu, 18 Jun 2020 04:05:26 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m81so6563346ioa.1;
        Thu, 18 Jun 2020 04:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvd3pIj+tWBoeTv5FpltPgwLvfskcVybHdrc5kKxO6Y=;
        b=X8DQwMbcf5Krh9k+oLulHjiUuvnnxP2Z4E13xrA/lO3Tlh/9roxRFYolP0cY9EnFjw
         WFowAyOz9DvtNu76Pygkksd/D3PGcqVfQAZ5Ujkb0q0tLCEwvXTY2CWUEVQpTw3Dilf8
         qprA16JC2kUDs29OzvCVVHYbWK1cKgx79/vAyLv4q+Q2G/Wxcm7+8FVc5ff/Tn7oBDj/
         r1SmyITtQEvbxUlIJMuph7seUNw5TcpX6vFb8q/ZN/u7iGggXgD9uvHoTqJnO2ZIQRUu
         MhGUu4biC2V+acZsUm/b8LpsypuH9DMpISZCCE+Is3UmD0tEuMNdrd3XZEjOfqCSBdx3
         yN6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvd3pIj+tWBoeTv5FpltPgwLvfskcVybHdrc5kKxO6Y=;
        b=lpmDwYrosX+FCaR+1WXV9NKZQRqRuoYzvPbBcyaruzic/bMI7tHaD2wlFdLB1lXRMt
         j4N/xs9RpmZbDSs66MjPRyWbbZsS06IZJ+8Oeyz0hB944GFnidRhVZWG4RR5ESdUuDSu
         zdN195vpBtHFcvYUw5OJZtYD1KfYuwLmFR/AqQb+iUarDSFVbFqbxCzr9FI1EUA1A2w5
         MXPbIevUVIVqwW+SEBJM8sDvYUrl0NPtnP33RcojF6ni1oFyhXIiXVSbIpBiBOxtPGtC
         KlyEqnIse+r7vrupWXmXnX74k8D6v8OiKMDEsQYh6n0Syb0O4oboqvDRBnDK69Ow5/I2
         7BkQ==
X-Gm-Message-State: AOAM530qkDw9Vh8YaJ89VAozXgituDSkUyo/GceTs+z1PN8cD7gD6soI
        cjpPR8PJuVMfSIswudWfzq7RNjeFWwsXD+wg4HQ=
X-Google-Smtp-Source: ABdhPJxF7QN7rHiGQq2iqDeLUd0PNzN1JOcG99q/rVp9Wrjhswig4yTInE8Kk+BVnb+KWzAteZUcOup3r2agEL3iCKE=
X-Received: by 2002:a05:6638:10b:: with SMTP id x11mr3729129jao.109.1592478325264;
 Thu, 18 Jun 2020 04:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <1592222181-9832-1-git-send-email-laoar.shao@gmail.com>
 <20200616081628.GC9499@dhcp22.suse.cz> <CALOAHbDsCB1yZE6m96xiX1KiUWJW-8Hn0eqGcuEipkf9R6_L2A@mail.gmail.com>
 <20200616092727.GD9499@dhcp22.suse.cz> <CALOAHbD8x3sULHpGe=t58cBU2u1vuqrBRtAB3-+oR7TQNwOxwg@mail.gmail.com>
 <20200616104806.GE9499@dhcp22.suse.cz> <20200618003427.GZ2040@dread.disaster.area>
In-Reply-To: <20200618003427.GZ2040@dread.disaster.area>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Thu, 18 Jun 2020 19:04:49 +0800
Message-ID: <CALOAHbAtmSzyj-r3ghX311+BLmHHT-Bb0WRmzmAFRV6SuvevGw@mail.gmail.com>
Subject: Re: [PATCH v3] xfs: avoid deadlock when trigger memory reclaim in ->writepages
To:     Dave Chinner <david@fromorbit.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 18, 2020 at 8:34 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Jun 16, 2020 at 12:48:06PM +0200, Michal Hocko wrote:
> > On Tue 16-06-20 17:39:33, Yafang Shao wrote:
> > > The history is complicated, but it doesn't matter.
> > > Let's  turn back to the upstream kernel now. As I explained in the commit log,
> > > xfs_vm_writepages
> > >   -> iomap_writepages.
> > >      -> write_cache_pages
> > >         -> lock_page <<<< This page is locked.
> > >         -> writepages ( which is  iomap_do_writepage)
> > >            -> xfs_map_blocks
> > >               -> xfs_convert_blocks
> > >                  -> xfs_bmapi_convert_delalloc
> > >                     -> xfs_trans_alloc
> > >                          -> kmem_zone_zalloc //It should alloc page
> > > with GFP_NOFS
> > >
> > > If GFP_NOFS isn't set in xfs_trans_alloc(), the kmem_zone_zalloc() may
> > > trigger the memory reclaim then it may wait on the page locked in
> > > write_cache_pages() ...
> >
> > This cannot happen because the memory reclaim backs off on locked pages.
>
> ->writepages can hold a bio with multiple PageWriteback pages
> already attached to it. Direct GFP_KERNEL page reclaim can wait on
> them - if that happens the the bio will never be issued and so
> reclaim will deadlock waiting for the writeback state to clear...
>

Thanks for the explanation.

> > > That means the ->writepages should be set with GFP_NOFS to avoid this
> > > recursive filesystem reclaim.
>
> Indeed. We already have parts of the IO submission path under
> PF_MEMALLOC_NOFS so we can do transaction allocation, etc. See
> xfs_prepare_ioend(), which is called from iomap via:
>
> iomap_submit_ioend()
>   ->prepare_ioend()
>     xfs_prepare_ioend()
>
> we can get there from:
>
> iomap_writepage()
>   iomap_do_writepage()
>     iomap_writepage_map()
>       iomap_submit_ioend()
>   iomap_submit_ioend()
>
> and:
>
> iomap_writepages()
>   write_cache_pages()
>     iomap_do_writepage()
>       iomap_writepage_map()
>         iomap_submit_ioend()
>   iomap_submit_ioend()
>
> Which says that we really should be putting both iomap_writepage()
> and iomap_writepages() under PF_MEMALLOC_NOFS context so that
> filesystem callouts don't have to repeatedly enter and exit
> PF_MEMALLOC_NOFS context to avoid memory reclaim recursion...
>

Looks reasonable.
I will update this patch to put both iomap_writepage() and
iomap_writepages() under PF_MEMALLOC_NOFS context and try to remove
the usage of PF_MEMALLOC_NOFS from the filesystem callouts.


-- 
Thanks
Yafang

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF70431735
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Oct 2021 13:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhJRL1z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Oct 2021 07:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhJRL1y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:27:54 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604D1C06161C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 04:25:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 5so39169041edw.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Oct 2021 04:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gPRa+GSx7RmAe7nuMact+Hy1SGN0pX2ue9iQEqlgDeY=;
        b=iLOEQy3hLQGxuSpx8nDLpmRexerQ6wUot7MJFQnE03H2rh5fF1infChmnCYW4zcx0I
         WTcCKlIpCDRclyDGt1v5mCbcXBvJyQWVBXJk8kKtHui8qFeUVgPFtJh+avC5uKjdxbjo
         x0Nrcj6u8udBdOT6eQ1CCeyn/ybZ2M4w/zl90oUnM6dOhZIx7n1hwqzRDHwtlbdz7dKS
         e304sTRQpydN3nHa/O2YEMx4S6WoUhYD0a8vzTfbBbLgyxZ3+xFSJNyMYzL03EOolga0
         2WnV1CqhKXQGhnQ1w+hHpAXKaQ4HIiTXlHAl1l8idVBOu4+2onDrjQsx4rrTsp4D4G9W
         RK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gPRa+GSx7RmAe7nuMact+Hy1SGN0pX2ue9iQEqlgDeY=;
        b=BHM7iXGRzoiBd0oQ35y6RB1DejXe8a0Bch+knZ6IVRxiPJs2fxs3w4VEZyPp3ExQb+
         y2fPZvRXg05IzDZ+ZFA9pCgF+7gL87uYyAHwpcwOvesKKoo6FYY0mhlRE9CbvuajNjI+
         wWxnyY5hH8GRfHSu+qbk2KzI+94WfhZSnO5wAxTbKinNTFhFBLvrSOvx88uuMYGs+zow
         ZHps/bp7e+mvsPHzdiUKNfwb7OA+FJQwo4PSwtrHkTwtsRY8a5Ui3w+TuZR/LgNjZm/m
         pPzHM6lD6SolUopQEbaTKcw/76ZMjeHk2rZVmQKPJTGPrlQ+7y5PSe4yboAlws4kRjpg
         VVXA==
X-Gm-Message-State: AOAM531NvPuulzb1nlau9g5aEijgDpbMqt6/j3fUQCsq/L1sAKK/ha3S
        dLVNR41yeyhaTJgBt013BrDJ6h/4WyJk8O8zA0o+knK3Pg==
X-Google-Smtp-Source: ABdhPJwcollHeNMoxnh1JoQySifC4C4NJarUkZe1p+m8UO4YkOdccOn3r5dB3j2q2Umdp9bEkC+aSZRQrRckc/h6xoc=
X-Received: by 2002:aa7:d8c7:: with SMTP id k7mr38407934eds.85.1634556341848;
 Mon, 18 Oct 2021 04:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211011090240.97-1-xieyongji@bytedance.com> <CAJfpegvw2F_WbTAk_f92YwBn3YwqbG3Ond74DY7yvMbzeUnMKA@mail.gmail.com>
 <CACycT3sTarn8BfsGUQsrEbtWt9qeZ8Ph4O3VGpbYi7gbGKgsJA@mail.gmail.com> <CAJfpeguaRjQ9Fd1S4NHx5XVF89PGgFBxW3Xf=XNrb1QQRbDbYQ@mail.gmail.com>
In-Reply-To: <CAJfpeguaRjQ9Fd1S4NHx5XVF89PGgFBxW3Xf=XNrb1QQRbDbYQ@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 18 Oct 2021 19:25:31 +0800
Message-ID: <CACycT3s=aC6eWfo0LHMuE6sVVErjkZPScsgaBGn4QABbZE2a9g@mail.gmail.com>
Subject: Re: [RFC] fuse: Avoid invalidating attrs if writeback_cache enabled
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org,
        =?UTF-8?B?5byg5L2z6L6w?= <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 13, 2021 at 9:52 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 11 Oct 2021 at 16:45, Yongji Xie <xieyongji@bytedance.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 9:21 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Mon, 11 Oct 2021 at 11:07, Xie Yongji <xieyongji@bytedance.com> wrote:
> > > >
> > > > Recently we found the performance of small direct writes is bad
> > > > when writeback_cache enabled. This is because we need to get
> > > > attrs from userspace in fuse_update_get_attr() on each write.
> > > > The timeout for the attributes doesn't work since every direct write
> > > > will invalidate the attrs in fuse_direct_IO().
> > > >
> > > > To fix it, this patch tries to avoid invalidating attrs if writeback_cache
> > > > is enabled since we should trust local size/ctime/mtime in this case.
> > >
> > > Hi,
> > >
> > > Thanks for the patch.
> > >
> > > Just pushed an update to
> > > git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.gitt#for-next
> > > (9ca3f8697158 ("fuse: selective attribute invalidation")) that should
> > > fix this behavior.
> > >
> >
> > Looks like fuse_update_get_attr() will still get attrs from userspace
> > each time with this commit applied.
> >
> > > Could you please test?
> > >
> >
> > I applied the commit 9ca3f8697158 ("fuse: selective attribute
> > invalidation")  and tested it. But the issue still exists.
>
> Yeah, my bad.  Pushed a more complete set of fixes to #for-next ending with
>
> e15a9a5fca6c ("fuse: take cache_mask into account in getattr")
>
> You should pull or cherry pick the complete branch.
>

I tested this branch, but it still doesn't fix this issue. The
inval_mask = 0x6C0 and cache_mask = 0x2C0, so we still need to get
attrs from userspace. Should we add STATX_BLOCKS to cache_mask?

Thanks,
Yongji

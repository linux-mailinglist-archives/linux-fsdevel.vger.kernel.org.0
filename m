Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06845B5CEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Sep 2022 17:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiILPH7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Sep 2022 11:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiILPH5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:07:57 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF482252C
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 08:07:56 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id bi53so4367863vkb.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Sep 2022 08:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qsit0mYnKbhTa7KICv6S84ycyQkgfRkJRjfiZB+74yM=;
        b=PBNSrNGD/XA7/xFkHNHAFgvvDLeHp/QSiaVzgImk7A08KazUlicppkZh6tFUc9BBKi
         OfQOiVZgjDVLP6jp/rZYny7Y4/bFNUxc05k1w/69B+3UKRIoxW1RDX5fW1+sn+xwYLzY
         QQIItAYQtVCnTGLhoSMPWoV2577s4PRLVYLN+MYyq2unstTfaMlu5UkZ1TIsY/RyvX2+
         rDuLOCZ4BNLJQyiNS1fN3+4/6leqSAjY3QJPQWwacF8HZ0AtTQNyKcSob6931Jp7Ncen
         PkwSFQuT888QP1B78jEwu+sBZnncK2/NU78MZWLubRrKm8q3nkhTOy6bpk5uC/xiPwNL
         dvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qsit0mYnKbhTa7KICv6S84ycyQkgfRkJRjfiZB+74yM=;
        b=RdGE1xK2t9WnoVb4LwW7qWr6iGRUOjQskNKLzwBjW6AM/7neCF58umek9/oYCgJjWD
         G9GFtd1FUCH9Paq2nKdXNi5BHrDrflmnKjKMfGVVHFWFoMxrZwxgn7QqehwX+PY6Sp/X
         jP65RjsPx59ozRUp+RoYERw3tkELvbti0LUMLdJMIiz8SNqsyiJKHEM6DcwDdYHD1u4h
         +ts/zNzcmWbUFNuv/lrmfL8M1joINuP0uZ/lYtkfxTfOoawja03IU0NXgkZFNolAa0oM
         YxZzAg58AXH8H+hZyEUzVmuxJkMZU5s21CAWE2505kpvXVTCFPhV1y1BGfm/+pOgFaWL
         9suw==
X-Gm-Message-State: ACgBeo1Wv648VAYwpVFR1fz3cwtEtfhcpgq3pO0JYiCGyeCrCGCpgjJc
        vT24kZJQ8oI2sdN76+LZRTR+CnfbMGnSyBAWCFs=
X-Google-Smtp-Source: AA6agR4ZkWiLKdR+vc3tJJIrXY1ZLtL/I8ro4KjqAnD30XImKKYo3j7s2ULpoxVeGU3c91NvlO/ga7uNRjv2AL0tFos=
X-Received: by 2002:a1f:984a:0:b0:3a1:ccba:1d7 with SMTP id
 a71-20020a1f984a000000b003a1ccba01d7mr6463294vke.11.1662995275280; Mon, 12
 Sep 2022 08:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com>
 <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com> <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com>
 <Yx8xEhxrF5eFCwJR@redhat.com> <CAOQ4uxikeG5Ys4Hm2nr7CuJ7cDpNmOP-PRKjezi-DTwDUP42kw@mail.gmail.com>
 <Yx9DuJwWN3l5T4jL@redhat.com>
In-Reply-To: <Yx9DuJwWN3l5T4jL@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 12 Sep 2022 18:07:42 +0300
Message-ID: <CAOQ4uxhTksMqScNuRbRNNtXvs+JhTbcggPQpXfzqHJtYmTKuRA@mail.gmail.com>
Subject: Re: Persistent FUSE file handles (Was: virtiofs uuid and file handles)
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Hanna Reitz <hreitz@redhat.com>
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

On Mon, Sep 12, 2022 at 5:35 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Mon, Sep 12, 2022 at 04:38:48PM +0300, Amir Goldstein wrote:
> > On Mon, Sep 12, 2022 at 4:16 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Sun, Sep 11, 2022 at 01:14:49PM +0300, Amir Goldstein wrote:
> > > > On Wed, Sep 23, 2020 at 10:44 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > >
> > > > > One proposal was to add  LOOKUP_HANDLE operation that is similar to
> > > > > LOOKUP except it takes a {variable length handle, name} as input and
> > > > > returns a variable length handle *and* a u64 node_id that can be used
> > > > > normally for all other operations.
> > > > >
> > > > > The advantage of such a scheme for virtio-fs (and possibly other fuse
> > > > > based fs) would be that userspace need not keep a refcounted object
> > > > > around until the kernel sends a FORGET, but can prune its node ID
> > > > > based cache at any time.   If that happens and a request from the
> > > > > client (kernel) comes in with a stale node ID, the server will return
> > > > > -ESTALE and the client can ask for a new node ID with a special
> > > > > lookup_handle(fh, NULL).
> > > > >
> > > > > Disadvantages being:
> > > > >
> > > > >  - cost of generating a file handle on all lookups
> > > > >  - cost of storing file handle in kernel icache
> > > > >
> > > > > I don't think either of those are problematic in the virtiofs case.
> > > > > The cost of having to keep fds open while the client has them in its
> > > > > cache is much higher.
> > > > >
> > > >
> > > > I was thinking of taking a stab at LOOKUP_HANDLE for a generic
> > > > implementation of persistent file handles for FUSE.
> > >
> > > Hi Amir,
> > >
> > > I was going throug the proposal above for LOOKUP_HANDLE and I was
> > > wondering how nodeid reuse is handled.
> >
> > LOOKUP_HANDLE extends the 64bit node id to be variable size id.
>
> Ok. So this variable size id is basically file handle returned by
> host?
>
> So this looks little different from what Miklos had suggested. IIUC,
> he wanted LOOKUP_HANDLE to return both file handle as well as *node id*.
>
> *********************************
> One proposal was to add  LOOKUP_HANDLE operation that is similar to
> LOOKUP except it takes a {variable length handle, name} as input and
> returns a variable length handle *and* a u64 node_id that can be used
> normally for all other operations.
> ***************************************
>

Ha! Thanks for reminding me about that.
It's been a while since I looked at what actually needs to be done.
That means that evicting server inodes from cache may not be as
easy as I had imagined.

> > A server that declares support for LOOKUP_HANDLE must never
> > reuse a handle.
> >
> > That's the basic idea. Just as a filesystem that declares to support
> > exportfs must never reuse a file handle.
>
> >
> > > IOW, if server decides to drop
> > > nodeid from its cache and reuse it for some other file, how will we
> > > differentiate between two. Some sort of generation id encoded in
> > > nodeid?
> > >
> >
> > That's usually the way that file handles are implemented in
> > local fs. The inode number is the internal lookup index and the
> > generation part is advanced on reuse.
> >
> > But for passthrough fs like virtiofsd, the LOOKUP_HANDLE will
> > just use the native fs file handles, so virtiofsd can evict the inodes
> > entry from its cache completely, not only close the open fds.
>
> Ok, got it. Will be interesting to see how kernel fuse changes look
> to accomodate this variable sized nodeid.
>

It may make sense to have a FUSE protocol dialect where nodeid
is variable size for all commands, but it probably won't be part of
the initial LOOKUP_HANDLE work.

> >
> > That is what my libfuse_passthough POC does.
>
> Where have you hosted corresponding kernel changes?
>

There are no kernel changes.

For xfs and ext4 I know how to implement open_by_ino()
and I know how to parse the opaque fs file handle to extract
ino+generation from it and return them in FUSE_LOOKUP
response.

So I could manage to implement persistent NFS file handles
over the existing FUSE protocol with 64bit node id.

Thanks,
Amir.

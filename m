Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFCFF5B454B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Sep 2022 10:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiIJIw1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Sep 2022 04:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIJIw0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Sep 2022 04:52:26 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A38AE68
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Sep 2022 01:52:25 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id d126so3985446vsd.13
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Sep 2022 01:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ErhE3U2sOm3xHc5HCLKslRLOuNXOgbB13IMibUsUSWs=;
        b=YomM3B/u+iq6N1yj/0BIumrfXdfOsx+joFcmo+LANRMc1CuYAE3VOYXD+YdHQ4ZSj/
         ZrWv5WFONDjQdkKZYo+2dxcodfJe0bxMpKvJMAYmXmn6yqbseFBEaVRQvbPgG8whHmKp
         fmg8GjC0dD8M+GqIFLLRKS8T1KK6d505ZrPaoCTHtwyUjbaa3oRr7689Xq6rntcaCF6A
         nrTdGWHVYXhzGTAXRNdixFYYwXAz43rIDGdxTb85IiqhhRJ82qiDLdUqi1Ml5z4IgKSK
         RmV823LwJeiwqts+m/AReEBJfDWcNdN2iZaGQ6eE9Nkrllzt7zcS/lyQu+cGr4ZbmgCk
         FutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ErhE3U2sOm3xHc5HCLKslRLOuNXOgbB13IMibUsUSWs=;
        b=OP6x6jrdXLa0HhNXWx8YYR0PHQXHEo9WSVkDf7aeKuudCzt3ljtat7Ez7L9N68DIJ+
         qe6bX6BqpQLnEshVJKehnbo1XFojlB+UhCZpQJ3atLWFlCBYO5XLYPxZIxyrW73I9Y7z
         ljK2sHmBL5Pgd8exuIZl2wH8BRjMKru8K0dc9xVXFqhSyetB2z8GOrGuUtm/NOQtTrCp
         y4TEvj+QQ2OQfFFYVS6wz7mGODbdUDi+xYdeLXVaJ6vf1+hru1YD3qFcdRA9xn3r12iV
         ZjFs+EqEZeiACewW5l/dTY3doRS2yG3sFMaKVXMvB/nsH5WXhJmmrZWoeXtULoJ66fcN
         ZZKA==
X-Gm-Message-State: ACgBeo0RCd6AfumxTweVhyjku7tKnCboQOop9uBVPJ6qsRfivHBt4djB
        6OOffnUjwAIPAmuq7oTNdQyGyrw71+q3B/fUxoM=
X-Google-Smtp-Source: AA6agR5/At3VNSOtE86i4HJuKEhOuxzSKn6+61GGiYD7YlpbQNP4Kcg0oYXHHe19x8Dklp2/RN6G5VYfKbNBQrN4DRE=
X-Received: by 2002:a05:6102:d3:b0:398:6f6a:8850 with SMTP id
 u19-20020a05610200d300b003986f6a8850mr300797vsp.71.1662799944633; Sat, 10 Sep
 2022 01:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
 <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
 <CAJfpegtmXegm0FFxs-rs6UhJq4raktiyuzO483wRatj5HKZvYA@mail.gmail.com>
 <YD0evc676pdANlHQ@google.com> <CAOQ4uxjCT+gJVeMsnjyFZ9n6Z0+jZ6V4s_AtyPmHvBd52+zF7Q@mail.gmail.com>
 <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
In-Reply-To: <CAJfpegsKJ38rmZT=VrOYPOZt4pRdQGjCFtM-TV+TRtcKS5WSDQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 10 Sep 2022 11:52:12 +0300
Message-ID: <CAOQ4uxg-r3Fy-pmFrA0L2iUbUVcPz6YZMGrAH2LO315aE-6DzA@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for passthrough
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <bergwolf@gmail.com>,
        Akilesh Kailash <akailash@google.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
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

On Fri, Sep 9, 2022 at 10:07 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Thu, 8 Sept 2022 at 17:36, Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > Hi Alessio and Miklos,
> >
> > Some time has passed.. and I was thinking of picking up these patches.
> >
> > On Mon, Mar 1, 2021 at 7:05 PM Alessio Balsini <balsini@android.com> wrote:
> > >
> > > On Fri, Feb 19, 2021 at 09:40:21AM +0100, Miklos Szeredi wrote:
> > > > On Fri, Feb 19, 2021 at 8:05 AM Peng Tao <bergwolf@gmail.com> wrote:
> > > > >
> > > > > On Wed, Feb 17, 2021 at 9:41 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > > > What I think would be useful is to have an explicit
> > > > > > FUSE_DEV_IOC_PASSTHROUGH_CLOSE ioctl, that would need to be called
> > > > > > once the fuse server no longer needs this ID.   If this turns out to
> > > > > > be a performance problem, we could still add the auto-close behavior
> > > > > > with an explicit FOPEN_PASSTHROUGH_AUTOCLOSE flag later.
> > > > > Hi Miklos,
> > > > >
> > > > > W/o auto closing, what happens if user space daemon forgets to call
> > > > > FUSE_DEV_IOC_PASSTHROUGH_CLOSE? Do we keep the ID alive somewhere?
> > > >
> > > > Kernel would keep the ID open until explicit close or fuse connection
> > > > is released.
> > > >
> > > > There should be some limit on the max open files referenced through
> > > > ID's, though.   E.g. inherit RLIMIT_NOFILE from mounting task.
> > > >
> > > > Thanks,
> > > > Miklos
> > >
> > > I like the idea of FUSE_DEV_IOC_PASSTHROUGH_CLOSE to revoke the
> > > passthrough access, that is something I was already working on. What I
> > > had in mind was simply to break that 1:1 connection between fuse_file
> > > and lower filp setting a specific fuse_file::passthrough::filp to NULL,
> > > but this is slightly different from what you mentioned.
> > >
> >
> > I don't like the idea of switching between passthrough and server mid-life
> > of an open file.
> >
> > There are consequences related to syncing the attribute cache of the kernel
> > and the server that I don't even want to think about.
> >
> > > AFAIU you are suggesting to allocate one ID for each lower fs file
> > > opened with passthrough within a connection, and maybe using idr_find at
> > > every read/write/mmap operation to check if passthrough is enabled on
> > > that file. Something similar to fuse2_map_get().
> > > This way the fuse server can pass the same ID to one or more
> > > fuse_file(s).
> > > FUSE_DEV_IOC_PASSTHROUGH_CLOSE would idr_remove the ID, so idr_find
> > > would fail, preventing the use of passthrough on that ID. CMIIW.
> > >
> >
> > I don't think that FUSE_DEV_IOC_PASSTHROUGH_CLOSE should remove the ID.
> > We can use a refcount for the mapping and FUSE_DEV_IOC_PASSTHROUGH_CLOSE
> > just drops the initial server's refcount.
> >
> > Implementing revoke for an existing mapping is something completely different.
> > It can be done, not even so hard, but I don't think it should be part of this
> > series and in any case revoke will not remove the ID.
> >
> > > After FUSE_DEV_IOC_PASSTHROUGH_CLOSE(ID) it may happen that if some
> > > fuse_file(s) storing that ID are still open and the same ID is reclaimed
> > > in a new idr_alloc, this would lead to mismatching lower fs filp being
> > > used by our fuse_file(s).  So also the ID stored in the fuse_file(s)
> > > must be invalidated to prevent future uses of deallocated IDs.
> >
> > Obtaining a refcount on FOPEN_PASSTHROUGH will solve that.
> >
> > >
> > > Would it make sense to have a list of fuse_files using the same ID, that
> > > must be traversed at FUSE_DEV_IOC_PASSTHROUGH_CLOSE time?
> > > Negative values (maybe -ENOENT) might be used to mark IDs as invalid,
> > > and tested before idr_find at read/write/mmap to avoid the idr_find
> > > complexity in case passthrough is disabled for that file.
> > >
> > > What do you think?
> > >
> >
> > As I wrote above, this sounds unnecessarily complicated.
> >
> > Miklos,
> >
> > Do you agree with my interpretation of
> > FUSE_DEV_IOC_PASSTHROUGH_CLOSE?
>
> We need to deal with the case of too many open files.   The server
> could manage this, but then we do need to handle the case when a
> cached mapping disappears, i.e:
>
>  client opens file
>  [time passes]
>  cached passthrough fd gets evicted to make room for other passthrough I/O
>  [time passes]
>  new I/O request comes in
>  need to reestablish passthrough fd before finishing I/O
>
> The way I think of this is that a passthrough mapping is assigned at
> open time, which is cached (which may have the lifetime longer than
> the open file, but shorter as well).  When
> FUSE_DEV_IOC_PASSTHROUGH_CLOSE and there are cached mapping referring
> to this particular handle, then those mappings need to be purged.   On
> a new I/O request, the mapping will need to be reestablished by
> sending a FUSE_MAP request, which triggers
> FUSE_DEV_IOC_PASSTHROUGH_OPEN.
>

Do we really need all this complication?

I mean, if we do this then the server may end up thrashing this
passthrough cache
when the client has many open files.

I think we should accept the fact that just as any current FUSE
passthrough (in userspace) implementation is limited to max number of
open files as the server's process limitation, kernel passthrough implementation
will be limited by inheriting the mounter's process limitation.

There is no reason that the server should need to keep more
passthrough fd's open than client open fds.

If we only support FOPEN_PASSTHROUGH_AUTOCLOSE as v12
patches implicitly do, then the memory overhead is not much different
than the extra overlayfs pseudo realfiles.

So IMO, we can start with a refcounted mapping implementation
and only if there is interest in server managed mappings eviction
we could implement FUSE_DEV_IOC_PASSTHROUGH_FORGET.

> One other question that's nagging me is how to "unhide" these pseudo-fds.
>
> Could we create a kernel thread for each fuse sb which has normal
> file-table for these?  This would would allow inspecting state through
> /proc/$KTHREDID/fd, etc..
>

Yeah that sounds like a good idea.
As I mentioned elsewhere in the thread, io_uring also has a mechanism
to register open files with the kernel to perform IO on them later.
I assume those files are also visible via some /proc/$KTHREDID/fd,
but I'll need to check.

BTW, I see that the Android team is presenting eBPF-FUSE on LPC
coming Tuesday [1].

There are affordable and free options to attend virtually [2].

I wonder when patches will be available ;)

Thanks,
Amir.

[1] https://lpc.events/event/16/contributions/1339/
[2] https://lpc.events/event/16/page/181-attend

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDB1274637
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 18:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgIVQJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 12:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIVQJB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:09:01 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD73C061755;
        Tue, 22 Sep 2020 09:09:00 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t13so17803917ile.9;
        Tue, 22 Sep 2020 09:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hwXGfCymxH2zVikO+qlmm8on7Y6r8A57p3kCLV35zAM=;
        b=YMdZjI6aRmlwNHKDw6UCHWzH7x3HYoq5GQe4gFed956vb8XSraydYbPhSj0PZPAIvB
         JOUcJ1gFYB+JoQCCNrjUniwSu65qJXaKdPMUUYKgq6yOUJ3OrhKy/4hcMioiDMe7xZPn
         jm7uOnRIy0fq6LLD0tv+TMwaJ+ICs6EZc4kZiZrIbeEA6dJDpTZngxEb1QB8AF6fWnLo
         /oBNn0t3k3qa7XybnQKrLaYCQrVLOlIRya5PALNKyuaEEQ9EwOc2LkGUZv87oGcSuNYc
         TYaefZI/e+/r0bx/nWfi/Dh/4kQ51OGqBMAYYbzNn72/56U9lAvJfT6gkQYCN4TUMm4u
         uNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hwXGfCymxH2zVikO+qlmm8on7Y6r8A57p3kCLV35zAM=;
        b=YQlmyjQwnhX4ZKNWnan4oHYWViJsnoe7DTZ+Enb0dVw5vrM6ltCvYVIwXrdBRiMygZ
         o4kpp8cYLnOaPHeCxJUEAff6Bq1hwvfACOjaoxJMtqf1+MY327yiPgl/QjHqmvbaKWyc
         y5HFsgB9VGeu+MRVaCDRBADm99X9mwnnhMTR4HLNV46VvIJM1axZydRYFTtneaYt+awj
         fbzQoKeNJ94XE80C6SUONFF5VHQjdKYCJM1YUbZga5a0tmpnr7x2OU7Fu+S5OgTdXxTf
         nSFXcmEoe6o/oclwPQhVYOQEWVmd7YeEqFUzbViHwQh6nHkxUeH8LY4oy7uWvVNtW9cq
         +WRA==
X-Gm-Message-State: AOAM531Ulr7fuvGH9xX4Z9+KdT3KuCzoCJz9wfh/DKvs6z0pgzSJ8yNE
        uKj1mQer/4Ls6PHsqir/3NqMIxwxaArXVGgkv9M=
X-Google-Smtp-Source: ABdhPJwLeH3+K7rHShl3z2pHPlp6AyytciGqjpHU+JNBIrM+cMYdYDdgmZGV72mrsomKfqm095lIaxkVl+S+kQN4J7U=
X-Received: by 2002:a92:8b41:: with SMTP id i62mr5152407ild.9.1600790940086;
 Tue, 22 Sep 2020 09:09:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200911163403.79505-1-balsini@android.com> <20200911163403.79505-2-balsini@android.com>
 <CAOQ4uxiWK5dNMkrriApMVZQi6apmnMijcCw5j4fa2thHFdnFcw@mail.gmail.com>
 <20200918163354.GB3385065@google.com> <CAOQ4uxhNddkdZ5TCdg6Gdb9oYqNVUrpk25kGYxZNe-LDsZV_Ag@mail.gmail.com>
 <20200922121508.GB600068@google.com>
In-Reply-To: <20200922121508.GB600068@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 22 Sep 2020 19:08:48 +0300
Message-ID: <CAOQ4uxjFjpbVBQ6zAhtVfjB=+_T48m1c-cdA-Qr+O=2=6YmW3w@mail.gmail.com>
Subject: Re: [PATCH V8 1/3] fuse: Definitions and ioctl() for passthrough
To:     Alessio Balsini <balsini@android.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>, Jann Horn <jannh@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 22, 2020 at 3:15 PM Alessio Balsini <balsini@android.com> wrote:
>
> On Fri, Sep 18, 2020 at 10:59:16PM +0300, Amir Goldstein wrote:
> > On Fri, Sep 18, 2020 at 7:33 PM Alessio Balsini <balsini@android.com> wrote:
> > [...]
> > > > ... for example:
> > > >
> > > >        if (fs_stack_depth && passthrough_sb->s_type == fuse_fs_type) {
> > > >                pr_err("FUSE: stacked passthrough file\n");
> > > >                goto out;
> > > >        }
> > > >
> > > > But maybe we want to ban passthrough to any lower FUSE at least for start.
> > >
> > >
> > > Yes, what I proposed here is very conservative, and your solution sounds
> > > good to me. Unfortunately I don't have a clear idea of what could go wrong
> > > if we relax this constraint. I need some guidance from you experts here.
> > >
> >
> > I guess the main concern would be locking order and deadlocks.
> > With my suggestion I think deadlocks are avoided and I am less sure
> > but think that lockdep should not have false positives either.
> >
> > If people do need the 1-level stacking, I can try to think harder
> > if it is safe and maybe add some more compromise limitations.
> >
> > > What do you think if we keep this overly strict rule for now to avoid
> > > unintended behaviors and come back as we find affected use case?
> > >
> >
> > I can live with that if other designated users don't mind the limitation.
> >
> > I happen to be developing a passthrough FUSE fs [1] myself and
> > I also happen to be using it to pass through to overlayfs.
> > OTOH, the workloads for my use case are mostly large sequential IO,
> > and the hardware can handle the few extra syscalls, so the passthrough
> > fd feature is not urgent for my use case at this point in time.
>
>
> This is something that only happens if the FUSE daemon opens a connection
> wanting FUSE_PASSTHROUGH, so shouldn't affect existing use cases. Or am I
> wrong?

I meant, if I would have expected a significant performance improvement
from FUSE_PASSTHROUGH in my use case, I would have wanted to use it
and then passthrough to overlayfs would have mattered to me more.

> If some users find this limitation to be an issue, we can rethink/relax
> this policy in the future... Switching to something like the solution you
> proposed does not break the current behavior, so we would be able to change
> this with minimal effort.
>

True.

>
> >
> >
> > >
> > > >
> > > > > +       ret = -EEXIST;
> > > >
> > > > Why EEXIST? Why not EINVAL?
> > > >
> > >
> > >
> > > Reaching the stacking limit sounded like an error caused by the undesired
> > > existence of something, thus EEXIST sounded like a good fit.
> > > No problem in changing that to EINVAL.
> > >
> > >
> > >
> > > > > +       if (fs_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> > > > > +               pr_err("FUSE: maximum fs stacking depth exceeded for passthrough\n");
> > > > > +               goto out;
> > > > > +       }
> > > > > +
> > > > > +       req->args->passthrough_filp = passthrough_filp;
> > > > > +       return 0;
> > > > > +out:
> > > > > +       fput(passthrough_filp);
> > > > > +       return ret;
> > > > > +}
> > > > > +
> > > >
> > > > And speaking of overlayfs, I believe you may be able to test your code with
> > > > fuse-overlayfs (passthrough to upper files).
> > > >
> > ...
> > >
> > > This is indeed a project with several common elements to what we are doing
> > > in Android,
> >
> > Are you in liberty to share more information about the Android project?
> > Is it related to Incremental FS [2]?
> >
> > Thanks,
> > Amir.
> >
> > [1] https://github.com/amir73il/libfuse/commits/cachegwfs
> > [2] https://lore.kernel.org/linux-fsdevel/20190502040331.81196-1-ezemtsov@google.com/
>
> Thanks for the pointer to cachegwfs, I'm glad I'm seeing more and more
> passthrough file systems in addition to our use case in Android.
>

I am hearing about a lot of these projects.
I think that FUSE_PASSTHROUGH is a very useful feature.
I have an intention to explore passthrough to directory fd for
directory modifications. I sure hope you will beat me to it ;-)

> I'm not directly involved in the Incremental FS project, but, as far as I
> remember, only for the first PoC was actually developed as a FUSE file
> system. Because of the overhead introduced by the user space round-trips,
> that design was left behind and the whole Incremental FS infrastructure
> switched to becoming a kernel module.
> In general, the FUSE passthrough patch set proposed in this series wouldn't
> be helpful for that use case because, for example, Incremental FS requires
> live (de)compression of data, that can only be performed by the FUSE
> daemon.
>

Ext4 supports inline encryption. Btrfs supports encrypted/compressed extents.
No reason for FUSE not to support the same.
Is it trivial? No.
Is it an excuse for not using FUSE and writing a new userspace fs. Not
in my option.

> The specific use case I'm trying to improve with this FUSE passthrough
> series is instead related to the scoped storage feature that we introduced
> in Android 11, that is based on FUSE, and affects those folders that are
> shared among all the Apps (e.g., DCIM, Downloads, etc). More details here:
>

sdcard fs has had a lot of reincarnations :-)

I for one am happy with the return to FUSE.
Instead of saying "FUSE is too slow" and implementing a kernel sdcardfs,
improve FUSE to be faster for everyone - that's the way to go ;-)

> https://developer.android.com/about/versions/11/privacy/storage
>
> With FUSE we now have a flexible way to specify more fine-grained
> permissions (e.g., specify if an App is allowed to access files depenind on
> their type), create private App folders, maintain legacy paths for old
> Apps, manipulate pieces of files at run-time, etc. Forgive me if I forgot
> something. :)
> These extra operations may slower the file system access comprared to a
> native, direct access, but if:
> - the file being accessed requires special treatment before being passed to
>   the requesting App, then further tests will be performed at every
>   read/write operation (with some optimizations). This overhead is of
>   course annoying, but is something we are happy to pay because is
>   beneficial to the user (i.e., improves privacy and security).
> - Instead, if at open time a file is recognized as safe to access and does
>   not require any further enforcement from the FUSE daemon, there's no need
>   to pay for future read/write operations overheads, that wouldn't do
>   anything more than just copying data (possibly with the help of
>   splicing). In this case the FUSE passthrough feature proposed in this
>   series can be enabled to reduce this overhead.
>
> Moreover, some Apps use big files that contain all their resources, then
> access these files at random offsets, not taking advantage of read-ahead
> cache. The same happens for files containing databases.
> In addition, our specific use case involves a FUSE daemon is probably
> heavier than the average passthrough file system (for example those that
> are in libfuse/examples), so reducing user space round trips thanks to the
> patchset proposed here gives a strong improvement.
>
> Anyway, only showing the improvements in our extreme use case would have
> brought a limited case for upstreaming, and that is why the benchmarks I
> ran (presented in the cover letter), are based on the vanilla
> passthrough_hp daemon managing kind of standard storage workloads, and
> still show evident performance improvements.
> Running and sharing benchmarks on Android is also tricky because at the
> time of first submission the most recent public real device was running a
> 4.14 kernel, so that would have been maybe nice to see, but not that
> interesting... :)
>
> I hope I answered all your questions, please let me know if I missed
> something and feel free to ask for more details!
>

Thanks for sharing the details,
Amir.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870862741E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Sep 2020 14:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgIVMPM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Sep 2020 08:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgIVMPM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Sep 2020 08:15:12 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F47C0613CF
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 05:15:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s12so16798042wrw.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2020 05:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dDZSj0s8wHPI15fR6quH2XcNuljhPXwpn20yRRv1ACI=;
        b=R/y+q8vdCJh8dJgSf4Rp1eKqT9jsmZTwW+M32oj3kFd/ck2widQKCdzUHIBoBOivDL
         ZMGp9lxI3NqHu9RYJbst+wfs6fCbVS6bFv74oQosvQXLJM1dNnTJXVWwlVGEGVDTe+ZC
         6H6fY6j4oNpaTxeoHbUL3vBXU0EDlK2qr4xtdZ6+laR3p5WdKRHnhPo+HLl5zD1Qhdxc
         mqbpRnUcfSelq5cple7eGAnfJVYV70/vowCmA6Absgo01wMArnaF+uFTLOTvvkjBty8O
         DcfnOVECxQnlaGKcmQetuZJeAGev5eHg3xvGIr4WufvbUZ+z7KZEl/vhCPQQIQj3GHPg
         JZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dDZSj0s8wHPI15fR6quH2XcNuljhPXwpn20yRRv1ACI=;
        b=ZtEjrA+k8dM9StG/OthLyzf0pBvkqzzeXGLSzR9qnhAxilEbxU7CDpeOPLrAduue2A
         iRbtD2lsL0HQpgdkajSSykIbltMMw94YTunF+nfkUzqp3/WoAkWPEipguKMzPmgBTOD1
         nLtXepTnZhPc3h6H4RO8v2nL/5LMZ8YcxvFb+19hud5TMUud8vsgGj3tbqYJ6uMdWfnN
         JLlIqtap6sV3j32Dp5vIpRELBJzTfgrF8ASB9CqIX13ZVJZWkEH9ImxXaubIKmTcrwBv
         cmpDDR4AGSJhBw38g0Cr+CfoLc+enY6iKTXKL6zfEP+o3dlivQB9q9hMluLTtq9WVGXa
         bp/w==
X-Gm-Message-State: AOAM531KeytDMscDnPuNABPy1yLRilUKtuRlgHzdqBO4IkQATHKgjv5v
        9pKN1RR+p9rcttOMi1KhT4l6Xg==
X-Google-Smtp-Source: ABdhPJzn++K1WGPOWpia5vdh29LGBf7T2Bghey51Dyx4rDNFoAkDvmcbxObXumQ3XFeSlup//X0dPQ==
X-Received: by 2002:adf:f7ca:: with SMTP id a10mr4907738wrq.321.1600776910442;
        Tue, 22 Sep 2020 05:15:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id y5sm25895864wrh.6.2020.09.22.05.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 05:15:09 -0700 (PDT)
Date:   Tue, 22 Sep 2020 13:15:08 +0100
From:   Alessio Balsini <balsini@android.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
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
Subject: Re: [PATCH V8 1/3] fuse: Definitions and ioctl() for passthrough
Message-ID: <20200922121508.GB600068@google.com>
References: <20200911163403.79505-1-balsini@android.com>
 <20200911163403.79505-2-balsini@android.com>
 <CAOQ4uxiWK5dNMkrriApMVZQi6apmnMijcCw5j4fa2thHFdnFcw@mail.gmail.com>
 <20200918163354.GB3385065@google.com>
 <CAOQ4uxhNddkdZ5TCdg6Gdb9oYqNVUrpk25kGYxZNe-LDsZV_Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhNddkdZ5TCdg6Gdb9oYqNVUrpk25kGYxZNe-LDsZV_Ag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 18, 2020 at 10:59:16PM +0300, Amir Goldstein wrote:
> On Fri, Sep 18, 2020 at 7:33 PM Alessio Balsini <balsini@android.com> wrote:
> [...]
> > > ... for example:
> > >
> > >        if (fs_stack_depth && passthrough_sb->s_type == fuse_fs_type) {
> > >                pr_err("FUSE: stacked passthrough file\n");
> > >                goto out;
> > >        }
> > >
> > > But maybe we want to ban passthrough to any lower FUSE at least for start.
> >
> >
> > Yes, what I proposed here is very conservative, and your solution sounds
> > good to me. Unfortunately I don't have a clear idea of what could go wrong
> > if we relax this constraint. I need some guidance from you experts here.
> >
> 
> I guess the main concern would be locking order and deadlocks.
> With my suggestion I think deadlocks are avoided and I am less sure
> but think that lockdep should not have false positives either.
> 
> If people do need the 1-level stacking, I can try to think harder
> if it is safe and maybe add some more compromise limitations.
> 
> > What do you think if we keep this overly strict rule for now to avoid
> > unintended behaviors and come back as we find affected use case?
> >
> 
> I can live with that if other designated users don't mind the limitation.
> 
> I happen to be developing a passthrough FUSE fs [1] myself and
> I also happen to be using it to pass through to overlayfs.
> OTOH, the workloads for my use case are mostly large sequential IO,
> and the hardware can handle the few extra syscalls, so the passthrough
> fd feature is not urgent for my use case at this point in time.


This is something that only happens if the FUSE daemon opens a connection
wanting FUSE_PASSTHROUGH, so shouldn't affect existing use cases. Or am I
wrong?
If some users find this limitation to be an issue, we can rethink/relax
this policy in the future... Switching to something like the solution you
proposed does not break the current behavior, so we would be able to change
this with minimal effort.


> 
> 
> >
> > >
> > > > +       ret = -EEXIST;
> > >
> > > Why EEXIST? Why not EINVAL?
> > >
> >
> >
> > Reaching the stacking limit sounded like an error caused by the undesired
> > existence of something, thus EEXIST sounded like a good fit.
> > No problem in changing that to EINVAL.
> >
> >
> >
> > > > +       if (fs_stack_depth > FILESYSTEM_MAX_STACK_DEPTH) {
> > > > +               pr_err("FUSE: maximum fs stacking depth exceeded for passthrough\n");
> > > > +               goto out;
> > > > +       }
> > > > +
> > > > +       req->args->passthrough_filp = passthrough_filp;
> > > > +       return 0;
> > > > +out:
> > > > +       fput(passthrough_filp);
> > > > +       return ret;
> > > > +}
> > > > +
> > >
> > > And speaking of overlayfs, I believe you may be able to test your code with
> > > fuse-overlayfs (passthrough to upper files).
> > >
> ...
> >
> > This is indeed a project with several common elements to what we are doing
> > in Android,
> 
> Are you in liberty to share more information about the Android project?
> Is it related to Incremental FS [2]?
> 
> Thanks,
> Amir.
> 
> [1] https://github.com/amir73il/libfuse/commits/cachegwfs
> [2] https://lore.kernel.org/linux-fsdevel/20190502040331.81196-1-ezemtsov@google.com/

Thanks for the pointer to cachegwfs, I'm glad I'm seeing more and more
passthrough file systems in addition to our use case in Android.

I'm not directly involved in the Incremental FS project, but, as far as I
remember, only for the first PoC was actually developed as a FUSE file
system. Because of the overhead introduced by the user space round-trips,
that design was left behind and the whole Incremental FS infrastructure
switched to becoming a kernel module.
In general, the FUSE passthrough patch set proposed in this series wouldn't
be helpful for that use case because, for example, Incremental FS requires
live (de)compression of data, that can only be performed by the FUSE
daemon.

The specific use case I'm trying to improve with this FUSE passthrough
series is instead related to the scoped storage feature that we introduced
in Android 11, that is based on FUSE, and affects those folders that are
shared among all the Apps (e.g., DCIM, Downloads, etc). More details here:

https://developer.android.com/about/versions/11/privacy/storage

With FUSE we now have a flexible way to specify more fine-grained
permissions (e.g., specify if an App is allowed to access files depenind on
their type), create private App folders, maintain legacy paths for old
Apps, manipulate pieces of files at run-time, etc. Forgive me if I forgot
something. :)
These extra operations may slower the file system access comprared to a
native, direct access, but if:
- the file being accessed requires special treatment before being passed to
  the requesting App, then further tests will be performed at every
  read/write operation (with some optimizations). This overhead is of
  course annoying, but is something we are happy to pay because is
  beneficial to the user (i.e., improves privacy and security).
- Instead, if at open time a file is recognized as safe to access and does
  not require any further enforcement from the FUSE daemon, there's no need
  to pay for future read/write operations overheads, that wouldn't do
  anything more than just copying data (possibly with the help of
  splicing). In this case the FUSE passthrough feature proposed in this
  series can be enabled to reduce this overhead.

Moreover, some Apps use big files that contain all their resources, then
access these files at random offsets, not taking advantage of read-ahead
cache. The same happens for files containing databases.
In addition, our specific use case involves a FUSE daemon is probably
heavier than the average passthrough file system (for example those that
are in libfuse/examples), so reducing user space round trips thanks to the
patchset proposed here gives a strong improvement.

Anyway, only showing the improvements in our extreme use case would have
brought a limited case for upstreaming, and that is why the benchmarks I
ran (presented in the cover letter), are based on the vanilla
passthrough_hp daemon managing kind of standard storage workloads, and
still show evident performance improvements.
Running and sharing benchmarks on Android is also tricky because at the
time of first submission the most recent public real device was running a
4.14 kernel, so that would have been maybe nice to see, but not that
interesting... :)

I hope I answered all your questions, please let me know if I missed
something and feel free to ask for more details!

Thanks again,
Alessio

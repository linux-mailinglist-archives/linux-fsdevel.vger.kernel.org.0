Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1242C82DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 12:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgK3LJX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 06:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727663AbgK3LJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:09:23 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74B1C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 03:08:42 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id o1so1650967wrx.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 03:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g+4njBXcirHJCL3DQ1RFf48zRCHizeggk1XBMK3pkS8=;
        b=TyPUISpItLAjJvF4hDb3xsrJ8mSrb+Sj3mga2hq5CcAUvvLxir1/oOAy6C8BGWqvM5
         gxUcNtLaZjKyBeAwJ5nCj3ESdfdcw9ZDHeT0ZTl9a1xp4adLRDinGVAQqcS12nmJ6eLL
         y0HOFmO9bd2GopLWU+BihcpjTiJznXAIBYKbe09Wbx9ua7WKLRIOxyJ5fht2DC3YhZFH
         oXbRH5KHclfGczRK7ir+nw23Aa+3gnFeJ8Gh8S2p+aZnosEew6N2g3ubYZ6Jiqa1qQvc
         RhXPXrmpQzvhLQ6Wh+2fAzGOt16H9Ti7yFc//MMm1Kg5Vq8R0bM4fqWB/aHE9PyEBHya
         k8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g+4njBXcirHJCL3DQ1RFf48zRCHizeggk1XBMK3pkS8=;
        b=eNnBWxj3BEC9ZNlAYTlTE3jW7ov92F+4ae+F2NyaJBDbVFV7D2SjG3EEAJcF0eWnZe
         mw6pvlzY0zj5vhOo0nRDCPyswBmJaPoIVecjvrsbDIpTNMfaaFG36OeQVdBZssQj3CsH
         kix82hdAo/WoAPGhDLnj/ubu1D3ltKDTDd6+qw3cTZNbUVjSFu5ErNDBAxkLDHR01jDI
         BatYolwoJ6w1sPcOxJTKhvAcvgh9C1Ux88s0cfEb+79HKUbf0hRQoNdeigw2io27U2iD
         W7d91IMxGGdBSsIKt8F0sJZS6JoJYyh0jovYuWPbr6SOx31sAFNBJRsNQj1z9hRtmoiT
         DP3w==
X-Gm-Message-State: AOAM5325j3pLe6u8tICkIaYRawdTT6rTn0i3o9cORmXpBaSADfp+IYW3
        /iaKSJOKlL9m8lTnmrUZNQReig==
X-Google-Smtp-Source: ABdhPJz2YTkLjLzzlKHQpVJhkrmkflLI0peqopogShKZB+g+T1ZFnYUgX2B5fapJzhBhWzarPGepFg==
X-Received: by 2002:a5d:49ce:: with SMTP id t14mr27651862wrs.75.1606734521373;
        Mon, 30 Nov 2020 03:08:41 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id s4sm6270738wra.91.2020.11.30.03.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 03:08:40 -0800 (PST)
Date:   Mon, 30 Nov 2020 11:08:39 +0000
From:   Alessio Balsini <balsini@android.com>
To:     Peng Tao <bergwolf@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V10 0/5] fuse: Add support for passthrough read/write
Message-ID: <20201130110839.GA1980518@google.com>
References: <20201026125016.1905945-1-balsini@android.com>
 <CA+a=Yy76W4Xob6UVXsPLA_FKF_8+QFQSEF98yALjRmuOhnVOdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+a=Yy76W4Xob6UVXsPLA_FKF_8+QFQSEF98yALjRmuOhnVOdw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Nov 28, 2020 at 10:10:37AM +0800, Peng Tao wrote:
> On Tue, Oct 27, 2020 at 1:00 AM Alessio Balsini <balsini@android.com> wrote:
> >
> > This is the 10th version of the series. Please find the changelog at the
> > bottom of this cover letter.
> >
> > Add support for file system passthrough read/write of files when enabled in
> > userspace through the option FUSE_PASSTHROUGH.
> >
> > There are file systems based on FUSE that are intended to enforce special
> > policies or trigger complicated decision makings at the file operations
> > level. Android, for example, uses FUSE to enforce fine-grained access
> > policies that also depend on the file contents.
> > Sometimes it happens that at open or create time a file is identified as
> > not requiring additional checks for consequent reads/writes, thus FUSE
> > would simply act as a passive bridge between the process accessing the FUSE
> > file system and the lower file system. Splicing and caching help reduce the
> > FUSE overhead, but there are still read/write operations forwarded to the
> > userspace FUSE daemon that could be avoided.
> >
> > This series has been inspired by the original patches from Nikhilesh Reddy,
> > the idea and code of which has been elaborated and improved thanks to the
> > community support.
> >
> > When the FUSE_PASSTHROUGH capability is enabled, the FUSE daemon may decide
> > while handling the open/create operations, if the given file can be
> > accessed in passthrough mode. This means that all the further read and
> > write operations would be forwarded by the kernel directly to the lower
> > file system using the VFS layer rather than to the FUSE daemon.
> > All the requests other than reads or writes are still handled by the
> > userspace FUSE daemon.
> > This allows for improved performance on reads and writes, especially in the
> > case of reads at random offsets, for which no (readahead) caching mechanism
> > would help.
> > Benchmarks show improved performance that is close to native file system
> > access when doing massive manipulations on a single opened file, especially
> > in the case of random reads, for which the bandwidth increased by almost 2X
> > or sequential writes for which the improvement is close to 3X.
> >
> > The creation of this direct connection (passthrough) between FUSE file
> > objects and file objects in the lower file system happens in a way that
> > reminds of passing file descriptors via sockets:
> > - a process requests the opening of a file handled by FUSE, so the kernel
> >   forwards the request to the FUSE daemon;
> > - the FUSE daemon opens the target file in the lower file system, getting
> >   its file descriptor;
> > - the FUSE daemon also decides according to its internal policies if
> >   passthrough can be enabled for that file, and, if so, can perform a
> >   FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl() on /dev/fuse, passing the file
> >   descriptor obtained at the previous step and the fuse_req unique
> >   identifier;
> > - the kernel translates the file descriptor to the file pointer navigating
> >   through the opened files of the "current" process and temporarily stores
> >   it in the associated open/create fuse_req's passthrough_filp;
> > - when the FUSE daemon has done with the request and it's time for the
> >   kernel to close it, it checks if the passthrough_filp is available and in
> >   case updates the additional field in the fuse_file owned by the process
> >   accessing the FUSE file system.
> > From now on, all the read/write operations performed by that process will
> > be redirected to the corresponding lower file system file by creating new
> > VFS requests.
> > Since the read/write operation to the lower file system is executed with
> > the current process's credentials, it might happen that it does not have
> > enough privileges to succeed. For this reason, the process temporarily
> > receives the same credentials as the FUSE daemon, that are reverted as soon
> > as the read/write operation completes, emulating the behavior of the
> > request to be performed by the FUSE daemon itself. This solution has been
> > inspired by the way overlayfs handles read/write operations.
> > Asynchronous IO is supported as well, handled by creating separate AIO
> > requests for the lower file system that will be internally tracked by FUSE,
> > that intercepts and propagates their completion through an internal
> > ki_completed callback similar to the current implementation of overlayfs.
> > The ioctl() has been designed taking as a reference and trying to converge
> > to the fuse2 implementation. For example, the fuse_passthrough_out data
> > structure has extra fields that will allow for further extensions of the
> > feature.
> >
> >
> >     Performance on SSD
> >
> > What follows has been performed with this change [V6] rebased on top of
> > vanilla v5.8 Linux kernel, using a custom passthrough_hp FUSE daemon that
> > enables pass-through for each file that is opened during both "open" and
> > "create". Tests were run on an Intel Xeon E5-2678V3, 32GiB of RAM, with an
> > ext4-formatted SSD as the lower file system, with no special tuning, e.g.,
> > all the involved processes are SCHED_OTHER, ondemand is the frequency
> > governor with no frequency restrictions, and turbo-boost, as well as
> > p-state, are active. This is because I noticed that, for such high-level
> > benchmarks, results consistency was minimally affected by these features.
> > The source code of the updated libfuse library and passthrough_hp is shared
> > at the following repository:
> >
> >     https://github.com/balsini/libfuse/tree/fuse-passthrough-stable-v.3.9.4
> The libfuse changes are not updated with the latest ioctl UAPI change yet.
> 
> > * UAPI updated: ioctl() now returns an ID that will be used at
> >   open/create response time to reference the passthrough file
> 
> Cheers,
> Tao
> -- 
> Into Sth. Rich & Strange

Hi Tao,

You are right, sorry, this is the correct branch that uses the
FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl with the current patch set:

  https://github.com/balsini/libfuse/tree/fuse-passthrough-v10-linux-5.8-v.3.9.4

I think I'll stick to this libfuse branch naming pattern from now on. :)

Thanks,
Alessio

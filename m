Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4B02C6E62
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Nov 2020 03:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732128AbgK1CMh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Nov 2020 21:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgK1CKt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Nov 2020 21:10:49 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EC7C0613D1;
        Fri, 27 Nov 2020 18:10:48 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id e8so5986659pfh.2;
        Fri, 27 Nov 2020 18:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7FacVR3V/WCEQ1CgCqyN6BOceGSQR7vhqJHiXGCEHWI=;
        b=PViRMpuuI4eSXEfb51qD0D+pcYok8I/rhmStXFBTFj3IPF6V/SEoRXQv/TBup1azDC
         hjHyNx2mApNmhLCf9Zyz95b6hiJYJGPjTJxKWjHBV0FrkhCSRKfUOLqV1605foMyGhaL
         3kqCzZrB4I05I5JRfvEh3ci+GEIC/gM6KW/VhCi+cpn0oTFhGM4+C58/w06d4tBKFQnv
         TAWroBz+1qLFoLIuj4DqzEmKTFdDLOe2sad/9hav4SQDjKZXqsmDrxu9/lxhK9oSMtDr
         8M8m7zu1dYHTGZFlo8e/FXG+aWvfmtIojHDJv/r7e5z+Rh3RwjBjiLJMWei0FoJ4CPut
         OytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7FacVR3V/WCEQ1CgCqyN6BOceGSQR7vhqJHiXGCEHWI=;
        b=FdU1Ua1u97h1DtGHoZZd+NPEE4rD12xbrej3czAtEE0UlHTEBp/TJtqP6mG/de4W8Q
         qvQSjKTuBgFgzBsHP6GmAspgtsySABN0dg5K80DkZngA2SmsQ/ZSlTIR0E70Lcse//IE
         71MVrRN/mRe/DIWasiwqMW1XHlFgaDQlYRcxDi6lUBTche+DYy86QPIRmij5z+VYMjdV
         0GflECnzkFYmiA5GZIy4LIZPpPiF05+9uh6q78S5Cbe4rz/LLNYhYZhh493KaRghVuNE
         UQ87iDnWpSZfsVrGxFVfDEO1f5mTioPB3B2xvefpW9eJEVpPFiMb37vrHBIsZBq0TCSr
         bd5g==
X-Gm-Message-State: AOAM531x0gS/My+fwhZ7MwmMG76eneok3Wup+Ji3tXK0mGmPLlMffokW
        tDAYRgJKsZC1i3Fh9ZRSO2KFgUv1trxSx33gd7M=
X-Google-Smtp-Source: ABdhPJwJzWeiq3C0co0/Pz4JEuuWQjID47IeRj592IOrxEVg6lIroPDYvpR9G1i2693CxUvn4SeCeqwdNUJi9gJ1RlE=
X-Received: by 2002:a17:90a:5d8c:: with SMTP id t12mr13721302pji.156.1606529448409;
 Fri, 27 Nov 2020 18:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20201026125016.1905945-1-balsini@android.com>
In-Reply-To: <20201026125016.1905945-1-balsini@android.com>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Sat, 28 Nov 2020 10:10:37 +0800
Message-ID: <CA+a=Yy76W4Xob6UVXsPLA_FKF_8+QFQSEF98yALjRmuOhnVOdw@mail.gmail.com>
Subject: Re: [PATCH V10 0/5] fuse: Add support for passthrough read/write
To:     Alessio Balsini <balsini@android.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 1:00 AM Alessio Balsini <balsini@android.com> wrote:
>
> This is the 10th version of the series. Please find the changelog at the
> bottom of this cover letter.
>
> Add support for file system passthrough read/write of files when enabled in
> userspace through the option FUSE_PASSTHROUGH.
>
> There are file systems based on FUSE that are intended to enforce special
> policies or trigger complicated decision makings at the file operations
> level. Android, for example, uses FUSE to enforce fine-grained access
> policies that also depend on the file contents.
> Sometimes it happens that at open or create time a file is identified as
> not requiring additional checks for consequent reads/writes, thus FUSE
> would simply act as a passive bridge between the process accessing the FUSE
> file system and the lower file system. Splicing and caching help reduce the
> FUSE overhead, but there are still read/write operations forwarded to the
> userspace FUSE daemon that could be avoided.
>
> This series has been inspired by the original patches from Nikhilesh Reddy,
> the idea and code of which has been elaborated and improved thanks to the
> community support.
>
> When the FUSE_PASSTHROUGH capability is enabled, the FUSE daemon may decide
> while handling the open/create operations, if the given file can be
> accessed in passthrough mode. This means that all the further read and
> write operations would be forwarded by the kernel directly to the lower
> file system using the VFS layer rather than to the FUSE daemon.
> All the requests other than reads or writes are still handled by the
> userspace FUSE daemon.
> This allows for improved performance on reads and writes, especially in the
> case of reads at random offsets, for which no (readahead) caching mechanism
> would help.
> Benchmarks show improved performance that is close to native file system
> access when doing massive manipulations on a single opened file, especially
> in the case of random reads, for which the bandwidth increased by almost 2X
> or sequential writes for which the improvement is close to 3X.
>
> The creation of this direct connection (passthrough) between FUSE file
> objects and file objects in the lower file system happens in a way that
> reminds of passing file descriptors via sockets:
> - a process requests the opening of a file handled by FUSE, so the kernel
>   forwards the request to the FUSE daemon;
> - the FUSE daemon opens the target file in the lower file system, getting
>   its file descriptor;
> - the FUSE daemon also decides according to its internal policies if
>   passthrough can be enabled for that file, and, if so, can perform a
>   FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl() on /dev/fuse, passing the file
>   descriptor obtained at the previous step and the fuse_req unique
>   identifier;
> - the kernel translates the file descriptor to the file pointer navigating
>   through the opened files of the "current" process and temporarily stores
>   it in the associated open/create fuse_req's passthrough_filp;
> - when the FUSE daemon has done with the request and it's time for the
>   kernel to close it, it checks if the passthrough_filp is available and in
>   case updates the additional field in the fuse_file owned by the process
>   accessing the FUSE file system.
> From now on, all the read/write operations performed by that process will
> be redirected to the corresponding lower file system file by creating new
> VFS requests.
> Since the read/write operation to the lower file system is executed with
> the current process's credentials, it might happen that it does not have
> enough privileges to succeed. For this reason, the process temporarily
> receives the same credentials as the FUSE daemon, that are reverted as soon
> as the read/write operation completes, emulating the behavior of the
> request to be performed by the FUSE daemon itself. This solution has been
> inspired by the way overlayfs handles read/write operations.
> Asynchronous IO is supported as well, handled by creating separate AIO
> requests for the lower file system that will be internally tracked by FUSE,
> that intercepts and propagates their completion through an internal
> ki_completed callback similar to the current implementation of overlayfs.
> The ioctl() has been designed taking as a reference and trying to converge
> to the fuse2 implementation. For example, the fuse_passthrough_out data
> structure has extra fields that will allow for further extensions of the
> feature.
>
>
>     Performance on SSD
>
> What follows has been performed with this change [V6] rebased on top of
> vanilla v5.8 Linux kernel, using a custom passthrough_hp FUSE daemon that
> enables pass-through for each file that is opened during both "open" and
> "create". Tests were run on an Intel Xeon E5-2678V3, 32GiB of RAM, with an
> ext4-formatted SSD as the lower file system, with no special tuning, e.g.,
> all the involved processes are SCHED_OTHER, ondemand is the frequency
> governor with no frequency restrictions, and turbo-boost, as well as
> p-state, are active. This is because I noticed that, for such high-level
> benchmarks, results consistency was minimally affected by these features.
> The source code of the updated libfuse library and passthrough_hp is shared
> at the following repository:
>
>     https://github.com/balsini/libfuse/tree/fuse-passthrough-stable-v.3.9.4
The libfuse changes are not updated with the latest ioctl UAPI change yet.

> * UAPI updated: ioctl() now returns an ID that will be used at
>   open/create response time to reference the passthrough file

Cheers,
Tao
-- 
Into Sth. Rich & Strange

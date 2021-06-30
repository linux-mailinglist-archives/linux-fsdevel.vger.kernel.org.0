Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B223B8678
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 17:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbhF3PtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 11:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235743AbhF3PtD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 11:49:03 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532C6C061756;
        Wed, 30 Jun 2021 08:46:34 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y76so3695593iof.6;
        Wed, 30 Jun 2021 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DQtlKoCc9YSJGpDWgsPOEOvlsOxc9jffBtGa2EcQTms=;
        b=JgoTCEZWNGvGo04wuKHdsw577/uZhlfIg47P9qxRFAN/TEZrJN+qGEGgb5UqA16ZPn
         MJHuYmYcx1QBCVXDfOdvj2QgZAlXzrauFy/SrjnymV875+WY1YYgfZq7qBbVOeqPI7qh
         lCokm0VKF1EXhTLBg7PIwvtvE//akoKu/P0q+jag4awhxAOqIfDU8TRp2lQrg4o8FQMP
         VySH+WQ1WVX3C2DwBoUH1aP5F90OnsDek86EibqpYV/c2xQqASWjtRkN84U3GaHT6MXG
         ScgwTFK89o7YJU8LfgqpqzupjOj0J0kbbXAcUE5BK6d2a9bHM2DTw71Iw5M7LO2QKsr7
         7KcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DQtlKoCc9YSJGpDWgsPOEOvlsOxc9jffBtGa2EcQTms=;
        b=T/iqlBQTFKhdWOYYwH6sjJdX7myYucXX1a5vRPeomwMQ53ArzIsUDJP93ZXqp7kMOl
         ygAhNXRvv6zm1jXbbRSwIuxVjmHp7m1Hcezvs3sejPkvW08u25i0sfJ/JxY1qjqtvMGs
         aT96qDxBjHZwrQ6pqP59BQlH+VpKlMkOr8gw/8WyHMUD0HCqqe7ropcbuNkqRlM48nGH
         ZqjxTNclH2tkPmTKHlAa53ewvambpuqxKemkGXiJEVkIrvjNgP2PPC1/KvJmL1kXYb4o
         k8Id0Sr3v16n/k5asgJX0VqB2aAyVcF9J23agKODJ8dsMkuj8FGX5sPpVGZMIuzhIcG0
         xR+A==
X-Gm-Message-State: AOAM531x7eF+Qu24kC5NMvFEabCsj2/aAi7FnhTwxw9/jnc825e3xHBJ
        ecbXOUe7ZU87TlMZ8rh6AG7pqLBZpxymdCL031A=
X-Google-Smtp-Source: ABdhPJysHxvk5qcwQJzY0bzYS66Eb29ROJRKzIhokSPLXEzgIfWYaxQBcpUsM/8d0yAuz0Hv4fIryDGRbJaY6fUNcrA=
X-Received: by 2002:a02:908a:: with SMTP id x10mr9258682jaf.30.1625067993559;
 Wed, 30 Jun 2021 08:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210513135644.GE20142@xsang-OptiPlex-9020> <877dk1zibo.fsf@suse.de>
In-Reply-To: <877dk1zibo.fsf@suse.de>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 18:46:22 +0300
Message-ID: <CAOQ4uxgde72YDADffihj1P-Kse_P6zkhrjBb1DhwVUC+yRJooQ@mail.gmail.com>
Subject: Re: [vfs] 94a4dd06a6: xfstests.generic.263.fail
To:     Luis Henriques <lhenriques@suse.de>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Olga Kornievskaia <aglo@umich.edu>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 2:03 PM Luis Henriques <lhenriques@suse.de> wrote:
>
> kernel test robot <oliver.sang@intel.com> writes:
>
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-9):
> >
> > commit: 94a4dd06a6bbf3978b0bb1dddc2d8ec4e5bcad26 ("[PATCH v9] vfs: fix =
copy_file_range regression in cross-fs copies")
> > url: https://github.com/0day-ci/linux/commits/Luis-Henriques/vfs-fix-co=
py_file_range-regression-in-cross-fs-copies/20210510-170804
> > base: https://git.kernel.org/cgit/linux/kernel/git/viro/vfs.git for-nex=
t
> >
> > in testcase: xfstests
> > version: xfstests-x86_64-73c0871-1_20210401
> > with following parameters:
> >
> >       disk: 4HDD
> >       fs: xfs
> >       test: generic-group-13
> >       ucode: 0x21
> >
> > test-description: xfstests is a regression test suite for xfs and other=
 files ystems.
> > test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> >
> >
> > on test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.=
30GHz with 8G memory
> >
> > caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
> >
> >
> >
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> >
> > 2021-05-11 11:28:23 export TEST_DIR=3D/fs/sda1
> > 2021-05-11 11:28:23 export TEST_DEV=3D/dev/sda1
> > 2021-05-11 11:28:23 export FSTYP=3Dxfs
> > 2021-05-11 11:28:23 export SCRATCH_MNT=3D/fs/scratch
> > 2021-05-11 11:28:23 mkdir /fs/scratch -p
> > 2021-05-11 11:28:23 export SCRATCH_DEV=3D/dev/sda4
> > 2021-05-11 11:28:23 export SCRATCH_LOGDEV=3D/dev/sda2
> > 2021-05-11 11:28:23 sed "s:^:generic/:" //lkp/benchmarks/xfstests/tests=
/generic-group-13
> > 2021-05-11 11:28:23 ./check generic/260 generic/261 generic/262 generic=
/263 generic/264 generic/265 generic/266 generic/267 generic/268 generic/26=
9 generic/270 generic/271 generic/272 generic/273 generic/274 generic/275 g=
eneric/276 generic/277 generic/278 generic/279
> > FSTYP         -- xfs (debug)
> > PLATFORM      -- Linux/x86_64 lkp-ivb-d02 5.12.0-rc6-00061-g94a4dd06a6b=
b #1 SMP Tue May 11 00:58:17 CST 2021
> > MKFS_OPTIONS  -- -f -bsize=3D4096 /dev/sda4
> > MOUNT_OPTIONS -- /dev/sda4 /fs/scratch
> >
> > generic/260   [not run] FITRIM not supported on /fs/scratch
> > generic/261   [not run] Reflink not supported by scratch filesystem typ=
e: xfs
> > generic/262   [not run] Reflink not supported by scratch filesystem typ=
e: xfs
> > generic/263   [failed, exit status 1]- output mismatch (see /lkp/benchm=
arks/xfstests/results//generic/263.out.bad)
> >     --- tests/generic/263.out 2021-04-01 03:07:08.000000000 +0000
> >     +++ /lkp/benchmarks/xfstests/results//generic/263.out.bad 2021-05-1=
1 11:28:29.773460096 +0000
> >     @@ -1,3 +1,32 @@
> >      QA output created by 263
> >      fsx -N 10000 -o 8192 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
> >     -fsx -N 10000 -o 128000 -l 500000 -r PSIZE -t BSIZE -w BSIZE -Z
> >     +Seed set to 1
> >     +main: filesystem does not support clone range, disabling!
> >     +main: filesystem does not support dedupe range, disabling!
> >     +skipping zero size read
> >     ...
> >     (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/263.out /lkp/b=
enchmarks/xfstests/results//generic/263.out.bad'  to see the entire diff)
> > generic/264   [not run] Reflink not supported by scratch filesystem typ=
e: xfs
> > generic/265   [not run] Reflink not supported by scratch filesystem typ=
e: xfs
> > generic/266   [not run] Reflink not supported by scratch filesystem typ=
e: xfs
> > generic/267   [not run] Reflink not supported by scratch filesystem typ=
e: xfs
> > generic/268   [not run] Reflink not supported by scratch filesystem typ=
e: xfs
> > generic/269    48s
> > generic/270    61s
> > generic/271   [not run] Reflink not supported by scratch filesystem typ=
e: xfs
> > generic/272   [not run] Reflink not supported by scratch filesystem typ=
e: xfs
> > generic/273    17s
> > generic/274    14s
> > generic/275    11s
> > generic/276   [not run] Reflink not supported by scratch filesystem typ=
e: xfs
> > generic/277    3s
> > generic/278   [not run] Reflink not supported by scratch filesystem typ=
e: xfs
> > generic/279   [not run] Reflink not supported by scratch filesystem typ=
e: xfs
> > Ran: generic/260 generic/261 generic/262 generic/263 generic/264 generi=
c/265 generic/266 generic/267 generic/268 generic/269 generic/270 generic/2=
71 generic/272 generic/273 generic/274 generic/275 generic/276 generic/277 =
generic/278 generic/279
> > Not run: generic/260 generic/261 generic/262 generic/264 generic/265 ge=
neric/266 generic/267 generic/268 generic/271 generic/272 generic/276 gener=
ic/278 generic/279
> > Failures: generic/263
> > Failed 1 of 20 tests
>
> OK, I see what's going on.  There are 2 issues: one with patch and anothe=
r
> one with the test itself.
>
> The CFR syscall should have been disabled in this test but it isn't
> because the test tries to copy 1 byte from a zero-sized file:
>
> int
> test_copy_range(void)
> {
>         loff_t o1 =3D 0, o2 =3D 1;
>
>         if (syscall(__NR_copy_file_range, fd, &o1, fd, &o2, 1, 0) =3D=3D =
-1 &&
>             (errno =3D=3D ENOSYS || errno =3D=3D EOPNOTSUPP || errno =3D=
=3D ENOTTY)) {
>                 if (!quiet)
>                         fprintf(stderr,
>                                 "main: filesystem does not support "
>                                 "copy range, disabling!\n");
>                 return 0;
>         }
>
>         return 1;
> }
>
> The syscall is doing an early '0' return because the file size is < len.
>
> Fixing the kernel should probably be as easy as removing the
> short-circuiting check in vfs_copy_file_range():
>
>         if (len =3D=3D 0)
>                 return 0;
>
> This will force the filesystems code to handle '0' size copies but will
> also make sure -EOPNOTSUPP is returned in this case.
>

Sorry for the late reply.
The solution above is correct.
That is aligned with the behavior of vfs_clone_file_range().
Need to call into the filesystem method also with 0 length
in order to learn about CFR support of this filesystem instance.

> Alternatively, we could have something like:
>
>         if (len =3D=3D 0) {
>                 if (file_out->f_op->copy_file_range)
>                         return 0;
>                 else
>                         return -EOPNOTSUPP;
>         }
>

This does not catch the case of a filesystem driver that has
CFR method but a filesystem instance does not support CFR.
For example, overlayfs with ext4 as upper fs.

> What do you guys think is the right thing to do?
>
> Additionally, the test should also be fixed with something as the patch
> bellow.  By making sure we have 1 byte to copy we also ensure the syscall
> will return -EOPNOTSUPP, even with the current version of the patch.
>

I don't think that the test should be fixed.

Thanks,
Amir.

> Cheers,
> --
> Luis
>
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index cd0bae55aeb8..97db594ae142 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1596,6 +1596,10 @@ int
>  test_copy_range(void)
>  {
>         loff_t o1 =3D 0, o2 =3D 1;
> +       int ret =3D 1;
> +
> +       /* Make sure we have 1 byte to copy */
> +       ftruncate(fd, 1);
>
>         if (syscall(__NR_copy_file_range, fd, &o1, fd, &o2, 1, 0) =3D=3D =
-1 &&
>             (errno =3D=3D ENOSYS || errno =3D=3D EOPNOTSUPP || errno =3D=
=3D ENOTTY)) {
> @@ -1603,10 +1607,13 @@ test_copy_range(void)
>                         fprintf(stderr,
>                                 "main: filesystem does not support "
>                                 "copy range, disabling!\n");
> -               return 0;
> +               ret =3D 0;
>         }
>
> -       return 1;
> +       /* Restore file size */
> +       ftruncate(fd, 0);
> +
> +       return ret;
>  }
>
>  void

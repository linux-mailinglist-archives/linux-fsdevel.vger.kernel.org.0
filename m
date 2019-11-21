Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F871059EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2019 19:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfKUStH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 13:49:07 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46582 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKUStH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:49:07 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so4631037iol.13;
        Thu, 21 Nov 2019 10:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K1u7X0Gy/yHf/V/sx8Gua1oticYhDDZwganOyh5Ba4k=;
        b=PTq0Ry8C5f5cJT/UP9S+s6swbW3MN1ARuASq3rjKVqAkCfrdcbj/+8tE2vsl1noKxu
         BRUrJEsx71pmPjpEl9tSS9RAfNueoHzkMpIy4rCxkv1yl3bvhmplLxfWeICJVf9yjJt6
         hzZTjba4tRlffSjb2exYS06id+qwAcklNa1XWSPzznyJadOT6z0MXk7le25wMVdkHx3X
         0jG/br59cClkJ64gSYSH9QouPQjIwg4yxLAdy3x135xOYkXhjCCBBGRbSpZ1rkdG3ygv
         XTdMFzuc+qd81OkGtLgDQsPawFk2I5qfgF7wNDQS5UaZASe2uMRQVfd/MxFw0dh3Zj9n
         oM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K1u7X0Gy/yHf/V/sx8Gua1oticYhDDZwganOyh5Ba4k=;
        b=H8Dgd2Ykp1HBUboXszHZFaT7LmiMeoDXNFj5H9hGOQwWB2w643V3wTRZXrOiMofi/G
         rgwaAT+AEH1u1cV0zpoSv7aVgvj3dkA2MD0JztfZshlDjn4QlOxoV07fsdshr5+vL+bZ
         MmnI8eST7dOWrC7XbdwE6mCUSxwVR9wBJY1E0sX/rmMEBOyIhJ3wkhyfGXH6oZ42zmfh
         pYIVltKFvzVw2Lsmr6OfyJ6iVibSfrntLLTEe19nRaZTC5ZmEE9wxE0BxoONmndEAOb6
         lhXI2Q/h1u90tJlDs0oZGFdqUyvD6Jgo4WlAcgBkSv9q9I5MM34DIYbqBEeYIIYVKgGZ
         GT9g==
X-Gm-Message-State: APjAAAVb3dLK8Po+UE5ABkTU+oajJrr43vesUymCfOw/plo9cz9HEvNd
        ZFjPabIKnGndFHmIFPjao6nadHHRY7R+JGiiqFI=
X-Google-Smtp-Source: APXvYqyitBxzDbCejIUCoWCE31e2WAP/hl9zblY4Y+8sEt1EUbdwsqweCwIrCe78lGjfHuVIM/CuGKP7npfyY805T8E=
X-Received: by 2002:a6b:c389:: with SMTP id t131mr9172369iof.50.1574362145646;
 Thu, 21 Nov 2019 10:49:05 -0800 (PST)
MIME-Version: 1.0
References: <20190829161155.GA5360@magnolia> <20190830004407.GA5340@magnolia> <20191121170107.GM6211@magnolia>
In-Reply-To: <20191121170107.GM6211@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Thu, 21 Nov 2019 19:48:54 +0100
Message-ID: <CAHpGcMJYRVeNNjhMP8GEVD9Wr5g-7_sXkR=qxQTCqrwyskuDBw@mail.gmail.com>
Subject: Re: [RFC PATCH] generic: test splice() with pipes
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     xfs <linux-xfs@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Do., 21. Nov. 2019 um 18:01 Uhr schrieb Darrick J. Wong
<darrick.wong@oracle.com>:
> On Thu, Aug 29, 2019 at 05:44:07PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <darrick.wong@oracle.com>
> >
> > Andreas Gr=C3=BCnbacher reports that on the two filesystems that suppor=
t
> > iomap directio, it's possible for splice() to return -EAGAIN (instead o=
f
> > a short splice) if the pipe being written to has less space available i=
n
> > its pipe buffers than the length supplied by the calling process.
> >
> > This is a regression test to check for correct operation.
> >
> > XXX Andreas: Since you wrote the C reproducer, can you send me the
> > proper copyright and author attribution statement for the C program?
>
> Ping?  Andreas, can I get the above info so I can get this moving again?

Oops, sure, this is:

Copyright (c) 2019 RedHat Inc.  All Rights Reserved.
Author: Andreas Gruenbacher <agruenba@redhat.com>

> --D
>
> > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > ---
> >  .gitignore            |    1
> >  src/Makefile          |    2 -
> >  src/splice-test.c     |  173 +++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  tests/generic/720     |   41 ++++++++++++
> >  tests/generic/720.out |    7 ++
> >  tests/generic/group   |    1
> >  6 files changed, 224 insertions(+), 1 deletion(-)
> >  create mode 100644 src/splice-test.c
> >  create mode 100755 tests/generic/720
> >  create mode 100644 tests/generic/720.out
> >
> > diff --git a/.gitignore b/.gitignore
> > index c8c815f9..26d4da11 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -112,6 +112,7 @@
> >  /src/runas
> >  /src/seek_copy_test
> >  /src/seek_sanity_test
> > +/src/splice-test
> >  /src/stale_handle
> >  /src/stat_test
> >  /src/swapon
> > diff --git a/src/Makefile b/src/Makefile
> > index c4fcf370..2920dfb1 100644
> > --- a/src/Makefile
> > +++ b/src/Makefile
> > @@ -28,7 +28,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesize p=
reallo_rw_pattern_reader \
> >       attr-list-by-handle-cursor-test listxattr dio-interleaved t_dir_t=
ype \
> >       dio-invalidate-cache stat_test t_encrypted_d_revalidate \
> >       attr_replace_test swapon mkswap t_attr_corruption t_open_tmpfiles=
 \
> > -     fscrypt-crypt-util bulkstat_null_ocount
> > +     fscrypt-crypt-util bulkstat_null_ocount splice-test
> >
> >  SUBDIRS =3D log-writes perf
> >
> > diff --git a/src/splice-test.c b/src/splice-test.c
> > new file mode 100644
> > index 00000000..d3c12075
> > --- /dev/null
> > +++ b/src/splice-test.c
> > @@ -0,0 +1,173 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2019 ????????????????????????????
> > + * Author:
> > + *
> > + * Make sure that reading and writing to a pipe via splice.
> > + */
> > +#include <sys/types.h>
> > +#include <sys/stat.h>
> > +#include <sys/wait.h>
> > +#include <unistd.h>
> > +#include <fcntl.h>
> > +#include <err.h>
> > +
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <stdbool.h>
> > +#include <string.h>
> > +#include <errno.h>
> > +
> > +#define SECTOR_SIZE 512
> > +#define BUFFER_SIZE (150 * SECTOR_SIZE)
> > +
> > +void read_from_pipe(int fd, const char *filename, size_t size)
> > +{
> > +     char buffer[SECTOR_SIZE];
> > +     size_t sz;
> > +     ssize_t ret;
> > +
> > +     while (size) {
> > +             sz =3D size;
> > +             if (sz > sizeof buffer)
> > +                     sz =3D sizeof buffer;
> > +             ret =3D read(fd, buffer, sz);
> > +             if (ret < 0)
> > +                     err(1, "read: %s", filename);
> > +             if (ret =3D=3D 0) {
> > +                     fprintf(stderr, "read: %s: unexpected EOF\n", fil=
ename);
> > +                     exit(1);
> > +             }
> > +             size -=3D sz;
> > +     }
> > +}
> > +
> > +void do_splice1(int fd, const char *filename, size_t size)
> > +{
> > +     bool retried =3D false;
> > +     int pipefd[2];
> > +
> > +     if (pipe(pipefd) =3D=3D -1)
> > +             err(1, "pipe");
> > +     while (size) {
> > +             ssize_t spliced;
> > +
> > +             spliced =3D splice(fd, NULL, pipefd[1], NULL, size, SPLIC=
E_F_MOVE);
> > +             if (spliced =3D=3D -1) {
> > +                     if (errno =3D=3D EAGAIN && !retried) {
> > +                             retried =3D true;
> > +                             fprintf(stderr, "retrying splice\n");
> > +                             sleep(1);
> > +                             continue;
> > +                     }
> > +                     err(1, "splice");
> > +             }
> > +             read_from_pipe(pipefd[0], filename, spliced);
> > +             size -=3D spliced;
> > +     }
> > +     close(pipefd[0]);
> > +     close(pipefd[1]);
> > +}
> > +
> > +void do_splice2(int fd, const char *filename, size_t size)
> > +{
> > +     bool retried =3D false;
> > +     int pipefd[2];
> > +     int pid;
> > +
> > +     if (pipe(pipefd) =3D=3D -1)
> > +             err(1, "pipe");
> > +
> > +     pid =3D fork();
> > +     if (pid =3D=3D 0) {
> > +             close(pipefd[1]);
> > +             read_from_pipe(pipefd[0], filename, size);
> > +             exit(0);
> > +     } else {
> > +             close(pipefd[0]);
> > +             while (size) {
> > +                     ssize_t spliced;
> > +
> > +                     spliced =3D splice(fd, NULL, pipefd[1], NULL, siz=
e, SPLICE_F_MOVE);
> > +                     if (spliced =3D=3D -1) {
> > +                             if (errno =3D=3D EAGAIN && !retried) {
> > +                                     retried =3D true;
> > +                                     fprintf(stderr, "retrying splice\=
n");
> > +                                     sleep(1);
> > +                                     continue;
> > +                             }
> > +                             err(1, "splice");
> > +                     }
> > +                     size -=3D spliced;
> > +             }
> > +             close(pipefd[1]);
> > +             waitpid(pid, NULL, 0);
> > +     }
> > +}
> > +
> > +void usage(const char *argv0)
> > +{
> > +     fprintf(stderr, "USAGE: %s [-rd] {filename}\n", basename(argv0));
> > +     exit(2);
> > +}
> > +
> > +int main(int argc, char *argv[])
> > +{
> > +     void (*do_splice)(int fd, const char *filename, size_t size);
> > +     const char *filename;
> > +     char *buffer;
> > +     int opt, open_flags, fd;
> > +     ssize_t ret;
> > +
> > +     do_splice =3D do_splice1;
> > +     open_flags =3D O_CREAT | O_TRUNC | O_RDWR | O_DIRECT;
> > +
> > +     while ((opt =3D getopt(argc, argv, "rd")) !=3D -1) {
> > +             switch(opt) {
> > +             case 'r':
> > +                     do_splice =3D do_splice2;
> > +                     break;
> > +             case 'd':
> > +                     open_flags &=3D ~O_DIRECT;
> > +                     break;
> > +             default:  /* '?' */
> > +                     usage(argv[0]);
> > +             }
> > +     }
> > +
> > +     if (optind >=3D argc)
> > +             usage(argv[0]);
> > +     filename =3D argv[optind];
> > +
> > +     printf("%s reader %s O_DIRECT\n",
> > +                do_splice =3D=3D do_splice1 ? "sequential" : "concurre=
nt",
> > +                (open_flags & O_DIRECT) ? "with" : "without");
> > +
> > +     buffer =3D aligned_alloc(SECTOR_SIZE, BUFFER_SIZE);
> > +     if (buffer =3D=3D NULL)
> > +             err(1, "aligned_alloc");
> > +
> > +     fd =3D open(filename, open_flags, 0666);
> > +     if (fd =3D=3D -1)
> > +             err(1, "open: %s", filename);
> > +
> > +     memset(buffer, 'x', BUFFER_SIZE);
> > +     ret =3D write(fd, buffer, BUFFER_SIZE);
> > +     if (ret < 0)
> > +             err(1, "write: %s", filename);
> > +     if (ret !=3D BUFFER_SIZE) {
> > +             fprintf(stderr, "%s: short write\n", filename);
> > +             exit(1);
> > +     }
> > +
> > +     ret =3D lseek(fd, 0, SEEK_SET);
> > +     if (ret !=3D 0)
> > +             err(1, "lseek: %s", filename);
> > +
> > +     do_splice(fd, filename, BUFFER_SIZE);
> > +
> > +     if (unlink(filename) =3D=3D -1)
> > +             err(1, "unlink: %s", filename);
> > +
> > +     return 0;
> > +}
> > diff --git a/tests/generic/720 b/tests/generic/720
> > new file mode 100755
> > index 00000000..b7f09c40
> > --- /dev/null
> > +++ b/tests/generic/720
> > @@ -0,0 +1,41 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +# Copyright (c) 2019, Oracle and/or its affiliates.  All Rights Reserv=
ed.
> > +#
> > +# FS QA Test No. 720
> > +#
> > +# Test using splice() to read from pipes.
> > +
> > +seq=3D`basename $0`
> > +seqres=3D$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +here=3D`pwd`
> > +tmp=3D/tmp/$$
> > +status=3D1    # failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > +
> > +_cleanup()
> > +{
> > +     cd /
> > +     rm -f $TEST_DIR/a
> > +}
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +
> > +# real QA test starts here
> > +_supported_os Linux
> > +_supported_fs generic
> > +_require_test
> > +
> > +rm -f $seqres.full
> > +
> > +src/splice-test -r $TEST_DIR/a
> > +src/splice-test -rd $TEST_DIR/a
> > +src/splice-test $TEST_DIR/a
> > +src/splice-test -d $TEST_DIR/a
> > +
> > +# success, all done
> > +status=3D0
> > +exit
> > diff --git a/tests/generic/720.out b/tests/generic/720.out
> > new file mode 100644
> > index 00000000..b0fc9935
> > --- /dev/null
> > +++ b/tests/generic/720.out
> > @@ -0,0 +1,7 @@
> > +QA output created by 720
> > +concurrent reader with O_DIRECT
> > +concurrent reader with O_DIRECT
> > +concurrent reader without O_DIRECT
> > +concurrent reader without O_DIRECT
> > +sequential reader with O_DIRECT
> > +sequential reader without O_DIRECT
> > diff --git a/tests/generic/group b/tests/generic/group
> > index cd418106..f75d4e60 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -569,3 +569,4 @@
> >  564 auto quick copy_range
> >  565 auto quick copy_range
> >  719 auto quick quota metadata
> > +720 auto quick rw pipe splice

Thanks,
Andreas

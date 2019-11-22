Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3103105E3D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 02:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKVB17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Nov 2019 20:27:59 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36923 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKVB17 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Nov 2019 20:27:59 -0500
Received: by mail-il1-f194.google.com with SMTP id s5so5291576iln.4;
        Thu, 21 Nov 2019 17:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rPCJO7GnHksxBlMw8PoFikzTQVlqGerblR7VxrP8op8=;
        b=ASlw3CCaFyR7q32GfxFccLOWoxnvXOTa6ScK3/dkhxFAmkjvMTsDw/oYeroX/UONIN
         1dg5+8/eS6TvDRHxqLr9dWmYSpNN3jTahRkvZvtS1HaTgqcze5cSO4io7cfCfaaUTCCU
         Cqxwt00jbCZia2fmxB8EiJt3rQUz6nWain09sdY0XnT6q34tSY3npp17ts8KADzFGAvN
         KbNE1t+EjaSnPYjKPW4n/Tqa6NhY5wFBCIEKgqRIL6dtpuOVrS8m0HblUwIa0QebSk2D
         PORn+VK9gepAf5J4/n/pYIBS1+cn2fzbwUJrerpGGiquQr328/JRqY/7GR0vrvyskOmS
         kaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rPCJO7GnHksxBlMw8PoFikzTQVlqGerblR7VxrP8op8=;
        b=CBME4DUJqMcJPy2HBB7gsDZHouKATVr6ygpsAJQ2aAdbvIVt+RraztHBpUfD4L2TJj
         r/5i64r11THsHbYi1ahioxBPngkdUrYMiMYh2ctNlafE0AuthteUss1rXXo/jcyIoQBj
         JShoYL99LIEooXM6XSycrFXqws0+Sh5moXpWhG8GvkgnSTI37gYiQlKwP3kcQWoqlblM
         Kx2e8FQhg+PEevzwA/W7oCP5YoY27NEY1Zlue78JMzC5sWUoygkpsa2LaOSYZ0VvfeM3
         ALsNiuCIve8G8pCK30r3/EDrVYcBcJgzO5ji2gjjGldeAy68AD0iAzF3ypeOBZ970L9P
         29qg==
X-Gm-Message-State: APjAAAV1Dle3tNu3UNdKGUP0go9Xc/rKnAMPtTBYrju/PCrNZZ7oRpmU
        /Gttzc4tcUyKsLAGUKn5m0hUEbB72H9sO0Gixew=
X-Google-Smtp-Source: APXvYqx85lCERWslzGv41CtcOyxqAyw6OMEf34F51kHE4PdFepqxGk1J7gmJsjOA+WHZErki5D7vpMXvmmXglZ/6t+0=
X-Received: by 2002:a92:2451:: with SMTP id k78mr14095595ilk.300.1574386077542;
 Thu, 21 Nov 2019 17:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20190829161155.GA5360@magnolia> <20190830004407.GA5340@magnolia>
 <20191121170107.GM6211@magnolia> <CAHpGcMJYRVeNNjhMP8GEVD9Wr5g-7_sXkR=qxQTCqrwyskuDBw@mail.gmail.com>
 <20191121191453.GN6211@magnolia>
In-Reply-To: <20191121191453.GN6211@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 22 Nov 2019 02:27:46 +0100
Message-ID: <CAHpGcMK_pJA1KU0fbX28e41a8X9Fa7Kw12k8=P955LUW8yYEkw@mail.gmail.com>
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

Am Do., 21. Nov. 2019 um 20:14 Uhr schrieb Darrick J. Wong
<darrick.wong@oracle.com>:
> On Thu, Nov 21, 2019 at 07:48:54PM +0100, Andreas Gr=C3=BCnbacher wrote:
> > Am Do., 21. Nov. 2019 um 18:01 Uhr schrieb Darrick J. Wong
> > <darrick.wong@oracle.com>:
> > > On Thu, Aug 29, 2019 at 05:44:07PM -0700, Darrick J. Wong wrote:
> > > > From: Darrick J. Wong <darrick.wong@oracle.com>
> > > >
> > > > Andreas Gr=C3=BCnbacher reports that on the two filesystems that su=
pport
> > > > iomap directio, it's possible for splice() to return -EAGAIN (inste=
ad of
> > > > a short splice) if the pipe being written to has less space availab=
le in
> > > > its pipe buffers than the length supplied by the calling process.
> > > >
> > > > This is a regression test to check for correct operation.
> > > >
> > > > XXX Andreas: Since you wrote the C reproducer, can you send me the
> > > > proper copyright and author attribution statement for the C program=
?
> > >
> > > Ping?  Andreas, can I get the above info so I can get this moving aga=
in?
> >
> > Oops, sure, this is:
> >
> > Copyright (c) 2019 RedHat Inc.  All Rights Reserved.
> > Author: Andreas Gruenbacher <agruenba@redhat.com>
>
> Ok thanks.  It's appropriate to tag it as GPL v2 licensed, correct?

My prevous reply didn't quite make it, so again, yes, that's correct.

Thanks,
Andreas

> --D
>
> > > --D
> > >
> > > > Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> > > > ---
> > > >  .gitignore            |    1
> > > >  src/Makefile          |    2 -
> > > >  src/splice-test.c     |  173 +++++++++++++++++++++++++++++++++++++=
++++++++++++
> > > >  tests/generic/720     |   41 ++++++++++++
> > > >  tests/generic/720.out |    7 ++
> > > >  tests/generic/group   |    1
> > > >  6 files changed, 224 insertions(+), 1 deletion(-)
> > > >  create mode 100644 src/splice-test.c
> > > >  create mode 100755 tests/generic/720
> > > >  create mode 100644 tests/generic/720.out
> > > >
> > > > diff --git a/.gitignore b/.gitignore
> > > > index c8c815f9..26d4da11 100644
> > > > --- a/.gitignore
> > > > +++ b/.gitignore
> > > > @@ -112,6 +112,7 @@
> > > >  /src/runas
> > > >  /src/seek_copy_test
> > > >  /src/seek_sanity_test
> > > > +/src/splice-test
> > > >  /src/stale_handle
> > > >  /src/stat_test
> > > >  /src/swapon
> > > > diff --git a/src/Makefile b/src/Makefile
> > > > index c4fcf370..2920dfb1 100644
> > > > --- a/src/Makefile
> > > > +++ b/src/Makefile
> > > > @@ -28,7 +28,7 @@ LINUX_TARGETS =3D xfsctl bstat t_mtab getdevicesi=
ze preallo_rw_pattern_reader \
> > > >       attr-list-by-handle-cursor-test listxattr dio-interleaved t_d=
ir_type \
> > > >       dio-invalidate-cache stat_test t_encrypted_d_revalidate \
> > > >       attr_replace_test swapon mkswap t_attr_corruption t_open_tmpf=
iles \
> > > > -     fscrypt-crypt-util bulkstat_null_ocount
> > > > +     fscrypt-crypt-util bulkstat_null_ocount splice-test
> > > >
> > > >  SUBDIRS =3D log-writes perf
> > > >
> > > > diff --git a/src/splice-test.c b/src/splice-test.c
> > > > new file mode 100644
> > > > index 00000000..d3c12075
> > > > --- /dev/null
> > > > +++ b/src/splice-test.c
> > > > @@ -0,0 +1,173 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +/*
> > > > + * Copyright (C) 2019 ????????????????????????????
> > > > + * Author:
> > > > + *
> > > > + * Make sure that reading and writing to a pipe via splice.
> > > > + */
> > > > +#include <sys/types.h>
> > > > +#include <sys/stat.h>
> > > > +#include <sys/wait.h>
> > > > +#include <unistd.h>
> > > > +#include <fcntl.h>
> > > > +#include <err.h>
> > > > +
> > > > +#include <stdlib.h>
> > > > +#include <stdio.h>
> > > > +#include <stdbool.h>
> > > > +#include <string.h>
> > > > +#include <errno.h>
> > > > +
> > > > +#define SECTOR_SIZE 512
> > > > +#define BUFFER_SIZE (150 * SECTOR_SIZE)
> > > > +
> > > > +void read_from_pipe(int fd, const char *filename, size_t size)
> > > > +{
> > > > +     char buffer[SECTOR_SIZE];
> > > > +     size_t sz;
> > > > +     ssize_t ret;
> > > > +
> > > > +     while (size) {
> > > > +             sz =3D size;
> > > > +             if (sz > sizeof buffer)
> > > > +                     sz =3D sizeof buffer;
> > > > +             ret =3D read(fd, buffer, sz);
> > > > +             if (ret < 0)
> > > > +                     err(1, "read: %s", filename);
> > > > +             if (ret =3D=3D 0) {
> > > > +                     fprintf(stderr, "read: %s: unexpected EOF\n",=
 filename);
> > > > +                     exit(1);
> > > > +             }
> > > > +             size -=3D sz;
> > > > +     }
> > > > +}
> > > > +
> > > > +void do_splice1(int fd, const char *filename, size_t size)
> > > > +{
> > > > +     bool retried =3D false;
> > > > +     int pipefd[2];
> > > > +
> > > > +     if (pipe(pipefd) =3D=3D -1)
> > > > +             err(1, "pipe");
> > > > +     while (size) {
> > > > +             ssize_t spliced;
> > > > +
> > > > +             spliced =3D splice(fd, NULL, pipefd[1], NULL, size, S=
PLICE_F_MOVE);
> > > > +             if (spliced =3D=3D -1) {
> > > > +                     if (errno =3D=3D EAGAIN && !retried) {
> > > > +                             retried =3D true;
> > > > +                             fprintf(stderr, "retrying splice\n");
> > > > +                             sleep(1);
> > > > +                             continue;
> > > > +                     }
> > > > +                     err(1, "splice");
> > > > +             }
> > > > +             read_from_pipe(pipefd[0], filename, spliced);
> > > > +             size -=3D spliced;
> > > > +     }
> > > > +     close(pipefd[0]);
> > > > +     close(pipefd[1]);
> > > > +}
> > > > +
> > > > +void do_splice2(int fd, const char *filename, size_t size)
> > > > +{
> > > > +     bool retried =3D false;
> > > > +     int pipefd[2];
> > > > +     int pid;
> > > > +
> > > > +     if (pipe(pipefd) =3D=3D -1)
> > > > +             err(1, "pipe");
> > > > +
> > > > +     pid =3D fork();
> > > > +     if (pid =3D=3D 0) {
> > > > +             close(pipefd[1]);
> > > > +             read_from_pipe(pipefd[0], filename, size);
> > > > +             exit(0);
> > > > +     } else {
> > > > +             close(pipefd[0]);
> > > > +             while (size) {
> > > > +                     ssize_t spliced;
> > > > +
> > > > +                     spliced =3D splice(fd, NULL, pipefd[1], NULL,=
 size, SPLICE_F_MOVE);
> > > > +                     if (spliced =3D=3D -1) {
> > > > +                             if (errno =3D=3D EAGAIN && !retried) =
{
> > > > +                                     retried =3D true;
> > > > +                                     fprintf(stderr, "retrying spl=
ice\n");
> > > > +                                     sleep(1);
> > > > +                                     continue;
> > > > +                             }
> > > > +                             err(1, "splice");
> > > > +                     }
> > > > +                     size -=3D spliced;
> > > > +             }
> > > > +             close(pipefd[1]);
> > > > +             waitpid(pid, NULL, 0);
> > > > +     }
> > > > +}
> > > > +
> > > > +void usage(const char *argv0)
> > > > +{
> > > > +     fprintf(stderr, "USAGE: %s [-rd] {filename}\n", basename(argv=
0));
> > > > +     exit(2);
> > > > +}
> > > > +
> > > > +int main(int argc, char *argv[])
> > > > +{
> > > > +     void (*do_splice)(int fd, const char *filename, size_t size);
> > > > +     const char *filename;
> > > > +     char *buffer;
> > > > +     int opt, open_flags, fd;
> > > > +     ssize_t ret;
> > > > +
> > > > +     do_splice =3D do_splice1;
> > > > +     open_flags =3D O_CREAT | O_TRUNC | O_RDWR | O_DIRECT;
> > > > +
> > > > +     while ((opt =3D getopt(argc, argv, "rd")) !=3D -1) {
> > > > +             switch(opt) {
> > > > +             case 'r':
> > > > +                     do_splice =3D do_splice2;
> > > > +                     break;
> > > > +             case 'd':
> > > > +                     open_flags &=3D ~O_DIRECT;
> > > > +                     break;
> > > > +             default:  /* '?' */
> > > > +                     usage(argv[0]);
> > > > +             }
> > > > +     }
> > > > +
> > > > +     if (optind >=3D argc)
> > > > +             usage(argv[0]);
> > > > +     filename =3D argv[optind];
> > > > +
> > > > +     printf("%s reader %s O_DIRECT\n",
> > > > +                do_splice =3D=3D do_splice1 ? "sequential" : "conc=
urrent",
> > > > +                (open_flags & O_DIRECT) ? "with" : "without");
> > > > +
> > > > +     buffer =3D aligned_alloc(SECTOR_SIZE, BUFFER_SIZE);
> > > > +     if (buffer =3D=3D NULL)
> > > > +             err(1, "aligned_alloc");
> > > > +
> > > > +     fd =3D open(filename, open_flags, 0666);
> > > > +     if (fd =3D=3D -1)
> > > > +             err(1, "open: %s", filename);
> > > > +
> > > > +     memset(buffer, 'x', BUFFER_SIZE);
> > > > +     ret =3D write(fd, buffer, BUFFER_SIZE);
> > > > +     if (ret < 0)
> > > > +             err(1, "write: %s", filename);
> > > > +     if (ret !=3D BUFFER_SIZE) {
> > > > +             fprintf(stderr, "%s: short write\n", filename);
> > > > +             exit(1);
> > > > +     }
> > > > +
> > > > +     ret =3D lseek(fd, 0, SEEK_SET);
> > > > +     if (ret !=3D 0)
> > > > +             err(1, "lseek: %s", filename);
> > > > +
> > > > +     do_splice(fd, filename, BUFFER_SIZE);
> > > > +
> > > > +     if (unlink(filename) =3D=3D -1)
> > > > +             err(1, "unlink: %s", filename);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > diff --git a/tests/generic/720 b/tests/generic/720
> > > > new file mode 100755
> > > > index 00000000..b7f09c40
> > > > --- /dev/null
> > > > +++ b/tests/generic/720
> > > > @@ -0,0 +1,41 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0-or-later
> > > > +# Copyright (c) 2019, Oracle and/or its affiliates.  All Rights Re=
served.
> > > > +#
> > > > +# FS QA Test No. 720
> > > > +#
> > > > +# Test using splice() to read from pipes.
> > > > +
> > > > +seq=3D`basename $0`
> > > > +seqres=3D$RESULT_DIR/$seq
> > > > +echo "QA output created by $seq"
> > > > +
> > > > +here=3D`pwd`
> > > > +tmp=3D/tmp/$$
> > > > +status=3D1    # failure is the default!
> > > > +trap "_cleanup; exit \$status" 0 1 2 3 15
> > > > +
> > > > +_cleanup()
> > > > +{
> > > > +     cd /
> > > > +     rm -f $TEST_DIR/a
> > > > +}
> > > > +
> > > > +# get standard environment, filters and checks
> > > > +. ./common/rc
> > > > +
> > > > +# real QA test starts here
> > > > +_supported_os Linux
> > > > +_supported_fs generic
> > > > +_require_test
> > > > +
> > > > +rm -f $seqres.full
> > > > +
> > > > +src/splice-test -r $TEST_DIR/a
> > > > +src/splice-test -rd $TEST_DIR/a
> > > > +src/splice-test $TEST_DIR/a
> > > > +src/splice-test -d $TEST_DIR/a
> > > > +
> > > > +# success, all done
> > > > +status=3D0
> > > > +exit
> > > > diff --git a/tests/generic/720.out b/tests/generic/720.out
> > > > new file mode 100644
> > > > index 00000000..b0fc9935
> > > > --- /dev/null
> > > > +++ b/tests/generic/720.out
> > > > @@ -0,0 +1,7 @@
> > > > +QA output created by 720
> > > > +concurrent reader with O_DIRECT
> > > > +concurrent reader with O_DIRECT
> > > > +concurrent reader without O_DIRECT
> > > > +concurrent reader without O_DIRECT
> > > > +sequential reader with O_DIRECT
> > > > +sequential reader without O_DIRECT
> > > > diff --git a/tests/generic/group b/tests/generic/group
> > > > index cd418106..f75d4e60 100644
> > > > --- a/tests/generic/group
> > > > +++ b/tests/generic/group
> > > > @@ -569,3 +569,4 @@
> > > >  564 auto quick copy_range
> > > >  565 auto quick copy_range
> > > >  719 auto quick quota metadata
> > > > +720 auto quick rw pipe splice
> >
> > Thanks,
> > Andreas

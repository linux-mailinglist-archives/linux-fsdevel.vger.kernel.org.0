Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF5FC116792
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 08:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfLIHhI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 02:37:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29554 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726270AbfLIHhI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 02:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575877026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rj/40+Ni8SRd7cpe7p7g7aqJGtJMe66r3Pz4JHIZr3k=;
        b=OBX9DLyzk8rlPC1OnyG/w5aDBMjPPdI3QE5+vRjaTpAMxcVS1ovBheVKzCmGKE8nYvaKcZ
        70T5YGAsTtk1lZSELJAB7+/54gwjV5yVH/kCkCErvtyI5hPb6d5lImiKT5Q7KTf7YjDDfW
        TqsJ+4HDnBklktJw+QK8CDP0JuwPKX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-iPTEGhJOPOqzKm72Z9GK0Q-1; Mon, 09 Dec 2019 02:37:04 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBD66800D5B;
        Mon,  9 Dec 2019 07:37:03 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F30A5D6A7;
        Mon,  9 Dec 2019 07:37:03 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 5F22918089C8;
        Mon,  9 Dec 2019 07:37:03 +0000 (UTC)
Date:   Mon, 9 Dec 2019 02:37:03 -0500 (EST)
From:   Zirong Lang <zlang@redhat.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     ltp@lists.linux.it, linux-fsdevel@vger.kernel.org
Message-ID: <2129381829.39694312.1575877023126.JavaMail.zimbra@redhat.com>
In-Reply-To: <b59bb33a-205a-581b-91ac-c1e05e92ca93@cn.fujitsu.com>
References: <20191208141617.21925-1-zlang@redhat.com> <b59bb33a-205a-581b-91ac-c1e05e92ca93@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] syscalls/newmount: new test case for new mount
 API
MIME-Version: 1.0
X-Originating-IP: [10.72.12.160, 10.4.195.25]
Thread-Topic: syscalls/newmount: new test case for new mount API
Thread-Index: l+VYs7zfbLywLa+ZCiWn5lu0x1+fbw==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: iPTEGhJOPOqzKm72Z9GK0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



----- =E5=8E=9F=E5=A7=8B=E9=82=AE=E4=BB=B6 -----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: "Yang Xu" <xuyang2018.jy@cn.fujitsu.com>
> =E6=94=B6=E4=BB=B6=E4=BA=BA: "Zorro Lang" <zlang@redhat.com>, ltp@lists.l=
inux.it
> =E6=8A=84=E9=80=81: linux-fsdevel@vger.kernel.org
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: =E6=98=9F=E6=9C=9F=E4=B8=80, 2019=
=E5=B9=B4 12 =E6=9C=88 09=E6=97=A5 =E4=B8=8B=E5=8D=88 12:49:32
> =E4=B8=BB=E9=A2=98: Re: [LTP] [PATCH v2] syscalls/newmount: new test case=
 for new mount API
>=20
>=20
> Hi Zorro
>=20
> ON 2019/12/08 22:16, Zorro Lang wrote:
> >=20
> > diff --git a/configure.ac b/configure.ac
> > index 50d14967d..28f840c51 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -229,6 +229,7 @@ LTP_CHECK_MADVISE
> >   LTP_CHECK_MKDTEMP
> >   LTP_CHECK_MMSGHDR
> >   LTP_CHECK_MREMAP_FIXED
> > +LTP_CHECK_NEWMOUNT
> >   LTP_CHECK_NOMMU_LINUX
> >   LTP_CHECK_PERF_EVENT
> >   LTP_CHECK_PRCTL_SUPPORT
> > diff --git a/include/lapi/newmount.h b/include/lapi/newmount.h
> > new file mode 100644
> > index 000000000..6b787fe7d
> > --- /dev/null
> > +++ b/include/lapi/newmount.h
> > @@ -0,0 +1,89 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
> > + * Author: Zorro Lang <zlang@redhat.com>
> > + */
> > +
> > +#ifndef NEWMOUNT_H__
> > +#define NEWMOUNT_H__
> > +
> > +#include <stdint.h>
> > +#include <unistd.h>
> > +#include "config.h"
> > +#include "lapi/syscalls.h"
> > +
> > +#if !defined(HAVE_NEWMOUNT)
> Why use HVAE_NEWMOUNT?

Oh, my mistake. I wrote HAVE_NEWMOUNT with CHECK_NEWMOUNT together. I shoul=
d use
HAVE_FSOPEN, HAVE_FSCONFIG etc.

Thanks,
Zorro

> > +static inline int fsopen(const char *fs_name, unsigned int flags)
> > +{
> > +=09return tst_syscall(__NR_fsopen, fs_name, flags);
> > +}
> > +
> > +/*
> > + * fsopen() flags.
> > + */
> > +#define FSOPEN_CLOEXEC=09=090x00000001
> > +
> > +static inline int fsconfig(int fsfd, unsigned int cmd,
> > +                           const char *key, const void *val, int aux)
> > +{
> > +=09return tst_syscall(__NR_fsconfig, fsfd, cmd, key, val, aux);
> > +}
> > +
> > +/*
> > + * The type of fsconfig() call made.
> > + */
> > +enum fsconfig_command {
> > +=09FSCONFIG_SET_FLAG=09=3D 0,    /* Set parameter, supplying no value =
*/
> > +=09FSCONFIG_SET_STRING=09=3D 1,    /* Set parameter, supplying a strin=
g value */
> > +=09FSCONFIG_SET_BINARY=09=3D 2,    /* Set parameter, supplying a binar=
y blob
> > value */
> > +=09FSCONFIG_SET_PATH=09=3D 3,    /* Set parameter, supplying an object=
 by path
> > */
> > +=09FSCONFIG_SET_PATH_EMPTY=09=3D 4,    /* Set parameter, supplying an =
object by
> > (empty) path */
> > +=09FSCONFIG_SET_FD=09=09=3D 5,    /* Set parameter, supplying an objec=
t by fd */
> > +=09FSCONFIG_CMD_CREATE=09=3D 6,    /* Invoke superblock creation */
> > +=09FSCONFIG_CMD_RECONFIGURE =3D 7,   /* Invoke superblock reconfigurat=
ion */
> > +};
> > +
> > +static inline int fsmount(int fsfd, unsigned int flags, unsigned int
> > ms_flags)
> > +{
> > +=09return tst_syscall(__NR_fsmount, fsfd, flags, ms_flags);
> > +}
> > +
> > +/*
> > + * fsmount() flags.
> > + */
> > +#define FSMOUNT_CLOEXEC=09=090x00000001
> > +
> > +/*
> > + * Mount attributes.
> > + */
> > +#define MOUNT_ATTR_RDONLY=090x00000001 /* Mount read-only */
> > +#define MOUNT_ATTR_NOSUID=090x00000002 /* Ignore suid and sgid bits */
> > +#define MOUNT_ATTR_NODEV=090x00000004 /* Disallow access to device spe=
cial
> > files */
> > +#define MOUNT_ATTR_NOEXEC=090x00000008 /* Disallow program execution *=
/
> > +#define MOUNT_ATTR__ATIME=090x00000070 /* Setting on how atime should =
be
> > updated */
> > +#define MOUNT_ATTR_RELATIME=090x00000000 /* - Update atime relative to
> > mtime/ctime. */
> > +#define MOUNT_ATTR_NOATIME=090x00000010 /* - Do not update access time=
s. */
> > +#define MOUNT_ATTR_STRICTATIME=090x00000020 /* - Always perform atime
> > updates */
> > +#define MOUNT_ATTR_NODIRATIME=090x00000080 /* Do not update directory =
access
> > times */
> > +
> > +static inline int move_mount(int from_dfd, const char *from_pathname,
> > +                             int to_dfd, const char *to_pathname,
> > +                             unsigned int flags)
> > +{
> > +=09return tst_syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd=
,
> > +=09                   to_pathname, flags);
> > +}
> > +
> > +/*
> > + * move_mount() flags.
> > + */
> > +#define MOVE_MOUNT_F_SYMLINKS=09=090x00000001 /* Follow symlinks on fr=
om path
> > */
> > +#define MOVE_MOUNT_F_AUTOMOUNTS=09=090x00000002 /* Follow automounts o=
n from
> > path */
> > +#define MOVE_MOUNT_F_EMPTY_PATH=09=090x00000004 /* Empty from path per=
mitted
> > */
> > +#define MOVE_MOUNT_T_SYMLINKS=09=090x00000010 /* Follow symlinks on to=
 path */
> > +#define MOVE_MOUNT_T_AUTOMOUNTS=09=090x00000020 /* Follow automounts o=
n to
> > path */
> > +#define MOVE_MOUNT_T_EMPTY_PATH=09=090x00000040 /* Empty to path permi=
tted */
> > +#define MOVE_MOUNT__MASK=09=090x00000077
> > +
> > +#endif /* HAVE_NEWMOUNT */
> > +#endif /* NEWMOUNT_H__ */
> > diff --git a/include/lapi/syscalls/aarch64.in
> > b/include/lapi/syscalls/aarch64.in
> > index 0e00641bc..5b9e1d9a4 100644
> > --- a/include/lapi/syscalls/aarch64.in
> > +++ b/include/lapi/syscalls/aarch64.in
> > @@ -270,4 +270,8 @@ pkey_mprotect 288
> >   pkey_alloc 289
> >   pkey_free 290
> >   pidfd_send_signal 424
> > +move_mount 429
> > +fsopen 430
> > +fsconfig 431
> > +fsmount 432
> >   _sysctl 1078
> > diff --git a/include/lapi/syscalls/powerpc64.in
> > b/include/lapi/syscalls/powerpc64.in
> > index 660165d7a..3aaed64e0 100644
> > --- a/include/lapi/syscalls/powerpc64.in
> > +++ b/include/lapi/syscalls/powerpc64.in
> > @@ -359,3 +359,7 @@ pidfd_send_signal 424
> >   pkey_mprotect 386
> >   pkey_alloc 384
> >   pkey_free 385
> > +move_mount 429
> > +fsopen 430
> > +fsconfig 431
> > +fsmount 432
> > diff --git a/include/lapi/syscalls/s390x.in
> > b/include/lapi/syscalls/s390x.in
> > index 7d632d1dc..bd427555a 100644
> > --- a/include/lapi/syscalls/s390x.in
> > +++ b/include/lapi/syscalls/s390x.in
> > @@ -341,3 +341,7 @@ pkey_mprotect 384
> >   pkey_alloc 385
> >   pkey_free 386
> >   pidfd_send_signal 424
> > +move_mount 429
> > +fsopen 430
> > +fsconfig 431
> > +fsmount 432
> > diff --git a/include/lapi/syscalls/x86_64.in
> > b/include/lapi/syscalls/x86_64.in
> > index b1cbd4f2f..94f0b562e 100644
> > --- a/include/lapi/syscalls/x86_64.in
> > +++ b/include/lapi/syscalls/x86_64.in
> > @@ -320,3 +320,7 @@ pkey_alloc 330
> >   pkey_free 331
> >   statx 332
> >   pidfd_send_signal 424
> > +move_mount 429
> > +fsopen 430
> > +fsconfig 431
> > +fsmount 432
> > diff --git a/m4/ltp-newmount.m4 b/m4/ltp-newmount.m4
> > new file mode 100644
> > index 000000000..e13a6f0b1
> > --- /dev/null
> > +++ b/m4/ltp-newmount.m4
> > @@ -0,0 +1,10 @@
> > +dnl SPDX-License-Identifier: GPL-2.0-or-later
> > +dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
> > +
> > +AC_DEFUN([LTP_CHECK_NEWMOUNT],[
> > +AC_CHECK_FUNCS(fsopen,,)
> > +AC_CHECK_FUNCS(fsconfig,,)
> > +AC_CHECK_FUNCS(fsmount,,)
> > +AC_CHECK_FUNCS(move_mount,,)
> > +AC_CHECK_HEADER(sys/mount.h,,,)
> > +])
> You use m4 to check them. But it seems that you don't use those macros
> in your cases.
> > diff --git a/runtest/syscalls b/runtest/syscalls
> > index 15dbd9971..fac1c62d2 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -794,6 +794,8 @@ nanosleep01 nanosleep01
> >   nanosleep02 nanosleep02
> >   nanosleep04 nanosleep04
> >  =20
> > +newmount01 newmount01
> > +
> >   nftw01 nftw01
> >   nftw6401 nftw6401
> >  =20
> > diff --git a/testcases/kernel/syscalls/newmount/.gitignore
> > b/testcases/kernel/syscalls/newmount/.gitignore
> > new file mode 100644
> > index 000000000..dc78edd5b
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/newmount/.gitignore
> > @@ -0,0 +1 @@
> > +/newmount01
> > diff --git a/testcases/kernel/syscalls/newmount/Makefile
> > b/testcases/kernel/syscalls/newmount/Makefile
> > new file mode 100644
> > index 000000000..7d0920df6
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/newmount/Makefile
> > @@ -0,0 +1,9 @@
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +#
> > +# Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
> > +
> > +top_srcdir=09=09?=3D ../../../..
> > +
> > +include $(top_srcdir)/include/mk/testcases.mk
> > +
> > +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > diff --git a/testcases/kernel/syscalls/newmount/newmount01.c
> > b/testcases/kernel/syscalls/newmount/newmount01.c
> > new file mode 100644
> > index 000000000..464ecb699
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/newmount/newmount01.c
> > @@ -0,0 +1,114 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
> > + * Author: Zorro Lang <zlang@redhat.com>
> > + *
> > + * Use new mount API (fsopen, fsconfig, fsmount, move_mount) to mount
> > + * a filesystem without any specified mount options.
> > + */
> > +
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <sys/mount.h>
> > +
> > +#include "tst_test.h"
> > +#include "tst_safe_macros.h"
> "tst_test.h" has included "tst_safe_macros.h"
> > +#include "lapi/newmount.h"
> > +
> > +#define LINELENGTH 256
> > +#define MNTPOINT "newmount_point"
> > +static int sfd, mfd;
> > +static int is_mounted =3D 0;
> static int sfd, mfd, is_mounted;



> > +
> > +static int ismount(char *mntpoint)
> > +{
> > +=09int ret =3D 0;
> > +=09FILE *file;
> > +=09char line[LINELENGTH];
> > +
> > +=09file =3D fopen("/proc/mounts", "r");
> > +=09if (file =3D=3D NULL)
> > +=09=09tst_brk(TFAIL | TTERRNO, "Open /proc/mounts failed");
> > +
> > +=09while (fgets(line, LINELENGTH, file) !=3D NULL) {
> > +=09=09if (strstr(line, mntpoint) !=3D NULL) {
> > +=09=09=09ret =3D 1;
> > +=09=09=09break;
> > +=09=09}
> > +=09}
> > +=09fclose(file);
> > +=09return ret;
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +=09if (is_mounted) {
> > +=09=09TEST(tst_umount(MNTPOINT));
> > +=09=09if (TST_RET !=3D 0)
> > +=09=09=09tst_brk(TFAIL | TTERRNO, "umount failed in cleanup");
> > +=09}
> > +}
> > +
> > +static void test_newmount(void)
> > +{
> > +=09TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
> > +=09if (TST_RET < 0) {
> > +=09=09tst_brk(TFAIL | TTERRNO,
> > +=09=09        "fsopen %s", tst_device->fs_type);
> > +=09}
> > +=09sfd =3D TST_RET;
> > +=09tst_res(TPASS, "fsopen %s", tst_device->fs_type);
> > +
> > +=09TEST(fsconfig(sfd, FSCONFIG_SET_STRING, "source", tst_device->dev, =
0));
> > +=09if (TST_RET < 0) {
> > +=09=09tst_brk(TFAIL | TTERRNO,
> > +=09=09        "fsconfig set source to %s", tst_device->dev);
> > +=09}
> > +=09tst_res(TPASS, "fsconfig set source to %s", tst_device->dev);
> > +
> > +
> > +=09TEST(fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> > +=09if (TST_RET < 0) {
> > +=09=09tst_brk(TFAIL | TTERRNO,
> > +=09=09        "fsconfig create superblock");
> > +=09}
> > +=09tst_res(TPASS, "fsconfig create superblock");
> > +
> > +=09TEST(fsmount(sfd, FSMOUNT_CLOEXEC, 0));
> > +=09if (TST_RET < 0) {
> > +=09=09tst_brk(TFAIL | TTERRNO, "fsmount");
> > +=09}
> > +=09mfd =3D TST_RET;
> > +=09tst_res(TPASS, "fsmount");
> > +=09SAFE_CLOSE(sfd);
> > +
> > +=09TEST(move_mount(mfd, "", AT_FDCWD, MNTPOINT, MOVE_MOUNT_F_EMPTY_PAT=
H));
> > +=09if (TST_RET < 0) {
> > +=09=09tst_brk(TFAIL | TTERRNO, "move_mount attach to mount point");
> > +=09}
> > +=09is_mounted =3D 1;
> > +=09tst_res(TPASS, "move_mount attach to mount point");
> > +=09SAFE_CLOSE(mfd);
> > +
> > +=09if (ismount(MNTPOINT)) {
> > +=09=09tst_res(TPASS, "new mount works");
> > +=09=09TEST(tst_umount(MNTPOINT));
> > +=09=09if (TST_RET !=3D 0)
> > +=09=09=09tst_brk(TFAIL | TTERRNO, "umount failed");
> > +=09=09is_mounted =3D 0;
> cleanup also does umount operation. Maybe we can call it in here.
> > +=09} else {
> > +=09=09tst_res(TFAIL, "new mount fails");
> > +=09}
> > +}
> > +
> > +static struct tst_test test =3D {
> > +=09.test_all=09=3D test_newmount,
> > +=09.cleanup=09=3D cleanup,
> > +=09.needs_root=09=3D 1,
> > +=09.mntpoint=09=3D MNTPOINT,
> > +=09.needs_device=09=3D 1,
> In ltp library code, if you sepecify "format_device =3D 1", it will auto
> set "needs_device =3D 1". So remove it.
>=20
> > +=09.format_device=09=3D 1,
> > +=09.all_filesystems =3D 1,
> > +};
> >=20
>=20
>=20
>=20


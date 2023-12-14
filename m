Return-Path: <linux-fsdevel+bounces-6039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1C38129EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 09:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29D928263F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 08:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69EC15E96;
	Thu, 14 Dec 2023 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHJ+y3PU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF31EE0;
	Thu, 14 Dec 2023 00:03:43 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67f01b911c5so6406526d6.0;
        Thu, 14 Dec 2023 00:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702541023; x=1703145823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKrbI1xAKWbEcqudHvTK+osAC0pIMnz5+OHOQinRQHA=;
        b=jHJ+y3PUlVrZapEItmupJJvgHSa4NOirQJ4450Ofh4u9fuQk9OP/njU6PrhpwlcogJ
         1PyoS4Rif9o0pn/y8dIYR6qV3MJI6uXXImm4+BZo/FaCdg8jF7DQJ3Dkn2oqVOEIYFmL
         1e2MURTPowV8tARl6Zisc7PDpXHzbph/QnavRHPqeCW03jUjqosgIapyR3lcYCLR2IQ/
         jsS7S27Q5A/2MjUpi774uFFEXp4TtAEP23AgIqv2UTebURcDyY61l0+rBr1dygHRRcqQ
         5WE1P+08Z6SPBVlh5logEU7fLwpM68ZdfAbUwoux7wYcsoiXVBmQqAQkiDLnw7LtLHeY
         //Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702541023; x=1703145823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKrbI1xAKWbEcqudHvTK+osAC0pIMnz5+OHOQinRQHA=;
        b=pmUaWdBM0eyke5eZjvV6bl11+30r8gAjZq+X7PuoW3Cajp5EpcfO0v7q0eXf5NdjTb
         5iRrZpfB8YyJ0GfLFSK155R3SxXHbNpNsEIlkp461ePkLeGdqb3zAhDuPhT3eNpwLnzB
         0uHNLJb+jldOYP/dRj7NXx8iCLglGcmwCW3ldE0vP8rrWbJBrbYAVfGt/cL4tJluebTh
         ubUF1aw9qTCQZAI8+YC8up2wzfifx1RM9AAvgVJJ0Q0rKH4v12Ekm00WAT1hHpO4iaK+
         atgwbFxllyGtEZXPn42THFEXnnKMnNXgCpxnW0jP5NXcUvXYBf/hvns/7LMmkemn4EgL
         76ZA==
X-Gm-Message-State: AOJu0YxHAY43sBqQn7BzDAO8/9/zGNkjsQhKfV88GlkYw2YoikPl38S/
	atk/p0D0xvgsIDBp3K4WWteHK9o9IIEA1y5DGHU=
X-Google-Smtp-Source: AGHT+IHiiov80boeHkt0nMYOcwByWiEI5TZkBNJUCKkQV0ajqk43JpAoV2ZEpq8gQdCzhQJBjHP9u4z4rU8/5xWVx8A=
X-Received: by 2002:a05:6214:246d:b0:67f:e1d:af38 with SMTP id
 im13-20020a056214246d00b0067f0e1daf38mr183836qvb.50.1702541022813; Thu, 14
 Dec 2023 00:03:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214064439.1023011-1-avagin@google.com> <20231214064439.1023011-2-avagin@google.com>
In-Reply-To: <20231214064439.1023011-2-avagin@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 Dec 2023 10:03:31 +0200
Message-ID: <CAOQ4uxh4kbnFuYMK4fd=VTsu=up_FB7XFT5Jf0-a8QTAhLcC7Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/overlayfs: verify device and inode numbers
 in /proc/pid/maps
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	overlayfs <linux-unionfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 8:44=E2=80=AFAM Andrei Vagin <avagin@google.com> wr=
ote:
>
> When mapping a file on overlayfs, the file stored in ->vm_file is a
> backing file whose f_inode is on the underlying filesystem. We need to
> verify that /proc/pid/maps contains numbers of the overlayfs file, but
> not its backing file.
>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>
> Signed-off-by: Andrei Vagin <avagin@google.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  tools/testing/selftests/Makefile              |   1 +
>  .../filesystems/overlayfs/.gitignore          |   2 +
>  .../selftests/filesystems/overlayfs/Makefile  |   7 +
>  .../filesystems/overlayfs/dev_in_maps.c       | 182 ++++++++++++++++++
>  .../selftests/filesystems/overlayfs/log.h     |  26 +++
>  5 files changed, 218 insertions(+)
>  create mode 100644 tools/testing/selftests/filesystems/overlayfs/.gitign=
ore
>  create mode 100644 tools/testing/selftests/filesystems/overlayfs/Makefil=
e
>  create mode 100644 tools/testing/selftests/filesystems/overlayfs/dev_in_=
maps.c
>  create mode 100644 tools/testing/selftests/filesystems/overlayfs/log.h
>
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/M=
akefile
> index 3b2061d1c1a5..0939a40abb28 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -26,6 +26,7 @@ TARGETS +=3D filesystems
>  TARGETS +=3D filesystems/binderfs
>  TARGETS +=3D filesystems/epoll
>  TARGETS +=3D filesystems/fat
> +TARGETS +=3D filesystems/overlayfs
>  TARGETS +=3D firmware
>  TARGETS +=3D fpu
>  TARGETS +=3D ftrace
> diff --git a/tools/testing/selftests/filesystems/overlayfs/.gitignore b/t=
ools/testing/selftests/filesystems/overlayfs/.gitignore
> new file mode 100644
> index 000000000000..52ae618fdd98
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/overlayfs/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +dev_in_maps
> diff --git a/tools/testing/selftests/filesystems/overlayfs/Makefile b/too=
ls/testing/selftests/filesystems/overlayfs/Makefile
> new file mode 100644
> index 000000000000..56b2b48a765b
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/overlayfs/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_GEN_PROGS :=3D dev_in_maps
> +
> +CFLAGS :=3D -Wall -Werror
> +
> +include ../../lib.mk
> diff --git a/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c =
b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> new file mode 100644
> index 000000000000..e19ab0e85709
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/overlayfs/dev_in_maps.c
> @@ -0,0 +1,182 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +
> +#include <inttypes.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +
> +#include <linux/unistd.h>
> +#include <linux/types.h>
> +#include <linux/mount.h>
> +#include <sys/syscall.h>
> +#include <sys/stat.h>
> +#include <sys/mount.h>
> +#include <sys/mman.h>
> +#include <sched.h>
> +#include <fcntl.h>
> +
> +#include "../../kselftest.h"
> +#include "log.h"
> +
> +static int sys_fsopen(const char *fsname, unsigned int flags)
> +{
> +       return syscall(__NR_fsopen, fsname, flags);
> +}
> +
> +static int sys_fsconfig(int fd, unsigned int cmd, const char *key, const=
 char *value, int aux)
> +{
> +       return syscall(__NR_fsconfig, fd, cmd, key, value, aux);
> +}
> +
> +static int sys_fsmount(int fd, unsigned int flags, unsigned int attr_fla=
gs)
> +{
> +       return syscall(__NR_fsmount, fd, flags, attr_flags);
> +}
> +
> +static int sys_move_mount(int from_dfd, const char *from_pathname,
> +                         int to_dfd, const char *to_pathname,
> +                         unsigned int flags)
> +{
> +       return syscall(__NR_move_mount, from_dfd, from_pathname, to_dfd, =
to_pathname, flags);
> +}
> +
> +static long get_file_dev_and_inode(void *addr, struct statx *stx)
> +{
> +       char buf[4096];
> +       FILE *mapf;
> +
> +       mapf =3D fopen("/proc/self/maps", "r");
> +       if (mapf =3D=3D NULL)
> +               return pr_perror("fopen(/proc/self/maps)");
> +
> +       while (fgets(buf, sizeof(buf), mapf)) {
> +               unsigned long start, end;
> +               uint32_t maj, min;
> +               __u64 ino;
> +
> +               if (sscanf(buf, "%lx-%lx %*s %*s %x:%x %llu",
> +                               &start, &end, &maj, &min, &ino) !=3D 5)
> +                       return pr_perror("unable to parse: %s", buf);
> +               if (start =3D=3D (unsigned long)addr) {
> +                       stx->stx_dev_major =3D maj;
> +                       stx->stx_dev_minor =3D min;
> +                       stx->stx_ino =3D ino;
> +                       return 0;
> +               }
> +       }
> +
> +       return pr_err("unable to find the mapping");
> +}
> +
> +static int ovl_mount(void)
> +{
> +       int tmpfs, fsfd, ovl;
> +
> +       fsfd =3D sys_fsopen("tmpfs", 0);
> +       if (fsfd =3D=3D -1)
> +               return pr_perror("fsopen(tmpfs)");
> +
> +       if (sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0) =3D=3D=
 -1)
> +               return pr_perror("FSCONFIG_CMD_CREATE");
> +
> +       tmpfs =3D sys_fsmount(fsfd, 0, 0);
> +       if (tmpfs =3D=3D -1)
> +               return pr_perror("fsmount");
> +
> +       close(fsfd);
> +
> +       /* overlayfs can't be constructed on top of a detached mount. */
> +       if (sys_move_mount(tmpfs, "", AT_FDCWD, "/tmp", MOVE_MOUNT_F_EMPT=
Y_PATH))
> +               return pr_perror("move_mount");
> +       close(tmpfs);
> +
> +       if (mkdir("/tmp/w", 0755) =3D=3D -1 ||
> +           mkdir("/tmp/u", 0755) =3D=3D -1 ||
> +           mkdir("/tmp/l", 0755) =3D=3D -1)
> +               return pr_perror("mkdir");
> +
> +       fsfd =3D sys_fsopen("overlay", 0);
> +       if (fsfd =3D=3D -1)
> +               return pr_perror("fsopen(overlay)");
> +       if (sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "test", 0) =
=3D=3D -1 ||
> +           sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "lowerdir", "/tmp/l",=
 0) =3D=3D -1 ||
> +           sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "upperdir", "/tmp/u",=
 0) =3D=3D -1 ||
> +           sys_fsconfig(fsfd, FSCONFIG_SET_STRING, "workdir", "/tmp/w", =
0) =3D=3D -1)
> +               return pr_perror("fsconfig");
> +       if (sys_fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0) =3D=3D=
 -1)
> +               return pr_perror("fsconfig");
> +       ovl =3D sys_fsmount(fsfd, 0, 0);
> +       if (ovl =3D=3D -1)
> +               return pr_perror("fsmount");
> +
> +       return ovl;
> +}
> +
> +/*
> + * Check that the file device and inode shown in /proc/pid/maps match va=
lues
> + * returned by stat(2).
> + */
> +static int test(void)
> +{
> +       struct statx stx, mstx;
> +       int ovl, fd;
> +       void *addr;
> +
> +       ovl =3D ovl_mount();
> +       if (ovl =3D=3D -1)
> +               return -1;
> +
> +       fd =3D openat(ovl, "test", O_RDWR | O_CREAT, 0644);
> +       if (fd =3D=3D -1)
> +               return pr_perror("openat");
> +
> +       addr =3D mmap(NULL, 4096, PROT_READ | PROT_WRITE, MAP_FILE | MAP_=
SHARED, fd, 0);
> +       if (addr =3D=3D MAP_FAILED)
> +               return pr_perror("mmap");
> +
> +       if (get_file_dev_and_inode(addr, &mstx))
> +               return -1;
> +       if (statx(fd, "", AT_EMPTY_PATH | AT_STATX_SYNC_AS_STAT, STATX_IN=
O, &stx))
> +               return pr_perror("statx");
> +
> +       if (stx.stx_dev_major !=3D mstx.stx_dev_major ||
> +           stx.stx_dev_minor !=3D mstx.stx_dev_minor ||
> +           stx.stx_ino !=3D mstx.stx_ino)
> +               return pr_fail("unmatched dev:ino %x:%x:%llx (expected %x=
:%x:%llx)\n",
> +                       mstx.stx_dev_major, mstx.stx_dev_minor, mstx.stx_=
ino,
> +                       stx.stx_dev_major, stx.stx_dev_minor, stx.stx_ino=
);
> +
> +       ksft_test_result_pass("devices are matched\n");
> +       return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       int fsfd;
> +
> +       fsfd =3D sys_fsopen("overlay", 0);
> +       if (fsfd =3D=3D -1) {
> +               ksft_test_result_skip("unable to create overlay mount\n")=
;
> +               return 1;
> +       }
> +       close(fsfd);
> +
> +       /* Create a new mount namespace to not care about cleaning test m=
ounts. */
> +       if (unshare(CLONE_NEWNS) =3D=3D -1) {
> +               ksft_test_result_skip("unable to create a new mount names=
pace\n");
> +               return 1;
> +       }
> +
> +       if (mount(NULL, "/", NULL, MS_SLAVE | MS_REC, NULL) =3D=3D -1) {
> +               pr_perror("mount");
> +               return 1;
> +       }
> +
> +       ksft_set_plan(1);
> +
> +       if (test())
> +               return 1;
> +
> +       ksft_exit_pass();
> +       return 0;
> +}
> diff --git a/tools/testing/selftests/filesystems/overlayfs/log.h b/tools/=
testing/selftests/filesystems/overlayfs/log.h
> new file mode 100644
> index 000000000000..db64df2a8483
> --- /dev/null
> +++ b/tools/testing/selftests/filesystems/overlayfs/log.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __SELFTEST_TIMENS_LOG_H__
> +#define __SELFTEST_TIMENS_LOG_H__
> +
> +#define pr_msg(fmt, lvl, ...)                                          \
> +       ksft_print_msg("[%s] (%s:%d)\t" fmt "\n",                       \
> +                       lvl, __FILE__, __LINE__, ##__VA_ARGS__)
> +
> +#define pr_p(func, fmt, ...)   func(fmt ": %m", ##__VA_ARGS__)
> +
> +#define pr_err(fmt, ...)                                               \
> +       ({                                                              \
> +               ksft_test_result_error(fmt "\n", ##__VA_ARGS__);         =
       \
> +               -1;                                                     \
> +       })
> +
> +#define pr_fail(fmt, ...)                                      \
> +       ({                                                      \
> +               ksft_test_result_fail(fmt, ##__VA_ARGS__);      \
> +               -1;                                             \
> +       })
> +
> +#define pr_perror(fmt, ...)    pr_p(pr_err, fmt, ##__VA_ARGS__)
> +
> +#endif
> --
> 2.43.0.472.g3155946c3a-goog
>


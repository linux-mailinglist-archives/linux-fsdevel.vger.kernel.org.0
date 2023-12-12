Return-Path: <linux-fsdevel+bounces-5616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB1E80E397
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 06:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064A81F21EC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 05:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1576511719;
	Tue, 12 Dec 2023 05:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6ZcvW6T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F91CE;
	Mon, 11 Dec 2023 21:17:24 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77f44cd99c6so360950785a.0;
        Mon, 11 Dec 2023 21:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702358244; x=1702963044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YD/9513lMc2HvL8P0k7L3vQlESrpCHMiKxv6xcYrY1I=;
        b=Q6ZcvW6TiC5gYftchXWUmiBIwwCdq4Qh3rWRcIE4jN3KioLhuwKF/5flFO4+r62TQk
         f0hUQF/VY3hbEfDuBrQeDMElOf2MaBqQkXi03sh4GvcTstIPJegrnmhpdKbmx2B93s9r
         0EI0lXksQSR82RIpaz2EDV/00zmX1qBxnGdfilzCZ4WWq4OfAbfeXixRMHx3011shqQA
         1v0OE+cXq5Q39PDFStwNzA3kCAoVlMZs54vxbr8wSS8ovZcxptW/ZMRKi5CY50oLUH6u
         h79kfNuwfFhKsgtTAjlF3i3YiUH+uqFO5x6ovWex3GuxEYgwbovLjKBkXoHF1hlppPvb
         H+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702358244; x=1702963044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YD/9513lMc2HvL8P0k7L3vQlESrpCHMiKxv6xcYrY1I=;
        b=FkC/jjx6AOUtFl52TAj+xKm9AyZM5ZB6QmmgHMVDO/GDp1SMREHpULvTd7qa3//I92
         l55yGeNFVmWCD0S2zr5XXkQr2bxE5FCU+05iL7C9A3cPvxsjBu+E/9TUbOLIYrEIGGzL
         NrBJcr3cquEuqE7XjvqUvff285QYRAaYtT6uw0JSHrk8cm8lZ3Ff1RydETGuAgRQJCRi
         EW6QLr7c7B0cGewRN6c1hfJOGgGxlPamRbVKK1xtxeYrp5VD4/uFg4r6tsNC7Lbm3aba
         ihy9Zv/Nk+xVr9XaBBE09kwiVXdur9L95cbyXNCrKDwwgjkJdR41xQVIjgihv2rGrQZp
         Q1nw==
X-Gm-Message-State: AOJu0Yw/N+oemr9Ib8GIOp3huwnv7SoXRoIofkr19cf/tBvIKDAH2Bqc
	oShNhSdeF1FNEieujseWt7Ge08losFHSWD8L3Rs=
X-Google-Smtp-Source: AGHT+IE/ecgDzGI+LZYye82qUJWm+mcX8rIZZUVScTeNXHaHdNYX0Zi34b5EW2q9RFLMcz/BcgzXwP0li6e9jdBkoSk=
X-Received: by 2002:a05:620a:6d08:b0:77e:fbba:645a with SMTP id
 ul8-20020a05620a6d0800b0077efbba645amr7660694qkn.57.1702358243751; Mon, 11
 Dec 2023 21:17:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231211193048.580691-1-avagin@google.com> <20231211193048.580691-2-avagin@google.com>
In-Reply-To: <20231211193048.580691-2-avagin@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 12 Dec 2023 07:17:12 +0200
Message-ID: <CAOQ4uxgFGLJPQfvHV+6Yoexj-uEYM2ur5Dau7YySczN3-RwJnQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/overlayfs: verify device and inode numbers
 in /proc/pid/maps
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+fsdevel, +brauner

On Mon, Dec 11, 2023 at 9:30=E2=80=AFPM Andrei Vagin <avagin@google.com> wr=
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

Thanks for the fix and test.

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
> index 000000000000..08497c2e10a3
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
> +               if (sscanf(buf, "%lx-%lx %*s %*s %x:%x %llx",
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


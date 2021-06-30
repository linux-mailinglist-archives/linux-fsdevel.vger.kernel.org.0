Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6152A3B7C53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 05:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhF3EBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 00:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhF3EBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 00:01:46 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A46C061766;
        Tue, 29 Jun 2021 20:58:57 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h3so1520143ilc.9;
        Tue, 29 Jun 2021 20:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=th6quUd6v7Hy/uJAwOnXdzKJEOL7XC5IXy2fKLMMsQs=;
        b=dc9MBvMbnXQzuFWx6AEdAIWUxb0E6cSDOP8h2JKOcogu2ANQJCxu43Uhh5LVgxJxN8
         EoSqXhEZ3rCnudG8yfSU1ENe9UrBw8xGuBgsRgGEADd6yZvW8Ctitscx4pHT3e/mfIYJ
         TUwx15roycQC4XPdDK52cY/3HQpUgn9cQxFfJwLy2SCU8dKLbkrMm4rPfxuNr0Cl/t5C
         ekGKPXjUTOpwAQ5v/RMhG/M5dPLsuqtH9BEgAXPk1oMkGgC5V44icrzCNnfuqNywxOGG
         yL5CfvA1QiBYdHwbVRe9H86WOrzv47xmJ/vwyJHRnfZf1Fx6/rK8geLpxqFPvA/5DEg8
         Earg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=th6quUd6v7Hy/uJAwOnXdzKJEOL7XC5IXy2fKLMMsQs=;
        b=WqHsMViB850h7kcdKhZSQ/xUT76RiJpAk6IlXvmKyzemy9xigRKTl6ulCFuB7qmnRD
         5IcET/s8EzRgR4dP32akabYnIlUCRjoeNYS2kt1ZF3B07QjdT3Arh8FMsbKro4eY7ztT
         6bu3haxOLcpR9etcUAsIfxRHH+Nxl65yA2DLXkzlrcr5h0LJJqqJ4DZkyc/o2R4ijyAT
         qvF5+KaxkeWo9qqr3HiDAsjeXVRm0SwjGFkB815+X5Xt9Vq76Wg32uobtNOH+QOwTh4I
         JBFS478tdo8oNg8a89nl5UWNss/cuyfwbB7s0Jfs+U0sSP6KxfPABuGgFpBSP49otCGI
         as0w==
X-Gm-Message-State: AOAM5337epPzmxYSACdK1/sZFrt0HAm6E/rHdjp2hZybSq+RpfbtAFxi
        9scbe23ErbR8U3MWQ/k4J6W8jATIhXAMQy7lMEg=
X-Google-Smtp-Source: ABdhPJwNR7pALV+ElVafhtBlomdmHNvyS5tpGerzA5pMtyhAULugqw+kzdKfCmlDbyCsA2H2w9o6RGj3zVNDdbovr7I=
X-Received: by 2002:a92:dd05:: with SMTP id n5mr13903099ilm.72.1625025536411;
 Tue, 29 Jun 2021 20:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-1-krisman@collabora.com> <20210629191035.681913-15-krisman@collabora.com>
In-Reply-To: <20210629191035.681913-15-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 06:58:45 +0300
Message-ID: <CAOQ4uxieFwrz-C9GbbxCnOFazkTY=F7N253GDuv6eyjYg0n+jQ@mail.gmail.com>
Subject: Re: [PATCH v3 14/15] samples: Add fs error monitoring example
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 10:13 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Introduce an example of a FAN_FS_ERROR fanotify user to track filesystem
> errors.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>
> ---
> Changes since v1:
>   - minor fixes
> ---
>  samples/Kconfig               |   9 +++
>  samples/Makefile              |   1 +
>  samples/fanotify/Makefile     |   3 +
>  samples/fanotify/fs-monitor.c | 134 ++++++++++++++++++++++++++++++++++
>  4 files changed, 147 insertions(+)
>  create mode 100644 samples/fanotify/Makefile
>  create mode 100644 samples/fanotify/fs-monitor.c
>
> diff --git a/samples/Kconfig b/samples/Kconfig
> index b5a1a7aa7e23..f2f9c939035f 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -120,6 +120,15 @@ config SAMPLE_CONNECTOR
>           with it.
>           See also Documentation/driver-api/connector.rst
>
> +config SAMPLE_FANOTIFY_ERROR
> +       bool "Build fanotify error monitoring sample"
> +       depends on FANOTIFY
> +       help
> +         When enabled, this builds an example code that uses the
> +         FAN_FS_ERROR fanotify mechanism to monitor filesystem
> +         errors.
> +         See also Documentation/admin-guide/filesystem-monitoring.rst.
> +
>  config SAMPLE_HIDRAW
>         bool "hidraw sample"
>         depends on CC_CAN_LINK && HEADERS_INSTALL
> diff --git a/samples/Makefile b/samples/Makefile
> index 087e0988ccc5..931a81847c48 100644
> --- a/samples/Makefile
> +++ b/samples/Makefile
> @@ -5,6 +5,7 @@ subdir-$(CONFIG_SAMPLE_AUXDISPLAY)      += auxdisplay
>  subdir-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs
>  obj-$(CONFIG_SAMPLE_CONFIGFS)          += configfs/
>  obj-$(CONFIG_SAMPLE_CONNECTOR)         += connector/
> +obj-$(CONFIG_SAMPLE_FANOTIFY_ERROR)    += fanotify/
>  subdir-$(CONFIG_SAMPLE_HIDRAW)         += hidraw
>  obj-$(CONFIG_SAMPLE_HW_BREAKPOINT)     += hw_breakpoint/
>  obj-$(CONFIG_SAMPLE_KDB)               += kdb/
> diff --git a/samples/fanotify/Makefile b/samples/fanotify/Makefile
> new file mode 100644
> index 000000000000..b3d5cc826e6f
> --- /dev/null
> +++ b/samples/fanotify/Makefile
> @@ -0,0 +1,3 @@
> +userprogs-always-y += fs-monitor
> +
> +userccflags += -I usr/include
> diff --git a/samples/fanotify/fs-monitor.c b/samples/fanotify/fs-monitor.c
> new file mode 100644
> index 000000000000..f949ea00271d
> --- /dev/null
> +++ b/samples/fanotify/fs-monitor.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2021, Collabora Ltd.
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>

Kernel test robot reported some problem with this include

> +#include <err.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <fcntl.h>
> +#include <sys/fanotify.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +
> +#ifndef FAN_FS_ERROR
> +#define FAN_FS_ERROR           0x00008000
> +#define FAN_EVENT_INFO_TYPE_ERROR      4
> +
> +int mount_fd;
> +
> +struct fanotify_event_info_error {
> +       struct fanotify_event_info_header hdr;
> +       __s32 error;
> +       __u32 error_count;
> +};
> +#endif
> +
> +static void handle_notifications(char *buffer, int len)
> +{
> +       struct fanotify_event_metadata *metadata;
> +       struct fanotify_event_info_error *error;
> +       struct fanotify_event_info_fid *fid;
> +       struct file_handle *file_handle;
> +       int bad_file;
> +       int ret;
> +       struct stat stat;
> +       char *next;
> +
> +       for (metadata = (struct fanotify_event_metadata *) buffer;
> +            FAN_EVENT_OK(metadata, len);
> +            metadata = FAN_EVENT_NEXT(metadata, len)) {
> +               next = (char *)metadata + metadata->event_len;
> +               if (metadata->mask != FAN_FS_ERROR) {
> +                       printf("unexpected FAN MARK: %llx\n", metadata->mask);
> +                       goto next_event;
> +               } else if (metadata->fd != FAN_NOFD) {
> +                       printf("Unexpected fd (!= FAN_NOFD)\n");
> +                       goto next_event;
> +               }
> +
> +               printf("FAN_FS_ERROR found len=%d\n", metadata->event_len);
> +
> +               error = (struct fanotify_event_info_error *) (metadata+1);
> +               if (error->hdr.info_type != FAN_EVENT_INFO_TYPE_ERROR) {
> +                       printf("unknown record: %d (Expecting TYPE_ERROR)\n",
> +                              error->hdr.info_type);
> +                       goto next_event;
> +               }
> +
> +               printf("\tGeneric Error Record: len=%d\n", error->hdr.len);
> +               printf("\terror: %d\n", error->error);
> +               printf("\terror_count: %d\n", error->error_count);
> +
> +               fid = (struct fanotify_event_info_fid *) (error + 1);
> +
> +               if ((char *) fid >= next) {
> +                       printf("Event doesn't have FID\n");
> +                       goto next_event;
> +               }
> +               printf("FID record found\n");
> +
> +               if (fid->hdr.info_type != FAN_EVENT_INFO_TYPE_FID) {
> +                       printf("unknown record: %d (Expecting TYPE_FID)\n",
> +                              fid->hdr.info_type);
> +                       goto next_event;
> +               }
> +               printf("\tfsid: %x%x\n", fid->fsid.val[0], fid->fsid.val[1]);
> +
> +
> +               file_handle = (struct file_handle *) &fid->handle;
> +               bad_file = open_by_handle_at(mount_fd, file_handle,  O_PATH);

I would not recommend in this practice at all  and in a sample program
in particular.

While FID is mean to to be used as input for open_by_handle_at()
with "regular" events, with error events FID may belong to a corrupt
inode that cannot be opened, a filesystem that is already shutdown
due to error or point to irrelevant root inode.

I suggest that you stick to printing the FID value.

A filesystem monitoring tool will typically know which filesystem it is
watching and it will be easy for it to parse the inode and generation
out of the FID.

In fact, if the handle_type is the generic type FILEID_INO32_GEN
and handle_bytes is 8, it is safe for this sample fs-monitor to parse the
FID as <32bit ino; 32bit gen> and print those parsed values
worst case the values will be wrong.

Thanks,
Amir.

> +               if (bad_file < 0) {
> +                       printf("open_by_handle_at %d\n", errno);
> +                       goto next_event;
> +               }
> +
> +               ret = fstat(bad_file, &stat);
> +               if (ret < 0)
> +                       printf("fstat %d\n", errno);
> +
> +               printf("\tinode=%ld\n", stat.st_ino);
> +
> +next_event:
> +               printf("---\n\n");
> +       }
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       int fd;
> +       char buffer[BUFSIZ];
> +
> +       if (argc < 2) {
> +               printf("Missing path argument\n");
> +               return 1;
> +       }
> +
> +       mount_fd = open(argv[1], O_RDONLY);
> +       if (mount_fd < 0)
> +               errx(1, "mount_fd");
> +
> +       fd = fanotify_init(FAN_CLASS_NOTIF|FAN_REPORT_FID, O_RDONLY);
> +       if (fd < 0)
> +               errx(1, "fanotify_init");
> +
> +       if (fanotify_mark(fd, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
> +                         FAN_FS_ERROR, AT_FDCWD, argv[1])) {
> +               errx(1, "fanotify_mark");
> +       }
> +
> +       while (1) {
> +               int n = read(fd, buffer, BUFSIZ);
> +
> +               if (n < 0)
> +                       errx(1, "read");
> +
> +               handle_notifications(buffer, n);
> +       }
> +
> +       return 0;
> +}
> --
> 2.32.0
>

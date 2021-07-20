Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277473CFFE5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhGTQYf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 12:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbhGTQYC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 12:24:02 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2942C061574;
        Tue, 20 Jul 2021 10:04:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l6so12713516wmq.0;
        Tue, 20 Jul 2021 10:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBQQzstrJ1gYNrT0Melpe4vYPm4Di0XzvV/ACAiV8dU=;
        b=Yl97JjlTnSH/4anBuNe+rxIvT4hdPRd9J9mKU5DfoZdNCGP6C8dsC0OvrJUeVbMEMb
         wWxtdyr1piIqB9WvgwvcJhK89EdxzV4Jy73kTESHnBgRw7WgKKp/uqQSTSbiBWlfZQlc
         ULoJ2dI6Bm4fLn2NiFbW5WZNnWo7DTlJB2pDx7hLqJLKtkzufaswOvi5fMHrkU3TLG9j
         qIXgE6SkYF2uo2PT3Sxn61Te1sozED1NeNA4+Y/6ZslhF9TUlD9MMPD2WqNnjrRIW7qZ
         b3kjK1UmPnqvZQbnwLrwo5yDNzWHcJscfMn9aSsQILSMKqqE+JTrlOXrSpHhi2z4wNlU
         jk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBQQzstrJ1gYNrT0Melpe4vYPm4Di0XzvV/ACAiV8dU=;
        b=lYYK343d1Hyf895/YJPr5P4tbvfcLGpY7js8y52pdHYFdlpByYlCqhXoaxmTWC+e88
         O+8thfzZ5y9eoGm5fOYsLuhEB0ynb5k1amrT3Yh4WVdNd2Dd6a3GyeizDGd9/S0t9Er0
         4qhUpsXF1OY/5OC2EKwodvIiVgJE/wAFKYR/d4GjUNA83b8i6DFfoDq+nWriJrjh1ANy
         /1r2Bd2ZpGJaQ30EKMgeUvChq5FnT42VrN+XhNR85hlUILF2p5IxSNv2WT8qYxeBIV/o
         Hc5monMCGyxKxyQ5ZcKCl1jutK7mmwfPlgF6+lYV74MUno8QKFTEOaNvtrS5a/fhDfnp
         kFbQ==
X-Gm-Message-State: AOAM530dpHNTsZFdYV6EkeJqT88NhLv2IePFY6zyPBV79VTvSEfWFaxm
        sNyloL2QqGGgi+oD8qaGyBXwOO0mSmW8jjsv6tw=
X-Google-Smtp-Source: ABdhPJxvDJO2Z2acCPBQtmhGcr6JO51jgSOCM7nqjcv55yHELU2G7JdJj4hFhw+HzJ++aRM1L4fCenbPc/uuNenAkAA=
X-Received: by 2002:a05:600c:4a17:: with SMTP id c23mr38876425wmp.50.1626800673826;
 Tue, 20 Jul 2021 10:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210720155944.1447086-1-krisman@collabora.com> <20210720155944.1447086-16-krisman@collabora.com>
In-Reply-To: <20210720155944.1447086-16-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 20 Jul 2021 20:04:22 +0300
Message-ID: <CAOQ4uxhF-HxTefqKFMyC2tUVDv_g+u109M36=xw+2CA55jiNiQ@mail.gmail.com>
Subject: Re: [PATCH v4 15/16] samples: Add fs error monitoring example
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 20, 2021 at 7:00 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Introduce an example of a FAN_FS_ERROR fanotify user to track filesystem
> errors.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

except for one small nit

> ---
> Changes since v1:
>   - minor fixes
> ---
>  samples/Kconfig               |   9 +++
>  samples/Makefile              |   1 +
>  samples/fanotify/Makefile     |   5 ++
>  samples/fanotify/fs-monitor.c | 134 ++++++++++++++++++++++++++++++++++
>  4 files changed, 149 insertions(+)
>  create mode 100644 samples/fanotify/Makefile
>  create mode 100644 samples/fanotify/fs-monitor.c
>
> diff --git a/samples/Kconfig b/samples/Kconfig
> index b0503ef058d3..88353b8eac0b 100644
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
> index 000000000000..e20db1bdde3b
> --- /dev/null
> +++ b/samples/fanotify/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +userprogs-always-y += fs-monitor
> +
> +userccflags += -I usr/include -Wall
> +
> diff --git a/samples/fanotify/fs-monitor.c b/samples/fanotify/fs-monitor.c
> new file mode 100644
> index 000000000000..ff74ba077f34
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
> +#define FILEID_INO32_GEN       1
> +#define        FILEID_INVALID          0xff

If you install the kernel uapi header and try to build this
sample it will fail because FAN_FS_ERROR will be
defined but FILEID_INO32_GEN and FILEID_INVALID
will not be defined.

Thanks,
Amir.

> +
> +struct fanotify_event_info_error {
> +       struct fanotify_event_info_header hdr;
> +       __s32 error;
> +       __u32 error_count;
> +};
> +#endif
> +
> +static void print_fh(struct file_handle *fh)
> +{
> +       int i;
> +       uint32_t *h = (uint32_t *) fh->f_handle;
> +
> +       printf("\tfh: ");
> +       for (i = 0; i < fh->handle_bytes; i++)
> +               printf("%hhx", fh->f_handle[i]);
> +       printf("\n");
> +
> +       printf("\tdecoded fh: ");
> +       if (fh->handle_type == FILEID_INO32_GEN)
> +               printf("inode=%u gen=%u\n", h[0], h[1]);
> +       else if (fh->handle_type == FILEID_INVALID && !h[0] && !h[1])
> +               printf("Type %d (Superblock error)\n", fh->handle_type);
> +       else
> +               printf("Type %d (Unknown)\n", fh->handle_type);
> +
> +}
> +
> +static void handle_notifications(char *buffer, int len)
> +{
> +       struct fanotify_event_metadata *metadata;
> +       struct fanotify_event_info_error *error;
> +       struct fanotify_event_info_fid *fid;
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
> +               print_fh((struct file_handle *) &fid->handle);
> +
> +next_event:
> +               printf("---\n\n");
> +       }
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       int fd;
> +
> +       char buffer[BUFSIZ];
> +
> +       if (argc < 2) {
> +               printf("Missing path argument\n");
> +               return 1;
> +       }
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

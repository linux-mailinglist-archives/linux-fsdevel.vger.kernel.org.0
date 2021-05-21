Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5FE38C3CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 11:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhEUJuO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 05:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234447AbhEUJtz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 05:49:55 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF09C06138A;
        Fri, 21 May 2021 02:48:30 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d25so7743468ioe.1;
        Fri, 21 May 2021 02:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u3mHUsZVQJ0deEekncWZ5mQlfQua2MgWLj+CLXrJiGY=;
        b=YDcJDX8zEE4aSZjfkc36+f56g0Ln9ZZlWJP6hiOqvonPAogaVjNtJgS52ct7wgcynO
         fUdPu6O51TeuwosUxpS6+BSyRbEnr/z/05p8vq2cl7gb0/3iUVn3GXiEGDBw6rS1QQZi
         H1rbDmsMvCr5+p1S28dRcnWcONMrcpBCK+qekXaQDIh2x7SVcIuechNJTSbDVaOh25NU
         IRV11LqeZtfUMXHl7acU7KTYoViRMuL5JvOyzFQaJQV6xhy+hMcspizud7IfClE9aSVl
         FRtG8R7Pk7MfUF9/FJecY9BTImcfNl5TpMg1ytNXZ5bzNG7RRLA9TrkcCmIBnTwLW7pP
         JjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3mHUsZVQJ0deEekncWZ5mQlfQua2MgWLj+CLXrJiGY=;
        b=gfRfSD7LoGMe14OF2rTVWM6j2zaxqMashDW3Ek0D2HrPgBNXmjIeKwrW/+Rca37Mm0
         kw3Fn8lsoFC2LF3y6voPIymKIC9MUdmvC4NTY/UWnb082/m2zKgQKDfpI+/hfqUsMn9p
         0IyLnmMSj0d6Iyf4FKJs1hnLSm9WfQSDBdXhgY5GiJVe6OuUQAZar+kVMO4Z5fGC92c1
         UPMyH5ELyUSqtGWtW1S7zQGq+TGVMWFqnOyx+k7f6Novfqdx/Sj72BI15eTItGusMsDN
         Mq7ica77ocwKHF8A9eovXiloWX1D02T+wJ1IWCPB65MS2V5Tx//Jhg+lu81r6aB67pic
         RScw==
X-Gm-Message-State: AOAM533DQqke60ejTS+PW9FpkKs4MKp35L1mYPFMcxobUtUTP9TPvNra
        MGLcg9VC/2cBnPozWD0NNfMuuLIfGqTNigursEO/dDfTHlU=
X-Google-Smtp-Source: ABdhPJzaD+3Xa3OX0Go+e4ebQo7OCFX+Bya+ybouHelz2SyDP6rWrj1CiorcjPKtv0T4vhSFkRL9glds0MVQRlw4lVM=
X-Received: by 2002:a02:3505:: with SMTP id k5mr3240474jaa.123.1621590509890;
 Fri, 21 May 2021 02:48:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210521024134.1032503-1-krisman@collabora.com> <20210521024134.1032503-11-krisman@collabora.com>
In-Reply-To: <20210521024134.1032503-11-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 May 2021 12:48:18 +0300
Message-ID: <CAOQ4uxjk9K-yOyn4EAPjP_WK5UaCbcOGX4joH3futSCVTXZ76g@mail.gmail.com>
Subject: Re: [PATCH 10/11] samples: Add fs error monitoring example
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 5:42 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Introduce an example of a FAN_ERROR fanotify user to track filesystem
> errors.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  samples/Kconfig               |  8 +++
>  samples/Makefile              |  1 +
>  samples/fanotify/Makefile     |  3 ++
>  samples/fanotify/fs-monitor.c | 91 +++++++++++++++++++++++++++++++++++
>  4 files changed, 103 insertions(+)
>  create mode 100644 samples/fanotify/Makefile
>  create mode 100644 samples/fanotify/fs-monitor.c
>
> diff --git a/samples/Kconfig b/samples/Kconfig
> index b5a1a7aa7e23..e421556ec3e5 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -120,6 +120,14 @@ config SAMPLE_CONNECTOR
>           with it.
>           See also Documentation/driver-api/connector.rst
>
> +config SAMPLE_FANOTIFY_ERROR
> +       bool "Build fanotify error monitoring sample"
> +       depends on FANOTIFY
> +       help
> +         When enabled, this builds an example code that uses the FAN_ERROR
> +         fanotify mechanism to monitor filesystem errors.
> +         Documentation/admin-guide/filesystem-monitoring.rst
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
> index 000000000000..49d3e2a872e4
> --- /dev/null
> +++ b/samples/fanotify/fs-monitor.c
> @@ -0,0 +1,91 @@
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
> +#ifndef FAN_ERROR
> +#define FAN_ERROR              0x00008000
> +#define FAN_EVENT_INFO_TYPE_ERROR      5
> +
> +struct fanotify_event_info_error {
> +       struct fanotify_event_info_header hdr;
> +       int error;
> +       __kernel_fsid_t fsid;
> +       unsigned long inode;
> +       __u32 error_count;
> +};
> +#endif
> +
> +static void handle_notifications(char *buffer, int len)
> +{
> +       struct fanotify_event_metadata *metadata;
> +       struct fanotify_event_info_error *error;
> +
> +       for (metadata = (struct fanotify_event_metadata *) buffer;
> +            FAN_EVENT_OK(metadata, len); metadata = FAN_EVENT_NEXT(metadata, len)) {
> +               if (!(metadata->mask == FAN_ERROR)) {

Nit: != FAN_ERROR

> +                       printf("unexpected FAN MARK: %llx\n", metadata->mask);
> +                       continue;
> +               } else if (metadata->fd != FAN_NOFD) {
> +                       printf("Unexpected fd (!= FAN_NOFD)\n");
> +                       continue;
> +               }
> +
> +               printf("FAN_ERROR found len=%d\n", metadata->event_len);
> +
> +               error = (struct fanotify_event_info_error *) (metadata+1);
> +               if (error->hdr.info_type == FAN_EVENT_INFO_TYPE_ERROR) {

You meant != FAN_EVENT_INFO_TYPE_ERROR ?

> +                       printf("unknown record: %d\n", error->hdr.info_type);
> +                       continue;
> +               }
> +
> +               printf("  Generic Error Record: len=%d\n", error->hdr.len);
> +               printf("      fsid: %llx\n", error->fsid);
> +               printf("      error: %d\n", error->error);
> +               printf("      inode: %lu\n", error->inode);
> +               printf("      error_count: %d\n", error->error_count);
> +       }
> +}
> +
> +int main(int argc, char **argv)
> +{
> +       int fd;
> +       char buffer[BUFSIZ];

BUFSIZ not defined?

> +
> +       if (argc < 2) {
> +               printf("Missing path argument\n");
> +               return 1;
> +       }
> +
> +       fd = fanotify_init(FAN_CLASS_NOTIF, O_RDONLY);
> +       if (fd < 0)
> +               errx(1, "fanotify_init");
> +
> +       if (fanotify_mark(fd, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
> +                         FAN_ERROR, AT_FDCWD, argv[1])) {
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
> 2.31.0
>

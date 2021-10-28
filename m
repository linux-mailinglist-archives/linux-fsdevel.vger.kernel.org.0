Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A496343E4E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 17:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhJ1PVG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 11:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJ1PVF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 11:21:05 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4DAC061570;
        Thu, 28 Oct 2021 08:18:38 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id t17-20020a056830083100b00553ced10177so8861527ots.1;
        Thu, 28 Oct 2021 08:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VJhW3swgBV+e/gPkZrrlygFChJb/4eQSGwAUsc4yYHM=;
        b=kM+o+lvXLkhtZ/TWaNyhlfC+QPzPsxLJw6pWBGN2l5rFGth4OxlxrNtNz0nxgt4O4R
         zLDGbPv+b7a7f5u9IvaTKFSTglniM9lbFi34TpPH3fTap+7OgDITMO8EGVyyX1Dv8Vu4
         vv89hlq7Fx8YIVURbEUFejv8140hJ24ICyLbaoExee2/bUiUOY4IxLk8jjMAE17lMum+
         eZxAWsgTcKVqxXvsTLzrxhnmye2zgLgMqaY4A5zyZwaKLW89uL5jK7sJS6I4yOWsO7++
         umnsB3U7xkqqXV8Y8KLioopljgWTeZmnnS/tbm2XcmpYQMByGWvZaTtix/TrfWyQI3gV
         cNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=VJhW3swgBV+e/gPkZrrlygFChJb/4eQSGwAUsc4yYHM=;
        b=eY7g5POXUUMoXxAcQW4LbbU7EuqxLcczYdNG6worDa4rNlsbXnK698DfzKg91/Wkx4
         ok1yfZ2GJS5cola6fyk4ikTH2t+otMU1RSF2IwteTVeKHk1VHU97WGyUZO1c40GtsC/Q
         RhAUwf4f9V3BOoE53qKWZU5OKhrMzCAwemRFSJ+EtjNDb40i9XMNXcqfzIeR75vdJ6C+
         btpelANOVzI8JKT8cs0k8bAOhhDuubccSOWE5DjaGqL0rvR4TXKj4AeIr/VHsYbYin43
         3TcRdemDv6L1f+ttbcGt+xDDC1NjccPE0qopiC0ovAfjwNcuiroJAAC5Jj+55Lg4LpCn
         cmRQ==
X-Gm-Message-State: AOAM532ij8A0jfOCQ0fAjs2Abk6LEpT5hA337Hsd+L5yNhn5QccwZlUY
        zJlGMIN8ox521oa57Mv+vyE=
X-Google-Smtp-Source: ABdhPJx7L5WhDXKOrx76GdgOzmyhJZDBw+lJJlrTc2k1xINSNa99Tn2hxGIplXHzXSzsH90EmRjlKQ==
X-Received: by 2002:a05:6830:4002:: with SMTP id h2mr3947695ots.49.1635434316794;
        Thu, 28 Oct 2021 08:18:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h26sm998344oov.28.2021.10.28.08.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 08:18:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 28 Oct 2021 08:18:34 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, djwong@kernel.org,
        tytso@mit.edu, david@fromorbit.com, dhowells@redhat.com,
        khazhy@google.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-api@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v8 31/32] samples: Add fs error monitoring example
Message-ID: <20211028151834.GA423440@roeck-us.net>
References: <20211019000015.1666608-1-krisman@collabora.com>
 <20211019000015.1666608-32-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019000015.1666608-32-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 18, 2021 at 09:00:14PM -0300, Gabriel Krisman Bertazi wrote:
> Introduce an example of a FAN_FS_ERROR fanotify user to track filesystem
> errors.
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> Reviewed-by: Jan Kara <jack@suse.cz>
> ---
> Changes since v4:
>   - Protect file_handle defines with ifdef guards
> 
> Changes since v1:
>   - minor fixes
> ---
>  samples/Kconfig               |   9 +++
>  samples/Makefile              |   1 +
>  samples/fanotify/Makefile     |   5 ++
>  samples/fanotify/fs-monitor.c | 142 ++++++++++++++++++++++++++++++++++
>  4 files changed, 157 insertions(+)
>  create mode 100644 samples/fanotify/Makefile
>  create mode 100644 samples/fanotify/fs-monitor.c
> 
> diff --git a/samples/Kconfig b/samples/Kconfig
> index b0503ef058d3..88353b8eac0b 100644
> --- a/samples/Kconfig
> +++ b/samples/Kconfig
> @@ -120,6 +120,15 @@ config SAMPLE_CONNECTOR
>  	  with it.
>  	  See also Documentation/driver-api/connector.rst
>  
> +config SAMPLE_FANOTIFY_ERROR
> +	bool "Build fanotify error monitoring sample"
> +	depends on FANOTIFY

This needs something like
	depends on CC_CAN_LINK
or possibly even
	depends on CC_CAN_LINK && HEADERS_INSTALL
to avoid compilation errors such as

samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file or directory
    7 | #include <errno.h>
      |          ^~~~~~~~~
compilation terminated.

when using a toolchain without C library support, such as those provided
on kernel.org.

Guenter

> +	help
> +	  When enabled, this builds an example code that uses the
> +	  FAN_FS_ERROR fanotify mechanism to monitor filesystem
> +	  errors.
> +	  See also Documentation/admin-guide/filesystem-monitoring.rst.
> +
>  config SAMPLE_HIDRAW
>  	bool "hidraw sample"
>  	depends on CC_CAN_LINK && HEADERS_INSTALL
> diff --git a/samples/Makefile b/samples/Makefile
> index 087e0988ccc5..931a81847c48 100644
> --- a/samples/Makefile
> +++ b/samples/Makefile
> @@ -5,6 +5,7 @@ subdir-$(CONFIG_SAMPLE_AUXDISPLAY)	+= auxdisplay
>  subdir-$(CONFIG_SAMPLE_ANDROID_BINDERFS) += binderfs
>  obj-$(CONFIG_SAMPLE_CONFIGFS)		+= configfs/
>  obj-$(CONFIG_SAMPLE_CONNECTOR)		+= connector/
> +obj-$(CONFIG_SAMPLE_FANOTIFY_ERROR)	+= fanotify/
>  subdir-$(CONFIG_SAMPLE_HIDRAW)		+= hidraw
>  obj-$(CONFIG_SAMPLE_HW_BREAKPOINT)	+= hw_breakpoint/
>  obj-$(CONFIG_SAMPLE_KDB)		+= kdb/
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
> index 000000000000..a0e44cd31e6f
> --- /dev/null
> +++ b/samples/fanotify/fs-monitor.c
> @@ -0,0 +1,142 @@
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
> +#include <sys/types.h>
> +
> +#ifndef FAN_FS_ERROR
> +#define FAN_FS_ERROR		0x00008000
> +#define FAN_EVENT_INFO_TYPE_ERROR	5
> +
> +struct fanotify_event_info_error {
> +	struct fanotify_event_info_header hdr;
> +	__s32 error;
> +	__u32 error_count;
> +};
> +#endif
> +
> +#ifndef FILEID_INO32_GEN
> +#define FILEID_INO32_GEN	1
> +#endif
> +
> +#ifndef FILEID_INVALID
> +#define	FILEID_INVALID		0xff
> +#endif
> +
> +static void print_fh(struct file_handle *fh)
> +{
> +	int i;
> +	uint32_t *h = (uint32_t *) fh->f_handle;
> +
> +	printf("\tfh: ");
> +	for (i = 0; i < fh->handle_bytes; i++)
> +		printf("%hhx", fh->f_handle[i]);
> +	printf("\n");
> +
> +	printf("\tdecoded fh: ");
> +	if (fh->handle_type == FILEID_INO32_GEN)
> +		printf("inode=%u gen=%u\n", h[0], h[1]);
> +	else if (fh->handle_type == FILEID_INVALID && !fh->handle_bytes)
> +		printf("Type %d (Superblock error)\n", fh->handle_type);
> +	else
> +		printf("Type %d (Unknown)\n", fh->handle_type);
> +
> +}
> +
> +static void handle_notifications(char *buffer, int len)
> +{
> +	struct fanotify_event_metadata *event =
> +		(struct fanotify_event_metadata *) buffer;
> +	struct fanotify_event_info_header *info;
> +	struct fanotify_event_info_error *err;
> +	struct fanotify_event_info_fid *fid;
> +	int off;
> +
> +	for (; FAN_EVENT_OK(event, len); event = FAN_EVENT_NEXT(event, len)) {
> +
> +		if (event->mask != FAN_FS_ERROR) {
> +			printf("unexpected FAN MARK: %llx\n", event->mask);
> +			goto next_event;
> +		}
> +
> +		if (event->fd != FAN_NOFD) {
> +			printf("Unexpected fd (!= FAN_NOFD)\n");
> +			goto next_event;
> +		}
> +
> +		printf("FAN_FS_ERROR (len=%d)\n", event->event_len);
> +
> +		for (off = sizeof(*event) ; off < event->event_len;
> +		     off += info->len) {
> +			info = (struct fanotify_event_info_header *)
> +				((char *) event + off);
> +
> +			switch (info->info_type) {
> +			case FAN_EVENT_INFO_TYPE_ERROR:
> +				err = (struct fanotify_event_info_error *) info;
> +
> +				printf("\tGeneric Error Record: len=%d\n",
> +				       err->hdr.len);
> +				printf("\terror: %d\n", err->error);
> +				printf("\terror_count: %d\n", err->error_count);
> +				break;
> +
> +			case FAN_EVENT_INFO_TYPE_FID:
> +				fid = (struct fanotify_event_info_fid *) info;
> +
> +				printf("\tfsid: %x%x\n",
> +				       fid->fsid.val[0], fid->fsid.val[1]);
> +				print_fh((struct file_handle *) &fid->handle);
> +				break;
> +
> +			default:
> +				printf("\tUnknown info type=%d len=%d:\n",
> +				       info->info_type, info->len);
> +			}
> +		}
> +next_event:
> +		printf("---\n\n");
> +	}
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int fd;
> +
> +	char buffer[BUFSIZ];
> +
> +	if (argc < 2) {
> +		printf("Missing path argument\n");
> +		return 1;
> +	}
> +
> +	fd = fanotify_init(FAN_CLASS_NOTIF|FAN_REPORT_FID, O_RDONLY);
> +	if (fd < 0)
> +		errx(1, "fanotify_init");
> +
> +	if (fanotify_mark(fd, FAN_MARK_ADD|FAN_MARK_FILESYSTEM,
> +			  FAN_FS_ERROR, AT_FDCWD, argv[1])) {
> +		errx(1, "fanotify_mark");
> +	}
> +
> +	while (1) {
> +		int n = read(fd, buffer, BUFSIZ);
> +
> +		if (n < 0)
> +			errx(1, "read");
> +
> +		handle_notifications(buffer, n);
> +	}
> +
> +	return 0;
> +}

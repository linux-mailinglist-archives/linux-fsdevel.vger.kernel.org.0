Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED982544A6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 13:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgH0L6A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 07:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgH0LzM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:55:12 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32DBC061239;
        Thu, 27 Aug 2020 04:55:04 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j25so7242023ejk.9;
        Thu, 27 Aug 2020 04:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=84rbSuTncudioMXQiIArnZj65xnBD9WNG5Qdw55pqHQ=;
        b=iMahIZV6lbTxDiYylkcFgVMO5ufqkdL5GPHy/Sez1DjGDLs7uHfVtqaVtMQHhfF1Ph
         m6dPI+AmGcYr63gq3V5am5yX99IV6G4ZhSu0rWAQUEb9G6XCQqsNI5NbkzkwzLIDibn5
         tDrYSb57nxdA187vA4OavrldFB181XnH0s2llsdrp+X7tgqV2QzM3MakN44zzlLYuK4w
         Gb4cw/J45D+eymDAh4CFYINdXRuQJWP6rZbl5rXsgKJ4Ni5g67dmbpqBa0WQDRc7WqOR
         Sx/W7bxhUJLJIcXN6U1jBzTP5zGegWAeJYVxFi6qBKVmOEl58jFnlYRgfjVxDwvc7xdd
         QJgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=84rbSuTncudioMXQiIArnZj65xnBD9WNG5Qdw55pqHQ=;
        b=tkVv6M6jiPeS6P6Q+O2YIRI9BkX39eKaaRNnIZeRBaAQysu3KV97B9NoJ1HdKJa7Vq
         epFxSE6zxXLcWOtQcgOxXThJKwSOzTgPaEw6MIxvNrTM944F+mmH1ikgm1FGnp0TkCq5
         3wdnwL5Fe4BZalk6i+QEJ7QNDD6tAxAdvb4KIf022i/S0aA8DIdXH6kz05xyuoFeXSeU
         Gm6mYkLKSscnAgL2CRKetFvfTj2SovQBBoyKiKjguK38SyGpvLpENPUxsyoLpfkjwzmC
         xXQwgzslYB13lcVkMcJQ4AzKVq8fserBCpvyYNAFuO0MxknrO8eOxIzZjrtX/UsODMBl
         t0fA==
X-Gm-Message-State: AOAM533x9UrxuKbGR3R+uQh8F7SZt6h/ChAfM16rQOTXwAbW/kcXwnHk
        /qDOmoFA9TxuR/mVO0jkz/lwzn4HrEY=
X-Google-Smtp-Source: ABdhPJwGFzFLzHa+eTmPzpU5iQdZFPTlua80nZlH6pi0i6e8jy2xZ4j6eQ0rw422ScMZNDO2YW4T/A==
X-Received: by 2002:a17:906:4f8c:: with SMTP id o12mr20990849eju.69.1598529303024;
        Thu, 27 Aug 2020 04:55:03 -0700 (PDT)
Received: from ?IPv6:2001:a61:253c:4c01:2cf1:7133:9da2:66a9? ([2001:a61:253c:4c01:2cf1:7133:9da2:66a9])
        by smtp.gmail.com with ESMTPSA id dj16sm1377681edb.5.2020.08.27.04.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 04:55:02 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, torvalds@linux-foundation.org,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Add a manpage for watch_queue(7)
To:     David Howells <dhowells@redhat.com>, me@benboeckel.net
References: <159828303137.330133.10953708050467314086.stgit@warthog.procyon.org.uk>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <23fd9b5c-a283-d29b-709a-73ae450c31f3@gmail.com>
Date:   Thu, 27 Aug 2020 13:54:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159828303137.330133.10953708050467314086.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

It would be helpful if you labelled the subject "[PATCH v2 1/2]"
so that one could quickly see which of the patch series in my 
inbox is the newest. (I nearly replied to the wrong draft.)

On 8/24/20 5:30 PM, David Howells wrote:
> Add a manual page for the notifications/watch_queue facility.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  man7/watch_queue.7 |  304 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 304 insertions(+)
>  create mode 100644 man7/watch_queue.7
> 
> diff --git a/man7/watch_queue.7 b/man7/watch_queue.7
> new file mode 100644
> index 000000000..14c202cef
> --- /dev/null
> +++ b/man7/watch_queue.7
> @@ -0,0 +1,304 @@
> +.\"
> +.\" Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
> +.\" Written by David Howells (dhowells@redhat.com)
> +.\"
> +.\" This program is free software; you can redistribute it and/or
> +.\" modify it under the terms of the GNU General Public Licence
> +.\" as published by the Free Software Foundation; either version
> +.\" 2 of the Licence, or (at your option) any later version.

FWIW, and of course the decision is yours, the GPL is a license 
for code, not for documentation. Please consider using the "VERBATIM"
license instead (as you used in the mount manual pages).

> +.\"
> +.TH WATCH_QUEUE 7 "2020-08-07" Linux "General Kernel Notifications"
> +.SH NAME
> +General kernel notification queue
> +.SH SYNOPSIS
> +#include <linux/watch_queue.h>
> +.EX
> +
> +pipe2(fds, O_NOTIFICATION_PIPE);
> +ioctl(fds[0], IOC_WATCH_QUEUE_SET_SIZE, max_message_count);
> +ioctl(fds[0], IOC_WATCH_QUEUE_SET_FILTER, &filter);
> +keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fds[0], message_tag);
> +for (;;) {
> +	buf_len = read(fds[0], buffer, sizeof(buffer));
> +	...
> +}

Please no tabs in man-pages source (they can render strangely), and
the standard in man-pages is 4-space indents. (This needs fixing 
at multiple places below.)


> +.EE
> +.SH OVERVIEW
> +.PP

Preceding line unneeded, and mandoc lint will complain about such things.

Okay -- BOOM -- you jump right in here, in the following lines. Can we start
off with a paragraph or two that gently introduces this feature to
the reader who currently knows next to nothing about the topic (i.e., me).
Begin by telling the reader what problem is being solved here. And then
tell them that this page is describing the solution.

> +The general kernel notification queue is a general purpose transport for kernel

Why "general" twice in the preceding line?

Also, here you talk about "The... queue", as though there is only one of 
them, globally. But below, you talk about "queues", plural. I think
some rewording is needed.

> +notification messages to userspace.  Notification messages are marked with type
> +information so that events from multiple sources can be distinguished.

I think it might be helpful to mention a few examples of what things can 
be "sources".

> +Messages are also of variable length to accommodate different information for
> +each type.
> +.PP
> +Queues are implemented on top of standard pipes and multiple independent queues
> +can be created.  After a pipe has been created, its size and filtering can be
> +configured and event sources attached.  The pipe can then be read or polled to
> +wait for messages.
> +.PP
> +Multiple messages may be read out of the queue at a time if the buffer is large
> +enough, but messages will not get split amongst multiple reads.  If the buffer
> +isn't large enough for a message,

s/enough/enough for at least the next message/ ?

> +.B ENOBUFS
> +will be returned.
> +.PP
> +In the case of message loss,

Please, at or before this point, add an explanation of why loss could occur.
(I see that you say something about this later, but at this point in the page,
"loss" pops out of nowhere.)

> +.BR read (2)
> +will fabricate a loss message and pass that to userspace immediately after the
> +point at which the loss occurred.  A single loss message is generated, even if
> +multiple messages get lost at the same point.
> +.PP
> +A notification pipe allocates a certain amount of locked kernel memory (so that
> +the kernel can write a notification into it from contexts where allocation is
> +restricted), and so is subject to pipe resource limit restrictions - see
> +.BR pipe (7),
> +in the section on
> +.BR "/proc files" .
> +.PP
> +Sources must be attached to a queue manually; there's no single global event
> +source, but rather a variety of sources, each of which can be attached to by
> +multiple queues.  Attachments can be set up by:
> +.TP
> +.BR keyctl_watch_key (3)
> +Monitor a key or keyring for changes.
> +.PP
> +Because a source can produce a lot of different events, not all of which may
> +be of interest to the watcher, a single set of filters can be set on a queue
> +to determine whether a particular event will get inserted in a queue at the
> +point of posting inside the kernel.
> +.SH MESSAGE STRUCTURE
> +.PP
> +The output from reading the pipe is divided into variable length messages.
> +.BR read (2)
> +will never split a message across two separate read calls.  Each message
> +begins with a header of the form:
> +.PP
> +.in +4n
> +.EX
> +struct watch_notification {
> +	__u32	type:24;
> +	__u32	subtype:8;
> +	__u32	info;
> +};
> +.EE
> +.in
> +.PP
> +Where
> +.I type
> +indicates the general class of notification,
> +.I subtype
> +indicates the specific type of notification within that class and
> +.I info
> +includes the message length (in bytes), the watcher's ID and some type-specific
> +information.
> +.PP
> +A special message type,
> +.BR WATCH_TYPE_META ,
> +exists to convey information about the notification facility itself.  It has
> +the following subtypes:
> +.TP
> +.B WATCH_META_LOSS_NOTIFICATION
> +This indicates one or more messages were lost, probably due to a buffer
> +overrun.
> +.TP
> +.B WATCH_META_REMOVAL_NOTIFICATION
> +This indicates that a notification source went away whilst it is being watched.
> +This comes in two lengths: a short variant that carries just the header and a
> +long variant that includes a 64-bit identifier as well that identifies the
> +source more precisely (which variant is used and how the identifier should be
> +interpreted is source dependent).
> +.PP
> +.I info
> +includes the following fields:
> +.TP
> +.B WATCH_INFO_LENGTH
> +Bits 0-6 indicate the size of the message in bytes, and can be between 8 and
> +127.
> +.TP
> +.B WATCH_INFO_ID
> +Bits 8-15 indicate the tag given to the source binding call.  This is a number
> +between 0 and 255 and is purely a source index for userspace's use and isn't
> +interpreted by the kernel.
> +.TP
> +.B WATCH_INFO_TYPE_INFO
> +Bits 16-31 indicate subtype-dependent information.
> +.SH IOCTL COMMANDS
> +Pipes opened with
> +.B O_NOTIFICATION_PIPE
> +have the following
> +.BR ioctl (2)
> +commands available:
> +.TP
> +.B IOC_WATCH_QUEUE_SET_SIZE
> +The ioctl argument is indicates the maximum number of messages that can be
> +inserted into the pipe.  This must be a power of two.  This command also
> +pre-allocates memory to hold messages.
> +.IP
> +This may only be done once and the queue cannot be used until this command has
> +been done.
> +.TP
> +.B IOC_WATCH_QUEUE_SET_FILTER
> +This is used to set filters on the notifications that get written into the
> +buffer.  See the section on filtering for details.
> +.SH FILTERING
> +.PP
> +The
> +.B IOC_WATH_QUEUE_SET_FILTER
> +ioctl argument points to a structure of the following form:
> +.PP
> +.in +4n
> +.EX
> +struct watch_notification_filter {
> +	__u32	nr_filters;
> +	__u32	__reserved;
> +	struct watch_notification_type_filter filters[];
> +};
> +.EE
> +.in
> +.PP
> +Where
> +.I nr_filters
> +indicates the number of elements in the
> +.IR filters []
> +array, and
> +.I __reserved
> +should be 0.  Each element in the filters array specifies a filter and is of
> +the following form:
> +.PP
> +.in +4n
> +.EX
> +struct watch_notification_type_filter {
> +	__u32	type;
> +	__u32	info_filter;
> +	__u32	info_mask;
> +	__u32	subtype_filter[8];
> +};
> +.EE
> +.in
> +.PP
> +Where
> +.I type
> +refers to the type field in a notification record header;
> +.IR info_filter " and " info_mask
> +refer to the info field; and
> +.I subtype_filter
> +is a bit-mask of permitted subtypes.
> +.PP
> +A notification matches a filter if all of the following are true:
> +.in +4n
> +.PP
> +(*) The type on the notification matches that on the filter.
> +.PP
> +(*) The bit in subtype_filter that matches the notification subtype is set.
> +Each element in subtype_filter[] covers 32 subtypes, with, for example,
> +element 0 matching subtypes 0-31.  This can be summarised as:
> +.PP
> +.in +4n
> +.EX
> +F->subtype_filter[N->subtype / 32] & (1U << (N->subtype % 32))
> +.EE
> +.in
> +.PP
> +(*) The notification info, masked off, matches the filter info, e.g.:
> +.PP
> +.in +4n
> +.EX
> +(N->info & F->info_mask) == F->info_filter
> +.EE
> +.in
> +.PP
> +If no filters are set, all notifications are allowed by default and if one or
> +more filters are set, notifications are disallowed by default.
> +WATCH_TYPE_META cannot, however, be filtered.
> +.SH VERSIONS
> +The notification queue driver first appeared in v5.8 of the Linux kernel.
> +.SH EXAMPLE
> +To use the notification mechanism, first of all the pipe has to be opened and
> +the size must be set:
> +.PP
> +.in +4n
> +.EX
> +int fds[2];
> +pipe2(fd[0], O_NOTIFICATION_QUEUE);
> +int wfd = fd[0];
> +
> +ioctl(wfd, IOC_WATCH_QUEUE_SET_SIZE, 16);
> +.EE
> +.in
> +.PP
> +From this point, the queue is open for business.  Filters can be set to
> +restrict the notifications that get inserted into the queue from the sources
> +that are being watched.  For example:
> +.PP
> +.in +4n
> +.EX
> +static struct watch_notification_filter filter = {
> +	.nr_filters	= 1,
> +	.__reserved	= 0,
> +	.filters = {
> +		[0]	= {
> +			.type			= WATCH_TYPE_KEY_NOTIFY,
> +			.subtype_filter[0]	= 1 << NOTIFY_KEY_LINKED,
> +			.info_filter		= 1 << WATCH_INFO_FLAG_2,
> +			.info_mask		= 1 << WATCH_INFO_FLAG_2,
> +		},
> +	},
> +};

> +ioctl(wfd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
> +.EE
> +.in
> +.PP
> +will only allow key-change notifications that indicate a key is linked into a
> +keyring and then only if type-specific flag WATCH_INFO_FLAG_2 is set on the
> +notification.
> +.PP
> +Sources can then be watched, for example:
> +.PP
> +.in +4n
> +.EX
> +keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, wfd, 0x33);
> +.EE
> +.in
> +.PP
> +The first places a watch on the process's session keyring, directing the
> +notifications to the buffer we just created and specifying that they should be
> +tagged with 0x33 in the info ID field.
> +.PP
> +When it is determined that there is something in the buffer, messages can be
> +read out of the ring with something like the following:
> +.PP
> +.in +4n
> +.EX
> +for (;;) {
> +	unsigned char buf[WATCH_INFO_LENGTH];
> +	read(fd, buf, sizeof(buf));
> +	struct watch_notification *n = (struct watch_notification *)buf;
> +	switch (n->type) {
> +	case WATCH_TYPE_META:
> +		switch (n->subtype) {
> +		case WATCH_META_REMOVAL_NOTIFICATION:
> +			saw_removal_notification(n);
> +			break;
> +		case WATCH_META_LOSS_NOTIFICATION:
> +			printf("-- LOSS --\n");
> +			break;
> +		}
> +		break;
> +	case WATCH_TYPE_KEY_NOTIFY:
> +		saw_key_change(n);
> +		break;
> +	}
> +}

> +.EE
> +.in
> +.PP
> +

Remove preceding two lines.

> +.SH SEE ALSO
> +.ad l
> +.nh
> +.BR keyctl (1),
> +.BR ioctl (2),
> +.BR pipe2 (2),
> +.BR read (2),
> +.BR keyctl_watch_key (3)

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/

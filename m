Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BB623F076
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 18:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgHGQFg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 12:05:36 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38157 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbgHGQFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 12:05:35 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 01F0C5C015B;
        Fri,  7 Aug 2020 12:05:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 07 Aug 2020 12:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=date:from:to:cc:subject:message-id:reply-to:references
        :mime-version:content-type:in-reply-to; s=fm2; bh=rh62IHl9YuHZMS
        MJDKHRJ0mXg8EdwUrw/jArl6piTrE=; b=IIXN0ZEp6PVS5x9/Vp3EClz+FMoKgG
        2fytp9seT0GAVNP2yYpORg0ZdNFbBgAfPMWKdJOllfCeUDeeX3aMXfM2pcDftCAm
        n29O/UCWQx1bqqbsPFEetbvSHXMn2k6+g6l1F0CfODkuJNl8nUhntdvjRhmSkzJm
        lNimf0BPddqumxje6VPjnW/+LHZf0LDoXGSNC6R3XS2dSkAiywSHJzbRQQnYhuzy
        JF8v0o2kj97MpnfN+8h8asRiB0IaI2n4naTFYnVXtrDKcXwManwKARYpUa9Dq5lH
        6+7cIcyNwnFGnv+qM3MCFRjKCH25bj4FZXvqQ2cTfrnCFHEhGSVs2w/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:reply-to:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=rh62IHl9YuHZMSMJDKHRJ0mXg8EdwUrw/jArl6piTrE=; b=LYfCFxOh
        rQ7uc8XGjopHtYhkpp9uVoy0Y4r9/uY0nahRjctCPnq8Yf45SzmOiXaDFG+n8dIg
        tGdx+GQ9RWvAY9BpYwreKLDbFIUqazSRvvvtCnrkH03KEY9tUxXtLWeBhhUaYpjX
        wdzFjOSCoKgNZj1p6IbY9oZbnwcofXI/jJj6qONKcTvI+yZVTPyYev8gj7AUFl9m
        IOENtWMlYIi2YPj+bXPTtLXB2ejsIVfs8L4eqQy5YAZcoK24RLntfr3pQY0uBm+2
        StQfgertICrCiw+I96lJUq+60u8pH6V0H1Pp26TuQRZLKDFgJyz2u3g0ifvwkfMf
        R75Mool6qx4Gpw==
X-ME-Sender: <xms:zHstX4_tVZ-uxtptoxk5FFGPsR4gjUridEGX6Jzs69LCUmY4rcVF6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedvgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkrhhfgggtuggjfgesthdtredttderjeenucfhrhhomhepuegvnhcu
    uehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrghtth
    gvrhhnpeejtddvffehtefgkedtheevgfeileegfeehjedvhedtudeiteegtdeftdelvedv
    ffenucfkphepieelrddvtdegrdduieekrddvfeefnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepmhgvsegsvghnsghovggtkhgvlhdrnhgvth
X-ME-Proxy: <xmx:zHstXwu8zlQrEvLZuxjMn3oOFLDXLq14mXpctKCSXp3AOJdNqJkCzA>
    <xmx:zHstX-BKfLRDpUdGagKGD_21OZCR7J-TR-QPLnqCjc-JYg5voBt6Cw>
    <xmx:zHstX4eNlA8bWGhhBMxRuEu-SAct77Jc_YMohnia-SrmoaJW5QOTUA>
    <xmx:zHstXyrEosFymwiFP8ikMsx6z-TEZYoBP3OxghwoKdHdLXj2kZdlVw>
Received: from localhost (cpe-69-204-168-233.nycap.res.rr.com [69.204.168.233])
        by mail.messagingengine.com (Postfix) with ESMTPA id 61ABE3060067;
        Fri,  7 Aug 2020 12:05:32 -0400 (EDT)
Date:   Fri, 7 Aug 2020 12:05:31 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     David Howells <dhowells@redhat.com>
Cc:     mtk.manpages@gmail.com, torvalds@linux-foundation.org,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Add a manpage for watch_queue(7)
Message-ID: <20200807160531.GA1345000@erythro.dev.benboeckel.internal>
Reply-To: me@benboeckel.net
References: <159681277616.35436.11229310534842613599.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159681277616.35436.11229310534842613599.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 07, 2020 at 16:06:16 +0100, David Howells wrote:
> Add a manual page for the notifications/watch_queue facility.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
> 
>  man7/watch_queue.7 |  285 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 285 insertions(+)
>  create mode 100644 man7/watch_queue.7
> 
> diff --git a/man7/watch_queue.7 b/man7/watch_queue.7
> new file mode 100644
> index 000000000..6b22ad689
> --- /dev/null
> +++ b/man7/watch_queue.7
> @@ -0,0 +1,285 @@
> +.\"
> +.\" Copyright (C) 2020 Red Hat, Inc. All Rights Reserved.
> +.\" Written by David Howells (dhowells@redhat.com)
> +.\"
> +.\" This program is free software; you can redistribute it and/or
> +.\" modify it under the terms of the GNU General Public Licence
> +.\" as published by the Free Software Foundation; either version
> +.\" 2 of the Licence, or (at your option) any later version.
> +.\"
> +.TH WATCH_QUEUE 7 "2020-08-07" Linux "General Kernel Notifications"
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.SH NAME
> +General kernel notification queue
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.SH SYNOPSIS
> +#include <linux/watch_queue.h>
> +.EX
> +
> +pipe2(fds, O_NOTIFICATION_PIPE);
> +ioctl(fds[0], IOC_WATCH_QUEUE_SET_SIZE, max_message_count);
> +ioctl(fds[0], IOC_WATCH_QUEUE_SET_FILTER, &filter);
> +keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fds[0], 0x01);

What is this `0x01` magic number?

(Later, from below: It's a tag to add to messages. A variable with a
name to that effect is probably warranted in the "hello world" example
this early in the doc.)

> +for (;;) {
> +	buf_len = read(fds[0], buffer, sizeof(buffer));
> +	...
> +}
> +.EE
> +.SH OVERVIEW
> +.PP
> +The general kernel notification queue is a general purpose transport for kernel
> +notification messages to userspace.  Notification messages are marked with type
> +information so that events from multiple sources can be distinguished.
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
> +.B ENOBUFS
> +will be returned.
> +.PP
> +In the case of message loss,
> +.BR read (2)
> +will fabricate a loss message and pass that to userspace immediately after the
> +point at which the loss occurred.

If multiple messages are dropped in a row, is there one loss message per
loss message or per loss event?

> +A notification pipe allocates a certain amount of locked kernel memory (so that
> +the kernel can write a notification into it from contexts where allocation is
> +restricted), and so is subject to pipe resource limit restrictions.

A reference to the relevant manpage for resource limitations would be
nice here. I'd assume `setrlimit(2)`, but I don't see anything
pipe-specific there.

> +Sources must be attached to a queue manually; there's no single global event
> +source, but rather a variety of sources, each of which can be attached to by
> +multiple queues.  Attachments can be set up by:
> +.TP
> +.BR keyctl_watch_key (3)
> +Monitor a key or keyring for changes.
> +.PP
> +Because a source can produce a lot of different events, not all of which may be

"many events" or "many types of events"?

> +of interest to the watcher, a filter can be set on a queue to determine whether

"a filter can be set"? If multiple filters are allowed, "filters can be
added" might work better here to indicate that multiple filters are
allowed. Otherwise, "a single filter" would make it clearer that only
one is supported.

> +a particular event will get inserted in a queue at the point of posting inside
> +the kernel.
> +
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.SH MESSAGE STRUCTURE
> +.PP
> +The output from reading the pipe is divided into variable length messages.
> +Read will never split a message across two separate read calls.  Each message

"read(2) will never split" perhaps?

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
> +exists to convey information about the notification facility itself.  It has a
> +number of subtypes:

"a number of" seems extraneous. How about just "It has the following
subtypes"?

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

Are there macros for extracting these fields available? Why not also
have bitfields for these? Or is there some ABI issues with
non-power-of-2 bitfield sizes? For clarity, which bit is bit 0? Low
address or LSB? Is this documented in some other manpage?

Also, bit 7 is unused (for alignment I assume)? Is it always 0, 1, or
indeterminate?

> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.SH IOCTL COMMANDS
> +Pipes opened O_NOTIFICATION_PIPE have the following

"Pipes opened with". It should probably also be ".B O_NOTIFICATION_PIPE"
for markup purposes.

> +.IR ioctl ()
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

"set" -> "add"? If I call this multiple times, is only the last call
effective or do I need to keep a list of all filters myself so I can
append in the future (since I see no analogous GET_FILTER call)? Does
this have implications for criu restoring a process?

> +buffer.  The ioctl argument points to a structure of the following form:
> +.IP
> +.in +4n
> +.EX
> +struct watch_notification_filter {
> +	__u32	nr_filters;
> +	__u32	__reserved;
> +	struct watch_notification_type_filter filters[];
> +};
> +.EE
> +.in
> +.IP
> +Where
> +.I nr_filters
> +indicates the number of elements in the
> +.IR filters []
> +array.  Each element in the filters array specifies a filter and is of the
> +following form:

I assume `__reserved` must be 0 until it has meaning? Is that checked
kernel-side?

> +.IP
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
> +.IP
> +Where
> +.I type
> +refer to the type field in a notification record header, info_filter and

"refers"

> +info_mask refer to the info field and subtype_filter is a bit-mask of subtypes.

Adding the Oxford comma here would be nicer due to the one entry using
`and` itself, but I don't know the editorial rules on that in the docs.

> +.IP
> +If no filters are installed, all notifications are allowed by default and if
> +one or more filters are installed, notifications are disallowed by default.

Here, filters on a queue are referred to as being "installed". Some
consistency between "set", "add", and "install" would be appreciated.

> +.IP
> +A notifications matches a filter if, for notification N and filter F:
> +.IP
> +.in +4n
> +.EX
> +N->type == F->type &&
> +(F->subtype_filter[N->subtype >> 5] &
> +	(1U << (N->subtype & 31))) &&
> +(N->info & F->info_mask) == F->info_filter)
> +.EE
> +.in
> +.IP

The bitshifting here is a bit out-of-the-blue. There's obviously some
structure to subtypes, but it is only mentioned tangentially in this
algorithm. Is it worth mentioning somewhere? Given a list of subtypes I
want to match, how do I make a filter since they're supposed to be
opaque (modulo ABI stability)? This information belongs with each
message type's documentation or there needs to be some way to extract it
from any given set of message subtypes.

> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
> +From this point, the queue is open for business.

"open for business" seems awfully casual compare to the rest of the
text. Idioms are probably not best in technical docs anyways
(translation and such). How about "From this point on, the kernel can
place events into the queue."?

Is there any benefit/error case for adding event sources and then
setting the buffer size? Perhaps one might want all event sources to
start delivering together rather than the buffer filling up while adding
all of the sources?

>                                                    Filters can be set to

Another set/add/install uniformity location.

> +restrict the notifications that get inserted into the buffer from the sources

"buffer" -> "queue"?

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

OK, so the example helps with the filter and mask, but then each event
type probably needs to document which watch info flags each subtype
cares about or what it means.

Where are the docs for all of the available `WATCH_INFO_FLAG` macros?

> +		},
> +	},
> +};
> +
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
> +	unsigned char buf[128];

Is 128 the maximum message size? Do we have a macro for this? If it
isn't, shouldn't there be code for detecting ENOBUFS and using a bigger
buffer? Or at least not rolling with a busted buffer.

> +	int ret = read(fd, buf, sizeof(buf));

	/* Check if the buffer was too small for a message. */
	if (ret < 0 && errno == ENOBUFS)
		continue;

Though this seems like an infinite loop now since that too-large message
will just clog the queue...

Perfect error handling isn't necessary in example code like this, but
could we at least stick traffic cones in the potholes?

> +	struct watch_notification *n = (struct watch_notification *)buf;
> +	switch (n->type) {
> +	case WATCH_TYPE_META:

From above, if a filter is added, all messages not matching a filter are
dropped. Are WATCH_TYPE_META messages special in this case? If so, could
it be mentioned somewhere that they do not observe filters (I'm partial
to both the message type and filter docs since one might come to the
docs for either reason individually, but at least one should mention
it)? If they do observe filters, isn't this case block dead code?

> +		switch (n->subtype) {
> +		case WATCH_META_REMOVAL_NOTIFICATION:
> +			saw_removal_notification(n);
> +			break;
> +		case WATCH_META_LOSS_NOTIFICATION:
> +			printf("-- LOSS --\n");
> +			break;

The Rust developer in me wants to see:

	default:
		/* Subtypes may be added in future kernel versions. */
		printf("unrecognized meta subtype: %d\n", n->subtype);
		break;

unless we're guaranteeing that no other subtypes exist for this type
(updating the docs with new types doesn't help those who copy/paste from
here as a seed).

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
> +.\"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
> +.SH VERSIONS
> +The notification queue driver first appeared in v5.8 of the Linux kernel.

Other manpages seem to have this above examples. This is fine too, but
just double checking to see if there are conventions about section
ordering.

> +.SH SEE ALSO
> +.ad l
> +.nh
> +.BR keyctl (1),
> +.BR ioctl (2),
> +.BR pipe2 (2),
> +.BR read (2),
> +.BR keyctl_watch_key (3)

Thanks,

--Ben

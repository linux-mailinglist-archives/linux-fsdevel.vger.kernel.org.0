Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19F0138EBE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2019 17:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729680AbfFGPPG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jun 2019 11:15:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49364 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728486AbfFGPPF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jun 2019 11:15:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57EwcT1054607;
        Fri, 7 Jun 2019 15:14:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=h8vTh5Ofg2IydYEb3uYyDZob/185V8cMuqbg2wErPlI=;
 b=iuWapLZp/6g2F2aFZwbSr7BVghUA97+eWuLKDIEJhcWUA0qYBMjTgyCudTH8mqz7h9nS
 PcfBhd+aHrAo5jYcbxeU8Bg2jUXopmIh1yqx/wRwuDHxZ64ckb8knWaJJB+E4e+jzx/U
 MDYmqApjhTKCl2AnCWD4awWhSWG3s5tPrBwZmm16LrdTMZNO9WwLnSQmz1ZHCEGCqNoK
 7QdbM9Q4qd+ruEk+oXTwjSovZvmO/Xm3rok3W7vCWc1jRCq6JqXAVl6epZUWf5fm+fTd
 qcETmSu2hmHz5WnHaVxm9sUTl9/NIcmsVlgEp6kqf/bvljCBI8aDevXoauy5ontPF4Cq 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2suj0qxs50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 15:14:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57FAbOX009482;
        Fri, 7 Jun 2019 15:12:31 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2swnhbcka0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 15:12:31 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x57FCUqV031402;
        Fri, 7 Jun 2019 15:12:30 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 08:12:29 -0700
Date:   Fri, 7 Jun 2019 08:12:28 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-block@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] uapi: General notification ring definitions [ver
 #4]
Message-ID: <20190607151228.GA1872258@magnolia>
References: <155991702981.15579.6007568669839441045.stgit@warthog.procyon.org.uk>
 <155991706083.15579.16359443779582362339.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155991706083.15579.16359443779582362339.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070106
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 07, 2019 at 03:17:40PM +0100, David Howells wrote:
> Add UAPI definitions for the general notification ring, including the
> following pieces:
> 
>  (1) struct watch_notification.
> 
>      This is the metadata header for each entry in the ring.  It includes a
>      type and subtype that indicate the source of the message
>      (eg. WATCH_TYPE_MOUNT_NOTIFY) and the kind of the message
>      (eg. NOTIFY_MOUNT_NEW_MOUNT).
> 
>      The header also contains an information field that conveys the
>      following information:
> 
> 	- WATCH_INFO_LENGTH.  The size of the entry (entries are variable
>           length).
> 
> 	- WATCH_INFO_OVERRUN.  If preceding messages were lost due to ring
> 	  overrun or lack of memory.
> 
> 	- WATCH_INFO_ENOMEM.  If preceding messages were lost due to lack
>           of memory.
> 
> 	- WATCH_INFO_RECURSIVE.  If the event detected was applied to
>           multiple objects (eg. a recursive change to mount attributes).
> 
> 	- WATCH_INFO_IN_SUBTREE.  If the event didn't happen at the watched
>           object, but rather to some related object (eg. a subtree mount
>           watch saw a mount happen somewhere within the subtree).
> 
> 	- WATCH_INFO_TYPE_FLAGS.  Eight flags whose meanings depend on the
>           message type.
> 
> 	- WATCH_INFO_ID.  The watch ID specified when the watchpoint was
>           set.
> 
>      All the information in the header can be used in filtering messages at
>      the point of writing into the buffer.
> 
>  (2) struct watch_queue_buffer.
> 
>      This describes the layout of the ring.  Note that the first slots in
>      the ring contain a special metadata entry that contains the ring
>      pointers.  The producer in the kernel knows to skip this and it has a
>      proper header (WATCH_TYPE_META, WATCH_META_SKIP_NOTIFICATION) that
>      indicates the size so that the ring consumer can handle it the same as
>      any other record and just skip it.
> 
>      Note that this means that ring entries can never be split over the end
>      of the ring, so if an entry would need to be split, a skip record is
>      inserted to wrap the ring first; this is also WATCH_TYPE_META,
>      WATCH_META_SKIP_NOTIFICATION.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>

I'm starting by reading the uapi changes and the sample program...

> ---
> 
>  include/uapi/linux/watch_queue.h |   63 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 include/uapi/linux/watch_queue.h
> 
> diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
> new file mode 100644
> index 000000000000..c3a88fa5f62a
> --- /dev/null
> +++ b/include/uapi/linux/watch_queue.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_LINUX_WATCH_QUEUE_H
> +#define _UAPI_LINUX_WATCH_QUEUE_H
> +
> +#include <linux/types.h>
> +
> +enum watch_notification_type {
> +	WATCH_TYPE_META		= 0,	/* Special record */
> +	WATCH_TYPE_MOUNT_NOTIFY	= 1,	/* Mount notification record */
> +	WATCH_TYPE_SB_NOTIFY	= 2,	/* Superblock notification */
> +	WATCH_TYPE_KEY_NOTIFY	= 3,	/* Key/keyring change notification */
> +	WATCH_TYPE_BLOCK_NOTIFY	= 4,	/* Block layer notifications */
> +#define WATCH_TYPE___NR 5

Given the way enums work I think you can just make WATCH_TYPE___NR the
last element in the enum?

> +};
> +
> +enum watch_meta_notification_subtype {
> +	WATCH_META_SKIP_NOTIFICATION	= 0,	/* Just skip this record */
> +	WATCH_META_REMOVAL_NOTIFICATION	= 1,	/* Watched object was removed */
> +};
> +
> +/*
> + * Notification record
> + */
> +struct watch_notification {

Kind of a long name...

> +	__u32			type:24;	/* enum watch_notification_type */
> +	__u32			subtype:8;	/* Type-specific subtype (filterable) */

16777216 diferent types and 256 different subtypes?  My gut instinct
wants a better balance, though I don't know where I'd draw the line.
Probably 12 bits for type and 10 for subtype?  OTOH I don't have a good
sense of how many distinct notification types an XFS would want to send
back to userspace, and maybe 256 subtypes is fine.  We could always
reserve another watch_notification_type if we need > 256.

Ok, no objections. :)

> +	__u32			info;
> +#define WATCH_INFO_OVERRUN	0x00000001	/* Event(s) lost due to overrun */
> +#define WATCH_INFO_ENOMEM	0x00000002	/* Event(s) lost due to ENOMEM */
> +#define WATCH_INFO_RECURSIVE	0x00000004	/* Change was recursive */
> +#define WATCH_INFO_LENGTH	0x000001f8	/* Length of record / sizeof(watch_notification) */

This is a mask, isn't it?  Could we perhaps have some helpers here?
Something along the lines of...

#define WATCH_INFO_LENGTH_MASK	0x000001f8
#define WATCH_INFO_LENGTH_SHIFT	3

static inline size_t watch_notification_length(struct watch_notification *wn)
{
	return (wn->info & WATCH_INFO_LENGTH_MASK) >> WATCH_INFO_LENGTH_SHIFT *
			sizeof(struct watch_notification);
}

static inline struct watch_notification *watch_notification_next(
		struct watch_notification *wn)
{
	return wn + ((wn->info & WATCH_INFO_LENGTH_MASK) >>
			WATCH_INFO_LENGTH_SHIFT);
}

...so that we don't have to opencode all of the ring buffer walking
magic and stuff?

(I might also shorten the namespace from WATCH_INFO_ to WNI_ ...)

Hmm so the length field is 6 bits and therefore the maximum size of a
notification record is ... 63 * (sizeof(u32)  * 2) = 504 bytes?  Which
means that kernel users can send back a maximum payload of 496 bytes?
That's probably big enough for random fs notifications (bad metadata
detected, media errors, etc.)

Judging from the sample program I guess all that userspace does is
allocate a memory buffer and toss it into the kernel, which then
initializes the ring management variables, and from there we just scan
around the ring buffer every time poll(watch_fd) says there's something
to do?  How does userspace tell the kernel the size of the ring buffer?

Does (watch_notification->info & WATCH_INFO_LENGTH) == 0 have any
meaning besides apparently "stop looking at me"?

> +#define WATCH_INFO_IN_SUBTREE	0x00000200	/* Change was not at watched root */
> +#define WATCH_INFO_TYPE_FLAGS	0x00ff0000	/* Type-specific flags */

WATCH_INFO_FLAG_MASK ?

> +#define WATCH_INFO_FLAG_0	0x00010000
> +#define WATCH_INFO_FLAG_1	0x00020000
> +#define WATCH_INFO_FLAG_2	0x00040000
> +#define WATCH_INFO_FLAG_3	0x00080000
> +#define WATCH_INFO_FLAG_4	0x00100000
> +#define WATCH_INFO_FLAG_5	0x00200000
> +#define WATCH_INFO_FLAG_6	0x00400000
> +#define WATCH_INFO_FLAG_7	0x00800000
> +#define WATCH_INFO_ID		0xff000000	/* ID of watchpoint */

WATCH_INFO_ID_MASK ?

> +#define WATCH_INFO_ID__SHIFT	24

Why double underscore here?

> +};
> +
> +#define WATCH_LENGTH_SHIFT	3
> +
> +struct watch_queue_buffer {
> +	union {
> +		/* The first few entries are special, containing the
> +		 * ring management variables.

The first /two/ entries, correct?

Also, weird multiline comment style.

> +		 */
> +		struct {
> +			struct watch_notification watch; /* WATCH_TYPE_META */

Do these structures have to be cache-aligned for the atomic reads and
writes to work?

--D

> +			__u32		head;		/* Ring head index */
> +			__u32		tail;		/* Ring tail index */
> +			__u32		mask;		/* Ring index mask */
> +		} meta;
> +		struct watch_notification slots[0];
> +	};
> +};
> +
> +#endif /* _UAPI_LINUX_WATCH_QUEUE_H */
> 

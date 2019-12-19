Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42CDA12676F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 17:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLSQx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 11:53:59 -0500
Received: from ms.lwn.net ([45.79.88.28]:37284 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbfLSQx7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:53:59 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C8DD92E5;
        Thu, 19 Dec 2019 16:53:57 +0000 (UTC)
Date:   Thu, 19 Dec 2019 09:53:56 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     miklos@szeredi.hu, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: filesystems: convert fuse to RST
Message-ID: <20191219095356.4a3ad965@lwn.net>
In-Reply-To: <20191120192655.33709-1-dwlsalmeida@gmail.com>
References: <20191120192655.33709-1-dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 20 Nov 2019 16:26:55 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> 
> Converts fuse.txt to reStructuredText format, improving the presentation
> without changing much of the underlying content.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> -----------------------------------------------------------
> Changes in v2:
> -Copied FUSE maintainer (Miklos Szeredi)
> -Fixed the reference in the MAINTAINERS file
> -Removed some of the excessive markup in fuse.rst
> -Moved fuse.rst into admin-guide
> -Updated index.rst

So I have to confess that I've lost track of where we stand with this.
Holidays and moving house will do that...apologies.  In any case, I have a
couple of additional comments.

[...]

> -There's a control filesystem for FUSE, which can be mounted by:
> +There's a control filesystem for FUSE, which can be mounted by: ::
>  
>    mount -t fusectl none /sys/fs/fuse/connections

Please just do "...can be mounted by::"; it will do what you want.

> -Mounting it under the '/sys/fs/fuse/connections' directory makes it
> +Mounting it under the ``'/sys/fs/fuse/connections'`` directory makes it

There's still a lot of extra markup, and this seems like *way* too many
quotes... 

> -INTERRUPT requests take precedence over other requests, so the
> +*INTERRUPT* requests take precedence over other requests, so the
>  userspace filesystem will receive queued INTERRUPTs before any others.

Not sure you need to add that markup either, but beyond that...

> -The userspace filesystem may ignore the INTERRUPT requests entirely,
> -or may honor them by sending a reply to the _original_ request, with
> -the error set to EINTR.
> +The userspace filesystem may ignore the *INTERRUPT* requests entirely,
> +or may honor them by sending a reply to the *original* request, with
> +the error set to ``EINTR``.
>  
>  It is also possible that there's a race between processing the
>  original request and its INTERRUPT request.  There are two possibilities:
>  
> -  1) The INTERRUPT request is processed before the original request is
> +  #. The *INTERRUPT* request is processed before the original request is
>       processed
>  
> -  2) The INTERRUPT request is processed after the original request has
> +  #. The *INTERRUPT* request is processed after the original request has
>       been answered
>  
>  If the filesystem cannot find the original request, it should wait for
>  some timeout and/or a number of new requests to arrive, after which it
> -should reply to the INTERRUPT request with an EAGAIN error.  In case
> -1) the INTERRUPT request will be requeued.  In case 2) the INTERRUPT
> +should reply to the INTERRUPT request with an ``EAGAIN`` error.  In case
> +1) the ``INTERRUPT`` request will be requeued.  In case 2) the ``INTERRUPT``
>  reply will be ignored.

Here you are marking up the same term in a different way.  That can only
create confusion, which is generally not the goal for the docs.

Please make another pass and try to get the markup down to a minimum;
remember that the plain-text reading experience matters too.

Thanks,

jon

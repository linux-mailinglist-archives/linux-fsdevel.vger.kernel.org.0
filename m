Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8395215072
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 02:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgGFAPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 20:15:34 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:45955 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727970AbgGFAPc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 20:15:32 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 70398580332;
        Sun,  5 Jul 2020 20:15:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 05 Jul 2020 20:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        bTZL63OJhS2abfrP0xhwKic99+nFs7SLUUoeqTWqjVo=; b=xIl8DjEO73NZEXj7
        w5rGkdxgkdS7WFhDJwZT3nJiuBWlSj7cyM73HdYj6F1c/q8pyDl2dtViIniOUjlF
        G2r4QHveK7I9C0qkJmaNaMpNDsOVR5uWW8/8CFSxTBCcxIn8mkBE2+vxiF7eFUxl
        Ki5U+zMgtkDCvq2U0xJJjwje/iy9cE2HRwYhYnrtR6sFeCTjWt5QLJjMj0S8rXK5
        pgW+IpK05SB3vZJQm/cQXcsQHvMHn2illc1FnRjdGeWAe0FrPhJ51LfaXH4l0iXM
        hGKhrKUUi2HZInPYrZ9TtNu7Ie9jcDcYNKdFb5MIZX7BpC4hQoU1/o5dGl3yOw0H
        hmvgqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=bTZL63OJhS2abfrP0xhwKic99+nFs7SLUUoeqTWqj
        Vo=; b=EnIXih/dlbPjDgZDktFk7cJfQj5kg8Lb+zTiQ3RDG00ZyWjn01CHulfBT
        /mKp7Ns0yq3Zt5vSXPByPz1EODZUuTE+0kFMKEhmRtAbXFzFMy2ph9n6t2hQ9eo9
        i0ZxYhM4t2mdjSyK05K/REt04nrkmzHycBFJX5WS0Xhq0jMP9Q9UZJeDpaG0rDmv
        likcMbQnvGapo7V8koB0MwsqdpsCUWWhBwnVeYzVi3Ps2/jApHZPW7HU6vXR2St4
        9Gtt1zrk0rJxMi9ndYQvW8lH6yoYMGeWZqCDvDkl5BzxsX7WT7yAXUuCbX+G+C/M
        CiGaSTmDDDh+qSN9lWT9QsXBbgY1A==
X-ME-Sender: <xms:IW0CXwKVeu8lGbzOlq64_A5_uFFV9vNkIYm7mP0MSrimI9UB2WhDKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvdeftddrvddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:IW0CXwJa33pPbyJKs5j5yJJp8AVsGxsC2lc_Vn_Nn0WgjWxj9WfMHw>
    <xmx:IW0CXwt3L6lJEFZ-a435eMSG900UwVrgynIIndkpxdWRcto6-JaobA>
    <xmx:IW0CX9b9MDt0t9FCouBcea7zpCeNwSyaB2nZBRofypQ8--PuHp992A>
    <xmx:I20CX1CVjYZahSNs5yLT8Fa4eKR0D2nZXYQ0LYQaLxjYF-xToCoL_g>
Received: from mickey.themaw.net (58-7-230-200.dyn.iinet.net.au [58.7.230.200])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7F2713280063;
        Sun,  5 Jul 2020 20:15:24 -0400 (EDT)
Message-ID: <c0488eb9932989a0d932ee5ec6d66429db18db4d.camel@themaw.net>
Subject: Re: [PATCH 01/10] Documentation: filesystems: autofs-mount-control:
 drop doubled words
From:   Ian Kent <raven@themaw.net>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        autofs@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-cachefs@redhat.com, Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Date:   Mon, 06 Jul 2020 08:15:21 +0800
In-Reply-To: <20200703214325.31036-2-rdunlap@infradead.org>
References: <20200703214325.31036-1-rdunlap@infradead.org>
         <20200703214325.31036-2-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-07-03 at 14:43 -0700, Randy Dunlap wrote:
> Drop the doubled words "the" and "and".
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Ian Kent <raven@themaw.net>

Acked-by: Ian Kent <raven@themaw.net>

> Cc: autofs@vger.kernel.org
> ---
>  Documentation/filesystems/autofs-mount-control.rst |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-next-20200701.orig/Documentation/filesystems/autofs-mount-
> control.rst
> +++ linux-next-20200701/Documentation/filesystems/autofs-mount-
> control.rst
> @@ -391,7 +391,7 @@ variation uses the path and optionally i
>  set to an autofs mount type. The call returns 1 if this is a mount
> point
>  and sets out.devid field to the device number of the mount and
> out.magic
>  field to the relevant super block magic number (described below) or
> 0 if
> -it isn't a mountpoint. In both cases the the device number (as
> returned
> +it isn't a mountpoint. In both cases the device number (as returned
>  by new_encode_dev()) is returned in out.devid field.
>  
>  If supplied with a file descriptor we're looking for a specific
> mount,
> @@ -399,12 +399,12 @@ not necessarily at the top of the mounte
>  the descriptor corresponds to is considered a mountpoint if it is
> itself
>  a mountpoint or contains a mount, such as a multi-mount without a
> root
>  mount. In this case we return 1 if the descriptor corresponds to a
> mount
> -point and and also returns the super magic of the covering mount if
> there
> +point and also returns the super magic of the covering mount if
> there
>  is one or 0 if it isn't a mountpoint.
>  
>  If a path is supplied (and the ioctlfd field is set to -1) then the
> path
>  is looked up and is checked to see if it is the root of a mount. If
> a
>  type is also given we are looking for a particular autofs mount and
> if
> -a match isn't found a fail is returned. If the the located path is
> the
> +a match isn't found a fail is returned. If the located path is the
>  root of a mount 1 is returned along with the super magic of the
> mount
>  or 0 otherwise.


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230EF1375D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 19:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAJSJ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 13:09:26 -0500
Received: from ms.lwn.net ([45.79.88.28]:52276 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgAJSJ0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 13:09:26 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1C4A577D;
        Fri, 10 Jan 2020 18:09:25 +0000 (UTC)
Date:   Fri, 10 Jan 2020 11:09:23 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     miklos@szeredi.hu, markus.heiser@darmarit.de,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4] Documentation: filesystems: convert fuse to RST
Message-ID: <20200110110923.31fc56e5@lwn.net>
In-Reply-To: <20191231185110.809467-1-dwlsalmeida@gmail.com>
References: <20191231185110.809467-1-dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 31 Dec 2019 15:51:10 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Converts fuse.txt to reStructuredText format, improving the presentation
> without changing much of the underlying content.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

So I note that the last non-typo-fix change to this document happened in
2006, which leads me to suspect that it might be just a wee bit out of
date.  Miklos, what's the story here?  Should we put a warning at the top?

Otherwise I really only have one other comment on the conversion...


>  .../filesystems/{fuse.txt => fuse.rst}        | 174 ++++++++----------
>  Documentation/filesystems/index.rst           |   1 +
>  MAINTAINERS                                   |   2 +-
>  3 files changed, 80 insertions(+), 97 deletions(-)
>  rename Documentation/filesystems/{fuse.txt => fuse.rst} (79%)
> 
> diff --git a/Documentation/filesystems/fuse.txt b/Documentation/filesystems/fuse.rst
> similarity index 79%
> rename from Documentation/filesystems/fuse.txt
> rename to Documentation/filesystems/fuse.rst
> index 13af4a49e7db..aa7d6f506b8d 100644
> --- a/Documentation/filesystems/fuse.txt
> +++ b/Documentation/filesystems/fuse.rst
> @@ -1,41 +1,39 @@
> -Definitions
> -~~~~~~~~~~~
> +==============
> +FUSE
> +==============
>  
> -Userspace filesystem:
> +Definitions
> +===========
>  
> +``Userspace filesystem:``
>    A filesystem in which data and metadata are provided by an ordinary
>    userspace process.  The filesystem can be accessed normally through
>    the kernel interface.

I think that ``literal text`` should really only be used for literal text -
something that the user types, function names, etc.  Here you're defining a
term, which is different.  You could use **emphasis** as you have in other
places, but I also honestly think it doesn't need special markup at all.

Thanks,

jon

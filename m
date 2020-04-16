Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAD81ABB99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 10:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502782AbgDPIqv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 04:46:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:34646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502817AbgDPIqf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:46:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A2BDAF40;
        Thu, 16 Apr 2020 08:45:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F2ED81E1250; Thu, 16 Apr 2020 10:45:37 +0200 (CEST)
Date:   Thu, 16 Apr 2020 10:45:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/34] docs: filesystems: convert dnotify.txt to ReST
Message-ID: <20200416084537.GA23739@quack2.suse.cz>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
 <ed628af6cc9fc157c617825c74d6084eb42c7800.1586960617.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed628af6cc9fc157c617825c74d6084eb42c7800.1586960617.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 15-04-20 16:32:27, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Add a document title;
> - Some whitespace fixes and new line breaks;
> - Add table markups;
> - Add it to filesystems/index.rst
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Looks good to me. I expect you merge this through documentation tree so you
can add:

Acked-by: Jan Kara <jack@suse.cz>

								Honza



> ---
>  .../filesystems/{dnotify.txt => dnotify.rst}          | 11 ++++++++---
>  Documentation/filesystems/index.rst                   |  1 +
>  MAINTAINERS                                           |  2 +-
>  3 files changed, 10 insertions(+), 4 deletions(-)
>  rename Documentation/filesystems/{dnotify.txt => dnotify.rst} (90%)
> 
> diff --git a/Documentation/filesystems/dnotify.txt b/Documentation/filesystems/dnotify.rst
> similarity index 90%
> rename from Documentation/filesystems/dnotify.txt
> rename to Documentation/filesystems/dnotify.rst
> index 08d575ece45d..a28a1f9ef79c 100644
> --- a/Documentation/filesystems/dnotify.txt
> +++ b/Documentation/filesystems/dnotify.rst
> @@ -1,5 +1,8 @@
> -		Linux Directory Notification
> -		============================
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============================
> +Linux Directory Notification
> +============================
>  
>  	   Stephen Rothwell <sfr@canb.auug.org.au>
>  
> @@ -12,6 +15,7 @@ being delivered using signals.
>  The application decides which "events" it wants to be notified about.
>  The currently defined events are:
>  
> +	=========	=====================================================
>  	DN_ACCESS	A file in the directory was accessed (read)
>  	DN_MODIFY	A file in the directory was modified (write,truncate)
>  	DN_CREATE	A file was created in the directory
> @@ -19,6 +23,7 @@ The currently defined events are:
>  	DN_RENAME	A file in the directory was renamed
>  	DN_ATTRIB	A file in the directory had its attributes
>  			changed (chmod,chown)
> +	=========	=====================================================
>  
>  Usually, the application must reregister after each notification, but
>  if DN_MULTISHOT is or'ed with the event mask, then the registration will
> @@ -36,7 +41,7 @@ especially important if DN_MULTISHOT is specified.  Note that SIGRTMIN
>  is often blocked, so it is better to use (at least) SIGRTMIN + 1.
>  
>  Implementation expectations (features and bugs :-))
> ----------------------------
> +---------------------------------------------------
>  
>  The notification should work for any local access to files even if the
>  actual file system is on a remote server.  This implies that remote
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 470b2da2b7b1..960e0cc29491 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -26,6 +26,7 @@ algorithms work.
>     directory-locking
>     dax
>     devpts
> +   dnotify
>  
>     automount-support
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 511d19bcfa1e..eebb55517709 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4995,7 +4995,7 @@ M:	Jan Kara <jack@suse.cz>
>  R:	Amir Goldstein <amir73il@gmail.com>
>  L:	linux-fsdevel@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/filesystems/dnotify.txt
> +F:	Documentation/filesystems/dnotify.rst
>  F:	fs/notify/dnotify/
>  F:	include/linux/dnotify.h
>  
> -- 
> 2.25.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50EAE16215C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 08:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgBRHK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 02:10:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:36386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgBRHK6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:10:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 36FB2AEF6;
        Tue, 18 Feb 2020 07:10:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CB5611E0CF7; Tue, 18 Feb 2020 08:10:54 +0100 (CET)
Date:   Tue, 18 Feb 2020 08:10:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH 24/44] docs: filesystems: convert inotify.txt to ReST
Message-ID: <20200218071054.GA16121@quack2.suse.cz>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
 <8f846843ecf1914988feb4d001e3a53d27dc1a65.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f846843ecf1914988feb4d001e3a53d27dc1a65.1581955849.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 17-02-20 17:12:10, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Add a document title;
> - Adjust document title;
> - Fix list markups;
> - Some whitespace fixes and new line breaks;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks. You can add:

Acked-by: Jan Kara <jack@suse.cz>

or tell me if you want me to pick up this patch.

								Honza

> ---
>  Documentation/filesystems/index.rst           |  1 +
>  .../filesystems/{inotify.txt => inotify.rst}  | 33 ++++++++++++-------
>  2 files changed, 23 insertions(+), 11 deletions(-)
>  rename Documentation/filesystems/{inotify.txt => inotify.rst} (83%)
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 3fbe2fa0b5c5..5a737722652c 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -70,6 +70,7 @@ Documentation for filesystem implementations.
>     hfs
>     hfsplus
>     hpfs
> +   inotify
>     fuse
>     overlayfs
>     virtiofs
> diff --git a/Documentation/filesystems/inotify.txt b/Documentation/filesystems/inotify.rst
> similarity index 83%
> rename from Documentation/filesystems/inotify.txt
> rename to Documentation/filesystems/inotify.rst
> index 51f61db787fb..7f7ef8af0e1e 100644
> --- a/Documentation/filesystems/inotify.txt
> +++ b/Documentation/filesystems/inotify.rst
> @@ -1,27 +1,36 @@
> -				   inotify
> -	    a powerful yet simple file change notification system
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============================================================
> +Inotify - A Powerful yet Simple File Change Notification System
> +===============================================================
>  
>  
>  
>  Document started 15 Mar 2005 by Robert Love <rml@novell.com>
> +
>  Document updated 4 Jan 2015 by Zhang Zhen <zhenzhang.zhang@huawei.com>
> -	--Deleted obsoleted interface, just refer to manpages for user interface.
> +
> +	- Deleted obsoleted interface, just refer to manpages for user interface.
>  
>  (i) Rationale
>  
> -Q: What is the design decision behind not tying the watch to the open fd of
> +Q:
> +   What is the design decision behind not tying the watch to the open fd of
>     the watched object?
>  
> -A: Watches are associated with an open inotify device, not an open file.
> +A:
> +   Watches are associated with an open inotify device, not an open file.
>     This solves the primary problem with dnotify: keeping the file open pins
>     the file and thus, worse, pins the mount.  Dnotify is therefore infeasible
>     for use on a desktop system with removable media as the media cannot be
>     unmounted.  Watching a file should not require that it be open.
>  
> -Q: What is the design decision behind using an-fd-per-instance as opposed to
> +Q:
> +   What is the design decision behind using an-fd-per-instance as opposed to
>     an fd-per-watch?
>  
> -A: An fd-per-watch quickly consumes more file descriptors than are allowed,
> +A:
> +   An fd-per-watch quickly consumes more file descriptors than are allowed,
>     more fd's than are feasible to manage, and more fd's than are optimally
>     select()-able.  Yes, root can bump the per-process fd limit and yes, users
>     can use epoll, but requiring both is a silly and extraneous requirement.
> @@ -29,8 +38,8 @@ A: An fd-per-watch quickly consumes more file descriptors than are allowed,
>     spaces is thus sensible.  The current design is what user-space developers
>     want: Users initialize inotify, once, and add n watches, requiring but one
>     fd and no twiddling with fd limits.  Initializing an inotify instance two
> -   thousand times is silly.  If we can implement user-space's preferences 
> -   cleanly--and we can, the idr layer makes stuff like this trivial--then we 
> +   thousand times is silly.  If we can implement user-space's preferences
> +   cleanly--and we can, the idr layer makes stuff like this trivial--then we
>     should.
>  
>     There are other good arguments.  With a single fd, there is a single
> @@ -65,9 +74,11 @@ A: An fd-per-watch quickly consumes more file descriptors than are allowed,
>     need not be a one-fd-per-process mapping; it is one-fd-per-queue and a
>     process can easily want more than one queue.
>  
> -Q: Why the system call approach?
> +Q:
> +   Why the system call approach?
>  
> -A: The poor user-space interface is the second biggest problem with dnotify.
> +A:
> +   The poor user-space interface is the second biggest problem with dnotify.
>     Signals are a terrible, terrible interface for file notification.  Or for
>     anything, for that matter.  The ideal solution, from all perspectives, is a
>     file descriptor-based one that allows basic file I/O and poll/select.
> -- 
> 2.24.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

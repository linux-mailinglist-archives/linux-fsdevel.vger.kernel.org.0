Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F23A161E7A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 02:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgBRBV4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 20:21:56 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:46560 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbgBRBV4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 20:21:56 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TqC7pSS_1581988911;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TqC7pSS_1581988911)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Feb 2020 09:21:51 +0800
Subject: Re: [PATCH 12/44] docs: filesystems: convert dlmfs.txt to ReST
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
 <efc9e59925723e17d1a4741b11049616c221463e.1581955849.git.mchehab+huawei@kernel.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <3b40d7d4-3798-08db-220d-b45704ada48a@linux.alibaba.com>
Date:   Tue, 18 Feb 2020 09:21:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <efc9e59925723e17d1a4741b11049616c221463e.1581955849.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 20/2/18 00:11, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Use copyright symbol;
> - Adjust document title;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add table markups;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../filesystems/{dlmfs.txt => dlmfs.rst}      | 28 +++++++++++++------
>  Documentation/filesystems/index.rst           |  1 +
>  2 files changed, 20 insertions(+), 9 deletions(-)
>  rename Documentation/filesystems/{dlmfs.txt => dlmfs.rst} (86%)
> 
> diff --git a/Documentation/filesystems/dlmfs.txt b/Documentation/filesystems/dlmfs.rst
> similarity index 86%
> rename from Documentation/filesystems/dlmfs.txt
> rename to Documentation/filesystems/dlmfs.rst
> index fcf4d509d118..68daaa7facf9 100644
> --- a/Documentation/filesystems/dlmfs.txt
> +++ b/Documentation/filesystems/dlmfs.rst
> @@ -1,20 +1,25 @@
> -dlmfs
> -==================
> +.. SPDX-License-Identifier: GPL-2.0
> +.. include:: <isonum.txt>
> +
> +=====
> +DLMFS
> +=====
> +
>  A minimal DLM userspace interface implemented via a virtual file
>  system.
>  
>  dlmfs is built with OCFS2 as it requires most of its infrastructure.
>  
> -Project web page:    http://ocfs2.wiki.kernel.org
> -Tools web page:      https://github.com/markfasheh/ocfs2-tools
> -OCFS2 mailing lists: http://oss.oracle.com/projects/ocfs2/mailman/
> +:Project web page:    http://ocfs2.wiki.kernel.org
> +:Tools web page:      https://github.com/markfasheh/ocfs2-tools
> +:OCFS2 mailing lists: http://oss.oracle.com/projects/ocfs2/mailman/
>  
>  All code copyright 2005 Oracle except when otherwise noted.
>  
> -CREDITS
> +Credits
>  =======
>  
> -Some code taken from ramfs which is Copyright (C) 2000 Linus Torvalds
> +Some code taken from ramfs which is Copyright |copy| 2000 Linus Torvalds
>  and Transmeta Corp.
>  
>  Mark Fasheh <mark.fasheh@oracle.com>
> @@ -96,14 +101,19 @@ operation. If the lock succeeds, you'll get an fd.
>  open(2) with O_CREAT to ensure the resource inode is created - dlmfs does
>  not automatically create inodes for existing lock resources.
>  
> +============  ===========================
>  Open Flag     Lock Request Type
> ----------     -----------------

Better to remove the above line.

> +============  ===========================
>  O_RDONLY      Shared Read
>  O_RDWR        Exclusive
> +============  ===========================
>  
> +
> +============  ===========================
>  Open Flag     Resulting Locking Behavior
> ----------     --------------------------

Ditto.

> +============  ===========================
>  O_NONBLOCK    Trylock operation
> +============  ===========================
>  
>  You must provide exactly one of O_RDONLY or O_RDWR.
>  
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index ab3b656bbe60..c6885c7ef781 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -58,6 +58,7 @@ Documentation for filesystem implementations.
>     ceph
>     cramfs
>     debugfs
> +   dlmfs
>     fuse
>     overlayfs
>     virtiofs
> 

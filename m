Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1F7161E7C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 02:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgBRBXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 20:23:09 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56072 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbgBRBXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 20:23:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TqCLohQ_1581988985;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TqCLohQ_1581988985)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Feb 2020 09:23:05 +0800
Subject: Re: [PATCH 29/44] docs: filesystems: convert ocfs2.txt to ReST
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>, ocfs2-devel@oss.oracle.com
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
 <e29a8120bf1d847f23fb68e915f10a7d43bed9e3.1581955849.git.mchehab+huawei@kernel.org>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <740bc2d9-06b3-c59a-3447-72e58bed4fdc@linux.alibaba.com>
Date:   Tue, 18 Feb 2020 09:23:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <e29a8120bf1d847f23fb68e915f10a7d43bed9e3.1581955849.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 20/2/18 00:12, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Adjust document title;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Looks good.

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  Documentation/filesystems/index.rst           |  1 +
>  .../filesystems/{ocfs2.txt => ocfs2.rst}      | 31 +++++++++++++------
>  2 files changed, 22 insertions(+), 10 deletions(-)
>  rename Documentation/filesystems/{ocfs2.txt => ocfs2.rst} (88%)
> 
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index f3a26fdbd04f..3b2b07491c98 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -76,6 +76,7 @@ Documentation for filesystem implementations.
>     nilfs2
>     nfs/index
>     ntfs
> +   ocfs2
>     ocfs2-online-filecheck
>     overlayfs
>     virtiofs
> diff --git a/Documentation/filesystems/ocfs2.txt b/Documentation/filesystems/ocfs2.rst
> similarity index 88%
> rename from Documentation/filesystems/ocfs2.txt
> rename to Documentation/filesystems/ocfs2.rst
> index 4c49e5410595..412386bc6506 100644
> --- a/Documentation/filesystems/ocfs2.txt
> +++ b/Documentation/filesystems/ocfs2.rst
> @@ -1,5 +1,9 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================
>  OCFS2 filesystem
> -==================
> +================
> +
>  OCFS2 is a general purpose extent based shared disk cluster file
>  system with many similarities to ext3. It supports 64 bit inode
>  numbers, and has automatically extending metadata groups which may
> @@ -14,22 +18,26 @@ OCFS2 mailing lists: http://oss.oracle.com/projects/ocfs2/mailman/
>  
>  All code copyright 2005 Oracle except when otherwise noted.
>  
> -CREDITS:
> +Credits
> +=======
> +
>  Lots of code taken from ext3 and other projects.
>  
>  Authors in alphabetical order:
> -Joel Becker   <joel.becker@oracle.com>
> -Zach Brown    <zach.brown@oracle.com>
> -Mark Fasheh   <mfasheh@suse.com>
> -Kurt Hackel   <kurt.hackel@oracle.com>
> -Tao Ma        <tao.ma@oracle.com>
> -Sunil Mushran <sunil.mushran@oracle.com>
> -Manish Singh  <manish.singh@oracle.com>
> -Tiger Yang    <tiger.yang@oracle.com>
> +
> +- Joel Becker   <joel.becker@oracle.com>
> +- Zach Brown    <zach.brown@oracle.com>
> +- Mark Fasheh   <mfasheh@suse.com>
> +- Kurt Hackel   <kurt.hackel@oracle.com>
> +- Tao Ma        <tao.ma@oracle.com>
> +- Sunil Mushran <sunil.mushran@oracle.com>
> +- Manish Singh  <manish.singh@oracle.com>
> +- Tiger Yang    <tiger.yang@oracle.com>
>  
>  Caveats
>  =======
>  Features which OCFS2 does not support yet:
> +
>  	- Directory change notification (F_NOTIFY)
>  	- Distributed Caching (F_SETLEASE/F_GETLEASE/break_lease)
>  
> @@ -37,8 +45,10 @@ Mount options
>  =============
>  
>  OCFS2 supports the following mount options:
> +
>  (*) == default
>  
> +======================= ========================================================
>  barrier=1		This enables/disables barriers. barrier=0 disables it,
>  			barrier=1 enables it.
>  errors=remount-ro(*)	Remount the filesystem read-only on an error.
> @@ -104,3 +114,4 @@ journal_async_commit	Commit block can be written to disk without waiting
>  			for descriptor blocks. If enabled older kernels cannot
>  			mount the device. This will enable 'journal_checksum'
>  			internally.
> +======================= ========================================================
> 

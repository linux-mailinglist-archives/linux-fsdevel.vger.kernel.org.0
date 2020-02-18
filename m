Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C731D16215F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Feb 2020 08:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgBRHLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 02:11:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:36772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgBRHLh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:11:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5CCECAF21;
        Tue, 18 Feb 2020 07:11:35 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8C8F61E0CF7; Tue, 18 Feb 2020 08:11:34 +0100 (CET)
Date:   Tue, 18 Feb 2020 08:11:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 16/44] docs: filesystems: convert ext2.txt to ReST
Message-ID: <20200218071134.GB16121@quack2.suse.cz>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
 <fde6721f0303259d830391e351dbde48f67f3ec7.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fde6721f0303259d830391e351dbde48f67f3ec7.1581955849.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 17-02-20 17:12:02, Mauro Carvalho Chehab wrote:
> - Add a SPDX header;
> - Some whitespace fixes and new line breaks;
> - Mark literal blocks as such;
> - Add table markups;
> - Use footnoote markups;
> - Add it to filesystems/index.rst.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks! You can add:

Acked-by: Jan Kara <jack@suse.cz>

Again, please tell me if you want me to pickup this patch.

								Honza

> ---
>  .../filesystems/{ext2.txt => ext2.rst}        | 41 ++++++++++++-------
>  Documentation/filesystems/index.rst           |  1 +
>  2 files changed, 27 insertions(+), 15 deletions(-)
>  rename Documentation/filesystems/{ext2.txt => ext2.rst} (91%)
> 
> diff --git a/Documentation/filesystems/ext2.txt b/Documentation/filesystems/ext2.rst
> similarity index 91%
> rename from Documentation/filesystems/ext2.txt
> rename to Documentation/filesystems/ext2.rst
> index 94c2cf0292f5..d83dbbb162e2 100644
> --- a/Documentation/filesystems/ext2.txt
> +++ b/Documentation/filesystems/ext2.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  
>  The Second Extended Filesystem
>  ==============================
> @@ -14,8 +16,9 @@ Options
>  Most defaults are determined by the filesystem superblock, and can be
>  set using tune2fs(8). Kernel-determined defaults are indicated by (*).
>  
> -bsddf			(*)	Makes `df' act like BSD.
> -minixdf				Makes `df' act like Minix.
> +====================    ===     ================================================
> +bsddf			(*)	Makes ``df`` act like BSD.
> +minixdf				Makes ``df`` act like Minix.
>  
>  check=none, nocheck	(*)	Don't do extra checking of bitmaps on mount
>  				(check=normal and check=strict options removed)
> @@ -62,6 +65,7 @@ quota, usrquota			Enable user disk quota support
>  
>  grpquota			Enable group disk quota support
>  				(requires CONFIG_QUOTA).
> +====================    ===     ================================================
>  
>  noquota option ls silently ignored by ext2.
>  
> @@ -294,9 +298,9 @@ respective fsck programs.
>  If you're exceptionally paranoid, there are 3 ways of making metadata
>  writes synchronous on ext2:
>  
> -per-file if you have the program source: use the O_SYNC flag to open()
> -per-file if you don't have the source: use "chattr +S" on the file
> -per-filesystem: add the "sync" option to mount (or in /etc/fstab)
> +- per-file if you have the program source: use the O_SYNC flag to open()
> +- per-file if you don't have the source: use "chattr +S" on the file
> +- per-filesystem: add the "sync" option to mount (or in /etc/fstab)
>  
>  the first and last are not ext2 specific but do force the metadata to
>  be written synchronously.  See also Journaling below.
> @@ -316,10 +320,12 @@ Most of these limits could be overcome with slight changes in the on-disk
>  format and using a compatibility flag to signal the format change (at
>  the expense of some compatibility).
>  
> -Filesystem block size:     1kB        2kB        4kB        8kB
> -
> -File size limit:          16GB      256GB     2048GB     2048GB
> -Filesystem size limit:  2047GB     8192GB    16384GB    32768GB
> +=====================  =======    =======    =======   ========
> +Filesystem block size      1kB        2kB        4kB        8kB
> +=====================  =======    =======    =======   ========
> +File size limit           16GB      256GB     2048GB     2048GB
> +Filesystem size limit   2047GB     8192GB    16384GB    32768GB
> +=====================  =======    =======    =======   ========
>  
>  There is a 2.4 kernel limit of 2048GB for a single block device, so no
>  filesystem larger than that can be created at this time.  There is also
> @@ -370,19 +376,24 @@ ext4 and journaling.
>  References
>  ==========
>  
> +=======================	===============================================
>  The kernel source	file:/usr/src/linux/fs/ext2/
>  e2fsprogs (e2fsck)	http://e2fsprogs.sourceforge.net/
>  Design & Implementation	http://e2fsprogs.sourceforge.net/ext2intro.html
>  Journaling (ext3)	ftp://ftp.uk.linux.org/pub/linux/sct/fs/jfs/
>  Filesystem Resizing	http://ext2resize.sourceforge.net/
> -Compression (*)		http://e2compr.sourceforge.net/
> +Compression [1]_	http://e2compr.sourceforge.net/
> +=======================	===============================================
>  
>  Implementations for:
> +
> +=======================	===========================================================
>  Windows 95/98/NT/2000	http://www.chrysocome.net/explore2fs
> -Windows 95 (*)		http://www.yipton.net/content.html#FSDEXT2
> -DOS client (*)		ftp://metalab.unc.edu/pub/Linux/system/filesystems/ext2/
> -OS/2 (+)		ftp://metalab.unc.edu/pub/Linux/system/filesystems/ext2/
> +Windows 95 [1]_		http://www.yipton.net/content.html#FSDEXT2
> +DOS client [1]_		ftp://metalab.unc.edu/pub/Linux/system/filesystems/ext2/
> +OS/2 [2]_		ftp://metalab.unc.edu/pub/Linux/system/filesystems/ext2/
>  RISC OS client		http://www.esw-heim.tu-clausthal.de/~marco/smorbrod/IscaFS/
> +=======================	===========================================================
>  
> -(*) no longer actively developed/supported (as of Apr 2001)
> -(+) no longer actively developed/supported (as of Mar 2009)
> +.. [1] no longer actively developed/supported (as of Apr 2001)
> +.. [2] no longer actively developed/supported (as of Mar 2009)
> diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
> index 03a493b27920..102b3b65486a 100644
> --- a/Documentation/filesystems/index.rst
> +++ b/Documentation/filesystems/index.rst
> @@ -62,6 +62,7 @@ Documentation for filesystem implementations.
>     ecryptfs
>     efivarfs
>     erofs
> +   ext2
>     fuse
>     overlayfs
>     virtiofs
> -- 
> 2.24.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3C41BD232
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 04:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgD2CVW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 22:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgD2CVW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:21:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109A3C03C1AC;
        Tue, 28 Apr 2020 19:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=cKGLOpBW4qS3y+pSSeknlOPB4GuywQqaIP5NAkI3phg=; b=TOAaZYbwlvmhe7a3bX4UBPMl8g
        MxcFA1SBtsecnMjpu3Xk2gQq1t3UYHkPjlxkb1XBkCTLFiaSstXR0YMJ6Bt7dQo1nUEuh34Dd2Lgx
        6BG+shZqj4pzsEgQ0yQ4AhxIsjeqHs58A08N8BmTC24Tng+tWHLnDLDIq5EN8RiL+FatAP4Y2SVAD
        LTiuuGbqAUoHI30oREXQHNdova4wUbypSpixAb2H5dMjoxaBug59Kae1ekAY9eKHDg3+EiRFdF/5z
        6370HWQBCKHo7Up+IGGFD4p2M15KpKerbW+SX9j+MNsfoX6aX49U+oXXwaibqIvS6caji1SBFlrEC
        mgbkL1SQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTcLg-0002L2-Ph; Wed, 29 Apr 2020 02:21:20 +0000
Subject: Re: [PATCH V11.1] Documentation/dax: Update Usage section
To:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20200428002142.404144-5-ira.weiny@intel.com>
 <20200428222145.409961-1-ira.weiny@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <28f97c0b-6c7f-7496-b57d-0342a4dcc0af@infradead.org>
Date:   Tue, 28 Apr 2020 19:21:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428222145.409961-1-ira.weiny@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/28/20 3:21 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Update the Usage section to reflect the new individual dax selection
> functionality.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V11:
> 	Minor changes from Darrick
> 
> Changes from V10:
> 	Clarifications from Dave
> 	Add '-c' to xfs_io examples
> 
> Changes from V9:
> 	Fix missing ')'
> 	Fix trialing '"'

trailing

> 
> Changes from V8:
> 	Updates from Darrick
> 
> Changes from V7:
> 	Cleanups/clarifications from Darrick and Dan
> 
> Changes from V6:
> 	Update to allow setting FS_XFLAG_DAX any time.
> 	Update with list of behaviors from Darrick
> 	https://lore.kernel.org/lkml/20200409165927.GD6741@magnolia/
> 
> Changes from V5:
> 	Update to reflect the agreed upon semantics
> 	https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
> ---
>  Documentation/filesystems/dax.txt | 142 +++++++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
> index 679729442fd2..dc1c1aa36cc2 100644
> --- a/Documentation/filesystems/dax.txt
> +++ b/Documentation/filesystems/dax.txt
> @@ -17,11 +17,147 @@ For file mappings, the storage device is mapped directly into userspace.
>  Usage
>  -----
>  
> -If you have a block device which supports DAX, you can make a filesystem
> +If you have a block device which supports DAX, you can make a file system
>  on it as usual.  The DAX code currently only supports files with a block
>  size equal to your kernel's PAGE_SIZE, so you may need to specify a block
> -size when creating the filesystem.  When mounting it, use the "-o dax"
> -option on the command line or add 'dax' to the options in /etc/fstab.
> +size when creating the file system.
> +
> +Currently 3 filesystems support DAX: ext2, ext4 and xfs.  Enabling DAX on them

Why "file system" in the first paragraph when "filesystem" is used here and below?

> +is different.
> +
> +Enabling DAX on ext4 and ext2
> +-----------------------------
> +
> +When mounting the filesystem, use the "-o dax" option on the command line or
> +add 'dax' to the options in /etc/fstab.  This works to enable DAX on all files
> +within the filesystem.  It is equivalent to the '-o dax=always' behavior below.
> +
> +
> +Enabling DAX on xfs
> +-------------------
> +
> +Summary
> +-------
> +
> + 1. There exists an in-kernel file access mode flag S_DAX that corresponds to
> +    the statx flag STATX_ATTR_DAX.  See the manpage for statx(2) for details
> +    about this access mode.
> +
> + 2. There exists a persistent flag FS_XFLAG_DAX that can be applied to regular
> +    files and directories. This advisory flag can be set or cleared at any
> +    time, but doing so does not immediately affect the S_DAX state.
> +
> + 3. If the persistent FS_XFLAG_DAX flag is set on a directory, this flag will
> +    be inherited by all regular files and subdirectories that are subsequently
> +    created in this directory. Files and subdirectories that exist at the time
> +    this flag is set or cleared on the parent directory are not modified by
> +    this modification of the parent directory.
> +
> + 4. There exists dax mount options which can override FS_XFLAG_DAX in the

             exist

> +    setting of the S_DAX flag.  Given underlying storage which supports DAX the
> +    following hold:
> +
> +    "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.
> +
> +    "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."
> +
> +    "-o dax=always" means "always set S_DAX ignore FS_XFLAG_DAX."
> +
> +    "-o dax"        is a legacy option which is an alias for "dax=always".
> +		    This may be removed in the future so "-o dax=always" is
> +		    the preferred method for specifying this behavior.
> +
> +    NOTE: Modifications to and the inheritance behavior of FS_XFLAG_DAX remain
> +    the same even when the file system is mounted with a dax option.  However,
> +    in-core inode state (S_DAX) will be overridden until the file system is

                                     "file system" (2 times above)

> +    remounted with dax=inode and the inode is evicted from kernel memory.
> +
> + 5. The S_DAX policy can be changed via:
> +
> +    a) Setting the parent directory FS_XFLAG_DAX as needed before files are
> +       created
> +
> +    b) Setting the appropriate dax="foo" mount option
> +
> +    c) Changing the FS_XFLAG_DAX on existing regular files and directories.

                       FS_XFLAGS_DAX flag on

> +       This has runtime constraints and limitations that are described in 6)
> +       below.
> +
> + 6. When changing the S_DAX policy via toggling the persistent FS_XFLAG_DAX flag,
> +    the change in behaviour for existing regular files may not occur
> +    immediately.  If the change must take effect immediately, the administrator
> +    needs to:
> +
> +    a) stop the application so there are no active references to the data set
> +       the policy change will affect
> +
> +    b) evict the data set from kernel caches so it will be re-instantiated when
> +       the application is restarted. This can be achieved by:
> +
> +       i. drop-caches
> +       ii. a filesystem unmount and mount cycle

filesystem

> +       iii. a system reboot
> +
> +
> +Details
> +-------
> +
> +There are 2 per-file dax flags.  One is a persistent inode setting (FS_XFLAG_DAX)
> +and the other is a volatile flag indicating the active state of the feature
> +(S_DAX).
> +
> +FS_XFLAG_DAX is preserved within the file system.  This persistent config

file system

> +setting can be set, cleared and/or queried using the FS_IOC_FS[GS]ETXATTR ioctl
> +(see ioctl_xfs_fsgetxattr(2)) or an utility such as 'xfs_io'.
> +
> +New files and directories automatically inherit FS_XFLAG_DAX from
> +their parent directory _when_ _created_.  Therefore, setting FS_XFLAG_DAX at
> +directory creation time can be used to set a default behavior for an entire
> +sub-tree.
> +
> +To clarify inheritance, here are 3 examples:
> +
> +Example A:
> +
> +mkdir -p a/b/c
> +xfs_io -c 'chattr +x' a
> +mkdir a/b/c/d
> +mkdir a/e
> +
> +	dax: a,e
> +	no dax: b,c,d
> +
> +Example B:
> +
> +mkdir a
> +xfs_io -c 'chattr +x' a
> +mkdir -p a/b/c/d
> +
> +	dax: a,b,c,d
> +	no dax:
> +
> +Example C:
> +
> +mkdir -p a/b/c
> +xfs_io -c 'chattr +x' c
> +mkdir a/b/c/d
> +
> +	dax: c,d
> +	no dax: a,b
> +
> +
> +The current enabled state (S_DAX) is set when a file inode is instantiated in
> +memory by the kernel.  It is set based on the underlying media support, the
> +value of FS_XFLAG_DAX and the file system's dax mount option.
> +
> +statx can be used to query S_DAX.  NOTE that only regular files will ever have
> +S_DAX set and therefore statx will never indicate that S_DAX is set on
> +directories.
> +
> +Setting the FS_XFLAG_DAX (specifically or through inheritance) occurs even if

           the FS_XFLAG_DAX flag

> +the underlying media does not support dax and/or the file system is overridden

file system

Just be consistent, please.

> +with a mount option.
> +
>  
>  
>  Implementation Tips for Block Driver Writers
> 

thanks.
-- 
~Randy


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A31F1AABE8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 17:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636872AbgDOPaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 11:30:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41548 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393140AbgDOPaA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:30:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FFJrXp085881;
        Wed, 15 Apr 2020 15:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=dY7Fz+8QuziNjodegq/yd3qaKlCXDX93epdc7PV1U/M=;
 b=Hcg2Cs2RNDtlGAM3pyshZdbMoxm5tJSH+WKTT8yZngxnK7PD3h4OCFy04Ajn8wIhyc8F
 Lds7svvJ7K5rOEVF9Ecf3P5brYoOLkrb96GCd1SWV13flv0MevhGvntJNTYjTmOvI05c
 wALAxcgUst7EWj2Mcn534Ys/ks9u7/eiNtTjoOzAam558IINlRPkoZN2FF5x0zXw0Xgv
 1XA55QiEsLyk9g+0R0diZlEzK7PmvqFqnqEdOjkrSqXB4/r39SXcSiPEcmsE/mY67RqY
 z0PzPQtq6hf8Bx3Ed0Hg7w/XLFxbUTNMF3QNeiiX5j0rv0/QInZH7tCd36hb6QaXTWrU QA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30e0bf9kvq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:29:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03FFJ38G179824;
        Wed, 15 Apr 2020 15:29:46 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30dyvf0ktn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 15:29:46 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03FFTiXV008317;
        Wed, 15 Apr 2020 15:29:44 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Apr 2020 08:29:44 -0700
Date:   Wed, 15 Apr 2020 08:29:42 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V8 11/11] Documentation/dax: Update Usage section
Message-ID: <20200415152942.GS6742@magnolia>
References: <20200415064523.2244712-1-ira.weiny@intel.com>
 <20200415064523.2244712-12-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415064523.2244712-12-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004150114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150114
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:45:23PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Update the Usage section to reflect the new individual dax selection
> functionality.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
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
>  Documentation/filesystems/dax.txt | 166 +++++++++++++++++++++++++++++-
>  1 file changed, 163 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
> index 679729442fd2..893820c53f49 100644
> --- a/Documentation/filesystems/dax.txt
> +++ b/Documentation/filesystems/dax.txt
> @@ -17,11 +17,171 @@ For file mappings, the storage device is mapped directly into userspace.
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
> +Currently 3 filesystems support DAX, ext2, ext4 and xfs.  Enabling DAX on them

"...support DAX: ext2, ext4..."

Please put a colon after "DAX" since it's not part of the list.

> +is different.
> +
> +Enabling DAX on ext4 and ext2
> +-----------------------------
> +
> +When mounting the filesystem, use the "-o dax" option on the command line or
> +add 'dax' to the options in /etc/fstab.  This works to enable DAX on all files
> +within the filesystem.  It is equivalent to the '-o dax=always' behavior below
> +with the exception that the STATX_ATTR_DAX flag is not supported, nor needed,
> +as it is always true.

STATX_ATTR_DAX isn't supported?  I thought ext[24] set S_DAX, so the
statx flag should work the same as it does on xfs?

I also wonder if it's worth mentioning that in the long run ext4 will
match the xfs semantics, but maybe that's better left for the ext4 rfc
series.

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
> + 2. There exists an advisory file inode flag FS_XFLAG_DAX that is
> +    inherited from the parent directory FS_XFLAG_DAX inode flag at file
> +    creation time.  This advisory flag can be set or cleared at any
> +    time, but doing so does not immediately affect the S_DAX state.
> +
> +    Unless overridden by mount options (see (3)), if FS_XFLAG_DAX is set
> +    and the fs is on pmem then it will enable S_DAX at inode load time;
> +    if FS_XFLAG_DAX is not set, it will not enable S_DAX.
> +
> + 3. There exists a dax= mount option.
> +
> +    "-o dax=never"  means "never set S_DAX, ignore FS_XFLAG_DAX."
> +
> +    "-o dax=always" means "always set S_DAX (at least on pmem),
> +                    and ignore FS_XFLAG_DAX."
> +
> +    "-o dax"        is an alias for "dax=always".
> +
> +    "-o dax=inode"  means "follow FS_XFLAG_DAX" and is the default.
> +
> + 4. There exists an advisory directory inode flag FS_XFLAG_DAX that can
> +    be set or cleared at any time.  The flag state is inherited by any files or
> +    subdirectories when they are created within that directory.
> +
> + 5. Programs that require a specific file access mode (DAX or not DAX)
> +    can do one of the following:
> +
> +    (a) Create files in directories that the FS_XFLAG_DAX flag set as
> +        needed; or
> +
> +    (b) Have the administrator set an override via mount option; or
> +
> +    (c) Set or clear the file's FS_XFLAG_DAX flag as needed.  Programs
> +        must then cause the kernel to evict the inode from memory.  This
> +        can be done by:
> +
> +        i>  Closing the file and re-opening the file and using statx to
> +            see if the fs has changed the S_DAX flag; and
> +
> +        ii> If the file still does not have the desired S_DAX access
> +            mode, either unmount and remount the filesystem, or close
> +            the file and use drop_caches.
> +
> + 6. It is expected that users who want to squeeze every last bit of performance
> +    out of the particular rough and tumble bits of their storage will also be
> +    exposed to the difficulties of what happens when the operating system can't
> +    totally virtualize those hardware capabilities.  DAX is such a feature.
> +
> +
> +Details
> +-------
> +
> +There are 2 per-file dax flags.  One is a physical inode setting (FS_XFLAG_DAX)
> +and the other a currently enabled state (S_DAX).
> +
> +FS_XFLAG_DAX is maintained, on disk, on individual inodes.  It is preserved
> +within the file system.  This 'physical' config setting can be set using an
> +ioctl and/or an application such as "xfs_io -c 'chattr [-+]x'".  Files and
> +directories automatically inherit FS_XFLAG_DAX from their parent directory
> +_when_ _created_.  Therefore, setting FS_XFLAG_DAX at directory creation time
> +can be used to set a default behavior for an entire sub-tree.  (Doing so on the
> +root directory acts to set a default for the entire file system.)

Urk, I guess I need to push that patch to make mkfs.xfs do this. ;)

> +To clarify inheritance here are 3 examples:
> +
> +Example A:
> +
> +mkdir -p a/b/c
> +xfs_io 'chattr +x' a
> +mkdir a/b/c/d
> +mkdir a/e
> +
> +	dax: a,e
> +	no dax: b,c,d
> +
> +Example B:
> +
> +mkdir a
> +xfs_io 'chattr +x' a
> +mkdir -p a/b/c/d
> +
> +	dax: a,b,c,d
> +	no dax:
> +
> +Example C:
> +
> +mkdir -p a/b/c
> +xfs_io 'chattr +x' c
> +mkdir a/b/c/d
> +
> +	dax: c,d
> +	no dax: a,b
> +
> +
> +The current enabled state (S_DAX) is set when a file inode is _loaded_ based on
> +the underlying media support, the value of FS_XFLAG_DAX, and the file systems
> +dax mount option setting.  See below.
> +
> +statx can be used to query S_DAX.  NOTE that a directory will never have S_DAX
> +set and therefore statx will never indicate that S_DAX is set on directories.
> +
> +NOTE: Setting the FS_XFLAG_DAX (specifically or through inheritance) occurs
> +even if the underlying media does not support dax and/or the file system is
> +overridden with a mount option.
> +
> +
> +Overriding FS_XFLAG_DAX (dax= mount option)
> +-------------------------------------------
> +
> +There exists a dax mount option.  Using the mount option does not change the
> +physical configured state of individual files but overrides the S_DAX operating
> +state when inodes are loaded.
> +
> +Given underlying media support, the dax mount option is a tri-state option
> +(never, always, inode) with the following meanings:
> +
> +   "-o dax=never" means "never set S_DAX, ignore FS_XFLAG_DAX"
> +   "-o dax=always" means "always set S_DAX, ignore FS_XFLAG_DAX"
> +        "-o dax" by itself means "dax=always" to remain compatible with older
> +	         kernels
> +   "-o dax=inode" means "follow FS_XFLAG_DAX"
> +
> +The default state is 'inode'.  Given underlying media support, the following
> +algorithm is used to determine the effective mode of the file S_DAX on a
> +capable device.
> +
> +	S_DAX = FS_XFLAG_DAX;
> +
> +	if (dax_mount == "always")
> +		S_DAX = true;
> +	else if (dax_mount == "off"
> +		S_DAX = false;

The logic in this pseudocode doesn't match the order that's in
xfs_inode_enable_dax.  I think the outcome is the same, but it's easier
to verify that if the statements are in roughly the same order.

	if dax=never:
		S_DAX = false
	elif the file system and media don't both support DAX:
		S_DAX = false
	elif dax=always:
		S_DAX = true
	else:
		S_DAX = inode flag status

--D

> +
> +To reiterate: Setting, and inheritance, continues to affect FS_XFLAG_DAX even
> +while the file system is mounted with a dax override.  However, in-core inode
> +state (S_DAX) will continue to be overridden until the filesystem is remounted
> +with dax=inode and the inode is evicted."
>  
>  
>  Implementation Tips for Block Driver Writers
> -- 
> 2.25.1
> 

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB38C1A69B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Apr 2020 18:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731445AbgDMQT2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Apr 2020 12:19:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:49536 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbgDMQT1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:19:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DGJHqe083245;
        Mon, 13 Apr 2020 16:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=YJU6HlQqS/nwIZeFXkDwYcE2QyTAfB5Ec7sJE/JFGpI=;
 b=n24vJWBZxI5JFE6YXnfl1Kd/WBKx6YiX89PN1hc8fmZEH0StJ1jI1/E2LfALihrZSyYP
 VmPDKHWl1fmoweRcsxk2Bll5rKo/NAjK4dwAk8GRjvdthq1r2As0ATROZ+YfXMj0XEf+
 a9m+3HBARZTiR2qJzz1wt5fSmsY+x82883kz+KEzDoAvms/9eLXSvbn2FO2rje2/NPLv
 1ZCxpuyeosjY9BCa175JwhoBEJvDuzGN2mlIF6hs6KdCRFDwYTyutGx3vI3qEPeIme+K
 03usrLXvmGlOs6drylsbAYl0DB27WtwY5YzjRaJzUyNyuN5OrEDUcBhmLGqlGQpLQ/lB Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 30b6hpfef5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 16:19:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03DGGsWe027463;
        Mon, 13 Apr 2020 16:19:16 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 30bqkxnnu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Apr 2020 16:19:16 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03DGJEcr006215;
        Mon, 13 Apr 2020 16:19:15 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 13 Apr 2020 09:19:14 -0700
Date:   Mon, 13 Apr 2020 09:19:12 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V7 9/9] Documentation/dax: Update Usage section
Message-ID: <20200413161912.GZ6742@magnolia>
References: <20200413054046.1560106-1-ira.weiny@intel.com>
 <20200413054046.1560106-10-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413054046.1560106-10-ira.weiny@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9590 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004130124
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:40:46PM -0700, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Update the Usage section to reflect the new individual dax selection
> functionality.

Yum. :)

> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
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
> index 679729442fd2..af14c1b330a9 100644
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
> +Currently 2 filesystems support DAX, ext4 and xfs.  Enabling DAX on them is
> +different at this time.

I thought ext2 supports DAX?

> +Enabling DAX on ext4
> +--------------------
> +
> +When mounting the filesystem, use the "-o dax" option on the command line or
> +add 'dax' to the options in /etc/fstab.
> +
> +
> +Enabling DAX on xfs
> +-------------------
> +
> +Summary
> +-------
> +
> + 1. There exists an in-kernel access mode flag S_DAX that is set when
> +    file accesses go directly to persistent memory, bypassing the page
> +    cache.  Applications must call statx to discover the current S_DAX
> +    state (STATX_ATTR_DAX).
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
> +    Basically, Formula-1 cars require a bit more care and feeding than your
> +    averaged Toyota minivan, as it were.

I think we can omit this last sentence for the formal documentation...
:)

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
> +
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
> +set and therefore statx will always return false on directories.

"statx will never indicate that S_DAX is set on directories."

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
> +
> +To reiterate: Setting, and inheritance, continues to affect FS_XFLAG_DAX even
> +while the file system is mounted with a dax override.  However, file enabled
> +state, S_DAX, will continue to be the overridden until the file system is
> +remounted with dax=inode.

"However, in-core inode state (S_DAX) will continue to be overridden
until the filesystem is remounted with dax=inode and the inode is
evicted."

...since we don't currently evict inodes just because a remount occurred.
:)

--D

>  
>  
>  Implementation Tips for Block Driver Writers
> -- 
> 2.25.1
> 

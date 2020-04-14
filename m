Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDA91A72F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 07:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405473AbgDNFVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 01:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405467AbgDNFVj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 01:21:39 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E95FC0A3BE2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2020 22:21:38 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id c7so15364106edl.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2020 22:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZY8Vs/SgwJl+VB027jYPMKdeld89d9fqn3BGrnSEshA=;
        b=laUVcAhwpnvPYmoi3Vs4k6JlLKU7l/6lGpqIm4rNDHe75tVMkLYBulH3dC0lvmguj2
         7gmPjORXoeijp6jw6Wp9xBSd2GWJl1vucqlB7xwqDdjVkfTQ/qRIMcOP2EnAnnbWaZEw
         taELjK/cbkyaYl5jD8vGkc1bV25tVRzzZtme8siByLNib6t4mxjRJ/hDeQ/eYStGST0T
         WDULZxhGjbK2MBRUZycQuwZhjwiGShoayN9LoR+hK+HzCvMQYVHaplpCApFB5g72V05w
         /IZVipN/VlAwVu5R0s9VnLTvGAt1ZbwckMQQAhAs6ozRgqVdOdw+3/QF3FKT+z3YqedQ
         ywhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZY8Vs/SgwJl+VB027jYPMKdeld89d9fqn3BGrnSEshA=;
        b=G93GLat8/vdickbUUPTkizs1oAF9Ij6pxFlHKzwh6k0hn9BM73LTsT3r24dYR+ZeEW
         P02KtxCSh4IJQuCN38nuK2+NUaajar1zr/TIQHOeu1znBvrEW8Wokg7ZTRI2lRdwSRlr
         l2786E5IebdI69Pyt3m+sVGz8uCiton3YUz8OHtd4RjqTn+rsOHiAMjpCxrHeFxZWvb5
         p2fjvD0pe7qyzSlfcygbAgXEZ7T0z2Kj+88m4PsBk/3o8eozYARyocODY6IjTTfaqJuo
         o/HEESgyvKigvIFY3sePdWmAp1b7JBZuRzY5wmZUK9jzRkeowo0Ycpy8DKeHCC5WoZbP
         AzMg==
X-Gm-Message-State: AGi0PubkNVMYiEKHOuEX9mpkQuTtW/hcMZxCUgt7P6RzPMGypXkwfwmv
        0K/M2IAJ8AT11znS21+4A5fe8WTG5ZdghYeP/Tsm1A==
X-Google-Smtp-Source: APiQypIqcFELxzeJQBnDG8J7SDZ/6/w8DMevIneRKEWQzaP8G0zmTkaBzVyHxQ0NkMxEQlNY/w0eiznf5LBjuNDT/Rg=
X-Received: by 2002:a17:906:1e42:: with SMTP id i2mr18247668ejj.317.1586841696955;
 Mon, 13 Apr 2020 22:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200413054046.1560106-1-ira.weiny@intel.com> <20200413054046.1560106-10-ira.weiny@intel.com>
In-Reply-To: <20200413054046.1560106-10-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 13 Apr 2020 22:21:26 -0700
Message-ID: <CAPcyv4g1gGWUuzVyOgOtkRTxzoSKOjVpAOmW-UDtmud9a3CUUA@mail.gmail.com>
Subject: Re: [PATCH V7 9/9] Documentation/dax: Update Usage section
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 12, 2020 at 10:41 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Update the Usage section to reflect the new individual dax selection
> functionality.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes from V6:
>         Update to allow setting FS_XFLAG_DAX any time.
>         Update with list of behaviors from Darrick
>         https://lore.kernel.org/lkml/20200409165927.GD6741@magnolia/
>
> Changes from V5:
>         Update to reflect the agreed upon semantics
>         https://lore.kernel.org/lkml/20200405061945.GA94792@iweiny-DESK2.sc.intel.com/
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
> +
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
> +    cache.

I had reserved some quibbling with this wording, but now that this is
being proposed as documentation I'll let my quibbling fly. "dax" may
imply, but does not require persistent memory nor does it necessarily
"bypass page cache". For example on configurations that support dax,
but turn off MAP_SYNC (like virtio-pmem), a software flush is
required. Instead, if we're going to define "dax" here I'd prefer it
be a #include of the man page definition that is careful (IIRC) to
only talk about semantics and not backend implementation details. In
other words, dax is to page-cache as direct-io is to page cache,
effectively not there, but dig a bit deeper and you may find it.

> Applications must call statx to discover the current S_DAX
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
> +       dax: a,e
> +       no dax: b,c,d
> +
> +Example B:
> +
> +mkdir a
> +xfs_io 'chattr +x' a
> +mkdir -p a/b/c/d
> +
> +       dax: a,b,c,d
> +       no dax:
> +
> +Example C:
> +
> +mkdir -p a/b/c
> +xfs_io 'chattr +x' c
> +mkdir a/b/c/d
> +
> +       dax: c,d
> +       no dax: a,b
> +
> +
> +The current enabled state (S_DAX) is set when a file inode is _loaded_ based on
> +the underlying media support, the value of FS_XFLAG_DAX, and the file systems
> +dax mount option setting.  See below.
> +
> +statx can be used to query S_DAX.  NOTE that a directory will never have S_DAX
> +set and therefore statx will always return false on directories.
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
> +                kernels
> +   "-o dax=inode" means "follow FS_XFLAG_DAX"
> +
> +The default state is 'inode'.  Given underlying media support, the following
> +algorithm is used to determine the effective mode of the file S_DAX on a
> +capable device.
> +
> +       S_DAX = FS_XFLAG_DAX;
> +
> +       if (dax_mount == "always")
> +               S_DAX = true;
> +       else if (dax_mount == "off"
> +               S_DAX = false;
> +
> +To reiterate: Setting, and inheritance, continues to affect FS_XFLAG_DAX even
> +while the file system is mounted with a dax override.  However, file enabled
> +state, S_DAX, will continue to be the overridden until the file system is
> +remounted with dax=inode.
>
>
>  Implementation Tips for Block Driver Writers
> --
> 2.25.1
>

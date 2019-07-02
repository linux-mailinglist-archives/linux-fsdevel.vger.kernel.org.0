Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D735CFF2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2019 15:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGBNCK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 09:02:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35815 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfGBNCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:02:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id c6so952300wml.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jul 2019 06:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L0Augh0CTTlBAZvDCLRt1s60tklJose8OaxiKCFG9bA=;
        b=ODoAOfoVY7D/edoPBEz9W5Dc2Vzada7CCUyfZ29qxGJ6VUV6i8OPR5SRxBt608IKw4
         KqrWa4wX7Wzm6EqrliBA+cheRPVHjYsCK3LXHzhW2N7Ve/DOIf5UWKpMMfkCbBtfX/y3
         mQn7CWXAtGuWybFtsf4j3n16MxOI38EfeBr4Dk7jh5yo7PWcjyEIk5YW4yI7kHNzyeDt
         RBneMnqbCkaY+h8ZQ4J9n6MWPElmvqTHD7hWatVGpEVn5YGfzEpwbtOICKi0SBcUp5gt
         /XH+7XmQ7lbcZsU5rVxBVbPrOk4CC4aD+Opgy/jy/pdt89t07FfcU4snwlPjo3VEaR6j
         pmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L0Augh0CTTlBAZvDCLRt1s60tklJose8OaxiKCFG9bA=;
        b=N1bJ53JJab5/v34UsBL3N8aqhPPaluTozBdjZdgI9rjuWeBGnk/dzkgQ5gVZy90z5A
         RDqgiSTmPqu68Gdd5d3UugBOjHVzzcuKh8j3JpWuhJiBw23/TZPnnoSDM/Rdm/PGpGmm
         1QKapyJIaDnzL7AL1VS9DoZqXzw1u8fUaRfDRfkT69D/RNNl2Yksl0yQh9bA1qun9mA4
         ooZEtZcyyWO25axsISy5TiywnPnkhuRTST/YmT2nLYovfw7TFjGqN/oKU5LtshT4BQ8o
         /nMXNsDHvrnqsbLZNsMFzTbEKtDFc3D54ch3tykSjEsEeErXQENwRoZWTWQz6fIFoyG9
         rEuQ==
X-Gm-Message-State: APjAAAV/swHeqUDx7Z8sVQt4prg6vF6hQY0MkLCse7M4wxqzAuv04r6N
        C1LymlVo0XYroJUkEzB0+C4=
X-Google-Smtp-Source: APXvYqzGiT1dnuyjzcIGZsLj8N0vAeiCBK3JzMXo+y+oTKC9M8Wu2gTJyFM3f4tYLJrgDBXsIolhTA==
X-Received: by 2002:a1c:2302:: with SMTP id j2mr3324521wmj.174.1562072526202;
        Tue, 02 Jul 2019 06:02:06 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id g5sm14462728wrp.29.2019.07.02.06.02.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 06:02:05 -0700 (PDT)
Date:   Tue, 2 Jul 2019 15:02:04 +0200
From:   Christian Brauner <christian@brauner.io>
To:     David Howells <dhowells@redhat.com>
Cc:     viro@zeniv.linux.org.uk, raven@themaw.net, mszeredi@redhat.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/11] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #15]
Message-ID: <20190702130203.rz5mlnsvabvvenpk@brauner.io>
References: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
 <156173662509.14042.3867242748127323502.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <156173662509.14042.3867242748127323502.stgit@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 28, 2019 at 04:43:45PM +0100, David Howells wrote:
> Add a system call to allow filesystem information to be queried.  A request
> value can be given to indicate the desired attribute.  Support is provided
> for enumerating multi-value attributes.
> 
> ===============
> NEW SYSTEM CALL
> ===============
> 
> The new system call looks like:
> 
> 	int ret = fsinfo(int dfd,
> 			 const char *filename,
> 			 const struct fsinfo_params *params,
> 			 void *buffer,
> 			 size_t buf_size);
> 
> The params parameter optionally points to a block of parameters:
> 
> 	struct fsinfo_params {
> 		__u32	at_flags;
> 		__u32	request;
> 		__u32	Nth;
> 		__u32	Mth;
> 		__u64	__reserved[3];
> 	};
> 
> If params is NULL, it is assumed params->request should be
> fsinfo_attr_statfs, params->Nth should be 0, params->Mth should be 0 and
> params->at_flags should be 0.
> 
> If params is given, all of params->__reserved[] must be 0.
> 
> dfd, filename and params->at_flags indicate the file to query.  There is no
> equivalent of lstat() as that can be emulated with fsinfo() by setting
> AT_SYMLINK_NOFOLLOW in params->at_flags.  There is also no equivalent of
> fstat() as that can be emulated by passing a NULL filename to fsinfo() with
> the fd of interest in dfd.  AT_NO_AUTOMOUNT can also be used to an allow
> automount point to be queried without triggering it.
> 
> params->request indicates the attribute/attributes to be queried.  This can
> be one of:
> 
> 	FSINFO_ATTR_STATFS		- statfs-style info
> 	FSINFO_ATTR_FSINFO		- Information about fsinfo()
> 	FSINFO_ATTR_IDS			- Filesystem IDs
> 	FSINFO_ATTR_LIMITS		- Filesystem limits
> 	FSINFO_ATTR_SUPPORTS		- What's supported in statx(), IOC flags
> 	FSINFO_ATTR_CAPABILITIES	- Filesystem capabilities
> 	FSINFO_ATTR_TIMESTAMP_INFO	- Inode timestamp info
> 	FSINFO_ATTR_VOLUME_ID		- Volume ID (string)
> 	FSINFO_ATTR_VOLUME_UUID		- Volume UUID
> 	FSINFO_ATTR_VOLUME_NAME		- Volume name (string)
> 	FSINFO_ATTR_NAME_ENCODING	- Filename encoding (string)
> 	FSINFO_ATTR_NAME_CODEPAGE	- Filename codepage (string)
> 
> Some attributes (such as the servers backing a network filesystem) can have
> multiple values.  These can be enumerated by setting params->Nth and
> params->Mth to 0, 1, ... until ENODATA is returned.
> 
> buffer and buf_size point to the reply buffer.  The buffer is filled up to
> the specified size, even if this means truncating the reply.  The full size
> of the reply is returned.  In future versions, this will allow extra fields
> to be tacked on to the end of the reply, but anyone not expecting them will
> only get the subset they're expecting.  If either buffer of buf_size are 0,
> no copy will take place and the data size will be returned.
> 
> At the moment, this will only work on x86_64 and i386 as it requires the
> system call to be wired up.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-api@vger.kernel.org
> ---
> 
>  arch/x86/entry/syscalls/syscall_32.tbl |    1 
>  arch/x86/entry/syscalls/syscall_64.tbl |    1 
>  fs/Kconfig                             |    7 
>  fs/Makefile                            |    1 
>  fs/fsinfo.c                            |  545 ++++++++++++++++++++++++++++++++
>  include/linux/fs.h                     |    5 
>  include/linux/fsinfo.h                 |   65 ++++
>  include/linux/syscalls.h               |    4 
>  include/uapi/asm-generic/unistd.h      |    4 
>  include/uapi/linux/fsinfo.h            |  219 +++++++++++++
>  kernel/sys_ni.c                        |    1 
>  samples/vfs/Makefile                   |    4 
>  samples/vfs/test-fsinfo.c              |  551 ++++++++++++++++++++++++++++++++
>  13 files changed, 1407 insertions(+), 1 deletion(-)
>  create mode 100644 fs/fsinfo.c
>  create mode 100644 include/linux/fsinfo.h
>  create mode 100644 include/uapi/linux/fsinfo.h
>  create mode 100644 samples/vfs/test-fsinfo.c
> 
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index ad968b7bac72..03decae51513 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -438,3 +438,4 @@
>  431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
>  432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
>  433	i386	fspick			sys_fspick			__ia32_sys_fspick
> +434	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index b4e6f9e6204a..ea63df9a1020 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -355,6 +355,7 @@
>  431	common	fsconfig		__x64_sys_fsconfig
>  432	common	fsmount			__x64_sys_fsmount
>  433	common	fspick			__x64_sys_fspick
> +434	common	fsinfo			__x64_sys_fsinfo
>  
>  #
>  # x32-specific system call numbers start at 512 to avoid cache impact
> diff --git a/fs/Kconfig b/fs/Kconfig
> index cbbffc8b9ef5..9e7d2f2c0111 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -15,6 +15,13 @@ config VALIDATE_FS_PARSER
>  	  Enable this to perform validation of the parameter description for a
>  	  filesystem when it is registered.
>  
> +config FSINFO
> +	bool "Enable the fsinfo() system call"
> +	help
> +	  Enable the file system information querying system call to allow
> +	  comprehensive information to be retrieved about a filesystem,
> +	  superblock or mount object.
> +
>  if BLOCK
>  
>  config FS_IOMAP
> diff --git a/fs/Makefile b/fs/Makefile
> index c9aea23aba56..26eaeae4b9a1 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -53,6 +53,7 @@ obj-$(CONFIG_SYSCTL)		+= drop_caches.o
>  
>  obj-$(CONFIG_FHANDLE)		+= fhandle.o
>  obj-$(CONFIG_FS_IOMAP)		+= iomap.o
> +obj-$(CONFIG_FSINFO)		+= fsinfo.o
>  
>  obj-y				+= quota/
>  
> diff --git a/fs/fsinfo.c b/fs/fsinfo.c
> new file mode 100644
> index 000000000000..09e743b16235
> --- /dev/null
> +++ b/fs/fsinfo.c
> @@ -0,0 +1,545 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Filesystem information query.
> + *
> + * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
> + * Written by David Howells (dhowells@redhat.com)
> + */
> +#include <linux/syscalls.h>
> +#include <linux/fs.h>
> +#include <linux/file.h>
> +#include <linux/mount.h>
> +#include <linux/namei.h>
> +#include <linux/statfs.h>
> +#include <linux/security.h>
> +#include <linux/uaccess.h>
> +#include <linux/fsinfo.h>
> +#include <uapi/linux/mount.h>
> +#include "internal.h"
> +
> +static u32 calc_mount_attrs(u32 mnt_flags)

I totally forgot to mention this:
I had a patchset that extended statfs to also report back when a
mountpoint is shared, slave, private, or unbindable to avoid parsing
/proc/1/mountinfo which is unreliable and slow. I've given a lengthier
argument in the patchset I sent more than a year ago:
https://lkml.org/lkml/2018/5/25/397

Pretty please, make it possible to retrieve propagation attributes with
fsinfo(). We desperately need this and it's trivial to add imho.

> +{
> +	u32 attrs = 0;
> +
> +	if (mnt_flags & MNT_READONLY)
> +		attrs |= MOUNT_ATTR_RDONLY;
> +	if (mnt_flags & MNT_NOSUID)
> +		attrs |= MOUNT_ATTR_NOSUID;
> +	if (mnt_flags & MNT_NODEV)
> +		attrs |= MOUNT_ATTR_NODEV;
> +	if (mnt_flags & MNT_NOEXEC)
> +		attrs |= MOUNT_ATTR_NOEXEC;
> +	if (mnt_flags & MNT_NODIRATIME)
> +		attrs |= MOUNT_ATTR_NODIRATIME;
> +
> +	if (mnt_flags & MNT_NOATIME)
> +		attrs |= MOUNT_ATTR_NOATIME;
> +	else if (mnt_flags & MNT_RELATIME)
> +		attrs |= MOUNT_ATTR_RELATIME;
> +	else
> +		attrs |= MOUNT_ATTR_STRICTATIME;
> +	return attrs;
> +}

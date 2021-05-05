Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F1C373BB4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 14:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhEEMwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 08:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhEEMwO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 08:52:14 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D476C061574;
        Wed,  5 May 2021 05:51:17 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 12BE9C01B; Wed,  5 May 2021 14:51:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1620219074; bh=K79smNROaNkMtfX4gl9qYK3itoGKn5ZoulACwxkOabs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arieQ/wOQ0trz8U5kduJkZvAZ+mX+IT4Zoz1iWfrgf9fZf0O4LfYPsIZD8TV2joVD
         J8NW8AdPSQ5rJBaCZzupSDIsdij2Vw0So8YOCmXVoRzo4nblFcP2ax/Nj4yccRrva/
         SeJKCd/cYY9yiPp3Fr9uWt9e3UJlvdtsISywrkPW3hEK99hvam55UBaUb9d5yklODp
         OL79uRGpdTPr2GM8qj5QeXT6ZRY7uImISjRGVg5AXGT672dC280W1NVHRkDEoCbIVk
         pYcnU8Wkzff7qiL9tW+HkFxt376o7nIB1fcyDV8zpUqlk2Jx6Y/bE0qesDFW2jA3A/
         6CSq8PMEucQIg==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 059F2C009;
        Wed,  5 May 2021 14:51:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1620219072; bh=K79smNROaNkMtfX4gl9qYK3itoGKn5ZoulACwxkOabs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFBA5Obp2i8ITADn4tLJqSpRknJtKs7j2ozle7umi59vFtGyHb6L8sp9511jVZbhk
         gLbY729gplOQ4m7QAGGYJiCBK1oSmz+arSsU3Y3x4DGxmqDoEVOYuZ56zEfA5ECgFq
         nDA0MKwTV+YAjp122kGP013KkXYZrGaA+UglmDHClPs/FRcGXIcTL1wz5BqUvg2xYn
         xTrxx3gmSVJ8XixkACkNPtnWGgOmRFI6C/scgLZTgbXYjPA2/gCq2ZwwHasT/MvYQf
         L7D7o4p3usHJGcDBuRV2UyjaZM1qKFFFpVMRsKJ2kbZzCuR/SqMNY/hwplaQd2Gxbc
         5TCsW5eaiF5pA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 3f5dc009;
        Wed, 5 May 2021 12:51:05 +0000 (UTC)
Date:   Wed, 5 May 2021 21:50:50 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] 9p: add support for root file systems
Message-ID: <YJKUqj5hY3q+qOia@codewreck.org>
References: <20210505120748.8622-1-changbin.du@gmail.com>
 <20210505120748.8622-2-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210505120748.8622-2-changbin.du@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Why has this only been sent to direct maintainers and linux-doc@vger ?
Please resend to at least v9fs-developer@sf, linux-fs@vger and whoever
get_maintainer.pl deems appropriate for init/do_mounts.c changes
(added the two lists to this mail)


As a whole for the series: I'm personally not sure I'd encourage this,
it can currently be done with an initrd if someone cares enough and if
we're going to add all remote filesystems that way there's going to be
no end to it.

That being said, I'm not 100% opposed to it if there is demand; but I'll
expect you to help with whatever bug reports people come up with using
this option.


Changbin Du wrote on Wed, May 05, 2021 at 08:07:46PM +0800:
> diff --git a/fs/9p/v9fsroot.c b/fs/9p/v9fsroot.c
> new file mode 100644
> index 000000000000..7dd91cc3814f
> --- /dev/null
> +++ b/fs/9p/v9fsroot.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * SMB root file system support

copy-paste error from fs/cifs/cifsroot.c

> + *
> + * Copyright (c) 2021 Changbin Du <changbin.du@gmail.com>
> + */
> +#include <linux/init.h>
> +#include <linux/fs.h>
> +#include <linux/types.h>
> +#include <linux/ctype.h>
> +#include <linux/string.h>
> +#include <linux/root_dev.h>
> +#include <linux/kernel.h>
> +
> +static char root_dev[2048] __initdata = "";
> +static char root_opts[1024] __initdata = "";
> +
> +/* v9fsroot=<path>[,options] */
> +static int __init v9fs_root_setup(char *line)
> +{
> +	char *s;
> +	int len;
> +
> +	ROOT_DEV = Root_V9FS;
> +
> +	if (strlen(line) >= 1) {
> +		/* make s point to ',' or '\0' at end of line */
> +		s = strchrnul(line, ',');
> +		/* len is strlen(unc) + '\0' */
> +		len = s - line + 1;
> +		if (len > sizeof(root_dev)) {
> +			printk(KERN_ERR "Root-V9FS: path too long\n");

9p has its own p9_debug helper; it's a bit awkward because even
P9_DEBUG_ERROR right now is not displayed by default so I'm not against
pr_err or pr_warn for important messages (I'd like to replace all such
messages by either at some point), but at least stick to pr_xyz(...)
rather than printk(KERN_XYZ...)

> +			return 1;
> +		}
> +		strlcpy(root_dev, line, len);
> +		if (*s) {
> +			int n = snprintf(root_opts,
> +					 sizeof(root_opts), "%s,%s",
> +					 DEFAULT_MNT_OPTS, s + 1);

Did you actually run with this? DEFAULT_MNT_OPTS is not defined here.

> +			if (n >= sizeof(root_opts)) {
> +				printk(KERN_ERR "Root-V9FS: mount options string too long\n");
> +				root_opts[sizeof(root_opts)-1] = '\0';
> +				return 1;
> +			}
> +		}
> +	}
> +
> +	return 1;

I'm also surprised this only ever returns 1, the cifs codes does the
same but I'd be surprised the mount can work without a tag so there
certainly should be some difference between working and not working?

I'd also expect ROOT_DEV to only be set on success, this doesn't make
sense to trigger 9p mounting mechanisms with something that can't be
mounted, leading to a long timeout (5+10+15+30*2 seconds) before a hard
error when the hard error can be given right away.

> +}
> +
> +__setup("v9fsroot=", v9fs_root_setup);
> +
> +int __init v9fs_root_data(char **dev, char **opts)
> +{
> +	if (!root_dev[0]) {
> +		printk(KERN_ERR "Root-V9FS: no rootdev specified\n");
> +		return -1;
> +	}
> +
> +	*dev = root_dev;
> +	*opts = root_opts;
> +
> +	return 0;
> +}
> diff --git a/include/linux/root_dev.h b/include/linux/root_dev.h
> index 4e78651371ba..becd0ee2ff87 100644
> --- a/include/linux/root_dev.h
> +++ b/include/linux/root_dev.h
> @@ -9,6 +9,7 @@
>  enum {
>  	Root_NFS = MKDEV(UNNAMED_MAJOR, 255),
>  	Root_CIFS = MKDEV(UNNAMED_MAJOR, 254),
> +	Root_V9FS = MKDEV(UNNAMED_MAJOR, 253),
>  	Root_RAM0 = MKDEV(RAMDISK_MAJOR, 0),
>  	Root_RAM1 = MKDEV(RAMDISK_MAJOR, 1),
>  	Root_FD0 = MKDEV(FLOPPY_MAJOR, 0),
> diff --git a/init/do_mounts.c b/init/do_mounts.c
> index a78e44ee6adb..60af89983a6b 100644
> --- a/init/do_mounts.c
> +++ b/init/do_mounts.c
> @@ -287,6 +287,8 @@ dev_t name_to_dev_t(const char *name)
>  		return Root_NFS;
>  	if (strcmp(name, "/dev/cifs") == 0)
>  		return Root_CIFS;
> +	if (strcmp(name, "/dev/v9fs") == 0)
> +		return Root_V9FS;
>  	if (strcmp(name, "/dev/ram") == 0)
>  		return Root_RAM0;
>  #ifdef CONFIG_BLOCK
> @@ -536,6 +538,43 @@ static int __init mount_cifs_root(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_9P_FS_ROOT
> +
> +extern int v9fs_root_data(char **dev, char **opts);
> +
> +#define V9FSROOT_TIMEOUT_MIN	5
> +#define V9FSROOT_TIMEOUT_MAX	30
> +#define V9FSROOT_RETRY_MAX	5
> +
> +static int __init mount_v9fs_root(void)
> +{
> +	char *root_dev, *root_data;
> +	unsigned int timeout;
> +	int try, err;
> +
> +	err = v9fs_root_data(&root_dev, &root_data);
> +	if (err != 0)
> +		return 0;
> +
> +	timeout = V9FSROOT_TIMEOUT_MIN;
> +	for (try = 1; ; try++) {
> +		err = do_mount_root(root_dev, "9p",
> +				    root_mountflags, root_data);
> +		if (err == 0)
> +			return 1;
> +		if (try > V9FSROOT_RETRY_MAX)
> +			break;
> +
> +		/* Wait, in case the server refused us immediately */
> +		ssleep(timeout);
> +		timeout <<= 1;
> +		if (timeout > V9FSROOT_TIMEOUT_MAX)
> +			timeout = V9FSROOT_TIMEOUT_MAX;
> +	}
> +	return 0;
> +}
> +#endif
> +
>  void __init mount_root(void)
>  {
>  #ifdef CONFIG_ROOT_NFS
> @@ -552,6 +591,13 @@ void __init mount_root(void)
>  		return;
>  	}
>  #endif
> +#ifdef CONFIG_9P_FS_ROOT
> +	if (ROOT_DEV == Root_V9FS) {
> +		if (!mount_v9fs_root())
> +			printk(KERN_ERR "VFS: Unable to mount root fs via 9p.\n");
> +		return;
> +	}
> +#endif
>  #ifdef CONFIG_BLOCK
>  	{
>  		int err = create_dev("/dev/root", ROOT_DEV);
-- 
Dominique

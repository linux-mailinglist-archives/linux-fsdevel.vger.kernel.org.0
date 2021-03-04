Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC14732CD35
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 07:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhCDG4A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 01:56:00 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48201 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235799AbhCDGz2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:55:28 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4A4265802EE;
        Thu,  4 Mar 2021 01:54:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 04 Mar 2021 01:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        KliIs66mn8GDFI1ojhPUHNSStiEfUS7UpgbsszD2yZ0=; b=LbdafKGUQEVbhWFc
        vIQCjPI0KEQT/VaAMRJfjq6YkBbhAcxxcgtHCsNrgpFISe6sSMM+fqefrvRNi6kQ
        iFxpC/WzPMGLzppy38O8acEUseAMJ6XPL/WbUU3Zh/t2wOOKvDqLcFzCe66R1ola
        tD8v4/Q96RJ1fsiQOXVcn0ydtMzGRP6vaTYYzL3l2PeW4CaLf/2lA4wJgLwF03qm
        GVouR1efe5pYa+lhs3I/+YpDquZyRaR9233C3zzdGKctmLzuYGjEEfMl4vnfDkk/
        Wc0E4dzDjUSuwbScIw395Q58hYcd/bW5+1kByFTIkUb0E/QeMdaDxzLGFjIrX7yX
        xcx7Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=KliIs66mn8GDFI1ojhPUHNSStiEfUS7UpgbsszD2y
        Z0=; b=qckjPau3z4GvQBFaYpkoMqDCMZLiAHdVXfrFy9D7i5Azh0ZyQ2YVQS+/n
        ei6u7Tii5RtGYzbGeK0vB9dBAddNQ+3JJoRdi4RRtr654DbYdr6/iz5wQwfls/uP
        e3FlSFHegmaZzjp2BdqIB3KWEr/7qeldVsnzS/cIcTnOzBxbh0g3AmdwfdPSSQ2v
        96iaFheKhA8tSipMbVQtaX5D1UzBW8FEbGuQ2uRCqjWaqBxchsXDt6s/NYdks/X5
        J/EttyxntLb293x818euyLAWqRGEGOIlOkZUtNR+OYu7V4HEqndtAsxUP0+p0YOi
        T6nfoT7k50wOXPFthAXFpeWEy4uDA==
X-ME-Sender: <xms:HIRAYHTAtgsVTy5Y3mHfgyXhlhQ4I3Roi1J-TBiOI6ZILleKPw-4EA>
    <xme:HIRAYIxFnnjCyFjrNhLM8Jpg8ASTFRHvcnGvPMQ_eslidB6njhiJUV4YSjzy2kUMk
    Wi134eqfZDH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddtfedgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddtiedrieelrddvvdejrddvfeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:HIRAYM28TwrmKRwT10xFPljvO2cXvlh0OGqkxD7HTWi7k5WhVy_Viw>
    <xmx:HIRAYHD9ch97CBaOI1YWM65fiBykn0ejDvZwPEsCKuI2xoY6uLD8xg>
    <xmx:HIRAYAhNLLNVwd0eM73w15bcoPgbgwk851iChRi-4F1M-FE_KIafQA>
    <xmx:HoRAYFYx4E4sV4U3GoZ_DYcpp-2-YGieRkDkuOCglH4m59yRMfH7KA>
Received: from mickey.themaw.net (106-69-227-234.dyn.iinet.net.au [106.69.227.234])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4435724005B;
        Thu,  4 Mar 2021 01:54:15 -0500 (EST)
Message-ID: <832c1a384dc0b71b2902accf3091ea84381acc10.camel@themaw.net>
Subject: Re: [RFC PATCH] autofs: find_autofs_mount overmounted parent support
From:   Ian Kent <raven@themaw.net>
To:     Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, autofs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ross Zwisler <zwisler@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biggers <ebiggers@google.com>,
        Mattias Nissler <mnissler@chromium.org>,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 04 Mar 2021 14:54:11 +0800
In-Reply-To: <20210303152931.771996-1-alexander.mikhalitsyn@virtuozzo.com>
References: <20210303152931.771996-1-alexander.mikhalitsyn@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-03-03 at 18:28 +0300, Alexander Mikhalitsyn wrote:
> It was discovered that find_autofs_mount() function
> in autofs not support cases when autofs mount
> parent is overmounted. In this case this function will
> always return -ENOENT.

Ok, I get this shouldn't happen.

> 
> Real-life reproducer is fairly simple.
> Consider the following mounts on root mntns:
> --
> 35 24 0:36 / /proc/sys/fs/binfmt_misc ... shared:16 - autofs systemd-
> 1 ...
> 654 35 0:57 / /proc/sys/fs/binfmt_misc ... shared:322 - binfmt_misc
> ...
> --
> and some process which calls ioctl(AUTOFS_DEV_IOCTL_OPENMOUNT)
> $ unshare -m -p --fork --mount-proc ./process-bin
> 
> Due to "mount-proc" /proc will be overmounted and
> ioctl() will fail with -ENOENT

I think I need a better explanation ...

What's being said here?

For a start your talking about direct mounts, I'm pretty sure this
use case can't occur with indirect mounts in the sense that the
indirect mount base should/must never be over mounted and IIRC that
base can't be /proc (but maybe that's just mounts inside proc ...),
can't remember now but from a common sense POV an indirect mount
won't/can't be on /proc.

And why is this ioctl be called?

If the mount is over mounted should that prevent expiration of the
over mounted /proc anyway, so maybe the return is correct ... or
not ...

I get that the mount namespaces should be independent and intuitively
this is a bug but what is the actual use and expected result.

But anyway, aren't you saying that the VFS path walk isn't handling
mount namespaces properly or are you saying that a process outside
this new mount namespace becomes broken because of it?

Either way the solution looks more complicated than I'd expect so
some explanation along these lines would be good.

Ian
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: autofs@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alexander Mikhalitsyn <
> alexander.mikhalitsyn@virtuozzo.com>
> ---
>  fs/autofs/dev-ioctl.c | 127 +++++++++++++++++++++++++++++++++++++---
> --
>  fs/namespace.c        |  44 +++++++++++++++
>  include/linux/mount.h |   5 ++
>  3 files changed, 162 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
> index 5bf781ea6d67..55edd3eba8ce 100644
> --- a/fs/autofs/dev-ioctl.c
> +++ b/fs/autofs/dev-ioctl.c
> @@ -10,6 +10,7 @@
>  #include <linux/fdtable.h>
>  #include <linux/magic.h>
>  #include <linux/nospec.h>
> +#include <linux/nsproxy.h>
>  
>  #include "autofs_i.h"
>  
> @@ -179,32 +180,130 @@ static int autofs_dev_ioctl_protosubver(struct
> file *fp,
>  	return 0;
>  }
>  
> +struct filter_autofs_data {
> +	char *pathbuf;
> +	const char *fpathname;
> +	int (*test)(const struct path *path, void *data);
> +	void *data;
> +};
> +
> +static int filter_autofs(const struct path *path, void *p)
> +{
> +	struct filter_autofs_data *data = p;
> +	char *name;
> +	int err;
> +
> +	if (path->mnt->mnt_sb->s_magic != AUTOFS_SUPER_MAGIC)
> +		return 0;
> +
> +	name = d_path(path, data->pathbuf, PATH_MAX);
> +	if (IS_ERR(name)) {
> +		err = PTR_ERR(name);
> +		pr_err("d_path failed, errno %d\n", err);
> +		return 0;
> +	}
> +
> +	if (strncmp(data->fpathname, name, PATH_MAX))
> +		return 0;
> +
> +	if (!data->test(path, data->data))
> +		return 0;
> +
> +	return 1;
> +}
> +
>  /* Find the topmost mount satisfying test() */
>  static int find_autofs_mount(const char *pathname,
>  			     struct path *res,
>  			     int test(const struct path *path, void
> *data),
>  			     void *data)
>  {
> -	struct path path;
> +	struct filter_autofs_data mdata = {
> +		.pathbuf = NULL,
> +		.test = test,
> +		.data = data,
> +	};
> +	struct mnt_namespace *mnt_ns = current->nsproxy->mnt_ns;
> +	struct path path = {};
> +	char *fpathbuf = NULL;
>  	int err;
>  
> +	/*
> +	 * In most cases user will provide full path to autofs mount
> point
> +	 * as it is in /proc/X/mountinfo. But if not, then we need to
> +	 * open provided relative path and calculate full path.
> +	 * It will not work in case when parent mount of autofs mount
> +	 * is overmounted:
> +	 * cd /root
> +	 * ./autofs_mount /root/autofs_yard/mnt
> +	 * mount -t tmpfs tmpfs /root/autofs_yard/mnt
> +	 * mount -t tmpfs tmpfs /root/autofs_yard
> +	 * ./call_ioctl /root/autofs_yard/mnt <- all fine here because
> we
> +	 * 					 have full path and
> don't
> +	 * 					 need to call
> kern_path()
> +	 * 					 and d_path()
> +	 * ./call_ioctl autofs_yard/mnt <- will fail because
> kern_path()
> +	 * 				   can't lookup
> /root/autofs_yard/mnt
> +	 * 				   (/root/autofs_yard
> directory is
> +	 * 				    empty)
> +	 *
> +	 * TO DISCUSS: we can write special algorithm for relative path
> case
> +	 * by getting cwd path combining it with relative path from
> user. But
> +	 * is it worth it? User also may use paths with symlinks in
> components
> +	 * of path.
> +	 *
> +	 */
>  	err = kern_path(pathname, LOOKUP_MOUNTPOINT, &path);
> -	if (err)
> -		return err;
> -	err = -ENOENT;
> -	while (path.dentry == path.mnt->mnt_root) {
> -		if (path.dentry->d_sb->s_magic == AUTOFS_SUPER_MAGIC) {
> -			if (test(&path, data)) {
> -				path_get(&path);
> -				*res = path;
> -				err = 0;
> -				break;
> -			}
> +	if (err) {
> +		if (pathname[0] == '/') {
> +			/*
> +			 * pathname looks like full path let's try to
> use it
> +			 * as it is when searching autofs mount
> +			 */
> +			mdata.fpathname = pathname;
> +			err = 0;
> +			pr_debug("kern_path failed on %s, errno %d.
> Will use path as it is to search mount\n",
> +				 pathname, err);
> +		} else {
> +			pr_err("kern_path failed on %s, errno %d\n",
> +			       pathname, err);
> +			return err;
> +		}
> +	} else {
> +		pr_debug("find_autofs_mount: let's resolve full path
> %s\n",
> +			 pathname);
> +
> +		fpathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> +		if (!fpathbuf) {
> +			err = -ENOMEM;
> +			goto err;
> +		}
> +
> +		/*
> +		 * We have pathname from user but it may be relative,
> we need to
> +		 * have full path because we want to compare it with
> mountpoints
> +		 * paths later.
> +		 */
> +		mdata.fpathname = d_path(&path, fpathbuf, PATH_MAX);
> +		if (IS_ERR(mdata.fpathname)) {
> +			err = PTR_ERR(mdata.fpathname);
> +			pr_err("d_path failed, errno %d\n", err);
> +			goto err;
>  		}
> -		if (!follow_up(&path))
> -			break;
>  	}
> +
> +	mdata.pathbuf = kmalloc(PATH_MAX, GFP_KERNEL);
> +	if (!mdata.pathbuf) {
> +		err = -ENOMEM;
> +		goto err;
> +	}
> +
> +	err = lookup_mount_path(mnt_ns, res, filter_autofs, &mdata);
> +
> +err:
>  	path_put(&path);
> +	kfree(fpathbuf);
> +	kfree(mdata.pathbuf);
>  	return err;
>  }
>  
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 56bb5a5fdc0d..e1d006dbdfe2 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1367,6 +1367,50 @@ void mnt_cursor_del(struct mnt_namespace *ns,
> struct mount *cursor)
>  }
>  #endif  /* CONFIG_PROC_FS */
>  
> +/**
> + * lookup_mount_path - traverse all mounts in mount namespace
> + *                     and filter using test() probe callback
> + * As a result struct path will be provided.
> + * @ns: root of mount tree
> + * @res: struct path pointer where resulting path will be written
> + * @test: filter callback
> + * @data: will be provided as argument to test() callback
> + *
> + */
> +int lookup_mount_path(struct mnt_namespace *ns,
> +		      struct path *res,
> +		      int test(const struct path *mnt, void *data),
> +		      void *data)
> +{
> +	struct mount *mnt;
> +	int err = -ENOENT;
> +
> +	down_read(&namespace_sem);
> +	lock_ns_list(ns);
> +	list_for_each_entry(mnt, &ns->list, mnt_list) {
> +		struct path tmppath;
> +
> +		if (mnt_is_cursor(mnt))
> +			continue;
> +
> +		tmppath.dentry = mnt->mnt.mnt_root;
> +		tmppath.mnt = &mnt->mnt;
> +
> +		if (test(&tmppath, data)) {
> +			path_get(&tmppath);
> +			*res = tmppath;
> +			err = 0;
> +			break;
> +		}
> +	}
> +	unlock_ns_list(ns);
> +	up_read(&namespace_sem);
> +
> +	return err;
> +}
> +
> +EXPORT_SYMBOL(lookup_mount_path);
> +
>  /**
>   * may_umount_tree - check if a mount tree is busy
>   * @mnt: root of mount tree
> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index 5d92a7e1a742..a79e6392e38e 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -118,6 +118,11 @@ extern unsigned int sysctl_mount_max;
>  
>  extern bool path_is_mountpoint(const struct path *path);
>  
> +extern int lookup_mount_path(struct mnt_namespace *ns,
> +			     struct path *res,
> +			     int test(const struct path *mnt, void
> *data),
> +			     void *data);
> +
>  extern void kern_unmount_array(struct vfsmount *mnt[], unsigned int
> num);
>  
>  #endif /* _LINUX_MOUNT_H */


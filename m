Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD749375826
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 18:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbhEFQFz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 12:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbhEFQFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 12:05:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C033EC061574;
        Thu,  6 May 2021 09:04:55 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id m37so5027053pgb.8;
        Thu, 06 May 2021 09:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vcpFfFIzyINPXpp5ROXT2gMnFUVzoFLvP2yhzNBbEtk=;
        b=LCfQRVSqi79241FgXcA8zTpkEKF+xbfL0ENgkAYXF4CaoiJUuMSf6W6VJ1trcHvVfT
         v0JKdfS0zuQSHziMYlz85XgB9Y6KCjXaMRV6amC44ZwO/INzViX/YrdiRJaphw40bWqa
         K1UQyh3bBOVRVZh6rHixkS7z92ylEjT7FpLR+dzATWZ3F0CaFPqdNkCJHnf7CA3l7xTc
         k+BBjT0yME2DUdp1yG5r69cr4TRd12a4VUdB3EJTbhG1iHgjboDQA9Tb+QOfzNeReqWd
         4uQqBm8536WWm7Vl5F2Mq8okLKz2j9iXN3CLGw0ifqzO9xlk+jEarD2d5Zcy05AY8gdQ
         RP+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vcpFfFIzyINPXpp5ROXT2gMnFUVzoFLvP2yhzNBbEtk=;
        b=iBu1XX6yFP/pKoIIIK1XuWdFmkwy8yVPYTvOMUnhRzQio8McxJbaIKx+VCVOY/w3yJ
         rv9OrG20ZVXtHnJxhpZ3nwd4EjxXwtFY7MFNEzSpwtqK3myuHHv9uGwtnKm1+o48p5UU
         0X2anfo4PoKoRddS68e+CHAZtbLYWQzglcIzD/mk1Bf2OzW6G+HiWpRoHRDATeuQOh2S
         73DLxNIK+GBb1sJDrV6DT9PpdxQdfyuTvb0JVcSkxr1ETseANfJkiY5KbYyFF3LTDmat
         j2g2mh5/Zdvlx/9WiuYMXyxqT1GrhvvBmg+9z1sTy4N9rmhpQ7RtSLzTgzn8Zd15ze1a
         ugiA==
X-Gm-Message-State: AOAM531qNl4ukrhZp9/chyocq5S6Zr+vh/Wu3mGj5SjLxt2AUgXa/F2c
        CgRqZW4UDW4by0U+95wZ30c=
X-Google-Smtp-Source: ABdhPJw3moov5fhsIOf0EXcPL/1UWXyACEKCIyXL8wBMsLd1jtzxVEQLISw2n4B8Jv6UOlYmOugFyg==
X-Received: by 2002:a63:e909:: with SMTP id i9mr5083892pgh.24.1620317095274;
        Thu, 06 May 2021 09:04:55 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id n8sm2615107pfu.111.2021.05.06.09.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 09:04:54 -0700 (PDT)
Date:   Fri, 7 May 2021 00:04:06 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, lkml@metux.net
Subject: Re: [PATCH 1/3] 9p: add support for root file systems
Message-ID: <20210506160406.bysqkln6p226rjjm@mail.google.com>
References: <20210505120748.8622-1-changbin.du@gmail.com>
 <20210505120748.8622-2-changbin.du@gmail.com>
 <YJKUqj5hY3q+qOia@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJKUqj5hY3q+qOia@codewreck.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 05, 2021 at 09:50:50PM +0900, Dominique Martinet wrote:
> Why has this only been sent to direct maintainers and linux-doc@vger ?
> Please resend to at least v9fs-developer@sf, linux-fs@vger and whoever
> get_maintainer.pl deems appropriate for init/do_mounts.c changes
> (added the two lists to this mail)
>
I made a typing mistake and then...

> 
> As a whole for the series: I'm personally not sure I'd encourage this,
> it can currently be done with an initrd if someone cares enough and if
> we're going to add all remote filesystems that way there's going to be
> no end to it.
> 
> That being said, I'm not 100% opposed to it if there is demand; but I'll
> expect you to help with whatever bug reports people come up with using
> this option.
> 
No problem, I can help with any issues related to this. It is worth doint this
especially for some virtulizaion scenarioes.

> 
> Changbin Du wrote on Wed, May 05, 2021 at 08:07:46PM +0800:
> > diff --git a/fs/9p/v9fsroot.c b/fs/9p/v9fsroot.c
> > new file mode 100644
> > index 000000000000..7dd91cc3814f
> > --- /dev/null
> > +++ b/fs/9p/v9fsroot.c
> > @@ -0,0 +1,64 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * SMB root file system support
> 
> copy-paste error from fs/cifs/cifsroot.c
> 
Sorry, I'll fix it.

> > + *
> > + * Copyright (c) 2021 Changbin Du <changbin.du@gmail.com>
> > + */
> > +#include <linux/init.h>
> > +#include <linux/fs.h>
> > +#include <linux/types.h>
> > +#include <linux/ctype.h>
> > +#include <linux/string.h>
> > +#include <linux/root_dev.h>
> > +#include <linux/kernel.h>
> > +
> > +static char root_dev[2048] __initdata = "";
> > +static char root_opts[1024] __initdata = "";
> > +
> > +/* v9fsroot=<path>[,options] */
> > +static int __init v9fs_root_setup(char *line)
> > +{
> > +	char *s;
> > +	int len;
> > +
> > +	ROOT_DEV = Root_V9FS;
> > +
> > +	if (strlen(line) >= 1) {
> > +		/* make s point to ',' or '\0' at end of line */
> > +		s = strchrnul(line, ',');
> > +		/* len is strlen(unc) + '\0' */
> > +		len = s - line + 1;
> > +		if (len > sizeof(root_dev)) {
> > +			printk(KERN_ERR "Root-V9FS: path too long\n");
> 
> 9p has its own p9_debug helper; it's a bit awkward because even
> P9_DEBUG_ERROR right now is not displayed by default so I'm not against
> pr_err or pr_warn for important messages (I'd like to replace all such
> messages by either at some point), but at least stick to pr_xyz(...)
> rather than printk(KERN_XYZ...)
> 
okay, will use pr_err() instead then.

> > +			return 1;
> > +		}
> > +		strlcpy(root_dev, line, len);
> > +		if (*s) {
> > +			int n = snprintf(root_opts,
> > +					 sizeof(root_opts), "%s,%s",
> > +					 DEFAULT_MNT_OPTS, s + 1);
> 
> Did you actually run with this? DEFAULT_MNT_OPTS is not defined here.
> 
oops, my bad that I forgot to test the latest change.

> > +			if (n >= sizeof(root_opts)) {
> > +				printk(KERN_ERR "Root-V9FS: mount options string too long\n");
> > +				root_opts[sizeof(root_opts)-1] = '\0';
> > +				return 1;
> > +			}
> > +		}
> > +	}
> > +
> > +	return 1;
> 
> I'm also surprised this only ever returns 1, the cifs codes does the
> same but I'd be surprised the mount can work without a tag so there
> certainly should be some difference between working and not working?
>
I think this returns 1 just means the "v9fsroot=" kernel parameter is handled
so do not need further processing. But this doesn't mean the mount options can
work.

> I'd also expect ROOT_DEV to only be set on success, this doesn't make
> sense to trigger 9p mounting mechanisms with something that can't be
> mounted, leading to a long timeout (5+10+15+30*2 seconds) before a hard
> error when the hard error can be given right away.
> 
Sure, will only set ROOT_DEV after basic option checking.

> > +}
> > +
> > +__setup("v9fsroot=", v9fs_root_setup);
> > +
> > +int __init v9fs_root_data(char **dev, char **opts)
> > +{
> > +	if (!root_dev[0]) {
> > +		printk(KERN_ERR "Root-V9FS: no rootdev specified\n");
> > +		return -1;
> > +	}
> > +
> > +	*dev = root_dev;
> > +	*opts = root_opts;
> > +
> > +	return 0;
> > +}
> > diff --git a/include/linux/root_dev.h b/include/linux/root_dev.h
> > index 4e78651371ba..becd0ee2ff87 100644
> > --- a/include/linux/root_dev.h
> > +++ b/include/linux/root_dev.h
> > @@ -9,6 +9,7 @@
> >  enum {
> >  	Root_NFS = MKDEV(UNNAMED_MAJOR, 255),
> >  	Root_CIFS = MKDEV(UNNAMED_MAJOR, 254),
> > +	Root_V9FS = MKDEV(UNNAMED_MAJOR, 253),
> >  	Root_RAM0 = MKDEV(RAMDISK_MAJOR, 0),
> >  	Root_RAM1 = MKDEV(RAMDISK_MAJOR, 1),
> >  	Root_FD0 = MKDEV(FLOPPY_MAJOR, 0),
> > diff --git a/init/do_mounts.c b/init/do_mounts.c
> > index a78e44ee6adb..60af89983a6b 100644
> > --- a/init/do_mounts.c
> > +++ b/init/do_mounts.c
> > @@ -287,6 +287,8 @@ dev_t name_to_dev_t(const char *name)
> >  		return Root_NFS;
> >  	if (strcmp(name, "/dev/cifs") == 0)
> >  		return Root_CIFS;
> > +	if (strcmp(name, "/dev/v9fs") == 0)
> > +		return Root_V9FS;
> >  	if (strcmp(name, "/dev/ram") == 0)
> >  		return Root_RAM0;
> >  #ifdef CONFIG_BLOCK
> > @@ -536,6 +538,43 @@ static int __init mount_cifs_root(void)
> >  }
> >  #endif
> >  
> > +#ifdef CONFIG_9P_FS_ROOT
> > +
> > +extern int v9fs_root_data(char **dev, char **opts);
> > +
> > +#define V9FSROOT_TIMEOUT_MIN	5
> > +#define V9FSROOT_TIMEOUT_MAX	30
> > +#define V9FSROOT_RETRY_MAX	5
> > +
> > +static int __init mount_v9fs_root(void)
> > +{
> > +	char *root_dev, *root_data;
> > +	unsigned int timeout;
> > +	int try, err;
> > +
> > +	err = v9fs_root_data(&root_dev, &root_data);
> > +	if (err != 0)
> > +		return 0;
> > +
> > +	timeout = V9FSROOT_TIMEOUT_MIN;
> > +	for (try = 1; ; try++) {
> > +		err = do_mount_root(root_dev, "9p",
> > +				    root_mountflags, root_data);
> > +		if (err == 0)
> > +			return 1;
> > +		if (try > V9FSROOT_RETRY_MAX)
> > +			break;
> > +
> > +		/* Wait, in case the server refused us immediately */
> > +		ssleep(timeout);
> > +		timeout <<= 1;
> > +		if (timeout > V9FSROOT_TIMEOUT_MAX)
> > +			timeout = V9FSROOT_TIMEOUT_MAX;
> > +	}
> > +	return 0;
> > +}
> > +#endif
> > +
> >  void __init mount_root(void)
> >  {
> >  #ifdef CONFIG_ROOT_NFS
> > @@ -552,6 +591,13 @@ void __init mount_root(void)
> >  		return;
> >  	}
> >  #endif
> > +#ifdef CONFIG_9P_FS_ROOT
> > +	if (ROOT_DEV == Root_V9FS) {
> > +		if (!mount_v9fs_root())
> > +			printk(KERN_ERR "VFS: Unable to mount root fs via 9p.\n");
> > +		return;
> > +	}
> > +#endif
> >  #ifdef CONFIG_BLOCK
> >  	{
> >  		int err = create_dev("/dev/root", ROOT_DEV);
> -- 
> Dominique

-- 
Cheers,
Changbin Du

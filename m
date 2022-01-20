Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDA2494DDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 13:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241517AbiATM0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 07:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiATM0b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:26:31 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFA2C061574;
        Thu, 20 Jan 2022 04:26:31 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m4so27843702edb.10;
        Thu, 20 Jan 2022 04:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SKRq4lKenw91+Znt4tUNU3j+2p6da+FhYVba+8njzzI=;
        b=R7MxVWj3C09fc5Sb9LAqGxKYKTxKNj6ahxflEXwLVZ5le/dxNP7ddIVbJEoKWtfUm7
         nk5OJlNAQWYkYy4TCMUxawa5fwLmn285AAfAD2+/powo/MH0cw7zWxAztrK8F9GssCow
         psC51Lii4mJL3CHqO0tueRySo5atmAa5U0jBjE1q8iDYHLcNl/fFole+fECq25umr5mj
         MSGPntPqb6bJ6POwqlyvlT6dlHoU537LW66wteMDKCFOwV/0utA+J6vV72RHtHcOE92L
         OQlp+I2KFLLfNtX/8e7JH4AJQKIe092YxU4mSHgjuy4Z8s1LEJy9fBeKVG2R52dOHHbD
         QusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SKRq4lKenw91+Znt4tUNU3j+2p6da+FhYVba+8njzzI=;
        b=RpDe09hzj8jE9BVMgB1koOqV9tJ+fuX4Zj5qE3v/z01l/5wa8woUZxxRe7BWvP4fa8
         6YCRp8yY4kIbiHCVxvZQmJxcS5WpbmnAYU0RpqWl6MjYHwLEX6awZteRTDlc9W/ZEQBP
         6kCzBUZYS+5p/YWSb7bZkfyxJmL+xE0XRaZWhh8wu16eqS3UDmRbeAd7td8ftJZJwpYp
         00WXmPAtcpHw7FMJ/xBmwK/p+xOkOG8S5j5fbK4wtvu3xdPV0QsMx6gXJWuMyvHGIVvp
         1UT+sozTM3TcqtqHPK9kGM4hGb3/j0pf4ysxXMo1N/nhZCgrTWBHEyggX6d1f0FzTzKE
         BkRQ==
X-Gm-Message-State: AOAM531fmQ956KSAn0t0Jfb3FL870rdmpGyQgpZ62ZOJp7TyEcwxWAUN
        HOOfnnvQCg2H/QgwOqmyiQ==
X-Google-Smtp-Source: ABdhPJxsbHWpP+Kt9MPp2c3xlwMiGWhXywTqsoXYzn/pVpQp4DmncA19FTLBKP5E2MGRnrnG1lt9kQ==
X-Received: by 2002:a05:6402:27cd:: with SMTP id c13mr36480249ede.137.1642681589590;
        Thu, 20 Jan 2022 04:26:29 -0800 (PST)
Received: from localhost.localdomain ([46.53.254.155])
        by smtp.gmail.com with ESMTPSA id c7sm941576ejm.204.2022.01.20.04.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 04:26:29 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:26:27 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Alexey Gladkov <legion@kernel.org>
Cc:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stephen.s.brennan@oracle.com
Subject: Re: [PATCH v2] proc: "mount -o lookup=" support
Message-ID: <YelU89iAjQF07bW+@localhost.localdomain>
References: <YegysyqL3LvljK66@localhost.localdomain>
 <20220119170432.oxxaazjwvf4q6xvh@example.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119170432.oxxaazjwvf4q6xvh@example.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 06:04:32PM +0100, Alexey Gladkov wrote:
> On Wed, Jan 19, 2022 at 06:48:03PM +0300, Alexey Dobriyan wrote:
> > >From 61376c85daab50afb343ce50b5a97e562bc1c8d3 Mon Sep 17 00:00:00 2001
> > From: Alexey Dobriyan <adobriyan@gmail.com>
> > Date: Mon, 22 Nov 2021 20:41:06 +0300
> > Subject: [PATCH 1/1] proc: "mount -o lookup=..." support
> > 
> > Docker implements MaskedPaths configuration option
> > 
> > 	https://github.com/estesp/docker/blob/9c15e82f19b0ad3c5fe8617a8ec2dddc6639f40a/oci/defaults.go#L97
> > 
> > to disable certain /proc files. It overmounts them with /dev/null.
> > 
> > Implement proper mount option which selectively disables lookup/readdir
> > in the top level /proc directory so that MaskedPaths doesn't need
> > to be updated as time goes on.
> > 
> > Syntax is
> > 
> > 			Filter everything
> > 	# mount -t proc -o lookup=/ proc /proc
> > 	# ls /proc
> > 	dr-xr-xr-x   8 root       root          0 Nov 22 21:12 995
> > 	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 self -> 1163
> > 	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 thread-self -> 1163/task/1163
> > 
> > 			Allow /proc/cpuinfo and /proc/uptime
> > 	# mount -t proc proc -o lookup=cpuinfo/uptime /proc
> > 
> > 	# ls /proc
> > 				...
> > 	dr-xr-xr-x   8 root       root          0 Nov 22 21:12 995
> > 	-r--r--r--   1 root       root          0 Nov 22 21:12 cpuinfo
> > 	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 self -> 1163
> > 	lrwxrwxrwx   1 root       root          0 Nov 22 21:12 thread-self -> 1163/task/1163
> > 	-r--r--r--   1 root       root          0 Nov 22 21:12 uptime
> > 
> > Trailing slash is optional but saves 1 allocation.
> > Trailing slash is mandatory for "filter everything".
> > 
> > Remounting with lookup= is disabled so that files and dcache entries
> > don't stay active while filter list is changed. Users are supposed
> > to unmount and mount again with different lookup= set.
> > Remount rules may change in the future. (Eric W. Biederman)
> > 
> > Re: speed
> > This is the price for filtering, given that lookup= is whitelist it is
> > not supposed to be very long. Second, it is one linear memory scan per
> > lookup, there are no linked lists. It may be faster than rbtree in fact.
> > It consumes 1 allocation per superblock which is list of names itself.
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> > ---
> > 
> > 	v2
> > 	documentation!
> > 	descriptive comments!
> > 	disable remount
> > 
> >  Documentation/filesystems/proc.rst |   8 ++
> >  fs/proc/generic.c                  |  18 ++--
> >  fs/proc/internal.h                 |  31 ++++++-
> >  fs/proc/proc_net.c                 |   2 +-
> >  fs/proc/root.c                     | 127 ++++++++++++++++++++++++++++-
> >  include/linux/proc_fs.h            |   2 +
> >  6 files changed, 178 insertions(+), 10 deletions(-)
> > 
> > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > index 8d7f141c6fc7..9a328f0b4346 100644
> > --- a/Documentation/filesystems/proc.rst
> > +++ b/Documentation/filesystems/proc.rst
> > @@ -2186,6 +2186,7 @@ The following mount options are supported:
> >  	hidepid=	Set /proc/<pid>/ access mode.
> >  	gid=		Set the group authorized to learn processes information.
> >  	subset=		Show only the specified subset of procfs.
> > +        lookup=         Top-level /proc filter, independent of subset=
> 
> Will it be possible to combine lookup= and subset= options when mounting?

Currently only subset=pid is implemented, which is equivalent to

	mount -t proc -o lookup=/ proc /proc

In the future subset= might expand and lookup= could filter whatever
exposed.

> > +lookup= mount option makes available only listed files/directories in
> > +the top-level /proc directory. Individual names are separated
> > +by slash. Empty list is equivalent to subset=pid. lookup= filters before
> > +subset= if both options are supplied. lookup= doesn't affect /proc/${pid}
> > +directories availability as well as /proc/self and /proc/thread-self
> > +symlinks. More fine-grained filtering is not supported at the moment.

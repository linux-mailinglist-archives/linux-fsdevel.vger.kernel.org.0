Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 102B8EA764
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2019 23:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfJ3Wzo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Oct 2019 18:55:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40173 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfJ3Wzn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Oct 2019 18:55:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id r4so2726505pfl.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2019 15:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q+EXrAwYPi1jmJDHL1saWh2OPPKGYxQ4xx1dAqXhHyk=;
        b=dGmI5orNM/wjsPNBWdlL9JeLS4CdUoeb0iw4BSIgfI79AV0e+hbMOrCNuna06yN5C+
         I8TAi6p83eL9NJw5KuRNR03Rc/Dy/3Wt3YAj38w8HqM1HLuFN81zrFXsBR7Top2YFJ2j
         kzKL4CEnAOqjw4V4GDHleYtq43IA+m2REy5SuM+5rN8Wt39+PostlbSnZ3KOh9GxQIn2
         Y3mlrJyV6sLc0u27AxIdROq3SBFZhCxha5m6eQoOBNUCIZ2jPpep4cUinlibOI0MRMms
         y+Vs20fZWj0ngXLwWUmWfYiBPAcD02bjmvpuZxaH1ydcwaCZwPdSBt9/iR0YX0ZSO3Xu
         LCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+EXrAwYPi1jmJDHL1saWh2OPPKGYxQ4xx1dAqXhHyk=;
        b=F+DwrFDBWep7aJcsQJTCVKfL6ZOcQ/d8f91OFcDES/jbgobQkN6qj2v/TWH+kX+t7H
         DFpvBLnnzLo1+PB7vElATQw3LT7HtaUNOToqGVKSTjEKrqDsNIcRE/7g9m9eyYXlt35z
         ZSwNBL8RUorUrKYhGzS/crdODiY86caT4sW7/vooD/+K38Pc0u1MB0Yh6TMjiZqAacrc
         bnzHeVpO26m9kwytlAy6Ut9xN983eGQjYRwh2Hxn5vsYLmm1Gcr42B6Rch87IQfMJu6W
         /jj9TB4B52iNyEcdAQ7QrWXOwIh4PhaZ0fAa/Gl8DABz/aRbul/gv0v4o00w2Slxk/4Q
         BYNw==
X-Gm-Message-State: APjAAAXvdklRBdRY4KwxzVPNNdShTz5MVq2d0lr7EuivrjbgzRvBvlLh
        jCGCWsLjW8RzBBx1/igHwYUkMA==
X-Google-Smtp-Source: APXvYqxmRK8Tbsn/pocESYP1hArr6clJQ86i82SJ4Cpipgz83jobHOXYs05aDY7bpL6rzfnUHam0LA==
X-Received: by 2002:a17:90a:6d64:: with SMTP id z91mr2230443pjj.44.1572476141676;
        Wed, 30 Oct 2019 15:55:41 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::3912])
        by smtp.gmail.com with ESMTPSA id h9sm982100pfn.167.2019.10.30.15.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 15:55:41 -0700 (PDT)
Date:   Wed, 30 Oct 2019 15:55:40 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [RFC PATCH v2 1/5] fs: add O_ENCODED open flag
Message-ID: <20191030225540.GG326591@vader>
References: <cover.1571164762.git.osandov@fb.com>
 <c4d2e911b7b04df9aa8418c8b11bc4c194e3808c.1571164762.git.osandov@fb.com>
 <20191019045057.2fcrzuwc27eg5naf@yavin.dot.cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191019045057.2fcrzuwc27eg5naf@yavin.dot.cyphar.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 19, 2019 at 03:50:57PM +1100, Aleksa Sarai wrote:
> On 2019-10-15, Omar Sandoval <osandov@osandov.com> wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > The upcoming RWF_ENCODED operation introduces some security concerns:
> > 
> > 1. Compressed writes will pass arbitrary data to decompression
> >    algorithms in the kernel.
> > 2. Compressed reads can leak truncated/hole punched data.
> > 
> > Therefore, we need to require privilege for RWF_ENCODED. It's not
> > possible to do the permissions checks at the time of the read or write
> > because, e.g., io_uring submits IO from a worker thread. So, add an open
> > flag which requires CAP_SYS_ADMIN. It can also be set and cleared with
> > fcntl(). The flag is not cleared in any way on fork or exec; it should
> > probably be used with O_CLOEXEC in most cases.
> > 
> > Note that the usual issue that unknown open flags are ignored doesn't
> > really matter for O_ENCODED; if the kernel doesn't support O_ENCODED,
> > then it doesn't support RWF_ENCODED, either.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >  fs/fcntl.c                       | 10 ++++++++--
> >  fs/namei.c                       |  4 ++++
> >  include/linux/fcntl.h            |  2 +-
> >  include/uapi/asm-generic/fcntl.h |  4 ++++
> >  4 files changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > index 3d40771e8e7c..45ebc6df078e 100644
> > --- a/fs/fcntl.c
> > +++ b/fs/fcntl.c
> > @@ -30,7 +30,8 @@
> >  #include <asm/siginfo.h>
> >  #include <linux/uaccess.h>
> >  
> > -#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_NOATIME)
> > +#define SETFL_MASK (O_APPEND | O_NONBLOCK | O_NDELAY | O_DIRECT | O_NOATIME | \
> > +		    O_ENCODED)
> >  
> >  static int setfl(int fd, struct file * filp, unsigned long arg)
> >  {
> > @@ -49,6 +50,11 @@ static int setfl(int fd, struct file * filp, unsigned long arg)
> >  		if (!inode_owner_or_capable(inode))
> >  			return -EPERM;
> >  
> > +	/* O_ENCODED can only be set by superuser */
> > +	if ((arg & O_ENCODED) && !(filp->f_flags & O_ENCODED) &&
> > +	    !capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> 
> I have a feeling the error should probably be an EACCES and not EPERM.

Shrug, I wanted to make this consistent with O_NOATIME, which uses
EPERM. EACCES seems more appropriate for lacking permissions for a
particular path rather than for an operation, but the lines are blurry.

> > +
> >  	/* required for strict SunOS emulation */
> >  	if (O_NONBLOCK != O_NDELAY)
> >  	       if (arg & O_NDELAY)
> > @@ -1031,7 +1037,7 @@ static int __init fcntl_init(void)
> >  	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
> >  	 * is defined as O_NONBLOCK on some platforms and not on others.
> >  	 */
> > -	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
> > +	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
> >  		HWEIGHT32(
> >  			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
> >  			__FMODE_EXEC | __FMODE_NONOTIFY));
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 671c3c1a3425..ae86b125888a 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -2978,6 +2978,10 @@ static int may_open(const struct path *path, int acc_mode, int flag)
> >  	if (flag & O_NOATIME && !inode_owner_or_capable(inode))
> >  		return -EPERM;
> >  
> > +	/* O_ENCODED can only be set by superuser */
> > +	if ((flag & O_ENCODED) && !capable(CAP_SYS_ADMIN))
> > +		return -EPERM;
> 
> I would suggest that this check be put into build_open_flags() rather
> than putting it this late in open(). Also, same nit about the error
> return as above.

This is where we check permissions for O_NOATIME, shouldn't we keep all
of those permission checks in the same place? build_open_flags() only
checks for flag validity.

> > +
> >  	return 0;
> >  }
> >  
> > diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> > index d019df946cb2..5fac02479639 100644
> > --- a/include/linux/fcntl.h
> > +++ b/include/linux/fcntl.h
> > @@ -9,7 +9,7 @@
> >  	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
> >  	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
> >  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> > -	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> > +	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_ENCODED)
> >  
> >  #ifndef force_o_largefile
> >  #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
> > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
> > index 9dc0bf0c5a6e..8c5cbd5942e3 100644
> > --- a/include/uapi/asm-generic/fcntl.h
> > +++ b/include/uapi/asm-generic/fcntl.h
> > @@ -97,6 +97,10 @@
> >  #define O_NDELAY	O_NONBLOCK
> >  #endif
> >  
> > +#ifndef O_ENCODED
> > +#define O_ENCODED	040000000
> > +#endif
> 
> You should also define this for all of the architectures which don't use
> the generic O_* flag values. On alpha, O_PATH is equal to the value you
> picked (just be careful on sparc -- 0x4000000 is the next free bit, but
> it's used by FMODE_NONOTIFY.)

Good catch, I'll fix that. Thanks!

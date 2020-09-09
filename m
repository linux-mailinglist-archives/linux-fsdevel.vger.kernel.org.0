Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E14D2633E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 19:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730416AbgIIRLi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 13:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbgIIPdh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:33:37 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4340C061347;
        Wed,  9 Sep 2020 08:32:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s65so1265388pgb.0;
        Wed, 09 Sep 2020 08:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=trGJ50voisTKMXdWojN1XirpnONTHR3jS4BAJJ1oVsw=;
        b=F7L8weSlpk8/pODYA4tNGT+KwpHzJOoFw3Bod4mveWjwavNu+4EScbFqoVsDsCaTuL
         50rr6rAhSmYZo/Ddx9al9AO6AgcF98IjzOzN72g6mISE+8TEZLFQh8MCpcLYS5VrO0ae
         7F6aIVGhN731HWeqWq7Ua2+l9nhrpSgblpMar32OlJmqDcBOmbspJ95FcPd0rQopRE/p
         7GsUc/rm5hOz+cqdebk6kIGvIjuoTOq7NSrGCxvkQ2tNadNQiWpZdJXePmeeZklVO6vW
         idszhiT37mO9NSZZmwY/wCP/vewHJ+OvBlPYaSa5h3A6v9qzD8ieKx1m0zD6Ln/jSZrK
         BwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=trGJ50voisTKMXdWojN1XirpnONTHR3jS4BAJJ1oVsw=;
        b=TflGpMkSz2rVOhK8Rrc/Ryv2yvskeR4qQLczSnTPc+jJd+FSDT2+3MoT3GJ/9wNZoA
         3/gKOAbvbudJJ36rFOpCgrbpDnA7psDw3shHqrxvncMECC7rGemWC8qY/MoTgxCI994M
         c4t0af1km+u9F4ZBUj2DYQN1nxJmbZdlrcqAHL6K8ZAjspReqD1b3hq1487Ssl5aX9be
         EKl0o6GC/p2MWEU+9vdujCVnFzk61IomKYmX15aUMRkIzm2ozCax5obzwiVDV3fUR2zA
         NrIASRLDYMIrfaX0WP3qTVgLhOFw0butiUEVoFkwTbb3lfgTVWScuvAEocbVvQJBLel3
         bJxA==
X-Gm-Message-State: AOAM5332i22ta/lcBNgETW01kig/yiVcDCdmOvAEbixYjQY4/ffUssu2
        WnJEViwwehFn+hgiupK6SP4=
X-Google-Smtp-Source: ABdhPJwYsuOpqojCS7ZyITqMamrO8ggPUW2+PUpO9xFfkiZyVjwWNPOrwLPiCLxyOjWzngiJ90vx9A==
X-Received: by 2002:a63:4822:: with SMTP id v34mr1010403pga.342.1599665565409;
        Wed, 09 Sep 2020 08:32:45 -0700 (PDT)
Received: from haolee.github.io ([2600:3c01::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id i62sm3194036pfe.140.2020.09.09.08.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:32:44 -0700 (PDT)
Date:   Wed, 9 Sep 2020 15:32:43 +0000
From:   Hao Lee <haolee.swjtu@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Eliminate a local variable to make the code more
 clear
Message-ID: <20200909153243.GA25215@haolee.github.io>
References: <20200729151740.GA3430@haolee.github.io>
 <20200908130656.GC22780@haolee.github.io>
 <20200908184857.GT1236603@ZenIV.linux.org.uk>
 <20200908231156.GA23779@haolee.github.io>
 <87k0x39kkr.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0x39kkr.fsf@x220.int.ebiederm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 09, 2020 at 07:54:44AM -0500, Eric W. Biederman wrote:
> Hao Lee <haolee.swjtu@gmail.com> writes:
> 
> > On Tue, Sep 08, 2020 at 07:48:57PM +0100, Al Viro wrote:
> >> On Tue, Sep 08, 2020 at 01:06:56PM +0000, Hao Lee wrote:
> >> > ping
> >> > 
> >> > On Wed, Jul 29, 2020 at 03:21:28PM +0000, Hao Lee wrote:
> >> > > The dentry local variable is introduced in 'commit 84d17192d2afd ("get
> >> > > rid of full-hash scan on detaching vfsmounts")' to reduce the length of
> >> > > some long statements for example
> >> > > mutex_lock(&path->dentry->d_inode->i_mutex). We have already used
> >> > > inode_lock(dentry->d_inode) to do the same thing now, and its length is
> >> > > acceptable. Furthermore, it seems not concise that assign path->dentry
> >> > > to local variable dentry in the statement before goto. So, this function
> >> > > would be more clear if we eliminate the local variable dentry.
> >> 
> >> How does it make the function more clear?  More specifically, what
> >> analysis of behaviour is simplified by that?
> >
> > When I first read this function, it takes me a few seconds to think
> > about if the local variable dentry is always equal to path->dentry and
> > want to know if it has special purpose. This local variable may confuse
> > other people too, so I think it would be better to eliminate it.
> 
> I tend to have the opposite reaction.  I read your patch and wonder
> why path->dentry needs to be reread what is changing path that I can not see.
> my back.

If I understand correctly, accessing path->dentry->d_inode needs one
more instruction than accessing dentry->d_inode, so the original code is
more efficient.

> 
> Now for clarity it would probably help to do something like:
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index bae0e95b3713..430f3b4785e3 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2206,7 +2206,7 @@ static struct mountpoint *lock_mount(struct path *path)
>                 return mp;
>         }
>         namespace_unlock();
> -       inode_unlock(path->dentry->d_inode);
> +       inode_unlock(dentry->d_inode);
>         path_put(path);
>         path->mnt = mnt;
>         dentry = path->dentry = dget(mnt->mnt_root);
> 
> 
> So at least the inode_lock and inode_unlock are properly paired.
> 
> At first glance inode_unlock using path->dentry instead of dentry
> appears to be an oversight in 84d17192d2af ("get rid of full-hash scan
> on detaching vfsmounts").  

I think I have understood why we use the local variable dentry. Thanks.

Regards,
Hao Lee

> 
> 
> Eric

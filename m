Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2DF433B04
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 17:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhJSPtG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 11:49:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:59264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhJSPtF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 11:49:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38C76610C7;
        Tue, 19 Oct 2021 15:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634658412;
        bh=67SC+1FKNIhtaifskaOaeFgNFOiPb79JlJDhJDbdXL0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ACoUtrEJX4wt/9AlA98Ou0ZRiySUWjDcmOzmdybSfxe1vbHFNfpNi7DbYEbHI+Cra
         cUG/Y9gn4qksIF4guX7gRb7Ee4eJSZf5lQe3cd6AhMd/YIXG8DHmVeknOZAaQjp9f3
         zaVPKGzbVNjpq2Vn1cDqbj2Hkp7nOoAECz35B2mUVxLG/AYA/M9GamiwxWANA5UHvS
         IYMI+bEW1MF6wvHMdFGD8w//6D0rNT7/5xfMfJl5KSa+5sqg+6mcjo7G300FNjfWSu
         KBUEJoRvrOtgl4IGjup7+kxm4Nctn8CnwXYHxV0toaAflTopaMCv/CtOp76P1RlFcM
         QTldYGidv6PWQ==
Message-ID: <e7bdcf0b279989e51c2c333e89acf3e1d476eff0.camel@kernel.org>
Subject: Re: [PATCH v3 18/23] fs: remove a comment pointing to the removed
 mandatory-locking file
From:   Jeff Layton <jlayton@kernel.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 19 Oct 2021 11:46:51 -0400
In-Reply-To: <20211019141427.GA15063@fieldses.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
         <887de3a1ecadda3dbfe0adf9df9070f0afa9406c.1634630486.git.mchehab+huawei@kernel.org>
         <f352a2e4b50a8678a8ddef5177702ecf9040490f.camel@kernel.org>
         <20211019141427.GA15063@fieldses.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-10-19 at 10:14 -0400, J. Bruce Fields wrote:
> On Tue, Oct 19, 2021 at 06:50:21AM -0400, Jeff Layton wrote:
> > On Tue, 2021-10-19 at 09:04 +0100, Mauro Carvalho Chehab wrote:
> > > The mandatory file locking got removed due to its problems, but
> > > there's still a comment inside fs/locks.c pointing to the removed
> > > doc.
> > > 
> > > Remove it.
> > > 
> > > Fixes: f7e33bdbd6d1 ("fs: remove mandatory file locking support")
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > > 
> > > To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > > See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/
> > > 
> > >  fs/locks.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > > 
> > > diff --git a/fs/locks.c b/fs/locks.c
> > > index d397394633be..94feadcdab4e 100644
> > > --- a/fs/locks.c
> > > +++ b/fs/locks.c
> > > @@ -61,7 +61,6 @@
> > >   *
> > >   *  Initial implementation of mandatory locks. SunOS turned out to be
> > >   *  a rotten model, so I implemented the "obvious" semantics.
> > > - *  See 'Documentation/filesystems/mandatory-locking.rst' for details.
> > >   *  Andy Walker (andy@lysaker.kvaerner.no), April 06, 1996.
> > >   *
> > >   *  Don't allow mandatory locks on mmap()'ed files. Added simple functions to
> > 
> > Thanks Mauro. I'll pick this into my locks branch, so it should make
> > v5.16 as well.
> 
> Could we delete the rest too?
> 
> We don't do those changelog-style comments any more; they're in the git
> history if you need them.  I can sort of get leaving some in out of
> respect or if they've still provide some useful information.  But
> keeping comments referring to code that doesn't even exist any more just
> seems confusing.
> 
> --b.
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 3d6fb4ae847b..2540b7aedeac 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -59,17 +59,6 @@
>   *  once we've checked for blocking and deadlocking.
>   *  Andy Walker (andy@lysaker.kvaerner.no), April 03, 1996.
>   *
> - *  Initial implementation of mandatory locks. SunOS turned out to be
> - *  a rotten model, so I implemented the "obvious" semantics.
> - *  See 'Documentation/filesystems/mandatory-locking.rst' for details.
> - *  Andy Walker (andy@lysaker.kvaerner.no), April 06, 1996.
> - *
> - *  Don't allow mandatory locks on mmap()'ed files. Added simple functions to
> - *  check if a file has mandatory locks, used by mmap(), open() and creat() to
> - *  see if system call should be rejected. Ref. HP-UX/SunOS/Solaris Reference
> - *  Manual, Section 2.
> - *  Andy Walker (andy@lysaker.kvaerner.no), April 09, 1996.
> - *
>   *  Tidied up block list handling. Added '/proc/locks' interface.
>   *  Andy Walker (andy@lysaker.kvaerner.no), April 24, 1996.
>   *
> @@ -95,10 +84,6 @@
>   *  Made the block list a circular list to minimise searching in the list.
>   *  Andy Walker (andy@lysaker.kvaerner.no), Sep 25, 1996.
>   *
> - *  Made mandatory locking a mount option. Default is not to allow mandatory
> - *  locking.
> - *  Andy Walker (andy@lysaker.kvaerner.no), Oct 04, 1996.
> - *
>   *  Some adaptations for NFS support.
>   *  Olaf Kirch (okir@monad.swb.de), Dec 1996,
>   *

IDK...Do we want to "erase history" selectively like that?

Maybe we should just get rid of the whole pile of "changelog" comments
in fs/locks.c? They aren't terribly useful these days anyhow.

-- 
Jeff Layton <jlayton@kernel.org>


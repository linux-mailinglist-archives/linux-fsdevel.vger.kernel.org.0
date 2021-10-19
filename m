Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B123143382B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Oct 2021 16:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhJSOQl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Oct 2021 10:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhJSOQl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Oct 2021 10:16:41 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566CCC06161C;
        Tue, 19 Oct 2021 07:14:28 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 9F2FE50D7; Tue, 19 Oct 2021 10:14:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 9F2FE50D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1634652867;
        bh=lt8qvOTFKGhiOOshAxcj3oNU5jo8B3ig8SJPket4UkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cm3SLPC0/FfrO0FP4N9LWvMC3i7KEzleNElr3DI7yo0fw/eypo1sOOitpDfEiwCTZ
         mmz9oybp7k+6nuXiL7n1mphTNW+GEb2/yZYk3CU+nkC0J+rCpgZcD+4IXcacf+d5NB
         2Vc5cqZBVAw03H1SnyA6kNOcfub7LkDKnwEN1HEg=
Date:   Tue, 19 Oct 2021 10:14:27 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 18/23] fs: remove a comment pointing to the removed
 mandatory-locking file
Message-ID: <20211019141427.GA15063@fieldses.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
 <887de3a1ecadda3dbfe0adf9df9070f0afa9406c.1634630486.git.mchehab+huawei@kernel.org>
 <f352a2e4b50a8678a8ddef5177702ecf9040490f.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f352a2e4b50a8678a8ddef5177702ecf9040490f.camel@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 19, 2021 at 06:50:21AM -0400, Jeff Layton wrote:
> On Tue, 2021-10-19 at 09:04 +0100, Mauro Carvalho Chehab wrote:
> > The mandatory file locking got removed due to its problems, but
> > there's still a comment inside fs/locks.c pointing to the removed
> > doc.
> > 
> > Remove it.
> > 
> > Fixes: f7e33bdbd6d1 ("fs: remove mandatory file locking support")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> > 
> > To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/
> > 
> >  fs/locks.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/fs/locks.c b/fs/locks.c
> > index d397394633be..94feadcdab4e 100644
> > --- a/fs/locks.c
> > +++ b/fs/locks.c
> > @@ -61,7 +61,6 @@
> >   *
> >   *  Initial implementation of mandatory locks. SunOS turned out to be
> >   *  a rotten model, so I implemented the "obvious" semantics.
> > - *  See 'Documentation/filesystems/mandatory-locking.rst' for details.
> >   *  Andy Walker (andy@lysaker.kvaerner.no), April 06, 1996.
> >   *
> >   *  Don't allow mandatory locks on mmap()'ed files. Added simple functions to
> 
> Thanks Mauro. I'll pick this into my locks branch, so it should make
> v5.16 as well.

Could we delete the rest too?

We don't do those changelog-style comments any more; they're in the git
history if you need them.  I can sort of get leaving some in out of
respect or if they've still provide some useful information.  But
keeping comments referring to code that doesn't even exist any more just
seems confusing.

--b.

diff --git a/fs/locks.c b/fs/locks.c
index 3d6fb4ae847b..2540b7aedeac 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -59,17 +59,6 @@
  *  once we've checked for blocking and deadlocking.
  *  Andy Walker (andy@lysaker.kvaerner.no), April 03, 1996.
  *
- *  Initial implementation of mandatory locks. SunOS turned out to be
- *  a rotten model, so I implemented the "obvious" semantics.
- *  See 'Documentation/filesystems/mandatory-locking.rst' for details.
- *  Andy Walker (andy@lysaker.kvaerner.no), April 06, 1996.
- *
- *  Don't allow mandatory locks on mmap()'ed files. Added simple functions to
- *  check if a file has mandatory locks, used by mmap(), open() and creat() to
- *  see if system call should be rejected. Ref. HP-UX/SunOS/Solaris Reference
- *  Manual, Section 2.
- *  Andy Walker (andy@lysaker.kvaerner.no), April 09, 1996.
- *
  *  Tidied up block list handling. Added '/proc/locks' interface.
  *  Andy Walker (andy@lysaker.kvaerner.no), April 24, 1996.
  *
@@ -95,10 +84,6 @@
  *  Made the block list a circular list to minimise searching in the list.
  *  Andy Walker (andy@lysaker.kvaerner.no), Sep 25, 1996.
  *
- *  Made mandatory locking a mount option. Default is not to allow mandatory
- *  locking.
- *  Andy Walker (andy@lysaker.kvaerner.no), Oct 04, 1996.
- *
  *  Some adaptations for NFS support.
  *  Olaf Kirch (okir@monad.swb.de), Dec 1996,
  *

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0664B6D7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 22:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbfIRU0c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 16:26:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730892AbfIRU0c (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:26:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3505E21897;
        Wed, 18 Sep 2019 20:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568838391;
        bh=b121uJlnZpdyC7nWhbV1OT40vYybgUmU7vaeAm0qmvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ji6Q685JYPrNKpsjOaFmL7aCE6IYQUsu0vF+fh8q+iELRyh+c6LKDpw2tDTIGyUXZ
         JpXQrRAthVSbUZRW4ebSTBGOMD3KwMfgV1f23oTONY+J7Kr25NafVNkcfn/+LAE/sy
         yw+a4UyoXJPkmcJamdmhBK0tJhuHsolLBm07qaQM=
Date:   Wed, 18 Sep 2019 22:26:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ju Hyung Park <qkrwngud825@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>, sj1557.seo@samsung.com,
        devel@driverdev.osuosl.org, linkinjeon@gmail.com,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org, alexander.levin@microsoft.com,
        sergey.senozhatsky@gmail.com, linux-fsdevel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: exfat: rebase to sdFAT v2.2.0
Message-ID: <20190918202629.GA2026850@kroah.com>
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
 <20190918195920.25210-1-qkrwngud825@gmail.com>
 <20190918201318.GB2025570@kroah.com>
 <CAD14+f0YeAPxmLbxB5gpJbNyjE1YiDyicBXeodwKN4Wvm_qJwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD14+f0YeAPxmLbxB5gpJbNyjE1YiDyicBXeodwKN4Wvm_qJwA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 19, 2019 at 05:22:03AM +0900, Ju Hyung Park wrote:
> Hi Greg,
> 
> On Thu, Sep 19, 2019 at 5:12 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > That's a lot of rewriting :(
> >
> > How about at least keeping the file names the same to make it easier to
> > see what happened here?
> >
> > Then send a follow-on patch that just does the rename?
> 
> That's still not quite useful tbh, lemme bring the diff stat I wrote
> in previous email just in case you missed it:
> <Full diff stat>
>  Kconfig      |   79 +-
>  Makefile     |   46 +-
>  api.c        |  423 ----
>  api.h        |  310 ---
>  blkdev.c     |  409 +---
>  cache.c      | 1142 ++++-----
>  config.h     |   49 -
>  core.c       | 5583 ++++++++++++++++++++++++--------------------
>  core.h       |  196 --
>  core_exfat.c | 1553 ------------
>  exfat.h      | 1309 +++++++----
>  exfat_fs.h   |  417 ----
>  extent.c     |  351 ---
>  fatent.c     |  182 --
>  misc.c       |  401 ----
>  nls.c        |  490 ++--
>  super.c      | 5103 +++++++++++++++++++++-------------------
>  upcase.c     |  740 ++++++
>  upcase.h     |  407 ----
>  version.h    |   29 -
>  xattr.c      |  136 --
>  21 files changed, 8186 insertions(+), 11169 deletions(-)
> 
> <diff-filter=M>
>  Kconfig  |   79 +-
>  Makefile |   46 +-
>  blkdev.c |  409 +---
>  cache.c  | 1142 +++++-----
>  core.c   | 5583 ++++++++++++++++++++++++++----------------------
>  exfat.h  | 1309 ++++++++----
>  nls.c    |  490 ++---
>  super.c  | 5103 ++++++++++++++++++++++---------------------
>  8 files changed, 7446 insertions(+), 6715 deletions(-)
> 
> These diff stats were taken by removing "exfat_" prefix from the
> current staging drivers.
> 
> But if that's still what you want, I'll do it.

It will show easier when you do funny things like take off the
formatting of the huge tables for no good reason :)

> btw, removing "exfat_" prefix from the current one makes more sense imo.

I agree.

> If we add "exfat_" prefix to the new one, we get weird file names like
> "exfat_core_exfat.c".

Agreed.

> > And by taking something like this, are you agreeing that Samsung will
> > help out with the development of this code to clean it up and get it
> > into "real" mergable shape?
> 
> Well, I think you got me confused with Namjae.
> (Yeah Korean names are confusing I know :) )

It was a general ask, that's all :)

> Namjae (or anyone else from Samsung) should answer that, not me.
> 
> I just prepared a patch as we were getting nowhere like you mentioned :)
> 
> > Also, I can't take this patch for this simple reason alone:
> > Don't delete SPDX lines :)
> 
> Sorry.
> I'll add that back for v2.
> 
> On Thu, Sep 19, 2019 at 5:13 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Sep 19, 2019 at 04:59:20AM +0900, Park Ju Hyung wrote:
> > > --- a/drivers/staging/exfat/exfat.h
> > > +++ b/drivers/staging/exfat/exfat.h
> > > @@ -1,4 +1,4 @@
> > > -/* SPDX-License-Identifier: GPL-2.0 */
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> >
> > You just changed the license of this file.  Are you SURE about that?
> 
> The sdFAT code release explicitly states "either version 2 of the
> License, or (at your option) any later version", so I thought that
> makes sense:
> https://github.com/arter97/exfat-linux/commit/d5393c4cbe0e5b50231aacd33d9b5b0ddf46a005
> 
> Please correct me if I'm wrong.

That differs from the original exfat code, so something is odd here.  I
need some sort of clarification from Samsung as to when they changed the
license in order to be able to relicense these files.

thanks,

greg k-h

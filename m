Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEC5184EB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 19:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgCMSfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 14:35:15 -0400
Received: from hr2.samba.org ([144.76.82.148]:59188 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbgCMSfO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Cc:To:From:Date;
        bh=WW96sv0//Vhg79QaiYlSOEgUUQBStmetDMf4TONIc6M=; b=kIlHxupkrQOi9TzlSzfbE4/bDL
        uXCSnq22mxKKsPp4wsY2SjwgRHrGGUjd5PkshA6/Ij7StaJi+8cCOXa+2uy4ujPSwXlu4A9n3fflf
        XkyYa3DkycxsDmAzUHRsrhw/lk4UQEuZG4SUx77yN3+V1HapwvdE+wEtw1OqGFv2+0PFrzzEuTaf/
        UILafbWfwJ6SVlMnnuB2/AhboOh8yg4LEOd40ctbA5s+rP3kSe79DPDaQA93TxktwMI4ekakTqtcG
        6UsWH3CbrSZH8DYC3XwCombBEVbF1GH+zILxk/YiipBOVfVlGS6LpdTFyGanweoKoy2YO/1N0o8Q9
        RhjdcWajNX5yyJ0vVHYm3FrfIeucAWOay4dqo9PauHbqEoCHY1eujrUgDXPg4HMaIlFtRVnOC6Q4E
        1KLWYGQz1OmRlsyhTOvvjXdzI88D+i+MKn2RMug3oipCgs+yrtta2s96ODrrQVXqGTHTk2wQZX736
        ghOoK4n2imWOy9qW7TdbFV1f;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1jCp9J-00029j-FH; Fri, 13 Mar 2020 18:35:09 +0000
Date:   Fri, 13 Mar 2020 11:35:03 -0700
From:   Jeremy Allison <jra@samba.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Stefan Metzmacher <metze@samba.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, jlayton@redhat.com,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralph =?iso-8859-1?Q?B=F6hme?= <slow@samba.org>,
        Volker Lendecke <vl@sernet.de>
Subject: Re: [PATCH 01/14] VFS: Add additional RESOLVE_* flags [ver #18]
Message-ID: <20200313183503.GA29092@jeremy-acer>
Reply-To: Jeremy Allison <jra@samba.org>
References: <158376245699.344135.7522994074747336376.stgit@warthog.procyon.org.uk>
 <20200310005549.adrn3yf4mbljc5f6@yavin>
 <CAHk-=wiEBNFJ0_riJnpuUXTO7+_HByVo-R3pGoB_84qv3LzHxA@mail.gmail.com>
 <580352.1583825105@warthog.procyon.org.uk>
 <CAHk-=wiaL6zznNtCHKg6+MJuCqDxO=yVfms3qR9A0czjKuSSiA@mail.gmail.com>
 <3d209e29-e73d-23a6-5c6f-0267b1e669b6@samba.org>
 <CAHk-=wgu3Wo_xcjXnwski7JZTwQFaMmKD0hoTZ=hqQv3-YojSg@mail.gmail.com>
 <8d24e9f6-8e90-96bb-6e98-035127af0327@samba.org>
 <20200313095901.tdv4vl7envypgqfz@yavin>
 <20200313182844.GO23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313182844.GO23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 13, 2020 at 06:28:44PM +0000, Al Viro wrote:
> On Fri, Mar 13, 2020 at 08:59:01PM +1100, Aleksa Sarai wrote:
> > On 2020-03-12, Stefan Metzmacher <metze@samba.org> wrote:
> > > Am 12.03.20 um 17:24 schrieb Linus Torvalds:
> > > > But yes, if we have a major package like samba use it, then by all
> > > > means let's add linkat2(). How many things are we talking about? We
> > > > have a number of system calls that do *not* take flags, but do do
> > > > pathname walking. I'm thinking things like "mkdirat()"?)
> > > 
> > > I haven't looked them up in detail yet.
> > > Jeremy can you provide a list?
> > > 
> > > Do you think we could route some of them like mkdirat() and mknodat()
> > > via openat2() instead of creating new syscalls?
> > 
> > I have heard some folks asking for a way to create a directory and get a
> > handle to it atomically -- so arguably this is something that could be
> > inside openat2()'s feature set (O_MKDIR?). But I'm not sure how popular
> > of an idea this is.
> 
> For fuck sake, *NO*!
> 
> We don't need any more multiplexors from hell.  mkdir() and open() have
> deeply different interpretation of pathnames (and anyone who asks for
> e.g. traversals of dangling symlinks on mkdir() is insane).  Don't try to
> mix those; even O_TMPFILE had been a mistake.
> 
> Folks, we'd paid very dearly for the atomic_open() merge.  We are _still_
> paying for it - and keep finding bugs induced by the convoluted horrors
> in that thing (see yesterday pull from vfs.git#fixes for the latest crop).
> I hope to get into more or less sane shape (part - this cycle, with
> followups in the next one), but the last thing we need is more complexity
> in the area.

Can we disentangle the laudable desire to keep kernel internals
simple (which I completely agree with :-) from the desire to
keep user-space interfaces simple ?

Having some way of doing a mkdir() that returns an open fd
on the new directory *is* a very useful thing for many applications,
but I really don't care how the kernel implements it. We have so much
Linux-specific code already that one more thing won't matter :-).

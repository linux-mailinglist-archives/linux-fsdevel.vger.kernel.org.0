Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAC93F69C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 21:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhHXTYv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 15:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbhHXTYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:24:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5794C061757;
        Tue, 24 Aug 2021 12:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X8On0rvSlTf2kwEiCNni3hrMmk2GB9B1Xxobnp0lp50=; b=ZAAmdQHAh8CWEWijVzZBirJIhJ
        lQ9e6F3VrkBIeYkpng+GikejRUuB3escokoxF3WhrG552QCMahoipFcMQUFrhzDF/1ovOMg5u2J0z
        dt7KvcGQFT7/OMsrFfjcjQ5m0s0bMQD+nQw4tSe/+QtJ8MAXlEmcr/bNHtb5qUvEs6ThNh6VuIq1V
        gSxVMvwboHRoNjVVFO2ShaapMrsx2a2z+4Dg/kPe5ODNKwjdR/rGYZUuSYrKOVCn5BcJ4Y6T1a0MK
        GF4ie5suYFVqu4q6a0Gy1vZ3GAYcG9vDGW98j41GdLrL/4ig/buigyujgMrxynn0n4flkSo4b9RhM
        xOXcdTkA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIc0x-00BTx6-Oo; Tue, 24 Aug 2021 19:23:21 +0000
Date:   Tue, 24 Aug 2021 20:23:15 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSVHI9iaamxTGmI7@casper.infradead.org>
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk>
 <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <YSVCAJDYShQke6Sy@casper.infradead.org>
 <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 12:11:49PM -0700, Linus Torvalds wrote:
> On Tue, Aug 24, 2021 at 12:02 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Choosing short words at random from /usr/share/dict/words:
> 
> I don't think you're getting my point.
> 
> In fact, you're just making it WORSE.
> 
> "short" and "greppable" is not the main issue here.
> 
> "understandable" and "follows other conventions" is.
> 
> And those "other conventions" are not "book binders in the 17th
> century". They are about operating system design.
> 
> So when you mention "slab" as a name example, that's not the argument
> you think it is. That's a real honest-to-goodness operating system
> convention name that doesn't exactly predate Linux, but is most
> certainly not new.

Sure, but at the time Jeff Bonwick chose it, it had no meaning in
computer science or operating system design.  Whatever name is chosen,
we'll get used to it.  I don't even care what name it is.

I want "short" because it ends up used everywhere.  I don't want to
be typing
	lock_hippopotamus(hippopotamus);

and I want greppable so it's not confused with something somebody else
has already used as an identifier.

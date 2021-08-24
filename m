Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AD93F6972
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 21:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhHXTD3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 15:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbhHXTD2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:03:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D84C061764;
        Tue, 24 Aug 2021 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/URawqNzD9p24ByjtYjkORGk8sChIZbeqxBr5P92U1E=; b=T0bMyPf0DHvC4HBKpfhArM/Nuq
        bOJFItaWCupAM2hBMS9krR1VoxfkreTkA+4eisVSsLFoBShTjXrJBL4l2AcwDMoRKJ36GzeqFc8xX
        PssQciEFhlHo5P4lBv6rcqrU+tDQG9aWo5to42Zh+4PP4uPP5kPaemLZaW7T+h7uUE2Qcr8gS8Vl8
        vzKjW+l7OtBNmeI/VKUu5byvZGNcU4frdfIPlQ8sSp5osQvUcIIY5M0qzDmplwWjKG6TmXC+s3F/Y
        B1zpDJFRepPZVve9OlzuAtOGm/0V25qjO3+79u7JCb4/5qdwkYfTTBFc8d8Sy/Bt0wjesbcrupXh2
        dsxJzm2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIbfk-00BSyq-Mo; Tue, 24 Aug 2021 19:01:42 +0000
Date:   Tue, 24 Aug 2021 20:01:20 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
Message-ID: <YSVCAJDYShQke6Sy@casper.infradead.org>
References: <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk>
 <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 11:26:30AM -0700, Linus Torvalds wrote:
> On Tue, Aug 24, 2021 at 11:17 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > If the only thing standing between this patch and the merge is
> > s/folio/ream/g,
> 
> I really don't think that helps. All the book-binding analogies are
> only confusing.
> 
> If anything, I'd make things more explicit. Stupid and
> straightforward. Maybe just "struct head_page" or something like that.
> Name it by what it *is*, not by analogies.

I don't mind calling it something entirely different.  I mean, the word
"slab" has nothing to do with memory or pages or anything.  I just want
something short and greppable.  Choosing short words at random from
/usr/share/dict/words:

belt gala claw ogre peck raft 
bowl moat cask deck rink toga


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6863F74D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Aug 2021 14:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbhHYMJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 08:09:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:54426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240598AbhHYMJf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:09:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33D2C610E6;
        Wed, 25 Aug 2021 12:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629893328;
        bh=FIFl9ZJpPgUJdHEDp/lmt+sw2tTDcKmFcMfQHZaov/E=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M7D6yPvBkKIKjPdUOz94jWfmtGYV35KIJmOHAwq79SUVjmln091edxptunoGWqdiS
         MAwA7V/nP2c/NNPYCqKN/QIa72l2DJtqu6oib5djyoQsY1lc83+H+qR52ADheuB4KF
         X0d/5aKd2Yz3ihkG8BjKKlrN7+H1AD3RiU2jJeHGGO7QqtN0+Uyi7ZEtiz/fvCq8A7
         mSCzdKDoZ+keom6JK45cRzjx1yQeTlti0y742kJQXAhAuSd3JmI+kfB3O3o+SFx2hu
         qbFLND6zO8Yh0AFEpub5gK1tFWe6Fp5pFpTzQt6Ie7x0R0BMoDuIMan+LDqLwGqmHP
         3GSaOOjkk/jaQ==
Message-ID: <85cc13e120734cc10aaf47b2bb12d65ec9e75f93.camel@kernel.org>
Subject: Re: [GIT PULL] Memory folios for v5.15
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>, Theodore Ts'o <tytso@mit.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 25 Aug 2021 08:08:46 -0400
In-Reply-To: <1974380.1629840723@warthog.procyon.org.uk>
References: <YSVQOgrPhwGcUSp4@mit.edu> <YSVH6k5plj9lrTFe@mit.edu>
         <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
         <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
         <1957060.1629820467@warthog.procyon.org.uk>
         <YSUy2WwO9cuokkW0@casper.infradead.org>
         <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
         <CAHk-=wgRdqtpsbHkKeqpRWUsuJwsfewCL4SZN2udXVgExFZOWw@mail.gmail.com>
         <1967090.1629833687@warthog.procyon.org.uk>
         <1974380.1629840723@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-08-24 at 22:32 +0100, David Howells wrote:
> Theodore Ts'o <tytso@mit.edu> wrote:
> 
> > What do you think of "struct pageset"?  Not quite as short as folios,
> > but it's clearer.
> 
> Fine by me (I suggested page_set), and as Vlastimil points out, the current
> usage of the name could be renamed.
> 

I honestly fail to see how any of this is better than "folio".

It's just a name, and "folio" has the advantage of being fairly unique.
The greppability that Willy mentioned is a perk, but folio also doesn't
sound similar to other words when discussing them verbally. That's
another advantage.

If I say "pageset" in a conversation, do I mean "struct pageset" or "a
random set of pages"? If I say  "folio", it's much more clear to what
I'm referring.

We've had a lot of time to get used to "page" as a term of art. We'd get
used to folio too.
-- 
Jeff Layton <jlayton@kernel.org>


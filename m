Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCE140CD09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 21:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhIOTQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 15:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbhIOTQf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 15:16:35 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B93C061574;
        Wed, 15 Sep 2021 12:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1631733315;
        bh=y6RJYPdDFdyu6WcAgzIYV17iU/gN+vlkm7UajawX/lg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=sxmtb/TUzwFCkYcw2fd90dlzdZJrYY2wkO//Ngg6bbfSdTYm7r+lQsHOEDmC0yFpL
         lQxoONWuUiojeSdfYBsHvGZR5e9tqx3mMdaLS4wyAHAHf5knItNc4+ecLsOkOt1zYT
         /FHXaI5U4c5/OGp4agpdRoSft2nkuNYarDC8zsFk=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A79DE12805FF;
        Wed, 15 Sep 2021 12:15:15 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oEVmn9C18TMb; Wed, 15 Sep 2021 12:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1631733315;
        bh=y6RJYPdDFdyu6WcAgzIYV17iU/gN+vlkm7UajawX/lg=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=sxmtb/TUzwFCkYcw2fd90dlzdZJrYY2wkO//Ngg6bbfSdTYm7r+lQsHOEDmC0yFpL
         lQxoONWuUiojeSdfYBsHvGZR5e9tqx3mMdaLS4wyAHAHf5knItNc4+ecLsOkOt1zYT
         /FHXaI5U4c5/OGp4agpdRoSft2nkuNYarDC8zsFk=
Received: from jarvis.lan (c-67-166-170-96.hsd1.va.comcast.net [67.166.170.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 3093612805FB;
        Wed, 15 Sep 2021 12:15:14 -0700 (PDT)
Message-ID: <f066615c0e2c6fe990fa5c19dd1c17d649bcb03a.camel@HansenPartnership.com>
Subject: Re: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers
 Summit topic?
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Chris Mason <clm@fb.com>, Theodore Ts'o <tytso@mit.edu>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>
Date:   Wed, 15 Sep 2021 15:15:13 -0400
In-Reply-To: <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
         <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
         <YUI5bk/94yHPZIqJ@mit.edu> <17242A0C-3613-41BB-84E4-2617A182216E@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-09-15 at 18:41 +0000, Chris Mason wrote:
> > On Sep 15, 2021, at 2:20 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> > 
> > On Wed, Sep 15, 2021 at 02:03:46PM -0400, James Bottomley wrote:
> > > On Wed, 2021-09-15 at 13:42 -0400, Theodore Ts'o wrote:
> > > [...]
> > > > Would this be helpful?  (Or Linus could pull either the folio
> > > > or pageset branch, and make this proposal obsolete, which would
> > > > be great.  :-)
> > > 
> > > This is a technical rather than process issue isn't it?  You
> > > don't have enough technical people at the Maintainer summit to
> > > help meaningfully.  The ideal location, of course, was LSF/MM
> > > which is now not happening.
> > > 
> > > However, we did offer the Plumbers BBB infrastructure to willy
> > > for a MM gathering which could be expanded to include this.
> > 
> > Well, that's why I was suggesting doing this as a LPC BOF, and
> > using an LPC BOF session on Friday --- I'm very much aware we don't
> > have the right tehcnical people at the Maintainer Summit.
> > 
> > It's not clear we will have enough MM folks at the LPC, and I agree
> > LSF/MM would be a better venue --- but as you say, it's not
> > happening. We could also use the BBB infrastructure after the LPC
> > as well, if we can't get everyone lined up and available on short
> > notice.  There are a lot of different possibilities; I'm for
> > anything where all of the stakeholders agree will work, so we can
> > make forward progress.
> 
> I think the two different questions are:
> 
> * What work is left for merging folios?

My reading of the email threads is that they're iterating to an actual
conclusion (I admit, I'm surprised) ... or at least the disagreements
are getting less.  Since the merge window closed this is now a 5.16
thing, so there's no huge urgency to getting it resolved next week.

> * What process should we use to make the overall development of folio
> sized changes more predictable and rewarding for everyone involved?

Well, the current one seems to be working (admittedly eventually, so
achieving faster resolution next time might be good) ... but I'm sure
you could propose alternatives ... especially in the time to resolution
department.

James



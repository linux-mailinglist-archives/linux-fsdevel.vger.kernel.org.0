Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157DA410139
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Sep 2021 00:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbhIQW1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 18:27:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55134 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232719AbhIQW1M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 18:27:12 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 18HMPY8h005995
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 18:25:34 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3CFF515C0098; Fri, 17 Sep 2021 18:25:34 -0400 (EDT)
Date:   Fri, 17 Sep 2021 18:25:34 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: Folio discussion recap
Message-ID: <YUUV3uHhh/PCqXsK@mit.edu>
References: <YSPwmNNuuQhXNToQ@casper.infradead.org>
 <YTu9HIu+wWWvZLxp@moria.home.lan>
 <YUIT2/xXwvZ4IErc@cmpxchg.org>
 <20210916025854.GE34899@magnolia>
 <YUN2vokEM8wgASk8@cmpxchg.org>
 <20210917052440.GJ1756565@dread.disaster.area>
 <YUTC6O0w3j7i8iDm@cmpxchg.org>
 <YUUE5qB9CW9qiAcN@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUUE5qB9CW9qiAcN@moria.home.lan>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 17, 2021 at 05:13:10PM -0400, Kent Overstreet wrote:
> Also: it's become pretty clear to me that we have crappy
> communications between MM developers and filesystem
> developers.

I think one of the challenges has been the lack of an LSF/MM since
2019.  And it may be that having *some* kind of ad hoc technical
discussion given that LSF/MM in 2021 is not happening might be a good
thing.  I'm sure if we asked nicely, we could use the LPC
infrasutrcture to set up something, assuming we can find a mutually
agreeable day or dates.

> Internally both teams have solid communications - I know
> in filesystem land we all talk to each other and are pretty good at
> working colaboratively, and it sounds like the MM team also has good
> internal communications. But we seem to have some problems with
> tackling issues that cross over between FS and MM land, or awkwardly
> sit between them.

That's a bit of a over-generalization; it seems like we've uncovered
that some of the disagreemnts are between different parts of the MM
community over the suitability of folios for anonymous pages.

And it's interesting, because I don't really consider Willy to be one
of "the FS folks" --- and he has been quite diligent to reaching out
to a number of folks in the FS community about our needs, and it's
clear that this has been really, really helpful.  There's no question
that we've had for many years some difficulties in the code paths that
sit between FS and MM, and I'd claim that it's not just because of
communications, but the relative lack of effort that was focused in
that area.  The fact that Willy has spent the last 9 months working on
FS / MM interactions has been really great, and I hope it continues.

That being said, it sounds like there are issues internal to the MM
devs that still need to be ironed out, and at the risk of throwing the
anon-THP folks under the bus, if we can land at least some portion of
the folio commits, it seems like that would be a step in the right
direction.

Cheers,

						- Ted

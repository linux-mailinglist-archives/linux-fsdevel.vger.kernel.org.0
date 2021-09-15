Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2F240CC79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Sep 2021 20:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbhIOSWN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Sep 2021 14:22:13 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43839 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229466AbhIOSWL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:22:11 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 18FIKUUX021510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 14:20:31 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id AD6E115C3427; Wed, 15 Sep 2021 14:20:30 -0400 (EDT)
Date:   Wed, 15 Sep 2021 14:20:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, ksummit@lists.linux.dev
Subject: Re: [MAINTAINER SUMMIT] Folios as a potential Kernel/Maintainers
 Summit topic?
Message-ID: <YUI5bk/94yHPZIqJ@mit.edu>
References: <YUIwgGzBqX6ZiGgk@mit.edu>
 <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7b70227bac9a684320068b362d28fcade6b65b9.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 15, 2021 at 02:03:46PM -0400, James Bottomley wrote:
> On Wed, 2021-09-15 at 13:42 -0400, Theodore Ts'o wrote:
> [...]
> > Would this be helpful?  (Or Linus could pull either the folio or
> > pageset branch, and make this proposal obsolete, which would be
> > great.  :-)
> 
> This is a technical rather than process issue isn't it?  You don't have
> enough technical people at the Maintainer summit to help meaningfully. 
> The ideal location, of course, was LSF/MM which is now not happening.
> 
> However, we did offer the Plumbers BBB infrastructure to willy for a MM
> gathering which could be expanded to include this.

Well, that's why I was suggesting doing this as a LPC BOF, and using
an LPC BOF session on Friday --- I'm very much aware we don't have the
right tehcnical people at the Maintainer Summit.

It's not clear we will have enough MM folks at the LPC, and I agree
LSF/MM would be a better venue --- but as you say, it's not happening.
We could also use the BBB infrastructure after the LPC as well, if we
can't get everyone lined up and available on short notice.  There are
a lot of different possibilities; I'm for anything where all of the
stakeholders agree will work, so we can make forward progress.

Cheers,

						- Ted

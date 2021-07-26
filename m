Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDEE3D5B7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jul 2021 16:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbhGZNjw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 09:39:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46734 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233970AbhGZNjv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:39:51 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 16QEJBnQ002055
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 10:19:12 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8E64C15C37CE; Mon, 26 Jul 2021 10:19:11 -0400 (EDT)
Date:   Mon, 26 Jul 2021 10:19:11 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andres Freund <andres@anarazel.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Larabel <Michael@michaellarabel.com>
Subject: Re: Folios give an 80% performance win
Message-ID: <YP7EX7w035AWASlg@mit.edu>
References: <20210715033704.692967-1-willy@infradead.org>
 <YPxNkRYMuWmuRnA5@casper.infradead.org>
 <1e48f7edcb6d9a67e8b78823660939007e14bae1.camel@HansenPartnership.com>
 <YPxYdhEirWL0XExY@casper.infradead.org>
 <b12f95c9f817f05e91ecd1aec81316afa1da1e42.camel@HansenPartnership.com>
 <17a9d8bf-cd52-4e6c-9b3e-2fbc1e4592d9@www.fastmail.com>
 <YPxjbopzwFYJw9hV@casper.infradead.org>
 <4c634d08-c658-44cf-ac92-92097eeb8532@www.fastmail.com>
 <20210724214413.fqsbjxhhodfzchs6@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210724214413.fqsbjxhhodfzchs6@alap3.anarazel.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 24, 2021 at 02:44:13PM -0700, Andres Freund wrote:
> The phoronix test uses postgres with only one relevant setting adjusted
> (increasing the max connection count). That will end up using a buffer pool of
> 128MB, no huge pages, and importantly is configured to aim for not more than
> 1GB for postgres' journal, which will lead to constant checkpointing. The test
> also only runs for 15 seconds, which likely isn't even enough to "warm up"
> (the creation of the data set here will take longer than the run).
> 
> Given that the dataset phoronix is using is about ~16GB of data (excluding
> WAL), and uses 256 concurrent clients running full tilt, using that limited
> postgres settings doesn't end up measuring something particularly interesting
> in my opinion.

Hi Andreas,

I tend to use the phoronix test suite for my performance runs when
testing ext4 changes simply because it's convenient.  Can you suggest
a better set configuration settings that I should perhaps use that
might give more "real world" numbers that you would find more
significant?

Thanks,

					- Ted

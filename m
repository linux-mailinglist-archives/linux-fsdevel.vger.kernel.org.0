Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 553F6BD3DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 22:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633438AbfIXUzD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 16:55:03 -0400
Received: from gentwo.org ([3.19.106.255]:49438 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbfIXUzD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:55:03 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Sep 2019 16:55:02 EDT
Received: by gentwo.org (Postfix, from userid 1002)
        id 1EDD83E9FF; Tue, 24 Sep 2019 20:55:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 1BF793E9E5;
        Tue, 24 Sep 2019 20:55:02 +0000 (UTC)
Date:   Tue, 24 Sep 2019 20:55:02 +0000 (UTC)
From:   cl@linux.com
X-X-Sender: cl@www.lameter.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     "Darrick J. Wong" <darrick.wong@oracle.com>, dsterba@suse.cz,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-btrfs@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
In-Reply-To: <20190924205133.GK1855@bombadil.infradead.org>
Message-ID: <alpine.DEB.2.21.1909242053010.17661@www.lameter.com>
References: <20190826111627.7505-1-vbabka@suse.cz> <20190826111627.7505-3-vbabka@suse.cz> <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz> <20190923171710.GN2751@twin.jikos.cz> <20190923175146.GT2229799@magnolia> <alpine.DEB.2.21.1909242045250.17661@www.lameter.com>
 <20190924205133.GK1855@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

n Tue, 24 Sep 2019, Matthew Wilcox wrote:

> > There was a public discussion about this issue and from what I can tell
> > the outcome was that the allocator already provides what you want. Which
> > was a mechanism to misalign objects and detect these issues. This
> > mechanism has been in use for over a decade.
>
> You missed the important part, which was *ENABLED BY DEFAULT*.  People
> who are enabling a debugging option to debug their issues, should not
> have to first debug all the other issues that enabling that debugging
> option uncovers!

Why would you have to debug all other issues? You could put your patch on
top of the latest stable or distro kernel for testing.

And I thought the rc phase was there for everyone to work on the bugs of
each other?

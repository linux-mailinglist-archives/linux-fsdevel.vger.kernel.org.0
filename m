Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0A23BD3E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2019 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633458AbfIXU5X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Sep 2019 16:57:23 -0400
Received: from gentwo.org ([3.19.106.255]:49446 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbfIXU5X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Sep 2019 16:57:23 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 513AF3E9FB; Tue, 24 Sep 2019 20:47:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 4FE343E9E5;
        Tue, 24 Sep 2019 20:47:52 +0000 (UTC)
Date:   Tue, 24 Sep 2019 20:47:52 +0000 (UTC)
From:   cl@linux.com
X-X-Sender: cl@www.lameter.com
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
cc:     dsterba@suse.cz, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-btrfs@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
In-Reply-To: <20190923175146.GT2229799@magnolia>
Message-ID: <alpine.DEB.2.21.1909242045250.17661@www.lameter.com>
References: <20190826111627.7505-1-vbabka@suse.cz> <20190826111627.7505-3-vbabka@suse.cz> <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz> <20190923171710.GN2751@twin.jikos.cz> <20190923175146.GT2229799@magnolia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 23 Sep 2019, Darrick J. Wong wrote:

> On Mon, Sep 23, 2019 at 07:17:10PM +0200, David Sterba wrote:
> > On Mon, Sep 23, 2019 at 06:36:32PM +0200, Vlastimil Babka wrote:
> > > So if anyone thinks this is a good idea, please express it (preferably
> > > in a formal way such as Acked-by), otherwise it seems the patch will be
> > > dropped (due to a private NACK, apparently).
>
> Oh, I didn't realize  ^^^^^^^^^^^^ that *some* of us are allowed the
> privilege of gutting a patch via private NAK without any of that open
> development discussion incovenience. <grumble>

There was a public discussion about this issue and from what I can tell
the outcome was that the allocator already provides what you want. Which
was a mechanism to misalign objects and detect these issues. This
mechanism has been in use for over a decade.



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09ABEC1C86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 10:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfI3IGW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 04:06:22 -0400
Received: from verein.lst.de ([213.95.11.211]:35237 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfI3IGW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 04:06:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 107A768AFE; Mon, 30 Sep 2019 10:06:14 +0200 (CEST)
Date:   Mon, 30 Sep 2019 10:06:13 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-btrfs@vger.kernel.org, Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2 2/2] mm, sl[aou]b: guarantee natural alignment for
 kmalloc(power-of-two)
Message-ID: <20190930080613.GA5379@lst.de>
References: <20190826111627.7505-1-vbabka@suse.cz> <20190826111627.7505-3-vbabka@suse.cz> <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df8d1cf4-ff8f-1ee1-12fb-cfec39131b32@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 23, 2019 at 06:36:32PM +0200, Vlastimil Babka wrote:
> So if anyone thinks this is a good idea, please express it (preferably
> in a formal way such as Acked-by), otherwise it seems the patch will be
> dropped (due to a private NACK, apparently).

I think we absolutely need something like this, and I'm sick and tired
of the people just claiming there is no problem.

From the user POV I don't care if aligned allocations need a new
GFP_ALIGNED flag or not, but as far as I can tell the latter will
probably cause more overhead in practice than not having it.

So unless someone comes up with a better counter proposal to provide
aligned kmalloc of some form that doesn't require a giant amount of
boilerplate code in the users:

Acked^2-by: Christoph Hellwig <hch@lst.de>

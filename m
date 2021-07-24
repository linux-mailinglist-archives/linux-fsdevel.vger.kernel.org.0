Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24B43D4938
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 20:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhGXSFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 14:05:19 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:33137 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhGXSFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 14:05:19 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id AAA11320046F;
        Sat, 24 Jul 2021 14:45:49 -0400 (EDT)
Received: from imap35 ([10.202.2.85])
  by compute3.internal (MEProxy); Sat, 24 Jul 2021 14:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=Aief0xddDIXfuN3qRjPsSQpvP84ygmw
        jnmtZ4q09KoQ=; b=sywG3rI/c3Omv3ras4Z42nPsmaGcQVWZfy0wn7ug4cBrz2U
        U8Qw/5HDcNeVAuGV9PQEjwUGyf6ZKhCZRDakEAxWifcU7K35RyCpirdbTLWsCiwj
        dRiPrcCQ+EyBV6pDTKEVRtzrfm/w2yTZpiOrNigkKLlYWJa9GWEZBibXhNTi0oB+
        RCOVXjisgh4okZiGK0IG50/B4lF5+3BcqK/G+bfG34+ho36RHSzkmOvWd0yTVsky
        3eMgI5fXP4vHx2VCgS8nVfRae45yhOuOIOgXQj9N6fdmVbRS1zlTBC0a2z5HqGWM
        RJwY6SvD0LhG6i5QW+2BIqiNA1pWOBmZZlv7Nsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Aief0x
        ddDIXfuN3qRjPsSQpvP84ygmwjnmtZ4q09KoQ=; b=KaieHYmCB0EdEhU2LBpdh6
        CMOfffV16hB9kPFvyoQMf6UfQd+nFxvVTYObTZiZgTuVGNkLjHxNFOjoVZNq8TVI
        9qC46P6BcAZNwJ9kSp3QyeGoaF7HxzaAJqYYAVhd3niXAtxrnN365TLnOT6yV4uj
        jVIrddPqF5yuBmiobmq+GhL8SiG0uuwgkifwUndLC4wQweruGQVv9/py8KBNXVRu
        9WRq5tCLoXLXU4IKW8woLZueGHXYTw3aBdpu4c/UMCHZmaoalH58a43bNv8spyF+
        F2I37Pqz4fsF+9aIy8tBRQ+O57s/RPY8Tx8l5GS7eUX3W4YrZUJA7oiM2EFHJ0nw
        ==
X-ME-Sender: <xms:3F_8YEDAPs3b6W_IxhMCapCiUjGEB7tooAn3Ajqk9EqBLR6_BOeJoQ>
    <xme:3F_8YGh3Z8cVjj2_4Y_jxB6z2Y77y8X-XJkGGElQ6cr1c-OwVq3oz3W5p9uAa4HZw
    1H4WrqGZXCKYjXPpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgedtgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvshcuhfhrvghunhgufdcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecugg
    ftrfgrthhtvghrnhepteegvddvffeghfejteevteevfeegffduudffgedtueejvdejlefg
    veegudekfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:3F_8YHmflRcF6UGAZVJ-cszwVavbSG_-X8rMbvGaj2j96Xbr3FRFyw>
    <xmx:3F_8YKwIa67DANxqdTpOChqHMZfTLF0mjcQz3YmurrfL9Oyp2BxwwQ>
    <xmx:3F_8YJT9MNBZyqAhx_tS9261JJSMrovlDqsHJXV-5DjESb9cVvZxsw>
    <xmx:3V_8YKSrvX2S30bq7hjFx_Mv7Iwk6aiE162W6LNLYn3XEylkItzeWQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2601D15A007C; Sat, 24 Jul 2021 14:45:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-540-g21c5be8f1e-fm-20210722.001-g21c5be8f
Mime-Version: 1.0
Message-Id: <17a9d8bf-cd52-4e6c-9b3e-2fbc1e4592d9@www.fastmail.com>
In-Reply-To: <b12f95c9f817f05e91ecd1aec81316afa1da1e42.camel@HansenPartnership.com>
References: <20210715033704.692967-1-willy@infradead.org>
 <YPxNkRYMuWmuRnA5@casper.infradead.org>
 <1e48f7edcb6d9a67e8b78823660939007e14bae1.camel@HansenPartnership.com>
 <YPxYdhEirWL0XExY@casper.infradead.org>
 <b12f95c9f817f05e91ecd1aec81316afa1da1e42.camel@HansenPartnership.com>
Date:   Sat, 24 Jul 2021 11:45:26 -0700
From:   "Andres Freund" <andres@anarazel.de>
To:     "James Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Matthew Wilcox" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>,
        "Michael Larabel" <Michael@michaellarabel.com>
Subject: Re: Folios give an 80% performance win
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Sat, Jul 24, 2021, at 11:23, James Bottomley wrote:
> On Sat, 2021-07-24 at 19:14 +0100, Matthew Wilcox wrote:
> > On Sat, Jul 24, 2021 at 11:09:02AM -0700, James Bottomley wrote:
> > > On Sat, 2021-07-24 at 18:27 +0100, Matthew Wilcox wrote:
> > > > What blows me away is the 80% performance improvement for
> > > > PostgreSQL. I know they use the page cache extensively, so it's
> > > > plausibly real. I'm a bit surprised that it has such good
> > > > locality, and the size of the win far exceeds my
> > > > expectations.  We should probably dive into it and figure out
> > > > exactly what's going on.
> > > 
> > > Since none of the other tested databases showed more than a 3%
> > > improvement, this looks like an anomalous result specific to
> > > something in postgres ... although the next biggest db: mariadb
> > > wasn't part of the tests so I'm not sure that's
> > > definitive.  Perhaps the next step should be to t
> > > est mariadb?  Since they're fairly similar in domain (both full
> > > SQL) if mariadb shows this type of improvement, you can
> > > safely assume it's something in the way SQL databases handle paging
> > > and if it doesn't, it's likely fixing a postgres inefficiency.
> > 
> > I think the thing that's specific to PostgreSQL is that it's a heavy
> > user of the page cache.  My understanding is that most databases use
> > direct IO and manage their own page cache, while PostgreSQL trusts
> > the kernel to get it right.
> 
> That's testable with mariadb, at least for the innodb engine since the
> flush_method is settable. 
> 
> > Regardless of whether postgres is "doing something wrong" or not,
> > do you not think that an 80% performance win would exert a certain
> > amount of pressure on distros to do the backport?
> 
> Well, I cut the previous question deliberately, but if you're going to
> force me to answer, my experience with storage tells me that one test
> being 10x different from all the others usually indicates a problem
> with the benchmark test itself rather than a baseline improvement, so
> I'd wait for more data.

I have a similar reaction - the large improvements are for a read/write pgbench benchmark at a scale that fits in memory. That's typically purely bound by the speed at which the WAL can be synced to disk. As far as I recall mariadb also uses buffered IO for WAL (but there was recent work in the area).

Is there a reason fdatasync() of 16MB files to have got a lot faster? Or a chance that could be broken?

Some improvement for read-only wouldn't surprise me, particularly if the os/pg weren't configured for explicit huge pages. Pgbench has a uniform distribution so its *very* tlb miss heavy with 4k pages.

Regards,
Andres

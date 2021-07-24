Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873CF3D4974
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 21:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGXSca (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 14:32:30 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:34645 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229476AbhGXSc3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 14:32:29 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B6AC432007D7;
        Sat, 24 Jul 2021 15:13:00 -0400 (EDT)
Received: from imap35 ([10.202.2.85])
  by compute3.internal (MEProxy); Sat, 24 Jul 2021 15:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=dXCbOqGxR8Vk0pjKq6a806jXWA/9phv
        bJwLeUoq51KU=; b=reX+fT1wQPMi3/naLPEr73S1dEeec5Q5Gp9mM6EaMl0oEYI
        YG6Lc4V3g94xLJQQ9c2i3JxjS2LeycCpGmVROS64RIr+YuCD+uaNsjmJcHrelKKb
        nywedFxnXuqzdFJr8XJhnszWbix3V0yuwQo9CBgxhjuoDJS4bT+cGOEldOB/pmNh
        drtFGF2peoVeZadpc9qIpqIAQlOTG/VRi3xvvgLiiLjlrVvRjX6lcvtdaIDdfXll
        hfmLPYrprUF6QIJ/JWFCRty5yyvMwVWVb5O0kNmIE6KsJaozRBFzduCZLDNjdFvL
        aLGfBfgg9YxI+JWvpeHxS9rOPufDDWjsj4vVeqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=dXCbOq
        GxR8Vk0pjKq6a806jXWA/9phvbJwLeUoq51KU=; b=RH85y+QAkCaiVl/RGgPPfc
        qNBBmEhpVrrzn4pFqOybH4CpMdPDY2alln2Vf3pFeg8k+VIKDf/7rzqiFKeRQJ2o
        HFmGYktc+hTbMnRxyU2QOVH0zRU0hyOmu6DKqYV7wUrDPz797T49AIEZhf1eBjXF
        UnWUV32Nd9SC83MIOjTIjkDQoElYkN+6m+qHGKAI6SFE8zUzhi4vWGJPbinRfcER
        wHuCch47FgsDDPS6uFoqyfl5PbOXG+KolTQpUabN/Ij2NVaZ7x08gExbkwOgV9ol
        tpWV1GW01aDDrSuKAbLZvNvpkDM/zXXdm6fo3JPP3/FVqVRnxlUGkLH2j1loPgJw
        ==
X-ME-Sender: <xms:O2b8YPRWR9vGHGOdV2jtWo0qt6f1GQPWzzcitafZT4hVRRLR0Aa4lQ>
    <xme:O2b8YAxaZX5RNDLvemPotjfVsQ3icVW8rMqY_mwvowQOYMkP2cWP1rzqIuuNAKQ98
    Fi9002quhfcZ5ewbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgedtgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvshcuhfhrvghunhgufdcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecugg
    ftrfgrthhtvghrnhepteegvddvffeghfejteevteevfeegffduudffgedtueejvdejlefg
    veegudekfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:O2b8YE13fkLSRTrxxqo-QMva6yeIkZTmAipGX2FlOp4Y5yZ9MjNorQ>
    <xmx:O2b8YPBl5_T1Ub9zSAuSlWvQXnjqDYi4oYz49Owk3vCtVxfVrRZxwA>
    <xmx:O2b8YIjLn4GAfS3WntS4Xd8JpGDzLqa-veLVPkIFEiARKEz2M5Q6Lg>
    <xmx:PGb8YEh_SSJs3X01a3UVPc37VTRTkh1P_8jIDp461lZ19sjRyUbetQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id DED8515A007C; Sat, 24 Jul 2021 15:12:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-540-g21c5be8f1e-fm-20210722.001-g21c5be8f
Mime-Version: 1.0
Message-Id: <4c634d08-c658-44cf-ac92-92097eeb8532@www.fastmail.com>
In-Reply-To: <YPxjbopzwFYJw9hV@casper.infradead.org>
References: <20210715033704.692967-1-willy@infradead.org>
 <YPxNkRYMuWmuRnA5@casper.infradead.org>
 <1e48f7edcb6d9a67e8b78823660939007e14bae1.camel@HansenPartnership.com>
 <YPxYdhEirWL0XExY@casper.infradead.org>
 <b12f95c9f817f05e91ecd1aec81316afa1da1e42.camel@HansenPartnership.com>
 <17a9d8bf-cd52-4e6c-9b3e-2fbc1e4592d9@www.fastmail.com>
 <YPxjbopzwFYJw9hV@casper.infradead.org>
Date:   Sat, 24 Jul 2021 12:12:36 -0700
From:   "Andres Freund" <andres@anarazel.de>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     "James Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
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

On Sat, Jul 24, 2021, at 12:01, Matthew Wilcox wrote:
> On Sat, Jul 24, 2021 at 11:45:26AM -0700, Andres Freund wrote:
> > On Sat, Jul 24, 2021, at 11:23, James Bottomley wrote:
> > > Well, I cut the previous question deliberately, but if you're going to
> > > force me to answer, my experience with storage tells me that one test
> > > being 10x different from all the others usually indicates a problem
> > > with the benchmark test itself rather than a baseline improvement, so
> > > I'd wait for more data.
> > 
> > I have a similar reaction - the large improvements are for a read/write pgbench benchmark at a scale that fits in memory. That's typically purely bound by the speed at which the WAL can be synced to disk. As far as I recall mariadb also uses buffered IO for WAL (but there was recent work in the area).
> > 
> > Is there a reason fdatasync() of 16MB files to have got a lot faster? Or a chance that could be broken?
> > 
> > Some improvement for read-only wouldn't surprise me, particularly if the os/pg weren't configured for explicit huge pages. Pgbench has a uniform distribution so its *very* tlb miss heavy with 4k pages.
> 
> It's going to depend substantially on the access pattern.  If the 16MB
> file (oof, that's tiny!) was read in in large chunks or even in small
> chunks, but consecutively, the folio changes will allocate larger pages
> (16k, 64k, 256k, ...).  Theoretically it might get up to 2MB pages and
> start using PMDs, but I've never seen that in my testing.

The 16MB files are just for the WAL/journal, and are write only in a benchmark like this. With pgbench it'll be written in small consecutive chunks (a few pages at a time, for each group commit). Each page is only written once, until after a checkpoint the entire file is "recycled" (renamed into the future of the WAL stream) and reused from start.

The data files are 1GB.


> fdatasync() could indeed have got much faster.  If we're writing back a
> 256kB page as a unit, we're handling 64 times less metadata than writing
> back 64x4kB pages.  We'll track 64x less dirty bits.  We'll find only
> 64 dirty pages per 16MB instead of 4096 dirty pages.

The dirty writes will be 8-32k or so in this workload - the constant commits require the WAL to constantly be flushed.


> It's always possible I just broke something.  The xfstests aren't
> exhaustive, and no regressions doesn't mean no problems.
> 
> Can you guide Michael towards parameters for pgbench that might give
> an indication of performance on a more realistic workload that doesn't
> entirely fit in memory?

Fitting in memory isn't bad - that's a large post of real workloads. It just makes it hard to believe the performance improvement, given that we expect to be bound by disk sync speed...

Michael, where do I find more details about the codification used during the run?

Regards,

Andres

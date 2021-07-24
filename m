Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728003D4A26
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jul 2021 23:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhGXVDr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 17:03:47 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:37751 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhGXVDq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 17:03:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2EBEF320024A;
        Sat, 24 Jul 2021 17:44:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 24 Jul 2021 17:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=3V7FevWb1p5n5Vec3/jBp3sIx0K
        Qg89281MvPR3XSBw=; b=MhmoEUW9N5gQrmySruuN/8u/+OjCR8a1gNKZ/JLHgTD
        VVIXWTiXhsHcTYjCJ1nJCsTjeVcmXWxau0BiD498s/6ytid/QtblgtDKrR5HJz6e
        BLwbh/FXOMWObfcQNLgOao1QRGh5WIHEayLnP4NrwWVG5xlWopZAx5Mq7PWvysH5
        AkqQ3nNN0/GI6fszm2OiFLLj3sOIQt0FkZ0tdCJpgEvuxlgxXd2pfR77+qrYCD25
        cNMNZJSF25q4UMqFG/5ZiwxM87F9J6t95ATeoSOcYcph2tkxTUTV9ip1JF63XD09
        ZPXGtlh5ib7eZxUUGqoUmzUqBxBcjQLYnYsWAGQpLMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3V7Fev
        Wb1p5n5Vec3/jBp3sIx0KQg89281MvPR3XSBw=; b=ChNj0gcB73QLDqaNGZC61C
        QJ3uy13y/8L5kegrtWxbbVjo6fte5IN4bDiB4KAP4cQoWBegXRRDUVksBs6oKOZM
        YLaEftfiIZ2OYfCrmQRA227N8yR/pqbzsFZZlnB7lCYTxxXB6bBlS3MHmKQ0gc8y
        o9NeBdlIY278Xm4GCiDsJhLBDudGoB7Z84C/Kdl7CWQAOEshUuZnQyzZmuYhToDT
        FAYg0NePFPh32+WJycFQ8QdHmeFfgwBoBb22QfcENgoUiFPH69cvVo8wyqKpVLpN
        CrEN2PwUELB8364UFcbc2dMp0s8Y+PzK3o0u9xxGxAi3hVoJsK/8z4zRr4FjUMwQ
        ==
X-ME-Sender: <xms:r4n8YFe5siCEm4SWjXouxUT52wGaSzYPr6Rye2w45Vkc7pcPr62nKg>
    <xme:r4n8YDMwxxQUhZBFn0Q90Kphsd4zj1tGHJQVPHi9srjZ5M91Uf7CuA6IB-Kbv_0my
    npgc8CSMiAYZqHM8Q>
X-ME-Received: <xmr:r4n8YOivgW5apjjM6W0lzEDQtMNvBB6e98tee9cBZK1wfLLppsEEgWf259okcPg2aBFpUWl_H8VDKBuxp1pq2weGAfjCxIR2Hpvn1frhlIzKO-CFY0geCrBvlAWl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgedugddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrfgrth
    htvghrnhepudeuvefhudevtefhgeehveetjedutdekfeejudehkedttdeuueeikeekteev
    tedunecuffhomhgrihhnpehgihhthhhusgdrtghomhdpihhnshhtrghllhdrshhhnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvghs
    segrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:r4n8YO_BBTBYiE1XI-abMGwlC5SwauLzCcSoSbDBex4VriG3sb7FYg>
    <xmx:r4n8YBsRSOVJ-jNmUXa1LYJ3VCgrYSu6iQI_psvFVjUvmCfjH0Woxg>
    <xmx:r4n8YNEm2A4fyIwbeipmDIdqPVeYS_-Bo5Y4y4FZMayYKjjf-MmWJg>
    <xmx:sIn8YHBiHP9ZyaftQ2fHqj8Lx60eDGKn9-ZqhQeNDlWKmiZJcBMLcQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Jul 2021 17:44:15 -0400 (EDT)
Date:   Sat, 24 Jul 2021 14:44:13 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Michael Larabel <Michael@michaellarabel.com>
Subject: Re: Folios give an 80% performance win
Message-ID: <20210724214413.fqsbjxhhodfzchs6@alap3.anarazel.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <YPxNkRYMuWmuRnA5@casper.infradead.org>
 <1e48f7edcb6d9a67e8b78823660939007e14bae1.camel@HansenPartnership.com>
 <YPxYdhEirWL0XExY@casper.infradead.org>
 <b12f95c9f817f05e91ecd1aec81316afa1da1e42.camel@HansenPartnership.com>
 <17a9d8bf-cd52-4e6c-9b3e-2fbc1e4592d9@www.fastmail.com>
 <YPxjbopzwFYJw9hV@casper.infradead.org>
 <4c634d08-c658-44cf-ac92-92097eeb8532@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c634d08-c658-44cf-ac92-92097eeb8532@www.fastmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2021-07-24 12:12:36 -0700, Andres Freund wrote:
> On Sat, Jul 24, 2021, at 12:01, Matthew Wilcox wrote:
> > On Sat, Jul 24, 2021 at 11:45:26AM -0700, Andres Freund wrote:
> > It's always possible I just broke something.  The xfstests aren't
> > exhaustive, and no regressions doesn't mean no problems.
> > 
> > Can you guide Michael towards parameters for pgbench that might give
> > an indication of performance on a more realistic workload that doesn't
> > entirely fit in memory?
> 
> Fitting in memory isn't bad - that's a large post of real workloads. It just makes it hard to believe the performance improvement, given that we expect to be bound by disk sync speed...

I just tried to compare folio-14 vs its baseline, testing commit 8096acd7442e
against 480552d0322d. In a VM however (but at least with its memory being
backed by huge pages and storage being passed through).  I got about 7%
improvement with just some baseline tuning of postgres applied. I think a 1-2%
of that is potentially runtime variance (I saw slightly different timings
leading around checkpointing that lead to a bit "unfair" advantage to the
folio run).

That's a *nice* win!

WRT the ~70% improvement:

> Michael, where do I find more details about the codification used during the
> run?

After some digging I found https://github.com/phoronix-test-suite/phoronix-test-suite/blob/94562dd4a808637be526b639d220c7cd937e2aa1/ob-cache/test-profiles/pts/pgbench-1.10.1/install.sh
For one the test says its done on ext4, while I used xfs. But I think the
bigger thing is the following:

The phoronix test uses postgres with only one relevant setting adjusted
(increasing the max connection count). That will end up using a buffer pool of
128MB, no huge pages, and importantly is configured to aim for not more than
1GB for postgres' journal, which will lead to constant checkpointing. The test
also only runs for 15 seconds, which likely isn't even enough to "warm up"
(the creation of the data set here will take longer than the run).

Given that the dataset phoronix is using is about ~16GB of data (excluding
WAL), and uses 256 concurrent clients running full tilt, using that limited
postgres settings doesn't end up measuring something particularly interesting
in my opinion.

Without changing the filesystem, using a configuration more similar to
phoronix', I do get a bigger win. But the run-to-run variance is so high
(largely due to the short test duration) that I don't trust those results
much.

It does look like there's a less slowdown due to checkpoints (i.e. fsyncing
all data files postgres modified since the last checkpoints) on the folio
branch, which does make some sense to me and would be a welcome improvement.

Greetings,

Andres Freund

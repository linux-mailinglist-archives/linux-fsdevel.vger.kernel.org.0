Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4213D6B63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 03:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhG0AVU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jul 2021 20:21:20 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:35339 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229524AbhG0AVT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jul 2021 20:21:19 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4564B580441;
        Mon, 26 Jul 2021 21:01:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 26 Jul 2021 21:01:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=4GoP2lpEbphZOrM/qJqbnIpCwuz
        xJrI8rOm0CYBK67E=; b=K7+fIREOIDAFh6ouMeGqj4o4UBPlX88yq9vU1atI112
        kvpsGuxqSzMOjzJxihs+SdKGc1tyzc9adbOUkbmK88ZudgdfwNHpEkfr59ibhOKk
        /nFDpGpplnQlTvC6r6U/3iCdiYYdyt5mOLXQ3X+WAzFzJ5t8yJxGC03uikSVl/xn
        lUG1vWA99D6vj0AFxIG2QEbep0cBljPVuAH1moI60xNJwqefd4bR3rS6F06qf5yc
        0WFbFNX3AT0NWyorr5cGHR2yQzn1F0xMYFS3T4x/H7IhzdR+WwgV5AQAiEWnEVaG
        KfOD8cdoPtmPs55C35Qrc7Yu7gQrEVdT3IJtF5mbkmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=4GoP2l
        pEbphZOrM/qJqbnIpCwuzxJrI8rOm0CYBK67E=; b=qJwNQmDsYMZetuodgigFCU
        DvrvTuxQ8xE3gzsT+C7iUxomQ4Qoh9SiXYY7RPEyWopwpdK2BL51aZeO4DCvy6Qd
        0yffH5Vu4WlxgxJeJciaDds/mdyozdf/EFvVXoDtdjTLGpFwU5P0hJJWoZ3jxUa+
        b90YhIz3irTxBBU3Uf6YO/lIbIUP3jOssjEUrgHIti/Lt/VCLyUj8+zs+TNyFiME
        XQYX51ZDyPjk7Gt29xpSulhW99pZw4WJvX9rQywAbjr11JS6JwD8Mz3+od29skK7
        +fpcJFmqUFTOflQuJOSzxRXHU02itQObCxSP1/Zht7AVHQgeAsSfpLSKzruSY/HA
        ==
X-ME-Sender: <xms:-Vr_YN7qWdjm7YnBCSYzIeDLYmOwgFwi-W8nVswXVbgeS1KPnGjJwg>
    <xme:-Vr_YK6Q6je5ZOTBjOxLy8iVictcUhv62jCRAKF4Dyd5fpP4InNXezZ32zZOJiwhW
    TiyIItqtHJBqPJC1w>
X-ME-Received: <xmr:-Vr_YEdGpMion0z5UjQ4-QKhezMQIY1C7M0dpvSBbV-ttBpTgqwzEFKil28-Kf4SjQslAdjqZc9LfkUyXrjObOzexPgMsLALtRx7mQQmQOChDMEOvpE95_p4tfLN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrgeeigdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughrvghs
    ucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrfgrth
    htvghrnhepudekhfekleeugeevteehleffffejgeelueduleeffeeutdelffeujeffhfeu
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:-Vr_YGIibaU9T5GLpMI6wyGFBKBj2CJ0OBGm7X2aBrxqjIE_CEWiJw>
    <xmx:-Vr_YBJ092ZR3hqHatCsys030PLu61FEScoEhgWeS5v4yLiMrpwFIA>
    <xmx:-Vr_YPwzI0cknTDfE_VXYGPYh1o9oAfG5-_ppa3d8G1AnAscFyTAZg>
    <xmx:-1r_YKWfd0yw1ulinw349uq0XrckpcH1wSk--ydWa5ndfXoZdhsL5w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jul 2021 21:01:45 -0400 (EDT)
Date:   Mon, 26 Jul 2021 18:01:44 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Theodore Ts'o <tytso@mit.edu>
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
Message-ID: <20210727010144.na67murecket5h4b@alap3.anarazel.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <YPxNkRYMuWmuRnA5@casper.infradead.org>
 <1e48f7edcb6d9a67e8b78823660939007e14bae1.camel@HansenPartnership.com>
 <YPxYdhEirWL0XExY@casper.infradead.org>
 <b12f95c9f817f05e91ecd1aec81316afa1da1e42.camel@HansenPartnership.com>
 <17a9d8bf-cd52-4e6c-9b3e-2fbc1e4592d9@www.fastmail.com>
 <YPxjbopzwFYJw9hV@casper.infradead.org>
 <4c634d08-c658-44cf-ac92-92097eeb8532@www.fastmail.com>
 <20210724214413.fqsbjxhhodfzchs6@alap3.anarazel.de>
 <YP7EX7w035AWASlg@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP7EX7w035AWASlg@mit.edu>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2021-07-26 10:19:11 -0400, Theodore Ts'o wrote:
> On Sat, Jul 24, 2021 at 02:44:13PM -0700, Andres Freund wrote:
> > The phoronix test uses postgres with only one relevant setting adjusted
> > (increasing the max connection count). That will end up using a buffer pool of
> > 128MB, no huge pages, and importantly is configured to aim for not more than
> > 1GB for postgres' journal, which will lead to constant checkpointing. The test
> > also only runs for 15 seconds, which likely isn't even enough to "warm up"
> > (the creation of the data set here will take longer than the run).
> > 
> > Given that the dataset phoronix is using is about ~16GB of data (excluding
> > WAL), and uses 256 concurrent clients running full tilt, using that limited
> > postgres settings doesn't end up measuring something particularly interesting
> > in my opinion.

> I tend to use the phoronix test suite for my performance runs when
> testing ext4 changes simply because it's convenient.  Can you suggest
> a better set configuration settings that I should perhaps use that
> might give more "real world" numbers that you would find more
> significant?

It depends a bit on what you want to test, obviously...

At the very least you should 'max_wal_size = 32GB' or such (it'll only
use that much if enough WAL is generated within checkpoint timeout,
which defaults to 5min).

And unfortunately you're not going to get meaningful performance results
for a read/write test within 10s, you need to run at least ~11min (so
two checkpoints happen).

With the default shared_buffers setting of 128MB you are going to
simulate a much-larger-than-postgres's-memory workload, albeit one where
the page cache *is* big enough on most current machines, unless you
limit the size of the page cache considerably. Doing so can be useful to
approximate a workload that would take much longer to initialize due to
the size.

I suggest *not* disabling autovacuum as currently done for performance
testing - it's not something many real-world setups can afford to do, so
benchmarking FS performance with it disabled doesn't seem like a good
idea.

FWIW, depending on what kind of thing you want to test, it'd not be hard
to come up with a test that less time to initialize. E.g. an insert-only
workload without an initial dataset or such.

As long as you *do* initialize 16GB of data, I think it'd make sense to
measure the time that takes. There's definitely been filesystem level
performance changes of that, and it's often going to be more IO intensive.

Greetings,

Andres Freund

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9EC17ED36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 01:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCJAS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 20:18:27 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39277 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726937AbgCJAS0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:18:26 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 35D6B2B17;
        Mon,  9 Mar 2020 20:18:25 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 09 Mar 2020 20:18:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=y2GQYGvf1VdVHeGmvE5sDqwzusj
        gACWrEd8rXJZj1/8=; b=hCLjptm8wkq6KP7tCx7x9OtPNkX0eMvm5L8o2L97Wdo
        y7vZrsFkN2f4S8Xv4R8dqRogUS/9W/QJ66jTev5Aoip48Jo0P4gB73pf4vehqIPK
        JjNTp8MWQ1ArZcM945bWyUlu9TnTT7vRowJNgZw7oaWVz+6Ro+kUV+BvaTb/Axir
        Rd6auBHkdyebUJ4UZ8DYveKmdHVSu6fdUbPx5wy2rYk0qCyFwSg38WMAwVPUg5Ku
        GA4lOOXpIKxaAK22UekVw8FFJzKTa6OzjJ9Oxk/T3qcyaA35MUgwyxYjd1ZtgS6K
        i5h6lcNjdPFhMmGhYyeM8m3cEHGO/5NZU3TbC7SzNdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=y2GQYG
        vf1VdVHeGmvE5sDqwzusjgACWrEd8rXJZj1/8=; b=hR1CHx7sGSLI0tfsHsnts5
        3Hmffp3/lf5X5mVKSJZiHGvay1HEsa/lAhINcfhikONaFnXvPMdWcLXqeI65qu98
        5IGZzvzrZLQ9rEQZTkcsAFr2dIvY4csYaQValDPkpQpiqkp6DIy7g6XepjoptqAM
        TAM4ZHUlxf1IYp29XvsF7D7DaBJDJkw0kAtUKVLfY/O4E08dDeL6j/ykjMW5rpWe
        5XcWL8In/VDf8l+3tnGbBDB8uwSj9B1NPqbn3/lNK7AcsnmcVtwEgK191sA2Nh4G
        LIeRxCXeQnoCNpMDjJXnTOClDNOcp3XeJNhqoSjyqGciCTV5p+IuLeAxePrsi5bg
        ==
X-ME-Sender: <xms:z9xmXj9MdiMQxb3sWpQ0zpHMFqyrXHaQEw8NK1xMORNkzGXW3ZRTzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudduledgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeetnhgurhgv
    shcuhfhrvghunhguuceorghnughrvghssegrnhgrrhgriigvlhdruggvqeenucfkphepie
    ejrdduiedtrddvudejrddvhedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheprghnughrvghssegrnhgrrhgriigvlhdruggv
X-ME-Proxy: <xmx:z9xmXg-FyPlg1L30wL5k3gQsDNd-t7jy7bKj8Kt6liqh63q9EbY7mw>
    <xmx:z9xmXuF-0sjXCm1U5Zku5J7ltPA7_BmZzh1YdA3oUYFbwW4JBHao7g>
    <xmx:z9xmXicuLoixXJ2XZ_721dkzztz4dN0Kp240Oq1ekOXjgrpEZlsUkw>
    <xmx:0dxmXho2KzunPEg77nJRP3TUrcGMSb00ReWWFfVGCGI3mSgfDxoD0Q>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 007C43061856;
        Mon,  9 Mar 2020 20:18:23 -0400 (EDT)
Date:   Mon, 9 Mar 2020 17:18:21 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Jeff Layton <jlayton@redhat.com>
Cc:     David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, Theodore Ts'o <tytso@mit.edu>,
        Stefan Metzmacher <metze@samba.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org, linux-api@vger.kernel.org,
        raven@themaw.net, mszeredi@redhat.com, christian@brauner.io,
        jannh@google.com, darrick.wong@oracle.com, kzak@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/14] VFS: Filesystem information [ver #18]
Message-ID: <20200310001821.vb7qwfhnq67rsknn@alap3.anarazel.de>
References: <158376244589.344135.12925590041630631412.stgit@warthog.procyon.org.uk>
 <2d31e2658e5f6651dc7d9908c4c12b6ba461fc88.camel@redhat.com>
 <20200309192240.nqf5bxylptw7mdm3@alap3.anarazel.de>
 <32c384ac3adf0cf924d3071a13af7edffe53cc2b.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32c384ac3adf0cf924d3071a13af7edffe53cc2b.camel@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2020-03-09 18:49:31 -0400, Jeff Layton wrote:
> On Mon, 2020-03-09 at 12:22 -0700, Andres Freund wrote:
> > On 2020-03-09 13:50:59 -0400, Jeff Layton wrote:
> > > I sent a patch a few weeks ago to make syncfs() return errors when there
> > > have been writeback errors on the superblock. It's not merged yet, but
> > > once we have something like that in place, we could expose info from the
> > > errseq_t to userland using this interface.
> >
> > I'm still a bit worried about the details of errseq_t being exposed to
> > userland. Partially because it seems to restrict further evolution of
> > errseq_t, and partially because it will likely up with userland trying
> > to understand it (it's e.g. just too attractive to report a count of
> > errors etc).
>
> Trying to interpret the counter field won't really tell you anything.
> The counter is not incremented unless someone has queried the value
> since it was last checked. A single increment could represent a single
> writeback error or 10000 identical ones.

Oh, right.  A zero errseq would still indicate something, but that's
probably fine.


> > Is there a reason to not instead report a 64bit counter instead of the
> > cookie? In contrast to the struct file case we'd only have the space
> > overhead once per superblock, rather than once per #files * #fd. And it
> > seems that the maintenance of that counter could be done without
> > widespread changes, e.g. instead/in addition to your change:

> What problem would moving to a 64-bit counter solve? I get the concern
> about people trying to get a counter out of the cookie field, but giving
> people an explicit 64-bit counter seems even more open to
> misinterpretation.

Well, you could get an actual error count out of it? I was thinking that
that value would get incremented every time mapping_set_error() is
called, which should make it a meaningful count?

Greetings,

Andres Freund

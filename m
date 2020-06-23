Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0D820514E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 13:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732458AbgFWLvX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 07:51:23 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:40869 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732389AbgFWLvX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:51:23 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id ACCC15E3;
        Tue, 23 Jun 2020 07:51:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 23 Jun 2020 07:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        l0J4A/dshGlbVBcJCsP/9iEYM7UuYctdoHwOc1yIvjc=; b=xbNuK+VZ+98ruYrL
        Y/4Tzh8HwXwiq2ACU+SlrAKM7Cv1sZRoCDfKp/D9EmhBbgRySgoUg1QwF3TsuFfb
        hpW7nyzj+cJRs+SVtLDXSL6e2x9VRB6CD3Op1PNmNf+NAzVULKWNXFIO2Qnk3Lk+
        ytWNRWrnork6Oz5N1asTBERYONDwhxw0IT1aOWIFeYfrhxQf00buOziIQTVQvwqY
        SyETfVgYDU60xq+58TU9iVkYLynLfiObUQyHSPaOPcaWoo2ouU9OXDJ0of0usjCU
        zv4CC2NAj7IyFbz2kUUYpdBfn5uts0Kw7M6KOsvpOmbN5uEDMzx632/XQvJIhJIY
        SwP3EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=l0J4A/dshGlbVBcJCsP/9iEYM7UuYctdoHwOc1yIv
        jc=; b=c+L61//xDmsBm8OtRyPAOOqoJKl39cxFd8XzW/73y1+BCO5HuPiyu9vS6
        es/h51yiY4VtwJ4tE3A8VUBZhj2hNTfiDdon3tdrDdxeTy8CxByBgWH4rKNBHxcR
        8U79/SI9HsxoMjgD0sy64kZjP1tU55jl/YkKT/APgwBFu7sreggCYaDFBg4AuDXe
        uQZQS282hX9yEbLJH8TPAqy40M2sMi1vtYgK/D2OQR9F15GBtm7oxEUt2Q7gZ2lg
        rObI8McpX1YlrZ4e6yxJ303kVXjpYDrmIHjMDAB7w4QJ0vLTgTMcj6/MhlFL/Isy
        RnbwOpx2JZE0pSNVuuTDSj0r/9zRQ==
X-ME-Sender: <xms:uOzxXmeSHA-XtAhMJbagF_24G-cQKv2JyMwOWNgKLCdkYkvw24ZNvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudekhedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepuddukedrvddtkedrheegrdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:uOzxXgP8nKvrrHlTfpW8epDS72L-W_Yx_uJntn_KPzrdSi4WQl0SZg>
    <xmx:uOzxXnhXZgC0MIT7M4Bnqum6Fk9S8_0qusDifyC2057nOrnFxrZOYQ>
    <xmx:uOzxXj96rBVmPWkDgV-U3jBh7vvWL8RksOBUclAAr07P4-E3Gq-_4w>
    <xmx:uezxXkUHtshHtK9m6E7mxPm6KmlCNp7MSIqx4oo_F0L8byiMO16b7g>
Received: from mickey.themaw.net (unknown [118.208.54.50])
        by mail.messagingengine.com (Postfix) with ESMTPA id CC34D328005E;
        Tue, 23 Jun 2020 07:51:16 -0400 (EDT)
Message-ID: <befb09a5f62852a828ac959acbad5d5e50c967de.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 23 Jun 2020 19:51:12 +0800
In-Reply-To: <74fb24d0-2b61-27f8-c44e-abd159e57469@linux.vnet.ibm.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
         <20200619153833.GA5749@mtj.thefacebook.com>
         <16d9d5aa-a996-d41d-cbff-9a5937863893@linux.vnet.ibm.com>
         <20200619222356.GA13061@mtj.duckdns.org>
         <429696e9fa0957279a7065f7d8503cb965842f58.camel@themaw.net>
         <20200622174845.GB13061@mtj.duckdns.org>
         <20200622180306.GA1917323@kroah.com>
         <2ead27912e2a852bffb1477e8720bdadb591628d.camel@themaw.net>
         <20200623060236.GA3818201@kroah.com>
         <74fb24d0-2b61-27f8-c44e-abd159e57469@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-06-23 at 02:33 -0700, Rick Lindsley wrote:
> On 6/22/20 11:02 PM, Greg Kroah-Hartman wrote:
> 
> > First off, this is not my platform, and not my problem, so it's
> > funny
> > you ask me :)
> 
> Weeeelll, not your platform perhaps but MAINTAINERS does list you
> first and Tejun second as maintainers for kernfs.  So in that sense,
> any patches would need to go thru you.  So, your opinions do matter.
> 
>   
> > Anyway, as I have said before, my first guesses would be:
> > 	- increase the granularity size of the "memory chunks",
> > reducing
> > 	  the number of devices you create.
> 
> This would mean finding every utility that relies on this
> behavior.  That may be possible, although not easy, for distro or
> platform software, but it's hard to guess what user-related utilities
> may have been created by other consumers of those distros or that
> platform.  In any case, removing an interface without warning is a
> hanging offense in many Linux circles.
> 
> > 	- delay creating the devices until way after booting, or do it
> > 	  on a totally different path/thread/workqueue/whatever to
> > 	  prevent delay at booting
> 
> This has been considered, but it again requires a full list of
> utilities relying on this interface and determining which of them may
> want to run before the devices are "loaded" at boot time.  It may be
> few, or even zero, but it would be a much more disruptive change in
> the boot process than what we are suggesting.
> 
> > And then there's always:
> > 	- don't create them at all, only only do so if userspace asks
> > 	  you to.
> 
> If they are done in parallel on demand, you'll see the same problem
> (load average of 1000+, contention in the same spot.)  You obviously
> won't hold up the boot, of course, but your utility and anything else
> running on the machine will take an unexpected pause ... for
> somewhere between 30 and 90 minutes.  Seems equally unfriendly.
> 
> A variant of this, which does have a positive effect, is to observe
> that coldplug during initramfs does seem to load up the memory device
> tree without incident.  We do a second coldplug after we switch roots
> and this is the one that runs into timer issues.  I have asked "those
> that should know" why there is a second coldplug.  I can guess but
> would prefer to know to avoid that screaming option.  If that second
> coldplug is unnecessary for the kernfs memory interfaces to work
> correctly, then that is an alternate, and perhaps even better
> solution.  (It wouldn't change the fact that kernfs was not built for
> speed and this problem remains below the surface to trip up another.)

We might still need the patches here for that on-demand mechanism
to be feasible.

For example, for an ls of the node directory it should be doable to
enumerate the nodes in readdir without creating dentries but there's
the inevitable stat() of each path that follows that would probably
lead to similar contention.

And changing the division of the entries into sub-directories would
inevitably break anything that does actually need to access them.

Ian


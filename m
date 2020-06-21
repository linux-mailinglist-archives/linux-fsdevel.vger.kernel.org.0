Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69AC3202825
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jun 2020 05:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729199AbgFUDWB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Jun 2020 23:22:01 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51719 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729165AbgFUDWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Jun 2020 23:22:00 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 1338D5C00A0;
        Sat, 20 Jun 2020 23:22:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 20 Jun 2020 23:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        xInmSuNUJ3WOINri4b+fa1Blskl9HMbqd5NJmzXhYxU=; b=UUOZR3/33xScFzUr
        hn3OJDReFqcHouyu70WVsX/I53nHKmltv1Qi6XbA2N16MBOiIn5PiBuhgwV3nSyT
        KhFpsjvLwe6X6/qDvblSzp8Sv3+CClzu2W3OASM1W5HHXeZu3F+31r4uyuoWiCWx
        4n04qtNOB3B5UE2oOPYX59mOxOGKjxW+3HqIG+CNCajutvNcnOhfIWE2KG4iZyCx
        I3ZluMYW/2htD4hn282c0vOFetRrXL7lbN8a3/13LQ8RkI46BTDhJ4YkIT4DBSJm
        IXF9flpLnQcIaBISsN2dU5x5bSnOh39/Lv646KKyapvgkPQzCDDw2346maUv5vCG
        4XMAKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=xInmSuNUJ3WOINri4b+fa1Blskl9HMbqd5NJmzXhY
        xU=; b=lC1uZ7VE5ipx8b2qBaHAY4+HuKqWffjRLpbNfzJ4u0KY5tO7MfsciLKJZ
        7FmhJRp/zXg6KX4k5TtiduHCV7h3z2mBEi9UNPRv2a5V7+HzZ/Gzs3yf+f4Gj3lP
        RABDZm7Xq3GQlRRIGKC7mUAN9/1ulaYGEN72GvNT+LQ00nY5c/GD+3YXQVaTIeTI
        +gnERELlmbOEMlba7QLVyHeNJgVXjytNt0H9BnrWs3rxLrdTsuZ6yMX0pE7xTPNF
        3QXxAbf9YwHExy52ETgGy2ehk1/OQ9+9TarLN7kZObrRNKpoh93rL/2NwF/RiCsf
        5HVLJJNVNXAuSH7mOTOSrA3IKVD9A==
X-ME-Sender: <xms:VtLuXpeZ82BWtT7xnQOHq1PBZ8QD5tzQDxqLm8yEiiv57eK1mNloQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejledgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    effeettedvgeduvdevfeevfeettdffudduheeuiefhueevgfevheffledugefgjeenucfk
    phepheekrdejrdduleegrdekjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:VtLuXnMr4PS7NTMZRZkzKl1f7Q9fZBWAKIl2dsXN6A5x1M7mdBkZew>
    <xmx:VtLuXigq4GlOqA5aRZuZihdYNrpY5_OO9-Gfg-ryhEqSA5B_r86y5Q>
    <xmx:VtLuXi9PFUzDW5zb1D-typam_lb5yoflWBxipgLM146_1EuYLaJBsQ>
    <xmx:WNLuXjXJSXSEwa_K9Lk4WqmGKZbhCefBrB14fD005oqbT4vqomSC6w>
Received: from mickey.themaw.net (58-7-194-87.dyn.iinet.net.au [58.7.194.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6019530618BF;
        Sat, 20 Jun 2020 23:21:55 -0400 (EDT)
Message-ID: <7834e0d0a824ed77bb585e6c52de3ca60a7a3f7d.camel@themaw.net>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency
 improvement
From:   Ian Kent <raven@themaw.net>
To:     Tejun Heo <tj@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 21 Jun 2020 11:21:51 +0800
In-Reply-To: <20200619153833.GA5749@mtj.thefacebook.com>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
         <20200619153833.GA5749@mtj.thefacebook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-06-19 at 11:38 -0400, Tejun Heo wrote:
> Hello, Ian.
> 
> On Wed, Jun 17, 2020 at 03:37:43PM +0800, Ian Kent wrote:
> > The series here tries to reduce the locking needed during path
> > walks
> > based on the assumption that there are many path walks with a
> > fairly
> > large portion of those for non-existent paths, as described above.
> > 
> > That was done by adding kernfs negative dentry caching (non-
> > existent
> > paths) to avoid continual alloc/free cycle of dentries and a
> > read/write
> > semaphore introduced to increase kernfs concurrency during path
> > walks.
> > 
> > With these changes we still need kernel parameters of
> > udev.children-max=2048
> > and systemd.default_timeout_start_sec=300 for the fastest boot
> > times of
> > under 5 minutes.
> 
> I don't have strong objections to the series but the rationales don't
> seem
> particularly strong. It's solving a suspected problem but only half
> way. It
> isn't clear whether this can be the long term solution for the
> problem
> machine and whether it will benefit anyone else in a meaningful way
> either.
> 
> I think Greg already asked this but how are the 100,000+ memory
> objects
> used? Is that justified in the first place?

The problem is real enough, however, whether improvements can be made
in other areas flowing on from the arch specific device creation
notifications is not clear cut.

There's no question that there is very high contention between the
VFS and sysfs and that's all the series is trying to improve, nothing
more.

What both you and Greg have raised are good questions but are
unfortunately very difficult to answer.

I tried to add some discussion about it, to the extent that I could,
in the cover letter.

Basically the division of memory into 256M chunks is something that's
needed to provide flexibility for arbitrary partition creation (a set
of hardware allocated that's used for, essentially, a bare metal OS
install). Whether that's many small partitions for load balanced server
farms (or whatever) or much larger partitions for for demanding
applications, such as Oracle systems, is not something that can be
known in advance.

So the division into small memory chunks can't change.

The question of sysfs node creation, what uses them and when they
are used is much harder.

I'm not able to find that out and, I doubt even IBM would know, if
their customers use applications that need to consult the sysfs
file system for this information or when it's needed if it is need
at all. So I'm stuck on this question.

One thing is for sure though, it would be (at the very least) risky
for a vendor to assume they either aren't needed or aren't needed early
during system start up.

OTOH I've looked at what gets invoked on udev notifications (which
is the source of the heavy path walk activity, I admit I need to
dig deeper) and that doesn't appear to be doing anything obviously
wrong so that far seems ok.

For my part, as long as the series proves to be sound, why not,
it does substantially reduce contention between the VFS and sysfs
is the face of heavy sysfs path walk activity so I think that
stands alone as sufficient to consider the change worthwhile.

Ian


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F7C50EEA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 04:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241802AbiDZCZL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 22:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiDZCZK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:25:10 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB66E86E09;
        Mon, 25 Apr 2022 19:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1650939723;
        bh=rOas/IZ4nk8ZseOMrCeHITIudB+xnsliDrTtFFh9E84=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=xSi6gI23nT8tAQZ85B39xUrcB0nxfG6MDm7hyHB6N8b7bEIKgTD/ulrhLKuAmmkjP
         3QYRR1p3MWsUj+9dnJsohNg7NXJMhOtZ6ErqRE3qX+Or1Lx2WRFRnuFAdD9CKgc1EQ
         wVv25XAYGq/ciqUvVDMJ101Q5shuPYsv/yHaWhS4=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4ED901287A1F;
        Mon, 25 Apr 2022 22:22:03 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gZEvPG-9iFTr; Mon, 25 Apr 2022 22:22:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1650939723;
        bh=rOas/IZ4nk8ZseOMrCeHITIudB+xnsliDrTtFFh9E84=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=xSi6gI23nT8tAQZ85B39xUrcB0nxfG6MDm7hyHB6N8b7bEIKgTD/ulrhLKuAmmkjP
         3QYRR1p3MWsUj+9dnJsohNg7NXJMhOtZ6ErqRE3qX+Or1Lx2WRFRnuFAdD9CKgc1EQ
         wVv25XAYGq/ciqUvVDMJ101Q5shuPYsv/yHaWhS4=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2741512810AB;
        Mon, 25 Apr 2022 22:22:02 -0400 (EDT)
Message-ID: <4b7a9126e3988f0f08245df398ffe1e0ec0b9558.camel@HansenPartnership.com>
Subject: Re: Rust and Kernel Vendoring [Was Re: [PATCH v2 1/8] lib/printbuf:
 New data structure for heap-allocated strings]
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        hannes@cmpxchg.org, akpm@linux-foundation.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-input@vger.kernel.org, roman.gushchin@linux.dev
Date:   Mon, 25 Apr 2022 22:22:00 -0400
In-Reply-To: <20220424203626.sdppoyvyrn4yeglp@moria.home.lan>
References: <20220421234837.3629927-7-kent.overstreet@gmail.com>
         <20220422042017.GA9946@lst.de> <YmI5yA1LrYrTg8pB@moria.home.lan>
         <20220422052208.GA10745@lst.de> <YmI/v35IvxhOZpXJ@moria.home.lan>
         <20220422113736.460058cc@gandalf.local.home>
         <20220422193015.2rs2wvqwdlczreh3@moria.home.lan>
         <1f3ce897240bf0f125ca3e5f6ded7c290118a8dc.camel@HansenPartnership.com>
         <20220422211350.qn2brzkfwsulwbiq@moria.home.lan>
         <afdda017cbd0dc0f41d673fe53d2a9c48fba9a6c.camel@HansenPartnership.com>
         <20220424203626.sdppoyvyrn4yeglp@moria.home.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2022-04-24 at 16:36 -0400, Kent Overstreet wrote:
> On Sat, Apr 23, 2022 at 10:16:37AM -0400, James Bottomley wrote:
> > You stripped the nuance of that.  I said many no_std crates could
> > be used in the kernel.  I also said that the async crate couldn't
> > because the rust compiler itself would have to support the kernel
> > threading model.
> 
> I just scanned through that thread and that's not what you said. What
> you said was:
> 
> > The above is also the rust crate problem in miniature: the crates
> > grow API features the kernel will never care about and importing
> > them wholesale is going to take forever because of the internal
> > kernel support issue.  In the end, to take rust async as an
> > example, it will be much better to do for rust what we've done for
> > zlib: take the core that can support the kernel threading model and
> > reimplement that in the kernel crate.  The act of doing that will
> > a) prove people care enough about the functionality and b) allow us
> > to refine it nicely.
> > 
> > I also don't think rust would really want to import crates
> > wholesale.  The reason for no_std is that rust is trying to adapt
> > to embedded environments, which the somewhat harsh constraints of
> > the kernel is very similar to.
> 
> But maybe your position has changed somewhat?

I read those two as saying the same thing just with differing levels of
detail.

>  It sounds like you've been arguing against just directly depending
> on foreign reposotories and for the staus quo of just ad-hoc copying
> of code.

I don't think I've said anything generalised about that either way. 
However, I have noted that most of the external repositories I've
looked at can't (or shouldn't) be imported directly.  Perhaps if we
could find one that could be pulled in directly, we could use that to
drive a discussion of how.

> I'll help by stating my own position: I think we should be coming up
> with a process for how dependencies on other git repositories are
> going to work, something better than just cut and paste. Whether or
> not we vendorize code isn't really that important, but I'd say that
> if we are vendorizing code and we're notincluding entire sub-
> repositories (like cargo vendor does) we ought to still make this a
> scripted process that takes as an input a list of files we're
> pulling and a remote repository we're pulling from, and the file list
> and the remote repo (and commit ID we're pulling from) should all be
> checked in.

Do we have an example of an external piece of code we could do this to?

[...]
> > > The kernel community has a lot of that going on here. Again,
> > > sorry to pick on you James, but I wanted to make the argument
> > > that - maybe the kernel _should_ be adopting a more structured
> > > way of using code from outside repositories, like cargo, or git
> > > submodules (except I've never had a positive experience with git
> > > submodules, so ignore that suggestion, unless I've just been
> > > using them wrong, in which case someone please teach me). To read
> > > you and Greg saying "nah, just copy code from other repos, it's
> > > fine" - it felt like being back in the old days when we were
> > > still trying to get people to use source control, and having that
> > > one older colleague who _insisted_ on not using source control of
> > > any kind, and that's a bit disheartening.
> > 
> > Even in C terms, the kernel is a nostdlib environment.  If a C
> > project has too much libc dependency it's not going to work
> > directly in the kernel, nor should it.  Let's look at zstd (which
> > is pretty much a nostdlib project) as a great example: the facebook
> > people didn't actually port the top of their tree (1.5) to the
> > kernel, they backported bug fixes to the 1.4 branch and made a
> > special release (1.4.10) just for us.  Why did they do this?  It
> > was because the 1.5 version vastly increased stack use to the
> > extent it would run off the end of the limited kernel stack so
> > couldn't be ported directly into the kernel.  A lot of C libraries
> > that are nostdlib have problems like this as well (you can use
> > recursion, but not in the kernel).  There's no easy way of shimming
> > environmental constraints like this.
> 
> I wonder if we might have come up with a better solution if there'd
> been more cross-project communication and less siloing. Small stacks
> aren't particular to the kernel - it's definitely not unheard of to
> write userspace code where you want to have a lot of small stacks
> (especially if you're doing some kind of coroutine style threading;
> I've done stuff like this in the past)

But would you say that every piece of userspace code should reject
recursion and write for small stacks just in case it needs to be reused
in a more extreme environment?

I don't; I think it's fine there are loads of implementations that
would never work in our environment, because mostly there's no reason
to use them in the kernel (or another embedded environment).  I also
understand why people build for the standard userspace environment
first ... it reduces complexity and makes the construction way easier. 

>  - and to me, as someone who's been incrementing on and maintaining a
> codebase in active use for 10 years, having multiple older versions
> in active use that need bugfixes gives me cold shivers.
> 
> I wouldn't be surprised if at some point the zstd people walk back
> some of their changes or make it configurable at some point :)

Many things can happen in the future, but right at the moment I still
think zstd is working fine for both parties.

James



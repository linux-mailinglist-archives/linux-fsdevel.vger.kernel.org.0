Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39367797D73
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Sep 2023 22:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239612AbjIGUha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 16:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbjIGUh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 16:37:29 -0400
Received: from out-229.mta1.migadu.com (out-229.mta1.migadu.com [IPv6:2001:41d0:203:375::e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE2C1BCD
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 13:37:25 -0700 (PDT)
Date:   Thu, 7 Sep 2023 16:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694119042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GA5nMAiT0G3MNbjKaeMA1EJ5Uv5kOOsTnwa98dAPhfY=;
        b=c3Ax82zhV4MudXHm4wVsI48RLeKX0lwf3ytp972lSFHu73dAii7XDeTiBCan4Wvf3xTSJu
        RmF9diKKx8MoXna6TV4EhbGm8afZ8abc7vVNMMy0+RB5Kb8UEec4VjP4tpSC9Bhjl74y7C
        Yf4Mewaobkp/r8LX6jRpVgBah+KrruA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230907203718.upkukiylhbmu5wjh@moria.home.lan>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 06, 2023 at 12:36:18PM -0700, Linus Torvalds wrote:
> So I'm starting to look at this because I have most other pull
> requests done, and while I realize there's no universal support for it
> I suspect any further changes are better done in-tree. The out-of-tree
> thing has been done.
> 
> However, while I'll continue to look at it in this form, I just
> realized that it's completely unacceptable for one very obvious
> reason:
> 
> On Sat, 2 Sept 2023 at 20:26, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> >   https://evilpiepirate.org/git/bcachefs.git bcachefs-for-upstream
> 
> No way am I pulling that without a signed tag and a pgp key with a
> chain of trust. You've been around for long enough that having such a
> key shouldn't be a problem for you, so make it happen.
> 
> There are a few other issues that I have with this, and Christoph did
> mention a big one: it's not been in linux-next. I don't know why I
> thought it had been, it's just such an obvious thing for any new "I
> want this merged upstream" tree.
> 
> So these kinds of "I'll just ignore _all_ basic rules" kinds of issues
> do annoy me.
> 
> I need to know that you understand that if you actually want this
> upstream, you need to work with upstream.
> 
> That very much means *NOT* continuing this "I'll just do it my way".
> You need to show that you can work with others, that you can work
> within the framework of upstream, and that not every single thread you
> get into becomes an argument.
> 
> This, btw, is not negotiable.  If you feel uncomfortable with that
> basic notion, you had better just continue doing development outside
> the main kernel tree for another decade.
> 
> The fact that I only now notice that you never submitted this to
> linux-next is obviously on me. My bad.
> 
> But at the same time it worries me that it might be a sign of you just
> thinking that your way is special.

Linus, I specifically asked you about linux-next in the offlist pre-pull
request thread back in May. It would have been nice if I could've gotten
an answer back then; instead, I'm only getting a definitive answer on
that now.

That question has even come up in meetings and no one could give a
definitive answer; the suggestion was to email you and CC people and
ask, which is precisely what I did.

Sigh.

Now I'm wondering what other surprises I'm going to get the next time
around...

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBA1797F47
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 01:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbjIGXkM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 19:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjIGXkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:40:12 -0400
Received: from out-214.mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA5A1BC6
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Sep 2023 16:40:07 -0700 (PDT)
Date:   Thu, 7 Sep 2023 19:40:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694130005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RWoDi3uV46oY7SIh3m0rhGAD6sZcLL9xJq9LF0bY/sg=;
        b=XWMTynq1Bzwny1usLjn4Le2XylzeIFJpbafRMoAau0HyAlZ0bjSgMCYyHv2yE2hPP61svM
        jM16YJWJSslPWvh2/wNy9fciQOSqw8VchwqBilx7YOqI0GJNvCZXU4o2IEahN7AgZB+7Pz
        yFuWLDf6zgAk8Tg5sNVu95XrKOX9lHM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230907234001.oe4uypp6anb5vqem@moria.home.lan>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
 <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjUX287gJCKDXUY02Wpot1n0VkjQk-PmDOmrsrEfwPfPg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
> 
>                 Linus

Honestly, though, this process is getting entirely kafkaesque.

I've been spending the past month or two working laying the groundwork
for putting together a team to work on this, because god knows we need
fresh blood in filesystem land - but that's on hold. Getting blindsided
by another three month delay hurts, but that's not even the main thing.

The biggest thing has just been the non stop hostility and accusations -
everything from "fracturing the community" too "ignoring all the rules"
and my favorite, "is this the hill Kent wants to die on?" - when I'm
just trying to get work done.

I don't generally think of myself as being particularly difficult to
work with, I get along fine with most of the filesystem developers I
interact with - regularly sharing ideas back and forth with the XFS
people - but these review discussions have been entirely dominated by
the most divisive people in our community, and I'm being told it's
entirely on me to work with the guy whos one constant in the past 15
years has been to try and block everything I submit?

I'm just trying to get work done here. I'm not trying to ignore the
rules. I'm trying to work with people who are willing to have reasonable
discussions.

-------------------

When I was a teenager, I wanted nothing more than to be a Linux kernel
programmer. I thought it utterly amazing that this huge group of people
from around the world were working together over the internet, and that
anyone could take part if they had the chops.

That was my escape from a shitty family situation and the assholes in my
life.

But my life is different now; I have new and better people in my life,
and I have to be thinking about them, and if merging bcachefs means I
have to spend a lot more time in interactions like this then it's going
to make me a shitty person to be around; and I don't want to do that to
myself and I definitely don't want to do that to the people I care
about.

I'm going to go offline for awhile and think about what I want to do
next.

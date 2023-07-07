Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92A574ADD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 11:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjGGJgE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 05:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjGGJgC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:36:02 -0400
Received: from out-7.mta0.migadu.com (out-7.mta0.migadu.com [91.218.175.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC31F2106
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 02:36:00 -0700 (PDT)
Date:   Fri, 7 Jul 2023 05:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688722559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iLz4FNRJXkZQlHsfs5x/mcA+1hjEngxn49GO585IyRg=;
        b=qEt/4nlf1NL5w80gAIY0gRn2phztUoU207aCufEGGpZjtvBhCiOzhkh094uO+6s07JMXMb
        pfF7RjJreEtkDLGO2sEv4bX67Ne92ZXEpFxNp+unIns9VNvTUhuymTYDn/7H21ssMRCFYL
        K+93IYXiauSjLv8i7nAw6+2EzkgGDo0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christian Brauner <brauner@kernel.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, willy@infradead.org,
        tytso@mit.edu, bfoster@redhat.com, jack@suse.cz,
        andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230707093553.j5ftk6t4tkgfhgz4@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
 <20230706211914.GB11476@frogsfrogsfrogs>
 <20230707-badeverbot-gekettet-19ce3c238dac@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707-badeverbot-gekettet-19ce3c238dac@brauner>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 07, 2023 at 10:48:55AM +0200, Christian Brauner wrote:
> > just merge it and let's move on to the next thing."
> 
> "and let the block and vfs maintainers and developers deal with the fallout"
> 
> is how that reads to others that deal with 65+ filesystems and counting.
> 
> The offlist thread that was started by Kent before this pr was sent has
> seen people try to outline calmly what problems they currently still
> have both maintenance wise and upstreaming wise. And it seems there's
> just no way this can go over calmly but instead requires massive amounts
> of defensive pushback and grandstanding.
> 
> Our main task here is to consider the concerns of people that constantly
> review and rework massive amounts of generic code. And I can't in good
> conscience see their concerns dismissed with snappy quotes.
> 
> I understand the impatience, I understand the excitement, I really do.
> But not in this way where core people just drop off because they don't
> want to deal with this anymore.
> 
> I've spent enough time on this thread.

Also, if you do feel like coming back to the discussion: I would still
like to hear in more detail about your specific pain points and talk
about what we can do to address them.

I've put a _ton_ of work into test infrastructure over the years, and
it's now scalable enough to handle fstests runs on every filesystem
fstests support - and it'll get you the results in short order.

I've started making the cluster available to other devs, and I'd be
happy to make it available to you as well. Perhaps there's other things
we could do.

Cheers,
Kent

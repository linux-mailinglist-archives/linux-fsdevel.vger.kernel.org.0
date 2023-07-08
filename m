Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA4ED74BE1B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jul 2023 17:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjGHPX1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jul 2023 11:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjGHPXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jul 2023 11:23:24 -0400
Received: from out-33.mta1.migadu.com (out-33.mta1.migadu.com [IPv6:2001:41d0:203:375::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FECB170C
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jul 2023 08:23:22 -0700 (PDT)
Date:   Sat, 8 Jul 2023 11:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688829799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JOmmsQd20h0V2vC6WmhrFR8UWMacra/J4pnHiQq9pxA=;
        b=bIyqgh7L+yljJ/Yjy4eInVD+jv4A5tfpQX61SbWBMmsRbBY+jC/UgNQWqJucRik5qoC6Vo
        ZJL61HktMnc6ECW+lx6nuSQfIFk/kIwy13JDLXtWaRStjmj8STuZJiVbP9qozW160z8O8i
        mrVCoC2WcxSPKIlUPHYwtpXS7MFnf3M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, bfoster@redhat.com,
        jack@suse.cz, andreas.gruenbacher@gmail.com, peterz@infradead.org,
        akpm@linux-foundation.org, dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230708152314.lcpepguue3imrt3i@moria.home.lan>
References: <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
 <20230706211914.GB11476@frogsfrogsfrogs>
 <20230707-badeverbot-gekettet-19ce3c238dac@brauner>
 <20230707091810.bamrvzcif7ncng46@moria.home.lan>
 <30661670c55601ff475f2f0698c2be2958e45c38.camel@HansenPartnership.com>
 <ZKjd7nQxvzRDA2tK@casper.infradead.org>
 <20230708043136.xj4u7mhklpblomqd@moria.home.lan>
 <20230708150249.GO1178919@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708150249.GO1178919@mit.edu>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 08, 2023 at 11:02:49AM -0400, Theodore Ts'o wrote:
> On Sat, Jul 08, 2023 at 12:31:36AM -0400, Kent Overstreet wrote:
> > 
> > I've long thought a more useful CoC would start with "always try to
> > continue the technical conversation in good faith, always try to build
> > off of what other people are saying; don't shut people down".
> 
> Kent, with all due respect, do you not always follow your suggested
> formulation that you've stated above.  That is to say, you do not
> always assume that your conversational partner is trying to raise
> objections in good faith. 

Ted, how do you have a technical conversation with someone who refuses
to say anything concrete, even when you ask them to elaborate on their
objections, and instead just repeats the same vague non-answers?

> You also want to assume that you are the smartest person in the room,
> and if they object, they are Obviously Wrong.

Ok, now you're really reaching.

Anyone who's actually worked with me can tell you I am quick to consider
other people's point of view and quick to admit when I'm wrong.

All I ask is the same courtesy.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01A574C049
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jul 2023 03:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGIBQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jul 2023 21:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGIBQg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jul 2023 21:16:36 -0400
Received: from out-29.mta1.migadu.com (out-29.mta1.migadu.com [IPv6:2001:41d0:203:375::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C161BC
        for <linux-fsdevel@vger.kernel.org>; Sat,  8 Jul 2023 18:16:35 -0700 (PDT)
Date:   Sat, 8 Jul 2023 21:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688865393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vI5pslL9S+8pP+XfH4J2qu5u8NmgfhAd3f1nmcMyzo4=;
        b=iV6F0pQCKdjYUkWmH9MmMzLR+gS5pJupQvWAxWLQztjREXqkkW3ZyR4tbMOCxsAPnh+x7F
        de26fNdWESSorXa7QZ+ZLpiHzRosx01XY2YPgYHQvXAos47PrAMuoqGaQwSPsnvVXhXeuG
        EAeFnrB35AGutFz00vXhLGeMf38UqC0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        dchinner@redhat.com, sandeen@redhat.com, tytso@mit.edu,
        bfoster@redhat.com, jack@suse.cz, andreas.gruenbacher@gmail.com,
        peterz@infradead.org, akpm@linux-foundation.org,
        dhowells@redhat.com
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230709011626.4br4l6vkkvqmtque@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <20230706155602.mnhsylo3pnief2of@moria.home.lan>
 <20230706164055.GA2306489@perftesting>
 <20230706173819.36c67pf42ba4gmv4@moria.home.lan>
 <20230706211914.GB11476@frogsfrogsfrogs>
 <20230707-badeverbot-gekettet-19ce3c238dac@brauner>
 <20230707091810.bamrvzcif7ncng46@moria.home.lan>
 <30661670c55601ff475f2f0698c2be2958e45c38.camel@HansenPartnership.com>
 <ZKjd7nQxvzRDA2tK@casper.infradead.org>
 <f8f36ffc1360daad3df907c901144144cbcba106.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8f36ffc1360daad3df907c901144144cbcba106.camel@HansenPartnership.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 08, 2023 at 12:42:59PM -0400, James Bottomley wrote:
> That's a bit of a straw man: I never said or implied "bad person".  I
> gave two examples, one from direct list interaction and one quoted from
> Kent of what I consider to be red flags behaviours on behalf of a
> maintainer.

You responded with a massive straw man about an army of little
Kents - seriously, what the hell was that about?

The only maintainers that I've had ongoing problems with have been Jens
and Christoph, and there's more history to that than I want to get into.

If you're talking about _our_ disagreement, I was arguing that cut and
pasting code from other repositories is a terrible workflow that's going
to cause us problems down the road, especially for the Rust folks, and
then afterwards you started hounding me in unrelated LKML discussions.

So clearly you took that personally, and I think maybe you still are.

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38D750341C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Apr 2022 07:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiDPDa0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 23:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiDPDaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:30:24 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E0ABC9C;
        Fri, 15 Apr 2022 20:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1650079672;
        bh=NLJO5M6lb6UWIzx72qVRIXirnJIepm8PzhysHksuLFs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rDEQcfqYypvNI+3grDOBIg8ZGCKrgASUU0pEiJrUW11NBtYRO4xBSy62tbuKtxGL+
         MWAeNuQ0HBGXYZWaZLUgu6kya2cAxHEoG0kit8KmKVAvv3WFDM/lrO7kCo7ly9wSq5
         4EGZctuwhGdw20HQ5lqaIRAkAvEAvN2cerztT43Q=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8AFBE128A02B;
        Fri, 15 Apr 2022 23:27:52 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id byxoCoALOO41; Fri, 15 Apr 2022 23:27:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1650079672;
        bh=NLJO5M6lb6UWIzx72qVRIXirnJIepm8PzhysHksuLFs=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=rDEQcfqYypvNI+3grDOBIg8ZGCKrgASUU0pEiJrUW11NBtYRO4xBSy62tbuKtxGL+
         MWAeNuQ0HBGXYZWaZLUgu6kya2cAxHEoG0kit8KmKVAvv3WFDM/lrO7kCo7ly9wSq5
         4EGZctuwhGdw20HQ5lqaIRAkAvEAvN2cerztT43Q=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id AF934128A02A;
        Fri, 15 Apr 2022 23:27:51 -0400 (EDT)
Message-ID: <ea85b3bce5f172dc73e2be8eb4dbd21fae826fa1.camel@HansenPartnership.com>
Subject: Re: Fwd: Adding crates
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, Chris Suter <chris@sutes.me>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Geert Stappers <stappers@stappers.nl>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 15 Apr 2022 23:27:50 -0400
In-Reply-To: <20220415203926.pvahugtzrg4dbhcc@moria.home.lan>
References: <CAKfU0DLS5icaFn0Mve6+y9Tn1vL+eLKqfquvXbX4oCpYH+VapQ@mail.gmail.com>
         <20220328054136.27mt2xdaltz4unby@gpm.stappers.nl>
         <CAKfU0D+gaC6s6kBBQ9OV+E9PFcm997efY-cUwP3bFWmuDDugbA@mail.gmail.com>
         <YkKXvnsvr0qz/pR2@kroah.com>
         <CAKfU0DLv3K7benXuofXqJwsgxUHA10bu8XWmyBZ0Z_PpZFMACg@mail.gmail.com>
         <CANiq72mrBpJm_6rjapicBoO_mkg4_hEpi9aRTAkj+gtiGkC3Aw@mail.gmail.com>
         <CAKfU0DJ1AqR4cy4=706qRGESozHii9dPL5BYQV047cZkyn3RzA@mail.gmail.com>
         <YkPdIMowqBsJORiK@kroah.com>
         <20220330204353.57w3fxtaw4wwqvi3@moria.home.lan>
         <df41ae9d0f02953cbfe9491f69247a8035f64562.camel@HansenPartnership.com>
         <20220415203926.pvahugtzrg4dbhcc@moria.home.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-04-15 at 16:39 -0400, Kent Overstreet wrote:
> On Fri, Apr 15, 2022 at 09:31:24AM -0400, James Bottomley wrote:
> > I think the solution to the problem is to try to maintain highly
> > mobile reference implementations and also keep constantly
> > considering what the requirements are for mobility (both on the
> > part of the reference implementation and the kernel).  I also think
> > that if we ever gave impementors the magic ability just to dump any
> > old code in the kernel, they'd use it to take the lazy way out
> > because it's a lot easier than trying to keep the reference
> > implementation separate.
> > 
> > The fact that most "reference" implementations don't conform to the
> > above isn't something we should be encouraging by supplying
> > compatibility APIs that paper over the problem and encourage API
> > bloat.
> 
> I think it might help if we had a
>  - standard set of review guidelines
>  - standard workflow
> 
> for pulling in (vendoring, however it gets done) code from external
> repositories.

But that's precisely what we shouldn't have.  For most standard
implementations it shouldn't be done.  zlib is a case in point: even if
we could pull in 74k lines from an external repo to try to extract the
300 we need that's not going to be via anything like a standard
process.  Now there might be something we could assist with in
standardising how reference implementations should be done to make them
mobile to environments like embedded and the kernel, but if the project
isn't structured like this, it's already pretty much too late.

> Generally what I see in the community is that people do want to
> support the kernel better, but then people see things like Greg's
> response of "don't do that" and it turns people off. Instead, we
> could 
>  - recognize that it's already being done (e.g. with zstd)

It hasn't been done with zstd.  What we have looks like a reference
implementation based on RFC 8478, it's nothing like the facebook github
for zstd and I'm sure more people than Greg (me included) would object
greatly to trying to swap our 300 line implementation for the facebook
74k line one.

>  - put some things in writing about how it _should_ be done

This is where I think we could help.  As I said: libxfs (and librcu as
you point out below) already exists as a blueprint.  For rust async,
it's a bit more complex because it depends on whether the async support
in the compiler can truly be made compatible with the kernel threading
model rather than simply vendoring the async crates.

> This could help a lot with e.g. the way Facebook maintains ZSTD - if
> we say "look, we want this code factored out better so we only have
> to review the stuff that's relevant" - the engineers generally won't
> mind doing that work, and now they'll have something to take to their
> managers as justification.

Well, they do, they just don't expect to do it by us vendoring the
reference implementation:

https://github.com/facebook/zstd/issues/1638

In the above, the facebook maintainer is willing to extract the
reference core and add it to the linux kernel.  That seems to be a
great result for us.

> Another thing I'd like to see is more of what the RCU folks have done
> - liburcu is _amazing_ in that, at least for me, it's been a drop in
> replacement for the kernel RCU implementation - and I would imagine
> it's as much as possible the same code. A good candidate would be the
> kernel workqueue code: workqueues are _great_ and I don't know of
> anything like them in userspace. That code should be
> seeing wider use! And if it was made an external library that was
> consumed by both the kernel and userspace, it could be - but it would
> require buy in from kernel people.

That might work for , but most other languages need something different
(and often have their own implementation, like python:

https://docs.python.org/3/library/queue.html

or rabbitMQ or something).

> But as you were saying about Facebook (and I discovered when I was at
> Google many moons ago, as a young engineer) - large organizations
> tend to be insular, they like te pretend the outside world doesn't
> exist. The kernel is one such organization :) We could be a better
> citizen by encouraging and enabling efforts such as this.

Well, I think they are.  To be clear, I think the way zstd is supported
in the kernel is great.  If it works for facebook (having the
maintainer extract it to the kernel and send us pull requests), I don't
see a problem with keeping it the way it is rather than trying to
vendor the existing code.

Regards,

James



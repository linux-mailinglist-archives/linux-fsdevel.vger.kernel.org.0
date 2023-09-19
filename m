Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C757A6943
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 18:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjISQ6G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 12:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjISQ6F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 12:58:05 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B050C6
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 09:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1695142678;
        bh=4XN17DBUYw9+xg2L7gGa15NHHbB4soAr8EZrLkJaqg0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=T0xtxaiFZ8AjIc3VcsvRjmfUs6fiM5eFmD7L3t5y2jLsU8cularoOkQXadoXnRnLz
         +4g8pmVTjM9TjuBhsm4TI6vtPPQsxGfyRoOpVgdxYVavAj/XJrA5Vm1qGmknfjq4LF
         u/8Ua9EIh6i+uRTlnhp/vCn6X1WnPXhJq3vARfhc=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 32E0912867B6;
        Tue, 19 Sep 2023 12:57:58 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id irqNu3k6ObXb; Tue, 19 Sep 2023 12:57:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1695142677;
        bh=4XN17DBUYw9+xg2L7gGa15NHHbB4soAr8EZrLkJaqg0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=Zh5vU5hZ7Pr0hdmpN8exN2IkJ9lJfQf7QflBoPeHf25+Mr7cf5ptF8vjfw96RgIoP
         0crq1b7G/OLKYjs820S7hFolzJXasYTSLypx75FiWcnRpZjQ71G78NVl/t3GN6bNGR
         pXLFM6DRiM8oAm5VGXv3149CT9i8ilaucT0vuIKU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 378151281B49;
        Tue, 19 Sep 2023 12:57:57 -0400 (EDT)
Message-ID: <4b2f3646fb3da593ec67c47bcfaec3b0a744dc5b.camel@HansenPartnership.com>
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file
 systems
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 19 Sep 2023 12:57:56 -0400
In-Reply-To: <ZQkK8kTPhFw8BpVA@dread.disaster.area>
References: <ZPkDLp0jyteubQhh@dread.disaster.area>
         <20230906215327.18a45c89@gandalf.local.home>
         <ZPkz86RRLaYOkmx+@dread.disaster.area>
         <20230906225139.6ffe953c@gandalf.local.home>
         <ZPlFwHQhJS+Td6Cz@dread.disaster.area>
         <20230907071801.1d37a3c5@gandalf.local.home>
         <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
         <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
         <ZQTfIu9OWwGnIT4b@dread.disaster.area>
         <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
         <ZQkK8kTPhFw8BpVA@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2023-09-19 at 12:44 +1000, Dave Chinner wrote:
> On Sat, Sep 16, 2023 at 05:50:50PM -0400, James Bottomley wrote:
> > On Sat, 2023-09-16 at 08:48 +1000, Dave Chinner wrote:
> > > On Wed, Sep 13, 2023 at 10:03:55AM -0700, Linus Torvalds wrote:
> > [...]
> > > >  - "they use the buffer cache".
> > > > 
> > > > Waah, waah, waah.
> > > 
> > > .... you dismiss those concerns in the same way a 6 year old
> > > school yard bully taunts his suffering victims.
> > > 
> > > Regardless of the merits of the observation you've made, the tone
> > > and content of this response is *completely unacceptable*. 
> > > Please keep to technical arguments, Linus, because this sort of
> > > response has no merit what-so-ever. All it does is shut down the
> > > technical discussion because no-one wants to be the target of
> > > this sort of ugly abuse just for participating in a technical
> > > discussion.
> > > 
> > > Given the number of top level maintainers that signed off on the
> > > CoC that are present in this forum, I had an expectation that
> > > this is a forum where bad behaviour is not tolerated at all.  So
> > > I've waited a couple of days to see if anyone in a project
> > > leadership position is going to say something about this
> > > comment.....
> > > 
> > > <silence>
> > > 
> > > The deafening silence of tacit acceptance is far more damning
> > > than the high pitched squeal of Linus's childish taunts.
> > 
> > Well, let's face it: it's a pretty low level taunt and it wasn't
> > aimed at you (or indeed anyone on the thread that I could find) and
> > it was backed by technical argument in the next sentence.  We all
> > have a tendency to let off steam about stuff in general not at
> > people in particular as you did here:
> > 
> > https://lore.kernel.org/ksummit/ZP+vcgAOyfqWPcXT@dread.disaster.area/
> 
> There's a massive difference between someone saying no to a wild
> proposal with the backing of solid ethical arguments against
> experimentation on non-consenting human subjects vs someone calling
> anyone who might disagree with them a bunch of cry-babies.
> 
> You do yourself a real disservice by claiming these two comments are
> in any way equivalent.

Well, let's see shall we.  The detrimental impact of an email often
results from the first sentence which is what most people see and react
to especially on the modern display devices like phones.  Pretty much
as you reacted to the first sentence from Linus above.  Your first
sentence in the email I quoted above replying to my idea was:

> No fucking way.

Absent further context that's a textbook stress inducing personal
attack.  Now, I've been on the receiving end of things like this for a
long time, so I simply deployed the usual stress reduction techniques,
read the rest of your email, deleted the knee jerk response and waited
to see if anyone else had a different opinion.

However, the key point is that your email induced the same stress
reaction in me that Linus' statement apparently did in you, so
absolutely I see an equivalence.

> > But I didn't take it as anything more than a rant about AI in
> > general and syzbot in particular and certainly I didn't assume it
> > was aimed at me or anyone else.
> 
> I wasn't ranting about AI at all. If you think that was what I was
> talking about then you have, once again, completely missed the
> point.
> 
> I was talking about the *ethics of our current situation* and how
> that should dictate the behaviour of community members and bots that
> they run for the benefit of the community. If a bot is causing harm
> to the community, then ethics dictates that there is only one
> reasonable course of action that can be taken...
> 
> This has *nothing to do with AI* and everything to do with how the
> community polices hostile actors in the community. If 3rd party
> run infrastructure is causing direct harm to developers and they
> aren't allowed to opt out, then what do we do about it?

My point was basically trying to improve the current situation by
getting the AI processes producing the reports to make them more useful
and eliminate a significant portion of the outbound flow, but I get
that some people are beyond that and would go for amputation rather
than attempted cure.

> > If everyone reached for the code of conduct when someone had a non-
> > specific rant using colourful phraseology, we'd be knee deep in
> > complaints, which is why we tend to be more circumspect when it
> > happens.
> 
> I disagree entirely, and I think this a really bad precedent to try
> to set. Maybe you see it as "Fred has a colourful way with words",
> but that doesn't change the fact the person receiving that comment
> might see the same comment very, very differently.

Which was precisely my point about your email above.  At its most basic
level the standard you hold yourself to has to be the same or better
than the standard you hold others to.

James

> I don't think anyone can dispute the fact that top level kernel
> maintainers are repeat offenders when it comes to being nasty,
> obnoxious and/or abusive. Just because kernel maintainers have
> normalised this behaviour between themselves, it does not make it OK
> to treat anyone else this way.
> 
> Maintainers need to be held to a higher standard than the rest of
> the community - the project leaders need to set the example of how
> everyone else should behave, work and act - and right now I am _very
> disappointed_ by where this thread has ended up.



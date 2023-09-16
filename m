Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DF17A324E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Sep 2023 21:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbjIPToU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 16 Sep 2023 15:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbjIPToI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:44:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050F6CDE
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Sep 2023 12:44:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20F7C433C7;
        Sat, 16 Sep 2023 19:44:00 +0000 (UTC)
Date:   Sat, 16 Sep 2023 15:44:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file
 systems
Message-ID: <20230916154427.657bfe93@gandalf.local.home>
In-Reply-To: <ZQTfIu9OWwGnIT4b@dread.disaster.area>
References: <ZO9NK0FchtYjOuIH@infradead.org>
        <8718a8a3-1e62-0e2b-09d0-7bce3155b045@roeck-us.net>
        <ZPkDLp0jyteubQhh@dread.disaster.area>
        <20230906215327.18a45c89@gandalf.local.home>
        <ZPkz86RRLaYOkmx+@dread.disaster.area>
        <20230906225139.6ffe953c@gandalf.local.home>
        <ZPlFwHQhJS+Td6Cz@dread.disaster.area>
        <20230907071801.1d37a3c5@gandalf.local.home>
        <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
        <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
        <ZQTfIu9OWwGnIT4b@dread.disaster.area>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 16 Sep 2023 08:48:02 +1000
Dave Chinner <david@fromorbit.com> wrote:

> >  - "they use the buffer cache".
> > 
> > Waah, waah, waah.  
> 
> .... you dismiss those concerns in the same way a 6 year old school
> yard bully taunts his suffering victims.
> 
> Regardless of the merits of the observation you've made, the tone
> and content of this response is *completely unacceptable*.  Please
> keep to technical arguments, Linus, because this sort of response
> has no merit what-so-ever. All it does is shut down the technical
> discussion because no-one wants to be the target of this sort of
> ugly abuse just for participating in a technical discussion.
> 
> Given the number of top level maintainers that signed off on the CoC
> that are present in this forum, I had an expectation that this is a
> forum where bad behaviour is not tolerated at all.  So I've waited a
> couple of days to see if anyone in a project leadership position is
> going to say something about this comment.....
> 
> <silence>
> 
> The deafening silence of tacit acceptance is far more damning than
> the high pitched squeal of Linus's childish taunts.

Being one of those that signed off on the CoC, I honestly didn't see this
until you pointed it out. As I'm not a file system maintainer I have been
mostly just skimming the emails in this thread. I had this one marked as
read, but I only really read the first half of it.

Even though I didn't see it, I will admit that even if I had, I would not
have said anything because I'm so use to it and I'm somewhat blind to it
until someone points it out to me.

I'm not on the CoC committee, but I am on the TAB, and I will officially
state that comment was not appropriate.

Linus, please let's keep this technical.

-- Steve

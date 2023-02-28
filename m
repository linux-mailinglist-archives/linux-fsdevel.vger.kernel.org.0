Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957516A5DE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 18:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjB1RD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 12:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB1RDZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:03:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2969993C8;
        Tue, 28 Feb 2023 09:03:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3FF7610A1;
        Tue, 28 Feb 2023 17:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F39C433EF;
        Tue, 28 Feb 2023 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677603802;
        bh=BGPHMddN/7Rv/G0+aO8UeGdWrCdsMalvyVw208xAlYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7iKjo1zLSWyNf9n61neTEP+5vqvclUtT+ZFbGvLQyTvnPobku6UI9DHpfADf7+kK
         +f5Dsup1xKf/+gjhDnsOV3Sj00vA2Wy8NM0dC+UrKIQ3hSDp3VEzAwAL2BCR9akVPE
         Se5xk4W9We2NJFj1LZPyhc+dl4zkMsbFEFXrSHgXTkxiz1ufpxdiQvKNYVZqV9Rt5/
         qRZF/hY64EnwOj3aY2xPaINOPp5tKF1rKB6kjeO9xeVbMhenzNSkYyA57VBubwqHQz
         f/K/HA4dJ3/DBLjekDy5uHuVCGfIf7vE88rwswnfOcagVK1ijRBu8sOWfaPDGwUII2
         9wrnavEzQzvBQ==
Date:   Tue, 28 Feb 2023 12:03:20 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: AUTOSEL process
Message-ID: <Y/4z2NyGgwG4zvYq@sashalap>
References: <Y/ux9JLHQKDOzWHJ@sol.localdomain>
 <Y/y70zJj4kjOVfXa@sashalap>
 <Y/zswi91axMN8OsA@sol.localdomain>
 <Y/zxKOBTLXFjSVyI@sol.localdomain>
 <Y/0U8tpNkgePu00M@sashalap>
 <Y/0i5pGYjrVw59Kk@gmail.com>
 <Y/0wMiOwoeLcFefc@sashalap>
 <Y/1LlA5WogOAPBNv@gmail.com>
 <Y/1em4ygHgSjIYau@sashalap>
 <Y/136zpJSWx96YEe@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Y/136zpJSWx96YEe@sol.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 27, 2023 at 07:41:31PM -0800, Eric Biggers wrote:
>On Mon, Feb 27, 2023 at 08:53:31PM -0500, Sasha Levin wrote:
>> >
>> > I'm shocked that these are the statistics you use to claim the current AUTOSEL
>> > process is working.  I think they actually show quite the opposite!
>> >
>> > First, since many AUTOSEL commits aren't actually fixes but nearly all
>> > stable-tagged commits *are* fixes, the rate of regressions per commit would need
>> > to be lower for AUTOSEL commits than for stable-tagged commits in order for
>> > AUTOSEL commits to have the same rate of regressions *per fix*.  Your numbers
>> > suggest a similar regression rate *per commit*.  Thus, AUTOSEL probably
>> > introduces more regressions *per fix* than stable-tagged commits.
>>
>> Interesting claim. How many of the AUTOSEL commits are "actual" fixes?
>> How do you know if a commit is a fix for anything or not?
>>
>> Could you try and back claims with some evidence?
>>
>> Yes, in a perfect world where we know if a commit is a fix we could
>> avoid introducing regressions into the stable trees. Heck, maybe we could
>> even stop writing buggy code to begin with?
>
>Are you seriously trying to claim that a random commit your neural network
>picked up is just as likely to be a fix as a commit that the author explicitly
>tagged as a fix and/or for stable?

I'd like to think that this is the case after the initial selection and
multiple rounds of reviews, yes.

>That's quite an extraordinary claim, and it's not true from my experience.  Lots
>of AUTOSEL patches that get Cc'ed to me, if I'm familiar enough with the area to
>understand fairly well whether the patch is a "fix", are not actually fixes.  Or
>are very borderline "fixes" that don't meet stable criteria.  (Note, I generally
>only bother responding to AUTOSEL if I think a patch is actually going to cause
>a problem.  So a lack of response isn't necessarily agreement that a patch is
>really suitable for stable...)
>
>Oh sorry, personal experience is not "evidence".  Please disregard my invalid
>non-evidence-based opinion.
>
>> > (Of course, stable-tagged commits sometimes have missing prerequisite bugs too.
>> > But it's expected to be at a lower rate, since the original developers and
>> > maintainers are directly involved in adding the stable tags.  These are the
>> > people who are more familiar than anyone else with prerequisites.)
>>
>> You'd be surprised. There is documentation around how one would annotate
>> dependencies for stable tagged commits, something along the lines of:
>>
>> 	cc: stable@kernel.org # dep1 dep2
>>
>> Grep through the git log and see how often this is actually used.
>
>Well, probably more common is that prerequisites are in the same patchset, and
>the prerequisites are tagged for stable too.  Whereas AUTOSEL often just picks
>patch X of N.  Also, developers and maintainers who tag patches for stable are
>probably more likely to help with the stable process in general and make sure
>patches are backported correctly...
>
>Anyway, the point is, AUTOSEL needs to be fixed to stop inappropriately
>cherry-picking patch X of N so often.

That's a fair point.

>> > a multi-patch series, and if so are earlier patches needed as prerequisites".
>> > There also needs to be more soak time in mainline, and more review time.
>>
>> Tricky bit with mainline/review time is that very few of our users
>> actually run -rc trees.
>>
>> We end up hitting many of the regressions because the commits actually
>> end up in stable trees. Should it work that way? No, but our testing
>> story around -rc releases is quite lacking.
>
>Well, in the bug that affected me, it *was* found on mainline almost
>immediately.  It just took a bit longer than the extremely aggressive 7-day
>AUTOSEL period to be fixed.
>
>Oh sorry again, one example is not "evidence".  Please disregard my invalid
>non-evidence-based opinion.

I'm happy that we're in agreement that significant process changes can't
happen because of opinions or anecdotal examples.

In all seriousness, I will work on addressing the issues that happened
around the commit(s) you've pointed out and improve our existing
process.

-- 
Thanks,
Sasha

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B768B4D20ED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 20:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349839AbiCHTIB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 14:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349841AbiCHTIB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:08:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB6954195
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 11:07:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE1F16165A
        for <linux-fsdevel@vger.kernel.org>; Tue,  8 Mar 2022 19:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32731C340EF;
        Tue,  8 Mar 2022 19:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646766422;
        bh=JywQ9l846m66kE1vqnNoV+GDSuefZ1CHGUrg7YV4QQ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bx0A7qNVFz3KCTlkApSHsDv61T24Z3JyLVHcvp+u0jZWJiRhmFun4XSEISAYl6wOI
         E7yHX2zDGzVaK0fazqMH3V2p5Kq2W556XrSxBAQ4GSqYEYe18Kb6y41KiegtfdixfJ
         +5ALxGZJ5SyD0gfPiO0wSNc/DqYy0pU4P3IJKdM5HhmaF8GKNSnn0+qtQlUAUk30g7
         fgJhJabFkSwVZ5JMitfxOzflksAP03FKRBxGtGtKRastWasmLFej9MGYX2/oO9Nz+X
         Bl4xW6S0d3QgBgx5aK4XGQQg+yEGINEA6XjYjI5fI5zWSA/PQJFnwzIjUeCEOH5qqN
         RlmRfhhQ9nbRQ==
Date:   Tue, 8 Mar 2022 14:06:57 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <YiepUS/bDKTNA5El@sashalap>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 08, 2022 at 01:04:05PM +0200, Amir Goldstein wrote:
>On Tue, Mar 8, 2022 at 12:08 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>>
>> On Tue, Mar 08, 2022 at 11:32:43AM +0200, Amir Goldstein wrote:
>> > On Tue, Feb 12, 2019 at 7:31 PM Sasha Levin <sashal@kernel.org> wrote:
>> > >
>> > > Hi all,
>> > >
>> > > I'd like to propose a discussion about the workflow of the stable trees
>> > > when it comes to fs/ and mm/. In the past year we had some friction with
>> > > regards to the policies and the procedures around picking patches for
>> > > stable tree, and I feel it would be very useful to establish better flow
>> > > with the folks who might be attending LSF/MM.
>> > >
>> > > I feel that fs/ and mm/ are in very different places with regards to
>> > > which patches go in -stable, what tests are expected, and the timeline
>> > > of patches from the point they are proposed on a mailing list to the
>> > > point they are released in a stable tree. Therefore, I'd like to propose
>> > > two different sessions on this (one for fs/ and one for mm/), as a
>> > > common session might be less conductive to agreeing on a path forward as
>> > > the starting point for both subsystems are somewhat different.
>> > >
>> > > We can go through the existing processes, automation, and testing
>> > > mechanisms we employ when building stable trees, and see how we can
>> > > improve these to address the concerns of fs/ and mm/ folks.
>> > >
>> >
>> > Hi Sasha,
>> >
>> > I think it would be interesting to have another discussion on the state of fs/
>> > in -stable and see if things have changed over the past couple of years.
>> > If you do not plan to attend LSF/MM in person, perhaps you will be able to
>> > join this discussion remotely?
>> >
>> > >From what I can see, the flow of ext4/btrfs patches into -stable still looks
>> > a lot healthier than the flow of xfs patches into -stable.
>>
>> That is explicitly because the ext4/btrfs developers/maintainers are
>> marking patches for stable backports, while the xfs
>> developers/maintainers are not.
>>
>> It has nothing to do with how me and Sasha are working,
>
>Absolutely, I have no complaints to the stable maintainers here, just wanted
>to get a status report from Sasha, because he did invest is growing the stable
>tree xfstests coverage AFAIK, which should have addressed some of the
>earlier concerns of xfs developers.

I can update: we indeed invested in improving the story behind how we
pull XFS patches into -stable, where I ended up with a collection of
scripts that can establish a baseline and compare stable-rc releases to
that baseline, reporting issues.

The system was somewhat expensive to maintain, in the sense that I often
hit flaky tests, chased down issues that are not obviously test
failures, just keeping stuff updated and running, and so on, but it was
still doable.

At one point we hit a few issues that didn't reproduce with xfstests,
and as a result there were asks such as the timing of when I pull
patches and their proposed flow into releases.

At that point the process on my end basically stopped:

  a. It was clear that xfs would be the only subsystem using this as
  mm/ext4/etc aligned with just tagging things for stable and being okay
  with me occasionally bugging them with AUTOSEL mails to catch stuff
  they might have missed.

  b. Neither me nor my employer had a particular interest in xfs.

  c. The process was too much of a snowflake to be doing along with the
  rest of the -stable work.

And so the scripts bitrotted and died.

Somewhat related: about a year ago I joined Google, who got bit in the
arse with a process like the one that Jan described for SUSE, and asked
for a new kernel program to use the upstream LTS trees, upgrade anually,
and run a subset of workloads on the -stable kernel to stay even closer
to upstream and catch issues earlier. (There's a taped presentation
about it here: https://www.youtube.com/watch?v=tryyzWATpaU).

At this point I can run a battery of tests and real workloads mostly at
subsystems that Google ends up caring about (which end up being most of
the core kernel code - mm, ext4, sched, etc), find real bugs, and
address them before a release. Sadly xfs is not one of those subsystem
that they care about.

>> so go take this up with the fs developers :)
>
>It is easy to blame the "fs developers", but is it also very hard on an
>overloaded maintainer to ALSO take care of GOOD stable tree updates.
>
>Here is a model that seems to be working well for some subsystems:
>When a tester/developer finds a bug they write an LTP test.
>That LTP test gets run by stable kernel test bots and prompts action
>from distros who now know of this issue and may invest resources
>in backporting patches.
>
>If I am seeing random developers reporting bugs from running xfstests
>on stable kernels and I am not seeing the stable kernel test bots reporting
>those bugs, then there may be room for improvement in the stable kernel
>testing process??

There always is, and wearing my stable maintainer hat I would *love*
*love* *love* if folks who care about a particular subsystem or workload
to test the kernels and let us know if anything broke, at which point we
will do our best to address it.

What we can't do is invest significant time into doing the testing work
ourselves for each and every subsystem in the kernel.

The testing rig I had is expensive, not even just time-wise but also
w.r.t the compute resources it required to operate, I suspect that most
of the bots that are running around won't dedicate that much resources
to each filesystem on a voluntary basis.

>> > In 2019, Luis started an effort to improve this situation (with some
>> > assistance from me and you) that ended up with several submissions
>> > of stable patches for v4.19.y, but did not continue beyond 2019.
>> >
>> > When one looks at xfstest bug reports on the list for xfs on kernels > v4.19
>> > one has to wonder if using xfs on kernels v5.x.y is a wise choice.
>>
>> That's up to the xfs maintainers to discuss.
>>
>> > Which makes me wonder: how do the distro kernel maintainers keep up
>> > with xfs fixes?
>>
>> Who knows, ask the distro maintainers that use xfs.  What do they do?
>>
>
>So here I am - asking them via proxy fs developers :)

I can comment on what I'm seeing with Google's COS distro: it's a
chicken-and-egg problem. It's hard to offer commercial support with the
current state of xfs, but on the other hand it's hard to improve the
state of xfs without a commercial party that would invest more
significant resources into it.

Luckily there is an individual in Google who has picked up this work and
hopefully we will see something coming out of it very soon, but honestly
- we just got lucky.

-- 
Thanks,
Sasha

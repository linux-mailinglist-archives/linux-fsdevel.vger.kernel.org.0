Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB7152D7DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 17:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241462AbiESPgz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 11:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241410AbiESPgp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 11:36:45 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A239F5675A
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 08:36:06 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id b20so4997855qkc.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 08:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BNpiAp66r7nUZ8PlySXFTLPOtISp14h9MHHCuM/nnpY=;
        b=sf4TjaH9vz+HxVfpHeMem1j5HKxR4RxtYRtK68ZaoRZe/NICE8Mh3I+rD02U44ZH5i
         QCdK3OgNPzbDN4X0+TL3fKCa+RDMnmv6EU/ntRWVnzS/9eK2lm0BTnQAwkaBydFfxnKu
         KEzQ/OqiHpQom/Q0nsJ4lZU68QP7xrzf3HnwF+PpkddIAh3ji+XYBIbUutinVVgcw6AU
         IMEmg4OMRYblRPOW2h6zGg2baxAVwvyfaRaOqQc+3vwG9Rr30cGWnAFvmfrv8FY/zbKm
         DI7evKDbEpzLjowhgl3o9B7q0WUXbuOAGD9C72c9UFRHQBAw4Y2Xkf0qnNzntmJIISFc
         MkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BNpiAp66r7nUZ8PlySXFTLPOtISp14h9MHHCuM/nnpY=;
        b=M/nLhllwX+370cMQGCJLnQ/xDwAzBCzLRPMeJCpq7y3/7piDgmnCNvmt8fQXvkp0B+
         J2qqG0WhpeQhRSpjAPEcrWTKmlKo9gX1xmPs7N307l6Q6yx+p8DrpGqybkE9ZYYS6aBw
         pY44b2uJU2/dNfDsr657oplHAgm1dpioIz1Xs7qXRJNwSvTs/pR6ianVYLVG0ByJ4zdh
         C/Kw4kbBhzU47qhC/K2z/6ya7FQdMjmwl8d18bCFcrHzHz5h8pQRJXL+RIpYhcaBNofX
         B69NtzbiZlFGYthWCEPvrJ+ffgG7r8yVuRjSK0F/Bc+EJB32vARHBP74YnvRGCMT9zNu
         oPqA==
X-Gm-Message-State: AOAM532zpMVJRCs++fyBXn8Hx4yNhfYGeFzYxGaJmKUJfruQEYDap5Oe
        8q+bMVvNUstKu87sTVlE699PEw==
X-Google-Smtp-Source: ABdhPJy5RiPhJyIyJco5qyeA4n8FyQc7ywfFOSnE8wzGNVY+4usKx3jFtLkPRVEJbvodku8fJPOaRQ==
X-Received: by 2002:a05:620a:1a99:b0:680:f33c:dbd3 with SMTP id bl25-20020a05620a1a9900b00680f33cdbd3mr3422227qkb.17.1652974565117;
        Thu, 19 May 2022 08:36:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h8-20020ac85148000000b002f39b99f679sm1492209qtn.19.2022.05.19.08.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 08:36:04 -0700 (PDT)
Date:   Thu, 19 May 2022 11:36:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, pankydev8@gmail.com,
        Theodore Tso <tytso@mit.edu>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for
 expunges
Message-ID: <YoZj4nHX42AOn8+F@localhost.localdomain>
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org>
 <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
 <20220519075805.GU2306852@dread.disaster.area>
 <CAOQ4uxi-A2iErkbBBaewmoKa8OGWXaUzaZqwygQxKzzEZcsCXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi-A2iErkbBBaewmoKa8OGWXaUzaZqwygQxKzzEZcsCXQ@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 12:20:28PM +0300, Amir Goldstein wrote:
> On Thu, May 19, 2022 at 10:58 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Thu, May 19, 2022 at 09:36:41AM +0300, Amir Goldstein wrote:
> > > [adding fstests and Zorro]
> > >
> > > On Thu, May 19, 2022 at 6:07 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > >
> > > > I've been promoting the idea that running fstests once is nice,
> > > > but things get interesting if you try to run fstests multiple
> > > > times until a failure is found. It turns out at least kdevops has
> > > > found tests which fail with a failure rate of typically 1/2 to
> > > > 1/30 average failure rate. That is 1/2 means a failure can happen
> > > > 50% of the time, whereas 1/30 means it takes 30 runs to find the
> > > > failure.
> > > >
> > > > I have tried my best to annotate failure rates when I know what
> > > > they might be on the test expunge list, as an example:
> > > >
> > > > workflows/fstests/expunges/5.17.0-rc7/xfs/unassigned/xfs_reflink.txt:generic/530 # failure rate about 1/15 https://gist.github.com/mcgrof/4129074db592c170e6bf748aa11d783d
> > > >
> > > > The term "failure rate 1/15" is 16 characters long, so I'd like
> > > > to propose to standardize a way to represent this. How about
> > > >
> > > > generic/530 # F:1/15
> > > >
> > >
> > > I am not fond of the 1/15 annotation at all, because the only fact that you
> > > are able to document is that the test failed after 15 runs.
> > > Suggesting that this means failure rate of 1/15 is a very big step.
> > >
> > > > Then we could extend the definition. F being current estimate, and this
> > > > can be just how long it took to find the first failure. A more valuable
> > > > figure would be failure rate avarage, so running the test multiple
> > > > times, say 10, to see what the failure rate is and then averaging the
> > > > failure out. So this could be a more accurate representation. For this
> > > > how about:
> > > >
> > > > generic/530 # FA:1/15
> > > >
> > > > This would mean on average there failure rate has been found to be about
> > > > 1/15, and this was determined based on 10 runs.
> >
> > These tests are run on multiple different filesystems. What happens
> > if you run xfs, ext4, btrfs, overlay in sequence? We now have 4
> > tests results, and 1 failure.
> >
> > Does that make it FA: 1/4, or does it make it 1/1,0/1,0/1,0/1?
> >
> > What happens if we run, say, XFS w/ defaults, rmapbt=1, v4, quotas?
> >
> > Does that make it FA: 1/4, or does it make it 0/1,1/1,0/1,0/1?
> >
> > In each case above, 1/4 tells us nothing useful. OTOH, the 0/1 vs
> > 1/1 breakdown is useful information, because it tells us whihc
> > filesystem failed the test, or which specific config failed the
> > test.
> >
> > Hence I think the ability for us to draw useful conclusions from a
> > number like this is large dependent on the specific data set it is
> > drawn from...
> >
> > > > We should also go extend check for fstests/blktests to run a test
> > > > until a failure is found and report back the number of successes.
> > > >
> > > > Thoughts?
> >
> > Who is the expected consumer of this information?
> >
> > I'm not sure it will be meaningful for anyone developing new code
> > and needing to run every test every time they run fstests.
> >
> > OTOH, for a QA environment where you have a fixed progression of the
> > kernel releases you are testing, it's likely valuable and already
> > being tracked in various distro QE management tools and
> > dashboards....
> >
> > > I have had a discussion about those tests with Zorro.
> > >
> > > Those tests that some people refer to as "flaky" are valuable,
> > > but they are not deterministic, they are stochastic.
> >
> > Extremely valuable. Worth their weight in gold to developers like
> > me.
> >
> > The recoveryloop group tests are a good example of this. The name of
> > the group indicates how we use it. I typically set it up to run with
> > an loop iteration like "-I 100" knowing that is will likely fail a
> > random test in the group within 10 iterations.
> >
> > Those one-off failures are almost always a real bug, and they are
> > often unique and difficult to reproduce exactly. Post-mortem needs
> > to be performed immediately because it may well be a unique on-off
> > failure and running another test after the failure destroys the
> > state needed to perform a post-mortem.
> >
> > Hence having a test farm running these multiple times and then
> > reporting "failed once in 15 runs" isn't really useful to me as a
> > developer - it doesn't tell us anything new, nor does it help us
> > find the bugs that are being tripped over.
> >
> > Less obvious stochastic tests exist, too. There are many tests that
> > use fstress as a workload that runs while some other operation is
> > performed - freeze, grow, ENOSPC, error injections, etc. They will
> > never be deterministic, any again any failure tends to be a real
> > bug, too.
> >
> > However, I think these should be run by QE environments all the time
> > as they require long term, frequent execution across different
> > configs in different environments to find the deep dark corners
> > where the bugs may lie dormant. These are the tests that find things
> > like subtle timing races no other tests ever exercise.
> >
> > I suspect that tests that alter their behaviour via LOAD_FACTOR or
> > TIME_FACTOR will fall into this category.
> >
> > > I think MTBF is the standard way to describe reliability
> > > of such tests, but I am having a hard time imagining how
> > > the community can manage to document accurate annotations
> > > of this sort, so I would stick with documenting the facts
> > > (i.e. the test fails after N runs).
> >
> > I'm unsure of what "reliablity of such tests" means in this context.
> > The tests are trying to exercise and measure the reliability of the
> > kernel code - if the *test is unreliable* then that says to me the
> > test needs fixing. If the test is reliable, then any failures that
> > occur indicate that the filesystem/kernel/fs tools are unreliable,
> > not the test....
> >
> > "test reliability" and "reliability of filesystem under test" are
> > different things with similar names. The latter is what I think we
> > are talking about measuring and reporting here, right?
> >
> > > OTOH, we do have deterministic tests, maybe even the majority of
> > > fstests are deterministic(?)
> >
> > Very likely. As a generalisation, I'd say that anything that has a
> > fixed, single step at a time recipe and a very well defined golden
> > output or exact output comparison match is likely deterministic.
> >
> > We use things like 'within tolerance' so that slight variations in
> > test results don't cause spurious failures and hence make the test
> > more deterministic.  Hence any test that uses 'within_tolerance' is
> > probably a test that is expecting deterministic behaviour....
> >
> > > Considering that every auto test loop takes ~2 hours on our rig and that
> > > I have been running over 100 loops over the past two weeks, if half
> > > of fstests are deterministic, that is a lot of wait time and a lot of carbon
> > > emission gone to waste.
> > >
> > > It would have been nice if I was able to exclude a "deterministic" group.
> > > The problem is - can a developer ever tag a test as being "deterministic"?
> >
> > fstests allows private exclude lists to be used - perhaps these
> > could be used to start building such a group for your test
> > environment. Building a list from the tests you never see fail in
> > your environment could be a good way to seed such a group...
> >
> > Maybe you have all the raw results from those hundreds of tests
> > sitting around - what does crunching that data look like? Who else
> > has large sets of consistent historic data sitting around? I don't
> > because I pollute my results archive by frequently running varied
> > and badly broken kernels through fstests, but people who just run
> > released or stable kernels may have data sets that could be used....
> >
> 
> I have no historic data of that sort and I have never stayed on the
> same test system long enough to collect this sort of data.
> 
> Josef has told us in LPC 2021 about his btrfs fstests dashboard
> where he started to collect historical data a while ago.
> 

I'm clearly biased, but I think this is the best way to go for *developers*.  We
want to know all the things, so we just need to have a clear way to see what's
failing and have a historical view of what has failed.  If you look at our
dashboard at toxicpanda.com you can click on the tests and see their runs and
failures on different configs.  This has been insanely valuable to me, and
helped me narrow down test cases that needed to be adjusted for compression.

> Collaborating on expunge lists of different fs and different
> kernel/config/distro
> is one of the goals behind Luis's kdevops project.
> 

I think this is also hugely valuable from the "Willy usecase" perspective.
Willy doesn't care about failure rates or interpreting the tea leaves of what
our format is, he wants to make sure he didn't break anything.  We should strive
to have 0 failures for this use case, so having expunge lists in place to get
rid of any flakey results are going to make it easier for non-experts to get a
solid grasp on wether they introduced a regression or not.

There's room for both use cases.  I want the expunge lists for newbies, I want
good reporting for the developers who know what they're doing.  We can provide
documentation for both

- If Willy, run 'make fstests-clean'
- If Josef, run 'mkame fstests'

Thanks,

Josef

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C054352CF3B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 11:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiESJUo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 05:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbiESJUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 05:20:42 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A94A76F4;
        Thu, 19 May 2022 02:20:40 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id n10so4176678qvi.5;
        Thu, 19 May 2022 02:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SrZrDaHweGaAi+UApTAiBNC9rpyNJRR1jI+3LTfDr6Y=;
        b=BSJlE+nqmeFAlf64O3ZpGHq3v7Z6ozrWZwWowg6bGVvquUw567/291UK+Jk3k2Mfbj
         Ecg5H2t75c32UIPMPKAun1q/Lu+Dj0sBDd8CZ2yZYLPUV5dK3xhL1MzHSMlqM8Niqfbp
         Mg38VanBEoeBy3s6c3LQvMfYyFsfkSeVXjWGs823O1XaxiWnZ0NWHrrRw5CgJjWEbs1J
         2vJe4CoLsJwb2R9POuT3rvEzv3/V26SGt6bC1QajVXu7h79Y1Oljd7S7bbCRgneKfJCb
         HLQuFGBlvufwe2NrfsLcrL1qt7zQpBTz+UAzdHuKN6H8rIYN6h+6heuU43D38lJTgc9F
         8rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SrZrDaHweGaAi+UApTAiBNC9rpyNJRR1jI+3LTfDr6Y=;
        b=IvB6VEj07VHAltvoiFGjQSqA+uYN+ytlbcMHwOST7ImqibCK+Rf9YZXw27g8Z6H/ri
         rFilEuF3Hmma39lBGLw5OwzW2FTkN1t5UXqFVDnMheEKoX/Nkg+g/XRQP4nNHPDvmVnG
         VbVCeLfeH7D/TRlHz2HLKNUd7rjol8fs6sMv8hAx/Di99KKoUtkh5+d7WoXDmnH+U+Vh
         VYAJ+uiLiSLY/ILtbh7Vcjh5w+/bEgCeHnNPiNcUN9zb++Mx597JsKh3pR7Zu1iOavWt
         G7yO5zNax+pOd6UzD8Urex73vEmqbUWuy+2Vg0JBeDMzXUnK+p3Y0Bd65IwIwqvYAKWa
         5X1A==
X-Gm-Message-State: AOAM532R6XMz5EJdhUCFRexdBgCD0YJbLBlxZoOON5ifcJZ15SUqoRGv
        wEKChzVX2MZWqE9f4knskJl/WHGxYSZYyJtD0ls=
X-Google-Smtp-Source: ABdhPJwRNDZ7LsUV7RphF17SpNGi1YT2manjy7HGtcPUAr6qB4km+8AxgvzGIQfM/to3SoVnpyBjYv0PxZVoLVjllho=
X-Received: by 2002:a05:6214:1cc4:b0:435:35c3:f0f1 with SMTP id
 g4-20020a0562141cc400b0043535c3f0f1mr3282856qvd.0.1652952039658; Thu, 19 May
 2022 02:20:39 -0700 (PDT)
MIME-Version: 1.0
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org> <CAOQ4uxhKHMjGq0QKKMPFAV6iJFwe1H5hBomCVVeT1EWJzo0eXg@mail.gmail.com>
 <20220519075805.GU2306852@dread.disaster.area>
In-Reply-To: <20220519075805.GU2306852@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 19 May 2022 12:20:28 +0300
Message-ID: <CAOQ4uxi-A2iErkbBBaewmoKa8OGWXaUzaZqwygQxKzzEZcsCXQ@mail.gmail.com>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for expunges
To:     Dave Chinner <david@fromorbit.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, pankydev8@gmail.com,
        Theodore Tso <tytso@mit.edu>,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 19, 2022 at 10:58 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, May 19, 2022 at 09:36:41AM +0300, Amir Goldstein wrote:
> > [adding fstests and Zorro]
> >
> > On Thu, May 19, 2022 at 6:07 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > I've been promoting the idea that running fstests once is nice,
> > > but things get interesting if you try to run fstests multiple
> > > times until a failure is found. It turns out at least kdevops has
> > > found tests which fail with a failure rate of typically 1/2 to
> > > 1/30 average failure rate. That is 1/2 means a failure can happen
> > > 50% of the time, whereas 1/30 means it takes 30 runs to find the
> > > failure.
> > >
> > > I have tried my best to annotate failure rates when I know what
> > > they might be on the test expunge list, as an example:
> > >
> > > workflows/fstests/expunges/5.17.0-rc7/xfs/unassigned/xfs_reflink.txt:generic/530 # failure rate about 1/15 https://gist.github.com/mcgrof/4129074db592c170e6bf748aa11d783d
> > >
> > > The term "failure rate 1/15" is 16 characters long, so I'd like
> > > to propose to standardize a way to represent this. How about
> > >
> > > generic/530 # F:1/15
> > >
> >
> > I am not fond of the 1/15 annotation at all, because the only fact that you
> > are able to document is that the test failed after 15 runs.
> > Suggesting that this means failure rate of 1/15 is a very big step.
> >
> > > Then we could extend the definition. F being current estimate, and this
> > > can be just how long it took to find the first failure. A more valuable
> > > figure would be failure rate avarage, so running the test multiple
> > > times, say 10, to see what the failure rate is and then averaging the
> > > failure out. So this could be a more accurate representation. For this
> > > how about:
> > >
> > > generic/530 # FA:1/15
> > >
> > > This would mean on average there failure rate has been found to be about
> > > 1/15, and this was determined based on 10 runs.
>
> These tests are run on multiple different filesystems. What happens
> if you run xfs, ext4, btrfs, overlay in sequence? We now have 4
> tests results, and 1 failure.
>
> Does that make it FA: 1/4, or does it make it 1/1,0/1,0/1,0/1?
>
> What happens if we run, say, XFS w/ defaults, rmapbt=1, v4, quotas?
>
> Does that make it FA: 1/4, or does it make it 0/1,1/1,0/1,0/1?
>
> In each case above, 1/4 tells us nothing useful. OTOH, the 0/1 vs
> 1/1 breakdown is useful information, because it tells us whihc
> filesystem failed the test, or which specific config failed the
> test.
>
> Hence I think the ability for us to draw useful conclusions from a
> number like this is large dependent on the specific data set it is
> drawn from...
>
> > > We should also go extend check for fstests/blktests to run a test
> > > until a failure is found and report back the number of successes.
> > >
> > > Thoughts?
>
> Who is the expected consumer of this information?
>
> I'm not sure it will be meaningful for anyone developing new code
> and needing to run every test every time they run fstests.
>
> OTOH, for a QA environment where you have a fixed progression of the
> kernel releases you are testing, it's likely valuable and already
> being tracked in various distro QE management tools and
> dashboards....
>
> > I have had a discussion about those tests with Zorro.
> >
> > Those tests that some people refer to as "flaky" are valuable,
> > but they are not deterministic, they are stochastic.
>
> Extremely valuable. Worth their weight in gold to developers like
> me.
>
> The recoveryloop group tests are a good example of this. The name of
> the group indicates how we use it. I typically set it up to run with
> an loop iteration like "-I 100" knowing that is will likely fail a
> random test in the group within 10 iterations.
>
> Those one-off failures are almost always a real bug, and they are
> often unique and difficult to reproduce exactly. Post-mortem needs
> to be performed immediately because it may well be a unique on-off
> failure and running another test after the failure destroys the
> state needed to perform a post-mortem.
>
> Hence having a test farm running these multiple times and then
> reporting "failed once in 15 runs" isn't really useful to me as a
> developer - it doesn't tell us anything new, nor does it help us
> find the bugs that are being tripped over.
>
> Less obvious stochastic tests exist, too. There are many tests that
> use fstress as a workload that runs while some other operation is
> performed - freeze, grow, ENOSPC, error injections, etc. They will
> never be deterministic, any again any failure tends to be a real
> bug, too.
>
> However, I think these should be run by QE environments all the time
> as they require long term, frequent execution across different
> configs in different environments to find the deep dark corners
> where the bugs may lie dormant. These are the tests that find things
> like subtle timing races no other tests ever exercise.
>
> I suspect that tests that alter their behaviour via LOAD_FACTOR or
> TIME_FACTOR will fall into this category.
>
> > I think MTBF is the standard way to describe reliability
> > of such tests, but I am having a hard time imagining how
> > the community can manage to document accurate annotations
> > of this sort, so I would stick with documenting the facts
> > (i.e. the test fails after N runs).
>
> I'm unsure of what "reliablity of such tests" means in this context.
> The tests are trying to exercise and measure the reliability of the
> kernel code - if the *test is unreliable* then that says to me the
> test needs fixing. If the test is reliable, then any failures that
> occur indicate that the filesystem/kernel/fs tools are unreliable,
> not the test....
>
> "test reliability" and "reliability of filesystem under test" are
> different things with similar names. The latter is what I think we
> are talking about measuring and reporting here, right?
>
> > OTOH, we do have deterministic tests, maybe even the majority of
> > fstests are deterministic(?)
>
> Very likely. As a generalisation, I'd say that anything that has a
> fixed, single step at a time recipe and a very well defined golden
> output or exact output comparison match is likely deterministic.
>
> We use things like 'within tolerance' so that slight variations in
> test results don't cause spurious failures and hence make the test
> more deterministic.  Hence any test that uses 'within_tolerance' is
> probably a test that is expecting deterministic behaviour....
>
> > Considering that every auto test loop takes ~2 hours on our rig and that
> > I have been running over 100 loops over the past two weeks, if half
> > of fstests are deterministic, that is a lot of wait time and a lot of carbon
> > emission gone to waste.
> >
> > It would have been nice if I was able to exclude a "deterministic" group.
> > The problem is - can a developer ever tag a test as being "deterministic"?
>
> fstests allows private exclude lists to be used - perhaps these
> could be used to start building such a group for your test
> environment. Building a list from the tests you never see fail in
> your environment could be a good way to seed such a group...
>
> Maybe you have all the raw results from those hundreds of tests
> sitting around - what does crunching that data look like? Who else
> has large sets of consistent historic data sitting around? I don't
> because I pollute my results archive by frequently running varied
> and badly broken kernels through fstests, but people who just run
> released or stable kernels may have data sets that could be used....
>

I have no historic data of that sort and I have never stayed on the
same test system long enough to collect this sort of data.

Josef has told us in LPC 2021 about his btrfs fstests dashboard
where he started to collect historical data a while ago.

Collaborating on expunge lists of different fs and different
kernel/config/distro
is one of the goals behind Luis's kdevops project.

For now, the expunge lists are curated in git:
https://github.com/linux-kdevops/kdevops/tree/master/workflows/fstests/expunges
Going forward, this cannot scale. If we want to collaborate and
collect results from
multiple testers and test labs we should consult with the KernelCI
project, who are
doing exactly that for other test suites.

You did not attend Luis' talk in LSFMM this year (he has already mentioned
kdevops back in LSFMM 2019), where some of these issues were discussed.
The video from LSFMM 2022 talk should be available in coming weeks.
I hear that Luis is also planning on giving a talk to a wider audience
in LPC 2022.

Thanks,
Amir.



> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com

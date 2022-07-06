Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324715684C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 12:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiGFKLm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 06:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiGFKL2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:11:28 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F480B4B8;
        Wed,  6 Jul 2022 03:11:27 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id i186so14551536vsc.9;
        Wed, 06 Jul 2022 03:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sCq1qR774KGiBeY4lPTFyzrnMabgyiMHInxYJ8h+1uY=;
        b=B4itdb+3Yy5QKgIdMmwaF/Khf8LFzbWp6Np17oXHCQ8yh4FrNMW2iuFHLloL4y+BwJ
         vAUTr9st12IdblZvx0zFHNaA4tb2aVoXtk7U7WxcguT/Y+0qnpXRy99NOM8tIBmFqyb5
         f7z/iSJh2XOP+Ff0JrUIyR1j2IK7aiq7gUUsLixr1M+1MQdJa3TZ4AWus9+rOyDudDUF
         VrvDM+d8J7ixE364LnAZNrSrp/XTh+/KGChpuKFpxCbgSaAYwni2LOvpu0m02dBefZ8Z
         17G0BhUsboyOGNtjzHepkSLfOoy04UDneALwwXtVXmOugh+hUmwraY/SDctxta9EL7tR
         MAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sCq1qR774KGiBeY4lPTFyzrnMabgyiMHInxYJ8h+1uY=;
        b=ZZEMyKJkRELBayVWGBbt18sUIscgVqjFKBNT3Yhx3kN71T2LpjfGrfjp3JYBbDkwoa
         DzsmPJQEJV/eja7M3BA0IujQPuj+wrcLeNolhaxWOvSi3mxHKrl1IYgMRGq+1WzmQzJQ
         WFAqw3Z2cTIZPzMo2KPCn4op4ujF0zknv2/I33EwC8zS4KlbFqGAPOh7+2xjhhZIs1V7
         ioLmb2B7XU5ah6OeeFrsSKWJ1FzNyfow0u90hBegvobJ4A6LgD1QstCnQzwuMekFTcSM
         q0Wy6yOPE3HWj7gocbV3Quz7JQyVKN6PRAZ1qLiWvc8+OS1OVZmb8gHb+mPl6Xf+qBUs
         Mk5A==
X-Gm-Message-State: AJIora9ZqAUKu9LURWsFORP3Ed3HBy/nJqLVfeYDHEREPKeJr1742gYA
        oyt5rWIP8FeJo3LRTbzgPup8JUzJ2lC4Z76ZtH4=
X-Google-Smtp-Source: AGRyM1vtGMIPSfZDOvv9noTsaDQY3RhsvpQ9by2taIwfmaGFaFRbqphY007lDgXDnG39cxZ3Nxs1C6Ektv7UUKy/ESs=
X-Received: by 2002:a05:6102:38c7:b0:356:4e2f:ae5b with SMTP id
 k7-20020a05610238c700b003564e2fae5bmr21524628vst.71.1657102286505; Wed, 06
 Jul 2022 03:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org> <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
 <CAOQ4uxgBtMifsNt1SDA0tz098Rt7Km6MAaNgfCeW=s=FPLtpCQ@mail.gmail.com>
 <20220704032516.GC3237952@dread.disaster.area> <CAOQ4uxj5wabQvsGELS7t_Z9Z4Z2ZUHAR8d+LBao89ANErwZ95g@mail.gmail.com>
 <20220705031133.GD3237952@dread.disaster.area>
In-Reply-To: <20220705031133.GD3237952@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 6 Jul 2022 13:11:16 +0300
Message-ID: <CAOQ4uxi2rBGqmtXghFJ+frDORETum+4KOKEg0oeX-woPXLNxTw@mail.gmail.com>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for expunges
To:     Dave Chinner <david@fromorbit.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Theodore Tso <tytso@mit.edu>,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
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

On Tue, Jul 5, 2022 at 6:11 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Jul 04, 2022 at 10:58:22AM +0300, Amir Goldstein wrote:
> > On Mon, Jul 4, 2022 at 6:25 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Sun, Jul 03, 2022 at 08:56:54AM +0300, Amir Goldstein wrote:
> > > > On Sun, Jul 3, 2022 at 12:48 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > > > >
> > > > > On 5/18/22 20:07, Luis Chamberlain wrote:
> > > > > > I've been promoting the idea that running fstests once is nice,
> > > > > > but things get interesting if you try to run fstests multiple
> > > > > > times until a failure is found. It turns out at least kdevops has
> > > > > > found tests which fail with a failure rate of typically 1/2 to
> > > > > > 1/30 average failure rate. That is 1/2 means a failure can happen
> > > > > > 50% of the time, whereas 1/30 means it takes 30 runs to find the
> > > > > > failure.
> > > > > >
> > > > > > I have tried my best to annotate failure rates when I know what
> > > > > > they might be on the test expunge list, as an example:
> > > > > >
> > > > > > workflows/fstests/expunges/5.17.0-rc7/xfs/unassigned/xfs_reflink.txt:generic/530 # failure rate about 1/15 https://gist.github.com/mcgrof/4129074db592c170e6bf748aa11d783d
> > > > > >
> > > > > > The term "failure rate 1/15" is 16 characters long, so I'd like
> > > > > > to propose to standardize a way to represent this. How about
> > > > > >
> > > > > > generic/530 # F:1/15
> > > > > >
> > > > > > Then we could extend the definition. F being current estimate, and this
> > > > > > can be just how long it took to find the first failure. A more valuable
> > > > > > figure would be failure rate avarage, so running the test multiple
> > > > > > times, say 10, to see what the failure rate is and then averaging the
> > > > > > failure out. So this could be a more accurate representation. For this
> > > > > > how about:
> > > > > >
> > > > > > generic/530 # FA:1/15
> > > > > >
> > > > > > This would mean on average there failure rate has been found to be about
> > > > > > 1/15, and this was determined based on 10 runs.
> > > > > >
> > > > > > We should also go extend check for fstests/blktests to run a test
> > > > > > until a failure is found and report back the number of successes.
> > > > > >
> > > > > > Thoughts?
> > > > > >
> > > > > > Note: yes failure rates lower than 1/100 do exist but they are rare
> > > > > > creatures. I love them though as my experience shows so far that they
> > > > > > uncover hidden bones in the closet, and they they make take months and
> > > > > > a lot of eyeballs to resolve.
> > > > >
> > > > > I strongly disagree with annotating tests with failure rates. My opinion
> > > > > is that on a given test setup a test either should pass 100% of the time
> > > > > or fail 100% of the time. If a test passes in one run and fails in
> > > > > another run that either indicates a bug in the test or a bug in the
> > > > > software that is being tested. Examples of behaviors that can cause
> > > > > tests to behave unpredictably are use-after-free bugs and race
> > > > > conditions. How likely it is to trigger such behavior depends on a
> > > > > number of factors. This could even depend on external factors like which
> > > > > network packets are received from other systems. I do not expect that
> > > > > flaky tests have an exact failure rate. Hence my opinion that flaky
> > > > > tests are not useful and also that it is not useful to annotate flaky
> > > > > tests with a failure rate. If a test is flaky I think that the root
> > > > > cause of the flakiness must be determined and fixed.
> > > > >
> > > >
> > > > That is true for some use cases, but unfortunately, the flaky
> > > > fstests are way too valuable and too hard to replace or improve,
> > > > so practically, fs developers have to run them, but not everyone does.
> > >
> > > Everyone *should* be running them. They find *new bugs*, and it
> > > doesn't matter how old the kernel is. e.g. if you're backporting XFS
> > > log changes and you aren't running the "flakey" recoveryloop group
> > > tests, then you are *not testing failure handling log recovery
> > > sufficiently*.
> > >
> > > Where do you draw the line? recvoeryloop tests that shutdown and
> > > recover the filesystem will find bugs, they are guaranteed to be
> > > flakey, and they are *absolutely necessary* to be run because they
> > > are the only tests that exercise that critical filesysetm crash
> > > recovery functionality.
> > >
> > > What do we actually gain by excluding these "non-deterministic"
> > > tests from automated QA environments?
> > >
> >
> > Automated QA environment is a broad term.
> > We all have automated QA environments.
> > But there is a specific class of automated test env, such as CI build bots
> > that do not tolerate human intervention.
>
> Those environments need curated test lists because of the fact
> that failures gate progress. They also tend to run in resource
> limited environments as fstests is not the only set of tests that
> are run. Hence, generally speaking, CI is not an environment you'd
> be running a full "auto" group set of tests. Even the 'quick' group
> (which take an hour to run here) is often far too time and resource
> intensive for a CI system to use effectively.
>
> IOWs, we can't easily curate a set of tests that are appropriate for
> all CI environments - it's up to the people running the CI
> enviroment to determine what level of testing is appropriate for
> gating commits to their source tree, not the fstests maintainers or
> developers...
>

OK. I think that is the way CIFS are doing CI -
Running a whitelist of (probably quick) tests known to pass on cifs.

> > Is it enough to run only the deterministic tests to validate xfs code?
> > No it is not.
> >
> > My LTS environment is human monitored - I look at every failure and
> > analyse the logs and look at historic data to decide if they are regressions
> > or not. A bot simply cannot do that.
> > The bot can go back and run the test N times on baseline vs patch.
> >
> > The question is, do we want kernel test bot to run -g auto -x soak
> > on linux-next and report issues to us?
> >
> > I think the answer to this question should be yes.
> >
> > Do we want kernel test bot to run -g auto and report flaky test
> > failures to us?
> >
> > I am pretty sure that the answer is no.
>
> My answer to both is *yes, absolutely*.
>

Ok.

> The zero-day kernel test bot runs all sorts of non-deterministic
> tests, including performance regression testing. We want these
> flakey/non-deterministic tests run in such environments, because
> they are often configurations we do not ahve access to and/or would
> never even consider. e.g. 128p server with a single HDD running IO
> scalability tests like AIM7...
>
> This is exactly where such automated testing provides developers
> with added value - it covers both hardware and software configs that
> indvidual developers cannot exercise themselves. Developers may or
> may not pay attention to those results depending on the test that
> "fails" and the hardware it "failed' on, but the point is that it
> got tested on something we'd never get coverage on otherwise.
>

So I am wondering what is the status today, because I rarely
see fstests failure reports from kernel test bot on the list, but there
are some reports.

Does anybody have a clue what hw/fs/config/group of fstests
kernel test bot is running on linux-next?

Did any fs maintainer communicate to kernel test bot maintainer
about this?

> > > The test run policy mechanisms we already have avoid
> > > this whole can of worms - we don't need to care about the specific
> > > test requirements of any specific test enviroment because the
> > > default is inclusive and it is trivial to exclude tests from that
> > > default set if needed.
> > >
> >
> > I had the humble notion that we should make running fstests to
> > passing-by developers as easy as possible, because I have had the
> > chance to get feedback from some developers on their first time
> > attempt to run fstests and it wasn't pleasant, but nevermind.
> > -g auto -x soak is fine.
>
> I think that the way to do this is the way Ted has described - wrap
> fstests in an environment where all the required knowledge is
> already encapsulated and the "drive by testers" just need to crank
> the handle and it churns out results.
>
> As it is, I don't think making things easier for "drive-by" testing
> at the expense of making things arbitrarily different and/or harder
> for people who use it every day is a good trade-off. The "target
> market" for fstests is *filesystem developers* and people who spend
> their working life *testing filesystems*. The number of people who
> do *useful* "drive-by" testing of filesystems is pretty damn small,
> and IMO that niche is nowhere near as important as making things
> better for the people who use fstests every day....
>

I agree that using fstests runners for drive-by testing makes more
sense.

> > When you think about it, many fs developrs run ./check -g auto,
> > so we should not interfere with that, but I bet very few run './check'?
> > so we could make the default for './check' some group combination
> > that is as deterministic as possible.
>
> Bare ./check invocations are designed to run every test, regardless
> of what group they are in.
>
> Stop trying to redefine longstanding existing behaviour - if you
> want to define "deterministic" tests so that you can run just those
> tests, define a group for it, add all the tests to it, and then
> document it in the README as "if you have no experience with
> fstests, this is where you should start".

OK. Or better yet, use an fstests runner.

>
> Good luck keeping that up to date, though, as you're now back to the
> same problem that Ted describes, which is the "deterministic" group
> changes based on kernel, filesystem, config, etc.
>

It's true. I think there is some room for improvement of how
tests are classified in fstests repo. I will elaborate on my reply to Ted.

Thanks,
Amir.

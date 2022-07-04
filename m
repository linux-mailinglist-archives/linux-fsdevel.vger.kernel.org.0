Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28B5564F2E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jul 2022 09:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbiGDH6i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jul 2022 03:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiGDH6h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:58:37 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93766AE43;
        Mon,  4 Jul 2022 00:58:35 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id j26so4035355vki.12;
        Mon, 04 Jul 2022 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2EuMszLQJmftWEYMfqbSK8wRP0ainjp7iyBTY4zWqk=;
        b=Fju+hBM5bOGAEUbB0ndxwwvHIppkFcmyZVqEEDJirjP7GM5C/ldXOV6yK7iXcyTe/N
         OoOhGQyPOM+QnOzxm8D6ZilL0DgqwR5qLvwXA8maGJyzJlSmYXPfM9N1B7ir2stMh36c
         MI1FUBJCFKJUmDGOBWDWQZD9sT7JAFWmcMYUpCCQqD8Y8r/WZk1eiTry20WVpvKOunWc
         CMNy7sfo4Tz+e+KCAfUOL7bYRDQa/4hGUfzF++soV7ZQ1P7zrhfLmptzKfgsabtaouYZ
         jxcZk/hEyvNLJ1NDs7k/VvVj1LPBzGK41iStxdbJ7v6V35YRf40VvKvmFYw/6RpwZ0lQ
         9C8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2EuMszLQJmftWEYMfqbSK8wRP0ainjp7iyBTY4zWqk=;
        b=pFVrKqnuGKD4fNVG+2LWdM92ZC8wIZXheQLntRgYj5iXrGexXiT7KwyzCQVw8tPtDF
         MH8X0cryE5cd+rVTUmedj5pkRWg8fMseyJleo04PXi0P/wPE7gXNfeZ8V40dDyKO0fx9
         6cFK5NCpfjeiAgirtAF71l+/vu5zYc6kk09ZjA66zwsFdcwztrTqKW4C7PBdLBxK8e5v
         4kk4ZdGKvx4iUumsiHd6tZkqsPH5TOZP9YbugLbSQPmERD3wsfMLrlu1kYZ417qMghqI
         S6owwZ+re5HJO1Shwxu3W7ZdTqpkc9vCzbiIm0qN7OhPa7dtx5ayQwPdZ9u5eYfMQwhC
         NK6g==
X-Gm-Message-State: AJIora/xgiHYaCiNyaCaoYCWq7mlOIOeGrddKiowoydBt2sM9yIQ/ZQJ
        bugS9kJr9OUOaOj63jxJ3qMzPx5k3SjG282sX+67imT+2wQ=
X-Google-Smtp-Source: AGRyM1sogqrRqlzSxIQ5yc9wFNM8TB6eEQsqsexK8k13E5lQSTLLwXgGM6sTJam71drIgHUzeStuQw7BoIvLJnfjlNo=
X-Received: by 2002:a05:6122:e10:b0:370:e49b:d1dd with SMTP id
 bk16-20020a0561220e1000b00370e49bd1ddmr5615170vkb.25.1656921514474; Mon, 04
 Jul 2022 00:58:34 -0700 (PDT)
MIME-Version: 1.0
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org> <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
 <CAOQ4uxgBtMifsNt1SDA0tz098Rt7Km6MAaNgfCeW=s=FPLtpCQ@mail.gmail.com> <20220704032516.GC3237952@dread.disaster.area>
In-Reply-To: <20220704032516.GC3237952@dread.disaster.area>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 4 Jul 2022 10:58:22 +0300
Message-ID: <CAOQ4uxj5wabQvsGELS7t_Z9Z4Z2ZUHAR8d+LBao89ANErwZ95g@mail.gmail.com>
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

On Mon, Jul 4, 2022 at 6:25 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Sun, Jul 03, 2022 at 08:56:54AM +0300, Amir Goldstein wrote:
> > On Sun, Jul 3, 2022 at 12:48 AM Bart Van Assche <bvanassche@acm.org> wrote:
> > >
> > > On 5/18/22 20:07, Luis Chamberlain wrote:
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
> > > >
> > > > We should also go extend check for fstests/blktests to run a test
> > > > until a failure is found and report back the number of successes.
> > > >
> > > > Thoughts?
> > > >
> > > > Note: yes failure rates lower than 1/100 do exist but they are rare
> > > > creatures. I love them though as my experience shows so far that they
> > > > uncover hidden bones in the closet, and they they make take months and
> > > > a lot of eyeballs to resolve.
> > >
> > > I strongly disagree with annotating tests with failure rates. My opinion
> > > is that on a given test setup a test either should pass 100% of the time
> > > or fail 100% of the time. If a test passes in one run and fails in
> > > another run that either indicates a bug in the test or a bug in the
> > > software that is being tested. Examples of behaviors that can cause
> > > tests to behave unpredictably are use-after-free bugs and race
> > > conditions. How likely it is to trigger such behavior depends on a
> > > number of factors. This could even depend on external factors like which
> > > network packets are received from other systems. I do not expect that
> > > flaky tests have an exact failure rate. Hence my opinion that flaky
> > > tests are not useful and also that it is not useful to annotate flaky
> > > tests with a failure rate. If a test is flaky I think that the root
> > > cause of the flakiness must be determined and fixed.
> > >
> >
> > That is true for some use cases, but unfortunately, the flaky
> > fstests are way too valuable and too hard to replace or improve,
> > so practically, fs developers have to run them, but not everyone does.
>
> Everyone *should* be running them. They find *new bugs*, and it
> doesn't matter how old the kernel is. e.g. if you're backporting XFS
> log changes and you aren't running the "flakey" recoveryloop group
> tests, then you are *not testing failure handling log recovery
> sufficiently*.
>
> Where do you draw the line? recvoeryloop tests that shutdown and
> recover the filesystem will find bugs, they are guaranteed to be
> flakey, and they are *absolutely necessary* to be run because they
> are the only tests that exercise that critical filesysetm crash
> recovery functionality.
>
> What do we actually gain by excluding these "non-deterministic"
> tests from automated QA environments?
>

Automated QA environment is a broad term.
We all have automated QA environments.
But there is a specific class of automated test env, such as CI build bots
that do not tolerate human intervention.

Is it enough to run only the deterministic tests to validate xfs code?
No it is not.

My LTS environment is human monitored - I look at every failure and
analyse the logs and look at historic data to decide if they are regressions
or not. A bot simply cannot do that.
The bot can go back and run the test N times on baseline vs patch.

The question is, do we want kernel test bot to run -g auto -x soak
on linux-next and report issues to us?

I think the answer to this question should be yes.

Do we want kernel test bot to run -g auto and report flaky test
failures to us?

I am pretty sure that the answer is no.

So we need -x soak or whatever for this specific class of machine
automated validation.

> > Zorro has already proposed to properly tag the non deterministic tests
> > with a specific group and I think there is really no other solution.
> >
> > The only question is whether we remove them from the 'auto' group
> > (I think we should).
>
> As per above, this shows that many people simply don't understand
> what many of these non-determinsitic tests are actually exercising,
> and hence what they fail to test by excluding them from automated
> testing.
>
> > There is probably a large overlap already between the 'stress' 'soak' and
> > 'fuzzers' test groups and the non-deterministic tests.
> > Moreover, if the test is not a stress/fuzzer test and it is not deterministic
> > then the test is likely buggy.
> >
> > There is only one 'stress' test not in 'auto' group (generic/019), only two
> > 'soak' tests not in the 'auto' group (generic/52{1,2}).
> > There are only three tests in 'soak' group and they are also exactly
> > the same three tests in the 'long_rw' group.
> >
> > So instead of thinking up a new 'flaky' 'random' 'stochastic' name
> > we may just repurpose the 'soak' group for this matter and start
> > moving known flaky tests from 'auto' to 'soak'.
>
> Please, no. The policy for the auto group is inclusive, not
> exclusive. It is based on the concept that every test is valuable
> and should be run if possible. Hence any test that generally
> passes, does not run forever and does not endanger the system should
> be a member of the auto group. That effectively only rules out
> fuzzer and dangerous tests from being in the auto group, as long
> running tests should be scaled by TIME_FACTOR/LOAD_FACTOR and hence
> the default test behaviour results in only a short time run time.
>
> If someone wants to *reduce their test coverage* for whatever reason
> (e.g. runtime, want to only run pass/fail tests, etc) then the
> mechanism we already have in place for this is for that person to
> use *exclusion groups*. i.e. we exclude subsets of tests from the
> default set, we don't remove them from the default set.
>
> Such an environment would run:
>
> ./check -g auto -x soak
>
> So that the test environment doesn't run the "non-determinisitic"
> tests in the 'soak' group. i.e. the requirements of this test
> environment do not dictate the tests that every other test
> environment runs by default.
>


OK.

> > generic/52{1,2} can be removed from 'soak' group and remain
> > in 'long_rw' group, unless filesystem developers would like to
> > add those to the stochastic test run.
> >
> > filesystem developers that will run ./check -g auto -g soak
> > will get the exact same test coverage as today's -g auto
> > and the "commoners" that run ./check -g auto will enjoy blissful
> > determitic test results, at least for the default config of regularly
> > tested filesystems (a.k.a, the ones tested by kernet test bot).?
>
> An argument that says "everyone else has to change what they do so I
> don't have to change" means that the person making the argument
> thinks their requirements are more important than the requirements
> of anyone else.

Unless that person was not arguing for themselves...
I was referring to passing-by developers that develop a patch that
interacts with fs code who do not usually develop and test filesystems.
Not for myself.

> The test run policy mechanisms we already have avoid
> this whole can of worms - we don't need to care about the specific
> test requirements of any specific test enviroment because the
> default is inclusive and it is trivial to exclude tests from that
> default set if needed.
>

I had the humble notion that we should make running fstests to
passing-by developers as easy as possible, because I have had the
chance to get feedback from some developers on their first time
attempt to run fstests and it wasn't pleasant, but nevermind.
-g auto -x soak is fine.

When you think about it, many fs developrs run ./check -g auto,
so we should not interfere with that, but I bet very few run './check'?
so we could make the default for './check' some group combination
that is as deterministic as possible.

If I am not mistaken, LTP main run script runltp.sh when run w/o
parameters has a default set of tests which obviously get run by the
kernel bots.

Thanks,
Amir.

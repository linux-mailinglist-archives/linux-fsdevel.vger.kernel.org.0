Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD4D568F47
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 18:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiGFQgK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jul 2022 12:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiGFQgJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:36:09 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7594167FA;
        Wed,  6 Jul 2022 09:36:08 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id 185so4484092vse.6;
        Wed, 06 Jul 2022 09:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i90W+nmLcKJiuU8nDMzMQhv3WUqAkvxIUgvsvqlvC6U=;
        b=KPNStwzU/WUz8HJuvH6zB5FOFwhfyrHw157f4JuCebX99xVsLG2D3r0EaGasjTsEIp
         dt22OVbgVNAnmd4KZTwrjo0eL7eWxNMP+JqC2HFYebenNlt2kZk8q922mKIhIarw+E1s
         FkbOKXj+UmQaIXlW/80q+PrUDiNSXcfCgLY0zg+UC078LCu83gNsB/xzW67w0rjCy7w5
         q1IEsyVfcGpATahCBDwkVsb9k2zxzXIetOtrLhCiLcQy7qytvPKe1lijppv3WKn0+ccE
         5q/g6tig6VLKXPQ6aQVGA7ZmpuxyR2WMLAfkpMA+gJ9FNT96N0wa788BzlRflsGBc6/Z
         uTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i90W+nmLcKJiuU8nDMzMQhv3WUqAkvxIUgvsvqlvC6U=;
        b=APzz891kkyuV29vcjOYyGh0o3sMsguO/c09gVZQ+b+FjdW6SrhC2Eo3JrabSPOouXu
         j7pg9YLEq4ComyeuhcsljtTfhoeBNQ1WJKwNySdN2tt+entpKuHnqgBEDDhc8WSkeuAw
         agZJUjnkVpBpvaBD9Z7NIV5Q4PhEEqRyIut88tnSPHJbQlFfW1tWxAteYojH03FmbQSz
         GZwrQ5ORvxRJCqyGFu6wfSj/yzv9HWxF7ZB7NadiCQkh7xAHJcdC7YfDdVYsIRRD1vxi
         DigtgRm7ZtOD981eU4xNw2UXn69MovJ7HUwL9WmsJDtEt9Uaqq5TK/yd7m2PSaRZAK+D
         4Ibw==
X-Gm-Message-State: AJIora+Nr7bCQB/rsqmLfJvEmyBbdRs4w1JwLzk/a04yBKi69N+2D/Iz
        0pjIMJ6fHYxkyTu4q227LIj2TCjpko2hRPQeP+g=
X-Google-Smtp-Source: AGRyM1tnkW4IeW9/81uz5P8pCuI6gW/bkVVSiVtYR6lE5LkenQueOcwH2XjlXBeSNYieDiA5VxWGQ38uYgVTERyOyHw=
X-Received: by 2002:a67:e0c6:0:b0:357:1264:f63d with SMTP id
 m6-20020a67e0c6000000b003571264f63dmr2236451vsl.36.1657125367974; Wed, 06 Jul
 2022 09:36:07 -0700 (PDT)
MIME-Version: 1.0
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org> <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
 <CAOQ4uxgBtMifsNt1SDA0tz098Rt7Km6MAaNgfCeW=s=FPLtpCQ@mail.gmail.com>
 <20220704032516.GC3237952@dread.disaster.area> <CAOQ4uxj5wabQvsGELS7t_Z9Z4Z2ZUHAR8d+LBao89ANErwZ95g@mail.gmail.com>
 <20220705031133.GD3237952@dread.disaster.area> <CAOQ4uxi2rBGqmtXghFJ+frDORETum+4KOKEg0oeX-woPXLNxTw@mail.gmail.com>
 <YsWcZbBALgWKS88+@mit.edu>
In-Reply-To: <YsWcZbBALgWKS88+@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 6 Jul 2022 19:35:57 +0300
Message-ID: <CAOQ4uxgr8v=h1xi=sfJD9uSp6DR_iAiXScd68Ov7=6Cm-iA+ZA@mail.gmail.com>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for expunges
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
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

On Wed, Jul 6, 2022 at 5:30 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Wed, Jul 06, 2022 at 01:11:16PM +0300, Amir Goldstein wrote:
> >
> > So I am wondering what is the status today, because I rarely
> > see fstests failure reports from kernel test bot on the list, but there
> > are some reports.
> >
> > Does anybody have a clue what hw/fs/config/group of fstests
> > kernel test bot is running on linux-next?
>
> Te zero-day test bot only reports test regressions.  So they have some
> list of tests that have failed in the past, and they only report *new*
> test failures.  This is not just true for fstests, but it's also true
> for things like check and compiler warnings warnings --- and I suspect
> it's for those sorts of reports that caused the zero-day bot to keep
> state, and to filter out test failures and/or check warnings and/or
> compiler warnings, so that only new test failures and/or new compiler
> warnigns are reported.  If they didn't, they would be spamming kernel
> developers, and given how.... "kind and understanding" kernel
> developers are at getting spammed, especially when sometimes the
> complaints are bogus ones (either test bugs or compiler bugs), my
> guess is that they did the filtering out of sheer self-defense.  It
> certainly wasn't something requested by a file system developer as far
> as I know.
>
>
> So this is how I think an automated system for "drive-by testers"
> should work.  First, the tester would specify the baseline/origin tag,
> and the testing system would run the tests on the baseline once.
> Hopefully, the test runner already has exclude files so that kernel
> bugs that cause an immediate kernel crash or deadlock would be already
> be in the exclude list.  But as I've discovered this weekend, for file
> systems that I haven't tried in a few yeas, like udf, or
> ubifs. etc. there may be missing tests that result in the test VM to
> stop responding and/or crash.
>
> I have a planned improvement where if you are using the gce-xfstests's
> lightweight test manager, since the LTM is constantly reading the
> serial console, a deadlock can be detected and the LTM can restart the
> VM.  The VM can then disambiguate from a forced reboot caused by the
> LTM, or a forced shutdown caused by the use of a preemptible VM (a
> planned feature not yet fully implemented yet), and the test runner
> can skip the tests already run, and skip the test which caused the
> crash or deadlock, and this could be reported so that eventually, the
> test could be added to the exclude file to benefit thouse people who
> are using kvm-xfstests.  (This is an example of a planned improvement
> in xfstests-bld which if someone is interested in helping to implement
> it, they should give me a ring.)
>
> Once the tests which are failing given a particular baseline are
> known, this state would then get saved, and then now the tests can be
> run on the drive-by developer's changes.  We can now compare the known
> failures for the baseline, with the changed kernels, and if there are
> any new failures, there are two possibilities: (a) this was a new
> feailure caused by the drive-by developer's changes, (b) this was a
> pre-existing known flake.
>
> To disambiguate between these two cases, we now run the failed test N
> times (where N is probably something like 10-50 times; I normally use
> 25 times) on the changed kernel, and get the failure rate.  If the
> failure rate is 100%, then this is almost certainly (a).  If the
> failure rate is < 100% (and greater than 0%), then we need to rerun
> the failed test on the baseline kernel N times, and see if the failure
> rate is 0%, then we should do a bisection search to determine the
> guilty commit.
>
> If the failure rate is 0%, then this is either an extremely rare
> flake, in which case we might need to increase N --- or it's an
> example of a test failure which is sensitive to the order of tests
> which are failed, in which case we may need to reun all of the tests
> in order up to the failed test.
>
> This is right now what I do when processing patches for upstream.
> It's also rather similar to what we're doing for the XFS stable
> backports, because it's much more efficient than running the baseline
> tests 100 times (which can take a week of continuous testing per
> Luis's comments) --- we only tests dozens (or more) times where a
> potential flake has been found, as opposed to *all* tests.  It's all
> done manually, but it would be great if we could automate this to make
> life easier for XFS stable backporters, and *also* for drive-by
> developers.
>

This process sounds like it could get us to mostly unattended regression
testing, so it sounds good.

I do wonder if there is nothing more that fstests devlopers can do to
assist when annotating new (and existing) tests to aid in that effort.

For example, there might be a case to tag a test as "this is a very
reliable test that should have no failures at all - if there is a failure
then something is surely wrong".
I wonder if it would help to have a group like that and how many
tests would that group include.

> And again, if anyone is interested in helping with this, especially if
> you're familiar with shell, python 3, and/or the Go language, please
> contact me off-line.
>

Please keep me in the loop if you have a prototype I may be able
to help test it.

Thanks,
Amir.

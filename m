Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAF6564554
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 07:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiGCF5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 01:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGCF5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 01:57:08 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D2B635C;
        Sat,  2 Jul 2022 22:57:07 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id w187so6134945vsb.1;
        Sat, 02 Jul 2022 22:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S09EmHyul/XlTGMMFg0S5sr547tyBYiGoQ4G8XzTNcI=;
        b=ddINMmdAPrBQ66IZHifncJZbP+UcQiW7L/OYWGGvmDNZH4IEFt4XTLbAkliUAs5/N+
         0YvwesqIn0cN9U8oaOX7J29t7/go35LyZWnbCmMVtReMixfQPcPDcXW4GQCmPs25xWeN
         MOl5i+h83ZjwLVYoJ6e9gi1aTl+hw1ufA+PFGAsDXkrTHt9tYT/ZSW3jhNvrGNt10rZm
         cRn8L1Dt6+Qp+Hlusfu/UbYY0/avVy0DkJEkbO+LAuiDijNAlvczNO67x8JYDvWJ0UUN
         ZE77P4pJUVJBgs/8AagbpVojikLyV4lInQQikeOhpFs4GyH/gB6lFwgIAtb4rcDtddZR
         nx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S09EmHyul/XlTGMMFg0S5sr547tyBYiGoQ4G8XzTNcI=;
        b=Q3jYSUkTeVdGwK5BJ+V1i0qU/vm0pOHw79HvJQ95Xly4L9Av52gT0TkyE/wg81/iSh
         tKMGGyWPBCmmWqB3KBHBp8Kqxf68QLmZ2KgIfpnTKdSh3EZOn6CMP6dO6Garh+jS4Ttr
         w6nUZyvT96xHEYSgkQJm9KSSyNRg3V69II0d51pmuJjkUHR+tFy/7YtuYV3f/maWC8f2
         mIGbZPzlgbrK0ANMObaEYcSSExj9x9MmX1qNswYIaMU/8HD46NYtsDwNfKrM/SR6AIz/
         HpAJ5FHXik+NjFXsVme5C1tdlqmlw5ZJuSIgRWsq4HjfIMzmN8N8OEFdHylEfPT2epul
         N/IQ==
X-Gm-Message-State: AJIora8cLuIS0cGAUOMjezHHzv17sPErGBdDxcQ/emP4JIPBhSFVX5/i
        9uz1cPSeE6m1NQhUGqLgBY1uPd5v2M3eBS9jdWk=
X-Google-Smtp-Source: AGRyM1tn8NLjJQpQ8hpfGDpoOVBmFOazVY52hM8TqvGWp/ZGkht9NeNFbBfVPOD7UgaiXvL6gEGW/PI/Raf5gZDorqk=
X-Received: by 2002:a05:6102:38c7:b0:356:4e2f:ae5b with SMTP id
 k7-20020a05610238c700b003564e2fae5bmr14281202vst.71.1656827826320; Sat, 02
 Jul 2022 22:57:06 -0700 (PDT)
MIME-Version: 1.0
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org> <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
In-Reply-To: <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 3 Jul 2022 08:56:54 +0300
Message-ID: <CAOQ4uxgBtMifsNt1SDA0tz098Rt7Km6MAaNgfCeW=s=FPLtpCQ@mail.gmail.com>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for expunges
To:     Bart Van Assche <bvanassche@acm.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Theodore Tso <tytso@mit.edu>,
        Josef Bacik <josef@toxicpanda.com>, jmeneghi@redhat.com,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Jake Edge <jake@lwn.net>, Klaus Jensen <its@irrelevant.dk>,
        fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>
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

On Sun, Jul 3, 2022 at 12:48 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 5/18/22 20:07, Luis Chamberlain wrote:
> > I've been promoting the idea that running fstests once is nice,
> > but things get interesting if you try to run fstests multiple
> > times until a failure is found. It turns out at least kdevops has
> > found tests which fail with a failure rate of typically 1/2 to
> > 1/30 average failure rate. That is 1/2 means a failure can happen
> > 50% of the time, whereas 1/30 means it takes 30 runs to find the
> > failure.
> >
> > I have tried my best to annotate failure rates when I know what
> > they might be on the test expunge list, as an example:
> >
> > workflows/fstests/expunges/5.17.0-rc7/xfs/unassigned/xfs_reflink.txt:generic/530 # failure rate about 1/15 https://gist.github.com/mcgrof/4129074db592c170e6bf748aa11d783d
> >
> > The term "failure rate 1/15" is 16 characters long, so I'd like
> > to propose to standardize a way to represent this. How about
> >
> > generic/530 # F:1/15
> >
> > Then we could extend the definition. F being current estimate, and this
> > can be just how long it took to find the first failure. A more valuable
> > figure would be failure rate avarage, so running the test multiple
> > times, say 10, to see what the failure rate is and then averaging the
> > failure out. So this could be a more accurate representation. For this
> > how about:
> >
> > generic/530 # FA:1/15
> >
> > This would mean on average there failure rate has been found to be about
> > 1/15, and this was determined based on 10 runs.
> >
> > We should also go extend check for fstests/blktests to run a test
> > until a failure is found and report back the number of successes.
> >
> > Thoughts?
> >
> > Note: yes failure rates lower than 1/100 do exist but they are rare
> > creatures. I love them though as my experience shows so far that they
> > uncover hidden bones in the closet, and they they make take months and
> > a lot of eyeballs to resolve.
>
> I strongly disagree with annotating tests with failure rates. My opinion
> is that on a given test setup a test either should pass 100% of the time
> or fail 100% of the time. If a test passes in one run and fails in
> another run that either indicates a bug in the test or a bug in the
> software that is being tested. Examples of behaviors that can cause
> tests to behave unpredictably are use-after-free bugs and race
> conditions. How likely it is to trigger such behavior depends on a
> number of factors. This could even depend on external factors like which
> network packets are received from other systems. I do not expect that
> flaky tests have an exact failure rate. Hence my opinion that flaky
> tests are not useful and also that it is not useful to annotate flaky
> tests with a failure rate. If a test is flaky I think that the root
> cause of the flakiness must be determined and fixed.
>

That is true for some use cases, but unfortunately, the flaky
fstests are way too valuable and too hard to replace or improve,
so practically, fs developers have to run them, but not everyone does.

Zorro has already proposed to properly tag the non deterministic tests
with a specific group and I think there is really no other solution.

The only question is whether we remove them from the 'auto' group
(I think we should).

There is probably a large overlap already between the 'stress' 'soak' and
'fuzzers' test groups and the non-deterministic tests.
Moreover, if the test is not a stress/fuzzer test and it is not deterministic
then the test is likely buggy.

There is only one 'stress' test not in 'auto' group (generic/019), only two
'soak' tests not in the 'auto' group (generic/52{1,2}).
There are only three tests in 'soak' group and they are also exactly
the same three tests in the 'long_rw' group.

So instead of thinking up a new 'flaky' 'random' 'stochastic' name
we may just repurpose the 'soak' group for this matter and start
moving known flaky tests from 'auto' to 'soak'.

generic/52{1,2} can be removed from 'soak' group and remain
in 'long_rw' group, unless filesystem developers would like to
add those to the stochastic test run.

filesystem developers that will run ./check -g auto -g soak
will get the exact same test coverage as today's -g auto
and the "commoners" that run ./check -g auto will enjoy blissful
determitic test results, at least for the default config of regularly
tested filesystems (a.k.a, the ones tested by kernet test bot).?

Darrick,

As the one who created the 'soak' group and only one that added
tests to it, what do you think about this proposal?
What do you think should be done with generic/52{1,2}?

Thanks,
Amir.

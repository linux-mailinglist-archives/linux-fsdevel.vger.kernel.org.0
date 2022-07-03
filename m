Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA8F564807
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 16:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiGCOWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 10:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiGCOWa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 10:22:30 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFD12DF0;
        Sun,  3 Jul 2022 07:22:29 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id 189so6766673vsh.2;
        Sun, 03 Jul 2022 07:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/pAsz4QfzaFjXy7Vy118iqtoQ+29CHgJNrEY4mVAeMs=;
        b=Nh4ZuoP7+jlqimG7xuP9QDOT3P+pZ0AORLfMyRP9QfxV6uUBEi2Wyb+upqAIoGcQ2b
         Ju27gFx9zznRQiOZ5L0lB+0Ip2xVBSblWDcMDfUR4UN4NKrHMj69V+djgYE89quYkRXu
         6N58/qUZSHzYMIxFPr666VfANsDzWg/wSVj2i1mAdiNyfPFAdkZpyX6eCIU9tSMsabKc
         euSH9b0kE0pHZ1UjpTFqQQxMZAdQzARSmkFZvkLUEZQ3aAphHX/RHjnjk5beRoqNj+Nq
         6LFfCkOz9/nZqaeaWCjvq4ycUK2tRihXYDVzyTLoqq33A1F+S6t0xgtT1CXoieEzIsph
         5I2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/pAsz4QfzaFjXy7Vy118iqtoQ+29CHgJNrEY4mVAeMs=;
        b=7pWK65UQVoYKk6X87jfsR+y1DlbRe8x7tVDcIsmywfJIm4kSkN2+nVLmYE6fKNeUbI
         2o/AXRjlFcNbeDlSWVyGAjzkdFJW5pFrHzlHazB/xptwQzb9b8dAGtUtQbLwvWhvR1Tx
         xoI4c/OWKuAlo/ebOC37dYlx+Lt90k/qNBI1RnIEnjOv4gffUrofpMFC1RI7IlHCapm8
         /cD8SFXQ4A0dR1oU7sDQWzqnZbxHg0xo1b9DLVMOtvyzHx4OuzCwM4KapIEJq3ctRH6j
         AgKMxPnhesvCEmrW3LcRAuQUick4So6qyBalGAXfNnJ3OX8pJyMO/Ntz30pjiTB7pNL/
         a/gg==
X-Gm-Message-State: AJIora9fUDd6LEebbZUOcyVAsT1tsoDHPFi34wTaaSAD2oLbRZLjHkoc
        zF9KHb/QJgiWByP72OMmdbB6A1RLN36/pj+vF9MnYmm9+fOmDw==
X-Google-Smtp-Source: AGRyM1uEQOOUY3fdKlv0RswYlo+lPv9RHJzpSQ7EWV/O9/ofrLJhjT1A2qw5B08eafr6LkY6PkX1GBSymq/wC6C7vQQ=
X-Received: by 2002:a05:6102:5dc:b0:354:63f1:df8d with SMTP id
 v28-20020a05610205dc00b0035463f1df8dmr14550839vsf.72.1656858148774; Sun, 03
 Jul 2022 07:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <YoW0ZC+zM27Pi0Us@bombadil.infradead.org> <a120fb86-5a08-230f-33ee-1cb47381fff1@acm.org>
 <CAOQ4uxgBtMifsNt1SDA0tz098Rt7Km6MAaNgfCeW=s=FPLtpCQ@mail.gmail.com> <YsGWb8nPUySuhos/@mit.edu>
In-Reply-To: <YsGWb8nPUySuhos/@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 3 Jul 2022 17:22:17 +0300
Message-ID: <CAOQ4uxhEaVjk6rEnsnjWOKs+dygioXk-9h-WJjBzkJfe8U9eMQ@mail.gmail.com>
Subject: Re: [RFC: kdevops] Standardizing on failure rate nomenclature for expunges
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Bart Van Assche <bvanassche@acm.org>,
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

On Sun, Jul 3, 2022 at 4:15 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Sun, Jul 03, 2022 at 08:56:54AM +0300, Amir Goldstein wrote:
> >
> > That is true for some use cases, but unfortunately, the flaky
> > fstests are way too valuable and too hard to replace or improve,
> > so practically, fs developers have to run them, but not everyone does.
> >
> > Zorro has already proposed to properly tag the non deterministic tests
> > with a specific group and I think there is really no other solution.
>
> The non-deterministic tests are not the sole, or even the most likely
> cause of flaky tests.  Or put another way, even if we used a
> deterministic pseudo-random numberator seed for some of the curently
> "non-determinstic tests" (and I believe we are for many of them
> already anyway), it's not going to be make the flaky tests go away.
>
> That's because with many of these tests, we are running multiple
> threads either in the fstress or fsx, or in the antogonist workload
> that is say, running the space utilization to full to generate ENOSPC
> errors, and then deleting a bunch of files to trigger as many ENOSPC
> hitter events as possible.
>
> > The only question is whether we remove them from the 'auto' group
> > (I think we should).
>
> I wouldn't; if someone wants to exclude the non-determistic tests,
> once they are tagged as belonging to a group, they can just exclude
> that group.  So there's no point removing them from the auto group
> IMHO.

The reason I suggested that *we* change our habits is because
we want to give passing-by fs testers an easier experience.

Another argument in favor of splitting out -g soak from -g auto -
You only need to run -g soak in a loop for as long as you like to be
confident about the results.
You need to run -g auto only once per definition -
If a test ends up failing the Nth time you run -g auto then it belongs
in -g soak and not in -g auto.

>
> > filesystem developers that will run ./check -g auto -g soak
> > will get the exact same test coverage as today's -g auto
> > and the "commoners" that run ./check -g auto will enjoy blissful
> > determitic test results, at least for the default config of regularly
> > tested filesystems (a.k.a, the ones tested by kernet test bot).?
>
> First of all, there are a number of tests today which are in soak or
> long_rw which are not in auto, so "-g auto -g soak" will *not* result
> in the "exact same test coverage".

I addressed this in my proposal.
I proposed to remove these two tests out of soak and asked for
Darrick's opinion.
Who is using -g soak anyway?

>
> Secondly, as I've tested above, deterministic tests does not
> necessasrily mean determinsitic test results --- unless by
> "determinsitic tests" you mean "completely single-threaded tests",
> which would eliminate a large amount of useful test coverage.
>

To be clear, when I wrote deterministic, what I meant was deterministic
results empirically, in the same sense that Bart meant - a test should
always pass.

Because Luis was using the expunge lists to blacklist any test failure,
no matter the failure rate, the kdevops expunge lists could be used as
a first draft for -g soak group, at least for tests that are blocklisted by
kdevops for all of ext4,xfs and btrfs default configs on the upstream kernel.

Thanks,
Amir.

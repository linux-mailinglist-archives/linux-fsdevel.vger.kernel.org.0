Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64709345B4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 10:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhCWJry (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 05:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhCWJr1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:47:27 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2107CC061763
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 02:47:27 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id y19-20020a0568301d93b02901b9f88a238eso18851566oti.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Mar 2021 02:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgweAXsQTwePYGvzySvRrmFVPab8jCtXeq0art5Xlzk=;
        b=c83oOIai0vT/1Ehf7TwcWcfH05xGv8gE6Hg9fLoNtkbRowQEpsxj0F9qOqpyseVzcK
         Q2rN4vwz/CFe7+PkWFTwCUeAyxAT31qQdtAeXfXs01n2UBp+LZwJq3hVB4sDOKwEeXyR
         RY+Hh9E6NspuxTBUJKfL2OA81sVHSqqt5Ih+LGq0V/NDMZOHpPIdEUkuL1e0trb8yM8c
         7MXr4IjK5B1jHwhY2nXdhfqGP8wCPR558Pk6EKwP+ETOoUDB9HndX6hp3wvxdcp6S2U6
         vmFQM21beG3mVjRFHTyq/nWVtwXAuSm3IyGLEtPu8jHKd067xDHfseWi99DCjr/vRArs
         5Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgweAXsQTwePYGvzySvRrmFVPab8jCtXeq0art5Xlzk=;
        b=Lj+p70vLjapI4pjHDFmlQ6FaICorpeMSupO5BywzbEwSn0SsbZxyrIZFu8a+cMQzuO
         lq25QNEaE8EZNyYTigKKQgreeKTvG4pAXqvfnfxbzo0P7fdZU4cXznCXr3E72N8GAMsp
         YIvELr+o2QrZeQfQvHtUCyQF6hqJn7Z8q6jxvvy2yBSnpH8No3Y8rnyHUxYmo1dUU6d2
         wICa/ZZoLDq60B+AAyJLMqZL08k+sWOSJyXDXD5eEEP1LntjqnwDb6duF+Q2ddYsnnM1
         9HH55HP2W0OMk8ySUr1IogNKVRTG81Ry2225W1lL1RLVDGZdq5Imft+vCe+BIteIX6I3
         3lag==
X-Gm-Message-State: AOAM531GIBlk39/UITcNngve27+4IwSGlJmW6tQDVK7oLO5E2eMChU4+
        qlB/Ns8LSkZLlUDYQKPQOdBFJByHkm1xPd5kMB3hEA==
X-Google-Smtp-Source: ABdhPJzMH/VSfRK/jh3ZF5YMuSkaPYCGAs70cdgURS9L1MinkG75zqWL9g7656lDBjdloiRtfRfpIaLvWD9vkS5E3HU=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr3724534otq.251.1616492846280;
 Tue, 23 Mar 2021 02:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210310104139.679618-1-elver@google.com> <20210310104139.679618-9-elver@google.com>
 <YFiamKX+xYH2HJ4E@elver.google.com> <CAP-5=fW8NnLFbnK8UwLuYFzkwk6Yjvxv=LdOpE8qgXbyL6=CCg@mail.gmail.com>
In-Reply-To: <CAP-5=fW8NnLFbnK8UwLuYFzkwk6Yjvxv=LdOpE8qgXbyL6=CCg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 23 Mar 2021 10:47:13 +0100
Message-ID: <CANpmjNN6_jO5vK8fteJ7bEi1gM6Ho2kZxSq9avocM3A5TyFL=g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 8/8] selftests/perf: Add kselftest for remove_on_exec
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 23 Mar 2021 at 04:10, Ian Rogers <irogers@google.com> wrote:
> On Mon, Mar 22, 2021 at 6:24 AM Marco Elver <elver@google.com> wrote:
> > On Wed, Mar 10, 2021 at 11:41AM +0100, Marco Elver wrote:
> > > Add kselftest to test that remove_on_exec removes inherited events from
> > > child tasks.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > To make compatible with more recent libc, we'll need to fixup the tests
> > with the below.
> >
> > Also, I've seen that tools/perf/tests exists, however it seems to be
> > primarily about perf-tool related tests. Is this correct?
> >
> > I'd propose to keep these purely kernel ABI related tests separate, and
> > that way we can also make use of the kselftests framework which will
> > also integrate into various CI systems such as kernelci.org.
>
> Perhaps there is a way to have both? Having the perf tool spot an
> errant kernel feels like a feature. There are also
> tools/lib/perf/tests and Vince Weaver's tests [1]. It is possible to
> run standalone tests from within perf test by having them be executed
> by a shell test.

Thanks for the pointers. Sure, I'd support more additional tests.

But I had another look and it seems the tests in
tools/{perf,lib/perf}/tests do focus on perf-tool or the library
respectively, so adding kernel ABI tests there feels wrong. (If
perf-tool somehow finds use for sigtrap, or remove_on_exec, then
having a perf-tool specific test for those would make sense again.)

The tests at [1] do seem relevant, and its test strategy seems more
extensive, including testing older kernels. Unfortunately it is
out-of-tree, but that's probably because it was started before
kselftest came into existence. But there are probably things that [1]
contains that are not appropriate in-tree.

It's all a bit confusing.

Going forward, if you insist on tests being also added to [1], we can
perhaps mirror some of the kselftest tests there. There's also a
logistical problem with the tests added here, because the tests
require an up-to-date siginfo_t, and they use the kernel's
<asm/siginfo.h> with some trickery. Until libc's siginfo_t is updated,
it probably doesn't make sense to add these tests to [1].

The other question is, would it be possible to also copy some of the
tests in [1] and convert to kselftest, so that they live in-tree and
are tested regularly (CI, ...)?

Because I'd much prefer in-tree tests with little boilerplate, that
are structured with parsable output; in the kernel we have the
kselftest framework for tests with a user space component, and KUnit
for pure in-kernel tests.

Thanks,
-- Marco

> Thanks,
> Ian
>
> [1] https://github.com/deater/perf_event_tests
[...]

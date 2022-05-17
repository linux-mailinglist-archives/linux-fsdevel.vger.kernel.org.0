Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995A452AD23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 22:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245104AbiEQU6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 16:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236107AbiEQU6Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 16:58:24 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFAA4838C
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 13:58:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f9so103029ejc.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 13:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wG//9LUlNxX10FI60aAD9TW4A6u0+UVzKTFUfna9EcM=;
        b=AxBMNTbcHtmh4XBZsbTZkYEST7SubuiZ7mqjxOZOiMHXh43ts9yox8tTHJ+1hVeBIN
         lY4fIhS+/lSj1st458hrZs6h5UyhayvPYCMRsR5CUSJGFGJ4JieKWcr5QD11SAurNEZw
         XbaC58/XduEvKMk/yRYy0ERGkk6fE3d1ghzgCC0GhJVlhkZwQN5Ssx3QyOM8OYzflvEO
         /RCBr0tVf2zPpkxY+sbZIfqK6likvHV1Dw4IzxHuady9FzE6y39pk3MRhizDmY4m8w0w
         BfL2pSY84wMy/v9UJeBFzF5P3fmLp+DXF9hTrL+jC2wUiElYRRm7ExC0URvxQsbfIJ+I
         WzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wG//9LUlNxX10FI60aAD9TW4A6u0+UVzKTFUfna9EcM=;
        b=wdHL+La4NGzfRhqyotlRkdmCOkLBBYtDwBKxBFuk20crC3d3Tg6/fx2n+EpsH7CMFT
         3D2yLPMC3Cl1St5AVGRJTYYynCwH8Yk5ENyHz/d99+pt3ws4Thv5SBJ8kdwLHC2kckR4
         dHu92vEG167i2IGoVFi0djmZ+vkJBl6lZGjv1vJ+poX+TNFjZHmbMAeFhVsnUKuPWsax
         h8d8JWcqkbgGGPsPkhOlPjz16U8OnaED35g9U/J8WEL4CZe5QaTVp54S90DE7TGUaOfa
         4GZgLdvm4H+SxJU2OVOfB4vCpm8cAStEq1Cw9FLLih/QV0hOUg7jvbJ83hPXuMB10ypm
         m/FQ==
X-Gm-Message-State: AOAM532BbqUIsXTx3tx1lrWAq2bp3EMs6L09BcXe7+AT/5AGO+BSY7bg
        aPpko2SOC3a5CExL4OHAJgZexDXtMlZSvM+zdIUXWQ==
X-Google-Smtp-Source: ABdhPJzIamuR1/kdHQioWL/LbryCYzlRAz8brhzkGJnKiTbrFbAryR+D9resD6kTTvU0KeuWD2VCw5Yxttr6yNiHuvQ=
X-Received: by 2002:a17:907:1c89:b0:6f4:4089:8256 with SMTP id
 nb9-20020a1709071c8900b006f440898256mr20638205ejc.60.1652821100668; Tue, 17
 May 2022 13:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com> <20220513083212.3537869-2-davidgow@google.com>
 <CAGS_qxr54nYThsj6UhqX54JO5WnyJXVQURnNF1eCzGB+4GCKLA@mail.gmail.com>
 <CABVgOS=gTznLFBTZbmNH7AFDnr7O70mWR9v4q6sDA7q04fKT=Q@mail.gmail.com> <CAGS_qxqFEcw=28FxbMMtEcjqcsgFHXV6Td+uTgDj32Z=PiQJkA@mail.gmail.com>
In-Reply-To: <CAGS_qxqFEcw=28FxbMMtEcjqcsgFHXV6Td+uTgDj32Z=PiQJkA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 17 May 2022 16:58:09 -0400
Message-ID: <CAFd5g45MCdydiLtn_UHku8d9-RMurLS+ep3fwZTuBafABpFrPw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kunit: Taint the kernel when KUnit tests are run
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 14, 2022 at 3:25 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Fri, May 13, 2022 at 8:04 PM David Gow <davidgow@google.com> wrote:
> > Hmm... thinking about it, I think it might be worth not tainting if 0
> > suites run, but tainting if 0 tests run.
> >
> > If we taint even if there are no suites present, that'll make things
> > awkward for the "build KUnit in, but not any tests" case: the kernel
> > would be tainted regardless. Given Android might be having the KUnit
>
> Actually, this is what the code does right now. I was wrong.
> If there are 0 suites => not tainted.
> If there are 0 tests in the suites => tainted.
>
> For kunit being built in, it first goes through this func
>    206  static void kunit_exec_run_tests(struct suite_set *suite_set)
>    207  {
>    208          struct kunit_suite * const * const *suites;
>    209
>    210          kunit_print_tap_header(suite_set);
>    211
>    212          for (suites = suite_set->start; suites <
> suite_set->end; suites++)
>    213                  __kunit_test_suites_init(*suites);
>    214  }
>
> So for the "build KUnit in, but not any tests" case, you'll never
> enter that for-loop.
> Thus you'll never call __kunit_test_suites_init() => kunit_run_tests().
>
> For module-based tests, we have the same behavior.
> If there's 0 test suites, we never enter the second loop, so we never taint.
> But if there's >0 suites, then we will, regardless of the # of test cases.
>
>    570  int __kunit_test_suites_init(struct kunit_suite * const * const suites)
>    571  {
>    572          unsigned int i;
>    573
>    574          for (i = 0; suites[i] != NULL; i++) {
>    575                  kunit_init_suite(suites[i]);
>    576                  kunit_run_tests(suites[i]);
>    577          }
>    578          return 0;
>    579  }
>
> So this change should already work as intended.
>
> > execution stuff built-in (but using modules for tests), it's probably
> > worth not tainting there. (Though I think they have a separate way of
> > disabling KUnit as well, so it's probably not a complete
> > deal-breaker).
> >
> > The case of having suites but no tests should still taint the kernel,
> > as suite_init functions could still run.
>
> Yes, suite_init functions are the concern. I agree we should taint if
> there are >0 suites but 0 test cases.
>
> I don't think it's worth trying to be fancy and tainting iff there >0
> test cases or a suite_init/exit function ran.
>
> >
> > Assuming that seems sensible, I'll send out a v4 with that changed.
>
> Just to be clear: that shouldn't be necessary.

Agreed. I think the current behavior is acceptable, and should be
unobtrusive to Android: Joe has a patch that introduces a kernel param
which disables running KUnit tests at the suite level which would
happen before this taint occurs. So the only way the taint happens is
if we actually try to execute some test cases (whether or not the
cases actually run).

> > > I wasn't quite sure where this applied, but I manually applied the changes here.
> > > Without this patch, this command exits fine:
> > > $ ./tools/testing/kunit/kunit.py run --kernel_args=panic_on_taint=0x40000
> > >
> > > With it, I get
> > > [12:03:31] Kernel panic - not syncing: panic_on_taint set ...
> > > [12:03:31] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N
> >
> > This is showing both 'G' and 'N' ('G' being the character for GPL --
>
> I just somehow missed the fact there was an 'N' at the end there.
> Thanks, I thought I was going crazy. I guess I was just going blind.
>
>
> Daniel

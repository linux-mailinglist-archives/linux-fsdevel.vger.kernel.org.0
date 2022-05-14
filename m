Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB60B526E75
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 09:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbiENDEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 23:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiENDEp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 23:04:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5702E0D33
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 20:04:40 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso7866434wma.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 May 2022 20:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UoAT8pjpOFcRyIaX+ZhbsdRFzNEAyY56dcHcgCnxySo=;
        b=edjiyqrDP2iLrGQci5HqJboHVDFmTJ/F0cVt2hEhqmcmZ1Bk3naqPevsH50aZD4bgL
         uBgAhlV9Rj0RBJ56NenEvJKuGc6772MbvBrXXNbzVOP+EC1sBTEu+10lN8/8axj7fG1N
         vk97VTRaDsfr5aMeV0pBT5JNUKtnKH5L6QaFyXYcbvuHq5NHIerSyN4yyEtubLhbHgUj
         IIBX/JBXVmbeHvA8pLO/5tUmzYZ2pkRoQwfskzITXr4dHOmkfxhcL42inxRIGVbqhEe7
         iQc1vYNPhvt+x0PWly/ZBGnxlxc2VJ/wpp56ADg9gnyrloSquEsApgEvgYEUFNnORcv/
         Ll4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UoAT8pjpOFcRyIaX+ZhbsdRFzNEAyY56dcHcgCnxySo=;
        b=L1bUjrvGzFIJwIk/J6x7gVADr9yB41AFK5WlzptcATZhHnLYETSivof4M4RjyaK3cl
         CSYwFregDwUmXGVmkx5X3FCQlSuO1vTuo8XkvvrlwN/o8gIEyIU2cgqOtcmh1rXG5WWU
         pl//evAHtPF6ijBPZ/uSPq1gZMvzB2yCTNFma2koSg03Jtfw/3QSYxQsd9LGecD5Ris6
         PomS6/BEQOtKNq3HTiUtlcFqqj0OOtldnS/gyAJXK+OglVjYTPXDPK61ufpU6QlbKHZv
         xgSMpAI6oX21F+eh/WqNXeeslcWfyHlXmAyNQSCVW3pVQeN91thuj7wY06JOH7tGCug8
         vtFQ==
X-Gm-Message-State: AOAM530lS1ochZev0DE7zFXxVRT+YDNdwskEUoXcRfABr4rJ3IBABVOl
        byJuvPjZjxMd5WUjnmKgKi/Nfa3M9ixcQAAhFFchNA==
X-Google-Smtp-Source: ABdhPJyqMTuCvPq2xupVijryWNy90M9KW5CbLPjYdKU/0lgqe+OXIfvdq3TgEH84h6n59TOZr0qbmIWNpw3XU3CMz+w=
X-Received: by 2002:a05:600c:264e:b0:394:2c56:eeb5 with SMTP id
 14-20020a05600c264e00b003942c56eeb5mr7208280wmy.6.1652497479045; Fri, 13 May
 2022 20:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220429043913.626647-1-davidgow@google.com> <20220513083212.3537869-2-davidgow@google.com>
 <CAGS_qxr54nYThsj6UhqX54JO5WnyJXVQURnNF1eCzGB+4GCKLA@mail.gmail.com>
In-Reply-To: <CAGS_qxr54nYThsj6UhqX54JO5WnyJXVQURnNF1eCzGB+4GCKLA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 14 May 2022 11:04:27 +0800
Message-ID: <CABVgOS=gTznLFBTZbmNH7AFDnr7O70mWR9v4q6sDA7q04fKT=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] kunit: Taint the kernel when KUnit tests are run
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
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

On Sat, May 14, 2022 at 3:09 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Fri, May 13, 2022 at 1:32 AM David Gow <davidgow@google.com> wrote:
> >
> > Make KUnit trigger the new TAINT_TEST taint when any KUnit test is run.
> > Due to KUnit tests not being intended to run on production systems, and
> > potentially causing problems (or security issues like leaking kernel
> > addresses), the kernel's state should not be considered safe for
> > production use after KUnit tests are run.
> >
> > Signed-off-by: David Gow <davidgow@google.com>
>
> Tested-by: Daniel Latypov <dlatypov@google.com>
>
> Looks good to me.
>
> There's an edge case where we might have 0 suites or 0 tests and we
> still taint the kernel, but I don't think we need to deal with that.
> At the start of kunit_run_tests() is the cleanest place to do this.

Hmm... thinking about it, I think it might be worth not tainting if 0
suites run, but tainting if 0 tests run.

If we taint even if there are no suites present, that'll make things
awkward for the "build KUnit in, but not any tests" case: the kernel
would be tainted regardless. Given Android might be having the KUnit
execution stuff built-in (but using modules for tests), it's probably
worth not tainting there. (Though I think they have a separate way of
disabling KUnit as well, so it's probably not a complete
deal-breaker).

The case of having suites but no tests should still taint the kernel,
as suite_init functions could still run.

Assuming that seems sensible, I'll send out a v4 with that changed.

> I wasn't quite sure where this applied, but I manually applied the changes here.
> Without this patch, this command exits fine:
> $ ./tools/testing/kunit/kunit.py run --kernel_args=panic_on_taint=0x40000
>
> With it, I get
> [12:03:31] Kernel panic - not syncing: panic_on_taint set ...
> [12:03:31] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N

This is showing both 'G' and 'N' ('G' being the character for GPL --
i.e. the kernel is not tainted by proprietary modules: 'P').

Jani did suggest a better way of printing these in the v1 discussion
(printing the actual names of taints present), which I might do in a
follow-up.

> 5.17.0-00001-gea9ee5e7aed8-dirty #60
>
> I'm a bit surprised that it prints 'G' and not 'N', but this does seem
> to be the right mask
> $ python3 -c 'print(hex(1<<18))'
> 0x40000
> and it only takes effect when this patch is applied.
> I'll chalk that up to my ignorance of how taint works.

-- David

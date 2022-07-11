Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C02570E10
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jul 2022 01:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiGKXPp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jul 2022 19:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiGKXPn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jul 2022 19:15:43 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2958735A
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 16:15:42 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 136so11212612ybl.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Jul 2022 16:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ZvoNrrFE3nmN7+wVapurCnBu267yWOoQYKYwm2cZlA=;
        b=h8DT22+wyNOULS4PEbbruwv3a1Q9EfxNbIhiIbhn8IsCxwXCugztDCZt4aXB5+uKpN
         i+xlpK84BAxiJQJe8rtnCbxrzwdjOPexodrhYRuLJHcft08Pt3q9LWOUFj33isPZM8OG
         sL0McsoxzhkVCxGHUbaDxOk/rie/TecBPLIYT7Rj90gO4atNc00hTgnLRMXi65d6/rgw
         xYmz1vdFuYfjvK9EDognJsm9m4kSgrWC2J+IyMpU8F7XoOOgVJiXBZhf2lokwhxv7XVF
         sToTs4rGW/lTcVAS5JMqE6iwMMayB/noPDwC/ke6PjNdFxt7uxMoCW5y41vKEP9bqK2n
         8e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ZvoNrrFE3nmN7+wVapurCnBu267yWOoQYKYwm2cZlA=;
        b=U5A0tdCHlOj21WTDBJftOEr4cpSLoYT89EVqjIjm05VFJlYB7t/Iy3fWgAk0BK+6Vz
         fXV3HJAjRm9udoTZYrWH+4kWAJEatAoJDNNiyIS4ZV6Qu8SG/CQAAbDAFEuQIw3Shd3a
         5MjeXIWK7JBHT1LqVRC+b5x/PWWM1LWF8YvrYc5yE6LDbt7JWNMBu8hAKaZDS4h4OOf8
         Dwe2WF94plbAu2WJdTnqLFiHnw8gG4I3Q5UW8Tg4Flme/pf9pxAKg1XXQfILVw3M9+Kf
         k5OaX5INWBP1brykiT1p0hUfKf3cZReAorXdZFVp4LhHQXsWauUdGSWOLbrjgpcSKnWv
         Lxug==
X-Gm-Message-State: AJIora/q9KV/+4bw8Wu8zed5zNjPGFgTaTpX56K2/7QcVgFHWbXOEP1S
        xTxsnU+bCkD86plWB7YYKS1+x3n0Mj1Jeop/BVuU0w==
X-Google-Smtp-Source: AGRyM1sNriE+i2iOsMQUz8LcFB7VN+nenZ8+7T7fgkdvZ66sbrVYCEI8HVMMnMGX6jzX4rNdbiE1FVjCtgbXzcYRBEA=
X-Received: by 2002:a25:cfd0:0:b0:66e:b731:7954 with SMTP id
 f199-20020a25cfd0000000b0066eb7317954mr20007259ybg.396.1657581341375; Mon, 11
 Jul 2022 16:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220616211016.4037482-1-dylanbhatch@google.com>
 <941e0991-eb3e-f988-8262-3d51ff8badad@linuxfoundation.org>
 <CADBMgpwt2ALzBTtEm7v6DLL_9pjUhVLDpBLHXn1b0bvVf2BSvg@mail.gmail.com>
 <47312e8a-87fe-c7dc-d354-74e81482bc1e@linuxfoundation.org>
 <CADBMgpx9hwHaWe=m2kQhKOJFWnLSejoWa6wz1VECEkLhWq4qog@mail.gmail.com>
 <a5f46e4e-a472-77ce-f61e-b2f9922bdd50@linuxfoundation.org>
 <CADBMgpzyOKVO1ju_WkxYLhXGvwJjHoL6V-+Nw49UdTFoPY7NvQ@mail.gmail.com>
 <b48cc574-302c-e74f-0720-9912f4663cbe@linuxfoundation.org> <CADBMgpz3z_hB_5BVVD5-4r3qYCVc_p_SrYKZLwaLg9Fy+h2p6g@mail.gmail.com>
In-Reply-To: <CADBMgpz3z_hB_5BVVD5-4r3qYCVc_p_SrYKZLwaLg9Fy+h2p6g@mail.gmail.com>
From:   Dylan Hatch <dylanbhatch@google.com>
Date:   Mon, 11 Jul 2022 16:15:30 -0700
Message-ID: <CADBMgpzPkErW=exgbzr+0z1x3JFdX9fuUJBhFG6ePxG59kvHaA@mail.gmail.com>
Subject: Re: [PATCH] selftests/proc: Fix proc-pid-vm for vsyscall=xonly.
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Accidentally hit direct reply, adding Shuah Khan <shuah@kernel.org>,
linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
linux-kselftest@vger.kernel.org, Shuah Khan
<skhan@linuxfoundation.org>

On Mon, Jul 11, 2022 at 4:04 PM Dylan Hatch <dylanbhatch@google.com> wrote:
>
> On Wed, Jun 22, 2022 at 10:15 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >
> > On 6/21/22 6:18 PM, Dylan Hatch wrote:
> > > On Fri, Jun 17, 2022 at 3:27 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> > >>
> > >> On 6/17/22 4:05 PM, Dylan Hatch wrote:
> > >>> On Fri, Jun 17, 2022 at 12:38 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> > >>>>
> > >>>> On 6/17/22 12:45 PM, Dylan Hatch wrote:
> > >>>>> On Thu, Jun 16, 2022 at 4:01 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> > >>>>>>
> > >>>
> > >>>>
> > >>>> It depends on the goal of the test. Is the test looking to see if the
> > >>>> probe fails with insufficient permissions, then you are changing the
> > >>>> test to not check for that condition.
> > >>>
> > >>> The goal of the test is to validate the output of /proc/$PID/maps, and
> > >>> the memory probe is only needed as setup to determine what the
> > >>> expected output should be. This used to be sufficient, but now it can
> > >>> no longer fully disambiguate it with the introduction of
> > >>> vsyscall=xonly. The solution proposed here is to disambiguate it by
> > >>> also checking the length read from /proc/$PID/maps.
> > >>>
> > >>>>
> > >>
> > >> Makes sense. However the question is does this test need to be enhanced
> > >> with the addition of vsyscall=xonly?
> > >>
> > >>>> I would say in this case, the right approach would be to leave the test
> > >>>> as is and report expected fail and add other cases.
> > >>>>
> > >>>> The goal being adding more coverage and not necessarily opt for a simple
> > >>>> solution.
> > >>>
> > >>> What does it mean to report a test as expected fail? Is this a
> > >>> mechanism unique to kselftest? I agree adding another test case would
> > >>> work, but I'm unsure how to do it within the framework of kselftest.
> > >>> Ideally, there would be separate test cases for vsyscall=none,
> > >>> vsyscall=emulate, and vsyscall=xonly, but these options can be toggled
> > >>> both in the kernel config and on the kernel command line, meaning (to
> > >>> the best of my knowledge) these test cases would have to be built
> > >>> conditionally against the conflig options and also parse the command
> > >>> line for the 'vsyscall' option.
> > >>>
> > >>
> > >> Expected fail isn't unique kselftest. It is a testing criteria where
> > >> a test is expected to fail. For example if a file can only be opened
> > >> with privileged user a test that runs and looks for failure is an
> > >> expected to fail case - we are looking for a failure.
> > >>
> > >> A complete battery of tests for vsyscall=none, vsyscall=emulate,
> > >> vsyscall=xonly would test for conditions that are expected to pass
> > >> and fail based on the config.
> > >>
> > >> tools/testing/selftests/proc/config doesn't have any config options
> > >> that are relevant to VSYSCALL
> > >>
> > >> Can you please send me the how you are running the test and what the
> > >> failure output looks like?
> > >
> > > I'm building a kernel with the following relevant configurations:
> > >
> > > $ cat .config | grep VSYSCALL
> > > CONFIG_GENERIC_TIME_VSYSCALL=y
> > > CONFIG_X86_VSYSCALL_EMULATION=y
> > > CONFIG_LEGACY_VSYSCALL_XONLY=y
> > > # CONFIG_LEGACY_VSYSCALL_NONE is not set
> > >
> > > Running the test without this change both in virtme and on real
> > > hardware gives the following error:
> > >
> > > # ./tools/testing/selftests/proc/proc-pid-vm
> > > proc-pid-vm: proc-pid-vm.c:328: int main(void): Assertion `rv == len' failed.
> > > Aborted
> > >
> > > This is because when CONFIG_LEGACY_VSYSCALL_XONLY=y a probe of the
> > > vsyscall page results in a segfault. This test was originally written
> > > before this option existed so it incorrectly assumes the vsyscall page
> > > isn't mapped at all, and the expected buffer length doesn't match the
> > > result.
> > >
> > > An alternate method of fixing this test could involve setting the
> > > expected result based on the config with #ifdef blocks, but I wasn't
> > > sure if that could be done for kernel config options in kselftest
> > > code. There's also the matter of checking the kernel command line for
> > > a `vsyscall=` arg, is parsing /proc/cmdline the best way to do this?
> > >
> >
> > We have a few tests do ifdef to be able to test the code as well as deal
> > with config specific tests. Not an issue.
> >
> > Parsing /proc/cmdline line is flexible for sure, if you want to use that
> > route.
> >
> > Thank you for finding the problem and identifying missing coverage. Look
> > forward to any patches fixing the problem.
> >
> > thanks,
> > -- Shuah
>
I've done some experimenting with ifdefs on config options, but it
seems that these options do not propagate properly into the tests. Is
there a specific method I should be using to propagate the config
values, or would you be able to point me to an example where this is
done properly?

Thanks and sorry for the slow reply on this,
Dylan

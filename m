Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E91C54FFB0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 00:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350694AbiFQWFp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 18:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbiFQWFo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 18:05:44 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D23C590A8
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 15:05:43 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i15so4506693ybp.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 15:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHoG7dDbbfhrmS/H7yyWkxeJ8IoOLiAVzbc6Ovna8+k=;
        b=R6fJeeiGDlD/+1wHzUVq4ENJyd1RnOML0OI/ctbcTHyebaauRByqLOBT0DUIvMpHEC
         p+gjCqNGT1KuicvmkkPiQikpQJ7t31SNL3ISafSzGaoU74t6lHjq0QJB2NqnDadhFI22
         C/3kvqRld8QD8XrcLlj0OHSEUOKviMJeE2FR5QhojpQJBb63FQSR7MZ/z9rot6kEkXwP
         9HzP3v+4rTQr9G9p4/He/nV/643sWxqvFCz6pCoRGFc8wEE5+JKe8nZ+D6IyZN19s6wB
         pY6uESe2yb8Gr4zy8mw/XWK4O6YJ8HbrPXhwL+8ZrI3Fs0clbvvYeYMC7cpE/lFIZOfl
         i1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHoG7dDbbfhrmS/H7yyWkxeJ8IoOLiAVzbc6Ovna8+k=;
        b=AN774HBzuCcVyE7vIXyt24cXpt8nRHKUoVuYHx/q1oDsvvstsDVs6ywTd5rKmo3Mu/
         htKucg3eXdJ6gylsycWtj2CxDr+KkuqFCcHDmKYR1NGKQj32CrVqixdC5E6qHlIMXBzp
         X5VzklHl6fIdKp9a1D6xFan4VmKjjPob2hgRZX1zM6cgZUKj7n92fiBUzTj+z2RkUd8R
         c7S8od37LMK21C0s7DjliA/ZinGUq7+4ueXlmjaOGOSfJ6c6DDjiVYUy3CFjhVpjAa8p
         Swgi+tyvPbjkd6dfyiBB7Vvl3ZCpCJzR2Vxhv3Q/RGaESF3l/rNWT+1YMVCEOzvzxuJG
         BuyQ==
X-Gm-Message-State: AJIora8fEk4klPuCots7ppdLuFogSQ5sZ1CZOvl/tG/4CZYujsjcxqFk
        DWLOckkHkFrLxvw5mNfCLdu5oh1WsMi6dL9EHTLR8Q==
X-Google-Smtp-Source: AGRyM1sF3bWOU6U0hUXlKsmL8i11lHkC9OJLeRChAOvOqYv4w5VGhzVZhfjNddIOWba2Ys5vztT2mAzvM7RJ57mBREs=
X-Received: by 2002:a25:c5c4:0:b0:664:8e1c:2fcf with SMTP id
 v187-20020a25c5c4000000b006648e1c2fcfmr13208362ybe.508.1655503542092; Fri, 17
 Jun 2022 15:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220616211016.4037482-1-dylanbhatch@google.com>
 <941e0991-eb3e-f988-8262-3d51ff8badad@linuxfoundation.org>
 <CADBMgpwt2ALzBTtEm7v6DLL_9pjUhVLDpBLHXn1b0bvVf2BSvg@mail.gmail.com> <47312e8a-87fe-c7dc-d354-74e81482bc1e@linuxfoundation.org>
In-Reply-To: <47312e8a-87fe-c7dc-d354-74e81482bc1e@linuxfoundation.org>
From:   Dylan Hatch <dylanbhatch@google.com>
Date:   Fri, 17 Jun 2022 15:05:30 -0700
Message-ID: <CADBMgpx9hwHaWe=m2kQhKOJFWnLSejoWa6wz1VECEkLhWq4qog@mail.gmail.com>
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

On Fri, Jun 17, 2022 at 12:38 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 6/17/22 12:45 PM, Dylan Hatch wrote:
> > On Thu, Jun 16, 2022 at 4:01 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
> >>
> >> On 6/16/22 3:10 PM, Dylan Hatch wrote:
> >>> This test would erroneously fail the /proc/$PID/maps case if
> >>> vsyscall=xonly since the existing probe of the vsyscall page only
> >>> succeeds if the process has read permissions. Fix this by checking for
> >>> either no vsyscall mapping OR an execute-only vsyscall mapping in the
> >>> case were probing the vsyscall page segfaults.
> >>>
> >>
> >> Does this fix include skipping the test with a clear message that
> >> says why test is skipped?
> >>
> >>> Signed-off-by: Dylan Hatch <dylanbhatch@google.com>
> >>> ---
> >>>    tools/testing/selftests/proc/proc-pid-vm.c | 20 +++++++++++++++-----
> >>>    1 file changed, 15 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
> >>> index 28604c9f805c..5ca85520131f 100644
> >>> --- a/tools/testing/selftests/proc/proc-pid-vm.c
> >>> +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> >>> @@ -213,9 +213,12 @@ static int make_exe(const uint8_t *payload, size_t len)
> >>>
> >>>    static bool g_vsyscall = false;
> >>>
> >>> -static const char str_vsyscall[] =
> >>> +static const char str_vsyscall_rx[] =
> >>>    "ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]\n";
> >>>
> >>> +static const char str_vsyscall_x[] =
> >>> +"ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]\n";
> >>> +
> >>>    #ifdef __x86_64__
> >>>    static void sigaction_SIGSEGV(int _, siginfo_t *__, void *___)
> >>>    {
> >>> @@ -261,6 +264,7 @@ int main(void)
> >>>        int exec_fd;
> >>>
> >>>        vsyscall();
> >>> +     const char *str_vsyscall = g_vsyscall ? str_vsyscall_rx : str_vsyscall_x;
> >>>
> >>>        atexit(ate);
> >>>
> >>> @@ -314,7 +318,8 @@ int main(void)
> >>>
> >>>        /* Test /proc/$PID/maps */
> >>>        {
> >>> -             const size_t len = strlen(buf0) + (g_vsyscall ? strlen(str_vsyscall) : 0);
> >>> +             const size_t len_buf0 = strlen(buf0);
> >>> +             const size_t len_vsys = strlen(str_vsyscall);
> >>>                char buf[256];
> >>>                ssize_t rv;
> >>>                int fd;
> >>> @@ -325,11 +330,16 @@ int main(void)
> >>>                        return 1;
> >>>                }
> >>>                rv = read(fd, buf, sizeof(buf));
> >>> -             assert(rv == len);
> >>> -             assert(memcmp(buf, buf0, strlen(buf0)) == 0);
> >>>                if (g_vsyscall) {
> >>> -                     assert(memcmp(buf + strlen(buf0), str_vsyscall, strlen(str_vsyscall)) == 0);
> >>> +                     assert(rv == len_buf0 + len_vsys);
> >>> +             } else {
> >>> +                     /* If vsyscall isn't readable, it's either x-only or not mapped at all */
> >>> +                     assert(rv == len_buf0 + len_vsys || rv == len_buf0);
> >>>                }
> >>> +             assert(memcmp(buf, buf0, len_buf0) == 0);
> >>> +             /* Check for vsyscall mapping if buf is long enough */
> >>> +             if (rv == len_buf0 + len_vsys)
> >>> +                     assert(memcmp(buf + len_buf0, str_vsyscall, len_vsys) == 0);
> >>>        }
> >>>
> >>>        /* Test /proc/$PID/smaps */
> >>>
> >>
> >> The change looks good to me. Doesn't look like it skips the test though?
> >
> > Instead of skipping the test, it changes the passing condition to
> > accept both cases of an unmapped vsyscall page and an x-only vsyscall
> > page. Differentiating between these two cases without relying on
> > /proc/$PID/maps would involve both checking the kernel command line
> > for vsyscall=xonly and having a special ifdef block for
> > CONFIG_VSYSCALL_XONLY, so accepting both as passing conditions seems
> > like a simpler solution.
> >
>
> It depends on the goal of the test. Is the test looking to see if the
> probe fails with insufficient permissions, then you are changing the
> test to not check for that condition.

The goal of the test is to validate the output of /proc/$PID/maps, and
the memory probe is only needed as setup to determine what the
expected output should be. This used to be sufficient, but now it can
no longer fully disambiguate it with the introduction of
vsyscall=xonly. The solution proposed here is to disambiguate it by
also checking the length read from /proc/$PID/maps.

>
> I would say in this case, the right approach would be to leave the test
> as is and report expected fail and add other cases.
>
> The goal being adding more coverage and not necessarily opt for a simple
> solution.

What does it mean to report a test as expected fail? Is this a
mechanism unique to kselftest? I agree adding another test case would
work, but I'm unsure how to do it within the framework of kselftest.
Ideally, there would be separate test cases for vsyscall=none,
vsyscall=emulate, and vsyscall=xonly, but these options can be toggled
both in the kernel config and on the kernel command line, meaning (to
the best of my knowledge) these test cases would have to be built
conditionally against the conflig options and also parse the command
line for the 'vsyscall' option.

Thanks,
Dylan

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7B48C4BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jan 2022 14:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbiALNWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 08:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353547AbiALNWy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:22:54 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7469CC06173F
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jan 2022 05:22:54 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id k15so9791361edk.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jan 2022 05:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MfZ/bQyc8Ol4TQ5HaN2khWewBoM9cI1PUzi7/CIfS6I=;
        b=Lsipx6XKx1x6e4uetXaiE2GztJ4AGV6fzRo4TY2NE2SduXUPlNhdbeLCtufRKCwwnC
         0SPpqEeAGedRwJ5A3cFuz+Fx8X+/99cdT8FkqL59AenhPixEDypHH2cxR0hfPpkdJRWL
         3JvI6T/LyCTCLZuaDgcUBHouUXc9It24q4dlN1kjlwLfcM/g4EbP22GfPDk2rbn0ZnTE
         zMXyKDy7LqM19xT86V7+wYsIyDPRZtmoHpEpQZRX4lX8AWYnKPxnZagvhAeBzuBXUUDa
         DtwE0zSmSKkYjMLLWx73/IhVuQzZsYYgMYNR0qZzGhYW+nWTdsCOHzUDX6UNTX3VT46H
         Yt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MfZ/bQyc8Ol4TQ5HaN2khWewBoM9cI1PUzi7/CIfS6I=;
        b=BwFbY/NRrNzqFa2UkAW4Taxyl1INsb7bXCjynrlebT7PX4Q9EEzt2wg3bb2AgvMrbN
         FhoNfv8DVPMT0ZHsRfr/vSYQ1bUG6lummdVREGL7hdteRA+okFNYEIlyakuJ1ycLDrhN
         Qsah7FnaHKAdc4kUaf23TtMWVG5NUp3Nl+m4EWCEiLRhA4DcTlVz9N7zo/sIltppKVWT
         FrU0svllAEmWczPb8gI1AteY7S4OGIsK/dBQOg76Jt2DOY5w9oG9vmDG016PgTrLJaHN
         kW2TsxpvrkPZUOGEc9JAZmFFLmat3Oykzu0SsGpZWCkP3oKsUjZWCM6hQSFLKwYS8maZ
         CDKQ==
X-Gm-Message-State: AOAM533kjjALLPqi/Mxjd6nXKI5fYWbwahuSYzVadlIScNRXsiYgsClo
        NNH+3dlj2ukRQxIaJP/oKI5A1PyOtEC7NJqRYwS8/Q==
X-Google-Smtp-Source: ABdhPJz5Wrm0HbctZgKlE4IIfTnFY0GNvyi3qy++ibXIKY6TXHt+qWqe1wMvjNYh3xmQ1f9ikobQGUS2W1drqcKJSp4=
X-Received: by 2002:a17:907:3f92:: with SMTP id hr18mr7524933ejc.693.1641993772970;
 Wed, 12 Jan 2022 05:22:52 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsMHhXJCgO-ykR0oO1kVdusGnthgj6ifxEKaGPHZJ-ZCw@mail.gmail.com>
 <20220112131837.igsjkkttqskw4eix@wittgenstein>
In-Reply-To: <20220112131837.igsjkkttqskw4eix@wittgenstein>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Wed, 12 Jan 2022 14:22:42 +0100
Message-ID: <CADYN=9Lvm-1etZS817eZK91NUyxkFBmsu=5-q_8Ei-1eV8DuZQ@mail.gmail.com>
Subject: Re: [next]: LTP: getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER)
 failed: ENOSPC (28)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
        linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev,
        containers@lists.linux.dev, Alexey Gladkov <legion@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 12 Jan 2022 at 14:18, Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, Jan 12, 2022 at 05:15:37PM +0530, Naresh Kamboju wrote:
> > While testing LTP syscalls with Linux next 20220110 (and till date 20220112)
> > on x86_64, i386, arm and arm64 the following tests failed.
> >
> > tst_test.c:1365: TINFO: Timeout per run is 0h 15m 00s
> > getxattr05.c:87: TPASS: Got same data when acquiring the value of
> > system.posix_acl_access twice
> > getxattr05.c:97: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> > tst_test.c:391: TBROK: Invalid child (13545) exit value 1
> >
> > fanotify17.c:176: TINFO: Test #1: Global groups limit in privileged user ns
> > fanotify17.c:155: TFAIL: unshare(CLONE_NEWUSER) failed: ENOSPC (28)
> > tst_test.c:391: TBROK: Invalid child (14739) exit value 1
> >
> > sendto03.c:48: TBROK: unshare(268435456) failed: ENOSPC (28)
> >
> > setsockopt05.c:45: TBROK: unshare(268435456) failed: ENOSPC (28)
> >
> > strace output:
> > --------------
> > [pid   481] wait4(-1, 0x7fff52f5ae8c, 0, NULL) = -1 ECHILD (No child processes)
> > [pid   481] clone(child_stack=NULL,
> > flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD,
> > child_tidptr=0x7f3af0fa7a10) = 483
> > strace: Process 483 attached
> > [pid   481] wait4(-1,  <unfinished ...>
> > [pid   483] unshare(CLONE_NEWUSER)      = -1 ENOSPC (No space left on device)
>
> This looks like another regression in the ucount code. Reverting the
> following commit fixes it and makes the getxattr05 test work again:
>
> commit 0315b634f933b0f12cfa82660322f6186c1aa0f4
> Author: Alexey Gladkov <legion@kernel.org>
> Date:   Fri Dec 17 15:48:23 2021 +0100
>
>     ucounts: Split rlimit and ucount values and max values
>
>     Since the semantics of maximum rlimit values are different, it would be
>     better not to mix ucount and rlimit values. This will prevent the error
>     of using inc_count/dec_ucount for rlimit parameters.
>
>     This patch also renames the functions to emphasize the lack of
>     connection between rlimit and ucount.
>
>     v2:
>     - Fix the array-index-out-of-bounds that was found by the lkp project.
>
>     Reported-by: kernel test robot <oliver.sang@intel.com>
>     Signed-off-by: Alexey Gladkov <legion@kernel.org>
>     Link: https://lkml.kernel.org/r/73ea569042babda5cee2092423da85027ceb471f.1639752364.git.legion@kernel.org
>     Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> The issue only surfaces if /proc/sys/user/max_user_namespaces is
> actually written to.

I did a git bisect and that pointed me to this patch too.

Cheers,
Anders

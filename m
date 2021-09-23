Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4082D415BEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 12:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbhIWK06 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Sep 2021 06:26:58 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:53853 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbhIWK06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:26:58 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MBDrM-1mZRGd30Lm-00CkVZ; Thu, 23 Sep 2021 12:25:25 +0200
Received: by mail-wr1-f42.google.com with SMTP id t7so15596748wrw.13;
        Thu, 23 Sep 2021 03:25:24 -0700 (PDT)
X-Gm-Message-State: AOAM533U++mQHBaaYO5RMxpMyepzUCbUHL4CJwEw4wDgCsGB0CAZkrVC
        JDOdxhP7WxoaowhEjwi12zJ5u2xoJwgGwODFipw=
X-Google-Smtp-Source: ABdhPJzC5Pos1T3UiHJSSsCIdXJofBl7ZfARwRkYsLQOoX39pi6HQSPjzuB5Y3XPLHj7prwJBhe6ePUG76CgqIgVldI=
X-Received: by 2002:a05:6000:1561:: with SMTP id 1mr4003238wrz.369.1632392724385;
 Thu, 23 Sep 2021 03:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210921130127.24131-1-rpalethorpe@suse.com> <CAK8P3a29ycNqOC_pD-UUtK37jK=Rz=nik=022Q1XtXr6-o6tuA@mail.gmail.com>
 <87o88mkor1.fsf@suse.de> <87lf3qkk72.fsf@suse.de> <87ilytkngp.fsf@suse.de>
 <CAK8P3a2S=a0aw8GY8fZxaU5fz7ZkdehtHgStkn2=u9gO28GVEw@mail.gmail.com> <87fstvlifu.fsf@suse.de>
In-Reply-To: <87fstvlifu.fsf@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Sep 2021 12:25:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3H3ZikSfqoeh0=PQQuFw6PTg2KgP+p=4G26ayuzgwQeQ@mail.gmail.com>
Message-ID: <CAK8P3a3H3ZikSfqoeh0=PQQuFw6PTg2KgP+p=4G26ayuzgwQeQ@mail.gmail.com>
Subject: Re: ia32 signed long treated as x64 unsigned int by __ia32_sys*
To:     rpalethorpe@suse.de
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:VsT0RG+x5xNNl9O9ELm6YaPkZKL9FOCyhaL/glhemx1qSo9Pqdt
 F5hd8W0T2BT/1gpRjV1jHZAaCEezqjigrdCSpB9ebAMrWdYzngCXs3SoUA64jEXZWhr/1mO
 8tzEqLBWv44kAnMD/A9f345A3oMFlAOE5+Yn/05RP58yb5eLvg1UHZoXlPl6pjSdAvwYb6O
 TrYUwgYgq3LZIkS6cYIWw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6eHKhAuQYxY=:s1HAIRIX+ogJcWuq5K/LVb
 ilhxyUya05Qxs8DX/KuEKg+8XsbNHSxfYxTOODXIs6q4C2LgElpNUIvB5fLjmvHfe3wAvaTtL
 LbKfvt6ck1irp1WfkZBjU8Z7OlJPZMZm7wPzBcMfeKWuKQyzKqSgfqWYs7d2/AVm3Td4U1++Q
 9g4g3vj1aZ92WD8cYnjStOWMYdBZnnE8cR8g4YylnAg2IvTl0NLqVZq53fevtqdQ0yEYzSWSP
 fjBtKlpuk2iyoY6Xmj0L/pPvCs3dSc5mEWUgicLtXkpLMYBZgJGqGNlNA2bcwWE01u7jrjjnf
 1JwtbmhV6mEZ2Xz0Tc30vHYPbhi1ysrtqLpm4Px9iR71dwnYV3xyQPzssCCb7TvKZVCGkqwBf
 uEUHz+vR8zNrpP6GjxN+20avT4FgT+xcPjS/kRjDuTdEi6Eh9unw1J4gKnlOhL3U7bE+yogiW
 OtF1zTZN/1BOOfqorn4sFnBrP4PcqzwdDjeyTiOv3u27rjTQ1aSW9NpjJmfmkPXJ6IcD8Pq6J
 ZwJPYhAZUoLEIMraP+8qStuPKX3LRA7JwEuO5RkWjEOxgEI34bkRphfiwbe134qN0Q89h81ft
 BWUPp0YXA16up+yosjj2c9UL1ENNaNAf2APSqhMs+Gop5Aiwrelc0GyS3222xbLnCg1eM38eL
 bma52stjJtehEdbWaiDVmBLHe3qr8d/uXUvjIZYVle4Gg7qBnAHJKw5VYtWSr2yQU5Kt5Y3wG
 6o3q6ZKLaNyxzF/EaKgwQOxFOH04oLdbWBump3BFr2uEm0tDDEVBvXCsmYRsy5Jb/j5z7Il+T
 IzM2i0e9jFiPubqSWpIldkra3WICBCCOnaXYnVAeFOX8Yjq1UXzdbj8yKQ8nZZPJtZzPHL0EE
 Gv8mMjywzG/a1GZHI4OA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 23, 2021 at 12:01 PM Richard Palethorpe <rpalethorpe@suse.de> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Wed, Sep 22, 2021 at 10:46 AM Richard Palethorpe <rpalethorpe@suse.de> wrote:
> >> Richard Palethorpe <rpalethorpe@suse.de> writes:
> >
> > I also noticed that only x86 and s390 even have separate entry
> > points for normal syscalls when called in compat mode, while
> > the others all just zero the upper halves of the registers in the
> > low-level entry code and then call the native entry point.
>
> It looks to me like aarch64 also has something similar? At any rate, I
> can try to fix it for x86 and investigate what else might be effected.

arm64 also has a custom asm/syscall_wrapper.h, but it only does
this for accessing pt_regs (as x86 does), not for doing any
argument conversion. x86 does the 32-to-64 widening in the
wrapper, arm64 relies on the pt_regs already having the upper
halves zeroed.

        Arnd

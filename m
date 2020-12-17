Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E472DDAB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Dec 2020 22:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgLQVQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Dec 2020 16:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgLQVQt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:16:49 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C28C061794
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 13:16:08 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m25so61276625lfc.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 13:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1gFWyQkmkLhCbv2d+Raglj6n3PIGWMNf0Fm0qm+U/4=;
        b=RASQ28YUFGFrGQbMX/V/LJFRd/0tYNs2lmT1vc9TRt8o323wTRa3xTS/uqfwYDDhkG
         T2753KyC0R4yJHCHSaEepCuW/vb3BWe2TxOZG6YPg0GuaeHmrg4IvIfKVK6JYJJvcSft
         njU67lOpM0+5A3Rq6ZjEEsS5UePl7Yn9kpVMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1gFWyQkmkLhCbv2d+Raglj6n3PIGWMNf0Fm0qm+U/4=;
        b=XgIS9fwdpgK54JvGpbQH5y1jxe7Jof3vGxjkZUc+/6W0qsEZoCtbHjboeDAikdNAZf
         tvCIGgCdgd2RTbCFevv3tLRHVLX+caVVCsIpI4hEPtiLid8Li0hsGsvtcBJQQnm5TFbX
         GZtVSj8L3WnqyJOPDPK+TloD+Q9aVeFzL9dBUNAnito+u8LVHcmBTCmv+XRIoa5FfYQj
         2aN18IjgvE6eEJHBWthIeLm6qHYBK1swq/huA/BXoOxdwPbLZ2NeGvIcXOqW8GWVJtPD
         iIBs7pKw+0nRK2iBezFt5LeWFmUSXuUBVoK12k/K6jm4rRYu7CBU61ady+gVp/M+MB+L
         vQSQ==
X-Gm-Message-State: AOAM532y3UI4WLKoXgtESqJgt0RPOOszkkjh/1rXNw2bHPw2eT+ZhYug
        rDeKUtSOblqKl+jvPocoEV6ezjoU9CsZ1A==
X-Google-Smtp-Source: ABdhPJwRNnp6Ht8TlnivZ61BgsN/MPoFQuRxR6u3xb4Gar4rrJLWHxAihSQSaIeFtyp7ea8FqofNjQ==
X-Received: by 2002:a05:6512:328b:: with SMTP id p11mr252385lfe.356.1608239766850;
        Thu, 17 Dec 2020 13:16:06 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id j4sm696735lfg.197.2020.12.17.13.16.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 13:16:03 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id u18so61335567lfd.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Dec 2020 13:16:03 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr248377lfl.41.1608239762945;
 Thu, 17 Dec 2020 13:16:02 -0800 (PST)
MIME-Version: 1.0
References: <51a9a594a38ae6e0982e78976cf046fb55b63a8e.1603191669.git.viresh.kumar@linaro.org>
 <20201027085152.GB10053@infradead.org> <CAHk-=whw9t3ZtV8iA2SJWYQS1VOJuS14P_qhj3v5-9PCBmGQww@mail.gmail.com>
 <b3a8e2e8-350f-65af-9707-a6d847352f8e@redhat.com> <CAK8P3a0C5qUguxg446iuvaHm0D+E1tSowxht7g9OJp90GDsAAQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0C5qUguxg446iuvaHm0D+E1tSowxht7g9OJp90GDsAAQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Dec 2020 13:15:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTnbrD0zfOaSkwQX0+OB0LE0EjD=+Zxsy2A36-ye+_6Q@mail.gmail.com>
Message-ID: <CAHk-=wiTnbrD0zfOaSkwQX0+OB0LE0EjD=+Zxsy2A36-ye+_6Q@mail.gmail.com>
Subject: Re: [PATCH] dcookies: Make dcookies depend on CONFIG_OPROFILE
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     William Cohen <wcohen@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Anmar Oueja <anmar.oueja@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just reviving this thread to see if we could get rid of the OPROFILE
kernel code this time..

One option is to just start off with adding a

        depends on DISABLED

on the OPROFILE config option, and see if anybody even notices.

But honestly, just removing the entirely might be the better thing.

The oprofile config is a bit odd. We have things like
OPROFILE_NMI_TIMER which defaults to on even if OPROFILE isn't even
selected. All the _users_ of that seem to be inside oprofile code, so
it's effectively a no-op without oprofile,

The only reason I noticed was that I looked at the Fedora kernel
config files, and went "uhhuh, Fedora still enables that", and had a
quick worry before I noticed that it's just the Kconfig system being
silly.

              Linus

On Wed, Oct 28, 2020 at 11:01 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Wed, Oct 28, 2020 at 5:34 PM William Cohen <wcohen@redhat.com> wrote:
> >
> > On 10/27/20 12:54 PM, Linus Torvalds wrote:
> > >
> > > I think the user-space "oprofile" program doesn't actually use the
> > > legacy kernel code any more, and hasn't for a long time.
> >
> > Yes, current OProfile code uses the existing linux perf infrastructure and
> > doesn't use the old oprofile kernel code.  I have thought about removing
> > that old oprofile driver code from kernel, but have not submitted patches
> > for it. I would be fine with eliminating that code from the kernel.
>
> I notice that arch/ia64/ supports oprofile but not perf. I suppose this just
> means that ia64 people no longer care enough about profiling to
> add perf support, but it wouldn't stop us from dropping it, right?
>
> There is also a stub implementation of oprofile for microblaze
> and no perf code, not sure if it would make any difference for them.
>
> Everything else that has oprofile kernel code also supports perf.
>
>        Arnd

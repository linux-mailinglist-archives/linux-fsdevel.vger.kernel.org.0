Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DF035672A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349670AbhDGIrQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 04:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349709AbhDGIrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:47:03 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CB5C06174A;
        Wed,  7 Apr 2021 01:46:54 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id y16so318496pfc.5;
        Wed, 07 Apr 2021 01:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZttKhZHU6qaVsRmUnPJpvZt0Hi/pFu56dbeZNbDXtU=;
        b=UDQs+QKztlc50Xzz9tDRt+AdeuvS//lqLAuKnWXU/KpkdRIyYns185alJd77pimmOQ
         Rm+SXfRq7Nbp44iFj09DlIBP8pB9Q/wr1Jktw0TsONZCLU6cUjKoAcBW9MELgEDcm9Fe
         pjdoHv/Z1K75roAdGxxxm60OLnxr6B3j/huNdwRUOBcR/NfWwdJ0T2Ry1GSBSm5M8gQG
         cPX3YXLL7dtqUWW4/37Lsyk3k7L76r1KootJDPbDvQIsbhQfbSpG/LRrVUU53kFzKElU
         mZPAf+0lfHR42X+g8hHRO6PYug2sgsVVq7CJaXGQetXBqPCEBbWZWj0if+0XEWIBGBV8
         f3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZttKhZHU6qaVsRmUnPJpvZt0Hi/pFu56dbeZNbDXtU=;
        b=U6xGKAfqxrLQgJHPe8FmLF8x8gAHUPieu4V5pp/CReJ9GyzSX7OxC13PhDrWxFcuBe
         p+9uywwNqYWqNFlvhv/DwkYgjcNSaVUavom7Y2H3iu/7hryQwVpvtRFxBiKyelypWZBM
         XmUZqei/7l8wblDlpP0TenIP6K+m/cXFStjyIjcU2V2QQkmLIJkBcVFCtqo3szb6A5FK
         y9NHvPsQnWrmpnPV1SYsfvrvy+b7jV8bbligwQjcSU5O/HQl/YTv09NzjkNigG1y20XT
         u1n89YwY7faLBOL4CLLaVrqcJxrWMuueTDsdMTdtKCp7HePLkIzD596S6B9iYSNhAlN2
         HtkA==
X-Gm-Message-State: AOAM531S82T3LQNp51YK3OHnBH50CMnAve9+VKkWDXoWcn+2oT/6ajEm
        gEQVmIbqutQQmub8myghsy5hC2PGm63Mb7qygDI=
X-Google-Smtp-Source: ABdhPJyOREH8pH5Yw3mdnLvelVM7fjh26m8MXKE2FHM7iVCNEkdX6M5hYPv1kbA5tQgLzWX2dL38Pt50r64dgAgPi18=
X-Received: by 2002:a63:3e4b:: with SMTP id l72mr2244351pga.203.1617785213524;
 Wed, 07 Apr 2021 01:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com> <202104061143.E11D2D0@keescook>
In-Reply-To: <202104061143.E11D2D0@keescook>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Apr 2021 11:46:37 +0300
Message-ID: <CAHp75Ve+11u=dtNTO8BCohOJHGWSMJtb1nGCOrNde7bXaD4ehA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-remoteproc@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        kexec@lists.infradead.org, rcu@vger.kernel.org,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Corey Minyard <minyard@acm.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 7, 2021 at 11:17 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Apr 06, 2021 at 04:31:58PM +0300, Andy Shevchenko wrote:
> > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > Here is the attempt to start cleaning it up by splitting out panic and
> > oops helpers.
> >
> > At the same time convert users in header and lib folder to use new header.
> > Though for time being include new header back to kernel.h to avoid twisted
> > indirected includes for existing users.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> I like it! Do you have a multi-arch CI to do allmodconfig builds to
> double-check this?

Unfortunately no, I rely on plenty of bots that are harvesting mailing lists.

But I will appreciate it if somebody can run this through various build tests.

> Acked-by: Kees Cook <keescook@chromium.org>

Thanks!


-- 
With Best Regards,
Andy Shevchenko

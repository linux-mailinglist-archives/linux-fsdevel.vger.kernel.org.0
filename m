Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3564935654D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 09:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349449AbhDGHeL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 03:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349438AbhDGHeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 03:34:10 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49350C06174A;
        Wed,  7 Apr 2021 00:34:01 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i4so376058pjk.1;
        Wed, 07 Apr 2021 00:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QvZSBrH1kmgxKZKSD+pBe7YtJvXFi8yG9kfTKSmsc5Q=;
        b=O2cXbe0TlOnka3Htg7a7ktCEm4u84Apnd4pxAh+QckwGH1N5XUJxAQXGojK8urTwHW
         S6qKShLuqQpXW7czN7NSppj8uMSG1ILItUs2jRqW9KCOM0ewsGPs471AJdd9fQwkregx
         5WJsKLnvvgP9H/rO+GMThc5QqAWIM6vJUjUihrVpN1qBZ1PZrQQurpb3jy0hrvC8q/ga
         193Hbzqy2uMvrG2DBivJBITDOAFTPHgkYrA0xxTN2O5/SDYNzxk8E+F9Ofv4wPxpKtYd
         OpyTo6+F49K8x0yWEkTWuqKF3gTonWd9jxsyeBFNYymfsKPd0N1ZAJ/ruwq0yRVkpYX5
         /xXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QvZSBrH1kmgxKZKSD+pBe7YtJvXFi8yG9kfTKSmsc5Q=;
        b=It3wmurtf3RzDQg5MbvIKfnNC72Wd9j3tdITngALofG7LqQTLW3OPQCtldNm0o7pfN
         vv6qrC6BmiLflb9Y2jK8e1Tw6F6dvD6Xtb2GLk/VBPQZo76gtaVLMk8/Yl2jhR8i6JcA
         Yupq8wnJ6MywTGqAe85FUj/riByuVr+xU4sH55ollKcjkNzKPONlw1OXXv0+pfnZ2iC2
         vhTPcgreszCN1xGhxtPRCzfUXcUfC6yICtfAitgkGF4+T+HOwb0A9NPf9jbPalcw5SCj
         hwv8xozO9qPdI7UeUMOvT7Jsv5e7gCF+8/NTzxcHKIkXX8YPoAEAwcMxFwWYOag9Fc3j
         bU+g==
X-Gm-Message-State: AOAM533NK4KGWEkiEc1OC1RcdlQTGg5Jw8Cdq/K5BEQAMNOaF47mYdvu
        hJWvWJ4hVxY88VhiaFfAIAWd6OrjgZ86cPhgha0=
X-Google-Smtp-Source: ABdhPJyRMoGPnuz4MO0FmGOHIM1XSyhsQpJQrKhPLw79y8VziNPPVSJYtRew3BRLtYZwwl4H1BLduTLJZdkCaUCy8qY=
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id
 p6-20020a170902a406b02900e678c471c8mr1880447plq.17.1617780840716; Wed, 07 Apr
 2021 00:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com> <20210406165108.GA4332@42.do-not-panic.com>
In-Reply-To: <20210406165108.GA4332@42.do-not-panic.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Apr 2021 10:33:44 +0300
Message-ID: <CAHp75Ve9vBQqSegM2-ch9NUN-MdevxxOs5ZdHkk1W7AacN+Wrw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
To:     Luis Chamberlain <mcgrof@kernel.org>
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
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 7, 2021 at 10:25 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Tue, Apr 06, 2021 at 04:31:58PM +0300, Andy Shevchenko wrote:
> > diff --git a/include/linux/panic_notifier.h b/include/linux/panic_notifier.h
> > new file mode 100644
> > index 000000000000..41e32483d7a7
> > --- /dev/null
> > +++ b/include/linux/panic_notifier.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_PANIC_NOTIFIERS_H
> > +#define _LINUX_PANIC_NOTIFIERS_H
> > +
> > +#include <linux/notifier.h>
> > +#include <linux/types.h>
> > +
> > +extern struct atomic_notifier_head panic_notifier_list;
> > +
> > +extern bool crash_kexec_post_notifiers;
> > +
> > +#endif       /* _LINUX_PANIC_NOTIFIERS_H */
>
> Why is it worth it to add another file just for this?

The main point is to break tons of loops that prevent having clean
headers anymore.

In this case, see bug.h, which is very important in this sense.

>  Seems like a very
> small file.

If it is an argument, it's kinda strange. We have much smaller headers.

-- 
With Best Regards,
Andy Shevchenko

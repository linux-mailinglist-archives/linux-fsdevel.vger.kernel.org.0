Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1E244FFD6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Nov 2021 09:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhKOIPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Nov 2021 03:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbhKOIP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:15:29 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B04C061746;
        Mon, 15 Nov 2021 00:12:31 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 136so9257281pgc.0;
        Mon, 15 Nov 2021 00:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=pjGJNnGfp7N4YPL+3tEog9B076yjtwRjSVPNfS56OSM=;
        b=BZeXQQNf4sUHMfeWyEIc/pL9d7eDdipdr3UY8NhmZmrw8aEqL+veJz5rohewQomD/9
         gvjGv+OH7MUauciTQWQYnOXuwsH4I0H4pV59b0eyWWSlTqdhfy8xyOmoREE2DI6snXLz
         UeUnn60CjTcS6eCkct14/Ckb+aRNdG7wFkJgBQxwQdI39R7GK/dKhSi+sJaEuxzuW281
         9trAJgcjSL+DDUqAWjBiEtl/ZO7ZATHqMvwQtVzovbIlK2W7HjxoWc8FGRGIOUnqFPiZ
         PPa9wm7xDaZ2vYDkqexwCjZaxaOsmVbYK8dMC8BEKzaHCIBVkh3YWiqN+bybl/4qX446
         DTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=pjGJNnGfp7N4YPL+3tEog9B076yjtwRjSVPNfS56OSM=;
        b=2mVDA/rCh9EU+hfSduWDyY2CCer/r74PtllvGe6tVw/pkKJuZnZmoRc92pvsFul7If
         SKcplayLk3poXpTJhNpTRi26Z4viA2tTeVMEmNbh1NQTCGAGop2a4lviDdKEbiZb+zBW
         FhKyTpAQzMkLRa6e08zqdIwXP+jbZLVG8cvWZwpu/8FOZ+DwSGZAYxD8f4GfSPwxTofX
         FaNmN9Tekoq5Lyg+cxCnCqhQ4jz1thylhcAvxARKg3+pBGPkLo+o/f2F9OblDH/TllRm
         SPxoZFf/x8qu2F6NaONaqqD7zlYyKgSCHzj+s9xMUYCITVzn25goEOf1PHDuuPhxqztm
         xINg==
X-Gm-Message-State: AOAM533ILwcZshvA87T36Fh9YtQcmqQNkmeMwboov2mS5OZUWTqQe2bE
        y6pybnD8cWzllyifSp0tSWM=
X-Google-Smtp-Source: ABdhPJzGituTcml7q8z/bFSirZjHN/EzKmPMByct6A039FIlbn7nWDRowe12KRH+XfpvJo86S+l4JA==
X-Received: by 2002:a63:8042:: with SMTP id j63mr23244031pgd.225.1636963951054;
        Mon, 15 Nov 2021 00:12:31 -0800 (PST)
Received: from k7550 ([103.214.62.4])
        by smtp.gmail.com with ESMTPSA id bt2sm17687876pjb.33.2021.11.15.00.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 00:12:30 -0800 (PST)
Message-ID: <d4bf6e277e1fc5dbd9026a8fdd705599de87ba6b.camel@gmail.com>
Subject: Re: [PATCH v2 0/2] Introduce the pkill_on_warn parameter
From:   Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
To:     Alexander Popov <alex.popov@linux.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul McKenney <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laura Abbott <labbott@kernel.org>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Scull <ascull@google.com>,
        Marc Zyngier <maz@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Wang Qing <wangqing@vivo.com>, Mel Gorman <mgorman@suse.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Mathieu Chouquet-Stringer <me@mathieu.digital>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Kitt <steve@sk2.org>, Stephen Boyd <sboyd@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc:     notify@kernel.org
Date:   Mon, 15 Nov 2021 13:42:12 +0530
In-Reply-To: <20211027233215.306111-1-alex.popov@linux.com>
References: <20211027233215.306111-1-alex.popov@linux.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-10-28 at 02:32 +0300, Alexander Popov wrote:
> [...]
> 
> From a security point of view, kernel warning messages provide a lot of
> useful information for attackers. Many GNU/Linux distributions allow
> unprivileged users to read the kernel log, so attackers use kernel
> warning infoleak in vulnerability exploits. 
At the risk of being too simplistic, if the intention is to cut down infoleaks,
why not simply have a config (and/or sysctl) to toggle it - both at kernel build
as well as at runtime via a sysctl.

A minimal starting attempt at this, definitely incomplete (i've not actually written
the config anywhere, sorry, I'd just like to propose this as an idea for now) could
be something like this? (Am calling the kconfig CONFIG_TERSE_DIAGS_ONWARN):

---
 kernel/panic.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index cefd7d82366f..bbf00b0a8110 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -587,10 +587,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
    if (args)
        vprintk(args->fmt, args->args);
 
-   print_modules();
-
-   if (regs)
-       show_regs(regs);
+   if (IS_ENABLED(CONFIG_TERSE_DIAGS_ONWARN))
+       return;
 
    if (panic_on_warn) {
        /*
@@ -603,6 +601,11 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
        panic("panic_on_warn set ...\n");
    }   
 
+   print_modules();
+
+   if (regs)
+       show_regs(regs);
+
    if (!regs)
        dump_stack();
 
-- 
2.25.1


Further, am unsure precisely which portions of diagnostic output would be useful
to retain when the config's on. Of course, this "patch" is very premature. Of course,
am open to suggestions on all of this,
Regards


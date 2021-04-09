Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E43597AC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 10:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbhDIIWz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Apr 2021 04:22:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:58283 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232344AbhDIIWy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:22:54 -0400
IronPort-SDR: AGgAavcBKwusVGnsDUomLoxZJQkOYtG8IpdAD6+pC1t7alZCaPKh6Aux9Fk2lwVeUoBUbr1ZIF
 CuS/gs2U6sYA==
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="173801052"
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="173801052"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 01:22:41 -0700
IronPort-SDR: LpPwGYvzeGLB4564wHP5jJbcRyN85WbfWAYL9lYRz8cQSDjnd3E+cW0pfFcrKjH/dI51i7LuRn
 04ILPMrQhS5g==
X-IronPort-AV: E=Sophos;i="5.82,208,1613462400"; 
   d="scan'208";a="613646033"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 01:22:32 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1lUmPK-002UMq-O4; Fri, 09 Apr 2021 11:22:26 +0300
Date:   Fri, 9 Apr 2021 11:22:26 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joerg Roedel <jroedel@suse.de>, Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
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
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
Message-ID: <YHAOwm5JtmH/8Njr@smile.fi.intel.com>
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
 <202104061143.E11D2D0@keescook>
 <CAHp75Ve+11u=dtNTO8BCohOJHGWSMJtb1nGCOrNde7bXaD4ehA@mail.gmail.com>
 <20210408232303.453749e0e6fb0adfa8545440@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408232303.453749e0e6fb0adfa8545440@linux-foundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 08, 2021 at 11:23:03PM -0700, Andrew Morton wrote:
> On Wed, 7 Apr 2021 11:46:37 +0300 Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Wed, Apr 7, 2021 at 11:17 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > On Tue, Apr 06, 2021 at 04:31:58PM +0300, Andy Shevchenko wrote:
> > > > kernel.h is being used as a dump for all kinds of stuff for a long time.
> > > > Here is the attempt to start cleaning it up by splitting out panic and
> > > > oops helpers.
> > > >
> > > > At the same time convert users in header and lib folder to use new header.
> > > > Though for time being include new header back to kernel.h to avoid twisted
> > > > indirected includes for existing users.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > >
> > > I like it! Do you have a multi-arch CI to do allmodconfig builds to
> > > double-check this?
> > 
> > Unfortunately no, I rely on plenty of bots that are harvesting mailing lists.
> > 
> > But I will appreciate it if somebody can run this through various build tests.
> > 
> 
> um, did you try x86_64 allmodconfig?
> 
> I'm up to
> kernelh-split-out-panic-and-oops-helpers-fix-fix-fix-fix-fix-fix-fix.patch
> and counting.


I will try on my side and will fix those, thanks!

> and.... drivers/leds/trigger/ledtrig-heartbeat.c as well.
> 
> I'll drop it.

No problem, thanks for the report.

-- 
With Best Regards,
Andy Shevchenko



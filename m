Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8EA35704A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Apr 2021 17:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353586AbhDGPaL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 11:30:11 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:41609 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353563AbhDGPaK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:30:10 -0400
Received: by mail-pj1-f43.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso1531594pje.0;
        Wed, 07 Apr 2021 08:30:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+M5ErOA6vMHXgHMo812hqipKBEarvAzxNuznNu4dPh4=;
        b=jsvrsCk2USuWmPdJ3aMJwVWzy7393uAv08mKvsKYFaJ3jCz3VVW+3ptyPpHt+GKx4l
         gu8PPEPO4ABq8AYUHGQRdtU2WGDKbxNh+d5+9X6fZqZ0bFodVnAgSlVZkClleG2AZ7/r
         h3FWStbOqUeG0Z+tP0bxzNT5xF5sJ9dTINsUIQh9Xl4sC7+4A7Ekvo04F2GemAkmhlrg
         H0euxVew93XQify4f3rbwJ4GvC3KOWGRPprBA2i2BqONFdVEMF65KAfxK6p20CvOCcot
         yITsnojVRMOplQSR1DucFSuPOKLIdUhJXRLk+0tZRNqQLMG/GN5QHESxap34pjxgdthM
         zdmQ==
X-Gm-Message-State: AOAM533kWqDVeQEz732forA2TcK+LLVu5mlJfxMUpn4sSA/RFy4gbEcA
        ZwqJzgEcQKtv84CmXQJ0khs=
X-Google-Smtp-Source: ABdhPJxpL5KaAnDuQDJzuUb5KCGFxZ3YcW99M+WHBna9dnMuIO92XOsuZyqjUKOy0DftFppakeCj7Q==
X-Received: by 2002:a17:902:b210:b029:e6:33b4:cd9e with SMTP id t16-20020a170902b210b02900e633b4cd9emr3418197plr.67.1617809399828;
        Wed, 07 Apr 2021 08:29:59 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id f65sm22129550pgc.19.2021.04.07.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 08:29:58 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 00948402D7; Wed,  7 Apr 2021 15:29:56 +0000 (UTC)
Date:   Wed, 7 Apr 2021 15:29:56 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v1 1/1] kernel.h: Split out panic and oops helpers
Message-ID: <20210407152956.GE4332@42.do-not-panic.com>
References: <20210406133158.73700-1-andriy.shevchenko@linux.intel.com>
 <20210406165108.GA4332@42.do-not-panic.com>
 <CAHp75Ve9vBQqSegM2-ch9NUN-MdevxxOs5ZdHkk1W7AacN+Wrw@mail.gmail.com>
 <20210407143040.GB4332@42.do-not-panic.com>
 <CAHp75VeXiLa0b49eoZKVR1DSqTc9hKxpSgy294hMiaUzt0ugOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeXiLa0b49eoZKVR1DSqTc9hKxpSgy294hMiaUzt0ugOA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 05:59:19PM +0300, Andy Shevchenko wrote:
> On Wed, Apr 7, 2021 at 5:30 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > On Wed, Apr 07, 2021 at 10:33:44AM +0300, Andy Shevchenko wrote:
> > > On Wed, Apr 7, 2021 at 10:25 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > On Tue, Apr 06, 2021 at 04:31:58PM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > Why is it worth it to add another file just for this?
> > >
> > > The main point is to break tons of loops that prevent having clean
> > > headers anymore.
> > >
> > > In this case, see bug.h, which is very important in this sense.
> >
> > OK based on the commit log this was not clear, it seemed more of moving
> > panic stuff to its own file, so just cleanup.
> 
> Sorry for that. it should have mentioned the kernel folder instead of
> lib. But I think it won't clarify the above.
> 
> In any case there are several purposes in this case
>  - dropping dependency in bug.h
>  - dropping a loop by moving out panic_notifier.h
>  - unload kernel.h from something which has its own domain
> 
> I think that you are referring to the commit message describing 3rd
> one, but not 1st and 2nd.

Right!

> I will amend this for the future splits, thanks!

Don't get me wrong, I love the motivation behind just the 3rd purpose,
however I figured there might be something more when I saw panic_notifier.h.
It was just not clear.

But awesome stuff!

  Luis

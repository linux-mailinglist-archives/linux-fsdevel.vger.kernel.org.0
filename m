Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 312E1271C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2019 23:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730419AbfEVVjD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 May 2019 17:39:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46729 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbfEVVjC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 May 2019 17:39:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id 203so2781134oid.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2019 14:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8iUa3mR7n1QUqI0vPloid9MGvfKcIGgUfFxnULZ5+U=;
        b=GDelsoqQolX8vZ500TJnYRTrvx7UvzJ51bjddO3LDssDGEV/KLjn45OPSK1LoHb+pt
         vMc4fO10d8rFO9cUXhUOasQS1z00mtA/aaww0itHgEjxtv6/EtX/A5C4yrS8r08gyITU
         TA04J0efipr8o8Xl0BPEGjp/KEY0bIEgjzBYUxRrb7zqAvNHGycq9491MnB/928cEorF
         vcRKUxoGSumKvZMwAn4LVEhN0I/8thaBrCFiTKXFw9vQen81eDnsqy70p43bZYFnR6bP
         AEdEBccKUY3heoXvT17IcKdkpcaihfJ0EloODJeeR+bHCXp13wWqqLlXuKmTMbFs7kR8
         kJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8iUa3mR7n1QUqI0vPloid9MGvfKcIGgUfFxnULZ5+U=;
        b=DXwDWS9V/LPn7i3bfSEUA236wbbzdwgjtAXHIDUYORuoE/G8U1yCDC+aQb8aYsqqX/
         K0O0YgNolpXxnS5ld2uOlBcj5NbUZI2goKee7AzhnfDFzmX/1rgPtHNcAHp/iifEogAq
         dVzk9Jnq44lKLYmBdVC473EikkVCpI2s5seIoq9CfKFyoHVZIhRY1BNz1HhekFIR6211
         Sogt/2jIS6h//Sk5HmV5Jrw/uCyjJ0PXeViCrLZJR00m0HJNijQhK0vbOEL3p0FVA9nh
         m5c90GPP+Af40sXFQrQQcNSH2qVsPDoIPx0vqw+l2AI+m4CHnylSu/UGBh0DYshJTLP3
         PQqQ==
X-Gm-Message-State: APjAAAXz4OX6Z3z3Ln1XOrFqvXERyVQFMYIJWfjhFXAf7dTicP2Fsbft
        r7VyJ+LtoDVLd24RoCH5mLaThf6P++uurLP9ydnnkw==
X-Google-Smtp-Source: APXvYqwhyT9IyVUG9lkFu5kWtgvlKVPb/Q03tyBe4vbXVaiSv8N9Jry7yPQvyfivwOs/aXwiHN39BhvkHSSieLsYpPE=
X-Received: by 2002:aca:55d6:: with SMTP id j205mr565451oib.137.1558561141083;
 Wed, 22 May 2019 14:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190509133551.GD29703@mit.edu> <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com> <20190509214233.GA20877@mit.edu>
 <80c72e64-2665-bd51-f78c-97f50f9a53ba@gmail.com> <20190511173344.GA8507@mit.edu>
 <20190513144451.GQ17751@phenom.ffwll.local> <20190514060433.GA181462@google.com>
 <CAKMK7uHqtSF_sazJTbFL+xmQJRk4iwukCKZHoDHhsKkLXk=ECQ@mail.gmail.com>
 <20190514183618.GC109557@google.com> <20190515074141.GY17751@phenom.ffwll.local>
In-Reply-To: <20190515074141.GY17751@phenom.ffwll.local>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 22 May 2019 14:38:48 -0700
Message-ID: <CAFd5g476Hc+6jL5sV=VJamXCbqGebwHqqN9N9RppQYMCoo052Q@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Knut Omang <knut.omang@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jeff Dike <jdike@addtoit.com>, Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+Bjorn Helgaas

On Wed, May 15, 2019 at 12:41 AM Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Tue, May 14, 2019 at 11:36:18AM -0700, Brendan Higgins wrote:
> > On Tue, May 14, 2019 at 02:05:05PM +0200, Daniel Vetter wrote:
> > > On Tue, May 14, 2019 at 8:04 AM Brendan Higgins
> > > <brendanhiggins@google.com> wrote:
> > > >
> > > > On Mon, May 13, 2019 at 04:44:51PM +0200, Daniel Vetter wrote:
> > > > > On Sat, May 11, 2019 at 01:33:44PM -0400, Theodore Ts'o wrote:
> > > > > > On Fri, May 10, 2019 at 02:12:40PM -0700, Frank Rowand wrote:
> > > > > > > However, the reply is incorrect.  Kselftest in-kernel tests (which
> > > > > > > is the context here) can be configured as built in instead of as
> > > > > > > a module, and built in a UML kernel.  The UML kernel can boot,
> > > > > > > running the in-kernel tests before UML attempts to invoke the
> > > > > > > init process.
> > > > > >
> > > > > > Um, Citation needed?
> > > > > >
> > > > > > I don't see any evidence for this in the kselftest documentation, nor
> > > > > > do I see any evidence of this in the kselftest Makefiles.
> > > > > >
> > > > > > There exists test modules in the kernel that run before the init
> > > > > > scripts run --- but that's not strictly speaking part of kselftests,
> > > > > > and do not have any kind of infrastructure.  As noted, the
> > > > > > kselftests_harness header file fundamentally assumes that you are
> > > > > > running test code in userspace.
> > > > >
> > > > > Yeah I really like the "no userspace required at all" design of kunit,
> > > > > while still collecting results in a well-defined way (unless the current
> > > > > self-test that just run when you load the module, with maybe some
> > > > > kselftest ad-hoc wrapper around to collect the results).
> > > > >
> > > > > What I want to do long-term is to run these kernel unit tests as part of
> > > > > the build-testing, most likely in gitlab (sooner or later, for drm.git
> > > >
> > > > Totally! This is part of the reason I have been insisting on a minimum
> > > > of UML compatibility for all unit tests. If you can suffiently constrain
> > > > the environment that is required for tests to run in, it makes it much
> > > > easier not only for a human to run your tests, but it also makes it a
> > > > lot easier for an automated service to be able to run your tests.
> > > >
> > > > I actually have a prototype presubmit already working on my
> > > > "stable/non-upstream" branch. You can checkout what presubmit results
> > > > look like here[1][2].
> > >
> > > ug gerrit :-)
> >
> > Yeah, yeah, I know, but it is a lot easier for me to get a project set
> > up here using Gerrit, when we already use that for a lot of other
> > projects.
> >
> > Also, Gerrit has gotten a lot better over the last two years or so. Two
> > years ago, I wouldn't touch it with a ten foot pole. It's not so bad
> > anymore, at least if you are used to using a web UI to review code.
>
> I was somewhat joking, I'm just not used to gerrit ... And seems to indeed
> be a lot more polished than last time I looked at it seriously.

I mean, it is still not perfect, but I think it has finally gotten to
the point where I prefer it over reviewing by email for high context
patches where you don't expect a lot of deep discussion.

Still not great for patches where you want to have a lot of discussion.

> > > > > only ofc). So that people get their pull requests (and patch series, we
> > > > > have some ideas to tie this into patchwork) automatically tested for this
> > > >
> > > > Might that be Snowpatch[3]? I talked to Russell, the creator of Snowpatch,
> > > > and he seemed pretty open to collaboration.
> > > >
> > > > Before I heard about Snowpatch, I had an intern write a translation
> > > > layer that made Prow (the presubmit service that I used in the prototype
> > > > above) work with LKML[4].
> > >
> > > There's about 3-4 forks/clones of patchwork. snowpatch is one, we have
> > > a different one on freedesktop.org. It's a bit a mess :-/

I think Snowpatch is an ozlabs project; at least the maintainer works at IBM.

Patchwork originally was a ozlabs project, right?

Has any discussion taken place trying to consolidate some of the forks?

Presubmit clearly seems like a feature that a number of people want.

> > Oh, I didn't realize that. I found your patchwork instance here[5], but
> > do you have a place where I can see the changes you have added to
> > support presubmit?
>
> Ok here's a few links. Aside from the usual patch view we've also added a
> series view:
>
> https://patchwork.freedesktop.org/project/intel-gfx/series/?ordering=-last_updated
>
> This ties the patches + cover letter together, and it even (tries to at
> least) track revisions. Here's an example which is currently at revision
> 9:
>
> https://patchwork.freedesktop.org/series/57232/

Oooh, nice! That looks awesome! Looks like you have a number of presubmits too.

> Below the patch list for each revision we also have the test result list.
> If you click on the grey bar it'll expand with the summary from CI, the
> "See full logs" is link to the full results from our CI. This is driven
> with some REST api from our jenkins.
>
> Patchwork also sends out mails for these results.

Nice! There are obviously a lot of other bots on various kernel
mailing lists. Do you think people would object to sending presubmit
results to the mailing lists by default?

> Source is on gitlab: https://gitlab.freedesktop.org/patchwork-fdo

Err, looks like you forked from the ozlab's repo a good while ago.

Still, this all looks great!

> > > > I am not married to either approach, but I think between the two of
> > > > them, most of the initial legwork has been done to make presubmit on
> > > > LKML a reality.
> > >
> > > We do have presubmit CI working already with our freedesktop.org
> > > patchwork. The missing glue is just tying that into gitlab CI somehow
> > > (since we want to unify build testing more and make it easier for
> > > contributors to adjust things).
> >
> > I checked out a couple of your projects on your patchwork instance: AMD
> > X.Org drivers, DRI devel, and Wayland. I saw the tab you added for
> > tests, but none of them actually had any test results. Can you point me
> > at one that does?
>
> Atm we use the CI stuff only on intel-gfx, with the our gpu CI farm, see
> links above.
>
> Cheers, Daniel
>
> >
> > Cheers!
> >
> > [5] https://patchwork.freedesktop.org/
> >
> > > > > super basic stuff.
> > > >
> > > > I am really excited to hear back on what you think!
> > > >
> > > > Cheers!
> > > >
> > > > [1] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-7bfa40efb132e15c8388755c273837559911425c
> > > > [2] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-a6784496eafff442ac98fb068bf1a0f36ee73509
> > > > [3] https://developer.ibm.com/open/projects/snowpatch/
> > > > [4] https://kunit.googlesource.com/prow-lkml/
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel

Cheers!

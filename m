Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 995911CF22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 20:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfENSg1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 14:36:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33942 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfENSg1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 14:36:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so9585760pfa.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kgrCvI66v1eNqCFIEetHipPbY2Pg16O5TtUnu8MLeKU=;
        b=gUDKqjEsr8Qv/Y/RdIi8Q0i7FwdadH/D5if9+lYhE9eNQ7LD2B70LCDjDacGxm/FVd
         7kNk5FVNgjwADCYAgcq7jDXk1GJDmyZ0Kh9Gx1ZgwB42ZvxUY0Ix0Sc6YTHp4jc2OTit
         wIpv9ZoVwEXLXTtC0OYc2rhNj0FLGzUxHwUjYJgkKxJYgKIgxENPIfowWiBpTDqrDXJR
         aV5ZOSNgafVxar7tXD+7n837g3sPSNo8qbLCnklS6BGK4TPE6mpuNgU2xapU2LGoeVW3
         VHuSjX0KcDsjpdugWjGvtUgdMmqQOHw13R3aNbCEwTZebS+H4VHnLozq+d5p3UypFj6x
         1Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kgrCvI66v1eNqCFIEetHipPbY2Pg16O5TtUnu8MLeKU=;
        b=h1dqFK1FC6PLJ1IgG0HWY2lV7SbLK4zSeaypkXXiRabb+wEZ4ZPcVAF+bzd4KsY8v/
         RU0d1FSmORX1E1ZVXdC3pQpmkeszPRxGmH5hZcno0HfTC5zdItpiCpoJWdgK/IvVoQcf
         l3PiUgAs6m/Cps5FEtEhKMnZCYtWYR+XVZFdCv2VrovEbzWaQK6M/BzbfnWISSthPXxN
         +2LOkJo78kTWhnPQD3BmKtUFaCmyybb9TjF4g+Jdr2qAG97oHbPgr3aoq4W73V6BVJzY
         PxpmXhDtbyLsh46D6JVdPxpHyc7pI50WBUP9YCxW1L/axgkUZFumpWG5d/Hdq0GC6pTF
         0S3w==
X-Gm-Message-State: APjAAAU76XVXABFPoHPbFkLu2zqG2S8w9OM1grccl8L15bQsUjOlD4Dm
        T3NxykP8p4lpKdTb4FUGuuluiA==
X-Google-Smtp-Source: APXvYqxx/zB3rhnaNxCnfVL/D4G9BC9H3ZRHO1zmfqf3pl1LMALbOUIKd0jSHjCRuQTB7Pn9vuxzCg==
X-Received: by 2002:a62:e205:: with SMTP id a5mr4433129pfi.40.1557858985424;
        Tue, 14 May 2019 11:36:25 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
        by smtp.gmail.com with ESMTPSA id u6sm10940875pfa.1.2019.05.14.11.36.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 11:36:24 -0700 (PDT)
Date:   Tue, 14 May 2019 11:36:18 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Frank Rowand <frowand.list@gmail.com>, Tim.Bird@sony.com,
        Knut Omang <knut.omang@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, sboyd@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>, jdike@addtoit.com,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190514183618.GC109557@google.com>
References: <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <80c72e64-2665-bd51-f78c-97f50f9a53ba@gmail.com>
 <20190511173344.GA8507@mit.edu>
 <20190513144451.GQ17751@phenom.ffwll.local>
 <20190514060433.GA181462@google.com>
 <CAKMK7uHqtSF_sazJTbFL+xmQJRk4iwukCKZHoDHhsKkLXk=ECQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHqtSF_sazJTbFL+xmQJRk4iwukCKZHoDHhsKkLXk=ECQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 14, 2019 at 02:05:05PM +0200, Daniel Vetter wrote:
> On Tue, May 14, 2019 at 8:04 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Mon, May 13, 2019 at 04:44:51PM +0200, Daniel Vetter wrote:
> > > On Sat, May 11, 2019 at 01:33:44PM -0400, Theodore Ts'o wrote:
> > > > On Fri, May 10, 2019 at 02:12:40PM -0700, Frank Rowand wrote:
> > > > > However, the reply is incorrect.  Kselftest in-kernel tests (which
> > > > > is the context here) can be configured as built in instead of as
> > > > > a module, and built in a UML kernel.  The UML kernel can boot,
> > > > > running the in-kernel tests before UML attempts to invoke the
> > > > > init process.
> > > >
> > > > Um, Citation needed?
> > > >
> > > > I don't see any evidence for this in the kselftest documentation, nor
> > > > do I see any evidence of this in the kselftest Makefiles.
> > > >
> > > > There exists test modules in the kernel that run before the init
> > > > scripts run --- but that's not strictly speaking part of kselftests,
> > > > and do not have any kind of infrastructure.  As noted, the
> > > > kselftests_harness header file fundamentally assumes that you are
> > > > running test code in userspace.
> > >
> > > Yeah I really like the "no userspace required at all" design of kunit,
> > > while still collecting results in a well-defined way (unless the current
> > > self-test that just run when you load the module, with maybe some
> > > kselftest ad-hoc wrapper around to collect the results).
> > >
> > > What I want to do long-term is to run these kernel unit tests as part of
> > > the build-testing, most likely in gitlab (sooner or later, for drm.git
> >
> > Totally! This is part of the reason I have been insisting on a minimum
> > of UML compatibility for all unit tests. If you can suffiently constrain
> > the environment that is required for tests to run in, it makes it much
> > easier not only for a human to run your tests, but it also makes it a
> > lot easier for an automated service to be able to run your tests.
> >
> > I actually have a prototype presubmit already working on my
> > "stable/non-upstream" branch. You can checkout what presubmit results
> > look like here[1][2].
> 
> ug gerrit :-)

Yeah, yeah, I know, but it is a lot easier for me to get a project set
up here using Gerrit, when we already use that for a lot of other
projects.

Also, Gerrit has gotten a lot better over the last two years or so. Two
years ago, I wouldn't touch it with a ten foot pole. It's not so bad
anymore, at least if you are used to using a web UI to review code.

> > > only ofc). So that people get their pull requests (and patch series, we
> > > have some ideas to tie this into patchwork) automatically tested for this
> >
> > Might that be Snowpatch[3]? I talked to Russell, the creator of Snowpatch,
> > and he seemed pretty open to collaboration.
> >
> > Before I heard about Snowpatch, I had an intern write a translation
> > layer that made Prow (the presubmit service that I used in the prototype
> > above) work with LKML[4].
> 
> There's about 3-4 forks/clones of patchwork. snowpatch is one, we have
> a different one on freedesktop.org. It's a bit a mess :-/

Oh, I didn't realize that. I found your patchwork instance here[5], but
do you have a place where I can see the changes you have added to
support presubmit?

> > I am not married to either approach, but I think between the two of
> > them, most of the initial legwork has been done to make presubmit on
> > LKML a reality.
> 
> We do have presubmit CI working already with our freedesktop.org
> patchwork. The missing glue is just tying that into gitlab CI somehow
> (since we want to unify build testing more and make it easier for
> contributors to adjust things).

I checked out a couple of your projects on your patchwork instance: AMD
X.Org drivers, DRI devel, and Wayland. I saw the tab you added for
tests, but none of them actually had any test results. Can you point me
at one that does?

Cheers!

[5] https://patchwork.freedesktop.org/

> > > super basic stuff.
> >
> > I am really excited to hear back on what you think!
> >
> > Cheers!
> >
> > [1] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-7bfa40efb132e15c8388755c273837559911425c
> > [2] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-a6784496eafff442ac98fb068bf1a0f36ee73509
> > [3] https://developer.ibm.com/open/projects/snowpatch/
> > [4] https://kunit.googlesource.com/prow-lkml/
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel


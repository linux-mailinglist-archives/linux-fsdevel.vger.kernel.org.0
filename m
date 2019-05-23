Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31BC827836
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 10:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbfEWIkO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 04:40:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33726 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWIkN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 04:40:13 -0400
Received: by mail-ed1-f68.google.com with SMTP id n17so8113415edb.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 01:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OtO3pn3g+W5AJ1zDc3bZ1Gi7BUopJKS5bXtOM69PFV0=;
        b=lq0MyFEeRcjMOqOeV3+f0i+TJjbwdAlfr6V7mYhQGHiFiyqULL6S2+Syj4bf4Ap+X1
         LTiy/HFPl8cYz36rVJ8eFk1gpYRLbr8SuDawjh76uT+RILl5tWpijdVhlyN7ntHtzA3K
         PNyVHRqlLgXqxpA59M9A3TUICNOzB/ZluRNqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=OtO3pn3g+W5AJ1zDc3bZ1Gi7BUopJKS5bXtOM69PFV0=;
        b=df07ZQLJMVq72abVRXWXPgWzpqwB+g6/uRuLRSfJMNL0KKSmi4DDqXm8jqEX52Qi+y
         ryKnsI4ieUINYLfkMfhK2Z5xEgcOJ4YsYaS/dUjgE4eODieexcSNFEqAR1wpZEr2dDNr
         KM+SbJpEcK34EHXK95zzfSCavIA0jb51acvVtlQDYX7nVXVVFXbj9YestY1vdkaKxpwr
         tqWrtbrsgWMnw/jzZeugP7zX8THf0Qc3W7PgryqhoKBh19Ye4HqafwSnIWmJV9nI3CD3
         SDXD3Ha7D1ThM/wxwt96gd0VCpSxBnShll8e5bGAsMe6UVu6bcZR9hUsmwYlgvnnLAa7
         Wt/A==
X-Gm-Message-State: APjAAAXojjDKrLE+cqtJ7o7DNITlf6PowFzRe+XqqqLQQKc9G/bGayoo
        +TeTFSQg73vDD0bhCK8snKkPuA==
X-Google-Smtp-Source: APXvYqz8Y+bfkGbAgCjaoic1YwZ2Mzn/1QL4hnOd08WL9imIzBVyErPfVOS7r/O39NeU8f+1ffyFzw==
X-Received: by 2002:a17:906:4995:: with SMTP id p21mr47837157eju.140.1558600810787;
        Thu, 23 May 2019 01:40:10 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id a40sm7754430edd.1.2019.05.23.01.40.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 May 2019 01:40:09 -0700 (PDT)
Date:   Thu, 23 May 2019 10:40:06 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
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
        Bjorn Helgaas <bhelgaas@google.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190523084006.GW21222@phenom.ffwll.local>
Mail-Followup-To: Brendan Higgins <brendanhiggins@google.com>,
        Theodore Ts'o <tytso@mit.edu>,
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
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
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
        Petr Mladek <pmladek@suse.com>, Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Bjorn Helgaas <bhelgaas@google.com>
References: <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <80c72e64-2665-bd51-f78c-97f50f9a53ba@gmail.com>
 <20190511173344.GA8507@mit.edu>
 <20190513144451.GQ17751@phenom.ffwll.local>
 <20190514060433.GA181462@google.com>
 <CAKMK7uHqtSF_sazJTbFL+xmQJRk4iwukCKZHoDHhsKkLXk=ECQ@mail.gmail.com>
 <20190514183618.GC109557@google.com>
 <20190515074141.GY17751@phenom.ffwll.local>
 <CAFd5g476Hc+6jL5sV=VJamXCbqGebwHqqN9N9RppQYMCoo052Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g476Hc+6jL5sV=VJamXCbqGebwHqqN9N9RppQYMCoo052Q@mail.gmail.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 22, 2019 at 02:38:48PM -0700, Brendan Higgins wrote:
> +Bjorn Helgaas
> 
> On Wed, May 15, 2019 at 12:41 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Tue, May 14, 2019 at 11:36:18AM -0700, Brendan Higgins wrote:
> > > On Tue, May 14, 2019 at 02:05:05PM +0200, Daniel Vetter wrote:
> > > > On Tue, May 14, 2019 at 8:04 AM Brendan Higgins
> > > > <brendanhiggins@google.com> wrote:
> > > > >
> > > > > On Mon, May 13, 2019 at 04:44:51PM +0200, Daniel Vetter wrote:
> > > > > > On Sat, May 11, 2019 at 01:33:44PM -0400, Theodore Ts'o wrote:
> > > > > > > On Fri, May 10, 2019 at 02:12:40PM -0700, Frank Rowand wrote:
> > > > > > > > However, the reply is incorrect.  Kselftest in-kernel tests (which
> > > > > > > > is the context here) can be configured as built in instead of as
> > > > > > > > a module, and built in a UML kernel.  The UML kernel can boot,
> > > > > > > > running the in-kernel tests before UML attempts to invoke the
> > > > > > > > init process.
> > > > > > >
> > > > > > > Um, Citation needed?
> > > > > > >
> > > > > > > I don't see any evidence for this in the kselftest documentation, nor
> > > > > > > do I see any evidence of this in the kselftest Makefiles.
> > > > > > >
> > > > > > > There exists test modules in the kernel that run before the init
> > > > > > > scripts run --- but that's not strictly speaking part of kselftests,
> > > > > > > and do not have any kind of infrastructure.  As noted, the
> > > > > > > kselftests_harness header file fundamentally assumes that you are
> > > > > > > running test code in userspace.
> > > > > >
> > > > > > Yeah I really like the "no userspace required at all" design of kunit,
> > > > > > while still collecting results in a well-defined way (unless the current
> > > > > > self-test that just run when you load the module, with maybe some
> > > > > > kselftest ad-hoc wrapper around to collect the results).
> > > > > >
> > > > > > What I want to do long-term is to run these kernel unit tests as part of
> > > > > > the build-testing, most likely in gitlab (sooner or later, for drm.git
> > > > >
> > > > > Totally! This is part of the reason I have been insisting on a minimum
> > > > > of UML compatibility for all unit tests. If you can suffiently constrain
> > > > > the environment that is required for tests to run in, it makes it much
> > > > > easier not only for a human to run your tests, but it also makes it a
> > > > > lot easier for an automated service to be able to run your tests.
> > > > >
> > > > > I actually have a prototype presubmit already working on my
> > > > > "stable/non-upstream" branch. You can checkout what presubmit results
> > > > > look like here[1][2].
> > > >
> > > > ug gerrit :-)
> > >
> > > Yeah, yeah, I know, but it is a lot easier for me to get a project set
> > > up here using Gerrit, when we already use that for a lot of other
> > > projects.
> > >
> > > Also, Gerrit has gotten a lot better over the last two years or so. Two
> > > years ago, I wouldn't touch it with a ten foot pole. It's not so bad
> > > anymore, at least if you are used to using a web UI to review code.
> >
> > I was somewhat joking, I'm just not used to gerrit ... And seems to indeed
> > be a lot more polished than last time I looked at it seriously.
> 
> I mean, it is still not perfect, but I think it has finally gotten to
> the point where I prefer it over reviewing by email for high context
> patches where you don't expect a lot of deep discussion.
> 
> Still not great for patches where you want to have a lot of discussion.
> 
> > > > > > only ofc). So that people get their pull requests (and patch series, we
> > > > > > have some ideas to tie this into patchwork) automatically tested for this
> > > > >
> > > > > Might that be Snowpatch[3]? I talked to Russell, the creator of Snowpatch,
> > > > > and he seemed pretty open to collaboration.
> > > > >
> > > > > Before I heard about Snowpatch, I had an intern write a translation
> > > > > layer that made Prow (the presubmit service that I used in the prototype
> > > > > above) work with LKML[4].
> > > >
> > > > There's about 3-4 forks/clones of patchwork. snowpatch is one, we have
> > > > a different one on freedesktop.org. It's a bit a mess :-/
> 
> I think Snowpatch is an ozlabs project; at least the maintainer works at IBM.
> 
> Patchwork originally was a ozlabs project, right?

So there's two patchworks (snowpatch makes the 3rd): the one on
freedesktop is another fork.

> Has any discussion taken place trying to consolidate some of the forks?

Yup, but didn't lead anywhere unfortunately :-/ At least between patchwork
and patchwork-fdo, I think snowpatch happened in parallel and once it was
done it's kinda too late. The trouble is that they all have slightly
different REST api and functionality, so for CI integration you can't just
switch one for the other.

> Presubmit clearly seems like a feature that a number of people want.
> 
> > > Oh, I didn't realize that. I found your patchwork instance here[5], but
> > > do you have a place where I can see the changes you have added to
> > > support presubmit?
> >
> > Ok here's a few links. Aside from the usual patch view we've also added a
> > series view:
> >
> > https://patchwork.freedesktop.org/project/intel-gfx/series/?ordering=-last_updated
> >
> > This ties the patches + cover letter together, and it even (tries to at
> > least) track revisions. Here's an example which is currently at revision
> > 9:
> >
> > https://patchwork.freedesktop.org/series/57232/
> 
> Oooh, nice! That looks awesome! Looks like you have a number of presubmits too.

We have a pretty big farm of machines that mostly just crunch through
premerge patch series. postmerge is mostly just for statistics (so we can
find the sporadic failures and better characterize them).

> > Below the patch list for each revision we also have the test result list.
> > If you click on the grey bar it'll expand with the summary from CI, the
> > "See full logs" is link to the full results from our CI. This is driven
> > with some REST api from our jenkins.
> >
> > Patchwork also sends out mails for these results.
> 
> Nice! There are obviously a lot of other bots on various kernel
> mailing lists. Do you think people would object to sending presubmit
> results to the mailing lists by default?
> 
> > Source is on gitlab: https://gitlab.freedesktop.org/patchwork-fdo
> 
> Err, looks like you forked from the ozlab's repo a good while ago.

Yeah see above, it's a bit a complicated story. I think there's a total of
3 patchworks now :-/

> Still, this all looks great!

Cheers, Daniel

> 
> > > > > I am not married to either approach, but I think between the two of
> > > > > them, most of the initial legwork has been done to make presubmit on
> > > > > LKML a reality.
> > > >
> > > > We do have presubmit CI working already with our freedesktop.org
> > > > patchwork. The missing glue is just tying that into gitlab CI somehow
> > > > (since we want to unify build testing more and make it easier for
> > > > contributors to adjust things).
> > >
> > > I checked out a couple of your projects on your patchwork instance: AMD
> > > X.Org drivers, DRI devel, and Wayland. I saw the tab you added for
> > > tests, but none of them actually had any test results. Can you point me
> > > at one that does?
> >
> > Atm we use the CI stuff only on intel-gfx, with the our gpu CI farm, see
> > links above.
> >
> > Cheers, Daniel
> >
> > >
> > > Cheers!
> > >
> > > [5] https://patchwork.freedesktop.org/
> > >
> > > > > > super basic stuff.
> > > > >
> > > > > I am really excited to hear back on what you think!
> > > > >
> > > > > Cheers!
> > > > >
> > > > > [1] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-7bfa40efb132e15c8388755c273837559911425c
> > > > > [2] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-a6784496eafff442ac98fb068bf1a0f36ee73509
> > > > > [3] https://developer.ibm.com/open/projects/snowpatch/
> > > > > [4] https://kunit.googlesource.com/prow-lkml/
> > > > > _______________________________________________
> > > > > dri-devel mailing list
> > > > > dri-devel@lists.freedesktop.org
> > > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> Cheers!

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

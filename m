Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0981D1C828
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 14:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfENMFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 08:05:19 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44852 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfENMFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 08:05:19 -0400
Received: by mail-io1-f67.google.com with SMTP id f22so12595593iol.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 05:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3cCt7Fv9PrSN+POfdDA9BhvmV9/m6Z9B8cT0V9l7bcU=;
        b=a7BcpiAa3cXS6NukeVFgCH7xf3ARmd8J6e/ULZ0a8xqTBwTNaq+N8QguChZh3uzW7f
         kWHSY7qQUZbeMlUwXYdXunYt1ZQd2SKBDUTXd3jKW+KmrJ1DqqIRVtLYOVb1f+tEQL2N
         W7DqiSEqrT+k9VDAEFt9iTN+c6I6bW1EG18JM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cCt7Fv9PrSN+POfdDA9BhvmV9/m6Z9B8cT0V9l7bcU=;
        b=bFN+EGiEOp8rlVWqBNMwukYvBZo/1oQOCrq7hH+Cor6SfMdpv7x8gzxSuTfRzut2PB
         BjBdFs5GwPU4fO3HxWxBnTP9Yeg/bAAbAQdH7SfzjIdlV3kU87VivAnZ7bXDCrKcgn0n
         9z+NA+a7WlLVcWNrUDOW2+z856MJLPmH4XOCODDRAWRNyqOVYed9RCkq4dxu5ZMkU6Vo
         YvdrTFb8KLtONDZjZ0VxX+Y2+3H42PVA1YdW5q7SWEcemdpmKBHFTuhFmDjqMLx3KBNg
         ZKWui6vW4aIgAA0QG6S3+2KwTQi1PMkDQQQFS2aJikC7o+NUBntFh0mYbWlOiMe34gEx
         MfIw==
X-Gm-Message-State: APjAAAVPwzkNTZw+CaUYhfaPuVIGWkO23nVb6UTO20JK6RUljYFzqauY
        73Xwsbtuo8Ri8o7ftYpVoHsEQVlk983Slv6r1cDYoQ==
X-Google-Smtp-Source: APXvYqyhBqCsjjVPPpuo20Er/14b4Noh22uMAdPO6o3WUMvHLuILgjBTMJK3Dh0BqwvOEYcjDaa/KDS4xlT8iYcmIUQ=
X-Received: by 2002:a6b:b654:: with SMTP id g81mr3614153iof.34.1557835518050;
 Tue, 14 May 2019 05:05:18 -0700 (PDT)
MIME-Version: 1.0
References: <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu> <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu> <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com> <20190509214233.GA20877@mit.edu>
 <80c72e64-2665-bd51-f78c-97f50f9a53ba@gmail.com> <20190511173344.GA8507@mit.edu>
 <20190513144451.GQ17751@phenom.ffwll.local> <20190514060433.GA181462@google.com>
In-Reply-To: <20190514060433.GA181462@google.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 14 May 2019 14:05:05 +0200
Message-ID: <CAKMK7uHqtSF_sazJTbFL+xmQJRk4iwukCKZHoDHhsKkLXk=ECQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 14, 2019 at 8:04 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Mon, May 13, 2019 at 04:44:51PM +0200, Daniel Vetter wrote:
> > On Sat, May 11, 2019 at 01:33:44PM -0400, Theodore Ts'o wrote:
> > > On Fri, May 10, 2019 at 02:12:40PM -0700, Frank Rowand wrote:
> > > > However, the reply is incorrect.  Kselftest in-kernel tests (which
> > > > is the context here) can be configured as built in instead of as
> > > > a module, and built in a UML kernel.  The UML kernel can boot,
> > > > running the in-kernel tests before UML attempts to invoke the
> > > > init process.
> > >
> > > Um, Citation needed?
> > >
> > > I don't see any evidence for this in the kselftest documentation, nor
> > > do I see any evidence of this in the kselftest Makefiles.
> > >
> > > There exists test modules in the kernel that run before the init
> > > scripts run --- but that's not strictly speaking part of kselftests,
> > > and do not have any kind of infrastructure.  As noted, the
> > > kselftests_harness header file fundamentally assumes that you are
> > > running test code in userspace.
> >
> > Yeah I really like the "no userspace required at all" design of kunit,
> > while still collecting results in a well-defined way (unless the current
> > self-test that just run when you load the module, with maybe some
> > kselftest ad-hoc wrapper around to collect the results).
> >
> > What I want to do long-term is to run these kernel unit tests as part of
> > the build-testing, most likely in gitlab (sooner or later, for drm.git
>
> Totally! This is part of the reason I have been insisting on a minimum
> of UML compatibility for all unit tests. If you can suffiently constrain
> the environment that is required for tests to run in, it makes it much
> easier not only for a human to run your tests, but it also makes it a
> lot easier for an automated service to be able to run your tests.
>
> I actually have a prototype presubmit already working on my
> "stable/non-upstream" branch. You can checkout what presubmit results
> look like here[1][2].

ug gerrit :-)

> > only ofc). So that people get their pull requests (and patch series, we
> > have some ideas to tie this into patchwork) automatically tested for this
>
> Might that be Snowpatch[3]? I talked to Russell, the creator of Snowpatch,
> and he seemed pretty open to collaboration.
>
> Before I heard about Snowpatch, I had an intern write a translation
> layer that made Prow (the presubmit service that I used in the prototype
> above) work with LKML[4].

There's about 3-4 forks/clones of patchwork. snowpatch is one, we have
a different one on freedesktop.org. It's a bit a mess :-/

> I am not married to either approach, but I think between the two of
> them, most of the initial legwork has been done to make presubmit on
> LKML a reality.

We do have presubmit CI working already with our freedesktop.org
patchwork. The missing glue is just tying that into gitlab CI somehow
(since we want to unify build testing more and make it easier for
contributors to adjust things).
-Daniel

> > super basic stuff.
>
> I am really excited to hear back on what you think!
>
> Cheers!
>
> [1] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-7bfa40efb132e15c8388755c273837559911425c
> [2] https://kunit-review.googlesource.com/c/linux/+/1509/10#message-a6784496eafff442ac98fb068bf1a0f36ee73509
> [3] https://developer.ibm.com/open/projects/snowpatch/
> [4] https://kunit.googlesource.com/prow-lkml/
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

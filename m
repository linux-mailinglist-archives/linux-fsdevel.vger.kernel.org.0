Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC4F013606
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2019 01:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfECXPC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 19:15:02 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36279 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfECXPC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 19:15:02 -0400
Received: by mail-oi1-f193.google.com with SMTP id l203so5701155oia.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2019 16:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YiBKDqzegd04O+PzAcr7R/FeGobNFYgVSfswMBcZCZU=;
        b=SXAm3yjCa0nibHXK4ceAAGFs6uCwaUpLsdyCU1o2lKOvlI3rqheWTpKnj2wyShZ7lu
         TPJifTqWsstn9qWG7fCugTMkSy8sDN1Wk1HhrgYmZcpapX1zR4GB6osSwq4oYO68ERug
         m0zSS0SWlzMDnDTsEAVvAyt86c9z8vzc3wqoXGPWKAEB7EiOd+Kh78da/TO1uS4+hvXu
         KHDx+3hb12TUOvvVeISvhVNnosdHc8Tl78soob4D9ge86intpqwkzZ5hweRv3v6ENiSu
         1rA6a30tpPPT6VjU3M1ZMvAEXkExGqUONafw5xmmYaV8aTHBJJADG16CXD8P/IByq2ER
         s7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YiBKDqzegd04O+PzAcr7R/FeGobNFYgVSfswMBcZCZU=;
        b=ri3g9wluRfqjBaAJt5WHAm7LlKh/zJPmo7pcteNPkAQJYtmPfI/wZfBx1SsJuIBOpr
         K0m72DRp0TkAb6TLwM//9B21GZDpuPxTuBZUDFBoUym+6VbL2MrJQxp2450w04I2fEeQ
         YSur0091We8nmga3YhBJgohVCq7JMmGlCe3i+fbrYrtVmM17qQb34Q3LSX1cHqpRuzm0
         HObyYOHOa5tCeb0d08QfksKMgbVlIf03iko4vnG4xelIfOr8paIrxWiKAhF6XzBSoHRk
         APHoTTm5VkAVYW5FEH42gKl6/qfTSWccipaug0DREz3c+E1ydMudSNeV9SbNaE/588ow
         ocAQ==
X-Gm-Message-State: APjAAAXrmaQfmG+fyddOcmzIVhdu6wZK0COsnHfccBVN/TZRZOyZMr9q
        QZGD/AuJWGCk4wKQBEWx2R/FLpK3EgiZzgzO3grc1w==
X-Google-Smtp-Source: APXvYqy8jY7gfDI7WH+mEtQuPQSGdDFLmcOn9yaaI5FbZz82XQ12EIWD3sphcpnXXnG85dXFQdhExQpRbCPKPfTjxbk=
X-Received: by 2002:aca:43d5:: with SMTP id q204mr880835oia.100.1556925301033;
 Fri, 03 May 2019 16:15:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-13-brendanhiggins@google.com> <20190502110220.GD12416@kroah.com>
 <CAFd5g47t=EdLKFCT=CnPkrM2z0nDVo24Gz4j0VxFOJbARP37Lg@mail.gmail.com>
 <a49c5088-a821-210c-66de-f422536f5b01@gmail.com> <CAFd5g44iWRchQKdJYtjRtPY6e-6e0eXpKXXsx5Ooi6sWE474KA@mail.gmail.com>
 <1a5f3c44-9fa9-d423-66bf-45255a90c468@gmail.com> <CAFd5g45RYm+zfdJXnyp2KZZH5ojfOzy++aq+4zBeE5VDu6WgEw@mail.gmail.com>
 <052fa196-4ea9-8384-79b7-fe6bacc0ee82@gmail.com>
In-Reply-To: <052fa196-4ea9-8384-79b7-fe6bacc0ee82@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 3 May 2019 16:14:49 -0700
Message-ID: <CAFd5g47aY-CL+d7DfiyTidY4aAVY+eg1TM1UJ4nYqKSfHOi-0w@mail.gmail.com>
Subject: Re: [PATCH v2 12/17] kunit: tool: add Python wrappers for running
 KUnit tests
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> On 5/2/19 10:36 PM, Brendan Higgins wrote:
> > On Thu, May 2, 2019 at 6:45 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>
> >> On 5/2/19 4:45 PM, Brendan Higgins wrote:
> >>> On Thu, May 2, 2019 at 2:16 PM Frank Rowand <frowand.list@gmail.com> wrote:
> >>>>
> >>>> On 5/2/19 11:07 AM, Brendan Higgins wrote:
> >>>>> On Thu, May 2, 2019 at 4:02 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>>>>>
> >>>>>> On Wed, May 01, 2019 at 04:01:21PM -0700, Brendan Higgins wrote:
> >>>>>>> From: Felix Guo <felixguoxiuping@gmail.com>
> >>>>>>>
> >>>>>>> The ultimate goal is to create minimal isolated test binaries; in the
> >>>>>>> meantime we are using UML to provide the infrastructure to run tests, so
> >>>>>>> define an abstract way to configure and run tests that allow us to
> >>>>>>> change the context in which tests are built without affecting the user.
> >>>>>>> This also makes pretty and dynamic error reporting, and a lot of other
> >>>>>>> nice features easier.
> >>>>>>>
> >>>>>>> kunit_config.py:
> >>>>>>>   - parse .config and Kconfig files.
> >>>>>>>
> >>>>>>> kunit_kernel.py: provides helper functions to:
> >>>>>>>   - configure the kernel using kunitconfig.
> >>>>>>>   - build the kernel with the appropriate configuration.
> >>>>>>>   - provide function to invoke the kernel and stream the output back.
> >>>>>>>
> >>>>>>> Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> >>>>>>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> >>>>>>
> >>>>>> Ah, here's probably my answer to my previous logging format question,
> >>>>>> right?  What's the chance that these wrappers output stuff in a standard
> >>>>>> format that test-framework-tools can already parse?  :)
> >>>
> >>> To be clear, the test-framework-tools format we are talking about is
> >>> TAP13[1], correct?
> >>
> >> I'm not sure what the test community prefers for a format.  I'll let them
> >> jump in and debate that question.
> >>
> >>
> >>>
> >>> My understanding is that is what kselftest is being converted to use.
> >>>
> >>>>>
> >>>>> It should be pretty easy to do. I had some patches that pack up the
> >>>>> results into a serialized format for a presubmit service; it should be
> >>>>> pretty straightforward to take the same logic and just change the
> >>>>> output format.
> >>>>
> >>>> When examining and trying out the previous versions of the patch I found
> >>>> the wrappers useful to provide information about how to control and use
> >>>> the tests, but I had no interest in using the scripts as they do not
> >>>> fit in with my personal environment and workflow.
> >>>>
> >>>> In the previous versions of the patch, these helper scripts are optional,
> >>>> which is good for my use case.  If the helper scripts are required to
> >>>
> >>> They are still optional.
> >>>
> >>>> get the data into the proper format then the scripts are not quite so
> >>>> optional, they become the expected environment.  I think the proper
> >>>> format should exist without the helper scripts.
> >>>
> >>> That's a good point. A couple things,
> >>>
> >>> First off, supporting TAP13, either in the kernel or the wrapper
> >>> script is not hard, but I don't think that is the real issue that you
> >>> raise.
> >>>
> >>> If your only concern is that you will always be able to have human
> >>> readable KUnit results printed to the kernel log, that is a guarantee
> >>> I feel comfortable making. Beyond that, I think it is going to take a
> >>> long while before I would feel comfortable guaranteeing anything about
> >>> how will KUnit work, what kind of data it will want to expose, and how
> >>> it will be organized. I think the wrapper script provides a nice
> >>> facade that I can maintain, can mediate between the implementation
> >>> details and the user, and can mediate between the implementation
> >>> details and other pieces of software that might want to consume
> >>> results.
> >>>
> >>> [1] https://testanything.org/tap-version-13-specification.html
> >>
> >> My concern is based on a focus on my little part of the world
> >> (which in _previous_ versions of the patch series was the devicetree
> >> unittest.c tests being converted to use the kunit infrastructure).
> >> If I step back and think of the entire kernel globally I may end
> >> up with a different conclusion - but I'm going to remain myopic
> >> for this email.
> >>
> >> I want the test results to be usable by me and my fellow
> >> developers.  I prefer that the test results be easily accessible
> >> (current printk() implementation means that kunit messages are
> >> just as accessible as the current unittest.c printk() output).
> >> If the printk() output needs to be filtered through a script
> >> to generate the actual test results then that is sub-optimal
> >> to me.  It is one more step added to my workflow.  And
> >> potentially with an embedded target a major pain to get a
> >> data file (the kernel log file) transferred from a target
> >> to my development host.
> >
> > That's fair. If that is indeed your only concern, then I don't think
> > the wrapper script will ever be an issue for you. You will always be
> > able to execute a given test the old fashioned/manual way, and the
> > wrapper script only summarizes results, it does not change the
> > contents.
> >
> >>
> >> I want a reported test failure to be easy to trace back to the
> >> point in the source where the failure is reported.  With printk()
> >> the search is a simple grep for the failure message.  If the
> >> failure message has been processed by a script, and then the
> >> failure reported to me in an email, then I may have to look
> >> at the script to reverse engineer how the original failure
> >> message was transformed into the message that was reported
> >> to me in the email.  Then I search for the point in the
> >> source where the failure is reported.  So a basic task has
> >> just become more difficult and time consuming.
> >
> > That seems to be a valid concern. I would reiterate that you shouldn't
> > be concerned by any processing done by the wrapper script itself, but
> > the reality is that depending on what happens with automated
> > testing/presubmit/CI other people might end up parsing and
> > transforming test results - it might happen, it might not.
>
> You seem to be missing my point.
>
> Greg asked that the output be in a standard format.
>
> You replied that the standard format could be created by the wrapper script.

I thought Greg originally meant that that is how it could be done when
he first commented on this patch, so I was agreeing and elaborating.
Nevertheless, it seems you and Greg are now in agreement on this
point, so I won't argue it further.

>
> Now you say that "it might happen, it might not".  In other words the output
> may or may not end up in the standard format.

Sorry, that was in reference to your concern about getting an email in
a different format than what the tool that you use generates. It
wasn't a statement about what I was or wasn't going to do in regards
to supporting a standard format.

>
> As Greg points out in comments to patch 12:
>
>   "The core of kunit should also log the messages in this format as well,
>   and not rely on the helper scripts as Frank points out, not everyone
>   will use/want them.  Might as well make it easy for everyone to always
>   do the right thing and not force it to always be added in later."
>
> I am requesting that the original message be in the standard format.  Of
> course anyone is free to transform the messages in later processing, no
> big deal.

My mistake, I thought that was a concern of yours.

In any case, it sounds like you and Greg are in agreement on the core
libraries generating the output in TAP13, so I won't argue that point
further.

## Analysis of using TAP13

One of my earlier concerns was that TAP13 is a bit over constrained
for what I would like to output from the KUnit core. It only allows
data to be output as either:
 - test number
 - ok/not ok with single line description
 - directive
 - diagnostics
 - YAML block

The test number must become before a set of ok/not ok lines, and does
not contain any additional information. One annoying thing about this
is it doesn't provide any kind of nesting or grouping.

There is one ok/not ok line per test and it may have a short
description of the test immediately after 'ok' or 'not ok'; this is
problematic because it wants the first thing you say about a test to
be after you know whether it passes or not.

Directives are just a way to specify skipped tests and TODOs.

Diagnostics seem useful, it looks like you can put whatever
information in them and print them out at anytime. It looks like a lot
of kselftests emit a lot of data this way.

The YAML block seems to be the way that they prefer users to emit data
beyond number of tests run and whether a test passed or failed. I
could express most things I want to express in terms of YAML, but it
is not the nicest format for displaying a lot of data like
expectations, missed function calls, and other things which have a
natural concise representation. Nevertheless, YAML readability is
mostly a problem who won't be using the wrapper scripts. My biggest
problem with the YAML block is that you can only have one, and TAP
specifies that it must come after the corresponding ok/not ok line,
which again has the issue that you have to hold on to a lot of
diagnostic data longer than you ideally would. Another downside is
that I now have to write a YAML serializer for the kernel.

## Here is what I propose for this patchset:

 - Print out test number range at the beginning of each test suite.
 - Print out log lines as soon as they happen as diagnostics.
 - Print out the lines that state whether a test passes or fails as a
ok/not ok line.

This would be technically conforming with TAP13 and is consistent with
what some kselftests have done.

## To be done in a future patchset:

Add a YAML serializer and print out some logs containing structured
data (like expectation failures, unexpected function calls, etc) in
YAML blocks.

Does this sound reasonable? I will go ahead and start working on this,
but feel free to give me feedback on the overall idea in the meantime.

Cheers

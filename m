Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8EAF1D0E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 22:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfENUyT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 16:54:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34953 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfENUyS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 16:54:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id h1so170245pgs.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 13:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=XygOuwoFm7gzQhhUOvWTZyqOBt7ptJW7nbpWmuwFcVs=;
        b=g4qKFaFE7Yh7H28KycQARZrVqeKj92RMFbA+a72bVGE1wixE+szHEVqZsfsCy/c0sr
         gvMzBI+cl1YducKsOuGaRhPvvo8n9HH5M0xOHiViD5KfsMxdIS9cpguok8JG7ChAcHGU
         RDtXuaLArDabdyJmiJY2aa5NeS+f1bjEcUhBO2Nz+HSP3Ovqxtt5GPMBfcfs+VgkRthb
         iHpOF/lPVIIEEAHwrrk7Ay8SQKzd0mL+GynkKMuKDNpOieChw+I5hnv++0884h7Mmiym
         YC6Zi5Hm6rVagGpO5c910E3PjbiUk/DNb9WUv3huqAImMMW6T6uHIgzQDEXt/Q47cqIt
         jnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XygOuwoFm7gzQhhUOvWTZyqOBt7ptJW7nbpWmuwFcVs=;
        b=Mabyoa60KiXQxhRwf/p1b5ch7LOlMtPtnHXVbRpKaOGLJ/wdakHYzqcV2tSvQW2Nuw
         L7M9henX/RobTkipcwV3I8USg0pCoPWa7d9SkyjDBqDMlJK5oP8QFhCCgRYJxbwqc/fP
         3y1RqW2Rlkgy6ZYi4THoR3keeaRvk0DJiBjm3XnMuF31DcW2oChtk91fe0bkgtZv2iI4
         sQWsurTFibwOX6GLs1b+YjpRyyPKZGpprZZ2PfpGLSDIQoYdMPEGAPcPBCWfFhhc7Cky
         EWz6G38bdYWNVY+ZJYaQdZB8I48QhA8sVoHfnI924ZyBFN0A63tFEKzD/HxM7TMZmP3S
         wKTA==
X-Gm-Message-State: APjAAAXkGZZ+buWGJpAWGzC6WhviHnC5RJQ+gDDP+xvPMfVsnSTb6iSo
        9UmbfBBytt6HDEdIR/X/uA5fSg==
X-Google-Smtp-Source: APXvYqwd+Jkh7md+hSBxZPhzl0i1uY2dXHZTreHilHxyWOiiHKFUut9EjRbN0xnr1SmnWhFYXdyBgA==
X-Received: by 2002:a63:2943:: with SMTP id p64mr40698957pgp.151.1557867257289;
        Tue, 14 May 2019 13:54:17 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
        by smtp.gmail.com with ESMTPSA id j184sm2017pge.83.2019.05.14.13.54.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 13:54:16 -0700 (PDT)
Date:   Tue, 14 May 2019 13:54:09 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Theodore Ts'o <tytso@mit.edu>, Tim.Bird@sony.com,
        knut.omang@oracle.com, gregkh@linuxfoundation.org,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        amir73il@gmail.com, dan.carpenter@oracle.com, daniel@ffwll.ch,
        jdike@addtoit.com, joel@jms.id.au, julia.lawall@lip6.fr,
        khilman@baylibre.com, mpe@ellerman.id.au, pmladek@suse.com,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190514205409.GA154649@google.com>
References: <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
 <2aed675e-0408-c812-3e1a-b90710c528f2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2aed675e-0408-c812-3e1a-b90710c528f2@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 10, 2019 at 02:52:59PM -0700, Frank Rowand wrote:

Sorry, I forgot to get back to this thread.

> On 5/9/19 3:20 PM, Logan Gunthorpe wrote:
> > 
> > 
> > On 2019-05-09 3:42 p.m., Theodore Ts'o wrote:
> >> On Thu, May 09, 2019 at 11:12:12AM -0700, Frank Rowand wrote:
> >>>
> >>>     "My understanding is that the intent of KUnit is to avoid booting a kernel on
> >>>     real hardware or in a virtual machine.  That seems to be a matter of semantics
> >>>     to me because isn't invoking a UML Linux just running the Linux kernel in
> >>>     a different form of virtualization?
> >>>
> >>>     So I do not understand why KUnit is an improvement over kselftest.
> >>>
> >>>     ...
> >>> 
> >>> What am I missing?"
> >> 
> >> One major difference: kselftest requires a userspace environment;
> >> it starts systemd, requires a root file system from which you can
> >> load modules, etc.  Kunit doesn't require a root file system;
> >> doesn't require that you start systemd; doesn't allow you to run
> >> arbitrary perl, python, bash, etc. scripts.  As such, it's much
> >> lighter weight than kselftest, and will have much less overhead
> >> before you can start running tests.  So it's not really the same
> >> kind of virtualization.
> 
> I'm back to reply to this subthread, after a delay, as promised.
> 
> 
> > I largely agree with everything Ted has said in this thread, but I
> > wonder if we are conflating two different ideas that is causing an
> > impasse. From what I see, Kunit actually provides two different
> > things:
> 
> > 1) An execution environment that can be run very quickly in userspace
> > on tests in the kernel source. This speeds up the tests and gives a
> > lot of benefit to developers using those tests because they can get
> > feedback on their code changes a *lot* quicker.
> 
> kselftest in-kernel tests provide exactly the same when the tests are
> configured as "built-in" code instead of as modules.
> 
> 
> > 2) A framework to write unit tests that provides a lot of the same
> > facilities as other common unit testing frameworks from userspace
> > (ie. a runner that runs a list of tests and a bunch of helpers such
> > as KUNIT_EXPECT_* to simplify test passes and failures).
> 
> > The first item from Kunit is novel and I see absolutely no overlap
> > with anything kselftest does. It's also the valuable thing I'd like
> > to see merged and grow.
> 
> The first item exists in kselftest.
> 
> 
> > The second item, arguably, does have significant overlap with
> > kselftest. Whether you are running short tests in a light weight UML
> > environment or higher level tests in an heavier VM the two could be
> > using the same framework for writing or defining in-kernel tests. It
> > *may* also be valuable for some people to be able to run all the UML
> > tests in the heavy VM environment along side other higher level
> > tests.
> > 
> > Looking at the selftests tree in the repo, we already have similar
> > items to what Kunit is adding as I described in point (2) above.
> > kselftest_harness.h contains macros like EXPECT_* and ASSERT_* with
> > very similar intentions to the new KUNIT_EXECPT_* and KUNIT_ASSERT_*
> > macros.
> 
> I might be wrong here because I have not dug deeply enough into the
> code!!!  Does this framework apply to the userspace tests, the
> in-kernel tests, or both?  My "not having dug enough GUESS" is that
> these are for the user space tests (although if so, they could be
> extended for in-kernel use also).
> 
> So I think this one maybe does not have an overlap between KUnit
> and kselftest.

You are right, Frank: the EXPECT_* and ASSERT_* in kselftest_harness.h
is for userspace only. kselftest_harness.h provides it's own main method
for running the tests[1]. It also makes assumptions around having access
to this main method[2].

There actually isn't that much infrastructure that that I can reuse
there. I can't even reuse the API definitions because they only pass the
context object (for me it is struct kunit, for them it is their fixture)
that they use to their test cases.

> > However, the number of users of this harness appears to be quite
> > small. Most of the code in the selftests tree seems to be a random
> > mismash of scripts and userspace code so it's not hard to see it as
> > something completely different from the new Kunit:
> > $ git grep --files-with-matches kselftest_harness.h *
> > Documentation/dev-tools/kselftest.rst
> > MAINTAINERS
> > tools/testing/selftests/kselftest_harness.h
> > tools/testing/selftests/net/tls.c
> > tools/testing/selftests/rtc/rtctest.c
> > tools/testing/selftests/seccomp/Makefile
> > tools/testing/selftests/seccomp/seccomp_bpf.c
> > tools/testing/selftests/uevent/Makefile
> > tools/testing/selftests/uevent/uevent_filtering.c
> 
> 
> > Thus, I can personally see a lot of value in integrating the kunit
> > test framework with this kselftest harness. There's only a small
> > number of users of the kselftest harness today, so one way or another
> > it seems like getting this integrated early would be a good idea.
> > Letting Kunit and Kselftests progress independently for a few years
> > will only make this worse and may become something we end up
> > regretting.
> 
> Yes, this I agree with.

I think I agree with this point. I cannot see any reason not to have
KUnit tests able to be run from the kselftest harness.

Conceptually, I think we are mostly in agreement that kselftest and
KUnit are distinct things. Like Shuah said, kselftest is a black box
regression test framework, KUnit is a white box unit testing framework.
So making kselftest the only interface to use KUnit would be a mistake
in my opinion (and I think others on this thread would agree).

That being said, when you go to run kselftest, I think there is an
expectation that you run all your tests. Or at least that kselftest
should make that possible. From my experience, usually when someone
wants to run all the end-to-end tests, *they really just want to run all
the tests*. This would imply that all your KUnit tests get run too.

Another added benefit of making it possible for the kselftest harness to
run KUnit tests would be that it would somewhat guarantee that the
interfaces between the two would remain compatible meaning that test
automation tools like CI and presubmit systems are more likely to be
easy to integrate in each and less likely to break for either.

Would anyone object if I explore this in a follow-up patchset? I have an
idea of how I might start, but I think it would be easiest to explore in
it's own patchset. I don't expect it to be a trivial amount of work.

Cheers!

[1] https://elixir.bootlin.com/linux/v5.1.2/source/tools/testing/selftests/kselftest_harness.h#L329
[2] https://elixir.bootlin.com/linux/v5.1.2/source/tools/testing/selftests/kselftest_harness.h#L681

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB54818F7C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 19:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfEIRnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 13:43:10 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40041 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfEIRnK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 13:43:10 -0400
Received: by mail-it1-f194.google.com with SMTP id g71so4714389ita.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 May 2019 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FC2rVRp+KvVlVpOd4Y7tQxF5qWg3rep+JWKzypDSYq8=;
        b=LbcJgGle/rhNYz98yotvkpEnwql392ytSXEkHgJR3WVHNiFk0zbLta6vt6IRyzyLpp
         950Fjqs62WqoNt1qtodnxEoU3/OPR9dDe9YJvU5YVSz3hzqSiXeaxhK0t5HUoWgDWxZG
         HT6WAb9G+yzAzQfyc7s+3V4khiykcDJvfcm9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FC2rVRp+KvVlVpOd4Y7tQxF5qWg3rep+JWKzypDSYq8=;
        b=UmkX/dyUryZd+d/JOf/ZE2whDjQf3NOcElBOtdzrqmIV1P19BouBkzi2iE2CHRM3Zu
         YhrpEYCmlca0r+0T9ZBzsoqBeORtNc2EU0acbpEyC7YVtAMyDLeErhpdkjLgJEyaLZX9
         m2ve2NYTPh/1P+fyFtedve1fJf5dCFfdcnEZrqyfL+HNQbj3S8iLOLiMOH8NRswrHqBc
         Dhq9W4L0hTtl14WMZqDSiyoEfhqIqlk+yaVqTiTR64unnSRM4azB8esjDBNZXipM45uI
         x0VzumYSk+qWuXdfIMqM8/GJHmq7bQ/gHqswH1GbRBRf+hF0bvcZ6e53HpTptQ5RE52G
         6NYQ==
X-Gm-Message-State: APjAAAV2cdRyB40/fRJLtpMfws+Erv6OB26xR7TEHuw8ZskvsNYyKlaB
        2oAnx5o9XiYxS9TcBOw8Sh3wUd8jm0uA/wxLVd0jqg==
X-Google-Smtp-Source: APXvYqypZncp40GnumoOHkLA1kNmLjAfWPEq0cInNiRdF0xrV+UuIt8Lmj8Y2my6/5rmuFEGlBGw2sdQWFlUn3jtftA=
X-Received: by 2002:a02:ca4a:: with SMTP id i10mr4326425jal.70.1557423788780;
 Thu, 09 May 2019 10:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com> <20190507080119.GB28121@kroah.com>
 <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com> <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com> <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu> <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 9 May 2019 19:42:57 +0200
Message-ID: <CAKMK7uHfbvj+us9PdN2H0aQUyNYW1Xa_vhNLyHtnEpU8m6pLpw@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Tim.Bird@sony.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, knut.omang@oracle.com,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
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

On Thu, May 9, 2019 at 7:00 PM <Tim.Bird@sony.com> wrote:
> > -----Original Message-----
> > From: Theodore Ts'o
> >
> > On Thu, May 09, 2019 at 01:52:15PM +0200, Knut Omang wrote:
> > > 1) Tests that exercises typically algorithmic or intricate, complex
> > >    code with relatively few outside dependencies, or where the
> > dependencies
> > >    are considered worth mocking, such as the basics of container data
> > >    structures or page table code. If I get you right, Ted, the tests
> > >    you refer to in this thread are such tests. I believe covering this space
> > >    is the goal Brendan has in mind for KUnit.
> >
> > Yes, that's correct.  I'd also add that one of the key differences is
> > that it sounds like Frank and you are coming from the perspective of
> > testing *device drivers* where in general there aren't a lot of
> > complex code which is hardware independent.
>
> Ummm.  Not to speak for Frank, but he's representing the device tree
> layer, which I'd argue sits exactly at the intersection of testing device drivers
> AND lots of complex code which is hardware independent.  So maybe his
> case is special.

Jumping in with a pure device driver hat: We already have add-hoc unit
tests in drivers/gpu, which somewhat shoddily integrate into
kselftests and our own gpu test suite from userspace. We'd like to do
a lot more in this area (there's enormous amounts of code in a gpu
driver that's worth testing on its own, or against a mocked model of a
part of the real hw), and I think a unit test framework for the entire
kernel would be great. Plus gpu/drm isn't the only subsystem by far
that already has a home-grown solution. So it's actually worse than
what Ted said: We don't just have a multitude of test frameworks
already, we have a multitude of ad-hoc unit test frameworks, each with
their own way to run tests, write tests and mock parts of the system.
Kunit hopefully helps us to standardize more in this area. I do plan
to look into converting all the drm selftest we have already as soon
as this lands (and as soon as I find some time ...).

Cheers, Daniel

>
> > After all, the vast
> > majority of device drivers are primarily interface code to hardware,
> > with as much as possible abstracted away to common code.  (Take, for
> > example, the model of the SCSI layer; or all of the kobject code.)
> >
> > > 2) Tests that exercises interaction between a module under test and other
> > >    parts of the kernel, such as testing intricacies of the interaction of
> > >    a driver or file system with the rest of the kernel, and with hardware,
> > >    whether that is real hardware or a model/emulation.
> > >    Using your testing needs as example again, Ted, from my shallow
> > understanding,
> > >    you have such needs within the context of xfstests
> > (https://github.com/tytso/xfstests)
> >
> > Well, upstream is for xfstests is git://git.kernel.org/pub/scm/fs/xfs/xfstests-
> > dev.git
> >
> > The test framework where I can run 20 hours worth of xfstests
> > (multiple file system features enabled, multiple mount options, etc.)
> > in 3 hours of wall clock time using multiple cloud VM is something
> > called gce-xfstests.
> >
> > I also have kvm-xfstests, which optimizes low test latency, where I
> > want to run a one or a small number of tests with a minimum of
> > overhead --- gce startup and shutdown is around 2 minutes, where as
> > kvm startup and shutdown is about 7 seconds.  As far as I'm concerned,
> > 7 seconds is still too slow, but that's the best I've been able to do
> > given all of the other things I want a test framework to do, including
> > archiving test results, parsing the test results so it's easy to
> > interpret, etc.  Both kvm-xfstests and gce-xfstests are located at:
> >
> >       git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
> >
> > So if Frank's primary argument is "too many frameworks", it's already
> > too late.  The block layer has blktests has a seprate framework,
> > called blktests --- and yeah, it's a bit painful to launch or learn
> > how to set things up.
> >
> > That's why I added support to run blktests using gce-xfstests and
> > kvm-xfstests, so that "gce-xfstests --blktests" or "kvm-xfstests
> > --xfstests" will pluck a kernel from your build tree, and launch at
> > test appliance VM using that kernel and run the block layer tests.
> >
> > The point is we *already* have multiple test frameworks, which are
> > optimized for testing different parts of the kernel.  And if you plan
> > to do a lot of work in these parts of the kernel, you're going to have
> > to learn how to use some other test framework other than kselftest.
> > Sorry, that's just the way it goes.
> >
> > Of course, I'll accept trivial patches that haven't been tested using
> > xfstests --- but that's because I can trivially run the smoke test for
> > you.  Of course, if I get a lot of patches from a contributor which
> > cause test regressions, I'll treat them much like someone who
> > contribute patches which fail to build.  I'll apply pressure to the
> > contributor to actually build test, or run a ten minute kvm-xfstests
> > smoke test.  Part of the reason why I feel comfortable to do this is
> > it's really easy to run the smoke test.  There are pre-compiled test
> > appliances, and a lot of documentation:
> >
> > https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-
> > quickstart.md
> >
> > This is why I have close to zero sympathy to Frank's complaint that
> > extra test frameworks are a bad thing.  To me, that's whining.  I've
> > done a huge amount of work to meet contributors more than half-way.
> > The insistence that "There Must Be One", ala the Highlander movie, is
> > IMHO so wrong that it's not even close.  Is it really that hard to do
> > a "git pull", download a test appliance, set up a config file to tell
> > kvm-xfstests where to find your build tree, and then run "kvm-xfstests
> > --smoke" or "gce-xfstests --smoke"?  Cry me a river.
>
> Handling these types of things that are not "really that hard to do" is
> exactly what meta-frameworks like KCI, Fuego, and LKFT are for.
> For a core developer in a sub-system, having them learn a particular
> specialized framework is OK.  However, for someone doing integration
> testing of the kernel (not a core developer
> in a particular subsystem), having lots of different frameworks turns
> into death by a thousand cuts.  But we're working to fix that.
> (Which reminds me that I have an outstanding action item to add an xfstest
> test definition to Fuego. :-) )
>
> >
> > There are already multiple test frameworks, and if you expect to do a
> > lot of work in a particular subsystem, you'll be expected to use the
> > Maintainer's choice of tests.  Deal with it.  We do this so we can
> > scale to the number of contributors we have in our subsystem.
>
> This seems to me to be exactly backwards.  You scale your contributors
> by making it easier for them, which means adopting something already
> well-know or established - not by being different.
>
> I understand your vise grip metaphor, and agree with you.  In my opinion
> kselftest and kunit are optimized for different things, and are different tools
> in the Linux kernel testing toolbox.  But if you start having too many tools, or
> the tools are too specialized, there are less people familiar with them and
> ready to use them to help contribute.
>
> >
> > > To 1) I agree with Frank in that the problem with using UML is that you still
> > have to
> > > relate to the complexity of a kernel run time system, while what you really
> > want for these
> > > types of tests is just to compile a couple of kernel source files in a normal
> > user land
> > > context, to allow the use of Valgrind and other user space tools on the
> > code.
> >
> > "Just compiling a couple of kernel source files in a normal user land"
> > is much harder than you think.  It requires writing vast numbers of
> > mocking functions --- for a file system I would have to simulate the
> > block device layer, large portions of the VFS layer, the scheduler and
> > the locking layer if I want to test locking bugs, etc., etc.  In
> > practice, UML itself is serving as mocking layer, by its mere
> > existence.  So when Frank says that KUnit doesn't provide any mocking
> > functions, I don't at all agree.  Using KUnit and UML makes testing
> > internal interfaces *far* simpler, especially if the comparison is
> > "just compile some kernel source files as part of a userspace test
> > program".
>
> I had one thing I wanted to ask about here.  You said previously that
> you plan to use KUnit to test a complicated but hardware independent
> part of the filesystem code.  If you test only via UML, will that give you
> coverage for non-x86 platforms? More specifically, will you get coverage
> for 32-bit, for big-endian as well as little-endian, for weird architectures?
> It seems like the software for these complicated sections of code is
> subject to regressions due to toolchain issues as much as from coding errors.
> That's why I was initially turned off when I  heard that KUnit only planned
> to support UML and not cross-compilation.
>
> I'm not sure what the status is of UML for all the weird embedded processors
> that get only cross-compiled and not natively-compiled, but there are multiple
> reasons why UML is less commonly used in the embedded space.
>
> > Perhaps your and Frank's experience is different --- perhaps that can
> > be explained by your past experience and interest in testing device
> > drivers as opposed to file systems.
> >
> > The other thing I'd add is that at least for me, a really important
> > consideration is how quickly we can run tests.  I consider
> > minimization of developer friction (e.g., all you need to do is
> > running "make ; kvm-xfstests --smoke" to run tests), and maximizing
> > developer velocity to be high priority goals.  Developer velocity is
> > how quickly can you run the tests; ideally, less than 5-10 seconds.
> >
> > And that's the other reason why I consider unit tests to be a
> > complement to integration tests.  "gce-xfstests --smoke" takes 10-15
> > minutes.  If I can have unit tests which takes 5-15 seconds for a
> > smoke test of the specific part of ext4 that I am modifying (and often
> > with much better coverage than integration tests from userspace),
> > that's at really big deal.  I can do this for e2fsprogs; but if I have
> > to launch a VM, the VM overhead pretty much eats all or most of that
> > time budget right there.
> >
> > From looking at your documentation of KTF, you are targetting the use
> > case of continuous testing.  That's a different testing scenario than
> > what I'm describing; with continuous testing, overhead measured in
> > minutes or even tens of minutes is not a big deal.  But if you are
> > trying to do real-time testing as part of your development process ---
> > *real* Test Driven Development, then test latency is a really big
> > deal.
> >
> > I'll grant that for people who are working on device drivers where
> > architecture dependencies are a big deal, building for an architecture
> > where you can run in a virtual environment or using test hardware is
> > going to be a better way to go.  And Brendan has said he's willing to
> > look at adapting KUnit so it can be built for use in a virtual
> > environment to accomodate your requirements.
>
> This might solve my cross-compile needs, so that's good.
>
> >
> > As far as I'm concerned, however, I would *not* be interested in KTF
> > unless you could demonstrate to me that launching at test VM, somehow
> > getting the kernel modules copied into the VM, and running the tests
> > as kernel modules, has zero overhead compared to using UML.
> >
> > Ultimately, I'm a pragmatist.  If KTF serves your needs best, good for
> > you.  If other approaches are better for other parts of the kernel,
> > let's not try to impose a strict "There Must Be Only One" religion.
> > That's already not true today, and for good reason.  There are many
> > different kinds of kernel code, and many different types of test
> > philosophies.  Trying to force all kernel testing into a single
> > Procrustean Bed is simply not productive.
>
> Had to look up "Procrustean Bed" - great phrase.  :-)
>
> I'm not of the opinion that there must only be one test framework
> in the kernel. But we should avoid unnecessary multiplication. Every
> person is going to have a different idea for where the line of necessity
> is drawn.  My own opinion is that what KUnit is adding is different enough
> from kselftest, that it's a valuable addition.
>
>  -- Tim
>
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch

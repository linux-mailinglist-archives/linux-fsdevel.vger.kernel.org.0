Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43CDE1C44D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2019 10:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfENIAT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 04:00:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39843 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfENIAJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 04:00:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id g9so7850567plm.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 01:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qmImQs3/7c0LXwB0nTQAxTJYiC8MuoLgE8xIG8Tm5O4=;
        b=biw/httZ7LNwyRVCMrvBT2zbF+p2oG91jQU+l2SyS/9sV5KK6LiWBnhzEhuwLQsBoW
         X8kzrG4MVIMA8sfsgcFuhL385pC/79BeeXvxRCN8/3WRJxyaKcJAUH7hvjM/7tL4+JFh
         GK9jh4I0S6os86Bkh7/5m6eA+2iQZkrxL7buqF1gkBTmVugmfIdWP/BFpPuOsgW3TMyU
         luNODvSs8vFtWPlLRAsZcPAcvXY5Iu1kYBgWRodUoQOqi6YoJLlvDDerIpNaDzV3TXS4
         sMndhpe2I2m7gj/QjLR6+OkGviiKoRZuet1JniT6L9yvAo7AEr9fU9zB1eyb9WD+IeB4
         7wIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qmImQs3/7c0LXwB0nTQAxTJYiC8MuoLgE8xIG8Tm5O4=;
        b=FD0Y7PxJ3rWvoTRLpTpuxbzNVAxsg5tcqKFKxrSb0HR8rhDfR0q3T5QllEEeoCX/jp
         7GieWVYwhmn7Au397SrQnf7l8XChjH00204n2nSm8rM8smcrjLXurjvfu/QlMAtS3dDv
         qbHjWDyFevoT82I8L/2xc4uV8J8Gdv99jmG4CjBG8NWkmEGVHVLWI+jwai3rzY5XMsPe
         50mUdeWw+OWgFqNHlY+ZIdtYSgH0HroK7w8SgjYvNtbsLOYgYX6DgHM1tSRFlKjaPHxT
         Fwu7pXHjfd3fFqBp3sw3rAF0Xcqy59SOqk+SWc4i24a1v9QOMLp4KAE+DIVbWl4SnTFL
         7/uw==
X-Gm-Message-State: APjAAAXEOaPgFHQGWWs8CRy5XjoGc/q2Fh0AZNR0yQ8npuWxGXNbKpF+
        IWE6h3u6Ccc61iE2TTiucs9nhQ==
X-Google-Smtp-Source: APXvYqwQCipm0AHDaVoG3LWGzF8Wl22z+O5ja+MEZvJAfFUVv/ZE8Gvzk6Ws7guVWw+sDHr1xsmzPA==
X-Received: by 2002:a17:902:f096:: with SMTP id go22mr37387931plb.49.1557820807750;
        Tue, 14 May 2019 01:00:07 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:2:d714:29b4:a56b:b23b])
        by smtp.gmail.com with ESMTPSA id j12sm19128638pff.148.2019.05.14.01.00.05
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 01:00:05 -0700 (PDT)
Date:   Tue, 14 May 2019 01:00:00 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Knut Omang <knut.omang@oracle.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Logan Gunthorpe <logang@deltatee.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
Message-ID: <20190514080000.GA212892@google.com>
References: <20190509214233.GA20877@mit.edu>
 <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
 <20190509233043.GC20877@mit.edu>
 <8914afef-1e66-e6e3-f891-5855768d3018@deltatee.com>
 <6d6e91ec-33d3-830b-4895-4d7a20ba7d45@gmail.com>
 <a1b88d5add15d43de0468c32d9a2427629337abb.camel@oracle.com>
 <CAKMK7uFd1xUx8u3xWLwifVSq4OEnMO4S-m0hESe68UzONXnMFg@mail.gmail.com>
 <CAFd5g47Fvafwgh15JNfxSBRf5qqG2z+V+XGAB2cJtNnHFTiFfQ@mail.gmail.com>
 <8abaf5f2-dd33-98d0-7b34-b57de7fe7c8b@gmail.com>
 <a3362d96a6d95d852753739384ded814f5269aac.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3362d96a6d95d852753739384ded814f5269aac.camel@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 11, 2019 at 08:43:23AM +0200, Knut Omang wrote:
> On Fri, 2019-05-10 at 14:59 -0700, Frank Rowand wrote:
> > On 5/10/19 3:23 AM, Brendan Higgins wrote:
> > >> On Fri, May 10, 2019 at 7:49 AM Knut Omang <knut.omang@oracle.com> wrote:
> > >>>
> > >>> On Thu, 2019-05-09 at 22:18 -0700, Frank Rowand wrote:
> > >>>> On 5/9/19 4:40 PM, Logan Gunthorpe wrote:
> > >>>>>
> > >>>>>
> > >>>>> On 2019-05-09 5:30 p.m., Theodore Ts'o wrote:
> > >>>>>> On Thu, May 09, 2019 at 04:20:05PM -0600, Logan Gunthorpe wrote:
> > >>>>>>>
> > >>>>>>> The second item, arguably, does have significant overlap with kselftest.
> > >>>>>>> Whether you are running short tests in a light weight UML environment or
> > >>>>>>> higher level tests in an heavier VM the two could be using the same
> > >>>>>>> framework for writing or defining in-kernel tests. It *may* also be valuable
> > >>>>>>> for some people to be able to run all the UML tests in the heavy VM
> > >>>>>>> environment along side other higher level tests.
> > >>>>>>>
> > >>>>>>> Looking at the selftests tree in the repo, we already have similar items to
> > >>>>>>> what Kunit is adding as I described in point (2) above. kselftest_harness.h
> > >>>>>>> contains macros like EXPECT_* and ASSERT_* with very similar intentions to
> > >>>>>>> the new KUNIT_EXECPT_* and KUNIT_ASSERT_* macros.
> > >>>>>>>
> > >>>>>>> However, the number of users of this harness appears to be quite small. Most
> > >>>>>>> of the code in the selftests tree seems to be a random mismash of scripts
> > >>>>>>> and userspace code so it's not hard to see it as something completely
> > >>>>>>> different from the new Kunit:
> > >>>>>>>
> > >>>>>>> $ git grep --files-with-matches kselftest_harness.h *
> > >>>>>>
> > >>>>>> To the extent that we can unify how tests are written, I agree that
> > >>>>>> this would be a good thing.  However, you should note that
> > >>>>>> kselftest_harness.h is currently assums that it will be included in
> > >>>>>> userspace programs.  This is most obviously seen if you look closely
> > >>>>>> at the functions defined in the header files which makes calls to
> > >>>>>> fork(), abort() and fprintf().
> > >>>>>
> > >>>>> Ah, yes. I obviously did not dig deep enough. Using kunit for
> > >>>>> in-kernel tests and kselftest_harness for userspace tests seems like
> > >>>>> a sensible line to draw to me. Trying to unify kernel and userspace
> > >>>>> here sounds like it could be difficult so it's probably not worth
> > >>>>> forcing the issue unless someone wants to do some really fancy work
> > >>>>> to get it done.
> > >>>>>
> > >>>>> Based on some of the other commenters, I was under the impression
> > >>>>> that kselftests had in-kernel tests but I'm not sure where or if they
> > >>>>> exist.
> > >>>>
> > >>>> YES, kselftest has in-kernel tests.  (Excuse the shouting...)
> > >>>>
> > >>>> Here is a likely list of them in the kernel source tree:
> > >>>>
> > >>>> $ grep module_init lib/test_*.c
> > >>>> lib/test_bitfield.c:module_init(test_bitfields)
> > >>>> lib/test_bitmap.c:module_init(test_bitmap_init);
> > >>>> lib/test_bpf.c:module_init(test_bpf_init);
> > >>>> lib/test_debug_virtual.c:module_init(test_debug_virtual_init);
> > >>>> lib/test_firmware.c:module_init(test_firmware_init);
> > >>>> lib/test_hash.c:module_init(test_hash_init);  /* Does everything */
> > >>>> lib/test_hexdump.c:module_init(test_hexdump_init);
> > >>>> lib/test_ida.c:module_init(ida_checks);
> > >>>> lib/test_kasan.c:module_init(kmalloc_tests_init);
> > >>>> lib/test_list_sort.c:module_init(list_sort_test);
> > >>>> lib/test_memcat_p.c:module_init(test_memcat_p_init);
> > >>>> lib/test_module.c:static int __init test_module_init(void)
> > >>>> lib/test_module.c:module_init(test_module_init);
> > >>>> lib/test_objagg.c:module_init(test_objagg_init);
> > >>>> lib/test_overflow.c:static int __init test_module_init(void)
> > >>>> lib/test_overflow.c:module_init(test_module_init);
> > >>>> lib/test_parman.c:module_init(test_parman_init);
> > >>>> lib/test_printf.c:module_init(test_printf_init);
> > >>>> lib/test_rhashtable.c:module_init(test_rht_init);
> > >>>> lib/test_siphash.c:module_init(siphash_test_init);
> > >>>> lib/test_sort.c:module_init(test_sort_init);
> > >>>> lib/test_stackinit.c:module_init(test_stackinit_init);
> > >>>> lib/test_static_key_base.c:module_init(test_static_key_base_init);
> > >>>> lib/test_static_keys.c:module_init(test_static_key_init);
> > >>>> lib/test_string.c:module_init(string_selftest_init);
> > >>>> lib/test_ubsan.c:module_init(test_ubsan_init);
> > >>>> lib/test_user_copy.c:module_init(test_user_copy_init);
> > >>>> lib/test_uuid.c:module_init(test_uuid_init);
> > >>>> lib/test_vmalloc.c:module_init(vmalloc_test_init)
> > >>>> lib/test_xarray.c:module_init(xarray_checks);
> > >>>>
> > >>>>
> > >>>>> If they do exists, it seems like it would make sense to
> > >>>>> convert those to kunit and have Kunit tests run-able in a VM or
> > >>>>> baremetal instance.
> > >>>>
> > >>>> They already run in a VM.
> > >>>>
> > >>>> They already run on bare metal.
> > >>>>
> > >>>> They already run in UML.
> > >>>>
> > >>>> This is not to say that KUnit does not make sense.  But I'm still trying
> > >>>> to get a better description of the KUnit features (and there are
> > >>>> some).
> > >>>
> > >>> FYI, I have a master student who looks at converting some of these to KTF, such as
> > for
> > >>> instance the XArray tests, which lended themselves quite good to a semi-automated
> > >>> conversion.
> > >>>
> > >>> The result is also a somewhat more compact code as well as the flexibility
> > >>> provided by the Googletest executor and the KTF frameworks, such as running selected
> > >>> tests, output formatting, debugging features etc.
> > >>
> > >> So is KTF already in upstream? Or is the plan to unify the KTF and
> > > 
> > > I am not certain about KTF's upstream plans, but I assume that Knut
> > > would have CC'ed me on the thread if he had started working on it.
> > > 
> > >> Kunit in-kernel test harnesses? Because there's tons of these
> > > 
> > > No, no plan. Knut and I talked about this a good while ago and it
> > > seemed that we had pretty fundamentally different approaches both in
> > > terms of implementation and end goal. Combining them seemed pretty
> > > infeasible, at least from a technical perspective. Anyway, I am sure
> > > Knut would like to give him perspective on the matter and I don't want
> > > to say too much without first giving him a chance to chime in on the
> > > matter.
> > > 
> > > Nevertheless, I hope you don't see resolving this as a condition for
> > > accepting this patchset. I had several rounds of RFC on KUnit, and no
> > > one had previously brought this up.
> > 
> > I seem to recall a request in reply to the KUnit RFC email threads to
> > work together.
> 
> You recall right.
> I wanted us to work together to refine a common approach.

Are you talking about right after we met at LPC in 2017? We talked about
working together, but I thought you didn't really see much value in what
I was doing with KUnit.

Or are you talking about our fist discussion on the RFC[1]. In this
case, you seemed to assert that KTF's approach was fundamentally
different and superior. You also didn't really seem interested in trying
to merge KTF at the time. The discussion concluded with Luis suggesting
that we should just keep working on both separately and let individual
users decide.

What changed since then?

> I still think that's possible.

I hope you aren't asserting that I have been unwilling to work with you.
At the outset (before I sent out the RFC), I was willing to let you take
the lead on things, but you didn't seem very interested in anything that
I brought to the table and most importantly were not interested in
sending out any code for discussion on the mailing lists.

After I started the RFC, most of your comments were very high level and,
at least to me, seemed like pretty fundamental philosophical differences
in our approaches, which is fine! I think Luis recognized that and I
think that is part of why he suggested for us to continue to work on
them separately.

I am not trying to be mean, but I don't really know what you expected me
to do. I don't recall any specific changes you suggested me to make in
my code (I think you only ever made a single comment on a thread on
anything other than the cover letter.) And you never proposed any of
your own code demonstrating an alternative way of doing things.

Nevertheless, you are of course fully welcome to critique anything I
have proposed, or to propose your own way of doing things, but we need
to do so here on the mailing lists.

> > However whether that impacts acceptance of this patch set is up to
> > the maintainer and how she wants to resolve the potential collision
> > of KUnit and KTF (if there is indeed any sort of collision).
> 
> I believe there's overlap and potential for unification and code sharing.
> My concern is to make sure that that can happen without disrupting too 
> many test users. I'd really like to get some more time to explore that.

It's possible. Like I said before, our approaches are pretty
fundamentally different. It sounds like there might be some overlap
between our expectaion/assertion macros, but we probably cannot use the
ones from Googletest without introducing C++ into the kernel which is a
no-no.

> It strikes me that the main difference in the two approaches 
> lies in the way reporting is done by default. Since KUnit handles all the
> reporting itself, while KTF relies on Googletest for that, a lot more code 
> in KUnit revolves around that part, while with KTF we have focused more on 
> features to enable writing powerful and effective tests.

I have a lot more features on the way, but what is in this initial
patchset are the absolutely core things needed to produce an MVP, and
yes, most of that code revolves around reporting and the fundamental
structure of tests.

Developing cool features is great, but you need to start off on a basis
that the community will accept. Sometimes you need to play around
downstream a bit to develop your ideas, but you always want to get
upstream feedback as early as possible; it's always possible that
someone might propose something, or point out something that breaks a
fundamental assumption that all your later features depend on.

> The reporting part can possibly be made configurable: Reporting with printk or reporting 
> via netlink to user space. In fact, as a KTF debugging option KTF already 
> supports printk reporting which can be enabled via sysfs.

Yep, I intentionally left an interface so printk (well actually
vprintk_emit) can be swapped out with another mechanism.

> If macros can have the same syntax, then there's 
> likely features in KTF that KUnit users would benefit from too. 
> But this of course have to be tried out.

Cool. Looking forward to hearing about it.

Cheers!

[1] https://lkml.org/lkml/2018/11/24/170

> > >> in-kernel unit tests already, and every merge we get more (Frank's
> > >> list didn't even look into drivers or anywhere else, e.g. it's missing
> > >> the locking self tests I worked on in the past), and a more structured
> > >> approach would really be good.
> > > 
> > > Well, that's what I am trying to do. I hope you like it!
> > > 
> > > Cheers!
> > > .
> > > 
> > 
> 

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B437D1A52E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2019 00:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfEJWS5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 18:18:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34224 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfEJWS4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 18:18:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so3655208pgt.1;
        Fri, 10 May 2019 15:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JWNIOzLm8gYzjswJ0stuD8ZfC7VRlSMkrSvSD2LEBME=;
        b=P/2j/G6Tg95n62+yzenlSA3Fe0pt0SIy533WsV8PAhiO4U6QMrD/LPCgX7p0+fy1br
         hC5M+2BOpeKyuzAGKLKtSJGJfiGW6huf4uB8oxmUS3clCmAZbCLvxb63fMzQYNibrzvE
         g/0wKvadTvp8buahkQ7d5+QqfRBhvqoe7lMX/HVlVHMKL/NT3zUeSX8zgtu9vuoP5ZwJ
         IiDiVw+RFRdwP/xiMPRLN6zWFioxEyqadG1K/whFRwMC5yvyKxAJjt12VtVhT4RRN4V6
         0KyLtrxcE94Qt84uBLuVdETBrm1ZlvpIwgo+iC04L8S4h1EL9vqN6pIBAse4cMPFaU7K
         QnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JWNIOzLm8gYzjswJ0stuD8ZfC7VRlSMkrSvSD2LEBME=;
        b=t+X2f0tzNsp4nwDnedgQiyh+sdX3uRoMEcDo5+P97iRRF8fo4fqAorbmCn3dwTWxid
         F8EnAPOue3g9vQFcnIdTdhawyN/0+SDfp7bPUVKESg0E+hRZQT+QUPmaMCCuqT/LhwDS
         SrJYw9fBPx9U3TMS+p6jlnUf0+I7tKUn5fZNX5V93bbQa6Chu8zVTYoHqFu7uMNZxXZG
         CXU1EH3mGVfD2tRQcvS6Hzr2LnBTmkzMa8+kI5WWrjERf1Wjz84rDknFJiEd+N/Pi1jO
         SFUivpTw/5jA6NMjyQzcC1Xe+meugvrY5vMjM1eIzwLhNGJfg6t6RRNn1KNFTwr54jY1
         b1NA==
X-Gm-Message-State: APjAAAUuPWJSqSqglGoltTjxseSGBDo47jhJXFuAy3MKOoFKuY/5yDrc
        oPTupAWxL8c3RINIQ7upQ/E=
X-Google-Smtp-Source: APXvYqy+fj1DO30q2eAmvfdh58K/G484lihRNfnozec3z2KBcfgR9zOGT+yHPPd/VkXXCk9hNOlw5w==
X-Received: by 2002:aa7:92d1:: with SMTP id k17mr17577516pfa.91.1557526735543;
        Fri, 10 May 2019 15:18:55 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id c129sm11732349pfg.178.2019.05.10.15.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 May 2019 15:18:55 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>,
        Knut Omang <knut.omang@oracle.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
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
References: <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
 <20190509233043.GC20877@mit.edu>
 <8914afef-1e66-e6e3-f891-5855768d3018@deltatee.com>
 <6d6e91ec-33d3-830b-4895-4d7a20ba7d45@gmail.com>
 <a1b88d5add15d43de0468c32d9a2427629337abb.camel@oracle.com>
 <CAKMK7uFd1xUx8u3xWLwifVSq4OEnMO4S-m0hESe68UzONXnMFg@mail.gmail.com>
 <CAFd5g47Fvafwgh15JNfxSBRf5qqG2z+V+XGAB2cJtNnHFTiFfQ@mail.gmail.com>
 <1781164863be8d21a7e1890ae6dfee9be101d0a0.camel@oracle.com>
 <CAFd5g46fn4nB-nd27-qj8BoC2h-dTCa=WMGoFNhgXDXY0xOdeg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ccec4818-1b9d-2554-e0e4-433eba659c8e@gmail.com>
Date:   Fri, 10 May 2019 15:18:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g46fn4nB-nd27-qj8BoC2h-dTCa=WMGoFNhgXDXY0xOdeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/10/19 1:54 PM, Brendan Higgins wrote:
> On Fri, May 10, 2019 at 5:13 AM Knut Omang <knut.omang@oracle.com> wrote:
>> On Fri, 2019-05-10 at 03:23 -0700, Brendan Higgins wrote:
>>>> On Fri, May 10, 2019 at 7:49 AM Knut Omang <knut.omang@oracle.com> wrote:
>>>>>
>>>>> On Thu, 2019-05-09 at 22:18 -0700, Frank Rowand wrote:
>>>>>> On 5/9/19 4:40 PM, Logan Gunthorpe wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2019-05-09 5:30 p.m., Theodore Ts'o wrote:
>>>>>>>> On Thu, May 09, 2019 at 04:20:05PM -0600, Logan Gunthorpe wrote:
>>>>>>>>>
>>>>>>>>> The second item, arguably, does have significant overlap with kselftest.
>>>>>>>>> Whether you are running short tests in a light weight UML environment or
>>>>>>>>> higher level tests in an heavier VM the two could be using the same
>>>>>>>>> framework for writing or defining in-kernel tests. It *may* also be valuable
>>>>>>>>> for some people to be able to run all the UML tests in the heavy VM
>>>>>>>>> environment along side other higher level tests.
>>>>>>>>>
>>>>>>>>> Looking at the selftests tree in the repo, we already have similar items to
>>>>>>>>> what Kunit is adding as I described in point (2) above. kselftest_harness.h
>>>>>>>>> contains macros like EXPECT_* and ASSERT_* with very similar intentions to
>>>>>>>>> the new KUNIT_EXECPT_* and KUNIT_ASSERT_* macros.
>>>>>>>>>
>>>>>>>>> However, the number of users of this harness appears to be quite small. Most
>>>>>>>>> of the code in the selftests tree seems to be a random mismash of scripts
>>>>>>>>> and userspace code so it's not hard to see it as something completely
>>>>>>>>> different from the new Kunit:
>>>>>>>>>
>>>>>>>>> $ git grep --files-with-matches kselftest_harness.h *
>>>>>>>>
>>>>>>>> To the extent that we can unify how tests are written, I agree that
>>>>>>>> this would be a good thing.  However, you should note that
>>>>>>>> kselftest_harness.h is currently assums that it will be included in
>>>>>>>> userspace programs.  This is most obviously seen if you look closely
>>>>>>>> at the functions defined in the header files which makes calls to
>>>>>>>> fork(), abort() and fprintf().
>>>>>>>
>>>>>>> Ah, yes. I obviously did not dig deep enough. Using kunit for
>>>>>>> in-kernel tests and kselftest_harness for userspace tests seems like
>>>>>>> a sensible line to draw to me. Trying to unify kernel and userspace
>>>>>>> here sounds like it could be difficult so it's probably not worth
>>>>>>> forcing the issue unless someone wants to do some really fancy work
>>>>>>> to get it done.
>>>>>>>
>>>>>>> Based on some of the other commenters, I was under the impression
>>>>>>> that kselftests had in-kernel tests but I'm not sure where or if they
>>>>>>> exist.
>>>>>>
>>>>>> YES, kselftest has in-kernel tests.  (Excuse the shouting...)
>>>>>>
>>>>>> Here is a likely list of them in the kernel source tree:
>>>>>>
>>>>>> $ grep module_init lib/test_*.c
>>>>>> lib/test_bitfield.c:module_init(test_bitfields)
>>>>>> lib/test_bitmap.c:module_init(test_bitmap_init);
>>>>>> lib/test_bpf.c:module_init(test_bpf_init);
>>>>>> lib/test_debug_virtual.c:module_init(test_debug_virtual_init);
>>>>>> lib/test_firmware.c:module_init(test_firmware_init);
>>>>>> lib/test_hash.c:module_init(test_hash_init);  /* Does everything */
>>>>>> lib/test_hexdump.c:module_init(test_hexdump_init);
>>>>>> lib/test_ida.c:module_init(ida_checks);
>>>>>> lib/test_kasan.c:module_init(kmalloc_tests_init);
>>>>>> lib/test_list_sort.c:module_init(list_sort_test);
>>>>>> lib/test_memcat_p.c:module_init(test_memcat_p_init);
>>>>>> lib/test_module.c:static int __init test_module_init(void)
>>>>>> lib/test_module.c:module_init(test_module_init);
>>>>>> lib/test_objagg.c:module_init(test_objagg_init);
>>>>>> lib/test_overflow.c:static int __init test_module_init(void)
>>>>>> lib/test_overflow.c:module_init(test_module_init);
>>>>>> lib/test_parman.c:module_init(test_parman_init);
>>>>>> lib/test_printf.c:module_init(test_printf_init);
>>>>>> lib/test_rhashtable.c:module_init(test_rht_init);
>>>>>> lib/test_siphash.c:module_init(siphash_test_init);
>>>>>> lib/test_sort.c:module_init(test_sort_init);
>>>>>> lib/test_stackinit.c:module_init(test_stackinit_init);
>>>>>> lib/test_static_key_base.c:module_init(test_static_key_base_init);
>>>>>> lib/test_static_keys.c:module_init(test_static_key_init);
>>>>>> lib/test_string.c:module_init(string_selftest_init);
>>>>>> lib/test_ubsan.c:module_init(test_ubsan_init);
>>>>>> lib/test_user_copy.c:module_init(test_user_copy_init);
>>>>>> lib/test_uuid.c:module_init(test_uuid_init);
>>>>>> lib/test_vmalloc.c:module_init(vmalloc_test_init)
>>>>>> lib/test_xarray.c:module_init(xarray_checks);
>>>>>>
>>>>>>
>>>>>>> If they do exists, it seems like it would make sense to
>>>>>>> convert those to kunit and have Kunit tests run-able in a VM or
>>>>>>> baremetal instance.
>>>>>>
>>>>>> They already run in a VM.
>>>>>>
>>>>>> They already run on bare metal.
>>>>>>
>>>>>> They already run in UML.
>>>>>>
>>>>>> This is not to say that KUnit does not make sense.  But I'm still trying
>>>>>> to get a better description of the KUnit features (and there are
>>>>>> some).
>>>>>
>>>>> FYI, I have a master student who looks at converting some of these to KTF, such as
>>> for
>>>>> instance the XArray tests, which lended themselves quite good to a semi-automated
>>>>> conversion.
>>>>>
>>>>> The result is also a somewhat more compact code as well as the flexibility
>>>>> provided by the Googletest executor and the KTF frameworks, such as running selected
>>>>> tests, output formatting, debugging features etc.
>>>>
>>>> So is KTF already in upstream? Or is the plan to unify the KTF and
>>>
>>> I am not certain about KTF's upstream plans, but I assume that Knut
>>> would have CC'ed me on the thread if he had started working on it.
>>
>> You are on the Github watcher list for KTF?
> 
> Yep! I have been since LPC in 2017.
> 
>> Quite a few of the commits there are preparatory for a forthcoming kernel patch set.
>> I'll of course CC: you on the patch set when we send it to the list.
> 
> Awesome! I appreciate it.
> 
>>
>>>> Kunit in-kernel test harnesses? Because there's tons of these
>>>
>>> No, no plan. Knut and I talked about this a good while ago and it
>>> seemed that we had pretty fundamentally different approaches both in
>>> terms of implementation and end goal. Combining them seemed pretty
>>> infeasible, at least from a technical perspective. Anyway, I am sure
>>> Knut would like to give him perspective on the matter and I don't want
>>> to say too much without first giving him a chance to chime in on the
>>> matter.
>>
>> I need more time to study KUnit details to say, but from a 10k feet perspective:
>> I think at least there's a potential for some API unification, in using the same macro
>> names. How about removing the KUNIT_ prefix to the test macros ;-) ?
> 
> Heh, heh. That's actually the way I had it in the earliest versions of
> KUnit! But that was pretty much the very first thing everyone
> complained about. I think I went from no prefix (like you are
> suggesting) to TEST_* before the first version of the RFC at the
> request of several people I was kicking the idea around with, and then
> I think I was asked to go from TEST_* to KUNIT_* in the very first
> revision of the RFC.
> 
> In short, I am sympathetic to your suggestion, but I think that is
> non-negotiable at this point. The community has a clear policy in
> place on the matter, and at this point I would really prefer not to
> change all the symbol names again.

This would not be the first time that a patch submitter has been
told "do B instead of A" for version 1, then told "do C instead of
B" for version 2, then told "do A instead of C" for the final version.

It sucks, but it happens.

As an aside, can you point to where the "clear policy in place" is
documented, and what the policy is?

-Frank


>> That would make the names shorter, saving typing when writing tests, and storage ;-)
>> and also make the names more similar to KTF's, and those of user land unit test
> 
> You mean the Googletest/Googlemock expectations/assertions?
> 
> It's a great library (with not so great a name), but unfortunately it
> is written in C++, which I think pretty much counts it out here.
> 
>> frameworks? Also it will make it possible to have functions compiling both with KTF and
>> KUnit, facilitating moving code between the two.
> 
> I think that would be cool, but again, I don't think this will be
> possible with Googletest/Googlemock.
> 
>>
>> Also the string stream facilities of KUnit looks interesting to share.
> 
> I am glad you think so!
> 
> If your biggest concern on my side is test macro names (which I think
> is a no-go as I mentioned above), I think we should be in pretty good
> shape once you are ready to move forward. Besides, I have a lot more
> KUnit patches coming after this: landing this patchset is just the
> beginning. So how about we keep moving forward on this patchset?
> 


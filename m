Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72E4D1830F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 03:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfEIBBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 21:01:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45150 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfEIBBF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 21:01:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id s11so332362pfm.12;
        Wed, 08 May 2019 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yViYa+n9NYDtvHDz0r+K4+Oq95Cqmi6zykBegH2S9+U=;
        b=q6xuWARhhaCyOtUDiM13Mq2TCdqcqKupS3zwIqMPehPxy2dz2ZMD7U2PVt+jR9lZz+
         2nRqsnpVOKzcK54vtxFntv+RFvdYg4stm9737Agrnk2/tY5aURLb8arfUosWg9ydusYH
         W1TWfgD3pvEWC39AVZVJ4j3ptsQ9ZNc7yOXKPURwxPcO9gN+TT273HnVJ3QjfSDMsugZ
         HwS2354TdboEeYwv/UOXS1+XimZ2WljTCF2XE0z5K9/D/XSnTxbJImLp2p1Y0Y8MbhcW
         ahg4eVcH+uEmwOrLS6T5gfmIwH8EtOEJaiZEHJ2OETOp0h4LkXlUemXkJCW5Vv5rKgFC
         X1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yViYa+n9NYDtvHDz0r+K4+Oq95Cqmi6zykBegH2S9+U=;
        b=jqLEPFRk/NYGgpALUxyX7fCzKkA0LP3CjfWY8TdhTkUA3HRyutS7ktaxkty9eTrHUb
         OKfh2VdF6CtAn4JWzdL52Pb8NlD4GCfJiT4uODnQKVDophRQu9ywz5jyVNhlq5BlPSTQ
         9brK4IBvcYHbMVOqJ/yTtfzesRBZqCuR2u4Pui+zUHHYbCt9x8RMt1YMZOWTbhlEZ76o
         AVTduBuVaukyCrSimdjoUWbHNxjLYi3VUdA+ok/8puLMTDJUEtSJH+cpX8Ru+It+Sh2e
         Fc+g6/N7xh7yCp0iUJwNSpa/0Qt0SAay/B+lkKWJcA754qpAWC5hnWLppgTjNh3A8dIz
         De9w==
X-Gm-Message-State: APjAAAU8iQJJUowItkqEn98C77F5gFZ4YxFhiie+ijxvoVzWFMhFtH6M
        PLZozz9At9+CdV0OeTs/1Sf+fHIa
X-Google-Smtp-Source: APXvYqz/V92Failmv0rkia78qR5hdpdS0xfB1JYjVMeOpzkJ527SwnH/qSInDGxbdmN18Nckfk3b+A==
X-Received: by 2002:aa7:8a81:: with SMTP id a1mr900658pfc.121.1557363664135;
        Wed, 08 May 2019 18:01:04 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u66sm553077pfb.76.2019.05.08.18.01.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 18:01:03 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     shuah <shuah@kernel.org>, Greg KH <gregkh@linuxfoundation.org>
Cc:     Brendan Higgins <brendanhiggins@google.com>, keescook@google.com,
        kieran.bingham@ideasonboard.com, mcgrof@kernel.org,
        robh@kernel.org, sboyd@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        Tim.Bird@sony.com, amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        knut.omang@oracle.com, logang@deltatee.com, mpe@ellerman.id.au,
        pmladek@suse.com, richard@nod.at, rientjes@google.com,
        rostedt@goodmis.org, wfg@linux.intel.com
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com>
 <1b1efa91-0523-21a9-e541-fdc3612bd117@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <911e44bb-9bb1-e603-a260-fac63760fff6@gmail.com>
Date:   Wed, 8 May 2019 18:01:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1b1efa91-0523-21a9-e541-fdc3612bd117@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/7/19 8:23 AM, shuah wrote:
> On 5/7/19 2:01 AM, Greg KH wrote:
>> On Mon, May 06, 2019 at 08:14:12PM -0700, Frank Rowand wrote:
>>> On 5/1/19 4:01 PM, Brendan Higgins wrote:
>>>> ## TLDR
>>>>
>>>> I rebased the last patchset on 5.1-rc7 in hopes that we can get this in
>>>> 5.2.
>>>>
>>>> Shuah, I think you, Greg KH, and myself talked off thread, and we agreed
>>>> we would merge through your tree when the time came? Am I remembering
>>>> correctly?
>>>>
>>>> ## Background
>>>>
>>>> This patch set proposes KUnit, a lightweight unit testing and mocking
>>>> framework for the Linux kernel.
>>>>
>>>> Unlike Autotest and kselftest, KUnit is a true unit testing framework;
>>>> it does not require installing the kernel on a test machine or in a VM
>>>> and does not require tests to be written in userspace running on a host
>>>> kernel. Additionally, KUnit is fast: From invocation to completion KUnit
>>>> can run several dozen tests in under a second. Currently, the entire
>>>> KUnit test suite for KUnit runs in under a second from the initial
>>>> invocation (build time excluded).
>>>>
>>>> KUnit is heavily inspired by JUnit, Python's unittest.mock, and
>>>> Googletest/Googlemock for C++. KUnit provides facilities for defining
>>>> unit test cases, grouping related test cases into test suites, providing
>>>> common infrastructure for running tests, mocking, spying, and much more.
>>>
>>> As a result of the emails replying to this patch thread, I am now
>>> starting to look at kselftest.  My level of understanding is based
>>> on some slide presentations, an LWN article, https://kselftest.wiki.kernel.org/
>>> and a _tiny_ bit of looking at kselftest code.
>>>
>>> tl;dr; I don't really understand kselftest yet.
>>>
>>>
>>> (1) why KUnit exists
>>>
>>>> ## What's so special about unit testing?
>>>>
>>>> A unit test is supposed to test a single unit of code in isolation,
>>>> hence the name. There should be no dependencies outside the control of
>>>> the test; this means no external dependencies, which makes tests orders
>>>> of magnitudes faster. Likewise, since there are no external dependencies,
>>>> there are no hoops to jump through to run the tests. Additionally, this
>>>> makes unit tests deterministic: a failing unit test always indicates a
>>>> problem. Finally, because unit tests necessarily have finer granularity,
>>>> they are able to test all code paths easily solving the classic problem
>>>> of difficulty in exercising error handling code.
>>>
>>> (2) KUnit is not meant to replace kselftest
>>>
>>>> ## Is KUnit trying to replace other testing frameworks for the kernel?
>>>>
>>>> No. Most existing tests for the Linux kernel are end-to-end tests, which
>>>> have their place. A well tested system has lots of unit tests, a
>>>> reasonable number of integration tests, and some end-to-end tests. KUnit
>>>> is just trying to address the unit test space which is currently not
>>>> being addressed.
>>>
>>> My understanding is that the intent of KUnit is to avoid booting a kernel on
>>> real hardware or in a virtual machine.  That seems to be a matter of semantics
>>> to me because isn't invoking a UML Linux just running the Linux kernel in
>>> a different form of virtualization?
>>>
>>> So I do not understand why KUnit is an improvement over kselftest.
> 
> They are in two different categories. Kselftest falls into black box
> regression test suite which is a collection of user-space tests with a
> few kernel test modules back-ending the tests in some cases.
> 
> Kselftest can be used by both kernel developers and users and provides
> a good way to regression test releases in test rings.
> 
> KUnit is a white box category and is a better fit as unit test framework
> for development and provides a in-kernel testing. I wouldn't view them
> one replacing the other. They just provide coverage for different areas
> of testing.

I don't see what about kselftest or KUnit is inherently black box or
white box.  I would expect both frameworks to be used for either type
of testing.


> I wouldn't view KUnit as something that would be easily run in test rings for example.

I don't see why not.

-Frank

> 
> Brendan, does that sound about right?
> 
>>>
>>> It seems to me that KUnit is just another piece of infrastructure that I
>>> am going to have to be familiar with as a kernel developer.  More overhead,
>>> more information to stuff into my tiny little brain.
>>>
>>> I would guess that some developers will focus on just one of the two test
>>> environments (and some will focus on both), splitting the development
>>> resources instead of pooling them on a common infrastructure.
> 
>>> What am I missing?
>>
>> kselftest provides no in-kernel framework for testing kernel code
>> specifically.  That should be what kunit provides, an "easy" way to
>> write in-kernel tests for things.
>>
>> Brendan, did I get it right?
> thanks,
> -- Shuah
> .
> 


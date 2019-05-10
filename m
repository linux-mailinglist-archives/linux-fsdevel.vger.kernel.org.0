Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0CA197F4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2019 07:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfEJFLG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 May 2019 01:11:06 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45872 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfEJFLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 May 2019 01:11:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id i21so2378268pgi.12;
        Thu, 09 May 2019 22:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OmO2i50lqlsSgaoTI7x+LU0Rb4IXRz+Mg/lkHAf6xo4=;
        b=h6HgSBhdR2q8pjCv5pazDNeWPWcAw6Ib0Ler3cJAxdQ1lH1ZXpe051KYcwiApiirUY
         NsyyscPa9Pb1qYp2NkCmr/yZEKpRoeDVZEqfvtvnktwfJQ8ltTb4MS9CTsMkX86Qfl6R
         wNMMYv103G1RYhl2X50sYZLrTrycqhSAGPUKSzzQl1mTsvFbaolXHksWaGgaRYrhfI5M
         L4lQp7rhFYpWaiSOHm1RnPbJGA0qf76yGUjq/SbXMKhbxFo+Wh9SPCsR3N1CveT2dAsB
         rZgYm5MWhhSu3m/dcDFfb9yq3sF+ceUTxztM4doeijTYv0drvN5XpBIqj67HbbygyZXH
         tPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OmO2i50lqlsSgaoTI7x+LU0Rb4IXRz+Mg/lkHAf6xo4=;
        b=CTwJLZM5YiwjXrqn1ZqRu0mh6c0l3WsKeMzyTuVNL5WLsoiNxYkYSKHjq8SNe6TopW
         4H6umJ3QO+YVyVSNQSoCay+PYkCUYR5WZpoxnWzU8NIdgmF51L5Bwhy5SEhBxAya1kkj
         7TcEl7kSAuTSBusAOvkHq2/kjm6FUhOISp2JIPmlt/NPNowxc8r2FxlGouCazNy9zA39
         l6RJB+aATIcopTiRNgD8EmMVtI0Rpg5T5wvmtphUYe+UsuErcaOAnFL+/m0JwY5iR3Nx
         J8BhiU+BKVHLJH000fXp/mP9t31mKB5v0w6QAQVnfWdeikIsv7EoamH/JyUiSsZkVcHc
         CqaA==
X-Gm-Message-State: APjAAAU3VTdCjljl8CLPREg9VVHHPd6UDtaeeESPEnpt4Uq7DNDWmZOi
        YfFlgYQ5wALf2Rm51IheErg=
X-Google-Smtp-Source: APXvYqxPmwGpQEcDwqNzCE5QbzmkFOAz6RNpDPlo/AiSRWJuVcPZ5PLYe5dgPDT9VD5VjyQCjG9Hrw==
X-Received: by 2002:aa7:93ba:: with SMTP id x26mr11246068pff.238.1557465065498;
        Thu, 09 May 2019 22:11:05 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id k9sm5952733pfa.180.2019.05.09.22.11.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 22:11:04 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
From:   Frank Rowand <frowand.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, devicetree@vger.kernel.org,
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
 <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
Message-ID: <78e4d46e-6212-9871-51d6-dd2126f39d45@gmail.com>
Date:   Thu, 9 May 2019 22:11:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Ted,

I'll try answering this again.

The first time I was a little flippant in part of my answer because I
thought your comments somewhat flippant.  This time I'll provide a
more complete answer.


On 5/8/19 7:13 PM, Frank Rowand wrote:
> On 5/8/19 6:58 PM, Theodore Ts'o wrote:
>> On Wed, May 08, 2019 at 05:43:35PM -0700, Frank Rowand wrote:

*****  begin context from Greg KH that you snipped  *****

On 5/7/19 1:01 AM, Greg KH wrote:

<< note that I have snipped my original question above this point >>

>
> kselftest provides no in-kernel framework for testing kernel code
> specifically.  That should be what kunit provides, an "easy" way to
> write in-kernel tests for things.

*****  end   context from Greg KH that you snipped  *****

>>> kselftest provides a mechanism for in-kernel tests via modules.  For
>>> example, see:
>>>
>>>   tools/testing/selftests/vm/run_vmtests invokes:
>>>     tools/testing/selftests/vm/test_vmalloc.sh
>>>       loads module:
>>>         test_vmalloc
>>>         (which is built from lib/test_vmalloc.c if CONFIG_TEST_VMALLOC)
>>
>> The majority of the kselftests are implemented as userspace programs.

My flippant answer:

> Non-argument.

This time:

My reply to Greg was pointing out that in-kernel tests do exist in
kselftest.

Your comment that the majority of kselftests are implemented as userspace
programs has no bearing on whether kselftest support in-kernel tests.
It does not counter the fact the kselftest supports in-kernel tests.


>> You *can* run in-kernel test using modules; but there is no framework
>> for the in-kernel code found in the test modules, which means each of
>> the in-kernel code has to create their own in-kernel test
>> infrastructure.

The kselftest in-kernel tests follow a common pattern.  As such, there
is a framework.

This next two paragraphs you ignored entirely in your reply:

> Why create an entire new subsystem (KUnit) when you can add a header
> file (and .c code as appropriate) that outputs the proper TAP formatted
> results from kselftest kernel test modules?
> 
> There are already a multitude of in kernel test modules used by
> kselftest.  It would be good if they all used a common TAP compliant
> mechanism to report results.


 
>> That's much like saying you can use vice grips to turn a nut or
>> bolt-head.  You *can*, but it might be that using a monkey wrench
>> would be a much better tool that is much easier.
>>
>> What would you say to a wood worker objecting that a toolbox should
>> contain a monkey wrench because he already knows how to use vise
>> grips, and his tiny brain shouldn't be forced to learn how to use a
>> wrench when he knows how to use a vise grip, which is a perfectly good
>> tool?
>>
>> If you want to use vice grips as a hammer, screwdriver, monkey wrench,
>> etc.  there's nothing stopping you from doing that.  But it's not fair
>> to object to other people who might want to use better tools.
>>
>> The reality is that we have a lot of testing tools.  It's not just
>> kselftests.  There is xfstests for file system code, blktests for
>> block layer tests, etc.   We use the right tool for the right job.

My flippant answer:

> More specious arguments.

This time:

I took your answer as a straw man, and had no desire to spend time
countering a straw man.

I am not proposing using a vice grips (to use your analogy).  I
am saying that maybe the monkey wrench already exists.

My point of this whole thread has been to try to get the submitter
to provide a better, more complete explanation of how and why KUnit 
is a better tool.

I have not yet objected to the number (and differences among) the
many sub-system tests.  I am questioning whether there is a need
for another _test framework_ for in-kernel testing.  If there is
something important that KUnit provides that does not exist in
existing frameworks then the next question would be to ask how
to implement that important thing (improve the existing
framework, replace the existing framework, or have two
frameworks).  I still think it is premature to ask this
question until we first know the answer to what unique features
KUnit adds (and apparently until we know what the existing
framework provides).

-Frank

> 
> -Frank
> 
>>
>> 						- Ted
>>
> 
> 


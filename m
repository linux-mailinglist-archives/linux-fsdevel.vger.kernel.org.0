Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADE51900C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2019 20:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfEISMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 May 2019 14:12:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35450 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbfEISMR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 May 2019 14:12:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id t87so1736577pfa.2;
        Thu, 09 May 2019 11:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uxi0dT3bZPj5ZkTVCL1ze6BziBmMlaGGA5Ikg1U2vOM=;
        b=NVDbC1bDsKomR5b17X9A07TUn96+Z0R3C4QHe4+4XmcpJtOfCd8CgmuLCZMfSUHc2Y
         AZQbhyOHVN3PbnfvpXNwIyTiJEC0AnC3A31KnDgtom1X8Z0bgVekXTI3BVaR1rUMtVkc
         mpvbZA/KClKMuTnmyJdmslHsYwuIqmD1989ZCuOTgZCEOLUbJp+Az3OuPzbniWLdhZRK
         A4eykSViXmcMIyntll9GMv/G9FH9fbRHmzzNbY06sd7ytRr4VIvYZ01eaVqBFzNo471Q
         13oOjpRmdvJZD1oIeJ41HPZmqYmiXnHa+CbiBBf3n0hUjCKPHXEpNrM3Np8eHuClrL/7
         NdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uxi0dT3bZPj5ZkTVCL1ze6BziBmMlaGGA5Ikg1U2vOM=;
        b=KWBcRuY1ZFzu4sDVv4UmjfwaKq1ypyP0wFO59su254aqLyO6sqd/qe8lg7LtaVz+DZ
         DILQ9g6ui/wPoGC+ficqXkRo8/cZLajKc7LRcS47etHwJevyR7jZbJXZJGmjZ48gcO3P
         IkPPTgdGpXmJkG8hm1mKuPJ3/w6i5NiFgZ4Qbfw+ugFaB8LYJbP8CuSR9NOiHp+PNo8s
         k5XisFBfgDa/QJLLLv1TVZFAV7OFG7gvLqRqdYgjVJjI9FY2YzQZllZFpeWtAUm5i8uG
         4rko+w0bTxlE42902DWkY6i0xMxZHzuK8dlHs/AScygUbbTTtmT45g4ixWwIE36L0KB7
         kSDQ==
X-Gm-Message-State: APjAAAXPCZ+B1UcrGCXT2T3mP2FLcr1s2tYqe1Y376c+ear2LYSpRPYZ
        yzSV9gY5e1hZoLb8cS85b70=
X-Google-Smtp-Source: APXvYqwGz4a+VK7p6ts4ffA1rbfVCYWZRJS4YjX+gCEsA57HSqJ7sXPY9ft7Z0NWCteDTJWoQXvRRA==
X-Received: by 2002:a65:5941:: with SMTP id g1mr7554475pgu.51.1557425535979;
        Thu, 09 May 2019 11:12:15 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id l68sm6532427pfb.20.2019.05.09.11.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 11:12:15 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Tim.Bird@sony.com, tytso@mit.edu, knut.omang@oracle.com
Cc:     gregkh@linuxfoundation.org, brendanhiggins@google.com,
        keescook@google.com, kieran.bingham@ideasonboard.com,
        mcgrof@kernel.org, robh@kernel.org, sboyd@kernel.org,
        shuah@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-um@lists.infradead.org, Alexander.Levin@microsoft.com,
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        logang@deltatee.com, mpe@ellerman.id.au, pmladek@suse.com,
        richard@nod.at, rientjes@google.com, rostedt@goodmis.org,
        wfg@linux.intel.com
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <54940124-50df-16ec-1a32-ad794ee05da7@gmail.com>
 <20190507080119.GB28121@kroah.com>
 <a09a7e0e-9894-8c1a-34eb-fc482b1759d0@gmail.com>
 <20190509015856.GB7031@mit.edu>
 <580e092f-fa4e-eedc-9e9a-a57dd085f0a6@gmail.com>
 <20190509032017.GA29703@mit.edu>
 <7fd35df81c06f6eb319223a22e7b93f29926edb9.camel@oracle.com>
 <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
Date:   Thu, 9 May 2019 11:12:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/9/19 10:00 AM, Tim.Bird@sony.com wrote:
>> -----Original Message-----
>> From: Theodore Ts'o 
>>

< massive snip >

I'll reply in more detail to some other earlier messages in this thread
later.

This reply is an attempt to return to the intent of my original reply to
patch 0 of this series.


>> Ultimately, I'm a pragmatist.  If KTF serves your needs best, good for
>> you.  If other approaches are better for other parts of the kernel,
>> let's not try to impose a strict "There Must Be Only One" religion.
>> That's already not true today, and for good reason.  There are many
>> different kinds of kernel code, and many different types of test
>> philosophies.  Trying to force all kernel testing into a single
>> Procrustean Bed is simply not productive.
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

My first reply to patch 0 was in the context of knowing next to nothing
about kselftest.  My level of understanding was essentially from slideware.
(As the thread progressed, I dug a little deeper into kselftest, so now have
a slightly better, though still fairly surface understanding of kselftest).

Maybe I did not explain myself clearly enough in that reply.  I will try
again here.

Patch 0 provided a one paragraph explanation of why KUnit exists, titled

   "## What's so special about unit testing?"

Patch 0 also provided a statement that it is not meant to replace
kselftest, in a paragraph titled

   "## Is KUnit trying to replace other testing frameworks for the kernel?"

I stated:

   "My understanding is that the intent of KUnit is to avoid booting a kernel on
   real hardware or in a virtual machine.  That seems to be a matter of semantics
   to me because isn't invoking a UML Linux just running the Linux kernel in
   a different form of virtualization?

   So I do not understand why KUnit is an improvement over kselftest.

   ...

   What am I missing?"


I was looking for a fuller, better explanation than was given in patch 0
of how KUnit provides something that is different than what kselftest
provides for creating unit tests for kernel code.

New question "(2)":

(2) If KUnit provides something unique, then the obvious follow on
question would be: does it make sense to (a) integrate that feature into
kselftest, (b) integrate the current kselftest in kernel test functionality
into KUnit and convert the in kernel test portion of kselftest to use
KUnit, or (c) KUnit and kselftest are so different that they need to
remain separate features.

*****  Please do not reply to this email with a discussion of "(2)".
*****  Such a discussion is premature if there is not an answer
*****  to my first question.

Observation (3), rephrased:

(3) I also brought up the issue that if option (c) was the answer to
question "(2)" (instead of either option (a) or option (b)) then this
is extra overhead for any developer or maintainer involved in different
subsystems that use the different frameworks.  I intended this as one
possible motivation for why my first question mattered.

Ted grabbed hold of this issue and basically ignored what I intended
to be my core question.  Nobody else has answered my core question,
though Knut's first reply did manage to get somewhere near the
intent of my core question.

*****  Please do not reply to this email with a discussion of "(3)".
*****  Such a discussion is premature if there is not an answer
*****  to my first question.
*****
*****  Also that discussion is already occurring in this thread,
*****  feel free to discuss it there if you want, even though I
*****  feel such discussion is premature.

I still do not have an answer to my original question.

-Frank

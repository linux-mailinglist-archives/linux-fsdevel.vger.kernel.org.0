Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB9801E5F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 02:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfEOAOg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 20:14:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40209 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfEOAOf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 20:14:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so350787pfn.7;
        Tue, 14 May 2019 17:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aAQdPwK8UhHmXdxJzm6jQLoLZaXI/Q5xb4j3/5myTwU=;
        b=DtjFqYj39Dm0Rv+bcjGdBjQ6EN0VVznNIsEvch4bISyaQ/e0Png3fqdAoPlSGFyybQ
         9RdNTatJQF70rYkneWxA0HwEKweBx5SaUxs2qBiWZDr2CTLQmWuFJ9nH5nKDx0Dww2GW
         Z8rok8HxjbdcQqXcj08v6osdgn+0zsqQwd3jqGM6V3OG1lyeNu7zeDJOjnPSzz2eaTXl
         jxqU2PXw8XetaV5HqNXVfIpEJuQGiWY6E99WNHu/hGpkNajhdTPWmMM+DcAwvntY2jlA
         MKDGZsE67wbYfTS3WmTNpzqmm/7pYEDSBFFQRWFMC7Etq/VfKLXr71eehd6T4tb/NW+Q
         rbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aAQdPwK8UhHmXdxJzm6jQLoLZaXI/Q5xb4j3/5myTwU=;
        b=p0PxiK9JT6yDylKkFj7pEo61s2+4o7GjmdE91030oYKFG1H+80kG69yW1v7f62QjqN
         1v1byjVvJ/tQn3StBnxx2IemaYTyKqYcpm0bGPUhlMMPQ8PnmkdZCDDwA4248OwGc/wE
         jBFc8VjAFSeIXkJpD78jhPFDd8IlvIGji8uPwxQyt1DqSPGg+QkzTc6SOCUs0gBoIv+K
         St4rdsej44N6MVlIwD0D2v6h2+Dist0Vj/3S7Cd7FDLzuNSxNrcvXI28350t2APX7I6K
         AU4itUtrOnZtfpevHG6Wy6TAca37/8556Mja5sm/uJPmk4CNv/pEoKmhkxYd3suzIia8
         38Cw==
X-Gm-Message-State: APjAAAW2FBjlSkuSsGQx/jUKXwMEgpL/j2A4Lq6bNr5r4ZGqdGUzgW8i
        JajfQ/plgoON7xm7AZN07Rk=
X-Google-Smtp-Source: APXvYqy79bd1G+CGXC0fbDQHPyQsJJqd7yTY4vTthhujhOHeBpcxwWbjzotGY9gkl1u9fw5B3eNBzQ==
X-Received: by 2002:a63:d04b:: with SMTP id s11mr41453267pgi.187.1557879274578;
        Tue, 14 May 2019 17:14:34 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u6sm334194pfm.10.2019.05.14.17.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 17:14:33 -0700 (PDT)
Subject: Re: [PATCH v2 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Brendan Higgins <brendanhiggins@google.com>
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
        amir73il@gmail.com, dan.carpenter@oracle.com,
        dan.j.williams@intel.com, daniel@ffwll.ch, jdike@addtoit.com,
        joel@jms.id.au, julia.lawall@lip6.fr, khilman@baylibre.com,
        mpe@ellerman.id.au, pmladek@suse.com, richard@nod.at,
        rientjes@google.com, rostedt@goodmis.org, wfg@linux.intel.com
References: <20190509133551.GD29703@mit.edu>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770D591@USCULXMSG01.am.sony.com>
 <875c546d-9713-bb59-47e4-77a1d2c69a6d@gmail.com>
 <20190509214233.GA20877@mit.edu>
 <b09ba170-229b-fde4-3e9a-e50d6ab4c1b5@deltatee.com>
 <20190509233043.GC20877@mit.edu>
 <8914afef-1e66-e6e3-f891-5855768d3018@deltatee.com>
 <6d6e91ec-33d3-830b-4895-4d7a20ba7d45@gmail.com>
 <3faa022b-0b70-0375-aa6d-12ea83a2671f@deltatee.com>
 <d148a554-2a71-a5a4-4bb2-d84d2c483277@gmail.com>
 <20190514083819.GC230665@google.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <5ff098a9-9424-901c-9017-d4492e306528@gmail.com>
Date:   Tue, 14 May 2019 17:14:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514083819.GC230665@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/14/19 1:38 AM, Brendan Higgins wrote:
> On Fri, May 10, 2019 at 03:13:40PM -0700, Frank Rowand wrote:
>> On 5/10/19 9:17 AM, Logan Gunthorpe wrote:
>>>
>>>
>>> On 2019-05-09 11:18 p.m., Frank Rowand wrote:
>>>
>>>> YES, kselftest has in-kernel tests.  (Excuse the shouting...)
>>>
>>> Cool. From my cursory look, in my opinion, these would be greatly
>>> improved by converting them to the framework Brendan is proposing for Kunit.
>>>
>>>>> If they do exists, it seems like it would make sense to
>>>>> convert those to kunit and have Kunit tests run-able in a VM or
>>>>> baremetal instance.
>>>>
>>>> They already run in a VM.
>>>>
>>>> They already run on bare metal.
>>>>
>>>> They already run in UML.
>>>
>>> Simply being able to run in UML is not the only thing here. Kunit
>>> provides the infrastructure to quickly build, run and report results for
>>> all the tests from userspace without needing to worry about the details
>>> of building and running a UML kernel, then parsing dmesg to figure out
>>> what tests were run or not.
>>
>> Yes.  But that is not the only environment that KUnit must support to be
>> of use to me for devicetree unittests (this is not new, Brendan is quite
>> aware of my needs and is not ignoring them).
>>
>>
>>>> This is not to say that KUnit does not make sense.  But I'm still trying
>>>> to get a better description of the KUnit features (and there are
>>>> some).
>>>
>>> So read the patches, or the documentation[1] or the LWN article[2]. It's
>>> pretty well described in a lot of places -- that's one of the big
>>> advantages of it. In contrast, few people seems to have any concept of
>>> what kselftests are or where they are or how to run them (I was
>>> surprised to find the in-kernel tests in the lib tree).
>>>
>>> Logan
>>>
>>> [1] https://google.github.io/kunit-docs/third_party/kernel/docs/
>>> [2] https://lwn.net/Articles/780985/
>>
>> I have been following the RFC versions.  I have installed the RFC patches
>> and run them to the extent that they worked (devicetree unittests were
>> a guinea pig for test conversion in the RFC series, but the converted
>> tests did not work).  I read portions of the code while trying to
>> understand the unittests conversion.  I made review comments based on
>> the portion of the code that I did read.  I have read the documentation
>> (very nice btw, as I have said before, but should be expanded).
>>
>> My comment is that the description to submit the patch series should
>> be fuller -- KUnit potentially has a lot of nice attributes, and I
>> still think I have only scratched the surface.  The average reviewer
>> may have even less in-depth knowledge than I do.  And as I have
>> commented before, I keep diving into areas that I had no previous
>> experience with (such as kselftest) to be able to properly judge this
>> patch series.
> 
> Thanks for the praise! That means a lot coming from you!
> 
> I really cannot disagree that I could use more documentation. You can
> pretty much always use more documentation. Nevertheless, is there a
> particular part of the documentation that you think it lacking?

I wasn't talking about the documentation that is part of KUnit.  I was
targeting patch 0.


> It sounds like there was a pretty long discussion here about, a number
> of different things.
> 
> Do you want a better description of what unit testing is and how KUnit
> helps make it possible?
> 
> Do you want more of an explanation distinguishing KUnit from kselftest?
> How so?

The high level issue is to provide reviewers with enough context to be
able to evaluate the patch series.  That is probably not very obvious
at this point in the thread.  At this point I was responding to Logan's
response to me that I should be reading Documentation to get a better
description of KUnit features.  I _think_ that Logan thought that I
did not understand KUnit features and was trying to be helpful by
pointing out where I could get more information.  If so, he was missing
my intended point had been that patch 0 should provide more information
to justify adding this feature.

One thing that has become very apparent in the discussion of this patch
series is that some people do not understand that kselftest includes
in-kernel tests, not just userspace tests.  As such, KUnit is an
additional implementation of "the same feature".  (One can debate
exactly which in-kernel test features kselftest and KUnit provide,
and how much overlap exists or does not exist.  So don't take "the
same feature" as my final opinion of how much overlap exists.)  So
that is a key element to be noted and explained.

I don't have a goal of finding all the things to include in patch 0,
that is really your job as the patch submitter.  But as a reviewer,
it is easy for me to point out an obvious hole, even if I don't find
all of the holes.  kselftest vs KUnit overlap was an obvious hole to
me.

So, yes, more of an explanation about the in-kernel testing available
via kselftest vs the in-kernel testing available via KUnit, and how
they provide the same or different functionality.  Should both exist?
Should one replace the other?  If one provides additional features,
should the additional features be merged into a common base?

> Do you just want better documentation on how to test the kernel? What
> tools we have at our disposal and when to use what tools?
> 
> Thanks!
> .
> 


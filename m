Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8F15B1F8A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Sep 2022 15:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbiIHNqY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Sep 2022 09:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiIHNqX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:46:23 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C3FB5A68;
        Thu,  8 Sep 2022 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1662644776; i=@fujitsu.com;
        bh=yMCPAIebxWO4vvQFb71MGPuxF6WjMXvRRiRf6mryorw=;
        h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
         In-Reply-To:Content-Type:Content-Transfer-Encoding;
        b=avrZt2VJjTxJirixqR6H/V3e3wSSh0H6k561RdHpHtuheftdEtoCd3HVUIjAtPI/S
         kt7WK6oIWizI6paJwqi8NFnPgdBmr9S/56r/TF73r5bkxZPfz59PmGS8jugzB8jqwz
         ZUNVOYrsF5fRBOdB60l2ngHleVhJ0pwkejVn3NIwzkiOb80foyC4H83daGKT+d8ahU
         +xrYvjdZlPbZwzCT2nXHA5/J1i4m43BAfUyAbXSq0vMPIHGGDlcnuQhjLdaRwwgmOk
         9+Rz/v9IG47pMYQ5c7Zym95cNdVscrt0Jmpje+whrrLnDdq6QmtLIdfRUvOE2567y0
         eehsLdqMcJChQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRWlGSWpSXmKPExsViZ8MxSVf9k2S
  ywatGa4t3n6ssthy7x2hx+QmfxekJi5gs9uw9yWJxedccNotdf3awW6z88YfVgcPj1CIJj80r
  tDw2repk83ixeSajx/t9V9k8Pm+SC2CLYs3MS8qvSGDNOPZ3EXvBJdmKR+32DYx/xLsYuTiEB
  LYwSjSunMQO4Sxnkuh49p4RwtkGlHkLkuHk4BWwk/i87i6YzSKgIvHr0GWouKDEyZlPWEBsUY
  FkibuH14PZwgK+Ems39TF3MXJwiAjYS3ScMgCZySzQzizx79kuqAVnmSRud35hAmlgE9CRuLD
  gLyuIzSmgIXFq+ywwm1nAQmLxm4PsELa8RPPW2WBDJQSUJGZ2x4OEJQQqJBqnH2KCsNUkrp7b
  xDyBUWgWkvNmIZk0C8mkBYzMqxitk4oy0zNKchMzc3QNDQx0DQ1NdY2NdA2NzPQSq3QT9VJLd
  ctTi0t0jfQSy4v1UouL9Yorc5NzUvTyUks2MQKjLKVYoW4H47WVP/UOMUpyMCmJ8u5eKJksxJ
  eUn1KZkVicEV9UmpNafIhRhoNDSYI3+C1QTrAoNT21Ii0zBxjxMGkJDh4lEd6Pb4DSvMUFibn
  FmekQqVOMuhznd+7fyyzEkpeflyolzmv4HqhIAKQoozQPbgQs+VxilJUS5mVkYGAQ4ilILcrN
  LEGVf8UozsGoJMyr8AFoCk9mXgncpldARzABHbE1UBzkiJJEhJRUA5N7H9f5pwdWzeS5ZS8Rt
  nZH8JYrjdxB3X5Vc77Ev4x3j+L9cnPb7eYzz0L/8Ia2a5psm61ikvfa48n6ma/TnF6HbzmV5X
  KucuHWG+vv1Qts1WnM6He9YPJq2vFwFUcOWz3u+51FlmJegi4cdvL+51+Iyj1f+ev/qpXNU0p
  v2qZoMJV5yTW8i8hY3ramN+iW3mVp/RXaFloNzjdYPl/VqlltdvH1Ecmjp2ZuSf82Zz3L5K9n
  V53boLf5v2PQuk3Z/Y+uvmDg7rKZ9fBrj0Oyw3Ter8ct1pdqfOI16HfPPhdjoqptHuG4eNK6s
  9+E7vBuYNK3fn+tflbR8h8f246/vz/93Crlj9dTDlbEncyc28asxFKckWioxVxUnAgAiO6r/r
  kDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-6.tower-571.messagelabs.com!1662644775!176728!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15548 invoked from network); 8 Sep 2022 13:46:15 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-6.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 8 Sep 2022 13:46:15 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 995BC1000FB;
        Thu,  8 Sep 2022 14:46:15 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 8B6F5100078;
        Thu,  8 Sep 2022 14:46:15 +0100 (BST)
Received: from [192.168.22.78] (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 8 Sep 2022 14:46:11 +0100
Message-ID: <dd363bd8-2dbd-5d9c-0406-380b60c5f510@fujitsu.com>
Date:   Thu, 8 Sep 2022 21:46:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
To:     "Darrick J. Wong" <djwong@kernel.org>, <bfoster@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        =?UTF-8?B?WWFuZywgWGlhby/mnagg5pmT?= <yangx.jy@fujitsu.com>
References: <20220609143435.393724-1-ruansy.fnst@fujitsu.com>
 <Yr5AV5HaleJXMmUm@magnolia>
 <74b0a034-8c77-5136-3fbd-4affb841edcb@fujitsu.com>
 <Ytl7yJJL1fdC006S@magnolia>
 <7fde89dc-2e8f-967b-d342-eb334e80255c@fujitsu.com>
 <YuNn9NkUFofmrXRG@magnolia>
 <0ea1cbe1-79d7-c22b-58bf-5860a961b680@fujitsu.com>
 <YusYDMXLYxzqMENY@magnolia>
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
In-Reply-To: <YusYDMXLYxzqMENY@magnolia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



在 2022/8/4 8:51, Darrick J. Wong 写道:
> On Wed, Aug 03, 2022 at 06:47:24AM +0000, ruansy.fnst@fujitsu.com wrote:

...

>>>>>>
>>>>>> BTW, since these patches (dax&reflink&rmap + THIS + pmem-unbind) are
>>>>>> waiting to be merged, is it time to think about "removing the
>>>>>> experimental tag" again?  :)
>>>>>
>>>>> It's probably time to take up that question again.
>>>>>
>>>>> Yesterday I tried running generic/470 (aka the MAP_SYNC test) and it
>>>>> didn't succeed because it sets up dmlogwrites atop dmthinp atop pmem,
>>>>> and at least one of those dm layers no longer allows fsdax pass-through,
>>>>> so XFS silently turned mount -o dax into -o dax=never. :(
>>>>
>>>> Hi Darrick,
>>>>
>>>> I tried generic/470 but it didn't run:
>>>>      [not run] Cannot use thin-pool devices on DAX capable block devices.
>>>>
>>>> Did you modify the _require_dm_target() in common/rc?  I added thin-pool
>>>> to not to check dax capability:
>>>>
>>>>            case $target in
>>>>            stripe|linear|log-writes|thin-pool)  # add thin-pool here
>>>>                    ;;
>>>>
>>>> then the case finally ran and it silently turned off dax as you said.
>>>>
>>>> Are the steps for reproduction correct? If so, I will continue to
>>>> investigate this problem.
>>>
>>> Ah, yes, I did add thin-pool to that case statement.  Sorry I forgot to
>>> mention that.  I suspect that the removal of dm support for pmem is
>>> going to force us to completely redesign this test.  I can't really
>>> think of how, though, since there's no good way that I know of to gain a
>>> point-in-time snapshot of a pmem device.
>>
>> Hi Darrick,
>>
>>   > removal of dm support for pmem
>> I think here we are saying about xfstest who removed the support, not
>> kernel?
>>
>> I found some xfstests commits:
>> fc7b3903894a6213c765d64df91847f4460336a2  # common/rc: add the restriction.
>> fc5870da485aec0f9196a0f2bed32f73f6b2c664  # generic/470: use thin-pool
>>
>> So, this case was never able to run since the second commit?  (I didn't
>> notice the not run case.  I thought it was expected to be not run.)
>>
>> And according to the first commit, the restriction was added because
>> some of dm devices don't support dax.  So my understanding is: we should
>> redesign the case to make the it work, and firstly, we should add dax
>> support for dm devices in kernel.
> 
> dm devices used to have fsdax support; I think Christoph is actively
> removing (or already has removed) all that support.
> 
>> In addition, is there any other testcase has the same problem?  so that
>> we can deal with them together.
> 
> The last I checked, there aren't any that require MAP_SYNC or pmem aside
> from g/470 and the three poison notification tests that you sent a few
> days ago.
> 
> --D
> 

Hi Darrick, Brian

I made a little investigation on generic/470.

This case was able to run before introducing thin-pool[1], but since 
that, it became 'Failed'/'Not Run' because thin-pool does not support 
DAX.  I have checked the log of thin-pool, it never supports DAX.  And, 
it's not someone has removed the fsdax support.  So, I think it's not 
correct to bypass the requirement conditions by adding 'thin-pool' to 
_require_dm_target().

As far as I known, to prevent out-of-order replay of dm-log-write, 
thin-pool was introduced (to provide discard zeroing).  Should we solve 
the 'out-of-order replay' issue instead of avoiding it by thin-pool? @Brian

Besides, since it's not a fsdax problem, I think there is nothing need 
to be fixed in fsdax.  I'd like to help it solved, but I'm still 
wondering if we could back to the original topic("Remove Experimental 
Tag") firstly? :)


[1] fc5870da485aec0f9196a0f2bed32f73f6b2c664 generic/470: use thin 
volume for dmlogwrites target device


--
Thanks,
Ruan.



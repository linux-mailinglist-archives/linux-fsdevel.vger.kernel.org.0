Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0C75FFEF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 06:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbfGEEJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jul 2019 00:09:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60406 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfGEEJU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jul 2019 00:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EpLpp6d5ev9UdUsgMU6f1l10/dE3Pg2qZg1140QaSWM=; b=b1jq75dxQbtB+7a65u6Rylo1L
        01T+/tPNKG4kAsias6gKT+e74KMYqsNVmHNpVUoATOVU43k0Q/oYEhbxb7uASluBzw9t31DXxOL4F
        VX9z+yb05Q+x9j+UVT6qB5SgP2QBi4gKgLvzIk7PpgKOFDOM75PF44vgjqpqzs1tXlSKHC82n/NJR
        mcjMdya35Mmn8wRdnCrJX1ijkuZzv7v7xGKF4UDt8ePkXqFbZInlYET+gWKS5rEU+CyZuoTWm3XSc
        Hk7S9UcSvq651qhTErC6lu0KudmoNoOKgrdnKQPc+r9geI20Fp6U2sgvPOInrz+2PZxT+v0SZsNyA
        uxb8DneeQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjFXC-0007w4-C8; Fri, 05 Jul 2019 04:09:18 +0000
Subject: Re: mmotm 2019-07-04-15-01 uploaded (gpu/drm/i915/oa/)
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel <dri-devel@lists.freedesktop.org>
References: <20190704220152.1bF4q6uyw%akpm@linux-foundation.org>
 <80bf2204-558a-6d3f-c493-bf17b891fc8a@infradead.org>
 <CAK7LNAQc1xYoet1o8HJVGKuonUV40MZGpK7eHLyUmqet50djLw@mail.gmail.com>
 <CAK7LNASLfyreDPvNuL1svvHPC0woKnXO_bsNku4DMK6UNn4oHw@mail.gmail.com>
 <5e5353e2-bfab-5360-26b2-bf8c72ac7e70@infradead.org>
 <CAK7LNATF+D5TgTZijG3EPBVON5NmN+JcwmCBvnvkMFyR+3wF2A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8868b3fc-ba16-2b01-4ebb-4bdefc2f9e18@infradead.org>
Date:   Thu, 4 Jul 2019 21:09:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK7LNATF+D5TgTZijG3EPBVON5NmN+JcwmCBvnvkMFyR+3wF2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/4/19 8:44 PM, Masahiro Yamada wrote:
> On Fri, Jul 5, 2019 at 12:23 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 7/4/19 8:09 PM, Masahiro Yamada wrote:
>>> On Fri, Jul 5, 2019 at 12:05 PM Masahiro Yamada
>>> <yamada.masahiro@socionext.com> wrote:
>>>>
>>>> On Fri, Jul 5, 2019 at 10:09 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>>
>>>>> On 7/4/19 3:01 PM, akpm@linux-foundation.org wrote:
>>>>>> The mm-of-the-moment snapshot 2019-07-04-15-01 has been uploaded to
>>>>>>
>>>>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>>>>
>>>>>> mmotm-readme.txt says
>>>>>>
>>>>>> README for mm-of-the-moment:
>>>>>>
>>>>>> http://www.ozlabs.org/~akpm/mmotm/
>>>>>
>>>>> I get a lot of these but don't see/know what causes them:
>>>>>
>>>>> ../scripts/Makefile.build:42: ../drivers/gpu/drm/i915/oa/Makefile: No such file or directory
>>>>> make[6]: *** No rule to make target '../drivers/gpu/drm/i915/oa/Makefile'.  Stop.
>>>>> ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915/oa' failed
>>>>> make[5]: *** [drivers/gpu/drm/i915/oa] Error 2
>>>>> ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915' failed
>>>>>
>>>>
>>>> I checked next-20190704 tag.
>>>>
>>>> I see the empty file
>>>> drivers/gpu/drm/i915/oa/Makefile
>>>>
>>>> Did someone delete it?
>>>>
>>>
>>>
>>> I think "obj-y += oa/"
>>> in drivers/gpu/drm/i915/Makefile
>>> is redundant.
>>
>> Thanks.  It seems to be working after deleting that line.
> 
> 
> Could you check whether or not
> drivers/gpu/drm/i915/oa/Makefile exists in your source tree?

It does not.

> Your build log says it was missing.
> 
> But, commit 5ed7a0cf3394 ("drm/i915: Move OA files to separate folder")
> added it.  (It is just an empty file)
> 
> I am just wondering why.

I am not using any git tree(s) for this.  Just patches.

That Makefile is in patch-v5.2-rc7-next-20190704.xz.

I don't know how Andrew generates the linux-next.patch file for mmotm,
but I don't see that Makefile anywhere in mmotm, although the rest of
the i915/oa/ files seems to be there.

Maybe diff skips empty files unless told to save them?

-- 
~Randy

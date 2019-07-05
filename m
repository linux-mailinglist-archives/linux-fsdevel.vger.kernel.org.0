Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3AF65FFB6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2019 05:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfGEDXN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Jul 2019 23:23:13 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57638 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727263AbfGEDXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Jul 2019 23:23:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=47wq6zSwqlBqXAKDNtdVAABXSaO0oASysFivQ8oCp8o=; b=BvDOOgZZqM9q76ywqtMSOtZ5rx
        4Yd/UFEsS1GbqcB1rh/9KgGpfLcWP0U1xWMX2d6RQm6pH2Y3b4L6yCf5UREw5z4M2lek5I5v5tqQG
        zeuxzyBWysZzObFCZgufRB/0uPOuIGeMiuKVjtQaNpEeW+5m4hIe2wMkPQUgcEr749i0GTBTNnL/s
        OVbyuzmWvBKTW+zo+rotD9KtchIGCSHtkp5IvEJ5H1vylQAew65hVblOCVzVQi+8phNLDiV5kRC0j
        D52fKegavaYmacCiyuD8u1pXFBflKpuU/8uUkhvg2vdl+n8bdtXiSn/QEGDUqB4ROMIo5pidwjHqM
        54BfyB3Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hjEoW-0007BD-CQ; Fri, 05 Jul 2019 03:23:09 +0000
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
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5e5353e2-bfab-5360-26b2-bf8c72ac7e70@infradead.org>
Date:   Thu, 4 Jul 2019 20:23:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK7LNASLfyreDPvNuL1svvHPC0woKnXO_bsNku4DMK6UNn4oHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/4/19 8:09 PM, Masahiro Yamada wrote:
> On Fri, Jul 5, 2019 at 12:05 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> On Fri, Jul 5, 2019 at 10:09 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> On 7/4/19 3:01 PM, akpm@linux-foundation.org wrote:
>>>> The mm-of-the-moment snapshot 2019-07-04-15-01 has been uploaded to
>>>>
>>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>>
>>>> mmotm-readme.txt says
>>>>
>>>> README for mm-of-the-moment:
>>>>
>>>> http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> I get a lot of these but don't see/know what causes them:
>>>
>>> ../scripts/Makefile.build:42: ../drivers/gpu/drm/i915/oa/Makefile: No such file or directory
>>> make[6]: *** No rule to make target '../drivers/gpu/drm/i915/oa/Makefile'.  Stop.
>>> ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915/oa' failed
>>> make[5]: *** [drivers/gpu/drm/i915/oa] Error 2
>>> ../scripts/Makefile.build:498: recipe for target 'drivers/gpu/drm/i915' failed
>>>
>>
>> I checked next-20190704 tag.
>>
>> I see the empty file
>> drivers/gpu/drm/i915/oa/Makefile
>>
>> Did someone delete it?
>>
> 
> 
> I think "obj-y += oa/"
> in drivers/gpu/drm/i915/Makefile
> is redundant.

Thanks.  It seems to be working after deleting that line.

-- 
~Randy

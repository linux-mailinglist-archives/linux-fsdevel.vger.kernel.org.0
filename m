Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67863231782
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 04:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbgG2CER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 22:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgG2CEQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 22:04:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD28C0619D2;
        Tue, 28 Jul 2020 19:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ptZ4CaB+9ZPFK7eW316fU2oYVkH0yzLQ4pZT4nFsjOA=; b=L8btYvGdt15/+hqPaBMVifuHFP
        mj1IC0WwS/5cB699Ff1misVVzWwylEgRgEeikp3o/HEiq+IyuXdd6WoWiXKDbcNet35tUEacF9F+9
        mTYW32EXz7eJ/JSPU2++z/q2bQfBo5prJ2CKpSn404aT0xYiDT1cZoVI4cZ1GREvWMq8SK5FNhqgv
        Lx/3DW/HMBwZBVDr0Rr7vmXvNb+UYGm6DsZZr5TKt+r2yhEvRq/kp4Jmg8cTkHauBvfjZeKgZL2CG
        SCwjA23ZuC+u/AqV2hlZ4HIYdHMxBYe7VnBlWw0ukpM+T48gLB8uyjhAHWYmM98XD1fqBBbKRt2bI
        LjM9hGDQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0bS1-0001A0-Q2; Wed, 29 Jul 2020 02:04:14 +0000
Subject: Re: mmotm 2020-07-27-18-18 uploaded (mm/page_alloc.c)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
References: <20200728011914.S-8vAYUK0%akpm@linux-foundation.org>
 <ae87385b-f830-dbdf-ebc7-1afb82a7fed0@infradead.org>
 <20200728145553.2a69fa2080de01922b3a74e0@linux-foundation.org>
 <048cef07-ad4b-8788-94a4-e144de731ab6@infradead.org>
 <20200728184419.4b137162844987c9199542bb@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bdd0b49f-2cdd-02e1-3c91-d96b4f806490@infradead.org>
Date:   Tue, 28 Jul 2020 19:04:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728184419.4b137162844987c9199542bb@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/28/20 6:44 PM, Andrew Morton wrote:
> On Tue, 28 Jul 2020 15:39:21 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 7/28/20 2:55 PM, Andrew Morton wrote:
>>> On Tue, 28 Jul 2020 05:33:58 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>>> On 7/27/20 6:19 PM, Andrew Morton wrote:
>>>>> The mm-of-the-moment snapshot 2020-07-27-18-18 has been uploaded to
>>>>>
>>>>>    http://www.ozlabs.org/~akpm/mmotm/
>>
>>
>>>> on x86_64:
>>>>
>>>> ../mm/page_alloc.c:8355:48: warning: ‘struct compact_control’ declared inside parameter list will not be visible outside of this definition or declaration
>>>>  static int __alloc_contig_migrate_range(struct compact_control *cc,
>>>>                                                 ^~~~~~~~~~~~~~~
>>>
>>> As is usually the case with your reports, I can't figure out how to
>>> reproduce it.  I copy then .config, run `make oldconfig' (need to hit
>>> enter a zillion times because the .config is whacky) then the build
>>> succeeds.  What's the secret?
>>
>> I was not aware that there was a problem. cp .config and make oldconfig
>> should be sufficient -- and I don't understand why you would need to hit
>> enter many times.
>>
>> I repeated this on my system without having to answer any oldconfig prompts
>> and still got build errors.
>>
>> There is no secret that I know of, but it would be good to get to the
>> bottom of this problem.
> 
> Well the first thing I hit was
> 
> Support for big SMP systems with more than 8 CPUs (X86_BIGSMP) [N/y/?] (NEW) 
> 
> and your .config doesn't mention that.

It's an x86_32 symbol and my config was for x86_64.


> make mrproper
> cp ~/config-randy .config
> make oldconfig

make ARCH=x86_64 oldconfig

HTH.
-- 
~Randy


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20295004CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 05:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbiDNDv0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 23:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiDNDvZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:51:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B928251E6E;
        Wed, 13 Apr 2022 20:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hwXbxLxNz2I8kL+yuirpQbS69KozlT5Hp/S+XH6keCM=; b=Kx/KQ74Ovy/C2kAapPnfoW6L3K
        b2U/nE3FohteuqbQ2ZEnh+GRwtU8bYp+E3O9MeYvWoDHz80QRZfViL6dXLdBDoQNXOlIx38cLMLwR
        UmwqhnvqgQ5rkJ1Yu2i8txsMd/7bl9n24W4Cn9bYocNYBpaymilXVDMkivFyEsafeAIBLR72VCZjP
        WNs/+IGY+BydzEyrdX+UIfVG4IYUeoCQMDFE/ppR2GxnY9Jg0i3VWjdHOUEFy3xBDaPlC8EBLnJhd
        HeNt82cOdf0+WKAXTtjKijwoqsDtpleGOcIQdqHa6K10k2BPJxvP0H9XdLqtPOutdgkv5ATngx2WO
        3nod+yBQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neqTR-004tJk-OZ; Thu, 14 Apr 2022 03:48:52 +0000
Message-ID: <bfdcc7c8-922f-61a9-aa15-7e7250f04af7@infradead.org>
Date:   Wed, 13 Apr 2022 20:48:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: mmotm 2022-04-12-21-05 uploaded (ARCH_HAS_NONLEAF_PMD_YOUNG)
Content-Language: en-US
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
References: <20220413040610.06AAAC385A4@smtp.kernel.org>
 <4ef4aa81-ed32-6c7f-2504-e7462bbaae2d@infradead.org>
 <CAOUHufb8yn3PF9gm3ahne2GLs8SCpjjuz_DpS1aH75jeDT_J7A@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAOUHufb8yn3PF9gm3ahne2GLs8SCpjjuz_DpS1aH75jeDT_J7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/13/22 20:43, Yu Zhao wrote:
> On Wed, Apr 13, 2022 at 9:39 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 4/12/22 21:06, Andrew Morton wrote:
>>> The mm-of-the-moment snapshot 2022-04-12-21-05 has been uploaded to
>>>
>>>    https://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> https://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>> https://ozlabs.org/~akpm/mmotm/series
>>
>> on i386:
>>
>> WARNING: unmet direct dependencies detected for ARCH_HAS_NONLEAF_PMD_YOUNG
>>   Depends on [n]: PGTABLE_LEVELS [=2]>2
>>   Selected by [y]:
>>   - X86 [=y]
> 
> Thanks for the heads up. Please try the following fix if it gets in your way.
> 
> https://lore.kernel.org/mm-commits/20220414023214.40C14C385A6@smtp.kernel.org/

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
~Randy

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1A44DBF48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 07:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiCQGUh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 02:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiCQGUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:20:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC1C133D85;
        Wed, 16 Mar 2022 23:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=CzacQYJi32PCX+c/yxXJ0QzlHaqXqdWAvq0PEazvbzI=; b=Y3iIWiZnipyTfxQNEW7QXq7gJa
        MT8yeWcXDKvN/4QmNRC/u0Sq2Gousi4W4dyMKQqB9taxiuSTcIfojaWcdbLW5sptUSQ6csA/8SY7x
        bbeReSnv1v3Kcdh4pVI2TlWLEOvXyquu2pvbIqUkrxym62r94oMWUAKP88wkG/nPlBiNyj7fBGDgb
        DeLcXg0AkNm7x66XX4Q4K74dkU/lHclU2gEhsdVBCoKsoJT1IXWa0QT3u/6sJezDPAkZ3QAWu7Rih
        ebT6PB4EYZb7eg2gX3dfh2LLqkw90Rg8Yxugqlb3mU+kgj8ytyRSoNHclNd+Rk7RRJzQOz16dRrIX
        +4TWXPMQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUhjT-001mGI-47; Thu, 17 Mar 2022 04:27:27 +0000
Message-ID: <2dd6d3f1-4213-aeec-dff1-5837f15865be@infradead.org>
Date:   Wed, 16 Mar 2022 21:27:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: mmotm 2022-03-16-17-42 uploaded (uml sub-x86_64, sched/fair, RCU)
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>, paulmck@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>
References: <20220317004304.95F89C340E9@smtp.kernel.org>
 <0f622499-36e1-ea43-ddc3-a8b3bb08d34b@infradead.org>
In-Reply-To: <0f622499-36e1-ea43-ddc3-a8b3bb08d34b@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/16/22 21:21, Randy Dunlap wrote:
> 
> 
> On 3/16/22 17:43, Andrew Morton wrote:
>> The mm-of-the-moment snapshot 2022-03-16-17-42 has been uploaded to
>>
>>    https://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> https://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
>> You will need quilt to apply these patches to the latest Linus release (5.x
>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>> https://ozlabs.org/~akpm/mmotm/series
> 
> 
> UML for x86_64, defconfig:

Also seen on UML for i386, x86_64, and i386.

> In file included from ./arch/x86/include/generated/asm/rwonce.h:1:0,
>                  from ../include/linux/compiler.h:248,
>                  from ../include/linux/kernel.h:20,
>                  from ../include/linux/cpumask.h:10,
>                  from ../include/linux/energy_model.h:4,
>                  from ../kernel/sched/fair.c:23:
> ../include/linux/psi.h: In function ‘cgroup_move_task’:
> ../include/linux/rcupdate.h:414:36: error: dereferencing pointer to incomplete type ‘struct css_set’
>  #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
>                                     ^~~~
> ../include/asm-generic/rwonce.h:55:33: note: in definition of macro ‘__WRITE_ONCE’
>   *(volatile typeof(x) *)&(x) = (val);    \
>                                  ^~~
> ../include/asm-generic/barrier.h:190:2: note: in expansion of macro ‘WRITE_ONCE’
>   WRITE_ONCE(*p, v);      \
>   ^~~~~~~~~~
> ../include/linux/rcupdate.h:455:3: note: in expansion of macro ‘smp_store_release’
>    smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>    ^~~~~~~~~~~~~~~~~
> ../include/linux/rcupdate.h:455:25: note: in expansion of macro ‘RCU_INITIALIZER’
>    smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>                          ^~~~~~~~~~~~~~~
> ../include/linux/psi.h:58:2: note: in expansion of macro ‘rcu_assign_pointer’
>   rcu_assign_pointer(p->cgroups, to);
>   ^~~~~~~~~~~~~~~~~~
> 
> 
> 

-- 
~Randy

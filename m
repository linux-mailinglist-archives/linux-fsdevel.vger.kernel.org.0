Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856D34DD1A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 01:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiCRAMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 20:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiCRAMI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:12:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E799E29CE;
        Thu, 17 Mar 2022 17:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=UOOQMXKnC3EL2rzumcle1jcblKs+Qj46u7I1wgq3BX8=; b=ohfbQ4+XpS70ZtH4DYm373Ug5c
        7SsD8IcKE5B7pJ4NnHkJMEW2kvq6T20I7X+bEW8Xp36helbB+dpPdnNpHEy4fY/ny/o35QCLaPXn4
        KaSjDMO3bdX94U5UNZEPsp22HLkzAHRnbJCfHqDHY9erDhNQ66EbREQEpD1T+kg8hcUXZXvy1VPcQ
        Zu2ujJzNGoZ9QHEIfPOTgatfGHmz+WN+QRvGfTBRA3S/Itch7K6T1w0lJzCrE+CIa0Ev/eGWv+jLO
        PDQ7HAtLNe0SutdkdzN9nwVLEtHvvOMTVqsO4Ifyq9taLXV52HUUcC1qUZ1QtsbL5lELvJt+81/zI
        kCw0J/nA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nV0CR-007SBE-Rt; Fri, 18 Mar 2022 00:10:36 +0000
Message-ID: <99d45fe4-53ca-b966-e140-cd68b731292a@infradead.org>
Date:   Thu, 17 Mar 2022 17:10:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: mmotm 2022-03-16-17-42 uploaded (uml sub-x86_64, sched/fair, RCU)
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>, paulmck@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>
References: <20220317004304.95F89C340E9@smtp.kernel.org>
 <0f622499-36e1-ea43-ddc3-a8b3bb08d34b@infradead.org>
 <20220316213011.8cac447e692283a4b5d97f3d@linux-foundation.org>
 <917e9ce0-c8cf-61b2-d1ba-ebf25bbd979d@infradead.org>
 <20220317165100.2755c5ae6a3a08b7ecb06181@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220317165100.2755c5ae6a3a08b7ecb06181@linux-foundation.org>
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



On 3/17/22 16:51, Andrew Morton wrote:
> On Wed, 16 Mar 2022 21:52:44 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>>>> In file included from ./arch/x86/include/generated/asm/rwonce.h:1:0,
>>>>                  from ../include/linux/compiler.h:248,
>>>>                  from ../include/linux/kernel.h:20,
>>>>                  from ../include/linux/cpumask.h:10,
>>>>                  from ../include/linux/energy_model.h:4,
>>>>                  from ../kernel/sched/fair.c:23:
>>>> ../include/linux/psi.h: In function ‘cgroup_move_task’:
>>>> ../include/linux/rcupdate.h:414:36: error: dereferencing pointer to incomplete type ‘struct css_set’
>>>>  #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
>>>>                                     ^~~~
>>>
>>> Works For Me.  I tried `make x86_64_defconfig' and `make i386_defconfig' too.
>>>
>>> Can you please share that .config, or debug a bit?
>>
>> $ make ARCH=um SUBARCH=x86_64 defconfig
>>
> 
> I still can't reproduce this :(
> 
>> This fixes the build error for me when CONFIG_PSI=n.
> 
> I have CONFIG_PSI=n

There was also this report about linux-next, also with CONFIG_PSI=n:

https://lore.kernel.org/all/EF33D230-9A8F-41C5-A38D-95128603224F@linux.ibm.com/

but I just tried to build with the .config file supplied there and didn't
have any build errors...

If it was just me & mmotm, I could see it being a problem with applying
patches, but this other report looks the same as my initial report.

I dunno. If it persists, we will track it down and quash it.

>> ---
>>  include/linux/psi.h |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> --- mmotm-2022-0316-1742.orig/include/linux/psi.h
>> +++ mmotm-2022-0316-1742/include/linux/psi.h
>> @@ -53,6 +53,9 @@ static inline int psi_cgroup_alloc(struc
>>  static inline void psi_cgroup_free(struct cgroup *cgrp)
>>  {
>>  }
>> +
>> +#include <linux/cgroup-defs.h>
>> +
>>  static inline void cgroup_move_task(struct task_struct *p, struct css_set *to)
>>  {
>>  	rcu_assign_pointer(p->cgroups, to);
> 
> Nothing in -next touches psi.h so I am unable to determine which patch
> needs fixing :(

-- 
~Randy

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5504DBF3C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 07:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiCQGUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 02:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiCQGUI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:20:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCBE12C6CC;
        Wed, 16 Mar 2022 23:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=XYhITqjVeQlf/f3mSnwwESbB4qHWGV3aRRTvRnzQdQs=; b=pGGdcaDHsyzjVZrrU+UzpWdJNu
        hvjK8tyYNByZ+3ybiA+ybjlaecuYesJ31VMdFS4wi5lrqBgHtQvwbIVXA+TQlwYkLOxJxiYuDMfQ6
        ALs9XqY/3/fHiJiGHc7woSCZ7OkAe0Esltuo2qv/NKb9mwZ1MUNI5HY3bX9UztPay62vTyDmwyg+K
        5R7dgNDRWaLDvNpxB03l4LXRI4zfPWON83PwF04bcx/GNWwZ9JwI0TP3ECyIB035GqookHgczIeQj
        2s4rGJVwPjiuMwwrh2ilsdqxxGfRkJNHCpwJCYBngQ2+ZsmG8PGie7M2jzMw6GYdFOtP49Uoc9CD5
        mJGubA8A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUi82-001mfa-Ip; Thu, 17 Mar 2022 04:52:50 +0000
Message-ID: <917e9ce0-c8cf-61b2-d1ba-ebf25bbd979d@infradead.org>
Date:   Wed, 16 Mar 2022 21:52:44 -0700
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
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220316213011.8cac447e692283a4b5d97f3d@linux-foundation.org>
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



On 3/16/22 21:30, Andrew Morton wrote:
> On Wed, 16 Mar 2022 21:21:16 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>>
>>
>> On 3/16/22 17:43, Andrew Morton wrote:
>>> The mm-of-the-moment snapshot 2022-03-16-17-42 has been uploaded to
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
>>
>> UML for x86_64, defconfig:
>>
>> In file included from ./arch/x86/include/generated/asm/rwonce.h:1:0,
>>                  from ../include/linux/compiler.h:248,
>>                  from ../include/linux/kernel.h:20,
>>                  from ../include/linux/cpumask.h:10,
>>                  from ../include/linux/energy_model.h:4,
>>                  from ../kernel/sched/fair.c:23:
>> ../include/linux/psi.h: In function ‘cgroup_move_task’:
>> ../include/linux/rcupdate.h:414:36: error: dereferencing pointer to incomplete type ‘struct css_set’
>>  #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
>>                                     ^~~~
> 
> Works For Me.  I tried `make x86_64_defconfig' and `make i386_defconfig' too.
> 
> Can you please share that .config, or debug a bit?

$ make ARCH=um SUBARCH=x86_64 defconfig



This fixes the build error for me when CONFIG_PSI=n.

---
 include/linux/psi.h |    3 +++
 1 file changed, 3 insertions(+)

--- mmotm-2022-0316-1742.orig/include/linux/psi.h
+++ mmotm-2022-0316-1742/include/linux/psi.h
@@ -53,6 +53,9 @@ static inline int psi_cgroup_alloc(struc
 static inline void psi_cgroup_free(struct cgroup *cgrp)
 {
 }
+
+#include <linux/cgroup-defs.h>
+
 static inline void cgroup_move_task(struct task_struct *p, struct css_set *to)
 {
 	rcu_assign_pointer(p->cgroups, to);

-- 
~Randy

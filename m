Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0A46752C3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 11:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjATKuB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 05:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjATKuA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 05:50:00 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925A4A272
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 02:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674211799; x=1705747799;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yDfXRh62CXOhxwkokMUICkJH6hx8gFfOCEE7kFzoojM=;
  b=OgMd2ZR5iVoFR1ipqAz9A6+DlzQu03Du/apZcGYvGZudahNsiF76ZxvK
   +R5K48YKAjSl6d2GC/n94ChIPakb6QcyGeBaIJtMSgiqQLOodwIDgQOmx
   RJrPDI1AijW8aiaRt1z2TMMHBvXeLUww7w6i+UHCIT7y6AwNcyG1GnQbB
   LLLyW9Jf0UhQg6Yj3MCs55VA6O0+og/4ML96AzQH3kIx0cv15nFYrsnpX
   HDgcxumQaEGCGGGPQDhKKownhS6p3M2X6Y5gNPPWVodbVEop5eAbUpiuq
   ZM5pk8p0GjbSpxr+U7dat5BgnSh8lTFX9gWsykPTPMdRqy7czD+LT1aKL
   w==;
X-IronPort-AV: E=Sophos;i="5.97,232,1669046400"; 
   d="scan'208";a="219701724"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2023 18:49:57 +0800
IronPort-SDR: eSzi7vb4BRBSeczzFRCGJ/C792KZu+s7NRpSb2DxiLkkIUkCeRVvha0IdzMV9to2S3Y3QNdKoy
 Q3gM5aQCtkfmnP0lmc8k6vHn7wHtRa6GLEknzL4u2DbsWg6DK8oFXwb/hems7Qhqi0rYTRpz4u
 3nQXShLHsVtDwj2xS3jVGSGXVA4DkJkLjg2lMP99k7HEI5H/TWPJuy2yd09ZAtpx+TvuxEcKFk
 s8GM3FUsh3N1hNejZuxi2oKOc+4TBzUzNYmnQPMssYkgf9U5cJJok1PndkKq7k0e/lgoSaaGHV
 aX0=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jan 2023 02:01:50 -0800
IronPort-SDR: cGzG9mrGjH9c4bbTTleOwCVaa/iwxMv3doo2oKIQ9bUf6FAx7J1QA7Nn/FoGrrMAf+z2tBxjAm
 KF1baDbGEWG9G4BUGDdIoILFEdb3F2GXSxik2piXSPZzf/M6TPDAB8RhbCir8pKxh2W/Gnp3uC
 gLjNHgvcy/5Gn3LUPc6ixpGMseUvs7VA9Et/F5E1YlR+6AtTD5OVFwOSX5EAN6y+Y2huBZGRwY
 VA0Tj/UFIAq75662VrQ981da5oSbqYLz72bd2E8xl1PjFhHd0ulSY0LjqEC4Qd61tNXh+UYqkb
 Zt0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jan 2023 02:49:57 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nyx8h6rSMz1RvTp
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 02:49:56 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674211795; x=1676803796; bh=yDfXRh62CXOhxwkokMUICkJH6hx8gFfOCEE
        7kFzoojM=; b=IKIlu8sKhW69D9kmzWqNRa5wDX/WdgQiojQQf/8grzSmBWVsoK1
        5III3ooowvXfG04nsLri3yaRhGHrDvgq4ZoxNZKR4KNFdPaLZZb4Oa9EbfVrNDIO
        CqQ6+MFx4cyY5E3H0YpdPcvzvndxVSxJFgy4P5nDoU66e/ShAlBZLzaWpyKlhRpl
        rOQlD8GIYj9b3HI+mLR6qpbv8zMoYPheOxSWdCKlvVoWrKERIoI2ibqqNxm96Dqf
        IPxZ1NbREKyaTJQ4K5TK/AN0wytLoRVuIUiKg+x/Kx+s8WxlDFoUWMvGuyVIZz72
        5wh9dvs6nAFwb0pLdLQHKQULZPRK2CZXR8g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nw9DysUj9Tud for <linux-fsdevel@vger.kernel.org>;
        Fri, 20 Jan 2023 02:49:55 -0800 (PST)
Received: from [10.225.163.44] (unknown [10.225.163.44])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nyx8d0FFgz1RvLy;
        Fri, 20 Jan 2023 02:49:52 -0800 (PST)
Message-ID: <a324b292-8e3f-686e-ee6f-846fd7678192@opensource.wdc.com>
Date:   Fri, 20 Jan 2023 19:49:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/3] ptrace,syscall_user_dispatch: Implement Syscall User
 Dispatch Suspension
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Gregory Price <gourry.memverge@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krisman@collabora.com, tglx@linutronix.de, luto@kernel.org,
        oleg@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org,
        adobriyan@gmail.com, corbet@lwn.net, shuah@kernel.org,
        Gregory Price <gregory.price@memverge.com>
References: <20230118201055.147228-1-gregory.price@memverge.com>
 <20230118201055.147228-2-gregory.price@memverge.com>
 <Y8prnDT0YUhEzI8+@hirez.programming.kicks-ass.net>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y8prnDT0YUhEzI8+@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/20/23 19:23, Peter Zijlstra wrote:
> On Wed, Jan 18, 2023 at 03:10:53PM -0500, Gregory Price wrote:
>> Adds PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH to ptrace options, and
>> modify Syscall User Dispatch to suspend interception when enabled.
>>
>> This is modeled after the SUSPEND_SECCOMP feature, which suspends
>> SECCOMP interposition.  Without doing this, software like CRIU will
>> inject system calls into a process and be intercepted by Syscall
>> User Dispatch, either causing a crash (due to blocked signals) or
>> the delivery of those signals to a ptracer (not the intended behavior).
>>
>> Since Syscall User Dispatch is not a privileged feature, a check
>> for permissions is not required, however attempting to set this
>> option when CONFIG_CHECKPOINT_RESTORE it not supported should be
>> disallowed, as its intended use is checkpoint/resume.
>>
>> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> 
> One small nit -- see below, otherwise:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
>> ---
>>  include/linux/ptrace.h               | 2 ++
>>  include/uapi/linux/ptrace.h          | 6 +++++-
>>  kernel/entry/syscall_user_dispatch.c | 5 +++++
>>  kernel/ptrace.c                      | 5 +++++
>>  4 files changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
>> index eaaef3ffec22..461ae5c99d57 100644
>> --- a/include/linux/ptrace.h
>> +++ b/include/linux/ptrace.h
>> @@ -45,6 +45,8 @@ extern int ptrace_access_vm(struct task_struct *tsk, unsigned long addr,
>>  
>>  #define PT_EXITKILL		(PTRACE_O_EXITKILL << PT_OPT_FLAG_SHIFT)
>>  #define PT_SUSPEND_SECCOMP	(PTRACE_O_SUSPEND_SECCOMP << PT_OPT_FLAG_SHIFT)
>> +#define PT_SUSPEND_SYSCALL_USER_DISPATCH \
>> +	(PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH << PT_OPT_FLAG_SHIFT)
>>  
>>  extern long arch_ptrace(struct task_struct *child, long request,
>>  			unsigned long addr, unsigned long data);
>> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
>> index 195ae64a8c87..ba9e3f19a22c 100644
>> --- a/include/uapi/linux/ptrace.h
>> +++ b/include/uapi/linux/ptrace.h
>> @@ -146,9 +146,13 @@ struct ptrace_rseq_configuration {
>>  /* eventless options */
>>  #define PTRACE_O_EXITKILL		(1 << 20)
>>  #define PTRACE_O_SUSPEND_SECCOMP	(1 << 21)
>> +#define PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH	(1 << 22)
>>  
>>  #define PTRACE_O_MASK		(\
>> -	0x000000ff | PTRACE_O_EXITKILL | PTRACE_O_SUSPEND_SECCOMP)
>> +	0x000000ff | \
>> +	PTRACE_O_EXITKILL | \
>> +	PTRACE_O_SUSPEND_SECCOMP | \
>> +	PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)
>>  
>>  #include <asm/ptrace.h>
>>  
>> diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
>> index 0b6379adff6b..7607f4598dd8 100644
>> --- a/kernel/entry/syscall_user_dispatch.c
>> +++ b/kernel/entry/syscall_user_dispatch.c
>> @@ -8,6 +8,7 @@
>>  #include <linux/uaccess.h>
>>  #include <linux/signal.h>
>>  #include <linux/elf.h>
>> +#include <linux/ptrace.h>
>>  
>>  #include <linux/sched/signal.h>
>>  #include <linux/sched/task_stack.h>
>> @@ -36,6 +37,10 @@ bool syscall_user_dispatch(struct pt_regs *regs)
>>  	struct syscall_user_dispatch *sd = &current->syscall_dispatch;
>>  	char state;
>>  
>> +	if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
>> +		unlikely(current->ptrace & PT_SUSPEND_SYSCALL_USER_DISPATCH))
> 
> Align with the '(' pleaase.
> 
>> +		return false;
>> +
>>  	if (likely(instruction_pointer(regs) - sd->offset < sd->len))
>>  		return false;
>>  
>> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
>> index 54482193e1ed..a6ad815bd4be 100644
>> --- a/kernel/ptrace.c
>> +++ b/kernel/ptrace.c
>> @@ -370,6 +370,11 @@ static int check_ptrace_options(unsigned long data)
>>  	if (data & ~(unsigned long)PTRACE_O_MASK)
>>  		return -EINVAL;
>>  
>> +	if (unlikely(data & PTRACE_O_SUSPEND_SYSCALL_USER_DISPATCH)) {
>> +		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTART))

Why not one if with a && ?

>> +			return -EINVAL;
>> +	}
>> +
>>  	if (unlikely(data & PTRACE_O_SUSPEND_SECCOMP)) {
>>  		if (!IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) ||
>>  		    !IS_ENABLED(CONFIG_SECCOMP))
>> -- 
>> 2.39.0
>>

-- 
Damien Le Moal
Western Digital Research


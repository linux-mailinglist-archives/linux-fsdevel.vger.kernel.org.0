Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC69D660883
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jan 2023 21:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235821AbjAFUyF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Jan 2023 15:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbjAFUyE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:54:04 -0500
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840636346;
        Fri,  6 Jan 2023 12:54:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 13A23604F1;
        Fri,  6 Jan 2023 21:54:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673038440; bh=4B7Dno8dzYVBkBqZi8r1yzPqvxe7Jybj/unBxoBDiak=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PIkDEiVcCZ0uawbe4Qw0/NStd7NsNXvxzSQHnuHpjJg0OP4U9hYETIbJ2lf5tdGt8
         ISZVUhZI9Dy/DE3TwAdjWwnVrmPCvifSkzhn9oENqlANKQHUkHy6Y9iWuIa9iWjHvT
         gonyuxuHW1FECBCJ5wp3tb4OZ9tQQqPjMrFiLATzy7ZZnCq/v/sefJ+jThUmKsdAIG
         Kh/l2ZPic7je4kX93QB04G6nY0nrkePRejFXL2kRb14xdeUUwXYv3qZBXlHABifZEP
         kz7sVYYH5ul7Cb9Dsz/LLpmA7DEEvwG0FMN6V+s1QYzRQr8yg+/7wHlxxg348tLW3U
         coJvHZxR3DR/g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2tpAY67k4C_j; Fri,  6 Jan 2023 21:53:57 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.196.35])
        by domac.alu.hr (Postfix) with ESMTPSA id D0E27604F0;
        Fri,  6 Jan 2023 21:53:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1673038437; bh=4B7Dno8dzYVBkBqZi8r1yzPqvxe7Jybj/unBxoBDiak=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JR6K7+GJ/FFQJaxz8NysLlEfYIZe+57kT/Zk2LpSJxbJxmATikFdFIAu3y+D2/qL2
         M4JIqn+SFahJ9xLH9JLUWTs74Yfzs1OtDlKVHRi1FNlAHnSaMAb9/q/qZxtNgiR55t
         4nO/qn4WFYV5lUIAF6X+icadopeoFH6YuWXS8Ir00foJTM+ClMRm1e9uiU0EpMbHrf
         DR2hf4srAJ7v3sCRtcpb1nG70T0iYA0qt2f/aDj5W8SW9aQEpcDNRtQO9/I7M0rG2T
         +iBGcV9R+Nj4sCnCMC/l/6ZgjnGAmDzTltd1K4i84LBTi7v1qwyCvsRlAJ5/53GC1D
         BX24LyPRVq8FQ==
Message-ID: <cd0cbfc0-cf8a-c97a-d03f-016c8f9b9fa3@alu.unizg.hr>
Date:   Fri, 6 Jan 2023 21:53:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] proc: fix PIE proc-empty-vm, proc-pid-vm tests
Content-Language: en-US, hr
To:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Brian Foster <bfoster@redhat.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
References: <fd9206f6-3ec4-cafc-e313-dfddf957bd5e@alu.unizg.hr>
 <Y7h2xvzKLg36DSq8@p183>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <Y7h2xvzKLg36DSq8@p183>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 06. 01. 2023. 20:30, Alexey Dobriyan wrote:
> vsyscall detection code uses direct call to the beginning of
> the vsyscall page:
> 
> 	asm ("call %P0" :: "i" (0xffffffffff600000))
> 
> It generates "call rel32" instruction but it is not relocated if binary
> is PIE, so binary segfaults into random userspace address and vsyscall
> page status is detected incorrectly.
> 
> Do more direct:
> 
> 	asm ("call *%rax")
> 
> which doesn't do need any relocaltions.
> 
> Mark g_vsyscall as volatile for a good measure, I didn't find instruction
> setting it to 0. Now the code is obviously correct:
> 
> 	xor	eax, eax
> 	mov	rdi, rbp
> 	mov	rsi, rbp
> 	mov	DWORD PTR [rip+0x2d15], eax      # g_vsyscall = 0
> 	mov	rax, 0xffffffffff600000
> 	call	rax
> 	mov	DWORD PTR [rip+0x2d02], 1        # g_vsyscall = 1
> 	mov	eax, DWORD PTR ds:0xffffffffff600000
> 	mov	DWORD PTR [rip+0x2cf1], 2        # g_vsyscall = 2
> 	mov	edi, [rip+0x2ceb]                # exit(g_vsyscall)
> 	call	exit
> 
> Note: fixed proc-empty-vm test oopses 5.19.0-28-generic kernel
> 	but this is separate story.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
> 
>   tools/testing/selftests/proc/proc-empty-vm.c |   12 +++++++-----
>   tools/testing/selftests/proc/proc-pid-vm.c   |    9 +++++----
>   2 files changed, 12 insertions(+), 9 deletions(-)
> 
> --- a/tools/testing/selftests/proc/proc-empty-vm.c
> +++ b/tools/testing/selftests/proc/proc-empty-vm.c
> @@ -25,6 +25,7 @@
>   #undef NDEBUG
>   #include <assert.h>
>   #include <errno.h>
> +#include <stdint.h>
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <string.h>
> @@ -41,7 +42,7 @@
>    * 1: vsyscall VMA is --xp		vsyscall=xonly
>    * 2: vsyscall VMA is r-xp		vsyscall=emulate
>    */
> -static int g_vsyscall;
> +static volatile int g_vsyscall;
>   static const char *g_proc_pid_maps_vsyscall;
>   static const char *g_proc_pid_smaps_vsyscall;
>   
> @@ -147,11 +148,12 @@ static void vsyscall(void)
>   
>   		g_vsyscall = 0;
>   		/* gettimeofday(NULL, NULL); */
> +		uint64_t rax = 0xffffffffff600000;
>   		asm volatile (
> -			"call %P0"
> -			:
> -			: "i" (0xffffffffff600000), "D" (NULL), "S" (NULL)
nt> -			: "rax", "rcx", "r11"
> +			"call *%[rax]"
> +			: [rax] "+a" (rax)
> +			: "D" (NULL), "S" (NULL)
> +			: "rcx", "r11"
>   		);
>   
>   		g_vsyscall = 1;
> --- a/tools/testing/selftests/proc/proc-pid-vm.c
> +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> @@ -257,11 +257,12 @@ static void vsyscall(void)
>   
>   		g_vsyscall = 0;
>   		/* gettimeofday(NULL, NULL); */
> +		uint64_t rax = 0xffffffffff600000;
>   		asm volatile (
> -			"call %P0"
> -			:
> -			: "i" (0xffffffffff600000), "D" (NULL), "S" (NULL)
> -			: "rax", "rcx", "r11"
> +			"call *%[rax]"
> +			: [rax] "+a" (rax)
> +			: "D" (NULL), "S" (NULL)
> +			: "rcx", "r11"
>   		);
>   
>   		g_vsyscall = 1;

I can confirm that the patch fixed the core dump in the exact environment that
used to reproduce the bug.

Apparently, it seems that gcc 12.2.0 -O2 optimiser on Ubuntu 22.10 kinetic kudu
did some new creative stuff to Alexey's code. For someone interested, I have saved the
assembly with and w/o -O2 ...

However, I have just found some spurious bug in proc-uptime-001.

But, this is another story ...

Thanks,
Mirsad

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union


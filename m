Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913E35F9832
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Oct 2022 08:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiJJGQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Oct 2022 02:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiJJGQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:16:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0127F54CA2;
        Sun,  9 Oct 2022 23:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665382584;
        bh=t5oCng6qrXN7iFHvVA23nQRcP3eRpq4/4Y+SJ+WKMQI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BxebPkM/d0tk1ML8vaIZiVAFv3HZhfphqPc0aJKN5r9MPhyBDw+u91Ym49xEhwnf7
         C+BnpJ/tgtQMifG0g2r4qbxOdb7F5JUzp+vi+CPx9gUHlsQ4bogs61H0yhjMpt9tZI
         yZgWB2aD/tImchBr6Riipr1B5i3rdRGmgN3jZmgI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.160.63]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPokN-1oTo0B20UV-00Mvbw; Mon, 10
 Oct 2022 08:16:24 +0200
Message-ID: <9f0b3333-bb28-c739-9bff-6fc50343b4f9@gmx.de>
Date:   Mon, 10 Oct 2022 08:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 4/4] arc: Use generic dump_stack_print_cmdline()
 implementation
Content-Language: en-US
To:     Vineet Gupta <vineet.gupta@linux.dev>, linux-s390@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>, x86@kernel.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Cc:     Alexey Brodkin <abrodkin@synopsys.com>,
        Shahab Vahedi <Shahab.Vahedi@synopsys.com>
References: <20220808130917.30760-1-deller@gmx.de>
 <20220808130917.30760-5-deller@gmx.de>
 <8da9812d-eb84-2a84-321e-ea2826ef8981@linux.dev>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <8da9812d-eb84-2a84-321e-ea2826ef8981@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NudOz7Pq8zqMzpDkWxd+lvw7MQLHFVHX4y2D3B0lFEDuIKKr66h
 qegUDgOH06dY83pJcJsE8la8/wqBLjQilAdyHfNW5OH54FBiT1VLNreHyu0NRHrlEcsSOLy
 +yFRkaihB4vP1N2x0uNckW/llOKv6XGjxN+5YnddWyS642ImXCjF9f8FJuuWfjgGBQEmN9e
 +sLRo1pOuHdypN3cwk4wQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OCcy9hBZBVE=:fJJDrowGKWaX2xVI3tu20J
 hS+T2B7yjXar8ybNkNOfrm650gvN6sWFh1Diw3RxZ2e4fMd7Tb0al7oqcHxC22HAn60Cn0kOp
 Cmezn+WVPZ0+bm5xCV2SRV5SHKwctYtlvjYKCG8x0GuolXpdU9COln/arXMau6HyZfdpIbKkK
 oFRYln23V8eOAQDTICFAm7pxr6dYOpcl/fnZNQQWWShthwVKX/LpwLOxpyXmHNtsyG+Kr1A5M
 jk+VVjI6Spzk03if5HW5mA4p5S7QU4NSCNyyqR81STu6qQ3SCuvQeZDnREWmGgwgcXOLmp6V1
 t/qrrYNuQKWed1qEUyPX01K0J7Pssk+Y103CaSiiEza0gKI0DCT9HhaNIlvnqKBW0BTQwL4sI
 Qys3/UKX4zrjBs/vl8iwWfyPuAScmqnzvmtJR6WDcq5fSnO6Cdh9vqPvM0cjpv+WXV/fuWqOh
 QB6ksyFUi7NUGy1SCvYHh1y3MjgBqp+rkMpGaJmPor6lJ39P4Ou0EmxFMClcMXWreHo4KDvLC
 htq2K726CjBMI7a8aPyn+M4rooQC4V/379XOWMFUL9crKufBL61UQ0M8OwgQhzp2iRy9bkAFn
 8cHdmQqEaYbIVZGD3eXybfdZR0DvWYcp6G/7TGvdIXe6a7NkCKYgq2/02rA12shd63TMkRWtv
 PauahAOqu/0XMC/Gko3pcuhbECP2Wy5vM5UPokbmRNrP+XBmiDBCLQP4uo+nKm+o2jufLTzTV
 lRn0x6LuzuywMXZ60mV9inyOcskjnc2d6zGr2J7ZST0+uINAkN/89mhlqcrh7WdY3ZialzXdK
 WSCwYEa3zeTiezGmKGb0dPMa+Y+ZZOhvVmtjjvVRsCuPiwKW3jWEXB2yiSYytRlaYa+UYczvl
 RXMp8YWHth6+Te13FpZaeNaLKYZim2CocI/gfiFuCgNhvG14t5IsATN50cJwbLerOhzGdcJCb
 8TkMOsaerDDqEXrpEZqWYp+1+P1jdhvFN6EdNoGjCdi51XUzoJg9b93/rW4kV1GUcb6BgC/8B
 o0dIi7l+vV2Eif81NtZiAaHJw9oNDIjhxnbvGvxuaRV9Qh2clQFCRc1NnzJTkDXs43SHUld9y
 HoWkZX4SBuAPoluTb9fw3sk7LAYhbdD9uJN+Xf6trl+6Cog9YgtpuEncwR6oahQ1xUHwYQylO
 bVnewqqTL1sJF8kDTjRrITx0zZUgHndHAMom8BjHN/7h7nKaaXmrOVRGwwl/iylJqlMkVP1NW
 DDwK9rOAY659rRm1hbcdr6X2zCQ3NPnZSKorkuEn4pJE1SV6J2DyGXNr/BCLIJ5wlCWHeh45p
 z4OlI8yl0/DsqsFnZQcw00Bi69s4tKfzwcpUqxNnaeoE+7mHJQPrmyUOu4CTwXpPpL/2yB3nK
 3ZSgwaO7wNZoUl0AEv+HB7L1O5pNH5NYBlpWlqCU/MX+qBMhew07dijVHW9Lf+9gnnNx7FzY5
 VgHl56FMusEvqFtCrxNeDWIXEmsyJ2HPJyixuKxn3c/U+A7myFi+AHjm7R2+9zd/tgAnDdsAe
 2Yde0koapcghlSai9bOgidFxV+3HFIrMJPFdbaVWj8Vyb
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/10/22 07:18, Vineet Gupta wrote:
> On 8/8/22 06:09, Helge Deller wrote:
>> The process program name and command line is now shown in generic code
>> in dump_stack_print_info(), so drop the arc-specific implementation.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>
> But that info printing was added back in 2018 by e36df28f532f882.
> I don't think arc is using show_regs_print_info -> dump_stack_print_info=
 yet.
> Or is there a different code path now which calls here ?

Right.
See patches #1 and #2 of this series which added this
info to dump_stack_print_info().


>> ---
>> =C2=A0 arch/arc/kernel/troubleshoot.c | 24 ------------------------
>> =C2=A0 1 file changed, 24 deletions(-)
>>
>> diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troublesh=
oot.c
>> index 7654c2e42dc0..9807e590ee55 100644
>> --- a/arch/arc/kernel/troubleshoot.c
>> +++ b/arch/arc/kernel/troubleshoot.c
>> @@ -51,29 +51,6 @@ static void print_regs_callee(struct callee_regs *re=
gs)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regs->r24, regs-=
>r25);
>> =C2=A0 }
>>
>> -static void print_task_path_n_nm(struct task_struct *tsk)
>> -{
>> -=C2=A0=C2=A0=C2=A0 char *path_nm =3D NULL;
>> -=C2=A0=C2=A0=C2=A0 struct mm_struct *mm;
>> -=C2=A0=C2=A0=C2=A0 struct file *exe_file;
>> -=C2=A0=C2=A0=C2=A0 char buf[ARC_PATH_MAX];
>> -
>> -=C2=A0=C2=A0=C2=A0 mm =3D get_task_mm(tsk);
>> -=C2=A0=C2=A0=C2=A0 if (!mm)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto done;
>> -
>> -=C2=A0=C2=A0=C2=A0 exe_file =3D get_mm_exe_file(mm);
>> -=C2=A0=C2=A0=C2=A0 mmput(mm);
>> -
>> -=C2=A0=C2=A0=C2=A0 if (exe_file) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 path_nm =3D file_path(exe_f=
ile, buf, ARC_PATH_MAX-1);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fput(exe_file);
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> -done:
>> -=C2=A0=C2=A0=C2=A0 pr_info("Path: %s\n", !IS_ERR(path_nm) ? path_nm : =
"?");
>> -}
>> -
>> =C2=A0 static void show_faulting_vma(unsigned long address)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct vm_area_struct *vma;
>> @@ -176,7 +153,6 @@ void show_regs(struct pt_regs *regs)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 preempt_enable();
>
> Maybe we remove preempt* as well now (perhaps as a follow up patch)
> since that was added by f731a8e89f8c78 "ARC: show_regs: lockdep:
> re-enable preemption" where show_regs -> print_task_path_n_nm ->
> mmput was triggering lockdep splat which is supposedly removed.

The patch series was dropped from Andrew's queue, because the kernel
test robot showed some issues:
https://lore.kernel.org/lkml/Yu59QdVpPgnXUnQC@xsang-OptiPlex-9020/
Maybe adding preempt_enable() in my patches would fix that -
sadly I haven't had time to follow up on this yet ...

Helge

>
>>
>> -=C2=A0=C2=A0=C2=A0 print_task_path_n_nm(tsk);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 show_regs_print_info(KERN_INFO);
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 show_ecr_verbose(regs);


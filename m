Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95772E8DC2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jan 2021 19:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbhACS1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 13:27:20 -0500
Received: from mout.gmx.net ([212.227.17.20]:33295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbhACS1T (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 13:27:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609698337;
        bh=30c8Nz2pdY061qBdlzGzHHvV6i0JHqIlEL+CUOePJsU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=buP6Q4kq4hsY6iRAboVYzG0632MZeAE02qvWKRrB0Z8xwGBAsb/Z0CY3ndcSBqPOV
         tTMiDN6lJ8js5QkmAakXmcgYCWK9EIlUJqfJ9PYFlTmHHD9KtEsw5tmes/ZywZc/f1
         6ZHVOzoLBzxdidZgcQmRoMtl2Tewm8NMbJf/tx/A=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.138.209]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26vB-1kyb2u2D3h-002UIG; Sun, 03
 Jan 2021 19:25:37 +0100
Subject: Re: [proc/wchan] 30a3a19273:
 leaking-addresses.proc.wchan./proc/bus/input/devices:B:KEY=1000000000007ff980000000007fffebeffdfffeffffffffffffffffffffe
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
References: <20210103142726.GC30643@xsang-OptiPlex-9020>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <d15378c8-8702-47ba-65b7-450f728793ed@gmx.de>
Date:   Sun, 3 Jan 2021 19:25:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210103142726.GC30643@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yUobJTBbhGcL6eC6tBdU6z/6yVb4cF4cE9WOS+Hf4W2X8AYhcp3
 aUDuZMU3T+CHXPM6PwfKqcuFiPgpdw1emj11rpbZDSqHXfBu+cI2K8P68ap+symzTkKghUB
 fgiuiYO5LzopZA/Pfkc3B0Shf8Mq8rfsKhKMNKdPykeb2Di78mkI33X/lZwOSU74QfQV6yJ
 7rmMY51lLBGLCF0E+rCaw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/P6+xLUH+d4=:IWXh2VZH37C91x1KugjscD
 7WyrHKvPayzrtQRdAR8IkBtZenvYsH5hVUB/yW8Y9m/ZkDADLDeWwfz6QbOQUvi+svKIr531k
 cD/lJ2F2BBC4OYbA6Ux7/Z+sZdAxgpTySxMXQ+Wm/ugkLXpeGNkQy5MOC/TMNGpy8VwJ5VIeH
 ey8s7Kt7cCX+CG5/7Qqv0tQCQpMAwBSysCgp8F50myU52dkRHWF3voIZ1P2BugnFtstdLk7FW
 qjhuENcl3Crr6kzXqkiiduo/RbzLSwzejFi6VolkjsBh3q7JKdWnH6g4zE+O+caGnRssSKjd5
 SEYaJTUnZ8QgzT+TlLaoteWlbO7lt5/QeZVG7pQ/FEp0oGPZYqXI/885t39GjAYOR9R3SV4dH
 ZReWq6nY/ZzAu6htioyPcKmvEXyGxOV3yzDBVF3yz9GLBHhz7z151HdcaCH78SKS7EV3TWUoc
 DbcePAZrPgzY8qz3E22QJtdDGlSiTjwg/jx/OlHGKUCj3EKYOD0Vi5RcxHDK8wrGODYpM9c5X
 GXIz3N+dfca7GGzQnARwyGhHtF12pKjy5Z4IShLWkCbSH2kG9nisNPoqawjPh45Nq2hUGY9Kz
 g9GHZUAdDCsQvAMjY5jH4m0jdP6vittQj1Iw1bc+THk6cWgsf9bbSGdVi0mi4sALDEpBwChU3
 9VQ2IfSt3KShgn0sXcMP4Qp37ZBz7DN2oBV2WqaXcIgSblELiq52rffx2lrB13HFGxXxlKaEx
 naLVmZCWswAx8fL3cMa06QLdBkoFypDvB+vl7yv3VW7GSVyXL1/VqYIYcGKaKd+zoKPwwcN9f
 oupRpXibCIBAeWl1C9CXQbMfhRMJpqPIvcVT2yUbQeEhcR4vQv3kVxSg8fc27TZCRiGBojDeG
 fAsgAq80Zc48ciUmK0Kw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/3/21 3:27 PM, kernel test robot wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 30a3a192730a997bc4afff5765254175b6fb64f3 ("[PATCH] proc/wchan: U=
se printk format instead of lookup_symbol_name()")
> url: https://github.com/0day-ci/linux/commits/Helge-Deller/proc-wchan-Us=
e-printk-format-instead-of-lookup_symbol_name/20201218-010048
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 09=
162bc32c880a791c6c0668ce0745cf7958f576
>
> in testcase: leaking-addresses
> version: leaking-addresses-x86_64-4f19048-1_20201111
> with following parameters:
>
> 	ucode: 0xde
>
>
>
> on test machine: 4 threads Intel(R) Core(TM) i7-7567U CPU @ 3.50GHz with=
 32G memory
>
> caused below changes (please refer to attached dmesg/kmsg for entire log=
/backtrace):

I don't see anything wrong with the wchan patch (30a3a192730a997bc4afff576=
5254175b6fb64f3),
or that it could have leaked anything.

Maybe the kernel test robot picked up the wchan patch by mistake ?

Helge


>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>
> 2021-01-01 01:52:25 ./leaking_addresses.pl --output-raw result/scan.out
> 2021-01-01 01:52:49 ./leaking_addresses.pl --input-raw result/scan.out -=
-squash-by-filename
>
> Total number of results from scan (incl dmesg): 156538
>
> dmesg output:
> [    0.058490] mapped IOAPIC to ffffffffff5fb000 (fec00000)
>
> Results squashed by filename (excl dmesg). Displaying [<number of result=
s> <filename>], <example result>
> [1 _error_injection_whitelist] 0xffffffffc0a254b0
> [25 __bug_table] 0xffffffffc01e0070
> [46 .orc_unwind_ip] 0xffffffffc009f3a0
> [6 __tracepoints_strings] 0xffffffffc027d7d0
> [50 .strtab] 0xffffffffc00b9b88
> [1 .rodata.cst16.mask2] 0xffffffffc00a70e0
> [1 key] 1000000000007 ff980000000007ff febeffdfffefffff fffffffffffffffe
> [50 .note.Linux] 0xffffffffc009f024
> [41 .data] 0xffffffffc00a1000
> [6 .static_call.text] 0xffffffffc0274b44
> [1 _ftrace_eval_map] 0xffffffffc0a20148
> [10 .data.once] 0xffffffffc04475b4
> [7 .static_call_sites] 0xffffffffc0a22088
> [6 __tracepoints_ptrs] 0xffffffffc027d7bc
> [7 .fixup] 0xffffffffc00852ea
> [49 __mcount_loc] 0xffffffffc009f03c
> [19 __param] 0xffffffffc009f378
> [38 .rodata.str1.8] 0xffffffffc009f170
> [1 ___srcu_struct_ptrs] 0xffffffffc0355000
> [14 .altinstr_replacement] 0xffffffffc04349ca
> [154936 kallsyms] ffffffff81000000 T startup_64
> [50 .gnu.linkonce.this_module] 0xffffffffc00a1140
> [24 __ksymtab_strings] 0xffffffffc00e2048
> [31 .bss] 0xffffffffc00a1500
> [42 .rodata.str1.1] 0xffffffffc009f09c
> [9 .init.rodata] 0xffffffffc00b8000
> [11 __ex_table] 0xffffffffc00bd128
> [14 .parainstructions] 0xffffffffc03b5d88
> [6 __tracepoints] 0xffffffffc02818c0
> [1 .rodata.cst16.mask1] 0xffffffffc00a70d0
> [18 __dyndbg] 0xffffffffc00a10c8
> [5 .altinstr_aux] 0xffffffffc0143a49
> [22 .smp_locks] 0xffffffffc009f094
> [2 .rodata.cst16.bswap_mask] 0xffffffffc005e070
> [40 .init.text] 0xffffffffc00b7000
> [4 .init.data] 0xffffffffc00e7000
> [10 .data..read_mostly] 0xffffffffc00a1100
> [14 .altinstructions] 0xffffffffc0446846
> [6 __bpf_raw_tp_map] 0xffffffffc0281720
> [50 .note.gnu.build-id] 0xffffffffc009f000
> [6 _ftrace_events] 0xffffffffc0281780
> [140 printk_formats] 0xffffffff82341767 : "CPU_ON"
> [25 __jump_table] 0xffffffffc00a0000
> [37 .exit.text] 0xffffffffc009ec70
> [50 .text] 0xffffffffc009e000
> [35 .text.unlikely] 0xffffffffc009ebaf
> [18 __ksymtab] 0xffffffffc00e203c
> [46 .orc_unwind] 0xffffffffc009f544
> [1 .data..cacheline_aligned] 0xffffffffc081d8c0
> [2 .noinstr.text] 0xffffffffc04b8d00
> [1 uevent] KEY=3D1000000000007 ff980000000007ff febeffdfffefffff fffffff=
ffffffffe
> [50 modules] netconsole 20480 0 - Live 0xffffffffc00cb000
> [337 blacklist] 0xffffffff81c00880-0xffffffff81c008a0	asm_exc_overflow
> [1 .rodata.cst32.byteshift_table] 0xffffffffc00a7100
> [2 wchan] 0xffffc9000000003c/proc/bus/input/devices: B: KEY=3D1000000000=
007 ff980000000007ff febeffdfffefffff fffffffffffffffe
> [6 .ref.data] 0xffffffffc02817a0
> [14 __ksymtab_gpl] 0xffffffffc03b503c
> [42 .rodata] 0xffffffffc009f2c0
> [50 .symtab] 0xffffffffc00b9000
>
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>
>
>
> Thanks,
> Oliver Sang
>


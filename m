Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D885F7195
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 01:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiJFXQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 19:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiJFXQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:16:18 -0400
X-Greylist: delayed 3595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Oct 2022 16:16:15 PDT
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05AA94120;
        Thu,  6 Oct 2022 16:16:14 -0700 (PDT)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 296LRJ1M3706824
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 6 Oct 2022 14:27:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 296LRJ1M3706824
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022090501; t=1665091641;
        bh=83oafeKZfAlix6QiAi5tyBeuvZ5eUW0hhmVMZremg+o=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=he58tKmvIQguFWQuXk4StAkobvC4MMRcgWm5oocTjATGRjxGaMUIwUgQuvmY5viZp
         OdiI5JtB78Nl6Q1Or4ZYxFqSiYbDj5OE1/uFwvcSGRkGH9dGkt9d879hBtR0vH2bGc
         7aH12+QOMsIw09wrwwGzj2TSdqLbgGqiZuNdlE8L9+qEaqPDRyBgWXppvye9w/e69Z
         IOaxQKuLoOW8QXyzS/uMpO/UHI9HiQCdbc5SdJmT/mKBZrAn0s6hAWyQl9aY9IVHYZ
         DtSBH3xBedi5AtXWjOr9sBXBoZLsUc4D7Mvh3VswLI+oqxa63rPjDEAwHeVQp+3PDI
         GTqTedLcwbnfQ==
Date:   Thu, 06 Oct 2022 14:27:18 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ali Raza <aliraza@bu.edu>, linux-kernel@vger.kernel.org
CC:     corbet@lwn.net, masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, luto@kernel.org,
        ebiederm@xmission.com, keescook@chromium.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, arnd@arndb.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, pbonzini@redhat.com,
        jpoimboe@kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, rjones@redhat.com, munsoner@bu.edu, tommyu@bu.edu,
        drepper@redhat.com, lwoodman@redhat.com, mboydmcse@gmail.com,
        okrieg@bu.edu, rmancuso@bu.edu
Subject: Re: [RFC UKL 00/10] Unikernel Linux (UKL)
User-Agent: K-9 Mail for Android
In-Reply-To: <20221003222133.20948-1-aliraza@bu.edu>
References: <20221003222133.20948-1-aliraza@bu.edu>
Message-ID: <85EF9D5D-6DCC-410C-96F5-C16F0E62BF22@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On October 3, 2022 3:21:23 PM PDT, Ali Raza <aliraza@bu=2Eedu> wrote:
>Unikernel Linux (UKL) is a research project aimed at integrating
>application specific optimizations to the Linux kernel=2E This RFC aims t=
o
>introduce this research to the community=2E Any feedback regarding the id=
ea,
>goals, implementation and research is highly appreciated=2E
>
>Unikernels are specialized operating systems where an application is link=
ed
>directly with the kernel and runs in supervisor mode=2E This allows the
>developers to implement application specific optimizations to the kernel,
>which can be directly invoked by the application (without going through t=
he
>syscall path)=2E An application can control scheduling and resource
>management and directly access the hardware=2E Application and the kernel=
 can
>be co-optimized, e=2Eg=2E, through LTO, PGO, etc=2E All of these optimiza=
tions,
>and others, provide applications with huge performance benefits over
>general purpose operating systems=2E
>
>Linux is the de-facto operating system of today=2E Applications depend on=
 its
>battle tested code base, large developer community, support for legacy
>code, a huge ecosystem of tools and utilities, and a wide range of
>compatible hardware and device drivers=2E Linux also allows some degree o=
f
>application specific optimizations through build time config options,
>runtime configuration, and recently through eBPF=2E But still, there is a
>need for even more fine-grained application specific optimizations, and
>some developers resort to kernel bypass techniques=2E
>
>Unikernel Linux (UKL) aims to get the best of both worlds by bringing
>application specific optimizations to the Linux ecosystem=2E This way,
>unmodified applications can keep getting the benefits of Linux while taki=
ng
>advantage of the unikernel-style optimizations=2E Optionally, application=
s
>can be modified to invoke deeper optimizations=2E
>
>There are two steps to unikernel-izing Linux, i=2Ee=2E, first, equip Linu=
x with
>a unikernel model, and second, actually use that model to implement
>application specific optimizations=2E This patch focuses on the first par=
t=2E
>Through this patch, unmodified applications can be built as Linux
>unikernels, albeit with only modest performance advantages=2E Like
>unikernels, UKL would allow an application to be statically linked into t=
he
>kernel and executed in supervisor mode=2E However, UKL preserves most of =
the
>invariants and design of Linux, including a separate page-able applicatio=
n
>portion of the address space and a pinned kernel portion, the ability to
>run multiple processes, and distinct execution modes for application and
>kernel code=2E Kernel execution mode and application execution mode are
>different, e=2Eg=2E, the application execution mode allows application th=
reads
>to be scheduled, handle signals, etc=2E, which do not apply to kernel
>threads=2E Application built as a Linux unikernel will have its text and =
data
>loaded with the kernel at boot time, while the rest of the address space
>would remain unchanged=2E These applications invoke the system call
>functionality through a function call into the kernel system call entry
>point instead of through the syscall assembly instruction=2E UKL would
>support a normal userspace so the UKL application can be started, managed=
,
>profiled, etc=2E, using normal command line utilities=2E
>
>Once Linux has a unikernel model, different application specific
>optimizations are possible=2E We have tried a few, e=2Eg=2E, fast system =
call
>transitions, shared stacks to allow LTO, invoking kernel functions
>directly, etc=2E We have seen huge performance benefits, details of which=
 are
>not relevant to this patch and can be found in our paper=2E
>(https://arxiv=2Eorg/pdf/2206=2E00789=2Epdf)
>
>UKL differs significantly from previous projects, e=2Eg=2E, UML, KML and =
LKL=2E
>User Mode Linux (UML) is a virtual machine monitor implemented on syscall
>interface, a very different goal from UKL=2E Kernel Mode Linux (KML) allo=
ws
>applications to run in kernel mode and replaces syscalls with function
>calls=2E While KML stops there, UKL goes further=2E UKL links application=
s and
>kernel together which allows further optimizations e=2Eg=2E, fast system =
call
>transitions, shared stacks to allow LTO, invoking kernel functions direct=
ly
>etc=2E Details can be found in the paper linked above=2E Linux Kernel Lib=
rary
>(LKL) harvests arch independent code from Linux, takes it to userspace as=
 a
>library to be linked with applications=2E A host needs to provide arch
>dependent functionality=2E This model is very different from UKL=2E A det=
ailed
>discussion of related work is present in the paper linked above=2E
>
>See samples/ukl for a simple TCP echo server example which can be built a=
s
>a normal user space application and also as a UKL application=2E In the L=
inux
>config options, a path to the compiled and partially linked application
>binary can be specified=2E Kernel built with UKL enabled will search this
>location for the binary and link with the kernel=2E Applications and requ=
ired
>libraries need to be compiled with -mno-red-zone -mcmodel=3Dkernel flags
>because kernel mode execution can trample on application red zones and in
>order to link with the kernel and be loaded in the high end of the addres=
s
>space, application should have the correct memory model=2E Examples of ot=
her
>applications like Redis, Memcached etc along with glibc and libgcc etc=2E=
,
>can be found at https://github=2Ecom/unikernelLinux/ukl
>
>List of authors and contributors:
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>Ali Raza - aliraza@bu=2Eedu
>Thomas Unger - tommyu@bu=2Eedu
>Matthew Boyd - mboydmcse@gmail=2Ecom
>Eric Munson - munsoner@bu=2Eedu
>Parul Sohal - psohal@bu=2Eedu
>Ulrich Drepper - drepper@redhat=2Ecom
>Richard W=2EM=2E Jones - rjones@redhat=2Ecom
>Daniel Bristot de Oliveira - bristot@kernel=2Eorg
>Larry Woodman - lwoodman@redhat=2Ecom
>Renato Mancuso - rmancuso@bu=2Eedu
>Jonathan Appavoo - jappavoo@bu=2Eedu
>Orran Krieger - okrieg@bu=2Eedu
>
>Ali Raza (9):
>  kbuild: Add sections and symbols to linker script for UKL support
>  x86/boot: Load the PT_TLS segment for Unikernel configs
>  sched: Add task_struct tracking of kernel or application execution
>  x86/entry: Create alternate entry path for system calls
>  x86/uaccess: Make access_ok UKL aware
>  x86/fault: Skip checking kernel mode access to user address space for
>    UKL
>  x86/signal: Adjust signal handler register values and return frame
>  exec: Make exec path for starting UKL application
>  Kconfig: Add config option for enabling and sample for testing UKL
>
>Eric B Munson (1):
>  exec: Give userspace a method for starting UKL process
>
> Documentation/index=2Erst           |   1 +
> Documentation/ukl/ukl=2Erst         | 104 +++++++++++++++++++++++
> Kconfig                           |   2 +
> Makefile                          |   4 +
> arch/x86/boot/compressed/misc=2Ec   |   3 +
> arch/x86/entry/entry_64=2ES         | 133 ++++++++++++++++++++++++++++++
> arch/x86/include/asm/elf=2Eh        |   9 +-
> arch/x86/include/asm/uaccess=2Eh    |   8 ++
> arch/x86/kernel/process=2Ec         |  13 +++
> arch/x86/kernel/process_64=2Ec      |  49 ++++++++---
> arch/x86/kernel/signal=2Ec          |  22 +++--
> arch/x86/kernel/vmlinux=2Elds=2ES     |  98 ++++++++++++++++++++++
> arch/x86/mm/fault=2Ec               |   7 +-
> fs/binfmt_elf=2Ec                   |  28 +++++++
> fs/exec=2Ec                         |  75 +++++++++++++----
> include/asm-generic/sections=2Eh    |   4 +
> include/asm-generic/vmlinux=2Elds=2Eh |  32 ++++++-
> include/linux/sched=2Eh             |  26 ++++++
> kernel/Kconfig=2Eukl                |  41 +++++++++
> samples/ukl/Makefile              |  16 ++++
> samples/ukl/README                |  17 ++++
> samples/ukl/syscall=2ES             |  28 +++++++
> samples/ukl/tcp_server=2Ec          |  99 ++++++++++++++++++++++
> scripts/mod/modpost=2Ec             |   4 +
> 24 files changed, 785 insertions(+), 38 deletions(-)
> create mode 100644 Documentation/ukl/ukl=2Erst
> create mode 100644 kernel/Kconfig=2Eukl
> create mode 100644 samples/ukl/Makefile
> create mode 100644 samples/ukl/README
> create mode 100644 samples/ukl/syscall=2ES
> create mode 100644 samples/ukl/tcp_server=2Ec
>
>
>base-commit: 4fe89d07dcc2804c8b562f6c7896a45643d34b2f

This is basically taking Linux and turning it into a whole new operating s=
ystem, while expecting the Linux kernel community to carry the support burd=
en thereof=2E

We have seen this before, notably with Xen=2E It is *expensive* and *painf=
ul* for the maintenance of the mainstream kernel=2E

Linux already has a notion of "kernel mode applications", they are called =
kernel modules and kernel threads=2E It seems to me that you are trying to =
introduce a user space compatibility layer into the kernel, with the only b=
enefit being avoiding the syscall overhead=2E The latter is bigger than we =
would like, which is why we are changing the x86 hardware architecture to i=
mprove it=2E

In my opinion, this would require *enormous* justification to put it into =
mainline=2E




Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE456230EC2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbgG1QFG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:05:06 -0400
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:38883
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731044AbgG1QFG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595952304; bh=G6IDCjjXe30xyWW7cVoInzXvrb0OXxUXXz0sBs69kmQ=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=o29lfJ3ZpYpIk1F2Lkoh/QVCsdJIThOVHQV8xWfe7ctC4UK0D0SPZTXjoG5eSxp9uJdYAHg5eNDfjUuXYhVBuIFUI3gsm5Wzv/oMubXjcY46f+0pY65jibz+jitOBZmwtZxXdDsgXkXgu1anSW7GMRzBET4B+A8W0VeUavhlm/QEA/SNIkpMUJXq7oL5P7QP7tZqGYF1a/1f2+byejd/C4ETDwSeXvTQ7QUJLiZvdQOkiUC4gfw5ZdrYXyYrXxg7Zj92VsdSoP8BZng7YbeGQQgAJddOTv8McIDIJ5meC8mhOROV3YqU28AnB22seoO9oHv6BFzNkmOOfArvI3h/AQ==
X-YMail-OSG: tw.tTdsVM1n8VUGww4s7lARtTQJLahLg5yN3olWBUx2U.x3d56DKeae2UL6KYcG
 OqmfQTtC..rDEffJ8JC8Ar4KVG0odCq3RPw7PGLxWCKoVcuEkcjSVrBkUTHaNY7zVa1NUoxGsG.R
 NBtUxi2WG4572ajkJG_gi2.aO82cqozMris8P1E983gezX.XIIIX2H7_J4xXn1TfYUFGFMLvEufm
 _H_Ey0i9hMS6HtwbjQo15LIv68OAqw1RYy58kE5zS1BOTzCU.hktBYzrlDuS2W_sdiVnVMh5G0if
 ZhSctivFFIsTr6vBPdkOgDJ6naOPLHDKgIu_lmkbrePkb7.FeuMZJ7Juo4sUZdgoBMol5x40Z7Fe
 ZcIoXzp2Wa4EWxPM6crH_E0Sg3jXwZT8hdiWOumuIR_GrLG88lZQd8dyvnDe0iIQJ8eXrSl6vhKw
 SAprDMhRVgyI7gf03SFaaHf7AUdDNci3BgSpYAobzpHpsu_aHxkMlmAszcLyFoI4JuGlh21r6pcv
 OrZV11OeEVNFeLArOXlp0md_9ZlRf91Ro6Myzl33MAI.IWJwzmxJkOX9ad5g0YaXbAnD5JZp7M3J
 0dmLiN4SsYMMBY0HZG685JXF_dSXjEyVj1s2u4YQn8DAT9nvWKmgclbHY5JZws0p8GYqd2WRSGiI
 y9lCvVRVVJVRkdqJxNIkMudIVPLINjPia5u2gmoMy_Dwh3uW5_puddcSkz5Lh37tUiLp5IYqNm9g
 FNFUgdH0Ejj1ImxXRNqBK4uLJeid9H7cJZ_8yJBs_6hPiAwJtZqaLsR7P3mzIH7RkLUWjmoNZJ4r
 aWyAPbKT0rKkbeXMxn1GSIGErF411cdLbJAVtdNifxif6dmIRuj_W56oIZ4PnNyc7QWP0jnvZdic
 EdM6Bsp01Ft8dzoXmC9RYOBRa95GMDOR0TCD7CsT3f4bOjj6670aFCwJy_gZdC6v9uztxULKXJ54
 TnLGSsoBILNCQNFXtA1nTcns2vvpnvFaDwzeZgyG39rjcnWP7MbwrY1Xk5b6y10TGMEPvZ7hNMrp
 HkshKv69t0QqGDRIw.1eN_A3Wf24Fcxy5_qkDhPMtJpHF7J3DaBlaqQ9aaKaaZk2g2wMltzofKNX
 zvDjLdt8f31uqva_Km_KOcqjAaJnFaOWcffjQHH9jxhBC0DLIC0SfOCUrYUvfQNkeRbwjzU6Zr9e
 _3opruC1T_6KFAXyAEDhjHyWrO7i1yXNY7DmQZphPLzg00mQfIoe5o7x6FKXQFI7uc_QqYcEBECe
 E_K8ffo0NT.Hzw5xmPOyJOL.zyn3T_i2HHwcCSvMUDuQ0uNFExknXAFJq5v_AtjWYM1JHBFQIyQ5
 _U4aissfwPDKui4tfwk.O1y7lAM8J2pwSPJ4XlSursVIaXHgJfRYs5zzKC_SnCP0sExBf0I8dlB2
 gshLPiVzAC8ZGY9_GyEj5gCGZdoyag98_5wCUWVJrdPbqU2N.4oBcPw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jul 2020 16:05:04 +0000
Received: by smtp425.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 497bafd7cf473c818672b7aecb5b7f67;
          Tue, 28 Jul 2020 16:05:03 +0000 (UTC)
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     madvenka@linux.microsoft.com, kernel-hardening@lists.openwall.com,
        linux-api@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, oleg@redhat.com,
        x86@kernel.org
References: <aefc85852ea518982e74b233e11e16d2e707bc32>
 <20200728131050.24443-1-madvenka@linux.microsoft.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <3fd22f92-7f45-1b0f-e4fe-857f3bceedd0@schaufler-ca.com>
Date:   Tue, 28 Jul 2020 09:05:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728131050.24443-1-madvenka@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.16271 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/28/2020 6:10 AM, madvenka@linux.microsoft.com wrote:
> From: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
>
> Introduction
> ------------
>
> Trampolines are used in many different user applications. Trampoline
> code is often generated at runtime. Trampoline code can also just be a
> pre-defined sequence of machine instructions in a data buffer.
>
> Trampoline code is placed either in a data page or in a stack page. In
> order to execute a trampoline, the page it resides in needs to be mapped
> with execute permissions. Writable pages with execute permissions provide
> an attack surface for hackers. Attackers can use this to inject malicious
> code, modify existing code or do other harm.
>
> To mitigate this, LSMs such as SELinux may not allow pages to have both
> write and execute permissions. This prevents trampolines from executing
> and blocks applications that use trampolines. To allow genuine applications
> to run, exceptions have to be made for them (by setting execmem, etc).
> In this case, the attack surface is just the pages of such applications.
>
> An application that is not allowed to have writable executable pages
> may try to load trampoline code into a file and map the file with execute
> permissions. In this case, the attack surface is just the buffer that
> contains trampoline code. However, a successful exploit may provide the
> hacker with means to load his own code in a file, map it and execute it.
>
> LSMs (such as the IPE proposal [1]) may allow only properly signed object
> files to be mapped with execute permissions. This will prevent trampoline
> files from being mapped. Again, exceptions have to be made for genuine
> applications.
>
> We need a way to execute trampolines without making security exceptions
> where possible and to reduce the attack surface even further.
>
> Examples of trampolines
> -----------------------
>
> libffi (A Portable Foreign Function Interface Library):
>
> libffi allows a user to define functions with an arbitrary list of
> arguments and return value through a feature called "Closures".
> Closures use trampolines to jump to ABI handlers that handle calling
> conventions and call a target function. libffi is used by a lot
> of different applications. To name a few:
>
> 	- Python
> 	- Java
> 	- Javascript
> 	- Ruby FFI
> 	- Lisp
> 	- Objective C
>
> GCC nested functions:
>
> GCC has traditionally used trampolines for implementing nested
> functions. The trampoline is placed on the user stack. So, the stack
> needs to be executable.
>
> Currently available solution
> ----------------------------
>
> One solution that has been proposed to allow trampolines to be executed
> without making security exceptions is Trampoline Emulation. See:
>
> https://pax.grsecurity.net/docs/emutramp.txt
>
> In this solution, the kernel recognizes certain sequences of instructions
> as "well-known" trampolines. When such a trampoline is executed, a page
> fault happens because the trampoline page does not have execute permission.
> The kernel recognizes the trampoline and emulates it. Basically, the
> kernel does the work of the trampoline on behalf of the application.

What prevents a malicious process from using the "well-known" trampoline
to its own purposes? I expect it is obvious, but I'm not seeing it. Old
eyes, I suppose.

> Here, the attack surface is the buffer that contains the trampoline.
> The attack surface is narrower than before. A hacker may still be able to
> modify what gets loaded in the registers or modify the target PC to point
> to arbitrary locations.
>
> Currently, the emulated trampolines are the ones used in libffi and GCC
> nested functions. To my knowledge, only X86 is supported at this time.
>
> As noted in emutramp.txt, this is not a generic solution. For every new
> trampoline that needs to be supported, new instruction sequences need to
> be recognized by the kernel and emulated. And this has to be done for
> every architecture that needs to be supported.
>
> emutramp.txt notes the following:
>
> "... the real solution is not in emulation but by designing a kernel API
> for runtime code generation and modifying userland to make use of it."
>
> Trampoline File Descriptor (trampfd)
> --------------------------
>
> I am proposing a kernel API using anonymous file descriptors that
> can be used to create and execute trampolines with the help of the
> kernel. In this solution also, the kernel does the work of the trampoline.
> The API is described in patch 1/4 of this patchset. I provide a
> summary here:
>
> Trampolines commonly execute the following sequence:
>
> 	- Load some values in some registers and/or
> 	- Push some values on the stack
> 	- Jump to a target PC
>
> libffi and GCC nested function trampolines fit into this model.
>
> Using the kernel API, applications and libraries can:
>
> 	- Create a trampoline object
> 	- Associate a register context with the trampoline (including
> 	  a target PC)
> 	- Associate a stack context with the trampoline
> 	- Map the trampoline into a process address space
> 	- Execute the trampoline by executing at the trampoline address
>
> The kernel creates the trampoline mapping without any permissions. When
> the trampoline is executed by user code, a page fault happens and the
> kernel gets control. The kernel recognizes that this is a trampoline
> invocation. It sets up the user registers based on the specified
> register context, and/or pushes values on the user stack based on the
> specified stack context, and sets the user PC to the requested target
> PC. When the kernel returns, execution continues at the target PC.
> So, the kernel does the work of the trampoline on behalf of the
> application.
>
> In this case, the attack surface is the context buffer. A hacker may
> attack an application with a vulnerability and may be able to modify the
> context buffer. So, when the register or stack context is set for
> a trampoline, the values may have been tampered with. From an attack
> surface perspective, this is similar to Trampoline Emulation. But
> with trampfd, user code can retrieve a trampoline's context from the
> kernel and add defensive checks to see if the context has been
> tampered with.
>
> As for the target PC, trampfd implements a measure called the
> "Allowed PCs" context (see Advantages) to prevent a hacker from making
> the target PC point to arbitrary locations. So, the attack surface is
> narrower than Trampoline Emulation.
>
> Advantages of the Trampoline File Descriptor approach
> -----------------------------------------------------
>
> - trampfd is customizable. The user can specify any combination of
>   allowed register name-value pairs in the register context and the kernel
>   will set it up accordingly. This allows different user trampolines to be
>   converted to use trampfd.
>
> - trampfd allows a stack context to be set up so that trampolines that
>   need to push values on the user stack can do that.
>
> - The initial work is targeted for X86 and ARM. But the implementation
>   leverages small portions of existing signal delivery code. Specifically,
>   it uses pt_regs for setting up user registers and copy_to_user()
>   to push values on the stack. So, this can be very easily ported to other
>   architectures.
>
> - trampfd provides a basic framework. In the future, new trampoline types
>   can be implemented, new contexts can be defined, and additional rules
>   can be implemented for security purposes.
>
> - For instance, trampfd defines an "Allowed PCs" context in this initial
>   work. As an example, libffi can create a read-only array of all ABI
>   handlers for an architecture at build time. This array can be used to
>   set the list of allowed PCs for a trampoline. This will mean that a hacker
>   cannot hack the PC part of the register context and make it point to
>   arbitrary locations.
>
> - An SELinux setting called "exectramp" can be implemented along the
>   lines of "execmem", "execstack" and "execheap" to selectively allow the
>   use of trampolines on a per application basis.
>
> - User code can add defensive checks in the code before invoking a
>   trampoline to make sure that a hacker has not modified the context data.
>   It can do this by getting the trampoline context from the kernel and
>   double checking it.
>
> - In the future, if the kernel can be enhanced to use a safe code
>   generation component, that code can be placed in the trampoline mapping
>   pages. Then, the trampoline invocation does not have to incur a trip
>   into the kernel.
>
> - Also, if the kernel can be enhanced to use a safe code generation
>   component, other forms of dynamic code such as JIT code can be
>   addressed by the trampfd framework.
>
> - Trampolines can be shared across processes which can give rise to
>   interesting uses in the future.
>
> - Trampfd can be used for other purposes to extend the kernel's
>   functionality.
>
> libffi
> ------
>
> I have implemented my solution for libffi and provided the changes for
> X86 and ARM, 32-bit and 64-bit. Here is the reference patch:
>
> http://linux.microsoft.com/~madvenka/libffi/libffi.txt
>
> If the trampfd patchset gets accepted, I will send the libffi changes
> to the maintainers for a review. BTW, I have also successfully executed
> the libffi self tests.
>
> Work that is pending
> --------------------
>
> - I am working on implementing an SELinux setting called "exectramp"
>   similar to "execmem" to allow the use of trampfd on a per application
>   basis.

You could make a separate LSM to do these checks instead of limiting
it to SELinux. Your use case, your call, of course.

>
> - I have a comprehensive test program to test the kernel API. I am
>   working on adding it to selftests.
>
> References
> ----------
>
> [1] https://microsoft.github.io/ipe/
> ---
> Madhavan T. Venkataraman (4):
>   fs/trampfd: Implement the trampoline file descriptor API
>   x86/trampfd: Support for the trampoline file descriptor
>   arm64/trampfd: Support for the trampoline file descriptor
>   arm/trampfd: Support for the trampoline file descriptor
>
>  arch/arm/include/uapi/asm/ptrace.h     |  20 ++
>  arch/arm/kernel/Makefile               |   1 +
>  arch/arm/kernel/trampfd.c              | 214 +++++++++++++++++
>  arch/arm/mm/fault.c                    |  12 +-
>  arch/arm/tools/syscall.tbl             |   1 +
>  arch/arm64/include/asm/ptrace.h        |   9 +
>  arch/arm64/include/asm/unistd.h        |   2 +-
>  arch/arm64/include/asm/unistd32.h      |   2 +
>  arch/arm64/include/uapi/asm/ptrace.h   |  57 +++++
>  arch/arm64/kernel/Makefile             |   2 +
>  arch/arm64/kernel/trampfd.c            | 278 ++++++++++++++++++++++
>  arch/arm64/mm/fault.c                  |  15 +-
>  arch/x86/entry/syscalls/syscall_32.tbl |   1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
>  arch/x86/include/uapi/asm/ptrace.h     |  38 +++
>  arch/x86/kernel/Makefile               |   2 +
>  arch/x86/kernel/trampfd.c              | 313 +++++++++++++++++++++++++
>  arch/x86/mm/fault.c                    |  11 +
>  fs/Makefile                            |   1 +
>  fs/trampfd/Makefile                    |   6 +
>  fs/trampfd/trampfd_data.c              |  43 ++++
>  fs/trampfd/trampfd_fops.c              | 131 +++++++++++
>  fs/trampfd/trampfd_map.c               |  78 ++++++
>  fs/trampfd/trampfd_pcs.c               |  95 ++++++++
>  fs/trampfd/trampfd_regs.c              | 137 +++++++++++
>  fs/trampfd/trampfd_stack.c             | 131 +++++++++++
>  fs/trampfd/trampfd_stubs.c             |  41 ++++
>  fs/trampfd/trampfd_syscall.c           |  92 ++++++++
>  include/linux/syscalls.h               |   3 +
>  include/linux/trampfd.h                |  82 +++++++
>  include/uapi/asm-generic/unistd.h      |   4 +-
>  include/uapi/linux/trampfd.h           | 171 ++++++++++++++
>  init/Kconfig                           |   8 +
>  kernel/sys_ni.c                        |   3 +
>  34 files changed, 1998 insertions(+), 7 deletions(-)
>  create mode 100644 arch/arm/kernel/trampfd.c
>  create mode 100644 arch/arm64/kernel/trampfd.c
>  create mode 100644 arch/x86/kernel/trampfd.c
>  create mode 100644 fs/trampfd/Makefile
>  create mode 100644 fs/trampfd/trampfd_data.c
>  create mode 100644 fs/trampfd/trampfd_fops.c
>  create mode 100644 fs/trampfd/trampfd_map.c
>  create mode 100644 fs/trampfd/trampfd_pcs.c
>  create mode 100644 fs/trampfd/trampfd_regs.c
>  create mode 100644 fs/trampfd/trampfd_stack.c
>  create mode 100644 fs/trampfd/trampfd_stubs.c
>  create mode 100644 fs/trampfd/trampfd_syscall.c
>  create mode 100644 include/linux/trampfd.h
>  create mode 100644 include/uapi/linux/trampfd.h
>

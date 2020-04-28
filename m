Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4E41BCC4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 21:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbgD1TWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 15:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728672AbgD1TWS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 15:22:18 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAAEC03C1AE
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 12:22:17 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t11so17840789lfe.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2020 12:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=opD7Vk+cgUl7dbTp5ZczjYHZ+7UjaGWB+S8PGRXvfAk=;
        b=YBSazLXARWnl1CvwswKXksKnwlBkbPPWFrhruK7C4tL8mSokRVCEDdG0K7pPSmC4yf
         o06C1DOwfxOOjXmFhSt2rauodTePGnVqFTOpy7SKwPQkLLCg+bc69ty33X63pP4vMFOF
         29wSQvHWSDgE27PMQFG/aEIiYTZ6fWizHrwAjmHKnXPg7f7MedXOZtdJ+/Y5miwoQbDA
         k2FX4eiGQGBwyU4TkvCcDTQ+eHUnrjUanS/NwhRRGwvKZ5HWgCxPSPK51MdsvbFr1UO+
         su0YqicO1CBLv1vguA3SD7FhlM8d+jZuwRxME4fTI47ZGlNLntloC30NmglrazgbpYlZ
         TvEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=opD7Vk+cgUl7dbTp5ZczjYHZ+7UjaGWB+S8PGRXvfAk=;
        b=X0O63vjl0kYCyGRMgLgGWsH97a6KFpHl2lRcKCoNdbWVyMNwhZurHftbh36IWkJ6U4
         +gbLul0LMidFIYLkgizbUyxq7wv1eKGaxqDP8RAW/NSFIab50mraiQLFriHy87EDV5Cw
         1QoMaee4q1KLLuViOOGSv+Zx4lUM37MKg0+1T3aJnFFpcKPiWvhCRFsngq7kce1mCENA
         D/APKn9Q1UNqc2deE6qkYTHWzbKDsFv6QH43JB04psYnOEGmfFmElzS2OYwxSYFOgfW/
         d9Z0JqFUxhgpBDlWGrs33qcEGtcVl5mybKqF8NF65zAZUhllxy9HqBhusbwQAq8TMCZI
         IaKg==
X-Gm-Message-State: AGi0PubaSchwq3Iuhm9tWfpOE7ytJXpuqmjr05VnsE8reTvGmKiPZXT/
        xKBP1VrAYsvdSBnXLiHBAEOIgoQU0fQ1kk/+PJEa4Q==
X-Google-Smtp-Source: APiQypLlpznG04JBP3KBzAaDaA/poR+Fm5OSMoYYDOm8gsIEEcDVfC2zhOSj0ksor7MMcR+scBJ3IJma5bVlqINdyk0=
X-Received: by 2002:ac2:5dc6:: with SMTP id x6mr20148765lfq.108.1588101735413;
 Tue, 28 Apr 2020 12:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200428175129.634352-1-mic@digikod.net>
In-Reply-To: <20200428175129.634352-1-mic@digikod.net>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Apr 2020 21:21:48 +0200
Message-ID: <CAG48ez1bKzh1YvbD_Lcg0AbMCH_cdZmrRRumU7UCJL=qPwNFpQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] Add support for RESOLVE_MAYEXEC
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 28, 2020 at 7:51 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> The goal of this patch series is to enable to control script execution
> with interpreters help.  A new RESOLVE_MAYEXEC flag, usable through
> openat2(2), is added to enable userspace script interpreter to delegate
> to the kernel (and thus the system security policy) the permission to
> interpret/execute scripts or other files containing what can be seen as
> commands.
>
> This third patch series mainly differ from the previous one by relying
> on the new openat2(2) system call to get rid of the undefined behavior
> of the open(2) flags.  Thus, the previous O_MAYEXEC flag is now replaced
> with the new RESOLVE_MAYEXEC flag and benefits from the openat2(2)
> strict check of this kind of flags.
>
> A simple system-wide security policy can be enforced by the system
> administrator through a sysctl configuration consistent with the mount
> points or the file access rights.  The documentation patch explains the
> prerequisites.
>
> Furthermore, the security policy can also be delegated to an LSM, either
> a MAC system or an integrity system.  For instance, the new kernel
> MAY_OPENEXEC flag closes a major IMA measurement/appraisal interpreter
> integrity gap by bringing the ability to check the use of scripts [1].
> Other uses are expected, such as for openat2(2) [2], SGX integration
> [3], bpffs [4] or IPE [5].
>
> Userspace needs to adapt to take advantage of this new feature.  For
> example, the PEP 578 [6] (Runtime Audit Hooks) enables Python 3.8 to be
> extended with policy enforcement points related to code interpretation,
> which can be used to align with the PowerShell audit features.
> Additional Python security improvements (e.g. a limited interpreter
> withou -c, stdin piping of code) are on their way.
>
> The initial idea come from CLIP OS 4 and the original implementation has
> been used for more than 11 years:
> https://github.com/clipos-archive/clipos4_doc
>
> An introduction to O_MAYEXEC (original name of RESOLVE_MAYEXEC) was
> given at the Linux Security Summit Europe 2018 - Linux Kernel Security
> Contributions by ANSSI:
> https://www.youtube.com/watch?v=3DchNjCRtPKQY&t=3D17m15s
> The "write xor execute" principle was explained at Kernel Recipes 2018 -
> CLIP OS: a defense-in-depth OS:
> https://www.youtube.com/watch?v=3DPjRE0uBtkHU&t=3D11m14s
>
> This patch series can be applied on top of v5.7-rc3.  This can be tested
> with CONFIG_SYSCTL.  I would really appreciate constructive comments on
> this patch series.

Just as a comment: You'd probably also have to use RESOLVE_MAYEXEC in
the dynamic linker. A while back, I wrote a proof-of-concept ELF
library that can execute arbitrary code without triggering IMA because
it has no executable segments - instead it uses init_array to directly
trigger code execution at a JOP gadget in libc that then uses
mprotect() to make the code executable. I tested this on Debian
Stretch back in 2018.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
user@debian:~/ima_stuff$ cat make_segments_rw.c
#include <stdlib.h>
#include <fcntl.h>
#include <err.h>
#include <elf.h>
#include <sys/mman.h>
#include <sys/stat.h>

int main(int argc, char **argv) {
        int fd =3D open(argv[1], O_RDWR);
        if (fd =3D=3D -1) err(1, "open");
        struct stat st;
        if (fstat(fd, &st)) err(1, "stat");
        unsigned char *mapping =3D mmap(NULL, st.st_size,
PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
        if (mapping =3D=3D MAP_FAILED) err(1, "mmap");
        Elf64_Ehdr *ehdr =3D (void*)mapping;
        Elf64_Phdr *phdrs =3D (void*)(mapping + ehdr->e_phoff);

        for (int i=3D0; i<ehdr->e_phnum; i++) {
                phdrs[i].p_flags &=3D ~PF_X;
                phdrs[i].p_flags |=3D PF_W;
        }

        return 0;
}
user@debian:~/ima_stuff$ cat test.s
        .text
        .section        .text.startup,"aw",@progbits
        .globl  foobar
        .align 4096
foobar:
        /* alignment for xmm stuff in libc */
        sub     $8, %rsp
        call    getpid
        mov     %rax, %rsi
        leaq    message(%rip), %rdi
        call    printf
        movq    stdout_indir(%rip), %rdi
        movq    (%rdi), %rdi
        call fflush
        xor     %edi, %edi
        call    _exit

        .section        .init_array,"aw"
        .align 8
        .quad   rmdir+0x774

        .section        .fini_array,"aw"
        .quad   0xdeadbeef
        .quad   0xdeadbeef
        .quad   0xdeadbeef
        .quad   ucontext_data /* goes into rdi */
        .quad   0xdeadbeef
        .quad   0xdeadbeef
        .quad   0xdeadbeef
        .quad   0xdeadbeef
        .quad   setcontext+0x35 /* call target */

        .data
ucontext_data:
        /* 0x00 */
        .quad 0xdeadbeefdeadbeef, 0xdeadbeefdeadbeef
        .quad 0xdeadbeefdeadbeef, 0xdeadbeefdeadbeef
        .quad 0xdeadbeefdeadbeef, 0xdeadbeefdeadbeef
        .quad 0xdeadbeefdeadbeef, 0xdeadbeefdeadbeef
        /* 0x40 */
        .quad 0xdeadbeefdeadbeef, 0xdeadbeefdeadbeef
        .quad 0xdeadbeefdeadbeef, 0xdeadbeefdeadbeef
        .quad 0xdeadbeefdeadbeef, foobar
        .quad             0x1000, 0xdeadbeefdeadbeef
        /* 0x80 */
        .quad 0xdeadbeefdeadbeef, 0x7
        .quad 0xdeadbeefdeadbeef, 0xdeadbeefdeadbeef
        .quad stack_end, mprotect

        /* my stack */
        .fill 0x10000, 1, 0x42
stack_end:
        .quad foobar
message:
        .string "hello world from PID %d\n"
stdout_indir:
        .quad stdout
user@debian:~/ima_stuff$ gcc -o make_segments_rw make_segments_rw.c
user@debian:~/ima_stuff$ as -o test.o test.s
test.s: Assembler messages:
test.s:2: Warning: setting incorrect section attributes for .text.startup
user@debian:~/ima_stuff$ ld -shared -znorelro -o test.so test.o
user@debian:~/ima_stuff$ ./make_segments_rw test.so
user@debian:~/ima_stuff$ LD_PRELOAD=3D./test.so /bin/echo
hello world from PID 1053
user@debian:~/ima_stuff$ sudo tail
/sys/kernel/security/ima/runtime_measurements_count
1182
user@debian:~/ima_stuff$ sudo tail /sys/kernel/security/ima/runtime_measure=
ments
tail: cannot open '/sys/kernel/security/ima/runtime_measurements' for
reading: No such file or directory
user@debian:~/ima_stuff$ sudo tail
/sys/kernel/security/ima/ascii_runtime_measurements
10 2435d24127ce5bcfbe776589ac86bc85530da07d ima-ng
sha256:ae35ddf5dbbef6ea31e8b87326001d12a6b4ec479bb8195b874d733d69ed1a4d
/usr/bin/x86_64-linux-gnu-gcc-6
10 f3ed20073a77fbc020d2807ce12ffc4cdbced976 ima-ng
sha256:65af5a9ea7ce00be9b921d4b13f5224c2369451eb918d4fa7721442283545957
/usr/bin/x86_64-linux-gnu-g++-6
10 25f0128e89a730a6f1cdd42d8de71d3db2625c9e ima-ng
sha256:d5d7e609b95939d0ae9f75a953d5cda4f1d8b9e4c1db98aeee7f792028bf026e
/usr/bin/x86_64-linux-gnu-as
10 51cf269a0008ab8173c7a696bee11be86a0bbd45 ima-ng
sha256:2d10a4e221ef8454b635f1ec646e6f4ff7f3db8e2e59b489c642758b2624a659
/usr/lib/x86_64-linux-gnu/libopcodes-2.28-system.so
10 b5c1db60c50722e1af84b83b34c0adb04b98d040 ima-ng
sha256:d3eef29b5b5bfc12999c5dbcc91029302477b70c7599aeb6b564140a336ab00b
/usr/lib/x86_64-linux-gnu/libbfd-2.28-system.so
10 6364d50cdac1733b7fd5dcfd9df124d1e4362a12 ima-ng
sha256:30c26e4b3cbd0677b2a23d09a72989002af138be57d301ed529c91b88427098f
/usr/lib/gcc/x86_64-linux-gnu/6/collect2
10 2a8c7ddacee57967e8a00ee1a522b552e29f559f ima-ng
sha256:a7b6287a8095701713e9ee7a886cae1f1ceefd0ce9c45dcc38719af563200964
/usr/bin/x86_64-linux-gnu-ld.bfd
10 e55a9c15349e2271cbdfe2f4fe36cd5b4070d3d0 ima-ng
sha256:b31674ad141a40eb2603f20400cc0dea4ee32ecf87771df3d039f16aae60ee26
/usr/lib/gcc/x86_64-linux-gnu/6/liblto_plugin.so.0.0.0
10 617aab630be74cd5bb7d830a727fd29cda361743 ima-ng
sha256:40fbf6acd3182d7a1ad158cd4de48da704bfe84f468d7b58dd557db93fe8a34c
/usr/bin/vim.basic
10 2c1fe398ecc0a8db6651621715d60a7e1b1958dc ima-ng
sha256:8523b422a01af773eff76b981c763cf0c739ea3030e592bb4d4f7854e295c418
/home/user/ima_stuff/make_segments_rw
user@debian:~/ima_stuff$
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

When looking at the syscalls the process is making, you can see that
it indeed never calls mmap() with PROT_EXEC on the library (I use
mprotect() to make my code executable, but IMA doesn't use the
mprotect security hook):

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
user@debian:~/ima_stuff$ strace -E LD_PRELOAD=3D./test.so /bin/echo
execve("/bin/echo", ["/bin/echo"], [/* 44 vars */]) =3D 0
brk(NULL)                               =3D 0x5642c52bc000
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x7fb83e817000
open("./test.so", O_RDONLY|O_CLOEXEC)   =3D 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\20\0\0\0\0\0\0"..=
.,
832) =3D 832
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D72232, ...}) =3D 0
getcwd("/home/user/ima_stuff", 128)     =3D 21
mmap(NULL, 2167449, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) =3D 0x7fb83e3e5000
mprotect(0x7fb83e3e7000, 2093056, PROT_NONE) =3D 0
mmap(0x7fb83e5e6000, 69632, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) =3D 0x7fb83e5e6000
mprotect(0x7ffea1b1f000, 4096,
PROT_READ|PROT_WRITE|PROT_EXEC|PROT_GROWSDOWN) =3D 0
close(3)                                =3D 0
access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D103509, ...}) =3D 0
mmap(NULL, 103509, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x7fb83e7fd000
close(3)                                =3D 0
access("/etc/ld.so.nohwcap", F_OK)      =3D -1 ENOENT (No such file or dire=
ctory)
open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) =3D 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\320\3\2\0\0\0\0\0".=
..,
832) =3D 832
fstat(3, {st_mode=3DS_IFREG|0755, st_size=3D1689360, ...}) =3D 0
mmap(NULL, 3795360, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) =3D 0x7fb83e046000
mprotect(0x7fb83e1db000, 2097152, PROT_NONE) =3D 0
mmap(0x7fb83e3db000, 24576, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x195000) =3D 0x7fb83e3db000
mmap(0x7fb83e3e1000, 14752, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x7fb83e3e1000
close(3)                                =3D 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x7fb83e7fb000
arch_prctl(ARCH_SET_FS, 0x7fb83e7fb700) =3D 0
mprotect(0x7fb83e3db000, 16384, PROT_READ) =3D 0
mprotect(0x5642c3eed000, 4096, PROT_READ) =3D 0
mprotect(0x7fb83e81a000, 4096, PROT_READ) =3D 0
munmap(0x7fb83e7fd000, 103509)          =3D 0
mprotect(0x7fb83e3e6000, 4096, PROT_READ|PROT_WRITE|PROT_EXEC) =3D 0
getpid()                                =3D 1084
fstat(1, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(136, 4), ...}) =3D 0
brk(NULL)                               =3D 0x5642c52bc000
brk(0x5642c52dd000)                     =3D 0x5642c52dd000
write(1, "hello world from PID 1084\n", 26hello world from PID 1084
) =3D 26
exit_group(0)                           =3D ?
+++ exited with 0 +++
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B00B31AA5D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Feb 2021 08:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhBMHm3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Feb 2021 02:42:29 -0500
Received: from mout.gmx.net ([212.227.17.20]:53751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229469AbhBMHm2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Feb 2021 02:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613202041;
        bh=idfUTHJbaeMOGlDzM/voRhw1ltbh15PMEFZKiKzTAPs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JvXINMWHgICui2DfZnF6uZtu8EjoplXTn8cQHvzTA1FP7IxlhcWLpfD4BCb33J/N9
         kYRaVZCHNVdzGPlCsZ33NIMeQK+DJVchqz2e0Z9oJBaOfI3PiDKa7OW9627bZzGON4
         UV8cFsNXD421PX8KjP4Hw2rLEhYlm9Xb3XdXUjl4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.134.198]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7R1J-1ly36K1VAT-017jIf; Sat, 13
 Feb 2021 08:40:41 +0100
Subject: Re: [PATCH v3] binfmt_misc: pass binfmt_misc flags to the interpreter
To:     Laurent Vivier <laurent@vivier.eu>, linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, YunQiang Su <ysu@wavecomp.com>,
        YunQiang Su <syq@debian.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20200128132539.782286-1-laurent@vivier.eu>
 <348e8e7a-3a2c-23b7-4a2e-d3f5e8a62173@vivier.eu>
From:   Helge Deller <deller@gmx.de>
Message-ID: <743e8674-fd7e-c7e1-aa7e-6674a9e9e116@gmx.de>
Date:   Sat, 13 Feb 2021 08:40:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <348e8e7a-3a2c-23b7-4a2e-d3f5e8a62173@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tNN6y8RrOyL4oqriF6kWbj3PAmTZD3EldR1GcyI27YaDsmm+v98
 hAEs2FDJTCCjDS+U0Q9x5ifJP75vP/hmOwTiZoz1W/1NjMkTeOKpELrf9fzQqLPZIdPNDK9
 WhWatPOk7diTEPUcxuiBO56ySNSooqOymxbZkqhKKO3PJEbf3z+yXiE859VmjfTSkxvvMBL
 BdQvWQnig486dAzg1PcJg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7pgY0p06W6I=:3+UKSLTCcshE+0EtahTc/e
 fLni0WucStIMOqg/7l9JRg/P6TkLEeAAEkAStpKyGpTLTa6ew5JHURfb7854wcFBhe8j+D6ww
 rn79RWOi3ifiBeLnyow7JJOz6VaO4uPVo0YFbGoicnesgDiIsAm+ByFob6CAcnTOjf0Vzcymp
 FSRBdzgbU9dqoYoVzYc4BD4jttEWyfZp4GIZ3t1uAuxtkY3Ktvv9K42voDypmHbTPzYUMW2MI
 JKQ3T/NQeM/AyShh7/nwnfcbA1cubkRmN/jvNdFJKn5v/cVqSwdvRLQK31BGV2Bc2UubAeyCg
 09uEmQ/mvIseuyTsocTZi4T8Y4hveHHisQE8Va3cRDuXLk8F3zfrRGjhYKzwr6JhtoO5BLo7b
 EWBCCZ1VVIVLZYAGDqc1DdMgUJg1mpHY9Ykzv1GUhitkvlvKJcXoP2sdoq6m5QQVOZYO5Nx5x
 Uy+LM4J51Y5KOPjdcwOmi3QAB5tbmOhXeL/ZaYSjXyRErMDQ3H6gugXZW+HOgbV3nXzEwcdZW
 1hBm2UxRCqXMK9S2n84w/sSnzm5ZGmvJTshpGR6l0rYOmzcUC4BDqhbWdXAFU5OOvBp1Mwd6e
 vZ8gwGGhkf7blZ3D3+q4r6MfoobFoKM/3oWGx2N4NtO9Afh0Ipb+FMcQr4zXYfErg3q13/iu8
 EoSfR25cZJkl+oVcOxXBD5ArqWxj8JK9xdsg5QQW7xfK+vnYqucmL527ckBl7Pi78mJsk/lPD
 zHLDntjqskYW2xloh5yoCP6Olaf+xiBYhv/ORJoZjqjdcKl4MM3FTygehxiXY6dfOdT0zD9or
 GSk1fNigGIIuJaUVbObRQ6HNZKRITSqXFpuBpOBnf6K4nGaVdcqySGArOjEyiXbHmQRXiYoi0
 qPFc6nOFcedpV24P4Kfw==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/5/20 6:20 PM, Laurent Vivier wrote:
> Le 28/01/2020 =C3=A0 14:25, Laurent Vivier a =C3=A9crit=C2=A0:
>> It can be useful to the interpreter to know which flags are in use.
>>
>> For instance, knowing if the preserve-argv[0] is in use would
>> allow to skip the pathname argument.
>>
>> This patch uses an unused auxiliary vector, AT_FLAGS, to add a
>> flag to inform interpreter if the preserve-argv[0] is enabled.
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Acked-by: Helge Deller <deller@gmx.de>

If nobody objects, I'd like to take this patch through the
parisc arch git tree.

It fixes a real-world problem with qemu-user which fails to
preserve the argv[0] argument when the callee of an exec is a
qemu-user target.
This problem leads to build errors on multiple Debian buildd servers
which are using qemu-user as emulation for the target machines.

For details see Debian bug:
http://bugs.debian.org/970460


Helge


>> ---
>>
>> Notes:
>>      This can be tested with QEMU from my branch:
>>
>>        https://github.com/vivier/qemu/commits/binfmt-argv0
>>
>>      With something like:
>>
>>        # cp ..../qemu-ppc /chroot/powerpc/jessie
>>
>>        # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential y=
es \
>>                              --persistent no --preserve-argv0 yes
>>        # systemctl restart systemd-binfmt.service
>>        # cat /proc/sys/fs/binfmt_misc/qemu-ppc
>>        enabled
>>        interpreter //qemu-ppc
>>        flags: POC
>>        offset 0
>>        magic 7f454c4601020100000000000000000000020014
>>        mask ffffffffffffff00fffffffffffffffffffeffff
>>        # chroot /chroot/powerpc/jessie  sh -c 'echo $0'
>>        sh
>>
>>        # qemu-binfmt-conf.sh --qemu-path / --systemd ppc --credential y=
es \
>>                              --persistent no --preserve-argv0 no
>>        # systemctl restart systemd-binfmt.service
>>        # cat /proc/sys/fs/binfmt_misc/qemu-ppc
>>        enabled
>>        interpreter //qemu-ppc
>>        flags: OC
>>        offset 0
>>        magic 7f454c4601020100000000000000000000020014
>>        mask ffffffffffffff00fffffffffffffffffffeffff
>>        # chroot /chroot/powerpc/jessie  sh -c 'echo $0'
>>        /bin/sh
>>
>>      v3: mix my patch with one from YunQiang Su and my comments on it
>>          introduce a new flag in the uabi for the AT_FLAGS
>>      v2: only pass special flags (remove Magic and Enabled flags)
>>
>>   fs/binfmt_elf.c              | 5 ++++-
>>   fs/binfmt_elf_fdpic.c        | 5 ++++-
>>   fs/binfmt_misc.c             | 4 +++-
>>   include/linux/binfmts.h      | 4 ++++
>>   include/uapi/linux/binfmts.h | 4 ++++
>>   5 files changed, 19 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index ecd8d2698515..ff918042ceed 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
>> @@ -176,6 +176,7 @@ create_elf_tables(struct linux_binprm *bprm, struct=
 elfhdr *exec,
>>   	unsigned char k_rand_bytes[16];
>>   	int items;
>>   	elf_addr_t *elf_info;
>> +	elf_addr_t flags =3D 0;
>>   	int ei_index =3D 0;
>>   	const struct cred *cred =3D current_cred();
>>   	struct vm_area_struct *vma;
>> @@ -250,7 +251,9 @@ create_elf_tables(struct linux_binprm *bprm, struct=
 elfhdr *exec,
>>   	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
>>   	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
>>   	NEW_AUX_ENT(AT_BASE, interp_load_addr);
>> -	NEW_AUX_ENT(AT_FLAGS, 0);
>> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
>> +		flags |=3D AT_FLAGS_PRESERVE_ARGV0;
>> +	NEW_AUX_ENT(AT_FLAGS, flags);
>>   	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
>>   	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
>>   	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
>> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
>> index 240f66663543..abb90d82aa58 100644
>> --- a/fs/binfmt_elf_fdpic.c
>> +++ b/fs/binfmt_elf_fdpic.c
>> @@ -507,6 +507,7 @@ static int create_elf_fdpic_tables(struct linux_bin=
prm *bprm,
>>   	char __user *u_platform, *u_base_platform, *p;
>>   	int loop;
>>   	int nr;	/* reset for each csp adjustment */
>> +	unsigned long flags =3D 0;
>>
>>   #ifdef CONFIG_MMU
>>   	/* In some cases (e.g. Hyper-Threading), we want to avoid L1 evictio=
ns
>> @@ -647,7 +648,9 @@ static int create_elf_fdpic_tables(struct linux_bin=
prm *bprm,
>>   	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
>>   	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
>>   	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
>> -	NEW_AUX_ENT(AT_FLAGS,	0);
>> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
>> +		flags |=3D AT_FLAGS_PRESERVE_ARGV0;
>> +	NEW_AUX_ENT(AT_FLAGS,	flags);
>>   	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
>>   	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cre=
d->uid));
>>   	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cr=
ed->euid));
>> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
>> index cdb45829354d..b9acdd26a654 100644
>> --- a/fs/binfmt_misc.c
>> +++ b/fs/binfmt_misc.c
>> @@ -154,7 +154,9 @@ static int load_misc_binary(struct linux_binprm *bp=
rm)
>>   	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
>>   		goto ret;
>>
>> -	if (!(fmt->flags & MISC_FMT_PRESERVE_ARGV0)) {
>> +	if (fmt->flags & MISC_FMT_PRESERVE_ARGV0) {
>> +		bprm->interp_flags |=3D BINPRM_FLAGS_PRESERVE_ARGV0;
>> +	} else {
>>   		retval =3D remove_arg_zero(bprm);
>>   		if (retval)
>>   			goto ret;
>> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
>> index b40fc633f3be..265b80d5fd6f 100644
>> --- a/include/linux/binfmts.h
>> +++ b/include/linux/binfmts.h
>> @@ -78,6 +78,10 @@ struct linux_binprm {
>>   #define BINPRM_FLAGS_PATH_INACCESSIBLE_BIT 2
>>   #define BINPRM_FLAGS_PATH_INACCESSIBLE (1 << BINPRM_FLAGS_PATH_INACCE=
SSIBLE_BIT)
>>
>> +/* if preserve the argv0 for the interpreter  */
>> +#define BINPRM_FLAGS_PRESERVE_ARGV0_BIT 3
>> +#define BINPRM_FLAGS_PRESERVE_ARGV0 (1 << BINPRM_FLAGS_PRESERVE_ARGV0_=
BIT)
>> +
>>   /* Function parameter for binfmt->coredump */
>>   struct coredump_params {
>>   	const kernel_siginfo_t *siginfo;
>> diff --git a/include/uapi/linux/binfmts.h b/include/uapi/linux/binfmts.=
h
>> index 689025d9c185..a70747416130 100644
>> --- a/include/uapi/linux/binfmts.h
>> +++ b/include/uapi/linux/binfmts.h
>> @@ -18,4 +18,8 @@ struct pt_regs;
>>   /* sizeof(linux_binprm->buf) */
>>   #define BINPRM_BUF_SIZE 256
>>
>> +/* if preserve the argv0 for the interpreter  */
>> +#define AT_FLAGS_PRESERVE_ARGV0_BIT 0
>> +#define AT_FLAGS_PRESERVE_ARGV0 (1 << AT_FLAGS_PRESERVE_ARGV0_BIT)
>> +
>>   #endif /* _UAPI_LINUX_BINFMTS_H */
>>
>


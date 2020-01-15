Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB78113C088
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 13:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731727AbgAOMTc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 07:19:32 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:44145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731258AbgAOMTb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:19:31 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MHndY-1iuVTR2UBa-00Ey0q; Wed, 15 Jan 2020 13:19:23 +0100
Subject: Re: [RFC v2] binfmt_misc: pass binfmt_misc flags to the interpreter
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20191122150830.15855-1-laurent@vivier.eu>
 <b39e59a6-82f2-2122-5b22-4d8a77eda275@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2a464b33-0b1d-ff35-5aab-77019a072593@vivier.eu>
Date:   Wed, 15 Jan 2020 13:19:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <b39e59a6-82f2-2122-5b22-4d8a77eda275@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rzRuXGOLOhVdHCUnIp0jlhvpy9y2n1TLQC1eG4D3zAmByzWNm32
 tcTt1JPbq79q/gG3KDTeoZ3w/CIF9x9jJG4bXbhvAEXJ3dQHp5aJXqp5hV02PWu2nOywu1P
 onzgiXaBgwEzA+3j9cwuJWa0snLoUeEhpmUrTfPfHvxxl51C2xSydnJU00qvc0vgTBfTtX8
 v0ymUvbqYMUo8TVuJbpCQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZLwRR0oePp0=:rTdyxLthyF8D5mpHxzzxUy
 srzGsb2RIkLY0zDPKBN/yJFHbzvuWwc9m+q0g4XP60gvakStlFiZ8UAXN4xEqajvyOzM4ZRiU
 2+nxo+sZBt1/wbxzSO9uL8jIDPh35irVvqhjWMex/NCnIXAhPyIrMxfoC/BzFEhtXKLlof4Km
 57DAApi+zkpznlb/W7g2BE9Odo4eIC6oL7ZT7gMAdPrco35kLMzJSkDNWcVIKylyMEXCnw+kJ
 DhrkKwudB1inKT0bLLbIaE4ir815SI+jBiQMJlN/ym0SP1MSbJciem8G9kGfPeKR2t98T8msC
 l/1Z/81p+JuXpKjcJEWIdg6i6wpPqiyQZyuP4DQ9R1HOymMw8tn19/3saqRpWDjWj32AQgmrs
 xC2OEncaj2L2CRr/P2DGQRd5m5FmNhq2f41+OyVAZITpAb9WV3IbEzPl7vGOM8y1PLeYeYngp
 9ZuI1EzcXrwbtDFwzxLMvYJJOR0ENBGlB7KD3jFmkHIDTvW9QonO5bk9n3FH7XHInszCo1ktk
 U3ph6qFMM3H7+AdRSl1oLp2TjHkMC8o+KL+7qZPCt8wJFaV1bybOXsW2CWFsgnyVWvjvlOwUl
 l/X3wUC3MLI3oDL+oTjtQN7Es0O1ZJ1XXlNx/HKVyAJTi98eGdA/9xyh1jL+yyN2nganwZnRE
 hGWRvl9fxSx78Tx8LbkC1YPTCv0ArYmskBnRArRpwkjIpJpW6N6UHC2g+hAfm8DTfV+SqXYPp
 vQAA7mTyOURpOMb7l8S76cXeagaDUYauVZi6w6CVixO/ydfCrYfov//G3/9g+iHlXDFnooMSk
 K3EwbqU1axD9IMZLrLvCmY102HBrTVIOqw2Eb84t6xAW2RvEO/PaExCPuOksoth3hkMiZJpPc
 Pf6CjdG0eFVu31d8U4b2xg64gNC/s6Rm0PGzFFJ30=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 07/01/2020 à 15:50, Laurent Vivier a écrit :
> Hi,
> 
> this change is simple, easy to read and understand but it is really
> needed by user space application interpreter to know the status of the
> system configuration.
> 
> Could we have a comment saying if there is a problem or if it is good to
> be merged?

Anyone?

> Thanks,
> Laurent
> 
> Le 22/11/2019 à 16:08, Laurent Vivier a écrit :
>> It can be useful to the interpreter to know which flags are in use.
>>
>> For instance, knowing if the preserve-argv[0] is in use would
>> allow to skip the pathname argument.
>>
>> This patch uses an unused auxiliary vector, AT_FLAGS,  to pass the
>> content of the binfmt flags (special flags: P, F, C, O).
>>
>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>> ---
>>
>> Notes:
>>     v2: only pass special flags (remove Magic and Enabled flags)
>>
>>  fs/binfmt_elf.c         | 2 +-
>>  fs/binfmt_elf_fdpic.c   | 2 +-
>>  fs/binfmt_misc.c        | 6 ++++++
>>  include/linux/binfmts.h | 2 +-
>>  4 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index c5642bcb6b46..7a34c03e5857 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
>> @@ -250,7 +250,7 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
>>  	NEW_AUX_ENT(AT_PHENT, sizeof(struct elf_phdr));
>>  	NEW_AUX_ENT(AT_PHNUM, exec->e_phnum);
>>  	NEW_AUX_ENT(AT_BASE, interp_load_addr);
>> -	NEW_AUX_ENT(AT_FLAGS, 0);
>> +	NEW_AUX_ENT(AT_FLAGS, bprm->fmt_flags);
>>  	NEW_AUX_ENT(AT_ENTRY, exec->e_entry);
>>  	NEW_AUX_ENT(AT_UID, from_kuid_munged(cred->user_ns, cred->uid));
>>  	NEW_AUX_ENT(AT_EUID, from_kuid_munged(cred->user_ns, cred->euid));
>> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
>> index d86ebd0dcc3d..8fe839be125e 100644
>> --- a/fs/binfmt_elf_fdpic.c
>> +++ b/fs/binfmt_elf_fdpic.c
>> @@ -647,7 +647,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
>>  	NEW_AUX_ENT(AT_PHENT,	sizeof(struct elf_phdr));
>>  	NEW_AUX_ENT(AT_PHNUM,	exec_params->hdr.e_phnum);
>>  	NEW_AUX_ENT(AT_BASE,	interp_params->elfhdr_addr);
>> -	NEW_AUX_ENT(AT_FLAGS,	0);
>> +	NEW_AUX_ENT(AT_FLAGS,	bprm->fmt_flags);
>>  	NEW_AUX_ENT(AT_ENTRY,	exec_params->entry_addr);
>>  	NEW_AUX_ENT(AT_UID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->uid));
>>  	NEW_AUX_ENT(AT_EUID,	(elf_addr_t) from_kuid_munged(cred->user_ns, cred->euid));
>> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
>> index cdb45829354d..25a392f23409 100644
>> --- a/fs/binfmt_misc.c
>> +++ b/fs/binfmt_misc.c
>> @@ -48,6 +48,9 @@ enum {Enabled, Magic};
>>  #define MISC_FMT_OPEN_BINARY (1 << 30)
>>  #define MISC_FMT_CREDENTIALS (1 << 29)
>>  #define MISC_FMT_OPEN_FILE (1 << 28)
>> +#define MISC_FMT_FLAGS_MASK (MISC_FMT_PRESERVE_ARGV0 | MISC_FMT_OPEN_BINARY | \
>> +			     MISC_FMT_CREDENTIALS | MISC_FMT_OPEN_FILE)
>> +
>>  
>>  typedef struct {
>>  	struct list_head list;
>> @@ -149,6 +152,9 @@ static int load_misc_binary(struct linux_binprm *bprm)
>>  	if (!fmt)
>>  		return retval;
>>  
>> +	/* pass special flags to the interpreter */
>> +	bprm->fmt_flags = fmt->flags & MISC_FMT_FLAGS_MASK;
>> +
>>  	/* Need to be able to load the file after exec */
>>  	retval = -ENOENT;
>>  	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
>> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
>> index b40fc633f3be..dae0d0d7b84d 100644
>> --- a/include/linux/binfmts.h
>> +++ b/include/linux/binfmts.h
>> @@ -60,7 +60,7 @@ struct linux_binprm {
>>  				   different for binfmt_{misc,script} */
>>  	unsigned interp_flags;
>>  	unsigned interp_data;
>> -	unsigned long loader, exec;
>> +	unsigned long loader, exec, fmt_flags;
>>  
>>  	struct rlimit rlim_stack; /* Saved RLIMIT_STACK used during exec. */
>>  
>>
> 


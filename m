Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7080E1C713A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 May 2020 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgEFNA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 May 2020 09:00:27 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:39120 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgEFNA1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 May 2020 09:00:27 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jWJey-0007Bg-TN; Wed, 06 May 2020 07:00:24 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jWJey-00061w-1F; Wed, 06 May 2020 07:00:24 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87bln2jhki.fsf@x220.int.ebiederm.org>
        <ce5f0c22-675b-cdc8-cd95-976c0e0babee@linux-m68k.org>
Date:   Wed, 06 May 2020 07:56:59 -0500
In-Reply-To: <ce5f0c22-675b-cdc8-cd95-976c0e0babee@linux-m68k.org> (Greg
        Ungerer's message of "Wed, 6 May 2020 22:42:42 +1000")
Message-ID: <87v9l9dxwk.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jWJey-00061w-1F;;;mid=<87v9l9dxwk.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19W5a9a8zm+g2O6M8Y98Fe+NXQMQUxKUZo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Greg Ungerer <gerg@linux-m68k.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 450 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (2.2%), b_tie_ro: 9 (1.9%), parse: 1.16 (0.3%),
         extract_message_metadata: 16 (3.6%), get_uri_detail_list: 2.5 (0.5%),
        tests_pri_-1000: 22 (4.9%), tests_pri_-950: 1.20 (0.3%),
        tests_pri_-900: 0.99 (0.2%), tests_pri_-90: 79 (17.6%), check_bayes:
        77 (17.2%), b_tokenize: 10 (2.3%), b_tok_get_all: 8 (1.8%),
        b_comp_prob: 2.4 (0.5%), b_tok_touch_all: 53 (11.8%), b_finish: 0.89
        (0.2%), tests_pri_0: 301 (67.0%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.1 (0.5%), poll_dns_idle: 0.51 (0.1%), tests_pri_10:
        2.6 (0.6%), tests_pri_500: 12 (2.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/7] binfmt: Move install_exec_creds after setup_new_exec to match binfmt_elf
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Greg Ungerer <gerg@linux-m68k.org> writes:

> One small nit:

Good point.

> On 6/5/20 5:41 am, Eric W. Biederman wrote:
>> In 2016 Linus moved install_exec_creds immediately after
>> setup_new_exec, in binfmt_elf as a cleanup and as part of closing a
>> potential information leak.
>>
>> Perform the same cleanup for the other binary formats.
>>
>> Different binary formats doing the same things the same way makes exec
>> easier to reason about and easier to maintain.
>>
>> The binfmt_flagt bits were tested by Greg Ungerer <gerg@linux-m68k.org>
>              ^^^^^
>              flat
>
> Regards
> Greg
>
>
>> Ref: 9f834ec18def ("binfmt_elf: switch to new creds when switching to new mm")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>   arch/x86/ia32/ia32_aout.c | 3 +--
>>   fs/binfmt_aout.c          | 2 +-
>>   fs/binfmt_elf_fdpic.c     | 2 +-
>>   fs/binfmt_flat.c          | 3 +--
>>   4 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/ia32/ia32_aout.c b/arch/x86/ia32/ia32_aout.c
>> index 9bb71abd66bd..37b36a8ce5fa 100644
>> --- a/arch/x86/ia32/ia32_aout.c
>> +++ b/arch/x86/ia32/ia32_aout.c
>> @@ -140,6 +140,7 @@ static int load_aout_binary(struct linux_binprm *bprm)
>>   	set_personality_ia32(false);
>>     	setup_new_exec(bprm);
>> +	install_exec_creds(bprm);
>>     	regs->cs = __USER32_CS;
>>   	regs->r8 = regs->r9 = regs->r10 = regs->r11 = regs->r12 =
>> @@ -156,8 +157,6 @@ static int load_aout_binary(struct linux_binprm *bprm)
>>   	if (retval < 0)
>>   		return retval;
>>   -	install_exec_creds(bprm);
>> -
>>   	if (N_MAGIC(ex) == OMAGIC) {
>>   		unsigned long text_addr, map_size;
>>   diff --git a/fs/binfmt_aout.c b/fs/binfmt_aout.c
>> index 8e8346a81723..ace587b66904 100644
>> --- a/fs/binfmt_aout.c
>> +++ b/fs/binfmt_aout.c
>> @@ -162,6 +162,7 @@ static int load_aout_binary(struct linux_binprm * bprm)
>>   	set_personality(PER_LINUX);
>>   #endif
>>   	setup_new_exec(bprm);
>> +	install_exec_creds(bprm);
>>     	current->mm->end_code = ex.a_text +
>>   		(current->mm->start_code = N_TXTADDR(ex));
>> @@ -174,7 +175,6 @@ static int load_aout_binary(struct linux_binprm * bprm)
>>   	if (retval < 0)
>>   		return retval;
>>   -	install_exec_creds(bprm);
>>     	if (N_MAGIC(ex) == OMAGIC) {
>>   		unsigned long text_addr, map_size;
>> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
>> index 240f66663543..6c94c6d53d97 100644
>> --- a/fs/binfmt_elf_fdpic.c
>> +++ b/fs/binfmt_elf_fdpic.c
>> @@ -353,6 +353,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>>   		current->personality |= READ_IMPLIES_EXEC;
>>     	setup_new_exec(bprm);
>> +	install_exec_creds(bprm);
>>     	set_binfmt(&elf_fdpic_format);
>>   @@ -434,7 +435,6 @@ static int load_elf_fdpic_binary(struct linux_binprm
>> *bprm)
>>   	current->mm->start_stack = current->mm->start_brk + stack_size;
>>   #endif
>>   -	install_exec_creds(bprm);
>>   	if (create_elf_fdpic_tables(bprm, current->mm,
>>   				    &exec_params, &interp_params) < 0)
>>   		goto error;
>> diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
>> index 831a2b25ba79..1a1d1fcb893f 100644
>> --- a/fs/binfmt_flat.c
>> +++ b/fs/binfmt_flat.c
>> @@ -541,6 +541,7 @@ static int load_flat_file(struct linux_binprm *bprm,
>>   		/* OK, This is the point of no return */
>>   		set_personality(PER_LINUX_32BIT);
>>   		setup_new_exec(bprm);
>> +		install_exec_creds(bprm);
>>   	}
>>     	/*
>> @@ -963,8 +964,6 @@ static int load_flat_binary(struct linux_binprm *bprm)
>>   		}
>>   	}
>>   -	install_exec_creds(bprm);
>> -
>>   	set_binfmt(&flat_format);
>>     #ifdef CONFIG_MMU
>>

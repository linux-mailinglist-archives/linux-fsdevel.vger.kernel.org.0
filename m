Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F87B7AD4DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 11:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjIYJyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 05:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYJyF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:54:05 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E08E8;
        Mon, 25 Sep 2023 02:53:56 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:46656)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qkiHo-0085b5-JY; Mon, 25 Sep 2023 03:53:52 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:44374 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qkiHn-000L9B-C5; Mon, 25 Sep 2023 03:53:52 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sebastian Ott <sebott@redhat.com>
Cc:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net>
        <36e93c8e-4384-b269-be78-479ccc7817b1@redhat.com>
        <87zg1bm5xo.fsf@email.froward.int.ebiederm.org>
        <37d3392c-cf33-20a6-b5c9-8b3fb8142658@redhat.com>
Date:   Mon, 25 Sep 2023 04:50:33 -0500
In-Reply-To: <37d3392c-cf33-20a6-b5c9-8b3fb8142658@redhat.com> (Sebastian
        Ott's message of "Mon, 25 Sep 2023 11:20:51 +0200 (CEST)")
Message-ID: <87ttrimviu.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qkiHn-000L9B-C5;;;mid=<87ttrimviu.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18w5NYq0x4TaF0i1cI2dmUlRdefiwsH+Wc=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Sebastian Ott <sebott@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 615 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 10 (1.7%), b_tie_ro: 9 (1.4%), parse: 1.36 (0.2%),
         extract_message_metadata: 6 (0.9%), get_uri_detail_list: 3.0 (0.5%),
        tests_pri_-2000: 3.7 (0.6%), tests_pri_-1000: 3.0 (0.5%),
        tests_pri_-950: 1.36 (0.2%), tests_pri_-900: 1.10 (0.2%),
        tests_pri_-200: 0.97 (0.2%), tests_pri_-100: 4.8 (0.8%),
        tests_pri_-90: 76 (12.3%), check_bayes: 74 (12.0%), b_tokenize: 12
        (1.9%), b_tok_get_all: 12 (2.0%), b_comp_prob: 4.1 (0.7%),
        b_tok_touch_all: 40 (6.6%), b_finish: 1.15 (0.2%), tests_pri_0: 455
        (74.0%), check_dkim_signature: 0.99 (0.2%), check_dkim_adsp: 4.0
        (0.6%), poll_dns_idle: 1.02 (0.2%), tests_pri_10: 3.3 (0.5%),
        tests_pri_500: 38 (6.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH RFC] binfmt_elf: fully allocate bss pages
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sebastian Ott <sebott@redhat.com> writes:

> On Sun, 24 Sep 2023, Eric W. Biederman wrote:
>> Sebastian Ott <sebott@redhat.com> writes:
>>
>>> Hej,
>>>
>>> since we figured that the proposed patch is not going to work I've spent a
>>> couple more hours looking at this (some static binaries on arm64 segfault
>>> during load [0]). The segfault happens because of a failed clear_user()
>>> call in load_elf_binary(). The address we try to write zeros to is mapped with
>>> correct permissions.
>>>
>>> After some experiments I've noticed that writing to anonymous mappings work
>>> fine and all the error cases happend on file backed VMAs. Debugging showed that
>>> in elf_map() we call vm_mmap() with a file offset of 15 pages - for a binary
>>> that's less than 1KiB in size.
>>>
>>> Looking at the ELF headers again that 15 pages offset originates from the offset
>>> of the 2nd segment - so, I guess the loader did as instructed and that binary is
>>> just too nasty?
>>>
>>> Program Headers:
>>>   Type           Offset             VirtAddr           PhysAddr
>>>                  FileSiz            MemSiz              Flags  Align
>>>   LOAD           0x0000000000000000 0x0000000000400000 0x0000000000400000
>>>                  0x0000000000000178 0x0000000000000178  R E    0x10000
>>>   LOAD           0x000000000000ffe8 0x000000000041ffe8 0x000000000041ffe8
>>>                  0x0000000000000000 0x0000000000000008  RW     0x10000
>>>   NOTE           0x0000000000000120 0x0000000000400120 0x0000000000400120
>>>                  0x0000000000000024 0x0000000000000024  R      0x4
>>>   GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
>>>                  0x0000000000000000 0x0000000000000000  RW     0x10
>>>
>>> As an additional test I've added a bunch of zeros at the end of that binary
>>> so that the offset is within that file and it did load just fine.
>>>
>>> On the other hand there is this section header:
>>>   [ 4] .bss              NOBITS           000000000041ffe8  0000ffe8
>>>        0000000000000008  0000000000000000  WA       0     0     1
>>>
>>> "sh_offset
>>> This member's value gives the byte offset from the beginning of the file to
>>> the first byte in the section. One section type, SHT_NOBITS described
>>> below, occupies no space in the file, and its sh_offset member locates
>>> the conceptual placement in the file.
>>> "
>>>
>>> So, still not sure what to do here..
>>>
>>> Sebastian
>>>
>>> [0] https://lore.kernel.org/lkml/5d49767a-fbdc-fbe7-5fb2-d99ece3168cb@redhat.com/
>>
>> I think that .bss section that is being generated is atrocious.
>>
>> At the same time I looked at what the linux elf loader is trying to do,
>> and the elf loader's handling of program segments with memsz > filesz
>> has serious remnants a.out of programs allocating memory with the brk
>> syscall.
>>
>> Lots of the structure looks like it started with the assumption that
>> there would only be a single program header with memsz > filesz the way
>> and that was the .bss.   The way things were in the a.out days and
>> handling of other cases has been debugged in later.
>>
>> So I have modified elf_map to always return successfully when there is
>> a zero filesz in the program header for an elf segment.
>>
>> Then I have factored out a function clear_tail that ensures the zero
>> padding for an entire elf segment is present.
>>
>> Please test this and see if it causes your test case to work.
>
> Sadly, that causes issues for other programs:

Bah.  Too much cleanup at once.

I will respin.

> [   44.164596] Run /init as init process
> [   44.168763] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [   44.176409] CPU: 32 PID: 1 Comm: init Not tainted 6.6.0-rc2+ #89
> [   44.182404] Hardware name: GIGABYTE R181-T92-00/MT91-FS4-00, BIOS F34 08/13/2020
> [   44.189786] Call trace:
> [   44.192220]  dump_backtrace+0xa4/0x130
> [   44.195961]  show_stack+0x20/0x38
> [   44.199264]  dump_stack_lvl+0x48/0x60
> [   44.202917]  dump_stack+0x18/0x28
> [   44.206219]  panic+0x2e0/0x350
> [   44.209264]  do_exit+0x370/0x390
> [   44.212481]  do_group_exit+0x3c/0xa0
> [   44.216044]  get_signal+0x800/0x808
> [   44.219521]  do_signal+0xfc/0x200
> [   44.222824]  do_notify_resume+0xc8/0x418
> [   44.226734]  el0_da+0x114/0x120
> [   44.229866]  el0t_64_sync_handler+0xb8/0x130
> [   44.234124]  el0t_64_sync+0x194/0x198
> [   44.237776] SMP: stopping secondary CPUs
> [   44.241740] Kernel Offset: disabled
> [   44.245215] CPU features: 0x03000000,14028142,10004203
> [   44.250342] Memory Limit: none
> [   44.253383] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Eric

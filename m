Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF797B36A2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjI2PXs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 11:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbjI2PXr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:23:47 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E481DD6;
        Fri, 29 Sep 2023 08:23:44 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:54204)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qmFLC-00FymL-Go; Fri, 29 Sep 2023 09:23:43 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:54014 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qmFLB-009ZoQ-44; Fri, 29 Sep 2023 09:23:42 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sebastian Ott <sebott@redhat.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20230929031716.it.155-kees@kernel.org>
        <20230929032435.2391507-1-keescook@chromium.org>
        <CAKbZUD3E2if8Sncy+M2YKncc_Zh08-86W6U5wR0ZMazShxbHHA@mail.gmail.com>
Date:   Fri, 29 Sep 2023 10:23:33 -0500
In-Reply-To: <CAKbZUD3E2if8Sncy+M2YKncc_Zh08-86W6U5wR0ZMazShxbHHA@mail.gmail.com>
        (Pedro Falcato's message of "Fri, 29 Sep 2023 13:06:38 +0100")
Message-ID: <87o7hl80lm.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1qmFLB-009ZoQ-44;;;mid=<87o7hl80lm.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18rmihOrcx0Q0L++mXAU7hLrmijYwsrwOA=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Pedro Falcato <pedro.falcato@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 794 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (1.5%), b_tie_ro: 10 (1.3%), parse: 1.28
        (0.2%), extract_message_metadata: 53 (6.6%), get_uri_detail_list: 5
        (0.7%), tests_pri_-2000: 59 (7.4%), tests_pri_-1000: 2.9 (0.4%),
        tests_pri_-950: 1.40 (0.2%), tests_pri_-900: 1.11 (0.1%),
        tests_pri_-200: 0.95 (0.1%), tests_pri_-100: 19 (2.4%), tests_pri_-90:
        107 (13.4%), check_bayes: 90 (11.3%), b_tokenize: 15 (1.9%),
        b_tok_get_all: 15 (1.9%), b_comp_prob: 4.6 (0.6%), b_tok_touch_all: 50
        (6.3%), b_finish: 1.00 (0.1%), tests_pri_0: 518 (65.3%),
        check_dkim_signature: 0.63 (0.1%), check_dkim_adsp: 6 (0.8%),
        poll_dns_idle: 0.61 (0.1%), tests_pri_10: 2.1 (0.3%), tests_pri_500:
        10 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 1/6] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Pedro Falcato <pedro.falcato@gmail.com> writes:

> On Fri, Sep 29, 2023 at 4:24 AM Kees Cook <keescook@chromium.org> wrote:
>>
>> From: "Eric W. Biederman" <ebiederm@xmission.com>
>>
>> Implement a helper elf_load() that wraps elf_map() and performs all
>> of the necessary work to ensure that when "memsz > filesz" the bytes
>> described by "memsz > filesz" are zeroed.
>>
>> An outstanding issue is if the first segment has filesz 0, and has a
>> randomized location. But that is the same as today.
>>
>> In this change I replaced an open coded padzero() that did not clear
>> all of the way to the end of the page, with padzero() that does.
>>
>> I also stopped checking the return of padzero() as there is at least
>> one known case where testing for failure is the wrong thing to do.
>> It looks like binfmt_elf_fdpic may have the proper set of tests
>> for when error handling can be safely completed.
>>
>> I found a couple of commits in the old history
>> https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git,
>> that look very interesting in understanding this code.
>>
>> commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail")
>> commit c6e2227e4a3e ("[SPARC64]: Missing user access return value checks in fs/binfmt_elf.c and fs/compat.c")
>> commit 5bf3be033f50 ("v2.4.10.1 -> v2.4.10.2")
>>
>> Looking at commit 39b56d902bf3 ("[PATCH] binfmt_elf: clearing bss may fail"):
>> >  commit 39b56d902bf35241e7cba6cc30b828ed937175ad
>> >  Author: Pavel Machek <pavel@ucw.cz>
>> >  Date:   Wed Feb 9 22:40:30 2005 -0800
>> >
>> >     [PATCH] binfmt_elf: clearing bss may fail
>> >
>> >     So we discover that Borland's Kylix application builder emits weird elf
>> >     files which describe a non-writeable bss segment.
>> >
>> >     So remove the clear_user() check at the place where we zero out the bss.  I
>> >     don't _think_ there are any security implications here (plus we've never
>> >     checked that clear_user() return value, so whoops if it is a problem).
>> >
>> >     Signed-off-by: Pavel Machek <pavel@suse.cz>
>> >     Signed-off-by: Andrew Morton <akpm@osdl.org>
>> >     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>>
>> It seems pretty clear that binfmt_elf_fdpic with skipping clear_user() for
>> non-writable segments and otherwise calling clear_user(), aka padzero(),
>> and checking it's return code is the right thing to do.
>>
>> I just skipped the error checking as that avoids breaking things.
>>
>> And notably, it looks like Borland's Kylix died in 2005 so it might be
>> safe to just consider read-only segments with memsz > filesz an error.
>>
>> Reported-by: Sebastian Ott <sebott@redhat.com>
>> Reported-by: Thomas Weißschuh <linux@weissschuh.net>
>> Closes: https://lkml.kernel.org/r/20230914-bss-alloc-v1-1-78de67d2c6dd@weissschuh.net
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> Link: https://lore.kernel.org/r/87sf71f123.fsf@email.froward.int.ebiederm.org
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  fs/binfmt_elf.c | 111 +++++++++++++++++++++---------------------------
>>  1 file changed, 48 insertions(+), 63 deletions(-)
>>
>> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
>> index 7b3d2d491407..2a615f476e44 100644
>> --- a/fs/binfmt_elf.c
>> +++ b/fs/binfmt_elf.c
>> @@ -110,25 +110,6 @@ static struct linux_binfmt elf_format = {
>>
>>  #define BAD_ADDR(x) (unlikely((unsigned long)(x) >= TASK_SIZE))
>>
>> -static int set_brk(unsigned long start, unsigned long end, int prot)
>> -{
>> -       start = ELF_PAGEALIGN(start);
>> -       end = ELF_PAGEALIGN(end);
>> -       if (end > start) {
>> -               /*
>> -                * Map the last of the bss segment.
>> -                * If the header is requesting these pages to be
>> -                * executable, honour that (ppc32 needs this).
>> -                */
>> -               int error = vm_brk_flags(start, end - start,
>> -                               prot & PROT_EXEC ? VM_EXEC : 0);
>> -               if (error)
>> -                       return error;
>> -       }
>> -       current->mm->start_brk = current->mm->brk = end;
>> -       return 0;
>> -}
>> -
>>  /* We need to explicitly zero any fractional pages
>>     after the data section (i.e. bss).  This would
>>     contain the junk from the file that should not
>> @@ -406,6 +387,51 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
>>         return(map_addr);
>>  }
>>
>> +static unsigned long elf_load(struct file *filep, unsigned long addr,
>> +               const struct elf_phdr *eppnt, int prot, int type,
>> +               unsigned long total_size)
>> +{
>> +       unsigned long zero_start, zero_end;
>> +       unsigned long map_addr;
>> +
>> +       if (eppnt->p_filesz) {
>> +               map_addr = elf_map(filep, addr, eppnt, prot, type, total_size);
>> +               if (BAD_ADDR(map_addr))
>> +                       return map_addr;
>> +               if (eppnt->p_memsz > eppnt->p_filesz) {
>> +                       zero_start = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
>> +                               eppnt->p_filesz;
>> +                       zero_end = map_addr + ELF_PAGEOFFSET(eppnt->p_vaddr) +
>> +                               eppnt->p_memsz;
>> +
>> +                       /* Zero the end of the last mapped page */
>> +                       padzero(zero_start);
>> +               }
>> +       } else {
>> +               map_addr = zero_start = ELF_PAGESTART(addr);
>> +               zero_end = zero_start + ELF_PAGEOFFSET(eppnt->p_vaddr) +
>> +                       eppnt->p_memsz;
>
> What happens if a previous segment has mapped ELF_PAGESTART(addr)?
> Don't we risk mapping over that?

It is bug of whomever produced the ELF executable.

The architectural page size is known is part of the per architecture
sysv ABI.  Typical it is the same or larger than the hardware page
size.

ELF executables are always mmaped in page sized chunks.  Which makes a
starting offset part-way through a page weird, and a bit awkward, but it
is something the code already attempts to handle.

> Whereas AFAIK old logic would just padzero the bss bytes.

No.  The old logic would either map that region with elf_map, and then
call padzero to zero out the bss bytes, or the old logic would fail if
the file offset was not contained within the file.

The updated logic if "filesz == 0" simply ignores the file offset
and always mmaps /dev/zero instead.  This means that giving a bogus
file offset does not unnecessarily cause an executable to fail.


If the desired behavior is to have file contents and bss on the same
page of data, the generator of the elf program header needs to
have "memsz > filesz".  That is already well supported for everything
except the elf interpreters.

Eric





Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33294A7386
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 15:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbiBBOr0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 09:47:26 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39820 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239800AbiBBOrX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:47:23 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:48348)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nFGun-007XXE-Vf; Wed, 02 Feb 2022 07:47:22 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:53402 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nFGum-00BUj3-V9; Wed, 02 Feb 2022 07:47:21 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Jann Horn <jannh@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Kees Cook <keescook@chromium.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>
References: <20220131153740.2396974-1-willy@infradead.org>
        <871r0nriy4.fsf@email.froward.int.ebiederm.org>
        <YfgKw5z2uswzMVRQ@casper.infradead.org>
        <877dafq3bw.fsf@email.froward.int.ebiederm.org>
        <YfgPwPvopO1aqcVC@casper.infradead.org>
        <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
        <87bkzroica.fsf_-_@email.froward.int.ebiederm.org>
        <87iltzn3nd.fsf_-_@email.froward.int.ebiederm.org>
        <CAG48ez3zfi1eHAgGPPEC=pB3oMUBif28Ns4qncUbxpCbMPYdgA@mail.gmail.com>
Date:   Wed, 02 Feb 2022 08:46:22 -0600
In-Reply-To: <CAG48ez3zfi1eHAgGPPEC=pB3oMUBif28Ns4qncUbxpCbMPYdgA@mail.gmail.com>
        (Jann Horn's message of "Tue, 1 Feb 2022 20:02:54 +0100")
Message-ID: <87wnidl41t.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nFGum-00BUj3-V9;;;mid=<87wnidl41t.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19+3fQZJhoRZ5kCJCpZEfNeAZFufd3xf8A=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Jann Horn <jannh@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 459 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (2.8%), b_tie_ro: 11 (2.4%), parse: 1.38
        (0.3%), extract_message_metadata: 22 (4.8%), get_uri_detail_list: 3.2
        (0.7%), tests_pri_-1000: 32 (6.9%), tests_pri_-950: 1.49 (0.3%),
        tests_pri_-900: 1.10 (0.2%), tests_pri_-90: 110 (24.0%), check_bayes:
        107 (23.4%), b_tokenize: 8 (1.8%), b_tok_get_all: 9 (2.0%),
        b_comp_prob: 2.7 (0.6%), b_tok_touch_all: 83 (18.1%), b_finish: 0.95
        (0.2%), tests_pri_0: 265 (57.8%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.6 (0.6%), poll_dns_idle: 0.39 (0.1%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 7 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 5/5] coredump: Use the vma snapshot in fill_files_note
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jann Horn <jannh@google.com> writes:

> On Mon, Jan 31, 2022 at 7:47 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Matthew Wilcox reported that there is a missing mmap_lock in
>> file_files_note that could possibly lead to a user after free.
>>
>> Solve this by using the existing vma snapshot for consistency
>> and to avoid the need to take the mmap_lock anywhere in the
>> coredump code except for dump_vma_snapshot.
>>
>> Update the dump_vma_snapshot to capture vm_pgoff and vm_file
>> that are neeeded by fill_files_note.
>>
>> Add free_vma_snapshot to free the captured values of vm_file.
>>
>> Reported-by: Matthew Wilcox <willy@infradead.org>
>> Link: https://lkml.kernel.org/r/20220131153740.2396974-1-willy@infradead.org
>> Cc: stable@vger.kernel.org
>> Fixes: a07279c9a8cd ("binfmt_elf, binfmt_elf_fdpic: use a VMA list snapshot")
>> Fixes: 2aa362c49c31 ("coredump: extend core dump note section to contain file names of mapped files")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> [...]
>> +static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm)
>>  {
>>         struct mm_struct *mm = current->mm;
>> -       struct vm_area_struct *vma;
>>         unsigned count, size, names_ofs, remaining, n;
>>         user_long_t *data;
>>         user_long_t *start_end_ofs;
>>         char *name_base, *name_curpos;
>> +       int i;
>>
>>         /* *Estimated* file count and total data size needed */
>>         count = mm->map_count;
>
> This function is still looking at mm->map_count in two spots, please
> change those spots to also look at cprm->vma_count. In particular the
> second one looks like it can cause memory corruption if the map_count
> changed since we created the snapshot.

Could catch I will fix that.  Correcting it not to use mm->map_count
looks like a fundamental part of the fix, and I missed it.  Oops!

> [...]
>> +static void free_vma_snapshot(struct coredump_params *cprm)
>> +{
>> +       if (cprm->vma_meta) {
>> +               int i;
>> +               for (i = 0; i < cprm->vma_count; i++) {
>> +                       struct file *file = cprm->vma_meta[i].file;
>> +                       if (file)
>> +                               fput(file);
>> +               }
>> +               kvfree(cprm->vma_meta);
>> +               cprm->vma_meta = NULL;
>
> (this NULL write is superfluous, but it also doesn't hurt)

Agreed.  It just makes the possible failure modes nicer.

Eric

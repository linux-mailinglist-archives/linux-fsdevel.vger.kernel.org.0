Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85C22CC0B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 16:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgLBPV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 10:21:26 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50228 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgLBPVX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 10:21:23 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kkTvs-005EKS-NX; Wed, 02 Dec 2020 08:20:40 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kkTvr-007fWp-J7; Wed, 02 Dec 2020 08:20:40 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Geoff Levand <geoff@infradead.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
        <20201120231441.29911-2-ebiederm@xmission.com>
        <20201123175052.GA20279@redhat.com>
        <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
        <87im9vx08i.fsf@x220.int.ebiederm.org>
        <87pn42r0n7.fsf@x220.int.ebiederm.org>
        <CAHk-=wi-h8y5MK83DA6Vz2TDSQf4eEadddhWLTT_94bP996=Ug@mail.gmail.com>
        <CAK8P3a3z1tZSSSyK=tZOkUTqXvewJgd6ntHMysY0gGQ7hPWwfw@mail.gmail.com>
        <ed83033f-80af-5be0-ecbe-f2bf5c2075e9@infradead.org>
        <87h7pdnlzv.fsf_-_@x220.int.ebiederm.org>
Date:   Wed, 02 Dec 2020 09:20:08 -0600
In-Reply-To: <87h7pdnlzv.fsf_-_@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Wed, 25 Nov 2020 15:51:32 -0600")
Message-ID: <87sg8ock0n.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kkTvr-007fWp-J7;;;mid=<87sg8ock0n.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18exXwqMrqZDqUxJs2IpoxEwxHuDiF20pM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_XMDrugObfuBody_08,XMSubLong,XM_B_SpammyWords autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Geoff Levand <geoff@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 504 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.1 (0.8%), b_tie_ro: 2.7 (0.5%), parse: 0.72
        (0.1%), extract_message_metadata: 11 (2.2%), get_uri_detail_list: 1.84
        (0.4%), tests_pri_-1000: 12 (2.3%), tests_pri_-950: 1.04 (0.2%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 169 (33.5%), check_bayes:
        162 (32.1%), b_tokenize: 7 (1.4%), b_tok_get_all: 9 (1.7%),
        b_comp_prob: 1.97 (0.4%), b_tok_touch_all: 141 (28.1%), b_finish: 0.69
        (0.1%), tests_pri_0: 296 (58.6%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.94 (0.2%), tests_pri_10:
        1.75 (0.3%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] coredump: Document coredump code exclusively used by cell spufs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Oleg Nesterov recently asked[1] why is there an unshare_files in
> do_coredump.  After digging through all of the callers of lookup_fd it
> turns out that it is
> arch/powerpc/platforms/cell/spufs/coredump.c:coredump_next_context
> that needs the unshare_files in do_coredump.
>
> Looking at the history[2] this code was also the only piece of coredump code
> that required the unshare_files when the unshare_files was added.
>
> Looking at that code it turns out that cell is also the only
> architecture that implements elf_coredump_extra_notes_size and
> elf_coredump_extra_notes_write.
>
> I looked at the gdb repo[3] support for cell has been removed[4] in binutils
> 2.34.  Geoff Levand reports he is still getting questions on how to
> run modern kernels on the PS3, from people using 3rd party firmware so
> this code is not dead.  According to Wikipedia the last PS3 shipped in
> Japan sometime in 2017.  So it will probably be a little while before
> everyone's hardware dies.
>
> Add some comments briefly documenting the coredump code that exists
> only to support cell spufs to make it easier to understand the
> coredump code.  Eventually the hardware will be dead, or their won't
> be userspace tools, or the coredump code will be refactored and it
> will be too difficult to update a dead architecture and these comments
> make it easy to tell where to pull to remove cell spufs support.
>
> [1] https://lkml.kernel.org/r/20201123175052.GA20279@redhat.com
> [2] 179e037fc137 ("do_coredump(): make sure that descriptor table isn't shared")
> [3] git://sourceware.org/git/binutils-gdb.git
> [4] abf516c6931a ("Remove Cell Broadband Engine debugging support").
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
>
> Does this change look good to people?  I think it captures this state of
> things and makes things clearer without breaking anything or removing
> functionality for anyone.

I haven't heard anything except a general ack to the concept of
comments.  So I am applying this.

Eric

>
>  fs/binfmt_elf.c | 2 ++
>  fs/coredump.c   | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index b6b3d052ca86..c1996f0aeaed 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -2198,6 +2198,7 @@ static int elf_core_dump(struct coredump_params *cprm)
>  	{
>  		size_t sz = get_note_info_size(&info);
>  
> +		/* For cell spufs */
>  		sz += elf_coredump_extra_notes_size();
>  
>  		phdr4note = kmalloc(sizeof(*phdr4note), GFP_KERNEL);
> @@ -2261,6 +2262,7 @@ static int elf_core_dump(struct coredump_params *cprm)
>  	if (!write_note_info(&info, cprm))
>  		goto end_coredump;
>  
> +	/* For cell spufs */
>  	if (elf_coredump_extra_notes_write(cprm))
>  		goto end_coredump;
>  
> diff --git a/fs/coredump.c b/fs/coredump.c
> index abf807235262..3ff17eea812e 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -790,6 +790,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  	}
>  
>  	/* get us an unshared descriptor table; almost always a no-op */
> +	/* The cell spufs coredump code reads the file descriptor tables */
>  	retval = unshare_files();
>  	if (retval)
>  		goto close_fail;

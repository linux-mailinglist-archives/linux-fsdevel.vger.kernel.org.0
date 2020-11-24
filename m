Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132622C2FFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 19:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404104AbgKXSdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 13:33:25 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:53452 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390872AbgKXSdY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 13:33:24 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1khd7y-00CpWM-N7; Tue, 24 Nov 2020 11:33:22 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1khd7w-005yjH-BE; Tue, 24 Nov 2020 11:33:22 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>
References: <20201123063835.18981-1-miles.chen@mediatek.com>
Date:   Tue, 24 Nov 2020 12:32:56 -0600
In-Reply-To: <20201123063835.18981-1-miles.chen@mediatek.com> (Miles Chen's
        message of "Mon, 23 Nov 2020 14:38:35 +0800")
Message-ID: <87lfeqsizr.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1khd7w-005yjH-BE;;;mid=<87lfeqsizr.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/cWINijvy8cfZD9GCnZGUD9VbnS+lLulo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3842]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miles Chen <miles.chen@mediatek.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1552 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (0.7%), b_tie_ro: 10 (0.6%), parse: 1.58
        (0.1%), extract_message_metadata: 15 (1.0%), get_uri_detail_list: 3.5
        (0.2%), tests_pri_-1000: 4.7 (0.3%), tests_pri_-950: 1.31 (0.1%),
        tests_pri_-900: 1.00 (0.1%), tests_pri_-90: 390 (25.1%), check_bayes:
        371 (23.9%), b_tokenize: 9 (0.6%), b_tok_get_all: 7 (0.4%),
        b_comp_prob: 2.3 (0.2%), b_tok_touch_all: 349 (22.5%), b_finish: 0.95
        (0.1%), tests_pri_0: 408 (26.3%), check_dkim_signature: 1.51 (0.1%),
        check_dkim_adsp: 25 (1.6%), poll_dns_idle: 716 (46.1%), tests_pri_10:
        2.5 (0.2%), tests_pri_500: 714 (46.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RESEND PATCH v1] proc: use untagged_addr() for pagemap_read addresses
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miles Chen <miles.chen@mediatek.com> writes:

> When we try to visit the pagemap of a tagged userspace pointer, we find
> that the start_vaddr is not correct because of the tag.
> To fix it, we should untag the usespace pointers in pagemap_read().
>
> I tested with 5.10-rc4 and the issue remains.
>
> My test code is baed on [1]:
>
> A userspace pointer which has been tagged by 0xb4: 0xb400007662f541c8


Sigh this patch is buggy.

> === userspace program ===
>
> uint64 OsLayer::VirtualToPhysical(void *vaddr) {
> 	uint64 frame, paddr, pfnmask, pagemask;
> 	int pagesize = sysconf(_SC_PAGESIZE);
> 	off64_t off = ((uintptr_t)vaddr) / pagesize * 8; // off = 0xb400007662f541c8 / pagesize * 8 = 0x5a00003b317aa0
> 	int fd = open(kPagemapPath, O_RDONLY);
> 	...
>
> 	if (lseek64(fd, off, SEEK_SET) != off || read(fd, &frame, 8) != 8) {
> 		int err = errno;
> 		string errtxt = ErrorString(err);
> 		if (fd >= 0)
> 			close(fd);
> 		return 0;
> 	}
> ...
> }
>
> === kernel fs/proc/task_mmu.c ===
>
> static ssize_t pagemap_read(struct file *file, char __user *buf,
> 		size_t count, loff_t *ppos)
> {
> 	...
> 	src = *ppos;
> 	svpfn = src / PM_ENTRY_BYTES; // svpfn == 0xb400007662f54
> 	start_vaddr = svpfn << PAGE_SHIFT; // start_vaddr == 0xb400007662f54000
> 	end_vaddr = mm->task_size;
>
> 	/* watch out for wraparound */
> 	// svpfn == 0xb400007662f54
> 	// (mm->task_size >> PAGE) == 0x8000000
> 	if (svpfn > mm->task_size >> PAGE_SHIFT) // the condition is true because of the tag 0xb4
> 		start_vaddr = end_vaddr;
>
> 	ret = 0;
> 	while (count && (start_vaddr < end_vaddr)) { // we cannot visit correct entry because start_vaddr is set to end_vaddr
> 		int len;
> 		unsigned long end;
> 		...
> 	}
> 	...
> }
>
> [1] https://github.com/stressapptest/stressapptest/blob/master/src/os.cc#L158
>
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>  fs/proc/task_mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 217aa2705d5d..e9a70f7ee515 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1599,11 +1599,11 @@ static ssize_t pagemap_read(struct file *file, char __user *buf,
>  
>  	src = *ppos;
>  	svpfn = src / PM_ENTRY_BYTES;

> -	start_vaddr = svpfn << PAGE_SHIFT;
> +	start_vaddr = untagged_addr(svpfn << PAGE_SHIFT);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Arguably the line above is safe, but unfortunately it has the
possibility of suffering from overflow.

>  	end_vaddr = mm->task_size;
>  
>  	/* watch out for wraparound */
> -	if (svpfn > mm->task_size >> PAGE_SHIFT)
> +	if (start_vaddr > mm->task_size)
>  		start_vaddr = end_vaddr;

Overflow handling you are removing here.
>  
>  	/*


I suspect the proper way to handle this is to move the test for
overflow earlier so the code looks something like:

	end_vaddr = mm->task_size;

	src = *ppos;
	svpfn = src / PM_ENTRY_BYTES;

	/* watch out for wraparound */
        start_vaddr = end_vaddr;
	if (svpfn < (ULONG_MAX >> PAGE_SHIFT))
        	start_vaddr = untagged_addr(svpfn << PAGE_SHIFT);

	/* Ensure the address is inside the task */
	if (start_vaddr > mm->task_size)
        	start_vaddr = end_vaddr;

Eric


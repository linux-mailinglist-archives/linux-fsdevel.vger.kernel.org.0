Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A609F230BA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 15:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgG1NmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 09:42:13 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:48638 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbgG1NmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 09:42:13 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1k0Prq-0006Yc-M5; Tue, 28 Jul 2020 07:42:06 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k0Prp-0008Po-SX; Tue, 28 Jul 2020 07:42:06 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com,
        steven.sistare@oracle.com
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
        <1595869887-23307-4-git-send-email-anthony.yznaga@oracle.com>
Date:   Tue, 28 Jul 2020 08:38:58 -0500
In-Reply-To: <1595869887-23307-4-git-send-email-anthony.yznaga@oracle.com>
        (Anthony Yznaga's message of "Mon, 27 Jul 2020 10:11:25 -0700")
Message-ID: <87365bg3nx.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k0Prp-0008Po-SX;;;mid=<87365bg3nx.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+1Sfes+daOU7hTlu4id0xK0fRE/vl7XQ8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Anthony Yznaga <anthony.yznaga@oracle.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 418 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.6%), b_tie_ro: 9 (2.2%), parse: 1.09 (0.3%),
         extract_message_metadata: 3.7 (0.9%), get_uri_detail_list: 1.29
        (0.3%), tests_pri_-1000: 4.4 (1.0%), tests_pri_-950: 1.33 (0.3%),
        tests_pri_-900: 1.15 (0.3%), tests_pri_-90: 79 (18.8%), check_bayes:
        76 (18.2%), b_tokenize: 8 (2.0%), b_tok_get_all: 7 (1.6%),
        b_comp_prob: 2.6 (0.6%), b_tok_touch_all: 54 (12.9%), b_finish: 1.29
        (0.3%), tests_pri_0: 283 (67.8%), check_dkim_signature: 0.76 (0.2%),
        check_dkim_adsp: 3.8 (0.9%), poll_dns_idle: 0.52 (0.1%), tests_pri_10:
        3.7 (0.9%), tests_pri_500: 21 (5.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 3/5] mm: introduce VM_EXEC_KEEP
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Anthony Yznaga <anthony.yznaga@oracle.com> writes:

> A vma with the VM_EXEC_KEEP flag is preserved across exec.  For anonymous
> vmas only.  For safety, overlap with fixed address VMAs created in the new
> mm during exec (e.g. the stack and elf load segments) is not permitted and
> will cause the exec to fail.
> (We are studying how to guarantee there are no conflicts. Comments welcome.)
>

> diff --git a/fs/exec.c b/fs/exec.c
> index 262112e5f9f8..1de09c4eef00 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1069,6 +1069,20 @@ ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
>  EXPORT_SYMBOL(read_code);
>  #endif
>  
> +static int vma_dup_some(struct mm_struct *old_mm, struct mm_struct *new_mm)
> +{
> +	struct vm_area_struct *vma;
> +	int ret;
> +
> +	for (vma = old_mm->mmap; vma; vma = vma->vm_next)
> +		if (vma->vm_flags & VM_EXEC_KEEP) {
> +			ret = vma_dup(vma, new_mm);
> +			if (ret)
> +				return ret;
> +		}
> +	return 0;
> +}
> +
>  /*
>   * Maps the mm_struct mm into the current task struct.
>   * On success, this function returns with the mutex
> @@ -1104,6 +1118,12 @@ static int exec_mmap(struct mm_struct *mm)
>  			mutex_unlock(&tsk->signal->exec_update_mutex);
>  			return -EINTR;
>  		}
> +		ret = vma_dup_some(old_mm, mm);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ouch! An unconditional loop through all of the vmas of the execing
process, just in case there is a VM_EXEC_KEEP vma.

I know we already walk the list in exit_mmap, but I get the feeling this
will slow exec down when this feature is not enabled, especially when
a process with a lot of vmas is calling exec.

                
> +		if (ret) {
> +			mmap_read_unlock(old_mm);
> +			mutex_unlock(&tsk->signal->exec_update_mutex);
> +			return ret;
> +		}
>  	}
>  
>  	task_lock(tsk);

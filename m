Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098F93465A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 17:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhCWQtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 12:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhCWQtX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:49:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8B8C061574;
        Tue, 23 Mar 2021 09:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=zsWUChpUzdyyXAnKfXL0ouDcOEMmm/9rEethWKfPjz8=; b=vEL4bbC/Jxk/aJHjrDr4zv0gw/
        7xKgFDlEoY6YM6CJEd/JF6DBP7Z/KWMZcmDQlNviBJ+TB+shHR9lRjzu5rW1jkhzifEOz7aI/GjVt
        90ekrEfBIfR2OpFrb1GCm8ND+hRkNd/C1SXsChV5TY1J8/dPWGkDQtu7Ra/iNOtPrgByCiQm5zWlN
        trEVbueUvBtDlxH+kaF5/w0N0hKN5Qf5OXndL6FBtbThWCoJibHIEbM0duicOJIO0FQJd8LJTiT+Q
        EOjxIB/P/DBrnmNWfMZPgjeoakePbbCMLRNhcUsUoGRtbjY/uhA5U3mWLySyrHAsut6mzWjDrzNN3
        v1YfDERQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOkCl-00AIu2-8i; Tue, 23 Mar 2021 16:48:36 +0000
Subject: Re: [PATCH v2] fs/exec: fix typos and sentence disorder
To:     Xiaofeng Cao <cxfcosmos@gmail.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaofeng Cao <caoxiaofeng@yulong.com>
References: <20210323074212.15444-1-caoxiaofeng@yulong.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1a4f3de7-54a6-6ef9-ce41-4abbf05fe0d3@infradead.org>
Date:   Tue, 23 Mar 2021 09:48:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323074212.15444-1-caoxiaofeng@yulong.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/23/21 12:42 AM, Xiaofeng Cao wrote:
> change 'backwords' to 'backwards'
> change 'and argument' to 'an argument'
> change 'visibile' to 'visible'
> change 'wont't' to 'won't'
> reorganize sentence
> 
> Signed-off-by: Xiaofeng Cao <caoxiaofeng@yulong.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> v2: resume the right boundary
>  fs/exec.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 18594f11c31f..5e23101f9259 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -536,7 +536,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
>  		if (!valid_arg_len(bprm, len))
>  			goto out;
>  
> -		/* We're going to work our way backwords. */
> +		/* We're going to work our way backwards. */
>  		pos = bprm->p;
>  		str += len;
>  		bprm->p -= len;
> @@ -603,7 +603,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
>  }
>  
>  /*
> - * Copy and argument/environment string from the kernel to the processes stack.
> + * Copy an argument/environment string from the kernel to the processes stack.
>   */
>  int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
>  {
> @@ -718,9 +718,9 @@ static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
>  	} else {
>  		/*
>  		 * otherwise, clean from old_start; this is done to not touch
> -		 * the address space in [new_end, old_start) some architectures
> +		 * the address space in [new_end, old_start). Some architectures
>  		 * have constraints on va-space that make this illegal (IA64) -
> -		 * for the others its just a little faster.
> +		 * for the others it's just a little faster.
>  		 */
>  		free_pgd_range(&tlb, old_start, old_end, new_end,
>  			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
> @@ -1120,7 +1120,7 @@ static int de_thread(struct task_struct *tsk)
>  		 */
>  
>  		/* Become a process group leader with the old leader's pid.
> -		 * The old leader becomes a thread of the this thread group.
> +		 * The old leader becomes a thread of this thread group.
>  		 */
>  		exchange_tids(tsk, leader);
>  		transfer_pid(leader, tsk, PIDTYPE_TGID);
> @@ -1142,7 +1142,7 @@ static int de_thread(struct task_struct *tsk)
>  		/*
>  		 * We are going to release_task()->ptrace_unlink() silently,
>  		 * the tracer can sleep in do_wait(). EXIT_DEAD guarantees
> -		 * the tracer wont't block again waiting for this thread.
> +		 * the tracer won't block again waiting for this thread.
>  		 */
>  		if (unlikely(leader->ptrace))
>  			__wake_up_parent(leader, leader->parent);
> @@ -1270,7 +1270,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>  
>  	/*
>  	 * Must be called _before_ exec_mmap() as bprm->mm is
> -	 * not visibile until then. This also enables the update
> +	 * not visible until then. This also enables the update
>  	 * to be lockless.
>  	 */
>  	set_mm_exe_file(bprm->mm, bprm->file);
> 


-- 
~Randy


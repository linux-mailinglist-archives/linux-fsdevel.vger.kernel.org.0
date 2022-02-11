Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EB74B2B70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Feb 2022 18:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351954AbiBKRMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 12:12:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344689AbiBKRMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:12:32 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2652621F;
        Fri, 11 Feb 2022 09:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=0evjDNoKi99keN6XHrmd5QB7BOODu4KyQguckMpbh8s=; b=ulZ45u0tXlg3DtFL/f3rcFX5Xu
        wIXyQy4oO6lh0qXb7hlQ4xWdVemLCUl0v9E9mwRNXSOSE4hAblmsgN8mDiRfDtvm2FWnQhGtY3GnL
        FfA9zyzkXFSXA7lpVm1tyjDwYRR/S3yGWOhgF7SDW7fkiQHJwO39bB27n5OPYL2hiAkFUxCXsXDTH
        iSS+WrkvXPv62l6HjAUEP5RBT+BHFucIkc6mLZwV40VPD66R4yIOcf5JBfmk1m0UA30iR98cuoTKX
        1NOBkH4LIRWpy7T52r6crS+3mMyori0oO0enXADk64INILvAR5uEXDWVl69IwEqPZbQirbu1/uZBL
        91V81p9A==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIZT0-00AaM3-0L; Fri, 11 Feb 2022 17:12:18 +0000
Message-ID: <6742c55a-59e5-80db-5490-07cec141f580@infradead.org>
Date:   Fri, 11 Feb 2022 09:12:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] exec: cleanup comments
Content-Language: en-US
To:     trix@redhat.com, ebiederm@xmission.com, keescook@chromium.org,
        viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220211160940.2516243-1-trix@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220211160940.2516243-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2/11/22 08:09, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Remove the second 'from'.
> Replace 'backwords' with 'backwards'.
> Replace 'visibile' with 'visible'.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  fs/exec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 40b1008fb0f7..8256e8bb9ad3 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -118,7 +118,7 @@ bool path_noexec(const struct path *path)
>   * Note that a shared library must be both readable and executable due to
>   * security reasons.
>   *
> - * Also note that we take the address to load from from the file itself.
> + * Also note that we take the address to load from the file itself.
>   */
>  SYSCALL_DEFINE1(uselib, const char __user *, library)
>  {
> @@ -542,7 +542,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
>  		if (!valid_arg_len(bprm, len))
>  			goto out;
>  
> -		/* We're going to work our way backwords. */
> +		/* We're going to work our way backwards. */
>  		pos = bprm->p;
>  		str += len;
>  		bprm->p -= len;
> @@ -1275,7 +1275,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>  
>  	/*
>  	 * Must be called _before_ exec_mmap() as bprm->mm is
> -	 * not visibile until then. This also enables the update
> +	 * not visible until then. This also enables the update
>  	 * to be lockless.
>  	 */
>  	retval = set_mm_exe_file(bprm->mm, bprm->file);

-- 
~Randy

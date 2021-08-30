Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632B83FB7CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Aug 2021 16:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237108AbhH3OUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Aug 2021 10:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbhH3OUf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Aug 2021 10:20:35 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7637DC061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Aug 2021 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=8P+M7Kcpb8BjL2dOgaMdKaHH7cpc2nc+QseSotQ7Yfg=; b=kujLvHK8/NBbIiZzbaxPVBSAlv
        dd6Wi3WDzwY2LelHZie/1mj2dd3UJimkTZQnjS+1lPZkWuCnCg+efrph49bkFWUahiVRSuZvLsd6a
        Cy+l215xMhFD8uvTXUUlkxx9ZlFI9LC/flN6ccwuNt3X5xs6tDcmFDOYsTCKFIzkbnSqHMqUkQfCP
        H8hjUFo984mLg5LEYOi/G1Yx9sM+ZDLBd8OmMVk4xcFzXChc68qDsRehqVJxVlz2dNy34Pn9LtEWe
        LEJ3ihvwa7qVnFmjkmWPj4PzC79+1bS1aX927Pm57rOryNgbR2DM2e0ebqsYiierjg3Khy9C95w6c
        6Pqqoc4Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKi8R-00HQUh-Aw; Mon, 30 Aug 2021 14:19:39 +0000
Subject: Re: [PATCH v2 1/1] exec: fix typo and grammar mistake in comment
To:     Adrian Huang <adrianhuang0701@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Adrian Huang <ahuang12@lenovo.com>
References: <20210830074406.789-1-adrianhuang0701@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <02c0abd5-8776-ba0a-cb76-897e2406ceb0@infradead.org>
Date:   Mon, 30 Aug 2021 07:19:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210830074406.789-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/30/21 12:44 AM, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> 1. backwords -> backwards
> 2. Remove 'and' and whitespace
> 3. Correct the possessive form of "process"
> 
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes since v2:
>   * Correct possessive form of "process" and fix the grammar, per Randy
> 
>   fs/exec.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 38f63451b928..d0e20fedde21 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -504,7 +504,7 @@ static int bprm_stack_limits(struct linux_binprm *bprm)
>   
>   /*
>    * 'copy_strings()' copies argument/environment strings from the old
> - * processes's memory to the new process's stack.  The call to get_user_pages()
> + * process's memory to the new process's stack. The call to get_user_pages()
>    * ensures the destination page is created and not swapped out.
>    */
>   static int copy_strings(int argc, struct user_arg_ptr argv,
> @@ -533,7 +533,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
>   		if (!valid_arg_len(bprm, len))
>   			goto out;
>   
> -		/* We're going to work our way backwords. */
> +		/* We're going to work our way backwards. */
>   		pos = bprm->p;
>   		str += len;
>   		bprm->p -= len;
> @@ -600,7 +600,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
>   }
>   
>   /*
> - * Copy and argument/environment string from the kernel to the processes stack.
> + * Copy an argument/environment string from the kernel to the process's stack.
>    */
>   int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
>   {
> 


-- 
~Randy


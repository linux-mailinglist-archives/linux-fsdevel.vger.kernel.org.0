Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B053F80EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 05:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhHZD2i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Aug 2021 23:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhHZD2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Aug 2021 23:28:38 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7579C061757
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Aug 2021 20:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=GVMtig/2m2YtLuLS208VOK3rAuEDmdlwDCSA3o6KDC4=; b=yEynP/DF1IAjKleSzXMRGgbnte
        noQASjp5tUUD9uOw4w4Zibv2A42HSyIxE40+zc5Gax+sDFR9xV4czSC+HWG9c+VCTzbcljTEXBLYe
        ivOjs+2BjJyUCXX1AghCpz+5XlhaT1IRn7IaJpHx41o8OqAuQKqNKK2/yXGLIy1KeCp5hGgOojMDB
        N9VkmBuFi95ZpQOeAsOnvQwiXIGchi7hXostvSnkXGemWiSgYeHw3ad2qqCwJu/MWvPlo1/eLUBEb
        Pmodq4u9zxjWS+/F9dfmyIZMIkkXCxP4ihaSv1HlM9RjH1c2XsvYzPZHpXN2xdR71JUZeHRuJmAKo
        /XcJV01w==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mJ63Q-0093hs-Cn; Thu, 26 Aug 2021 03:27:48 +0000
Subject: Re: [PATCH 1/1] exec: fix typo and grammar mistake in comment
To:     Adrian Huang <adrianhuang0701@gmail.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Adrian Huang <ahuang12@lenovo.com>
References: <20210826031451.611-1-adrianhuang0701@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eb28d8e8-3e7d-0120-a1a7-6e43b0bb05bb@infradead.org>
Date:   Wed, 25 Aug 2021 20:27:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210826031451.611-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/25/21 8:14 PM, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> 1. backwords -> backwards
> 2. Remove 'and'

   3. correct the possessive form of "process"

> 
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>   fs/exec.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 38f63451b928..7178aee0d781 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -533,7 +533,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
>   		if (!valid_arg_len(bprm, len))
>   			goto out;
>   
> -		/* We're going to work our way backwords. */

That could just be a pun. Maybe Al knows...

> +		/* We're going to work our way backwards. */
>   		pos = bprm->p;
>   		str += len;
>   		bprm->p -= len;
> @@ -600,7 +600,7 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
>   }
>   
>   /*
> - * Copy and argument/environment string from the kernel to the processes stack.
> + * Copy argument/environment strings from the kernel to the processe's stack.

Either process's stack or process' stack. Not what is typed there.
I prefer process's, just as this reference does:
   https://forum.wordreference.com/threads/process-or-processs.1704502/

>    */
>   int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
>   {
> 


-- 
~Randy


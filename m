Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E069459D05F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 07:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbiHWFQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 01:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238895AbiHWFQu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:16:50 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C16D4B499
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 22:16:49 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id f17so6269564pfk.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 22:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=fqQOcGIshToSvQyhg21sF8soYRf73aWYmaMl0SScXX8=;
        b=jfAymrwMpKfjsZ+XaXEKdwl6twDtg/hmhvKq1Jir4CguTo3+TfH+1q4m+0tTFqVfk1
         njDDmUkQbPUgvXU1VLRs70Sj5X7h1E/GnVisiwT7DqwwcvnxOtNEvmOBBfN6lPk3XM3E
         S6jYGKcooxt81Gk6YGjM1YwA+L3UNoPgDjv4f1YfpZaqZC+QY9Yp7B6+UtZZJDzZOLBZ
         uXvnQBriHipFKg/xJ9P8RhtQP+S98duAOVQaE/vn0Bi2Hv8COyXH6dsGSAoU+1d8sCIc
         1BrZ/p8oznLbtst0agaOqQidANETSRFUXk4TZL+0BF64rqg8xN15lNwEglB6lMGVa53y
         1EYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fqQOcGIshToSvQyhg21sF8soYRf73aWYmaMl0SScXX8=;
        b=re8w8CQNFdnTTxjyt1J7dQrH0N2vz7H0xqSB0BAuAJiGycHx8jOpyHqF/KYuwgZ4Gz
         Psaml6h7Bzz1ajKpMkxaOLl6yxzLT6C4F4kqzI7eGNLwD+YavlV7CBy6Ht8+UHPAWWSj
         MBanSuEhsxSTAiZSCBOCRUhFYFT7RPMTpEbp89zIbV7JM5KaYPkUWKMA3AClTr+QqfcA
         EWeHwSOx9f2vE1aNI1GAKzyM/DZXfcmI+Qn9nGIv9uf15PXCeEGpKvwaGJadgyU5mMbg
         YVjNcPsvqREYXaff8LEy7dVS9sGeZyCMLKKZjNFyk9SQXSPdkgmvQCZtazRoxmGb7HCk
         VrBQ==
X-Gm-Message-State: ACgBeo3NX11XtbrkEIrVlHOSN0+0MEkTSykFsTdc+3tQbvFA4Q9BAF20
        Y9q6Hw6l/5oLPxp0tEdZZat6sA==
X-Google-Smtp-Source: AA6agR4raQSAdD2MaqXbzBs6ck8VUdeRq4+xUzKmuW8KZKX/8ROBPIxYPkeEa+Q2H+QORYNELjEXjQ==
X-Received: by 2002:a63:43c7:0:b0:429:7abb:aaf7 with SMTP id q190-20020a6343c7000000b004297abbaaf7mr19189184pga.204.1661231808443;
        Mon, 22 Aug 2022 22:16:48 -0700 (PDT)
Received: from [10.4.208.12] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902cec900b00172973d3cd9sm9419880plg.55.2022.08.22.22.16.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 22:16:48 -0700 (PDT)
Message-ID: <fbc77b9b-62f1-f356-c91b-c1c9d160d9e8@bytedance.com>
Date:   Tue, 23 Aug 2022 13:16:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH 3/7] kernfs: Refactor kernfs_get_open_node()
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com
References: <20220820000550.367085-1-tj@kernel.org>
 <20220820000550.367085-4-tj@kernel.org>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220820000550.367085-4-tj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/8/20 08:05, Tejun Heo wrote:
> Factor out commont part. This is cleaner and should help with future
> changes. No functional changes.
> 

Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>

Thanks.

> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  fs/kernfs/file.c | 25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index 6437f7c7162d..7060a2a714b8 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -554,31 +554,28 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
>  static int kernfs_get_open_node(struct kernfs_node *kn,
>  				struct kernfs_open_file *of)
>  {
> -	struct kernfs_open_node *on, *new_on = NULL;
> +	struct kernfs_open_node *on;
>  	struct mutex *mutex;
>  
>  	mutex = kernfs_open_file_mutex_lock(kn);
>  	on = kernfs_deref_open_node_locked(kn);
>  
> -	if (on) {
> -		list_add_tail(&of->list, &on->files);
> -		mutex_unlock(mutex);
> -		return 0;
> -	} else {
> +	if (!on) {
>  		/* not there, initialize a new one */
> -		new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
> -		if (!new_on) {
> +		on = kmalloc(sizeof(*on), GFP_KERNEL);
> +		if (!on) {
>  			mutex_unlock(mutex);
>  			return -ENOMEM;
>  		}
> -		atomic_set(&new_on->event, 1);
> -		init_waitqueue_head(&new_on->poll);
> -		INIT_LIST_HEAD(&new_on->files);
> -		list_add_tail(&of->list, &new_on->files);
> -		rcu_assign_pointer(kn->attr.open, new_on);
> +		atomic_set(&on->event, 1);
> +		init_waitqueue_head(&on->poll);
> +		INIT_LIST_HEAD(&on->files);
> +		rcu_assign_pointer(kn->attr.open, on);
>  	}
> -	mutex_unlock(mutex);
>  
> +	list_add_tail(&of->list, &on->files);
> +
> +	mutex_unlock(mutex);
>  	return 0;
>  }
>  

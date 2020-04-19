Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05841AFED7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 01:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgDSXIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Apr 2020 19:08:30 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40288 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgDSXIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Apr 2020 19:08:30 -0400
Received: by mail-pj1-f67.google.com with SMTP id a22so3598101pjk.5;
        Sun, 19 Apr 2020 16:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bRxhA0JDlymvbxLQC4SO4UF/oBfb68GM9K/X50RbA9I=;
        b=a5+RgLNK3bdSXwen8lXty6rYjFPrnprqDgEnb9O4agwR7uwEMpz0fYUyf8TfdZfAt1
         t+FeC0DOfunPXHDBbZ41YiRVIjWypzeBu2ZGgQrmu31BpmmQnbOFx+c2s9MARmX+FMt1
         OoQotOzSohSwAiXdvaN+tMcshAVEBsyP0JFkkSeoanxRcMluCesQviEQzG1jkG1ZG3ZH
         edDNy+7hAgxS/7NdeXRLoNrnED+hpS1Qu0vLZQH/leZoBNRg1trPxLEkiNzdg6H+tW6z
         84NvbFGz4a84NyeRNdEBO7uW3mfxxKL0Pru4rmdcJFoTOsi4UsSA2NUtBUod9BIBMhff
         8ozg==
X-Gm-Message-State: AGi0PuYXBoVrRjPSU9qXfByhWVofIm1g2CRfjitH12/JpVhO7XnlrYUq
        mA66GNX1l9zZ+rs7akezcxBgZJgukPo=
X-Google-Smtp-Source: APiQypJ54vcVp1Xjf2NI19ielKB4SrpJ7y9ED790pSYxLzCyQKmTRUWLzMV3huGmnbqkdg34nUOdEw==
X-Received: by 2002:a17:902:6acc:: with SMTP id i12mr13979270plt.61.1587337708936;
        Sun, 19 Apr 2020 16:08:28 -0700 (PDT)
Received: from [100.124.11.78] ([104.129.199.4])
        by smtp.gmail.com with ESMTPSA id w125sm8133840pgw.22.2020.04.19.16.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Apr 2020 16:08:27 -0700 (PDT)
Subject: Re: [PATCH v2 09/10] block: panic if block debugfs dir is not created
To:     Luis Chamberlain <mcgrof@kernel.org>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rostedt@goodmis.org, mingo@redhat.com, jack@suse.cz,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org
Cc:     mhocko@suse.com, yukuai3@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200419194529.4872-1-mcgrof@kernel.org>
 <20200419194529.4872-10-mcgrof@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <01cd1694-7d13-67c1-827d-301dafd7a35b@acm.org>
Date:   Sun, 19 Apr 2020 16:08:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200419194529.4872-10-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/19/20 12:45 PM, Luis Chamberlain wrote:
> --- a/block/blk-debugfs.c
> +++ b/block/blk-debugfs.c
> @@ -15,6 +15,8 @@ struct dentry *blk_debugfs_root;
>   void blk_debugfs_register(void)
>   {
>   	blk_debugfs_root = debugfs_create_dir("block", NULL);
> +	if (!blk_debugfs_root)
> +		panic("Failed to create block debugfs directory\n");
>   }

Does Linus' "don't kill the kernel" rant apply to this patch?

Thanks,

Bart.


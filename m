Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144B3396D26
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 08:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhFAGLz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 02:11:55 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2920 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhFAGLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 02:11:54 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvMBV4GLPz677M;
        Tue,  1 Jun 2021 14:07:14 +0800 (CST)
Received: from dggpeml500019.china.huawei.com (7.185.36.137) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:10:11 +0800
Received: from [10.174.179.189] (10.174.179.189) by
 dggpeml500019.china.huawei.com (7.185.36.137) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 14:10:11 +0800
Subject: Re: [PATCH] fuse: use DIV_ROUND_UP helper macro for calculations
To:     <miklos@szeredi.hu>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>
References: <1621928447-456653-1-git-send-email-wubo40@huawei.com>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <79744e88-7f72-ce71-c379-cf749a6ba2f4@huawei.com>
Date:   Tue, 1 Jun 2021 14:10:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <1621928447-456653-1-git-send-email-wubo40@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.189]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500019.china.huawei.com (7.185.36.137)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ping ...

On 2021/5/25 15:40, Wu Bo wrote:
> From: Wu Bo <wubo40@huawei.com>
> 
> Replace open coded divisor calculations with the DIV_ROUND_UP kernel
> macro for better readability.
> 
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>   fs/fuse/file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 09ef2a4..62443eb 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -1405,7 +1405,7 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
>   		nbytes += ret;
>   
>   		ret += start;
> -		npages = (ret + PAGE_SIZE - 1) / PAGE_SIZE;
> +		npages = DIV_ROUND_UP(ret, PAGE_SIZE);
>   
>   		ap->descs[ap->num_pages].offset = start;
>   		fuse_page_descs_length_init(ap->descs, ap->num_pages, npages);
> 


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35B5ED54C9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2019 08:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfJMGRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Oct 2019 02:17:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42240 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfJMGRY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Oct 2019 02:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gHDvwzjyh2BcK8+v9tZOTrs2Kje82quoZLnRHBlDXkU=; b=hiDKVgsUJTt9/HS9pfII/xtxF
        fxGAQgT84/R/BNoKl1dm12dqUnbSJlJkREH7N+VymmjqUAxkhEMiNLQTuKCaQg8BAYcQHkyFTXCGW
        bgZrXRrsjX/IrJXKib/APthnGqPlf6AeJNf6bSdXCmwyqkunHiMirpQ3W/iqnZ36DtS5OuBRHfjw6
        DtoKOlFNbYzzACAb1+Mq6EyVw9EQ/x0AMQjTqzj5LmZLdjDsvaEwJBFZbDgdTimnSZ8+1DtuKJiWc
        unVbBy+Z+FU5lcM7lovuaycEFCMRyiiSdhHEWzAn6XN4NMP98tWqNe685Caizo2Qa88z7zm9Iiwuh
        NNVvpI7sA==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iJXBw-00013e-Fe; Sun, 13 Oct 2019 06:17:20 +0000
Subject: Re: [PATCH] writeback: Fix a warning while "make xmldocs"
To:     Masanari Iida <standby24x7@gmail.com>, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tj@kernel.org, axboe@kernel.dk
References: <20191013040837.14766-1-standby24x7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fcb2c42a-9ee9-7f59-0543-eca6e188ac00@infradead.org>
Date:   Sat, 12 Oct 2019 23:17:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191013040837.14766-1-standby24x7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/12/19 9:08 PM, Masanari Iida wrote:
> This patch fix following warning.
> ./fs/fs-writeback.c:918: warning: Excess function parameter
> 'nr_pages' description in 'cgroup_writeback_by_id'
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>
> ---
>  fs/fs-writeback.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index e88421d9a48d..8461a6322039 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -905,7 +905,7 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
>   * cgroup_writeback_by_id - initiate cgroup writeback from bdi and memcg IDs
>   * @bdi_id: target bdi id
>   * @memcg_id: target memcg css id
> - * @nr_pages: number of pages to write, 0 for best-effort dirty flushing
> + * @nr: number of pages to write, 0 for best-effort dirty flushing
>   * @reason: reason why some writeback work initiated
>   * @done: target wb_completion
>   *
> 

https://lore.kernel.org/linux-fsdevel/756645ac-0ce8-d47e-d30a-04d9e4923a4f@infradead.org/

Andrew has already added this to his patches.

-- 
~Randy

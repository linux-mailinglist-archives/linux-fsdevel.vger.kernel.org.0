Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA5751F300
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 05:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiEIDep (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 23:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiEIDYy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 23:24:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEE031379
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 May 2022 20:21:02 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxRFf0TvvzGph5;
        Mon,  9 May 2022 11:18:14 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 9 May 2022 11:21:00 +0800
Subject: Re: [PATCH 1/3] filemap: Remove obsolete comment in lock_page
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
CC:     Christoph Hellwig <hch@lst.de>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
References: <YngbFluT9ftR5dqf@casper.infradead.org>
 <20220508203048.667631-1-willy@infradead.org>
 <20220508203048.667631-2-willy@infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d86aea24-1ee5-c8a5-078c-60e0bac99151@huawei.com>
Date:   Mon, 9 May 2022 11:21:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220508203048.667631-2-willy@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/5/9 4:30, Matthew Wilcox (Oracle) wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> We no longer need the page's inode pinned.  This comment dates back to
> commit db37648cd6ce ("[PATCH] mm: non syncing lock_page()") which added
> lock_page_nosync().  That was removed by commit 7eaceaccab5f ("block:
> remove per-queue plugging") which also made this comment obsolete.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Many thanks for doing this! :)

> ---
>  include/linux/pagemap.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 65ae8f96554b..ab47579af434 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -908,9 +908,6 @@ static inline void folio_lock(struct folio *folio)
>  		__folio_lock(folio);
>  }
>  
> -/*
> - * lock_page may only be called if we have the page's inode pinned.
> - */
>  static inline void lock_page(struct page *page)
>  {
>  	struct folio *folio;
> 


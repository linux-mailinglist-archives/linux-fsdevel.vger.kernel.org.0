Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CB15A7220
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 01:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiH3X7S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 19:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiH3X7E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:59:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA18C6A4A3;
        Tue, 30 Aug 2022 16:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=+HJgGzdjoOCbPXQHd33i1N896ojtlMXsJVGIqbUOCQ8=; b=wLbgQIMvhs2qxhU2u+exycYzZ7
        GhN4meGiLY2lUJcusxW0Z+E19B48T/KsvAoDqnHNoe7AG8wTN+7jMYK6DvYoy+QtHRqY02B8Hyy55
        H92OqM7cgM4UlOwX9CwWCjMEWohnKfWEY2dz5OBAtuVPMvekxxA0H+b40eMZwftdqVwAiESOt8+hf
        wie8TQLWt+9DB/1hsW5BPXMVfxsrH50twp90MBZL6BYZjyNM1dAnpFyHf5cN+hJ5nrnmOAgvfS5U9
        2HLjHamkWgYN4tExun60r9dEs30pxImyjmndEZp0yrFNNJ+PY4+yu7JpYQpuhY0rvf+Xq4Un/y7km
        ri0d60WQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTB82-002arr-BT; Tue, 30 Aug 2022 23:58:46 +0000
Message-ID: <74683697-df9f-6f8f-00eb-4bb25e1a1638@infradead.org>
Date:   Tue, 30 Aug 2022 16:58:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -next] fs/hfsplus: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, axboe@kernel.dk
Cc:     hch@lst.de, bvanassche@acm.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220830074223.20281-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220830074223.20281-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/30/22 00:42, Yang Li wrote:
> Add the description of @opf and remove @op and @op_flags in
> hfsplus_submit_bio() kernel-doc comment.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2013
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>


Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  fs/hfsplus/wrapper.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
> index 0b791adf02e5..6202e877f459 100644
> --- a/fs/hfsplus/wrapper.c
> +++ b/fs/hfsplus/wrapper.c
> @@ -30,8 +30,7 @@ struct hfsplus_wd {
>   * @sector: block to read or write, for blocks of HFSPLUS_SECTOR_SIZE bytes
>   * @buf: buffer for I/O
>   * @data: output pointer for location of requested data
> - * @op: direction of I/O
> - * @op_flags: request op flags
> + * @opf: operation and flags for bio
>   *
>   * The unit of I/O is hfsplus_min_io_size(sb), which may be bigger than
>   * HFSPLUS_SECTOR_SIZE, and @buf must be sized accordingly. On reads

-- 
~Randy

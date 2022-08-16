Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0357A59659F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 00:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237581AbiHPWrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Aug 2022 18:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiHPWrv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:47:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4B7910A6;
        Tue, 16 Aug 2022 15:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=2YSX9MTzjphg3Pl8EWZLgii2B9uxrEDNzX37H2U4FY8=; b=EDzLUTgn+Obi4+hBg0tFp/TxJJ
        D/CcmuyO0mF0oZABfIlNwYmbY1rgLj675s5hGvnGABb5faUdtmkwZ8U6TeAq7/PJLLbMu7IXqEZQE
        dwjpeMNdPkn1/HHnnElhyJI/xBlGxhsZcYob/xstU7pwfa7tHMZ1a0vK5zv1KaC4xiQuySYtwwvCD
        NAQuHgKerHAZ/y8AUB1k5vLlehjnAGYVABRXunH9i/Yqrtt4XtnFAd+CEElraS4Hr5IkH9LRC+u5j
        9iQbfMAQSvKSXdl2enGSIkjJ5jmAe6Av4C5jBX6FqVcbkw+7/j62jrQOdvsMUbKUsoKzZF2ZgM+Io
        AZ4YOigQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oO5Le-007bMa-HA; Tue, 16 Aug 2022 22:47:46 +0000
Message-ID: <a063c19e-f6b9-a7ae-a199-1fc60de01c21@infradead.org>
Date:   Tue, 16 Aug 2022 15:47:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] fs/kernel_read_file: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20220815054411.68818-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220815054411.68818-1-yang.lee@linux.alibaba.com>
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



On 8/14/22 22:44, Yang Li wrote:
> Add a colon between the parameter name and description to meet the
> scripts/kernel-doc.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1901
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  fs/kernel_read_file.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/kernel_read_file.c b/fs/kernel_read_file.c
> index 5d826274570c..c4fc84e6d099 100644
> --- a/fs/kernel_read_file.c
> +++ b/fs/kernel_read_file.c
> @@ -8,16 +8,16 @@
>  /**
>   * kernel_read_file() - read file contents into a kernel buffer
>   *
> - * @file	file to read from
> - * @offset	where to start reading from (see below).
> - * @buf		pointer to a "void *" buffer for reading into (if
> + * @file:	file to read from
> + * @offset:	where to start reading from (see below).
> + * @buf:	pointer to a "void *" buffer for reading into (if
>   *		*@buf is NULL, a buffer will be allocated, and
>   *		@buf_size will be ignored)
> - * @buf_size	size of buf, if already allocated. If @buf not
> + * @buf_size:	size of buf, if already allocated. If @buf not
>   *		allocated, this is the largest size to allocate.
> - * @file_size	if non-NULL, the full size of @file will be
> + * @file_size:	if non-NULL, the full size of @file will be
>   *		written here.
> - * @id		the kernel_read_file_id identifying the type of
> + * @id:	the kernel_read_file_id identifying the type of
>   *		file contents being read (for LSMs to examine)
>   *
>   * @offset must be 0 unless both @buf and @file_size are non-NULL

-- 
~Randy

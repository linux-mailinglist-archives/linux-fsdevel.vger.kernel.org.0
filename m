Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC91633CD14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 06:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbhCPFXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 01:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbhCPFXR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:23:17 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1234::107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2572C06174A;
        Mon, 15 Mar 2021 22:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=pzK6j1BLSUD4GBlBNhV6RS9vkRptruk9iGMar/4N4MQ=; b=gDait91fy1rP3SXxVBrgYA2sB5
        jki0DZHU9GXlJcZAPXUjFdDFm2W2bgtC34WqAPPkJkA59Gi+TGJl6p/XcmfEiFT24NIXm2MdQ9nFD
        Q1yuHLQU/+jNT4HvsaLPBBnIgVM/v0X9ONwPejoqEBmJm9FHrgunUhmDTty/0lIYItFgcRsP0ZCUJ
        TFUlQ/64MqI/ZOET4+Y+jW0PNSYLNYNDVZ/qRNmhmq/3OEbrQJpzD6TKr882wQAS1FS3rOFNcAGAa
        S02J0HJgZetlREyKDEZMY66O29A4EkCFrKOoZaf+nxWZ6vjMFNKKLPZNx3q7I64i7s2TxSkS7dLiT
        MYoV4GXw==;
Received: from [2601:1c0:6280:3f0::9757]
        by merlin.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM2Ak-001PTS-N1; Tue, 16 Mar 2021 05:23:15 +0000
Subject: Re: [PATCH] fs: Trivial typo fix in the file coredump.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210316050302.3816253-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <515c0dca-2ce5-4c15-0682-b95374cb73e2@infradead.org>
Date:   Mon, 15 Mar 2021 22:23:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210316050302.3816253-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/15/21 10:03 PM, Bhaskar Chowdhury wrote:
> 
> s/postion/position/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  Al, I hope this time I read the comments well enough,if still
>  I am at fault , curse me!
> 
>  fs/coredump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 1c0fdc1aa70b..3ecae122ffd9 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -923,7 +923,7 @@ EXPORT_SYMBOL(dump_align);
> 
>  /*
>   * Ensures that file size is big enough to contain the current file
> - * postion. This prevents gdb from complaining about a truncated file
> + * position. This prevents gdb from complaining about a truncated file
>   * if the last "write" to the file was dump_skip.
>   */
>  void dump_truncate(struct coredump_params *cprm)
> --


-- 
~Randy


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593822165D0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 07:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbgGGFNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 01:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbgGGFNT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:13:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849A2C061755
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2020 22:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1ZvO6lR4RuCs3db0+rIlC3vsv9BD7qnEUHdhHmlJ/OA=; b=RB4J5NAUasTnRebyvkRWwR4gA8
        pE8WjdGJDz5LnO0iNmW8o/lLFq8kM37yFnTM0lHH4NDjgvIhe1LUH58wK5JhH8j82cblfjtbNlWLK
        JElD77zB20entYsWjp7xAe0vHgpmbgg599WDPGtl52ThrLLLN+ew5RER4HlwBhIh+8fRgpAuld9Bk
        SY0mKaVqZ5gtK8XPgLQ0Lz3LbFeaK/KTwLo2OotPBqlJmpvJcUUdIgkroAD8blNELIaSwCFqU5Z4u
        6ltm5h5NQF8TALrUiZ/OFD2R3msIjP84jQijWlvRDeYtB5iQi4QuOZAIeLPxujF3o8DxAFT9sUOsb
        XYUDY60Q==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsfuq-0008OA-Qi; Tue, 07 Jul 2020 05:13:17 +0000
Subject: Re: [PATCH] fs: correct kernel-doc inconsistency
To:     Colton Lewis <colton.w.lewis@protonmail.com>,
        viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org
References: <20200707044148.235087-1-colton.w.lewis@protonmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7b57c3a0-a41f-4b97-e0c9-d902abf8ae89@infradead.org>
Date:   Mon, 6 Jul 2020 22:13:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200707044148.235087-1-colton.w.lewis@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/6/20 9:42 PM, Colton Lewis wrote:
> Silence documentation build warning by correcting kernel-doc comment
> for file_sample_sub_err function.
> 
> ./include/linux/fs.h:2839: warning: Function parameter or member 'file' not described in 'file_sample_sb_err'
> ./include/linux/fs.h:2839: warning: Excess function parameter 'mapping' description in 'file_sample_sb_err'
> 
> Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>

Hi,
This is already fixed in linux-next.
You should check linux-next for anything that could already have patches
available but that have not been merged into mainline yet.

> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3f881a892ea7..15f430c800dc 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2827,7 +2827,7 @@ static inline errseq_t filemap_sample_wb_err(struct address_space *mapping)
>  
>  /**
>   * file_sample_sb_err - sample the current errseq_t to test for later errors
> - * @mapping: mapping to be sampled
> + * @file: file to be sampled
>   *
>   * Grab the most current superblock-level errseq_t value for the given
>   * struct file.
> 


thanks.
-- 
~Randy


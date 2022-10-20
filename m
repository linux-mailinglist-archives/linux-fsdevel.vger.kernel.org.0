Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BA060561C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 05:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJTDxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Oct 2022 23:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiJTDxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:53:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A4818BE06;
        Wed, 19 Oct 2022 20:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/JvjmffQ3hXpqGN/9W/KavgcOAZl9PKoivWmEcGrYWs=; b=Q0izzeWPBJEoLmgIJ8h5+GsAA/
        lz+Tl14gdK2oC8hvKqJshx92m73jjHfse8nC6iGms1xA2RNusjhg2LGdJfOLLkLm+TCmcXEGMS/0X
        NO1DjE5ZxH7F2TbQ8lOn0xEdxDuYjTxXHlBJTjMpwD9e8IWeUNrp8mYqElXLpEs/Oro3YLPXKgmUJ
        slckUs/Vx5pAl+F0fX0u58h1AWS+kYxQPp+vuY+wNFOlTnSxbHweKNkLk/V1vJl2DfrcASvs42R53
        4fNmeRyFyaSQBxsYCBBdWfo/VZJ6YYoKlKmSDwe5CHdJSVLy9UIKf7oUo0JtNUaRz26ez83f85pNY
        kUHj5BPQ==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olMcB-00A3P0-Vi; Thu, 20 Oct 2022 03:53:04 +0000
Message-ID: <c270337a-7be2-e53d-d4e8-81a934907205@infradead.org>
Date:   Wed, 19 Oct 2022 20:53:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] vfs: fs_context: Modify mismatched function name
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20221020034036.56523-1-jiapeng.chong@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221020034036.56523-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 10/19/22 20:40, Jiapeng Chong wrote:
> No functional modification involved.
> 
> fs/fs_context.c:347: warning: expecting prototype for vfs_dup_fc_config(). Prototype was for vfs_dup_fs_context() instead.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2456
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/fs_context.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index df04e5fc6d66..be45701cd998 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -340,7 +340,7 @@ void fc_drop_locked(struct fs_context *fc)
>  static void legacy_fs_context_free(struct fs_context *fc);
>  
>  /**
> - * vfs_dup_fc_config: Duplicate a filesystem context.
> + * vfs_dup_fs_context: Duplicate a filesystem context.

That is still not the correct kernel-doc format (or syntax).
The ':' should be a '-' instead.

Also, I see scripts/kernel-doc reporting 16 kernel-doc format
problems in this file. How about fixing more than just one of them, please.

fs_context.c:95: warning: No description found for return value of 'vfs_parse_fs
_param_source'
fs_context.c:128: warning: No description found for return value of 'vfs_parse_f
s_param'
fs_context.c:168: warning: Function parameter or member 'fc' not described in 'v
fs_parse_fs_string'
fs_context.c:168: warning: Function parameter or member 'key' not described in '
vfs_parse_fs_string'
fs_context.c:168: warning: Function parameter or member 'value' not described in
 'vfs_parse_fs_string'
fs_context.c:168: warning: Function parameter or member 'v_size' not described i
n 'vfs_parse_fs_string'
fs_context.c:168: warning: No description found for return value of 'vfs_parse_f
s_string'
fs_context.c:202: warning: Function parameter or member 'fc' not described in 'g
eneric_parse_monolithic'
fs_context.c:202: warning: Excess function parameter 'ctx' description in 'gener
ic_parse_monolithic'
fs_context.c:202: warning: No description found for return value of 'generic_par
se_monolithic'
fs_context.c:252: warning: No description found for return value of 'alloc_fs_co
ntext'
fs_context.c:340: warning: No description found for return value of 'vfs_dup_fs_
context'
fs_context.c:386: warning: Function parameter or member 'log' not described in '
logfc'
fs_context.c:386: warning: Function parameter or member 'prefix' not described i
n 'logfc'
fs_context.c:386: warning: Function parameter or member 'level' not described in
 'logfc'
fs_context.c:386: warning: Excess function parameter 'fc' description in 'logfc'
16 warnings


>   * @src_fc: The context to copy.
>   */
>  struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)

-- 
~Randy

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF07A7786D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 07:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjHKFDq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 01:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjHKFDn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 01:03:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3563F273E;
        Thu, 10 Aug 2023 22:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=PVjmoOWIsDeMpMGwKvmwReHGBhFn28bh4+1vKNjPRzA=; b=rYVRsiVyOqK/xKEKLGOVrv9Ss/
        VedX0whofDZFrrGVeNhdnc6o8j36VtJeKug3UbAZ1aV6dFPCgw+tRafmFlMvShJJW5QTgX7wob28m
        mliPR2b0k4xiFJTk6Orqf7lxpfRpScwtUp/Bzk6hHub8ElfMTybV2IIWpv0A3eaHzMgutNo21lwvu
        yka/oMP+0olVWZWCizZBej6Bq3GDDtHyZ3b33fFQoXc+dIzDlbPXzhVGI1stw3WeScSTyIqsXfPhX
        gmXukfsWSFjLHdBWqCiCMY7ecYKUd6dgPe2Vjsn/EKDcTRGM/ppcIcoIT4Hei5hkzuADVmhUlIGiB
        3ljIyi+Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUKJG-009SnW-1M;
        Fri, 11 Aug 2023 05:03:38 +0000
Message-ID: <a238c84e-3ddb-ef0b-66e4-b90d142fcd48@infradead.org>
Date:   Thu, 10 Aug 2023 22:03:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH -next] fs: Fix one kernel-doc comment
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, viro@zeniv.linux.org.uk,
        brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230811014359.4960-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230811014359.4960-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/10/23 18:43, Yang Li wrote:
> Fix one kernel-doc comment to silence the warning:
> 
> fs/read_write.c:88: warning: Function parameter or member 'maxsize' not described in 'generic_file_llseek_size'
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  fs/read_write.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index b07de77ef126..4771701c896b 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -71,7 +71,7 @@ EXPORT_SYMBOL(vfs_setpos);
>   * @file:	file structure to seek on
>   * @offset:	file offset to seek to
>   * @whence:	type of seek
> - * @size:	max size of this file in file system
> + * @maxsize:	max size of this file in file system
>   * @eof:	offset used for SEEK_END position
>   *
>   * This is a variant of generic_file_llseek that allows passing in a custom

-- 
~Randy

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADB463828B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 03:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiKYCwA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 21:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKYCv7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 21:51:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7317C29C81;
        Thu, 24 Nov 2022 18:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=WWyZ4GfuqQwjnEiGPBNjGmerSmAHeGHS1FWRjctLS5c=; b=ONIED5KAuazuCFSe5Sv0J83SAk
        Z1iPtr0dD0YKb331mx7x9CgRUzUgCJzUeSmvnL+XbyfKasT7W195Q4Ni+6ssuUNKirP5Nhxfmhg+Y
        UGSK77Nn0O69nLnHTMMuGvB4HV41EVE9RLPxr6CTtiK78WSCJ/8i4DBnoHIE1WIy+5THJMgPtgQ1k
        cf31CG8JdBJjeIb1B6QKhvOKxZhz1YUVrrLHRN7O7q+nc0EiSIkA1AzmgTw0ctAZsRxnhTOQkyNb8
        OY8VOqgF8Uuon+Mru4Pw1R+2J+jevU5D9fg6qxqN5P9fM0/uV0QGFJoDExRS2NkfzBUd0e9gzpkF2
        +sGj9JmA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oyOoi-00CI53-3Q; Fri, 25 Nov 2022 02:51:52 +0000
Message-ID: <49d0555b-7bd3-f8c7-f9ff-683d9720c6c7@infradead.org>
Date:   Thu, 24 Nov 2022 18:51:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] fs: namei: fix two excess parameter description warnings
Content-Language: en-US
To:     Kushagra Verma <kushagra765@outlook.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <HK0PR01MB28019953A3C47F9B4479D877F8069@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <HK0PR01MB28019953A3C47F9B4479D877F8069@HK0PR01MB2801.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 11/17/22 04:28, Kushagra Verma wrote:
> While building the kernel documentation, two excess parameter description
> warnings appear:
> 	./fs/namei.c:3589: warning: Excess function parameter 'dentry'
> 	description in 'vfs_tmpfile'
> 	./fs/namei.c:3589: warning: Excess function parameter 'open_flag'
> 	description in 'vfs_tmpfile'
> 
> Fix these warnings by changing 'dentry' to 'parentpath' in the parameter
> description and 'open_flag' to 'file' and change 'file' parameter's
> description accordingly.
> 
> Signed-off-by: Kushagra Verma <kushagra765@outlook.com>

Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  fs/namei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 578c2110df02..8e77e194fed5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3571,9 +3571,9 @@ static int do_open(struct nameidata *nd,
>  /**
>   * vfs_tmpfile - create tmpfile
>   * @mnt_userns:	user namespace of the mount the inode was found from
> - * @dentry:	pointer to dentry of the base directory
> + * @parentpath:	pointer to dentry of the base directory
>   * @mode:	mode of the new tmpfile
> - * @open_flag:	flags
> + * @file:	file information
>   *
>   * Create a temporary file.
>   *

-- 
~Randy

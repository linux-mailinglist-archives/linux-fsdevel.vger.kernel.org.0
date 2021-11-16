Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1313E453C7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 00:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhKPXDz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 18:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhKPXDz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 18:03:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63CBC061570;
        Tue, 16 Nov 2021 15:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=3hJqriphVMM07OM/Kwo2cD42Pvvn1Qz15qReihX4PtA=; b=jumkp0tSeYoAPtRUqzOMoMBk2l
        AXF3xXTEcIo0D+x65knBNjDTiy9q3pNCkBquegZITxoFnm8jou1bsg/kZwls6sinD/us0WJzJ3iD3
        CRfWQY0auo3D51k7hG+NC6gI1hZg7Y6Q50erfnZVDTXBFeqZq7IEsMk1oeQl5irquZk7i5asq1Y0R
        Y5ehBPopiiaf9YCTeuCY1WFTuDNMoWbNWNH3cQNyilkzLIy9OzzryUq6Vn8li0vSqRZche8rrNs1R
        8hRvgbX1Mm3PZ+r1AvGIFxYYytiYWlkJm0kD7r15vUwP8ZHWlu97gbYSWMgh9LxCEG9SA2tnD3QXz
        Zae5FyyQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mn7Rf-002uG4-BF; Tue, 16 Nov 2021 23:00:55 +0000
Subject: Re: [PATCH] fs: Eliminate compilation warnings for misc
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211116080611.31199-1-tianjia.zhang@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <941c9239-3b73-c2ae-83aa-f83d4e587fc8@infradead.org>
Date:   Tue, 16 Nov 2021 15:00:54 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211116080611.31199-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/21 12:06 AM, Tianjia Zhang wrote:
> Eliminate the following clang compilation warnings by adding or
> fixing function comment:

These are from clang?  They all appear to be from scripts/kernel-doc.

Can someone please clarify?

thanks.

>    fs/file.c:655: warning: Function parameter or member 'fdt' not described in 'last_fd'
>    fs/file.c:655: warning: Excess function parameter 'cur_fds' description in 'last_fd'
>    fs/file.c:703: warning: Function parameter or member 'flags' not described in '__close_range'
> 
>    fs/fs_context.c:202: warning: Function parameter or member 'fc' not described in 'generic_parse_monolithic'
>    fs/fs_context.c:202: warning: Excess function parameter 'ctx' description in 'generic_parse_monolithic'
>    fs/fs_context.c:386: warning: Function parameter or member 'log' not described in 'logfc'
>    fs/fs_context.c:386: warning: Function parameter or member 'prefix' not described in 'logfc'
>    fs/fs_context.c:386: warning: Function parameter or member 'level' not described in 'logfc'
>    fs/fs_context.c:386: warning: Excess function parameter 'fc' description in 'logfc'
> 
>    fs/namei.c:1044: warning: Function parameter or member 'inode' not described in 'may_follow_link'
> 
>    fs/read_write.c:88: warning: Function parameter or member 'maxsize' not described in 'generic_file_llseek_size'
>    fs/read_write.c:88: warning: Excess function parameter 'size' description in 'generic_file_llseek_size'
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>   fs/file.c       | 3 ++-
>   fs/fs_context.c | 6 ++++--
>   fs/namei.c      | 1 +
>   fs/read_write.c | 2 +-
>   4 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 8627dacfc424..ab3b635b0c86 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -645,7 +645,7 @@ EXPORT_SYMBOL(close_fd); /* for ksys_close() */
>   
>   /**
>    * last_fd - return last valid index into fd table
> - * @cur_fds: files struct
> + * @fdt: fdtable struct
>    *
>    * Context: Either rcu read lock or files_lock must be held.
>    *
> @@ -695,6 +695,7 @@ static inline void __range_close(struct files_struct *cur_fds, unsigned int fd,
>    *
>    * @fd:     starting file descriptor to close
>    * @max_fd: last file descriptor to close
> + * @flags:  close range flags
>    *
>    * This closes a range of file descriptors. All file descriptors
>    * from @fd up to and including @max_fd are closed.
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index b7e43a780a62..e94fb7f19d3f 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -189,7 +189,7 @@ EXPORT_SYMBOL(vfs_parse_fs_string);
>   
>   /**
>    * generic_parse_monolithic - Parse key[=val][,key[=val]]* mount data
> - * @ctx: The superblock configuration to fill in.
> + * @fc: filesystem context
>    * @data: The data to parse
>    *
>    * Parse a blob of data that's in key[=val][,key[=val]]* form.  This can be
> @@ -379,7 +379,9 @@ EXPORT_SYMBOL(vfs_dup_fs_context);
>   
>   /**
>    * logfc - Log a message to a filesystem context
> - * @fc: The filesystem context to log to.
> + * @log: The filesystem context to log to.
> + * @prefix: The log prefix.
> + * @level: The log level.
>    * @fmt: The format of the buffer.
>    */
>   void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt, ...)
> diff --git a/fs/namei.c b/fs/namei.c
> index 1f9d2187c765..3bc73b4f39c9 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1028,6 +1028,7 @@ int sysctl_protected_regular __read_mostly;
>   /**
>    * may_follow_link - Check symlink following for unsafe situations
>    * @nd: nameidata pathwalk data
> + * @inode: inode to check
>    *
>    * In the case of the sysctl_protected_symlinks sysctl being enabled,
>    * CAP_DAC_OVERRIDE needs to be specifically ignored if the symlink is
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 0074afa7ecb3..d7b0f8528930 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -71,7 +71,7 @@ EXPORT_SYMBOL(vfs_setpos);
>    * @file:	file structure to seek on
>    * @offset:	file offset to seek to
>    * @whence:	type of seek
> - * @size:	max size of this file in file system
> + * @maxsize:	max size of this file in file system
>    * @eof:	offset used for SEEK_END position
>    *
>    * This is a variant of generic_file_llseek that allows passing in a custom
> 


-- 
~Randy

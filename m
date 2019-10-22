Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38C5E02F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 13:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388676AbfJVLcJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 07:32:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43480 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731177AbfJVLcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:32:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id q24so6600725edr.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2019 04:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=plexistor-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IXdjAlYYb0/3BF9pQMCekdzHObGq7UqdMRAHLQJHvP0=;
        b=nshfuIVHMv5W1kTsmAFRMGY2vgtWD69hiQb7EqRiIky+siiGzKA8rT9H/CfogSpRWH
         ZzKKpiJII+11E/4bokPxJF9UeJdJJFXxET0FxY7Fny224N4pEngrgxbgQWpkSB/j7Pbn
         yhlbR9Y6w0Wujfqk41ZsLKXwAKZ5+/c46nnZSXt9j0X4GaelObZTCP/32nzyoA0eGKvJ
         EJrJ2D/qFHzNtezHZpQReKsjKU8Z2UcNRzQD+t2nObetnUDXlscLrsyXvG4/6VXG33QW
         RkNeTXbG4vW3EOIhy/oixEhvw+WDoPM5OFP1aGoYuZk451UWI2GmpxEwbsd+n8WpfONN
         5FnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IXdjAlYYb0/3BF9pQMCekdzHObGq7UqdMRAHLQJHvP0=;
        b=S/H3zj59sA9DJl0UBZqKHq0grzZ6RCY0JYA6CliVsH0lJJ+MkzaBqfY8IKgSb7LvAV
         xEvOXYUtrruJUF+nQysyxtcV6vBIxihrKUwC1qCegNYK3d7WAjPXdY2FyLsF8GZRbqEa
         iS0rjm9YX+p7ki5OO7smS63UXaBWRQAWUU3oxNgCLq96Gy+ziWW7Xfa1nLAoIH/dESwF
         XVCpyDRk8ayWVyj9zbmP+2KpuKbHA4b+L8C1IKuWwlMd+Ia9/mUrEjGq+7//bO6wJQ/f
         17WTboErfqewS7yvkQlOhmp3K2upKplE5JvwooVeTTBr4mpI6ww45QdpMXubI6sELrYH
         0qAg==
X-Gm-Message-State: APjAAAVsGgTyBLVK67U5TsOafUV4KBCGBfht5VhZlhb3HAyuowT9fLrK
        riZeYtZgTJjWUJrQO8C9vGUtzhR2dLs=
X-Google-Smtp-Source: APXvYqxQ+E/WTqukoI30ERPrEHKNbOYeg/geWj0e2Fz5zYm6mmeaHbKU07xRP3K0z7lNB1LlNNnNCw==
X-Received: by 2002:aa7:c595:: with SMTP id g21mr30006580edq.79.1571743927007;
        Tue, 22 Oct 2019 04:32:07 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.210.43])
        by smtp.googlemail.com with ESMTPSA id g17sm97740ejx.75.2019.10.22.04.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2019 04:32:06 -0700 (PDT)
Subject: Re: [PATCH 1/5] fs/stat: Define DAX statx attribute
To:     ira.weiny@intel.com, linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20191020155935.12297-1-ira.weiny@intel.com>
 <20191020155935.12297-2-ira.weiny@intel.com>
From:   Boaz Harrosh <boaz@plexistor.com>
Message-ID: <119b57ed-2799-c499-00df-50da80d23612@plexistor.com>
Date:   Tue, 22 Oct 2019 14:32:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191020155935.12297-2-ira.weiny@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20/10/2019 18:59, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> In order for users to determine if a file is currently operating in DAX
> mode (effective DAX).  Define a statx attribute value and set that
> attribute if the effective DAX flag is set.
> 
> To go along with this we propose the following addition to the statx man
> page:
> 
> STATX_ATTR_DAX
> 
> 	DAX (cpu direct access) is a file mode that attempts to minimize
> 	software cache effects for both I/O and memory mappings of this
> 	file.  It requires a capable device, a compatible filesystem
> 	block size, and filesystem opt-in. It generally assumes all
> 	accesses are via cpu load / store instructions which can
> 	minimize overhead for small accesses, but adversely affect cpu
> 	utilization for large transfers. File I/O is done directly
> 	to/from user-space buffers. While the DAX property tends to
> 	result in data being transferred synchronously it does not give
> 	the guarantees of synchronous I/O that data and necessary
> 	metadata are transferred. Memory mapped I/O may be performed
> 	with direct mappings that bypass system memory buffering. Again
> 	while memory-mapped I/O tends to result in data being
> 	transferred synchronously it does not guarantee synchronous
> 	metadata updates. A dax file may optionally support being mapped
> 	with the MAP_SYNC flag which does allow cpu store operations to
> 	be considered synchronous modulo cpu cache effects.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  fs/stat.c                 | 3 +++
>  include/uapi/linux/stat.h | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/fs/stat.c b/fs/stat.c
> index c38e4c2e1221..59ca360c1ffb 100644
> --- a/fs/stat.c
> +++ b/fs/stat.c
> @@ -77,6 +77,9 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
>  	if (IS_AUTOMOUNT(inode))
>  		stat->attributes |= STATX_ATTR_AUTOMOUNT;
>  
> +	if (inode->i_flags & S_DAX)

Is there a reason not to use IS_DAX(inode) ?

> +		stat->attributes |= STATX_ATTR_DAX;
> +
>  	if (inode->i_op->getattr)
>  		return inode->i_op->getattr(path, stat, request_mask,
>  					    query_flags);
> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> index 7b35e98d3c58..5b0962121ef7 100644
> --- a/include/uapi/linux/stat.h
> +++ b/include/uapi/linux/stat.h
> @@ -169,6 +169,7 @@ struct statx {
>  #define STATX_ATTR_ENCRYPTED		0x00000800 /* [I] File requires key to decrypt in fs */
>  
>  #define STATX_ATTR_AUTOMOUNT		0x00001000 /* Dir: Automount trigger */
> +#define STATX_ATTR_DAX			0x00002000 /* [I] File is DAX */
>  
>  
>  #endif /* _UAPI_LINUX_STAT_H */
> 


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5901A33AF3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 10:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhCOJsk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 05:48:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:60966 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhCOJsS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 05:48:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7AE2EAC1D;
        Mon, 15 Mar 2021 09:48:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 25A991E423D; Mon, 15 Mar 2021 10:48:17 +0100 (CET)
Date:   Mon, 15 Mar 2021 10:48:17 +0100
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        viro@zeniv.linux.org.uk, hch@infradead.org, axboe@kernel.dk,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Subject: Re: [RFC PATCH 3/3] block_dump: remove comments in docs
Message-ID: <20210315094817.GC3227@quack2.suse.cz>
References: <20210313030146.2882027-1-yi.zhang@huawei.com>
 <20210313030146.2882027-4-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313030146.2882027-4-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 13-03-21 11:01:46, zhangyi (F) wrote:
> Now block_dump feature is gone, remove all comments in docs.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/admin-guide/laptops/laptop-mode.rst | 11 -----------
>  Documentation/admin-guide/sysctl/vm.rst           |  8 --------
>  2 files changed, 19 deletions(-)
> 
> diff --git a/Documentation/admin-guide/laptops/laptop-mode.rst b/Documentation/admin-guide/laptops/laptop-mode.rst
> index c984c4262f2e..b61cc601d298 100644
> --- a/Documentation/admin-guide/laptops/laptop-mode.rst
> +++ b/Documentation/admin-guide/laptops/laptop-mode.rst
> @@ -101,17 +101,6 @@ this results in concentration of disk activity in a small time interval which
>  occurs only once every 10 minutes, or whenever the disk is forced to spin up by
>  a cache miss. The disk can then be spun down in the periods of inactivity.
>  
> -If you want to find out which process caused the disk to spin up, you can
> -gather information by setting the flag /proc/sys/vm/block_dump. When this flag
> -is set, Linux reports all disk read and write operations that take place, and
> -all block dirtyings done to files. This makes it possible to debug why a disk
> -needs to spin up, and to increase battery life even more. The output of
> -block_dump is written to the kernel output, and it can be retrieved using
> -"dmesg". When you use block_dump and your kernel logging level also includes
> -kernel debugging messages, you probably want to turn off klogd, otherwise
> -the output of block_dump will be logged, causing disk activity that is not
> -normally there.
> -
>  
>  Configuration
>  -------------
> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
> index 586cd4b86428..3ca6679f16ea 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -25,7 +25,6 @@ files can be found in mm/swap.c.
>  Currently, these files are in /proc/sys/vm:
>  
>  - admin_reserve_kbytes
> -- block_dump
>  - compact_memory
>  - compaction_proactiveness
>  - compact_unevictable_allowed
> @@ -106,13 +105,6 @@ On x86_64 this is about 128MB.
>  Changing this takes effect whenever an application requests memory.
>  
>  
> -block_dump
> -==========
> -
> -block_dump enables block I/O debugging when set to a nonzero value. More
> -information on block I/O debugging is in Documentation/admin-guide/laptops/laptop-mode.rst.
> -
> -
>  compact_memory
>  ==============
>  
> -- 
> 2.25.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

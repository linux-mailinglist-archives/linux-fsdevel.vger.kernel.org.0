Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F6E6EAE58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjDUP4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 11:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDUP4K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 11:56:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FA493F4;
        Fri, 21 Apr 2023 08:56:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 241CC617B5;
        Fri, 21 Apr 2023 15:56:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80B47C433D2;
        Fri, 21 Apr 2023 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682092568;
        bh=25t9JqK40yjvR8X6NIOYYvTj1/0mVvqPVROoptFqbdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EDpEPkJ9GCSXa6Y/Ytr3oMPrEVMt19wNvSIMgSva04q0zqQUc4bI3lTIEEK4aCdoD
         sjrBjbQKOEkNQtcBh17ZWiw/YcpGYlZznRT21slAa6rKcP/O6SPXsMpFMyjtuSzS4p
         T3a5/kO4yVxVOamchKhzqq2pBdpi2vU8gNG0zxIPSNbsZV7Pt65SjU6YYb/kOqFKQ9
         ymYeh+hAdnyejQBMA8+FWXMWUtMSYS/Q7qBNx6tUdQsx7L8eDttNZq5stU7nCk6Vpq
         Ez5D+IV6MUxTHgXKfa2Re7u9Awbq9CdbhHkqADRET0URfrkQrWYpi10yPRN5kBbZ6q
         tm49wKtN9zIqA==
Date:   Fri, 21 Apr 2023 08:56:07 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv6 6/9] fs.h: Add TRACE_IOCB_STRINGS for use in trace
 points
Message-ID: <20230421155607.GI360881@frogsfrogsfrogs>
References: <cover.1682069716.git.ritesh.list@gmail.com>
 <12576fb7b6a9720cc1d5659e95beea948c27907b.1682069716.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12576fb7b6a9720cc1d5659e95beea948c27907b.1682069716.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 21, 2023 at 03:16:16PM +0530, Ritesh Harjani (IBM) wrote:
> Add TRACE_IOCB_STRINGS macro which can be used in the trace point patch to
> print different flag values with meaningful string output.
> 
> Tested-by: Disha Goel <disgoel@linux.ibm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Looks good, will fix the indentation problems on commit.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  include/linux/fs.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c85916e9f7db..bdc1f7ed2aba 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -340,6 +340,20 @@ enum rw_hint {
>  /* can use bio alloc cache */
>  #define IOCB_ALLOC_CACHE	(1 << 21)
>  
> +/* for use in trace events */
> +#define TRACE_IOCB_STRINGS \
> +	{ IOCB_HIPRI, "HIPRI"	}, \
> +	{ IOCB_DSYNC, "DSYNC"	}, \
> +	{ IOCB_SYNC, "SYNC"	}, \
> +	{ IOCB_NOWAIT, "NOWAIT" }, \
> +	{ IOCB_APPEND, "APPEND" }, \
> +	{ IOCB_EVENTFD, "EVENTFD"}, \
> +	{ IOCB_DIRECT, "DIRECT" }, \
> +	{ IOCB_WRITE, "WRITE"	}, \
> +	{ IOCB_WAITQ, "WAITQ"	}, \
> +	{ IOCB_NOIO, "NOIO"	}, \
> +	{ IOCB_ALLOC_CACHE, "ALLOC_CACHE" }
> +
>  struct kiocb {
>  	struct file		*ki_filp;
>  	loff_t			ki_pos;
> -- 
> 2.39.2
> 

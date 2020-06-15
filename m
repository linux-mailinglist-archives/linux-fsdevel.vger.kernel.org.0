Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C5F1F921D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 10:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgFOIrW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 04:47:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:45322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728593AbgFOIrV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:47:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1F864AD4A;
        Mon, 15 Jun 2020 08:47:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9046C1E1289; Mon, 15 Jun 2020 10:47:19 +0200 (CEST)
Date:   Mon, 15 Jun 2020 10:47:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/29] fs: fs.h: fix a kernel-doc parameter description
Message-ID: <20200615084719.GH9449@quack2.suse.cz>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
 <e6b1201c3b5fa88085919908f01ea7337d9c9359.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b1201c3b5fa88085919908f01ea7337d9c9359.1592203542.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 15-06-20 08:46:46, Mauro Carvalho Chehab wrote:
> Changeset 3b0311e7ca71 ("vfs: track per-sb writeback errors and report them to syncfs")
> added a variant of filemap_sample_wb_err(), but it forgot to
> rename the arguments at the kernel-doc markup. Fix it.
> 
> Fix those warnings:
> 	./include/linux/fs.h:2845: warning: Function parameter or member 'file' not described in 'file_sample_sb_err'
> 	./include/linux/fs.h:2845: warning: Excess function parameter 'mapping' description in 'file_sample_sb_err'
> 
> Fixes: 3b0311e7ca71 ("vfs: track per-sb writeback errors and report them to syncfs")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks for the fix! It looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 6c4ab4dc1cd7..7e17ecc461d5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2829,7 +2829,7 @@ static inline errseq_t filemap_sample_wb_err(struct address_space *mapping)
>  
>  /**
>   * file_sample_sb_err - sample the current errseq_t to test for later errors
> - * @mapping: mapping to be sampled
> + * @file: file pointer to be sampled
>   *
>   * Grab the most current superblock-level errseq_t value for the given
>   * struct file.
> -- 
> 2.26.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

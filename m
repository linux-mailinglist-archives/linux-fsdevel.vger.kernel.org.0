Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D2735DDAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 13:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhDML3D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 07:29:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230395AbhDML3C (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:29:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C56661244;
        Tue, 13 Apr 2021 11:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618313322;
        bh=n/RQhfubZaNvPR8sqPygHbbKSkP1gMM78ul3t0DS6aU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y3CDvtulZGF5dFsgc/gEF3baEE4n/vjcZGT1vGBW1HvScByLSLKTLbQxWhiBQcM8X
         36L0pTGYB2bhJ3vzi61an0Gy1J3xLj2Igy41c5GmXJK3ok9M8C7EYqgQMRoiVANs9n
         hc3OdMyTy6a4d8FfpZi/MGIvLBWl7Vz6pMIeYktMGJ8SxriU6niAJ/euv4fMcedOqU
         HspxFKU8XvYf5sS1EN7R6okc4s5abs3nzmNFjpb34ZzwQyHk+aa2neAPuV1ZkIdKN6
         2iciItwt3AVNNn6F06dYh4f5JkLAtohkrUpzEW5OOOadB8bl5n6mbQTpzPy8n65saj
         CDoYNKKRj9f9w==
Message-ID: <cd9af9a5f8fd0f6ff088290695225ae385b1d15d.camel@kernel.org>
Subject: Re: [PATCH] fs/locks: remove useless assignments
From:   Jeff Layton <jlayton@kernel.org>
To:     Tian Tao <tiantao6@hisilicon.com>, viro@zeniv.linux.org.uk,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org
Date:   Tue, 13 Apr 2021 07:28:41 -0400
In-Reply-To: <1618279103-45362-1-git-send-email-tiantao6@hisilicon.com>
References: <1618279103-45362-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2021-04-13 at 09:58 +0800, Tian Tao wrote:
> Function parameter 'cmd' is rewritten with unused value at locks.c
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  fs/locks.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 53cf033..5c42363 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2369,7 +2369,6 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
>  		if (flock->l_pid != 0)
>  			goto out;
>  
> -		cmd = F_GETLK;
>  		fl->fl_flags |= FL_OFDLCK;
>  		fl->fl_owner = filp;
>  	}

Thanks, merged into the locks-next branch and should make v5.13.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>


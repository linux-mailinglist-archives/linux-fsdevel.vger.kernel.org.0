Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBDD2298C90
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 13:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1774619AbgJZMBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 08:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1769395AbgJZMBG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:01:06 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C97122263;
        Mon, 26 Oct 2020 12:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603713666;
        bh=CkldyogWfo/ivLO62VlJzz6D/OzTlHFeOpOL9uzt8ws=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=k492nic/qQb8HJzA+fwAwpk0/r1YvIdKoJLyndQDWWSNIZzxeW5NoASmTIPxfLB6C
         Ra3TdEZnkeQhAguW6yWA5SSigg6EkYT1wxklv0ytqNl0tMRpwdQ+b5qdy7Boua7A1M
         bS2AItSKlVAWs17f2NJUoZUzP1HiQxmrZbPVCTgI=
Message-ID: <9a07dd50505d16d0a2db155ab3a3938ab35320a3.camel@kernel.org>
Subject: Re: [PATCH v3 36/56] locks: fix a typo at a kernel-doc markup
From:   Jeff Layton <jlayton@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 26 Oct 2020 08:01:04 -0400
In-Reply-To: <901134db80ae9763d3ce2bc42faa1b2105c29d7f.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
         <901134db80ae9763d3ce2bc42faa1b2105c29d7f.1603469755.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-10-23 at 18:33 +0200, Mauro Carvalho Chehab wrote:
> locks_delete_lock -> locks_delete_block
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  fs/locks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 1f84a03601fe..f3c3ce82a455 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -750,7 +750,7 @@ static void __locks_wake_up_blocks(struct file_lock *blocker)
>  }
>  
>  /**
> - *	locks_delete_lock - stop waiting for a file lock
> + *	locks_delete_block - stop waiting for a file lock
>   *	@waiter: the lock which was waiting
>   *
>   *	lockd/nfsd need to disconnect the lock while working on it.

Thanks, merged. Should make 5.11.

Cheers,
-- 
Jeff Layton <jlayton@kernel.org>


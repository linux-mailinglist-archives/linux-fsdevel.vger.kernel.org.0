Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 982A7D1C87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 01:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbfJIXND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 19:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:35492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731542AbfJIXND (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:13:03 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ECAE206BB;
        Wed,  9 Oct 2019 23:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570662782;
        bh=oCRn3JjATva9R6bAW/lMjEkdJaPC+cn6csIMs4uFiPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YxgfdepboPDcp50suajDKZE/jFrWOWYBnGVR4FSn2qQjsRNg+b9CmsuTOAsRCHJjB
         BwW76CsJVUUb3/Ec8lupsntFXyszdN5pHcf3HMVZKuC5aqbYfaOy7yS73Pu8Rg8lnQ
         VsQDblnJTIxudsD45Dh4kH8dRJnckGlSDiDGAamU=
Date:   Wed, 9 Oct 2019 16:13:00 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/namespace: make to_mnt_ns static
Message-ID: <20191009231259.GA125579@gmail.com>
Mail-Followup-To: Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191009145211.16614-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009145211.16614-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 09, 2019 at 03:52:11PM +0100, Ben Dooks wrote:
> The to_mnt_ns() is not exported outside the file so
> make it static to fix the following sparse warning:
> 
> fs/namespace.c:1731:22: warning: symbol 'to_mnt_ns' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/namespace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index fe0e9e1410fe..b87b127fdce4 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1728,7 +1728,7 @@ static bool is_mnt_ns_file(struct dentry *dentry)
>  	       dentry->d_fsdata == &mntns_operations;
>  }
>  
> -struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
> +static struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
>  {
>  	return container_of(ns, struct mnt_namespace, ns);
>  }
> -- 
> 2.23.0
> 

Al, this patch has been sent to you 11 times by 8 different people over 2 years:

https://lore.kernel.org/linux-fsdevel/20191009145211.16614-1-ben.dooks@codethink.co.uk/
https://lore.kernel.org/linux-fsdevel/20190822154014.14401-1-ebiggers@kernel.org/
https://lore.kernel.org/linux-fsdevel/20190529212108.164246-1-ebiggers@kernel.org/
https://lore.kernel.org/linux-fsdevel/20190414191913.GA11798@bharath12345-Inspiron-5559/
https://lore.kernel.org/linux-fsdevel/20190319151756.96768-1-maowenan@huawei.com/
https://lore.kernel.org/linux-fsdevel/20190110204147.120073-1-ebiggers@kernel.org/
https://lore.kernel.org/linux-fsdevel/20181115000930.47611-1-ebiggers@kernel.org/
https://lore.kernel.org/linux-fsdevel/20180630120447.17861-1-colin.king@canonical.com/
https://lore.kernel.org/linux-fsdevel/20170111104846.26220-1-tklauser@distanz.ch/
https://lore.kernel.org/linux-fsdevel/20181207204318.1920-1-malat@debian.org/
https://lore.kernel.org/linux-fsdevel/a2cc7bd9cd4cd5be54303090c7ba6654d7b04b4f.1443364195.git.geliangtang@163.com/

No response from you to any of them.  I guess this means you're just not taking
these types of obvious cleanups?  Should people be sending them to Andrew Morton
instead?

- Eric

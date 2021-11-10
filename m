Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0906844BF54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 11:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbhKJLBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 06:01:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:38592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhKJLBo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 06:01:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 127CC61078;
        Wed, 10 Nov 2021 10:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636541936;
        bh=gHSBa8ivw9GQcEbo5ekqR+sipOS0BWUuUGJifY7Y8z4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ss/3sKIqZSWKLG//I6LhznU/o/oQhNgWFtj/L/G3W1W5mogp1JUdf3iiS0R7oydKG
         jGk7q4jGqvdiL/X07sU4NZFsSrW6DF95qDI8Bc4xoHCZquRZDnf/dPKUp8Kyaw+0iK
         xe6R2A4bmBIwF5dVYDT09SEfetcWxSIueXWnaZ8jcHNVtIHTHb6Ifd2hKsha/zxQsg
         E16CtSOe1O3Qh3TxSc1eub4jsoHB4xGcWVlNCV2sap0ZL6UdciIdpS4t4zVyXdi6Ct
         K2oZpcFqgEeqox27qEjuBvIiaCQTNwDPd7Kd264K9N+uFJ+DYH0xzLBzkk3P72EY20
         7reB7G4SndwRg==
Message-ID: <70778cdf726d59d852a3b1262760fb71574f0e91.camel@kernel.org>
Subject: Re: [PATCH] fasync: Use tabs instead of spaces in code indent
From:   Jeff Layton <jlayton@kernel.org>
To:     Wen Gu <guwen@linux.alibaba.com>, viro@zeniv.linux.org.uk,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
        xuanzhuo@linux.alibaba.com
Date:   Wed, 10 Nov 2021 05:58:54 -0500
In-Reply-To: <1636525756-68970-1-git-send-email-guwen@linux.alibaba.com>
References: <1636525756-68970-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-11-10 at 14:29 +0800, Wen Gu wrote:
> When I investigated about fasync_list in SMC network subsystem,
> I happened to find that here uses spaces instead of tabs in code
> indent and fix this by the way.
> 
> Fixes: f7347ce4ee7c ("fasync: re-organize fasync entry insertion to
> allow it under a spinlock")
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
> ---
>  fs/fcntl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 9c6c6a3..36ba188 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -927,7 +927,7 @@ void fasync_free(struct fasync_struct *new)
>   */
>  struct fasync_struct *fasync_insert_entry(int fd, struct file *filp, struct fasync_struct **fapp, struct fasync_struct *new)
>  {
> -        struct fasync_struct *fa, **fp;
> +	struct fasync_struct *fa, **fp;
>  
>  	spin_lock(&filp->f_lock);
>  	spin_lock(&fasync_lock);

Hi Wen,

I usually don't take patches that just fix whitespace like this. The
reason is that these sorts of patches tend to make backporting difficult
as they introduce merge conflicts for no good reason.

When you're making substantial changes in an area, then please do go
ahead and fix up whitespace in the same area, but patches that just fix
up whitespace are more trouble than they are worth.

Sorry,
-- 
Jeff Layton <jlayton@kernel.org>

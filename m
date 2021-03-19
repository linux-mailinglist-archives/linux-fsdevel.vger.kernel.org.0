Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37BE3425B7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 20:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCSTGB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 15:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhCSTFi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 15:05:38 -0400
X-Greylist: delayed 4289 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 19 Mar 2021 12:05:38 PDT
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF8AC06174A
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 12:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0ey7YfbgzAR3jH196JzXqYrJSyCm8QIKuZOJc+hwz/U=; b=VS+VfScgyEfNFcvWHbSF1a17CT
        X+62m9+nHK+9BFu8/Y//fM6aPmO44pEqXjTHBSHyz1gdDXweRMbKE0c+rjEsbWlIvGs8kuBWNfOIY
        zCYyCgKD8BdprZ/MUXiy5g13IGdE6eNsZp/L6WLrj8OaEjLS0C2OBeu0imIpTsBGN2PM5zWYcq6wr
        UQ04FjlT/rck1cCCMyydRlB/GcZBb2Gt8iHFuqoPRRpU+eCviJ+UjbEQTpbAsJ2I1EWTDfRsCiqOv
        nHdTwwUB6hTrPv1n3SneQh0fqhS2cosL8biwxlQ5Tqv2kdyMMzuZLlicgZ0DTdwDXl/PdbxO8Ypjj
        IqFIMBTQ==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNJK1-001R5X-VI; Fri, 19 Mar 2021 17:54:07 +0000
Date:   Fri, 19 Mar 2021 10:54:05 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/inode.c: Fix a rudimentary typo
In-Reply-To: <20210319005342.23795-1-unixbhaskar@gmail.com>
Message-ID: <b6e29afe-96c2-1016-8a2-40baa542d92@bombadil.infradead.org>
References: <20210319005342.23795-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_105406_026685_1B21D747 
X-CRM114-Status: GOOD (  12.58  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote: > s/funtion/function/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:

> s/funtion/function/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> fs/inode.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index a047ab306f9a..38c2e6b58dc4 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1423,7 +1423,7 @@ EXPORT_SYMBOL(ilookup);
>  * function must never block --- find_inode() can block in
>  * __wait_on_freeing_inode() --- or when the caller can not increment
>  * the reference count because the resulting iput() might cause an
> - * inode eviction.  The tradeoff is that the @match funtion must be
> + * inode eviction.  The tradeoff is that the @match function must be
>  * very carefully implemented.
>  */
> struct inode *find_inode_nowait(struct super_block *sb,
> --
> 2.26.2
>
>

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91744342F64
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 20:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCTT4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 15:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbhCTTzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 15:55:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DF9C061574;
        Sat, 20 Mar 2021 12:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uWrYtpK8ByXXQV902y0PottjEgsHB2TL3qHdy2XZsmg=; b=wHovkshiJTd2XSQv5NN+MRQpZ/
        MNdf8LAZc/I4pJsoq+VVZbf+Fog9PLkDB+W/DIEmClQsyRGTxK27JG7DYxXJ4vVFYM1GTAb44dm1F
        OIheJetTyuaXND+896daeS8+NLPg/R7tLQOI4SEhhAVFilB0TM2BziaVGB2TyEZelPgQw5PVUGugG
        +b1yXODKmZiQIH6wAyz9XMEzbRv65ReWMvZ5eGxnIgDAAkMOWg09naQ+qVO8EqRtumJuCNbR9iqr7
        X7wWiu0aK0XNuDLLJUo/nyxB6EJ/GpDdCxhi0BKnFzEr/A1Zriwz7ldPxhwcUm9hl42PLoIRQ6dLz
        ZqBOK3dg==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNhhN-0020qS-9D; Sat, 20 Mar 2021 19:55:50 +0000
Date:   Sat, 20 Mar 2021 12:55:49 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/attr.c: Couple of typo fixes
In-Reply-To: <20210320193353.30059-1-unixbhaskar@gmail.com>
Message-ID: <f8f9b340-cd4c-6eaf-48c1-854d3d5427fc@bombadil.infradead.org>
References: <20210320193353.30059-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_125549_346475_16EF23E6 
X-CRM114-Status: GOOD (  11.73  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote: > > s/filesytem/filesystem/
    > s/asssume/assume/ > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
    Acked-by: Randy Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/filesytem/filesystem/
> s/asssume/assume/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> fs/attr.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/attr.c b/fs/attr.c
> index 87ef39db1c34..e5330853c844 100644
> --- a/fs/attr.c
> +++ b/fs/attr.c
> @@ -250,7 +250,7 @@ void setattr_copy(struct user_namespace *mnt_userns, struct inode *inode,
> EXPORT_SYMBOL(setattr_copy);
>
> /**
> - * notify_change - modify attributes of a filesytem object
> + * notify_change - modify attributes of a filesystem object
>  * @mnt_userns:	user namespace of the mount the inode was found from
>  * @dentry:	object affected
>  * @attr:	new attributes
> @@ -265,7 +265,7 @@ EXPORT_SYMBOL(setattr_copy);
>  * caller should drop the i_mutex before doing so.
>  *
>  * If file ownership is changed notify_change() doesn't map ia_uid and
> - * ia_gid. It will asssume the caller has already provided the intended values.
> + * ia_gid. It will assume the caller has already provided the intended values.
>  *
>  * Alternatively, a caller may pass NULL for delegated_inode.  This may
>  * be appropriate for callers that expect the underlying filesystem not
> --
> 2.26.2
>
>

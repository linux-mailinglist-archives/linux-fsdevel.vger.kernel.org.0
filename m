Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E28F1BFCBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Sep 2019 03:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbfI0BfY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 21:35:24 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:60583 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbfI0BfY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 21:35:24 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 00113314;
        Thu, 26 Sep 2019 21:35:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 26 Sep 2019 21:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        wuCi48LP8H5ilbIB85ZAEiU5z8rUCcolTeN3vq3wqWk=; b=cY7PgjCJmHGHhR79
        Hso5BA2hg8poKpCpZUGWbk3laKZzBZo+wwguYW9M6H7or5rW1ADxlD07WQ1vvSSq
        b4pPATGHlIO1alBZTnPIl7/Rg3mzfLoIzwxTQFV5DVskLbXrSI+CNhG03Oh+tad2
        ZLS2sxXwcXPcLGBdI5bMHdX65PmMq9p/oT6lv+aoAzMS4jArGUMmf7zgsIijC678
        CGKWCvKZgrak65M7CN4SzDLl4x2ZrS5EDPmm6zLpA7Ng+wlQ47Lv0wV9NKnQlG3g
        YtZzwEAjNmo9j5HXU0YCbYH3TjmZvARsmd2kpMGINYOuDyn8tokUNnziJumd324z
        i8NA4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=wuCi48LP8H5ilbIB85ZAEiU5z8rUCcolTeN3vq3wq
        Wk=; b=y1HnUQ96DvrU12aHmL1XK3UuAnTgILNkwM2C1ScGvnJ4yc4TW7jI5pTLd
        J6P5IljDP3EneAU0JNyvhXcYupbwrIom30AmEHiamstnc/zGh33saVQStycx9vQo
        Xv5zeb/n/GSqpAgy59pA2FOalxVxFNWRmPQcu7PNn59wE5U54cjSHbCm3HnONZSR
        PV55SBwrx7SW1Mck/n4dUdPK7LdrcFeUGYV4TOLIjD5T9Hm0hfklC3Ors3MNZRJ2
        ipqAlir3K6HhHyj8sKA+tE86fiSeqDKEbAq+3vL7RyjgKEveuWFqvAhhXuXh7bFg
        w3DlwDPUSmWxyQ4ZWPJCMo3AXCFuA==
X-ME-Sender: <xms:WWeNXQNr22cHUauSWs3Sxke0raAF8uwJMuZ3Np5UY5UOzOZ8A6J93Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrfeehgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuffhomhgrihhnpehrvgguhh
    grthdrtghomhenucfkphepuddukedrvddtledrudeikedrvdeinecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvthenucevlhhushhtvghrufhiii
    gvpedt
X-ME-Proxy: <xmx:WWeNXUXC6fUozi0y4g9Z0Z-AkWX5caZG3poixNAHPDYC8ntqQUDy7g>
    <xmx:WWeNXcdvq7KW9ZYm0dMkHNNOB5hjHbfghn0phvVvRwU2fHnUu_uaPg>
    <xmx:WWeNXWF8tAnC18lXNz2LcE6XLMrjeW4GdD2L2q5t8BIa5gpfDn8zsw>
    <xmx:WmeNXeFU9oqsxTeVpSo4lfkPuiynnYra-G_SCSwQeJvIl05wstYpMw>
Received: from mickey.themaw.net (unknown [118.209.168.26])
        by mail.messagingengine.com (Postfix) with ESMTPA id 74F5AD6005E;
        Thu, 26 Sep 2019 21:35:19 -0400 (EDT)
Message-ID: <3468a81a09d13602c67007759593ddf450f8132c.camel@themaw.net>
Subject: Re: [RFC] Don't propagate automount
From:   Ian Kent <raven@themaw.net>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, viro@zeniv.linux.org.uk
Cc:     autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 27 Sep 2019 09:35:13 +0800
In-Reply-To: <20190926195234.bipqpw5sbk5ojcna@fiona>
References: <20190926195234.bipqpw5sbk5ojcna@fiona>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2019-09-26 at 14:52 -0500, Goldwyn Rodrigues wrote:
> An access to automounted filesystem can deadlock if it is a bind
> mount on shared mounts. A user program should not deadlock the kernel
> while automount waits for propagation of the mount. This is explained
> at https://bugzilla.redhat.com/show_bug.cgi?id=1358887#c10
> I am not sure completely blocking automount is the best solution,
> so please reply with what is the best course of action to do
> in such a situation.
> 
> Propagation of dentry with DCACHE_NEED_AUTOMOUNT can lead to
> propagation of mount points without automount maps and not under
> automount control. So, do not propagate them.

Yes, I'm not sure my comments about mount propagation in that
bug are accurate.

This behaviour has crept into the kernel in reasonably recent
times, maybe it's a bug or maybe mount propagation has been
"fixed", not sure.

I think I'll need to come up with a more detailed description
of what is being done for Al to be able to offer advice.

I'll get to that a bit later.

> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> diff --git a/fs/pnode.c b/fs/pnode.c
> index 49f6d7ff2139..b960805d7954 100644
> --- a/fs/pnode.c
> +++ b/fs/pnode.c
> @@ -292,6 +292,9 @@ int propagate_mnt(struct mount *dest_mnt, struct
> mountpoint *dest_mp,
>  	struct mount *m, *n;
>  	int ret = 0;
>  
> +	if (source_mnt->mnt_mountpoint->d_flags &
> DCACHE_NEED_AUTOMOUNT)
> +		return 0;
> +

Possible problem with this is it will probably prevent mount
propagation in both directions which will break stuff.

I had originally assumed the problem was mount propagation
back to the parent mount but now I'm not sure that this is
actually what is meant to happen.

>  	/*
>  	 * we don't want to bother passing tons of arguments to
>  	 * propagate_one(); everything is serialized by namespace_sem,
> 


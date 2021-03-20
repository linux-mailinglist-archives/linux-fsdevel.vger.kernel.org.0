Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4BE34299D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 02:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhCTB2n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 21:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbhCTB2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 21:28:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A76DC061760;
        Fri, 19 Mar 2021 18:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=20VkkZj1/h3PoX/Grgm1QafHUJwKJ6WIUAb3r5pvoFw=; b=OJGlsuuL6bqISa+VvkxKapqZHB
        xab232ctEZXd1mby7b7LqZ87aMM2eJKVnFGTyU6eDa4huQn/S6kken+HPJzluT/RdJVBXvyuV5j6j
        a+8lqonDpa/VhJzRQHv+tBLkLHRc4sgSIKMAPFgUHhRDyZ5zSSpshRfvlDZDivionb04c23WuoB8n
        tvoenu59xTxa2z6Fu4aKtz6ocgexchn+Pz31gjdyr9IxSP++arSqAp6xt/0g3A2c8hRigaGtPdtYJ
        wSMNWLIMYcNFzA3X9XGcPICKQFp/K99y69DLaeXIlf2PKZWwSX9vFp23aMWogYQU7N1K9cK6SNtan
        kneH3k0A==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNQPr-001dyR-V8; Sat, 20 Mar 2021 01:28:37 +0000
Date:   Fri, 19 Mar 2021 18:28:35 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc: Trivial spello fix
In-Reply-To: <20210319220034.15876-1-unixbhaskar@gmail.com>
Message-ID: <6d6201-27d2-19d2-b710-9b4461fce6f0@bombadil.infradead.org>
References: <20210319220034.15876-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_182836_024197_EF72E045 
X-CRM114-Status: GOOD (  11.65  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote: > > s/delimeter/delimiter/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sat, 20 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/delimeter/delimiter/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> Al, please don't fret over this trivialities. I am trying to make sense the
> change I am making.
>
> fs/binfmt_misc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index e1eae7ea823a..1e4a59af41eb 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -297,7 +297,7 @@ static Node *create_entry(const char __user *buffer, size_t count)
> 	if (copy_from_user(buf, buffer, count))
> 		goto efault;
>
> -	del = *p++;	/* delimeter */
> +	del = *p++;	/* delimiter */
>
> 	pr_debug("register: delim: %#x {%c}\n", del, del);
>
> --
> 2.26.2
>
>

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B26342F2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Mar 2021 20:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCTTOL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Mar 2021 15:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhCTTOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Mar 2021 15:14:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5045C061574;
        Sat, 20 Mar 2021 12:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4SRcsqOR7mHsvlTEOKmrt3I6oj9DuUZJwfHn+BDyzWg=; b=LsJhf1TAEH9gQ5pX+wyRzqvn8U
        GnJGsdXw8vwC6pteF7Stj3tkm0GCeqKjpNvfsQpFsm6m3X8t3BJatJnaunTkdyDST32Y4Dx3zHbji
        ooT2E6CjoiuO9461LoC6Ducko7ddLVc7s4Aro9mxBvZnrK41RAIq0UeMxQoIh+k6IZ1SQt4yiqFiZ
        y7EWcldSfP7SZRK72egjeWaMZM5kDhbmIfx+hNVsTyTmBTO6pNSyHdvVxcVmI6C7o6UntfvUJgt5d
        /ankrKtLvtQvgC9bJZufNv5O6GtxJhpioJQPnHRDruMdEUxwFvetUKaGilvFI4R5EHegXrlGzs1Qy
        x+GynFyg==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNh2v-001zvF-OH; Sat, 20 Mar 2021 19:14:02 +0000
Date:   Sat, 20 Mar 2021 12:14:01 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/namei.c: Mundane typo fix
In-Reply-To: <20210320185332.27937-1-unixbhaskar@gmail.com>
Message-ID: <2de2fc53-d65-7ccf-dabe-d8af526048e5@bombadil.infradead.org>
References: <20210320185332.27937-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_121401_810997_0CF892D8 
X-CRM114-Status: GOOD (  12.52  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote: > > s/carfully/carefully/
    > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com> Acked-by: Randy
    Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Sun, 21 Mar 2021, Bhaskar Chowdhury wrote:

>
> s/carfully/carefully/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> fs/namei.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 216f16e74351..bd0592000d87 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2045,7 +2045,7 @@ static inline unsigned int fold_hash(unsigned long x, unsigned long y)
> #endif
>
> /*
> - * Return the hash of a string of known length.  This is carfully
> + * Return the hash of a string of known length.  This is carefully
>  * designed to match hash_name(), which is the more critical function.
>  * In particular, we must end by hashing a final word containing 0..7
>  * payload bytes, to match the way that hash_name() iterates until it
> --
> 2.26.2
>
>

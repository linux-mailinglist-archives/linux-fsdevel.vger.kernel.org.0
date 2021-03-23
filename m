Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75286346B80
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 22:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhCWV6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 17:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbhCWV6a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:58:30 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CAFC061574;
        Tue, 23 Mar 2021 14:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=tguUq1/+1debzLV6j9Qgw6nQZpGX4uuwNKugLMThEpg=; b=poBC+bwUGkwikBCg8Z6eMjckck
        YZtFGWnQEaSmbAOu8SkRB3iA9t0z3qw4zmTSUNa2oC/FWKKEVKQudBTRkN1vVYoKhCZAc4aQVZeKh
        FDRUQApRRoesq5atcre1b9j0GXWCNUriurqVYCFpcajVZuB46he57P7hRzNU7NyJIZZZk8F3c+ZKF
        aJsev2bZoUFH++pmRGCN67Yh4Wc46Y99XYJCEKipntI6XXy7gIu2DfLXk7LVkV084g8jEyDprRExs
        +8pRy993sSAh04TGM9Yiw7xBD67LtkN/F1aHWbf/IC+MZSWzGYPt5VieAnQ9msV9K3eNcqMYfXQzs
        eJ08bHsQ==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOp2e-00FoaL-8Q; Tue, 23 Mar 2021 21:58:24 +0000
Subject: Re: [RFC PATCH 4/4] docs: tmpfs: Add casefold options
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     krisman@collabora.com, smcv@collabora.com, kernel@collabora.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>
References: <20210323195941.69720-1-andrealmeid@collabora.com>
 <20210323195941.69720-5-andrealmeid@collabora.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ec9ce4a7-30a9-67a1-90ce-e7709f04eb12@infradead.org>
Date:   Tue, 23 Mar 2021 14:58:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210323195941.69720-5-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi--

On 3/23/21 12:59 PM, André Almeida wrote:
> Document mounting options to enable casefold support in tmpfs.
> 
> Signed-off-by: André Almeida <andrealmeid@collabora.com>
> ---
>  Documentation/filesystems/tmpfs.rst | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> index 0408c245785e..84c87c309bd7 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -170,6 +170,32 @@ So 'mount -t tmpfs -o size=10G,nr_inodes=10k,mode=700 tmpfs /mytmpfs'
>  will give you tmpfs instance on /mytmpfs which can allocate 10GB
>  RAM/SWAP in 10240 inodes and it is only accessible by root.
>  
> +tmpfs has the following mounting options for case-insesitive lookups support:
> +
> +=========   ==============================================================
> +casefold    Enable casefold support at this mount point using the given
> +            argument as enconding. Currently only utf8 encondings are supported.

                           encoding.                      encodings

> +cf_strict   Enable strict casefolding at this mouting point (disabled by

                                                 mount

> +            default). This means that invalid strings should be reject by the

                                                                   rejected

> +            file system.
> +=========   ==============================================================
> +
> +Note that this option doesn't enable casefold by default, one needs to set

                                                    default; one needs to set the

> +casefold flag per directory, setting the +F attribute in an empty directory. New
> +directories within a casefolded one will inherit the flag.


-- 
~Randy


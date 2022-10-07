Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9162E5F7BF9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 19:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiJGRC3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Oct 2022 13:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJGRCR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Oct 2022 13:02:17 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25523D5BD;
        Fri,  7 Oct 2022 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AQv93op+k5Gt9JN/aohlZjFMvqKcFqY8ovnVzXuwPuQ=; b=Pe/uWQRJRr6GwWj3Jav6a4p2nJ
        kNYc9uK/kB0GygBjbdhpymaU7lg7RxmcmstpYzLgvusDwDg/MwqVtrKSMI8fDGhAzTB3yOG2qqLf2
        Ro3zk1no8UKiiCrmJHYQY6NRtxaEnRKu9N0sjLxW6Nzrc4ADnq5W7lgUb+pcq/XdnM2FzwpKxxqXZ
        Qg4sbg7zj2jQnfb5LtIO+0kxVIENpfbBOkFdIa2AyTEuvFykXGlyv1WAHVP3ctIGNo/h+Bmo+O20w
        c/DhBVQ+gXs2ZyEk+dIFAwXgg3kqmpf4OE6WOCScPaEtsXURqdp7wTJJPpxJQYYWjCuvl36Nh8CEE
        poNb/34g==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ogqji-00DNEg-4I; Fri, 07 Oct 2022 19:02:10 +0200
Message-ID: <00780cd5-8c4b-dfe1-950d-393cbaaff3fb@igalia.com>
Date:   Fri, 7 Oct 2022 14:01:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 8/8] efi: pstore: Add module parameter for setting the
 record size
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-efi@vger.kernel.org
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-9-gpiccoli@igalia.com>
 <202210061614.8AA746094A@keescook>
 <CAMj1kXF4UyRMh2Y_KakeNBHvkHhTtavASTAxXinDO1rhPe_wYg@mail.gmail.com>
 <f857b97c-9fb5-8ef6-d1cb-3b8a02d0e655@igalia.com>
 <CAMj1kXFy-2KddGu+dgebAdU9v2sindxVoiHLWuVhqYw+R=kqng@mail.gmail.com>
 <2a341c4d-763e-cfa4-0537-93451d8614fa@igalia.com>
 <CAMj1kXE6aObn7hGneGMMiJ-ss7YaiYDFL+HqktYt2WMUpZnFjQ@mail.gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <CAMj1kXE6aObn7hGneGMMiJ-ss7YaiYDFL+HqktYt2WMUpZnFjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/10/2022 12:06, Ard Biesheuvel wrote:
> [...]
> Well, I did spot this oddity
> 
>         efi_pstore_info.buf = kmalloc(4096, GFP_KERNEL);
>         if (!efi_pstore_info.buf)
>                 return -ENOMEM;
> 
>        efi_pstore_info.bufsize = 1024;
> 
> So that hardcoded 4096 looks odd, but at least it is larger than the
> default 1024. So what happens if you increase the record size to >
> 4096?

This is a very good finding, thanks a bunch Ard and apologies for this
mistake!

Before this patch it was "safe" doing this way since the allocation was
4096 whereas the size value was 1024. Now, with my change this is not
valid anymore, and my feeling is that it worked fine in my tests because
I'm testing panic (which is a single CPU/no-IRQ scenario), so basically
we're corrupting memory...but nothing broke in my tests due to panic
scenario.

Thanks again, I'll fix that - need to allocate record_size.


Guilherme




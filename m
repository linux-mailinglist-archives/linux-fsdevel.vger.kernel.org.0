Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B774EC8B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 17:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348374AbiC3Prp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345538AbiC3Pro (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:47:44 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D58C3EB86
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 08:45:58 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id w141so16663083qkb.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Mar 2022 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZRaeRvMSmHF9/f3VZA83L1Ad1gWgQ6AapuQZkdtChkg=;
        b=5E4AvSlLr39zW743+y4nmD5ONJKJkUxJilrF0KKc7IKbLynZx6oEtoSKsZn/zodPep
         JRpcAS7fvU67nYh7Bl6a0+/U1k+sLqFAXCo+xP+afJiAwX2/datKj4boXYza1D9NR7Tg
         bQAKsoj92J5yXVt2iI+6ZfDUspgtGsik+hMT3IlkR21Qaz6vN4zbliGeRUWgv+KItZNq
         88piKdR5ZK65XYQ8f/a7aNmGFw0EUZ6CKyZfyxD7QRV2k7PYVJ75L31EdaKreeCLyUGT
         AXP/7b2wcuawlII2CKWLNeQX122a6yrXNq3/HxccoOn9CPWWRyYPM0BfnFtmBKWtoabx
         oEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZRaeRvMSmHF9/f3VZA83L1Ad1gWgQ6AapuQZkdtChkg=;
        b=UDythRz9Jig2tLWLe0miCZ/CzXK5/N8ZUiFtAZrxf1FEtvWpks33Udm/9MFl+7ua06
         AfFLHPi2uMNmMZb5Ln2dwhSQkL1mcA1OINxmjdxQeyHe/b51zcBiVKDbQ+qiw3tXqL+V
         HoebJ5MKmR/s5LGPgLew8EjxnDTpvgst8nvxrlNHTSY2i4ousW+0w2NufxcRrzoLq7Zl
         Tcumyz8aIEyuqO41orEJnj353Bvo3Zg+NTiL4ON0+pCSvyHAFa9CasKd5zyFboRGcq7h
         Ty4TuRF2PQaqbiNwIUUpIyNlkE8Q7QkSfqh5QfoC0M4JtYSnQhOCwGAkQWUU/C8EWHWn
         ak2g==
X-Gm-Message-State: AOAM532bJjgDXUMqGGrpPrdYgtTPfOVk+xcDGQ4xoSASIwwZytSSx6Lf
        06TlQJNC+xWKu4Kv790ZZUzi2MF+Duk3xg==
X-Google-Smtp-Source: ABdhPJzL8Fzh1Kd60oS+1fKDMTEalGJpmVCe9CS5AeRl4im57Pw/IhwHXaetBACH42nIj2JrjNqN5w==
X-Received: by 2002:a05:620a:484:b0:67e:16fe:3689 with SMTP id 4-20020a05620a048400b0067e16fe3689mr147904qkr.745.1648655157650;
        Wed, 30 Mar 2022 08:45:57 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id bs32-20020a05620a472000b0067d4560a516sm11392106qkb.32.2022.03.30.08.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 08:45:57 -0700 (PDT)
Date:   Wed, 30 Mar 2022 11:45:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     CGEL <cgel.zte@gmail.com>, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: make PSI annotations of submit_bio only work
 for file pages
Message-ID: <YkR7NPFIQ9h2AK9h@cmpxchg.org>
References: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
 <YjiMsGoXoDU+FwsS@cmpxchg.org>
 <623938d1.1c69fb81.52716.030f@mx.google.com>
 <YjnO3p6vvAjeMCFC@cmpxchg.org>
 <20220323061058.GA2343452@cgel.zte@gmail.com>
 <62441603.1c69fb81.4b06b.5a29@mx.google.com>
 <YkRUfuT3jGcqSw1Q@cmpxchg.org>
 <YkRVSIG6QKfDK/ES@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkRVSIG6QKfDK/ES@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 06:04:08AM -0700, Christoph Hellwig wrote:
> On Wed, Mar 30, 2022 at 09:00:46AM -0400, Johannes Weiner wrote:
> > If you want type distinction, we should move it all into MM code, like
> > Christoph is saying. Were swap code handles anon refaults and the page
> > cache code handles file refaults. This would be my preferred layering,
> > and my original patch did that: https://lkml.org/lkml/2019/7/22/1070.
> 
> FYI, I started redoing that version and I think with all the cleanups
> to filemap.c and the readahead code this can be done fairly nicely now:
> 
> http://git.infradead.org/users/hch/block.git/commitdiff/666abb29c6db870d3941acc5ac19e83fbc72cfd4

Yes, it's definitely much nicer now with the MM instantiating the
pages for ->readpage(s).

But AFAICS this breaks compressed btrfs (and erofs?) because those
still do additional add_to_page_cache_lru() and bio submissions.

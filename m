Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC564E36E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 03:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiCVCtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 22:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbiCVCtN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 22:49:13 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E12A4A909;
        Mon, 21 Mar 2022 19:47:47 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i65so7286333qkd.7;
        Mon, 21 Mar 2022 19:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fxbk8zHpadBwqoYmDWUAyGhNym0Al2auQQmaphKtiiI=;
        b=GdDoCGokDh+u7cg/P9lZNMt+SHdG22s06tywPEdHjucdE1iaWkgO6z5mcrXTCssh3m
         xddjQhiaAyJ4ztee0l3PHHz8SLECOipWwuo9Z7YzgGZg8l5KBQ0qahNF5OVpsIZnwmRN
         /3tlnx+ifjbh51aOUahVYMMmmH5G17X+aHFZ5dfw+ul/62LZhaMeVbiIeBh7H8JYfRGu
         6qCUEvtXAp1iNu1l6mo4Zjgg4OYH3UOnQT4d/dt0x9x+7IL38NuWOm0Gjpd+hvxHab2l
         itER/2KjWfEteiY0dspt07y7Vu1awvo/eUzsZCoyjyTxH9eXl7xVohcgqD+iRxLuoOgx
         tPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fxbk8zHpadBwqoYmDWUAyGhNym0Al2auQQmaphKtiiI=;
        b=V1XpMQgJUDG3hWQB9pErp/oecYM5UFyZ9QghLtyLMVz2Usg7D1F7mJk3uQEFq/Ow4x
         cWKObiJ7NTW+D2scdXxrOZ6n5ZZJPamWyKkc6LcPw8DPFA5uoagsci3II19MdJ1lYYTx
         anTgTA4C85ucWu8/lNWfmqjQeEUohfxcjSKFDuX95YG/Yih7ZBf9R/fQD6H3L10P/7TZ
         5E7WK5d9fFe4zFV5SstZtRhOXGVnrjaBeeKkfIkeBZP50R7p2QIC8KraRD73vU5iE7DA
         RRwzLM3BwozLmO7jsOIrYgA5JBLdbS/SVP3ucP0JuOD8vT/V31ggagu2piPwPYAyJgmB
         1Xmg==
X-Gm-Message-State: AOAM532SfLdMKbrZbDhXQepVjixRN8W9SVMCHI9mEo+gErL7a/5680jl
        51pI7JeyD5tXGiVgN1mGFMA=
X-Google-Smtp-Source: ABdhPJx14QPIkLwvpLxDulgHQkSvIzJ5/A5iBQZUcX+1EpSqW2syPZ3jYTL4hxxykk4WHJUT26iQDQ==
X-Received: by 2002:a05:620a:21dc:b0:67b:1209:7530 with SMTP id h28-20020a05620a21dc00b0067b12097530mr14336349qka.111.1647917266687;
        Mon, 21 Mar 2022 19:47:46 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k73-20020a37a14c000000b0067b316a4161sm9076188qke.120.2022.03.21.19.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 19:47:45 -0700 (PDT)
Message-ID: <623938d1.1c69fb81.52716.030f@mx.google.com>
X-Google-Original-Message-ID: <20220322024742.GA2326136@cgel.zte@gmail.com>
Date:   Tue, 22 Mar 2022 02:47:42 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: make PSI annotations of submit_bio only work
 for file pages
References: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
 <YjiMsGoXoDU+FwsS@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjiMsGoXoDU+FwsS@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 21, 2022 at 10:33:20AM -0400, Johannes Weiner wrote:
> On Wed, Mar 16, 2022 at 06:39:28AM +0000, cgel.zte@gmail.com wrote:
> > From: Yang Yang <yang.yang29@zte.com.cn>
> > 
> > psi tracks the time spent on submitting the IO of refaulting file pages
> > and anonymous pages[1]. But after we tracks refaulting anonymous pages
> > in swap_readpage[2][3], there is no need to track refaulting anonymous
> > pages in submit_bio.
> > 
> > So this patch can reduce redundant calling of psi_memstall_enter. And
> > make it easier to track refaulting file pages and anonymous pages
> > separately.
> 
> I don't think this is an improvement.
> 
> psi_memstall_enter() will check current->in_memstall once, detect the
> nested call, and bail. Your patch checks PageSwapBacked for every page
> being added. It's more branches for less robust code.

We are also working for a new patch to classify different reasons cause
psi_memstall_enter(): reclaim, thrashing, compact, etc. This will help
user to tuning sysctl, for example, if user see high compact delay, he
may try do adjust THP sysctl to reduce the compact delay.

To support that, we should distinguish what's the reason cause psi in
submit_io(), this patch does the job.

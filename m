Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC3E4E37AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 04:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbiCVDqD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Mar 2022 23:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiCVDqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:46:00 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0EF19C20;
        Mon, 21 Mar 2022 20:44:32 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id kl29so6609514qvb.2;
        Mon, 21 Mar 2022 20:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=XrmP5QvY9v5GfSMnu4vuXWWsz33rmP/bhFlcHw3wCB0=;
        b=SCQgrbnQiBATElkNySc+P2EvESrtkrBHSXxGF61YIy9c6z1Jom1CELWcUvzFVrDvRa
         bAOHUmF+f0GdV+bEpYclmQOXh1fXzZZygS9U/oQ9Rujr/IHQ2blU6WWoFcb/k/fiWmLx
         CmD8oxNSo1M3rlfA1T1p+5OWTZ3AzwSuqBfDCKmrL+yX5CCyxhCwMJoBJxdVAZp5SAeq
         7UFeBpOW3HsRN72yU6FT84Auf83Ao3nsnX8FHsxk59piAMHktHzDvcK5hANlsKClDjhI
         FCriZSIqeDtcFD3hPdyiEOw9MTTF8N1r3LQLP+GnWX21tt1ee1PRV7JqpoSejAlpyxAW
         Rq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=XrmP5QvY9v5GfSMnu4vuXWWsz33rmP/bhFlcHw3wCB0=;
        b=MoQY8AzNPuIevHMRvqBWNjbKl4mfuFZYDEveXTeLO9l4Pe0IGBHQRrybSUIbogZ9wW
         pxWHIv2i+svfUg1mJ7S9yCSDms2Xm6bHoDaokT+BntHPv04CkTrXBLyLqSdQgY0zhD2k
         gdaxepuSCOSaNYlX3NmeKACkxpEeCH5IVekqqHsxtNPzMSdeB/sgfPQ++jfz/z/C2dYB
         8w1KMKLVMMlotP0Ww8kTNYuRPYwem92SfDZMGSdVvapnXCj5qnzRTbWCI5a+iHGukU+u
         U63WJZXxhvrnCNtChUdVwjrDJB+gfBQKIyy9pLTALAtLycKv5lDGSztUYTUUa75iLTD5
         UaLg==
X-Gm-Message-State: AOAM5325oi7mS4hUM9c8eZUbYrqwijyeMlAvV14H7uaZvnnfQtb5z6I4
        Ve6ZPKuJiA4igu2tTNBIo+o=
X-Google-Smtp-Source: ABdhPJwVOoAsZhDiZ1fE+whpWR+QfbOW/feKY++VvePGtmd17Yj6x3BU/ZzxppQbTHJgb39Le2LBfg==
X-Received: by 2002:a05:6214:21aa:b0:440:cd95:323b with SMTP id t10-20020a05621421aa00b00440cd95323bmr18629030qvc.53.1647920672139;
        Mon, 21 Mar 2022 20:44:32 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b26-20020a05620a119a00b0067e5a092d45sm5481464qkk.11.2022.03.21.20.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 20:44:31 -0700 (PDT)
Message-ID: <6239461f.1c69fb81.df45.a622@mx.google.com>
X-Google-Original-Message-ID: <20220322034428.GA2327077@cgel.zte@gmail.com>
Date:   Tue, 22 Mar 2022 03:44:28 +0000
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

And PageSwapBacked checking is after unlikely(PageWorkingset(page), so I think
the impact is little.

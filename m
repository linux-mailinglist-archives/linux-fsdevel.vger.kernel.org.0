Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA984E4C90
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 07:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241782AbiCWGMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 02:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiCWGMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:12:36 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0076E8F0;
        Tue, 22 Mar 2022 23:11:03 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id kc20so534669qvb.3;
        Tue, 22 Mar 2022 23:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=ifWjR9jEFmFX8aRx9xc4ahzyvlT1JxK8sH59+zbMgcM=;
        b=d8yqVfswjLKnW065K+y9jlbglxjxi533dEaaajB2Hr5kQEVFHk2pIMnd0cKiv2Y5QK
         3zj6eHcsJdEnbNGBhm7UHtSffl9a8EpWvRgpB0SoC9Nexg0tsr4nhsswekoQM/3fbDvG
         y6iOwb+TNOEMoKJF6mM5yjLFxZHBlW/Pudhfnftit78UhaFAC9k36rDZgCZunoGDss9H
         xTnVjv9J0LRCPBpIxq14i8JUOVoJx9a+cnHay7bfSal0huT9hL2haYbYdA26AiBNMUo3
         ULwEOgzAC6/zeSHW1R/z/fAJPmPpL8mzbTM63WDgElWHRZspna3zcn8/R31hyJ3Cvpm/
         vdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=ifWjR9jEFmFX8aRx9xc4ahzyvlT1JxK8sH59+zbMgcM=;
        b=ij2XD7tDgngXdhFh6GS0fRj47OocRSKRIwnXGFpOf2Faf0IUxKRjeWR3jigYRF+78G
         s0kJi3cHEujr6lC/jPGm+9KFBAfH2uuWHZFL0+wFRCfd9TeMb4pmF13M1PX+c8DGB4Ao
         nZttAa3yxPNFsoZNDJ8vyyDHQQXHIrjvyQcWB+T89W0EiLP4fWa0EP/5OwpG8DxDPYSA
         rVC7s2WnAn+v7IqXsqBZSwf5DCGBaZS+LYxrH4KwKz9g0K1gTBsigMF/jal1zyrr7Ydb
         jNUUi0IlmmUpyRfXNRgdw3Iy7NuhMYWGfTtXT3QX+1uBbQW9KB9rnHNU3NIfXq6Sp9jS
         ueTA==
X-Gm-Message-State: AOAM5330Ji0y1No5bfF34yLbzviIRa4lu4UWhivK5xoraZJ7OjvEQdXN
        iHllHzK3a5i/HqRajk1ioqg=
X-Google-Smtp-Source: ABdhPJxgu4dweeqTZjUIM6RLqCD9cWzQSftS10ONwtj2woCx83xyIagtnBycyLjFBoH22jxt1oI4KA==
X-Received: by 2002:a05:6214:20e6:b0:440:f6d0:fe55 with SMTP id 6-20020a05621420e600b00440f6d0fe55mr20307116qvk.57.1648015862723;
        Tue, 22 Mar 2022 23:11:02 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b126-20020a376784000000b0067d21404704sm9845296qkc.131.2022.03.22.23.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 23:11:01 -0700 (PDT)
Message-ID: <623ab9f5.1c69fb81.66f4.5e68@mx.google.com>
X-Google-Original-Message-ID: <20220323061058.GA2343452@cgel.zte@gmail.com>
Date:   Wed, 23 Mar 2022 06:10:58 +0000
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
 <623938d1.1c69fb81.52716.030f@mx.google.com>
 <YjnO3p6vvAjeMCFC@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjnO3p6vvAjeMCFC@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 09:27:58AM -0400, Johannes Weiner wrote:
> On Tue, Mar 22, 2022 at 02:47:42AM +0000, CGEL wrote:
> > On Mon, Mar 21, 2022 at 10:33:20AM -0400, Johannes Weiner wrote:
> > > On Wed, Mar 16, 2022 at 06:39:28AM +0000, cgel.zte@gmail.com wrote:
> > > > From: Yang Yang <yang.yang29@zte.com.cn>
> > > > 
> > > > psi tracks the time spent on submitting the IO of refaulting file pages
> > > > and anonymous pages[1]. But after we tracks refaulting anonymous pages
> > > > in swap_readpage[2][3], there is no need to track refaulting anonymous
> > > > pages in submit_bio.
> > > > 
> > > > So this patch can reduce redundant calling of psi_memstall_enter. And
> > > > make it easier to track refaulting file pages and anonymous pages
> > > > separately.
> > > 
> > > I don't think this is an improvement.
> > > 
> > > psi_memstall_enter() will check current->in_memstall once, detect the
> > > nested call, and bail. Your patch checks PageSwapBacked for every page
> > > being added. It's more branches for less robust code.
> > 
> > We are also working for a new patch to classify different reasons cause
> > psi_memstall_enter(): reclaim, thrashing, compact, etc. This will help
> > user to tuning sysctl, for example, if user see high compact delay, he
> > may try do adjust THP sysctl to reduce the compact delay.
> > 
> > To support that, we should distinguish what's the reason cause psi in
> > submit_io(), this patch does the job.
> 
> Please submit these patches together then. On its own, this patch
> isn't desirable.
I think this patch has it's independent value, I try to make a better
explain.

1) This patch doesn't work it worse or even better
After this patch, swap workingset handle is simpler, file workingset
handle just has one more check, as below.
Before this patch handling swap workingset:
	a) in swap_readpage() call psi_memstall_enter() ->
	b) in __bio_add_page() test if should call bio_set_flag(), true ->
	c) in __bio_add_page() call bio_set_flag()
	d) in submit_bio() test if should call psi_memstall_enter(), true ->
	e) call psi_memstall_enter, detect the nested call, and bail.
	f) call bio_clear_flag if needed.
Before this patch handling file page workingset:
	a) in __bio_add_page() test if should call bio_set_flag(), true ->
	...
	b) call bio_clear_flag if needed.
After this patch handling swap workingset:
	a) in swap_readpage() call psi_memstall_enter() ->
	b) in __bio_add_page() test if should call bio_set_flag(), one more check, false and return.
	c) in submit_bio() test if should call psi_memstall_enter(), false and return.
After this patch handling file pages workingset:
	a) in __bio_add_page() test if should call bio_set_flag(), one more check, true ->
	...
	b) call bio_clear_flag if needed.

2) This patch help tools like kprobe to trace different workingset
After this patch we know workingset in submit_io() is only cause by file pages.

3) This patch will help code evolution
Such as psi classify, getdelays supports counting file pages workingset submit.

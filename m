Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996C24ED1A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 04:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbiCaCX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 22:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiCaCX2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 22:23:28 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DC06948F;
        Wed, 30 Mar 2022 19:21:42 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id q200so5451408qke.7;
        Wed, 30 Mar 2022 19:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=fapBwBmTAtIl71PilJuVvs3oAczvZVBG4yWVkxfNDvw=;
        b=qNjf2hw/mJxU2BwZ0lEfO1Ot0ulo9n347dsWCoWi8KPJGHibxtGdYuchQuxCqqFmPc
         AQJjnJoSZM+Mjr+mXGufwJwDvwumoqTyuFiUNIjTtP1tjdnNbywxBcfGHQD3vaW5B41e
         WbUN0/8N6PClw5lhuIGrZkgZMPFhn/sIehFqhreVdrREqp5LrYYsCVeFRtcrsKX0txsm
         /hsUshSgoc9gTt/nDEftNzc0iwrROGLdvbK78Sp3Uf2tOR8jtI1+WquMIQif6OHnc6nN
         xujOX6cb3A6dl1ZMpts8kIYBCr0UgTvRaUAUdAhJVrDEPLGPPnqNT82275Hi1tT/5sdv
         Mw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=fapBwBmTAtIl71PilJuVvs3oAczvZVBG4yWVkxfNDvw=;
        b=JV1NS8ZQfv28tAk6qMCeRJc3Bb6jdELojuAepWn92UpibBoAdX7lkRqEp1AZI+ZDTY
         12aHMjIuqQUDssojeB2xPAfrhJFTOuBjJ5Lkg24Dl8JWH2iHIVLRoBzpVV8Aa8LJ/xH+
         beNRmLO/3XfRVqUufzR1+yP4BeyfuyGBlo7ZwMDJVaEwe1LlArLOycDSVgk6BsF/etA7
         hV8sl9Pwe+PLPAYX/lf1atq1WnbRqiHeLLF+Rl87dRwpqQkUaX8JVKJZC8xOavBEpf+4
         W73FccnlhXW7+ItAO1dtZXOvN3dVzLQVlI15SIFOq/F8fDZLmI+pSqnM6Kpim2iHG0Qo
         15xQ==
X-Gm-Message-State: AOAM5303QDgOCfADfmN6rbKk3VIocjXFmwJF22uXw353M6xWkKkTGWQs
        WHgTviIXCNErXIGB7jXkTT/4vNc0ntw=
X-Google-Smtp-Source: ABdhPJxjao7zPdd9ruWc84WM1510HMOORDSbT4Y0wAKLB3HOzlnHxSIXthPQuoKYxNniDiJPRz7RBA==
X-Received: by 2002:a05:620a:15af:b0:67e:9b09:697e with SMTP id f15-20020a05620a15af00b0067e9b09697emr1924127qkk.139.1648693301324;
        Wed, 30 Mar 2022 19:21:41 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id b17-20020a05620a271100b00680a61f51c0sm10460952qkp.16.2022.03.30.19.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 19:21:40 -0700 (PDT)
Message-ID: <62451034.1c69fb81.1d16c.7023@mx.google.com>
X-Google-Original-Message-ID: <20220331022138.GA2390008@cgel.zte@gmail.com>
Date:   Thu, 31 Mar 2022 02:21:38 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] block/psi: make PSI annotations of submit_bio only work
 for file pages
References: <20220316063927.2128383-1-yang.yang29@zte.com.cn>
 <YjiMsGoXoDU+FwsS@cmpxchg.org>
 <623938d1.1c69fb81.52716.030f@mx.google.com>
 <YjnO3p6vvAjeMCFC@cmpxchg.org>
 <20220323061058.GA2343452@cgel.zte@gmail.com>
 <62441603.1c69fb81.4b06b.5a29@mx.google.com>
 <YkRUfuT3jGcqSw1Q@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkRUfuT3jGcqSw1Q@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 30, 2022 at 09:00:46AM -0400, Johannes Weiner wrote:
> On Wed, Mar 30, 2022 at 08:34:08AM +0000, CGEL wrote:
> > On Wed, Mar 23, 2022 at 06:11:03AM +0000, CGEL wrote:
> > > On Tue, Mar 22, 2022 at 09:27:58AM -0400, Johannes Weiner wrote:
> > > > On Tue, Mar 22, 2022 at 02:47:42AM +0000, CGEL wrote:
> > > > > On Mon, Mar 21, 2022 at 10:33:20AM -0400, Johannes Weiner wrote:
> > > > > > On Wed, Mar 16, 2022 at 06:39:28AM +0000, cgel.zte@gmail.com wrote:
> > > > > > > From: Yang Yang <yang.yang29@zte.com.cn>
> > > > > > > 
> > > > > > > psi tracks the time spent on submitting the IO of refaulting file pages
> > > > > > > and anonymous pages[1]. But after we tracks refaulting anonymous pages
> > > > > > > in swap_readpage[2][3], there is no need to track refaulting anonymous
> > > > > > > pages in submit_bio.
> > > > > > > 
> > > > > > > So this patch can reduce redundant calling of psi_memstall_enter. And
> > > > > > > make it easier to track refaulting file pages and anonymous pages
> > > > > > > separately.
> > > > > > 
> > > > > > I don't think this is an improvement.
> > > > > > 
> > > > > > psi_memstall_enter() will check current->in_memstall once, detect the
> > > > > > nested call, and bail. Your patch checks PageSwapBacked for every page
> > > > > > being added. It's more branches for less robust code.
> > > > > 
> > > > > We are also working for a new patch to classify different reasons cause
> > > > > psi_memstall_enter(): reclaim, thrashing, compact, etc. This will help
> > > > > user to tuning sysctl, for example, if user see high compact delay, he
> > > > > may try do adjust THP sysctl to reduce the compact delay.
> > > > > 
> > > > > To support that, we should distinguish what's the reason cause psi in
> > > > > submit_io(), this patch does the job.
> > > > 
> > > > Please submit these patches together then. On its own, this patch
> > > > isn't desirable.
> > > I think this patch has it's independent value, I try to make a better
> > > explain.
> 
> You missed the point about it complicating semantics.
> 
> Right now, the bio layer annotates stalls from queue contention. This
> is very simple. The swap code has relied on it in the past. It doesn't
> now, but that doesn't change what the concept is at the bio layer.
> 
> You patch explicitly codifies that the MM handles swap IOs, and the
> lower bio layer handles files. This asymmetry is ugly and error prone.
>
Yes this asymmetry is bad, we also don't think this patch is perfect.

But just as you said below, page cache creating is spread out multiple
filesystems, if we move psi_memstall_enter to the upper layer it would
maybe horrible repetition and also error prone. I think the primary
question is page cache code is not centralized, before it's be solved
(not likely?), we may have to make a compromise, and I think this
patch is a simple one.

Thanks.

> If you want type distinction, we should move it all into MM code, like
> Christoph is saying. Were swap code handles anon refaults and the page
> cache code handles file refaults. This would be my preferred layering,
> and my original patch did that: https://lkml.org/lkml/2019/7/22/1070.
> 
> But it was NAKed, and I had to agree with the argument. The page cache
> code is not very centralized, and the place where we deal with
> individual pages (and detect refaults) and where we submit bios (where
> the stalls occur) is spread out into multiple filesystems. There are
> 180 submit_bio() calls in fs/; you'd have to audit which ones are for
> page cache submissions, and then add stall annotations or use a new
> submit_bio_cache() wrapper that handles it. Changes in the filesystem
> could easily miss this protocol and silently break pressure detection.
>
> I would prefer the annotations to be at this level, I just don't see
> how to do it cleanly/robustly. Maybe Christoph has an idea, he
> understands the fs side much better than I do.

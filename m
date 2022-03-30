Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD4C4EBCCC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 10:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244384AbiC3If7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 04:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbiC3If6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:35:58 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B49267D33;
        Wed, 30 Mar 2022 01:34:13 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id d142so16092467qkc.4;
        Wed, 30 Mar 2022 01:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=NEl4ZyDKfaHyPMaCMLIIWJ8UZ/cbSlx3qxxzXdskCtU=;
        b=LDq7b0pfnJZF01oqy5hAlAiVxT6eMq7Wcmk+pic3Ja+xHWHCpM3H+VYapR9NexpzfB
         v9kN1kMRSKC3mwwhJUzsxKxZZ4xHbNRehU66WcwgAz6Kh/tNJhjWRElUXd6NpFztmPRN
         +rNkUKogg0au71YFk+Qve1jptzJxRtmIN/K5nT+rQwWewlB0S08QxzYkUylE94nfsnWD
         UR/pCuu1YLJoz7fGP09fzqOeFgfWU9rfPa0qdw08SL3FS7RWEDp2+Hij+STx2VJs3e1m
         eF+gF8fP36CnQYmUF7si7aTp9NfW0Dg156cTKFl+5xZrkAQGOPzY4hA43qTvAPpdJMuH
         dA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=NEl4ZyDKfaHyPMaCMLIIWJ8UZ/cbSlx3qxxzXdskCtU=;
        b=YQa7XKk3bISNx9NJD4CorO0Lgue6cAXHMc3mAo+NnXnilt70dsUsQjnwIco+OKUVGw
         9x3DU8S6vP8BELIlMrgwSzQMwGEL1+XWl8l7yFUVZ+E7/SYoI0qJpe1+SALLk8b/8swa
         RN5SqvYYOq7NGpQhDrIaJmmHwt8RZ1YH/EaSlvAM8OuO9SR3mM95IJj2kH0bayLlTAS7
         O/IMHw+yQo58Obim2B9D1kRqsCu7FhKOWG9SudtL9skN3i558uJEt7VthIV/t2vQ8VbE
         +AB1gf3QMG6GS+xQWagpQczoPP2SzHX1TI+j/pZm+BH40wM8ji78qkPwhf2K+VG27tsZ
         KH6Q==
X-Gm-Message-State: AOAM531ROXEAe8LVsjVHCnN/Yuds4s877QE2CmJsZ2sdLQf6u8fXkZq7
        T9Ro6mdnkYyEhifGmDxfmlw=
X-Google-Smtp-Source: ABdhPJxLEk73iI4AYBNyhqSPL7af7D8CCI3uVBSSdDDTHuZ0TK1TqZrrENR8Ez8y24FG624d2SQC6A==
X-Received: by 2002:a05:620a:450f:b0:67d:b1ee:bd3 with SMTP id t15-20020a05620a450f00b0067db1ee0bd3mr22742284qkp.766.1648629252203;
        Wed, 30 Mar 2022 01:34:12 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v9-20020a05620a0a8900b0067db9cc46a9sm10236553qkg.62.2022.03.30.01.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 01:34:11 -0700 (PDT)
Message-ID: <62441603.1c69fb81.4b06b.5a29@mx.google.com>
X-Google-Original-Message-ID: <20220330083408.GA2381634@cgel.zte@gmail.com>
Date:   Wed, 30 Mar 2022 08:34:08 +0000
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
 <20220323061058.GA2343452@cgel.zte@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323061058.GA2343452@cgel.zte@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 06:11:03AM +0000, CGEL wrote:
> On Tue, Mar 22, 2022 at 09:27:58AM -0400, Johannes Weiner wrote:
> > On Tue, Mar 22, 2022 at 02:47:42AM +0000, CGEL wrote:
> > > On Mon, Mar 21, 2022 at 10:33:20AM -0400, Johannes Weiner wrote:
> > > > On Wed, Mar 16, 2022 at 06:39:28AM +0000, cgel.zte@gmail.com wrote:
> > > > > From: Yang Yang <yang.yang29@zte.com.cn>
> > > > > 
> > > > > psi tracks the time spent on submitting the IO of refaulting file pages
> > > > > and anonymous pages[1]. But after we tracks refaulting anonymous pages
> > > > > in swap_readpage[2][3], there is no need to track refaulting anonymous
> > > > > pages in submit_bio.
> > > > > 
> > > > > So this patch can reduce redundant calling of psi_memstall_enter. And
> > > > > make it easier to track refaulting file pages and anonymous pages
> > > > > separately.
> > > > 
> > > > I don't think this is an improvement.
> > > > 
> > > > psi_memstall_enter() will check current->in_memstall once, detect the
> > > > nested call, and bail. Your patch checks PageSwapBacked for every page
> > > > being added. It's more branches for less robust code.
> > > 
> > > We are also working for a new patch to classify different reasons cause
> > > psi_memstall_enter(): reclaim, thrashing, compact, etc. This will help
> > > user to tuning sysctl, for example, if user see high compact delay, he
> > > may try do adjust THP sysctl to reduce the compact delay.
> > > 
> > > To support that, we should distinguish what's the reason cause psi in
> > > submit_io(), this patch does the job.
> > 
> > Please submit these patches together then. On its own, this patch
> > isn't desirable.
> I think this patch has it's independent value, I try to make a better
> explain.
> 
> 1) This patch doesn't work it worse or even better
> After this patch, swap workingset handle is simpler, file workingset
> handle just has one more check, as below.
> Before this patch handling swap workingset:
> 	a) in swap_readpage() call psi_memstall_enter() ->
> 	b) in __bio_add_page() test if should call bio_set_flag(), true ->
> 	c) in __bio_add_page() call bio_set_flag()
> 	d) in submit_bio() test if should call psi_memstall_enter(), true ->
> 	e) call psi_memstall_enter, detect the nested call, and bail.
> 	f) call bio_clear_flag if needed.
> Before this patch handling file page workingset:
> 	a) in __bio_add_page() test if should call bio_set_flag(), true ->
> 	...
> 	b) call bio_clear_flag if needed.
> After this patch handling swap workingset:
> 	a) in swap_readpage() call psi_memstall_enter() ->
> 	b) in __bio_add_page() test if should call bio_set_flag(), one more check, false and return.
> 	c) in submit_bio() test if should call psi_memstall_enter(), false and return.
> After this patch handling file pages workingset:
> 	a) in __bio_add_page() test if should call bio_set_flag(), one more check, true ->
> 	...
> 	b) call bio_clear_flag if needed.
> 
> 2) This patch help tools like kprobe to trace different workingset
> After this patch we know workingset in submit_io() is only cause by file pages.
> 
> 3) This patch will help code evolution
> Such as psi classify, getdelays supports counting file pages workingset submit.

Looking forward to your review, thanks!

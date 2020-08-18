Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC56248EBA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 21:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHRTcp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 15:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgHRTcj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:32:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481F7C061342
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 12:32:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c10so98743pjn.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Aug 2020 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x0mSpyWuIZWEqnvKTrrktYzEB/1FdLaDkbrBBFQhHGI=;
        b=YBL+4UJq3578y/m4bQy5uoo7Nos5o95utY8lW1upX/s0vb/FLrVGVMCzuFifk1dPhx
         FS+7mdSK1xVpOroIiChvRnxET12YMP9nU64n53nNoOwXQ96vfIG4aiLfWcAX2C+39/Gk
         ZoRUZ8tSedL0l/FxYUN3T4we0BDMxD7AK7+V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x0mSpyWuIZWEqnvKTrrktYzEB/1FdLaDkbrBBFQhHGI=;
        b=kSz1toF2xs0L/LpOFhAAVwbQ1jxAUkkr91zPDxbcB3nMD0vitLRbipanNe/WH7JOEu
         0y1iTU92+ka18a9Zn9D0pkLwG/u9T8CV17NzW8yRm9fEAi3TieCeDTNfnZoNy78tVfu3
         4QbDE3h+CZVyyQ+CfbyNuP6gNIQei+V3Y1Jp+Oc4o42aA4/pSntL/uCYxLczg/sub5U0
         erFKDVox8jF3422j6egyXQLvnDqfBKB3q1DhFG0I1KNz7/RPLC9dh/dqiCu9XIATmSPO
         mkciTaM7tvYlveNjEjKyXb88CztzKrL87atfKE+/iM65nz2jsKk+KYwmUqUiczTlOAQM
         0EgA==
X-Gm-Message-State: AOAM53181qX4OlbafgBWTWftOgvEN34ZvbI0qlLbLGAmlJ9l4ojnfAZV
        1m2FRaRmlfONQ0LKKdIiHU4CRQ==
X-Google-Smtp-Source: ABdhPJw8jgdFZ3pGF84Ud3h+RrnX4Nws4z4yjNUuEJuoeNPBKsDHr98xigXexLsC3VVrIZx/qGKWvA==
X-Received: by 2002:a17:90a:1d0f:: with SMTP id c15mr1201149pjd.180.1597779158415;
        Tue, 18 Aug 2020 12:32:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z6sm24659552pfg.68.2020.08.18.12.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:32:37 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:32:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 06/11] lkdtm: disable set_fs-based tests for
 !CONFIG_SET_FS
Message-ID: <202008181228.D2DBEC6C6@keescook>
References: <20200817073212.830069-1-hch@lst.de>
 <20200817073212.830069-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817073212.830069-7-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:32:07AM +0200, Christoph Hellwig wrote:
> Once we can't manipulate the address limit, we also can't test what
> happens when the manipulation is abused.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/misc/lkdtm/bugs.c     | 2 ++
>  drivers/misc/lkdtm/core.c     | 4 ++++
>  drivers/misc/lkdtm/usercopy.c | 2 ++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
> index 4dfbfd51bdf774..66f1800b1cb82d 100644
> --- a/drivers/misc/lkdtm/bugs.c
> +++ b/drivers/misc/lkdtm/bugs.c
> @@ -312,6 +312,7 @@ void lkdtm_CORRUPT_LIST_DEL(void)
>  		pr_err("list_del() corruption not detected!\n");
>  }
>  
> +#ifdef CONFIG_SET_FS
>  /* Test if unbalanced set_fs(KERNEL_DS)/set_fs(USER_DS) check exists. */
>  void lkdtm_CORRUPT_USER_DS(void)
>  {
> @@ -321,6 +322,7 @@ void lkdtm_CORRUPT_USER_DS(void)
>  	/* Make sure we do not keep running with a KERNEL_DS! */
>  	force_sig(SIGKILL);
>  }
> +#endif

Please let the test defined, but it should XFAIL with a message about
the CONFIG (see similar ifdefs in lkdtm).

>  /* Test that VMAP_STACK is actually allocating with a leading guard page */
>  void lkdtm_STACK_GUARD_PAGE_LEADING(void)
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index a5e344df916632..aae08b33a7ee2a 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -112,7 +112,9 @@ static const struct crashtype crashtypes[] = {
>  	CRASHTYPE(CORRUPT_STACK_STRONG),
>  	CRASHTYPE(CORRUPT_LIST_ADD),
>  	CRASHTYPE(CORRUPT_LIST_DEL),
> +#ifdef CONFIG_SET_FS
>  	CRASHTYPE(CORRUPT_USER_DS),
> +#endif
>  	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
>  	CRASHTYPE(STACK_GUARD_PAGE_TRAILING),
>  	CRASHTYPE(UNSET_SMEP),
> @@ -172,7 +174,9 @@ static const struct crashtype crashtypes[] = {
>  	CRASHTYPE(USERCOPY_STACK_FRAME_FROM),
>  	CRASHTYPE(USERCOPY_STACK_BEYOND),
>  	CRASHTYPE(USERCOPY_KERNEL),
> +#ifdef CONFIG_SET_FS
>  	CRASHTYPE(USERCOPY_KERNEL_DS),
> +#endif
>  	CRASHTYPE(STACKLEAK_ERASING),
>  	CRASHTYPE(CFI_FORWARD_PROTO),

Then none of these are needed.

>  #ifdef CONFIG_X86_32

Hmpf, this ifdef was missed in ae56942c1474 ("lkdtm: Make arch-specific
tests always available"). I will fix that.

> diff --git a/drivers/misc/lkdtm/usercopy.c b/drivers/misc/lkdtm/usercopy.c
> index b833367a45d053..4b632fe79ab6bb 100644
> --- a/drivers/misc/lkdtm/usercopy.c
> +++ b/drivers/misc/lkdtm/usercopy.c
> @@ -325,6 +325,7 @@ void lkdtm_USERCOPY_KERNEL(void)
>  	vm_munmap(user_addr, PAGE_SIZE);
>  }
>  
> +#ifdef CONFIG_SET_FS
>  void lkdtm_USERCOPY_KERNEL_DS(void)
>  {
>  	char __user *user_ptr =
> @@ -339,6 +340,7 @@ void lkdtm_USERCOPY_KERNEL_DS(void)
>  		pr_err("copy_to_user() to noncanonical address succeeded!?\n");
>  	set_fs(old_fs);
>  }
> +#endif

(Same here, please.)

>  
>  void __init lkdtm_usercopy_init(void)
>  {
> -- 
> 2.28.0
> 

-- 
Kees Cook

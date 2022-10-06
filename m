Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA365F71D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Oct 2022 01:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiJFXcY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Oct 2022 19:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbiJFXcW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Oct 2022 19:32:22 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7E6EB7E6
        for <linux-fsdevel@vger.kernel.org>; Thu,  6 Oct 2022 16:32:21 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 3so1904345pfw.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Oct 2022 16:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yKadD/ss3Cpk+H0BiQNsKCB2TUcUsguQbnKNQv5/kN0=;
        b=IgojzYuxWx2bE00Y98xdo0ZwWyX0MZ9wy7TvUxGiMEtFuoOEdEZjS5oN5sYhLmr4/Y
         eruo2kTpDD3jJCf8z9Cnoz2B8e8+sc8y8ii5mRZItYaKYWdBujy4y0lB/1GqI77x1B89
         XxigEm+0aaOtp5nSV4K9N2KfEMTfRLUI8tzy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yKadD/ss3Cpk+H0BiQNsKCB2TUcUsguQbnKNQv5/kN0=;
        b=FzvRBTczyBdSE0PebgbxA3zVfW/7vwHND1XOiBMBbpCisLdn3PnShb6DItNiq0faKI
         erVFisrKv4gKz2jrF418MNnJLz8UUFQbWYJxNbXCAYQgT5z7D5KcmNPxzdIb9mu8rHCd
         pWDY4CNA/W4WhdynuzZe4mF9mfZ18V+m8WxNbztHdWDvV+3tOmZNX0SDuDwPzd2rcMKm
         D51sS9VBkZvTUtVStluOj3F4QAgUf0b5iRQzEVXOCEWBiNwY8PnylEpPw/UClHdYzfdI
         F6uN9xc/6Rt7V3w3azKHbfggMbl7I5ND4wq062ym7utiNOTJC6lfWlqiaAtbiDZPkmvi
         RZzw==
X-Gm-Message-State: ACrzQf3sIb5Rq7l9z2C5prYT4dtUYatAGE13XkXB9UkppfLsTjOr743/
        AjA1CKrXM7WAaAZcPie8PFl/kg==
X-Google-Smtp-Source: AMsMyM58m5Pz9GELGoenXWXqCUJQc7hwYRza3mJYd2c7sDABYcd/pK5mE+G6qWj/gBEEKH1KKSgW9A==
X-Received: by 2002:a05:6a00:1c99:b0:562:6292:9e4e with SMTP id y25-20020a056a001c9900b0056262929e4emr1927478pfw.22.1665099141269;
        Thu, 06 Oct 2022 16:32:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709026f0200b00172dc6e1916sm153559plk.220.2022.10.06.16.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:32:20 -0700 (PDT)
Date:   Thu, 6 Oct 2022 16:32:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com
Subject: Re: [PATCH 2/8] pstore: Expose kmsg_bytes as a module parameter
Message-ID: <202210061628.76EAEB8@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-3-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006224212.569555-3-gpiccoli@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 06, 2022 at 07:42:06PM -0300, Guilherme G. Piccoli wrote:
> Currently this tuning is only exposed as a filesystem option,
> but most Linux distros automatically mount pstore, hence changing
> this setting requires remounting it. Also, if that mount option
> wasn't explicitly set it doesn't show up in mount information,
> so users cannot check what is the current value of kmsg_bytes.
> 
> Let's then expose it as a module parameter, allowing both user
> visibility at all times (even if not manually set) and also the
> possibility of setting that as a boot/module parameter.

I've been meaning to do this too. :)

> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>  fs/pstore/platform.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index c32957e4b256..be05090076ce 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -89,6 +89,11 @@ static char *compress =
>  module_param(compress, charp, 0444);
>  MODULE_PARM_DESC(compress, "compression to use");
>  
> +/* How much of the kernel log to snapshot */
> +unsigned long kmsg_bytes = CONFIG_PSTORE_DEFAULT_KMSG_BYTES;
> +module_param(kmsg_bytes, ulong, 0444);
> +MODULE_PARM_DESC(kmsg_bytes, "amount of kernel log to snapshot (in bytes)");
> +
>  /* Compression parameters */
>  static struct crypto_comp *tfm;
>  
> @@ -100,9 +105,6 @@ struct pstore_zbackend {
>  static char *big_oops_buf;
>  static size_t big_oops_buf_sz;
>  
> -/* How much of the console log to snapshot */
> -unsigned long kmsg_bytes = CONFIG_PSTORE_DEFAULT_KMSG_BYTES;
> -
>  void pstore_set_kmsg_bytes(int bytes)
>  {
>  	kmsg_bytes = bytes;
> -- 
> 2.38.0

Doing a mount will override the result, so I wonder if there should be
two variables, etc... not a concern for the normal use case.

Also, I've kind of wanted to get rid of a "default" for this and instead
use a value based on the compression vs record sizes, etc. But I didn't
explore it.

-- 
Kees Cook

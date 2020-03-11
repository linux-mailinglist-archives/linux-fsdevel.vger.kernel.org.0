Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36B06181F1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgCKRU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 13:20:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42791 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730322AbgCKRU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:20:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id t3so1393218plz.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2020 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P6EKaX1yk36UPbpCr2MJbOIatu0Z5wCwvN3X/nog/c4=;
        b=LIlHm+edvk5lAktjIoXzhtiMe7TTT/WwRCOMvZQCRPYaM69mTOO4DszMDJXXb9PdZZ
         ob6Qobrw3w6Ag6uVvMMeXLqv/UlP2LWjlRzi95wn7vhHMu4GxIGYERXnK+nXSZ+cccTO
         9igVbvTcDlKDU1TbWaTuP5QwiMLQtZdaWIC78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P6EKaX1yk36UPbpCr2MJbOIatu0Z5wCwvN3X/nog/c4=;
        b=aooUMEGNc3f1NZmEg6+qqu4V/5yW7XNtDn//+h/BuXy82K9EjFKelvMr5A7gLsNL3u
         aRlX4kQ7ApnC8lNB+tS9q/7/yAVxp31D71G+56oV5UV6OzWEAwTJYWTZUeUpcyGfKpJT
         8MHGNR47u9dPaed4zk4h+w1CWLjhHQF8KtYhdCwmmxnQqa2X9M4cF2874gq8PHgK0jp4
         DetAbA5cTBo58Qwj9YmvrWzlIZUf0e/y3+f4re1V3CaV17XezAKLEv530mD+HcXTxTy5
         PECI5J1NXUcVK1D0unzcNXYInp0CCBQspFcoQlHxDYekzwyLYF3mmOM4NuA3wbW1zV9D
         9q7w==
X-Gm-Message-State: ANhLgQ0o/qaZXB3LacP68jmpt2v5xGAudknCmUFjH5aDU/rrGJRE+7al
        P8CRPXDTR2Ti+pdBtg/4BYpgDUOkRto=
X-Google-Smtp-Source: ADFU+vv/0NCgP3hBuxLBflFF34xjIGPeo/MBF1uHeyjSSzOUs4fjmSmfzp3rj/UTad09GD08/7v+/Q==
X-Received: by 2002:a17:90a:cb90:: with SMTP id a16mr1689261pju.80.1583947224699;
        Wed, 11 Mar 2020 10:20:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v123sm24901012pfb.85.2020.03.11.10.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:20:23 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:20:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs_parse: Remove pr_notice() about each validation
Message-ID: <202003111015.E263BE9448@keescook>
References: <202003061617.A8835CAAF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003061617.A8835CAAF@keescook>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Andrew,

Can you pick this up in -mm?

Thanks!

-Kees

On Fri, Mar 06, 2020 at 04:20:02PM -0800, Kees Cook wrote:
> This notice fills my boot logs with scary-looking asterisks but doesn't
> really tell me anything. Let's just remove it; validation errors
> are already reported separately, so this is just a redundant list of
> filesystems.
> 
> $ dmesg | grep VALIDATE
> [    0.306256] *** VALIDATE tmpfs ***
> [    0.307422] *** VALIDATE proc ***
> [    0.308355] *** VALIDATE cgroup ***
> [    0.308741] *** VALIDATE cgroup2 ***
> [    0.813256] *** VALIDATE bpf ***
> [    0.815272] *** VALIDATE ramfs ***
> [    0.815665] *** VALIDATE hugetlbfs ***
> [    0.876970] *** VALIDATE nfs ***
> [    0.877383] *** VALIDATE nfs4 ***
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/fs_parser.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/fs_parser.c b/fs/fs_parser.c
> index 7e6fb43f9541..ab53e42a874a 100644
> --- a/fs/fs_parser.c
> +++ b/fs/fs_parser.c
> @@ -368,8 +368,6 @@ bool fs_validate_description(const char *name,
>  	const struct fs_parameter_spec *param, *p2;
>  	bool good = true;
>  
> -	pr_notice("*** VALIDATE %s ***\n", name);
> -
>  	for (param = desc; param->name; param++) {
>  		/* Check for duplicate parameter names */
>  		for (p2 = desc; p2 < param; p2++) {
> -- 
> 2.20.1
> 
> 
> -- 
> Kees Cook

-- 
Kees Cook

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED06751193
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 21:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjGLT66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 15:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGLT64 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:58:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47011FDE
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 12:58:55 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-66869feb7d1so4238727b3a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 12:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689191935; x=1691783935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IM1dSYo+80BYxXSJlIL/sk/xBjg6Ots+Pol0AVH4Yb0=;
        b=kN0riAjmUZltvjS1ZZu/cmL9YDBQwpNyRLMnVeyJUsFYI7J0wzmmClyaLlqoVavvmR
         HX0aXQxW3ZgAMNfjI5b5Zwx9uGTFHByzmco0yjmVtRRTEK4R9DkGvVDg6OGwrOpdcj56
         K19maljE78z0Ngq7vlqpfwfvl2QxEWWBAC8oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689191935; x=1691783935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IM1dSYo+80BYxXSJlIL/sk/xBjg6Ots+Pol0AVH4Yb0=;
        b=akY5waD5HiNSK2NOSeBCbAHQFFzNfGsLZdaCkBOTev6o5AlhNkHx5DkqMuBtMvqDhs
         4VppCvVrJSa7RsrGJK8+TMdkK1qsKqz0xd93dj1I6Hf1utLwz9vToCYq+9ettehsZyoB
         wpS8eGz/9jIwO3sYEakrWuyRW/Xr54PXbt5Uq9Qr9Bhsel/Pm2gpF/eZ6ChBb+tp+e2K
         XlWx28uXXuSs0bO/EdfDeCFkPq5wmFcIyKHgiYoKzfOU1H4+R0aShCcJ8xCLKP1V7PNn
         QAVidynoscICepgoJ5ycCADdOm5cPrLRJHkvv0zY8P1GDX2E5FWue3WOWnusjEOEdAL3
         W21w==
X-Gm-Message-State: ABy/qLbOOYN1y9VrBVi+n4Z0sf/BAkeNGeMIMfKDao7oSzWrodtcH5io
        zz0SeMemOZ0hEiMN30RysS5aZ9jOemoZtmvphHM=
X-Google-Smtp-Source: APBJJlE4+AsaRrpGGfmncTL94MB7s8dvZvP4yBy4eC77VHo8u3xCXxW7nvKcyGe+QqgE6q1NDBivMQ==
X-Received: by 2002:a05:6a20:e685:b0:132:c11d:4582 with SMTP id mz5-20020a056a20e68500b00132c11d4582mr2302449pzb.3.1689191935305;
        Wed, 12 Jul 2023 12:58:55 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u22-20020aa78396000000b0068285a7f107sm4080729pfm.177.2023.07.12.12.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 12:58:54 -0700 (PDT)
Date:   Wed, 12 Jul 2023 12:58:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 29/32] lib/string_helpers: string_get_size() now returns
 characters wrote
Message-ID: <202307121248.36919B223@keescook>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-30-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509165657.1735798-30-kent.overstreet@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 09, 2023 at 12:56:54PM -0400, Kent Overstreet wrote:
> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> printbuf now needs to know the number of characters that would have been
> written if the buffer was too small, like snprintf(); this changes
> string_get_size() to return the the return value of snprintf().

Unfortunately, snprintf doesn't return characters written, it return
what it TRIED to write, and can cause a lot of problems[1]. This patch
would be fine with me if the snprintf was also replaced by scnprintf,
which will return the actual string length copied (or 0) *not* including
the trailing %NUL.

> [...]
> @@ -126,8 +126,8 @@ void string_get_size(u64 size, u64 blk_size, const enum string_size_units units,
>  	else
>  		unit = units_str[units][i];
>  
> -	snprintf(buf, len, "%u%s %s", (u32)size,
> -		 tmp, unit);
> +	return snprintf(buf, len, "%u%s %s", (u32)size,
> +			tmp, unit);

-Kees

[1] https://github.com/KSPP/linux/issues/105

-- 
Kees Cook

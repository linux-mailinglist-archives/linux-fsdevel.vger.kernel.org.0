Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CAB73747D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 20:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjFTSm6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 14:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjFTSm5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:42:57 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468971737
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 11:42:52 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666edfc50deso2588216b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 11:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687286571; x=1689878571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l+Plwr1huw+Iprthw8GSo9mwUqiU0W0HO5ZTEyvRXxM=;
        b=ky7pjJzMtQWP1zNtVfoPIiocJ5Jjmz3iNOCu22pPgRJ4IKBDArGJn/fwGyzo3UioAR
         He6IkG//7leBnBUqOmTMyScv+sRQmvzUHonIIvdPFuBCHhc9olFgH1HsitbSs7F7lvml
         fT25rEFkDoERwbsxJYyGjK+WRwU/fdTKFC/0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687286571; x=1689878571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+Plwr1huw+Iprthw8GSo9mwUqiU0W0HO5ZTEyvRXxM=;
        b=e5TIPSg7dGA7Bv8cURDbBPgFFBaL75sD1EcPbwm8cG50uOFoiHniRZyFBWNWM3VKz9
         IEGl3+cjtmo9x7VFY/SU/9jzSH9V3INP/yyD/Myiue5aRVNxh5e31T6JEHEguiFAciv9
         5n33ZeGn2YoYuTXNd8JYc8x6lg3dghDXwq8PI2KT1K52/m8qix5EbzyiQ65rhauLWDNl
         Kk0ezPGjsugjK9p+TGwUJbSjkByuIlgr+mWnUWziSjZiuDdKKqE9hTPkLisgW+TNxobi
         mYh4I9UJdfD0Lx6wMMCG4YtOT4EmSRLX88drKPSfZn5qMInhMDp3DjoafNd9DXCC3QDE
         BymA==
X-Gm-Message-State: AC+VfDyZ5t6/DvNIZ+YDfexDoPDS7GCcFt7B5nHDS/UL1Tdhd0oJ6FWI
        gQ1en334uL3F+u0aZoG4mFCHDfZ+j+5nQNLmXtw=
X-Google-Smtp-Source: ACHHUZ6xyUn85z6Ohu6udB7Pzp4abdWNuTB2aieXWsmYAErGG6uR+KUaoZPZKjpuZDilSEYoGKMxhA==
X-Received: by 2002:a05:6a00:2353:b0:666:b22d:c6e0 with SMTP id j19-20020a056a00235300b00666b22dc6e0mr16497710pfj.11.1687286571456;
        Tue, 20 Jun 2023 11:42:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r23-20020a62e417000000b0063d670ad850sm1662655pfh.92.2023.06.20.11.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 11:42:50 -0700 (PDT)
Date:   Tue, 20 Jun 2023 11:42:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] readdir: Replace one-element arrays with
 flexible-array members
Message-ID: <202306201142.235D900@keescook>
References: <ZJHiPJkNKwxkKz1c@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJHiPJkNKwxkKz1c@work>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 20, 2023 at 11:30:36AM -0600, Gustavo A. R. Silva wrote:
> One-element arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace one-element arrays with flexible-array
> members in multiple structures.
> 
> Address the following -Wstringop-overflow warnings seen when built
> m68k architecture with m5307c3_defconfig configuration:
> In function '__put_user_fn',
>     inlined from 'fillonedir' at fs/readdir.c:170:2:
> include/asm-generic/uaccess.h:49:35: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>    49 |                 *(u8 __force *)to = *(u8 *)from;
>       |                 ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
> fs/readdir.c: In function 'fillonedir':
> fs/readdir.c:134:25: note: at offset 1 into destination object 'd_name' of size 1
>   134 |         char            d_name[1];
>       |                         ^~~~~~
> In function '__put_user_fn',
>     inlined from 'filldir' at fs/readdir.c:257:2:
> include/asm-generic/uaccess.h:49:35: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>    49 |                 *(u8 __force *)to = *(u8 *)from;
>       |                 ~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
> fs/readdir.c: In function 'filldir':
> fs/readdir.c:211:25: note: at offset 1 into destination object 'd_name' of size 1
>   211 |         char            d_name[1];
>       |                         ^~~~~~
> 
> This helps with the ongoing efforts to globally enable
> -Wstringop-overflow.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/312
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks! We're getting closer every day to killing this code pattern
for good. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

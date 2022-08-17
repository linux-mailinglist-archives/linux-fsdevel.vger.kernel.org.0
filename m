Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D8D5977AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238004AbiHQUMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbiHQUMC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:12:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A8560534
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:12:01 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m2so12916924pls.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=HfC3dMpEngb7r9gnYszZZUkGHTRJbCSwAF6hsjZawl8=;
        b=VgN2NI+Ezj1YnwZA75qkUzO3odm7nQ/YsFK2soo32JnPYdtR6gEuOdUGqLBg8c5ktf
         fCo70wM3ALHe+y+fUNIROShP5H6+3xzGZPkl98pJmQZYK+HzHeTl7B8BF44BfwOOv+ir
         h+sT7VUYnSBUCMIx81qQvnB+TETrbRV0froDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=HfC3dMpEngb7r9gnYszZZUkGHTRJbCSwAF6hsjZawl8=;
        b=n2sc2yYcPR3KKRCe8YajXMd72bIn/5scDdGGZpMBKStvHOPzKKk5AbLASCwKViqqcj
         rHu1PxWV3wcrKlqjY+EWVMhzhEtShgd+pePVyHeLtKx9gV77JOmQ4HoHthA5MUbOkdW3
         szTVAQODQQNbTA9UBs1/Xzi/DOIGGV7BM3LV3ewFJvme1TgtukiQfHotrAUNfhmu/fKx
         YqegH5ocn75aUvDbLakoe8a0Of4RuNqszyDOgle5GrJEqPTBLOE2IdfJEkquaqEcFOJZ
         tm2MLz9lBPQgeafKvKyHvfd4lz9IDnCKptK++w2vdgFtvLAtk7hNnQ42QQ9kULTI9SYi
         ckig==
X-Gm-Message-State: ACgBeo1wCpHfxzNHjCQiR+5q/63bBr5HW+lBVdHxI9GXb+tvIfrt4wkl
        lp17LtTbWZmMR9QzYuhjs+t6uQ==
X-Google-Smtp-Source: AA6agR5O8XGj1uDOVttCpuLlRr7eJO5srWmKa+1LSIBXqFLAGYz3aii6rcP0HxPmAHhk8CX5FB3voQ==
X-Received: by 2002:a17:903:1246:b0:171:5033:85c with SMTP id u6-20020a170903124600b001715033085cmr27932780plh.146.1660767120719;
        Wed, 17 Aug 2022 13:12:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j15-20020a170903024f00b0015e8d4eb1d7sm346970plh.33.2022.08.17.13.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:11:59 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:11:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH v9 13/27] rust: export generated symbols
Message-ID: <202208171311.73A2CAAA6@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-14-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-14-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:41:58PM +0200, Miguel Ojeda wrote:
> All symbols are reexported reusing the `EXPORT_SYMBOL_GPL` macro
> from C. The lists of symbols are generated on the fly.
> 
> There are three main sets of symbols to distinguish:
> 
>   - The ones from the `core` and `alloc` crates (from the Rust
>     standard library). The code is licensed as Apache/MIT.
> 
>   - The ones from our abstractions in the `kernel` crate.
> 
>   - The helpers (already exported since they are not generated).
> 
> We export everything as GPL. This ensures we do not mistakenly
> expose GPL kernel symbols/features as non-GPL, even indirectly.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

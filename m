Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91957597785
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241728AbiHQUHm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241770AbiHQUH0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:07:26 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49513A6C26
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:07:22 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y141so12940321pfb.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=L1J+Db0VnmbiI3Iaaum15jtXnTuosKmaYb/Lkdrr5jE=;
        b=U+gyR2Mo78uIYzbWklKeKt4ZYdel9+/phgy56njeKiM+XlSgX/waUrlrw5+SfCLNVY
         xSEVXltiRRK6gqaK7QEC7WqHfljzsXVLHRQNE7H8NH0JwmVqwyV0Ejps/JAgMjbD423b
         y183iG/Lv20mPJotIXHLSPFvBKTfSLLi7FqM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=L1J+Db0VnmbiI3Iaaum15jtXnTuosKmaYb/Lkdrr5jE=;
        b=sR/AaM0yzjVFv+Kce3TCp+2BPN4jO1qC8dTymJSkG+LaRvtIfoI98tzGrpHqlZEG62
         ly8x1mywAc/FzwF5hxPtxEU2BcguzKsiKSuXk7tcBIqbcdgxWFs0K2ae6OuJJI8F14PW
         EZZMpkz7gapLM+FYJGYgej4w9276VpLD/ETco99bbUtptJDIfcml5+s6YnIYlHh2KG8q
         o9BmGoAJnp0Oc2RN2tl64iii6AAQT6eGyqu9jeIXC/ZHrzPUgN5r+OojCPuhxTtQwziw
         RiE4B2YO52tZ6K5wfw9ji6HG08ZP1lRmGMKFjGFBHk3q6yMo8dRxG2IQ+OgHJUxEGeYo
         P/mQ==
X-Gm-Message-State: ACgBeo2rqyfYZGttrkGERKy7FFVpXexxmc7re9HgRRXD2lYIvqXoSpDH
        xRzFpN7aW13u8XUxKUqSNSiglw==
X-Google-Smtp-Source: AA6agR56B2zJ+PZNRuW9rvybbFIh2ikn6WdkK9CVsOAMnbryGSeDrgue8aGoJ4yGi3x0wgdFS9gvGA==
X-Received: by 2002:a05:6a00:b8c:b0:52e:d6b4:d5a2 with SMTP id g12-20020a056a000b8c00b0052ed6b4d5a2mr26589037pfj.72.1660766841593;
        Wed, 17 Aug 2022 13:07:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w1-20020a170902904100b0016be6a554b5sm302013plz.233.2022.08.17.13.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:07:20 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:07:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v9 07/27] rust: import upstream `alloc` crate
Message-ID: <202208171257.E256DAA@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-8-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-8-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:41:52PM +0200, Miguel Ojeda wrote:
> This is a subset of the Rust standard library `alloc` crate,
> version 1.62.0, licensed under "Apache-2.0 OR MIT", from:
> 
>     https://github.com/rust-lang/rust/tree/1.62.0/library/alloc/src
> 
> The files are copied as-is, with no modifications whatsoever
> (not even adding the SPDX identifiers).
> 
> For copyright details, please see:
> 
>     https://github.com/rust-lang/rust/blob/1.62.0/COPYRIGHT
> 
> The next patch modifies these files as needed for use within
> the kernel. This patch split allows reviewers to double-check
> the import and to clearly see the differences introduced.

Can you include an easy script (in the commit log) for this kind of
verification?

For this, I have done:

$ git am 0001-rust-import-upstream-alloc-crate.patch
$ for i in $(diffstat -lp3 0001-rust-import-upstream-alloc-crate.patch); do
	wget --quiet -O check.rs \
	 https://github.com/rust-lang/rust/raw/1.62.0/library/alloc/src/$i
	diff -up rust/alloc/$i check.rs && echo $i: ok
	rm -f check.rs
done

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

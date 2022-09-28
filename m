Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66005EE07F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 17:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiI1Pbe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiI1PbK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:31:10 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E965E665;
        Wed, 28 Sep 2022 08:29:54 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id z6so20420542wrq.1;
        Wed, 28 Sep 2022 08:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=U4dfxCOtpXm2iIv192KdpqzJp/F1yD6Pk1tXFLgpuUI=;
        b=Z9CQjXskAc6LrZDIE2I9A4QZ8wXjAcCsltHUH2Drbj6M63Fc0ZXOa7t37ZJ30YThco
         tOXNgsPRYaYPoV0u0t69ol3Q324MVNuRq3jArjvb+tLsXeZN0rhtG9CBjRG487IoKPs/
         JQRdtgnOM2hEKnai66rIhDXyTXFFslUvSknYyyaTrtUbG6uWIUINteaj7lkehOjZflLs
         ynIP4vQeMw9zkP5GrnOjTfK53Y/j/P5yT/QZ3ebihsZj6OY6ddrKri7ql2OZvrF701NU
         JiK/JNqp5Q7o2YG9hBUwULhjESt/f3eugPJLGXemek1TOgAQUV6pnmUQCvRj9j0Hd6sf
         Klqg==
X-Gm-Message-State: ACrzQf2bgodYsJ/sPp9L2WRbfXBufejZPhnbXLLaSqg7gU8K/DKsVbBw
        T0TeLdeCeC0UjRIg02HZGzI=
X-Google-Smtp-Source: AMsMyM5OTNW6IKVdBtKnKaByGNB9jKdBhPhqyWANjliIhwqeqFJZczom9Bz3OlzRDDx7ON7PTYOFEQ==
X-Received: by 2002:adf:f7c7:0:b0:22c:be66:dd6f with SMTP id a7-20020adff7c7000000b0022cbe66dd6fmr6155609wrq.144.1664378985754;
        Wed, 28 Sep 2022 08:29:45 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c1c1300b003a5ca627333sm2391110wms.8.2022.09.28.08.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 08:29:45 -0700 (PDT)
Date:   Wed, 28 Sep 2022 15:29:43 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v10 10/27] rust: add `macros` crate
Message-ID: <YzRoZwhxE4182cm2@liuwe-devbox-debian-v2>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-11-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-11-ojeda@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:41PM +0200, Miguel Ojeda wrote:
> This crate contains all the procedural macros ("proc macros")
> shared by all the kernel.
> 
> Procedural macros allow to create syntax extensions. They run at
> compile-time and can consume as well as produce Rust syntax.
> 
> For instance, the `module!` macro that is used by Rust modules
> is implemented here. It allows to easily declare the equivalent
> information to the `MODULE_*` macros in C modules, e.g.:
> 
>     module! {
>         type: RustMinimal,
>         name: b"rust_minimal",
>         author: b"Rust for Linux Contributors",
>         description: b"Rust minimal sample",
>         license: b"GPL",
>     }

I don't use / know much of procedural macros, so I don't feel like I'm
qualified to review this patch.

Just a general question: what is the house rule for adding new proc
macros? They are powerful tools. I can see their value in `module!`
because writing all that boilerplate by hand is just painful. Yet they
are not straightforward to understand. It is difficult, just by looking
at the macro, to fully grasp what the final code looks like (though the
rsi target will help). Is there a concern that proc macro gets abused?

Thanks,
Wei.

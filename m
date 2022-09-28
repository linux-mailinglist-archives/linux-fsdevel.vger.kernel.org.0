Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB635EDF24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 16:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbiI1Ot1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 10:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233695AbiI1OtY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:49:24 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56938E462;
        Wed, 28 Sep 2022 07:49:22 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so1163069wmb.0;
        Wed, 28 Sep 2022 07:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=b++TaSXpJUvwsLorqpvjYCrKiWF0sRAAlUL/l9wAjnM=;
        b=ks9jU2reZprjujw6DQf+Ec0FIgBM6wY72U2sjLNWyiIiGmwFyc/xocmTC5JnaIsv5r
         C54GvNxK1fyJbqBgl/AouMbi7EE5a47p6ZpCNj/KEB/R3DpdALgWfqig6RBB9D99kzdI
         qKhttrHYqCd6p5EZdUrUnAgV9YL7vX599ESKydeiMyhfQfxTDtb9WNWpk+NWiGRv8KNs
         r8LmaV8Ud3zp1/GUMhjJpEDKYbrvZiMDRP+v/vWN/C9tyYUtRRy4J4tt13xeTKwc1hID
         s7V05pJ+2o+zM0lOVMcxE7KbY39Y8uf1eeZLZIiUKQuNuWddhwulvUfF/XmvmitcpOxz
         S7og==
X-Gm-Message-State: ACrzQf3UMZyPZ7ubQDfRqa9FIRmQRFN/fz8IOdzZRTRNZSjyEz27n37L
        LOXliYB1Hemt352ivQL33IE=
X-Google-Smtp-Source: AMsMyM4BICEsTCiOwKDYNZM6kA80a/1z/SDCkkFsgQ5RHyVrv0H+SFEHVYvZEBLAVJfET0dprJibhw==
X-Received: by 2002:a1c:7315:0:b0:3b4:e1b8:47b2 with SMTP id d21-20020a1c7315000000b003b4e1b847b2mr7119813wmb.165.1664376561208;
        Wed, 28 Sep 2022 07:49:21 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d45c8000000b0022ca921dc67sm4325744wrs.88.2022.09.28.07.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:49:20 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:49:16 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Finn Behrens <me@kloenk.de>, Miguel Cano <macanroj@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v10 20/27] scripts: add `rust_is_available.sh`
Message-ID: <YzRe7NX4rRwor3QL@liuwe-devbox-debian-v2>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-21-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-21-ojeda@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:51PM +0200, Miguel Ojeda wrote:
> This script tests whether the Rust toolchain requirements are in place
> to enable Rust support. It uses `min-tool-version.sh` to fetch
> the version numbers.
> 
> The build system will call it to set `CONFIG_RUST_IS_AVAILABLE` in
> a later patch.
> 
> It also has an option (`-v`) to explain what is missing, which is
> useful to set up the development environment. This is used via
> the `make rustavailable` target added in a later patch.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Finn Behrens <me@kloenk.de>
> Signed-off-by: Finn Behrens <me@kloenk.de>
> Co-developed-by: Miguel Cano <macanroj@gmail.com>
> Signed-off-by: Miguel Cano <macanroj@gmail.com>
> Co-developed-by: Tiago Lam <tiagolam@gmail.com>
> Signed-off-by: Tiago Lam <tiagolam@gmail.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4226E5977AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241840AbiHQUOt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241858AbiHQUOk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:14:40 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C238F5B79A
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:14:35 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id z187so12944059pfb.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=FbyLuHm2xhCUGL19AXt8ffDVo0+YYpSKzX1/TVHy8eM=;
        b=Lv35uPWK2dCxFc6yKVS0QrTwKJd+DyqJAJDYLYlMNmXnRdKNAscIzcoSbCxJgpBnQB
         wQyvuIuUxU1fialRwVmxITfAZuI+GS568dLSXNWfMr5o3ox+DM5xajm7FgElyHdDnT46
         zfV825m20a/8rKJz/wJGMOGiHSoVcZptheJsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FbyLuHm2xhCUGL19AXt8ffDVo0+YYpSKzX1/TVHy8eM=;
        b=R6dq8/bKTi2wmkLH4/CyjpBSWkhCp0onq7ZLf1HVWOTDDsGyIVFwTevocrU+LERU2b
         i5+k6LWPp/HRr7otSL5W9nhD69jeoPteYGABnK61UjBzRxlu47QQAgS5g7j6gPSi62on
         xS9C/7hCzuWGA1kyCsuoIy/5WMWhnbj+EJW6cOrKVbWYQwX9LXYdIWrvl+ttu1o/uj5c
         7tlEp4Slvnyk7FS3Um6h37/vfEEs0vvbkHr74onZ1zfSy1heBBz3LYViiZz6w8zWtQYl
         GFFb08nBWbMAYXIImS2ftazXi0johQo/PiBU24kli8esB77iW8dTFdO1T+KTodnxwf9u
         ErXw==
X-Gm-Message-State: ACgBeo0XqpwOPEIHThM4zVoU86CmcDgjJVKTIPhmKRlI1kel0o09VPbl
        sF+vTUVPa07ZPXxd+H/kr0HxHg==
X-Google-Smtp-Source: AA6agR5BHQ+uwX7K+UI84QLWNJT1fb4lGGawfZJ9CNwTPRxCSbqxFPJWBKPpaXPBRf6W1dCupD0O8g==
X-Received: by 2002:a65:458c:0:b0:428:ee87:33a8 with SMTP id o12-20020a65458c000000b00428ee8733a8mr13953189pgq.272.1660767274298;
        Wed, 17 Aug 2022 13:14:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e3-20020a056a0000c300b0052e7f103138sm10910092pfj.38.2022.08.17.13.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:14:33 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:14:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        David Gow <davidgow@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v9 19/27] scripts: add `generate_rust_target.rs`
Message-ID: <202208171314.D38EF72778@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-20-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-20-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:42:04PM +0200, Miguel Ojeda wrote:
> This script takes care of generating the custom target specification
> file for `rustc`, based on the kernel configuration.
> 
> It also serves as an example of a Rust host program.
> 
> A dummy architecture is kept in this patch so that a later patch
> adds x86 support on top with as few changes as possible.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

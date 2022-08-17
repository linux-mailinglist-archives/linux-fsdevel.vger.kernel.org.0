Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF195977F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241905AbiHQU2U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241895AbiHQU2R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:28:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3962CE6
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:28:12 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id pm17so13465126pjb.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=hT1mtmbXceJ51lQvB4DLzgKYpjDNa0L4N/kK3oT5iSo=;
        b=Alg7m2vCIvNQH6u/5J92QO95fXKnwPm0c54ozf9T/TnSTEtENcRnf6hhUF8VDUPvX/
         m5u/gYEuiJ2nuHA3Dd7NCs4rUZSiR3my0SvXT66bhA+TtPKi9iFc5a8eTQR+Y0algK19
         9IFXyqQCtfBgfsapNbx90XVFNDVhOjytnRgRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=hT1mtmbXceJ51lQvB4DLzgKYpjDNa0L4N/kK3oT5iSo=;
        b=ggW7r/GcX/P+f7XrurYGrxN8e2suYXfol9DavwkdExYV3VtTE/VYpyD68AyDSdIGeH
         p8gpzRcyGa4Mqs5jIRYjR9j7LxYDsfsplhmyU0+JRV4pT5WeFRXnkkbgLndfN3kRnQQC
         NoiSdPgRlLu5B4ozUwWLoOB+rjGeIt5MDXVbYopLyIcndybk1ZGI2rBCFTrOoZ6WkYjj
         2wAzx5hIYEbwWVCUC2JpECVrWAuMqMWwQf8Gr66l5xz+XIxZthPhJ4Bjl5iPC/9BGdEo
         dW98LuEqszNsiqHLAftUWuz0sz8h4x4dzag+F+L6wfgas5OYCYUjAIFfikg6vvPDtHWC
         8WzQ==
X-Gm-Message-State: ACgBeo1U+aQ3DVdW4ARbwC89NB6FroWsnlgCgsl82kL++D+2RcyClO1L
        5fwCB4gMLryCCNfNZm43FAf1Cg==
X-Google-Smtp-Source: AA6agR5lm+SAcceTecvESsUi3A+nQ2mXl4Fx0wTRiYvIuUCLBGgHZKgPMytipREue+HPDcXtmsKPNw==
X-Received: by 2002:a17:90a:dc15:b0:1fa:c517:7f14 with SMTP id i21-20020a17090adc1500b001fac5177f14mr964231pjv.117.1660768092268;
        Wed, 17 Aug 2022 13:28:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q1-20020a170902f34100b001636d95fe59sm326452ple.172.2022.08.17.13.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:28:11 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:28:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Milan Landaverde <milan@mdaverde.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v9 26/27] samples: add first Rust examples
Message-ID: <202208171328.E0DC29D0D@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-27-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-27-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:42:11PM +0200, Miguel Ojeda wrote:
> The beginning of a set of Rust modules that showcase how Rust
> modules look like and how to use the abstracted kernel features.
> 
> It also includes an example of a Rust host program with
> several modules.
> 
> These samples also double as tests in the CI.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

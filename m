Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5085B5EDDA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 15:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiI1NZJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 09:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiI1NZH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:25:07 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715477B1F3;
        Wed, 28 Sep 2022 06:25:06 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id o5so8536217wms.1;
        Wed, 28 Sep 2022 06:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=IJt6C3ywL4H7fQpqqRWXvtKK6PsYNMNNQ4fO0nq9AJ4=;
        b=IIn2BEGScn/Qs6vCuUYilZ9C5bhgmkufQbB9RsbPWEYkMKKp0qBHo6eZnnE2xmIbJo
         B0bpIrNbhjmI7/Qjg+GEnLPrncd4U09g16f+Uo0U5qEnPM8L8T7bDYTDmGA9SqgezNTA
         zr9UI/UyzzxoI2HRa2GQ3w7rdppkmNvGfIMb2RL/NQJvli3npL21upiwuvI4qn2kpNC8
         1aWIzR+DaRLdR2/sp8ncBhMMCcO+57k1/WXl4+pUgE/KblyvA04Z6x6Ikju5thmZRMvE
         TiTXKfz8h/w4Ngt1zruVJuhof/bqqU9c4v13iw2Z0nos+zc7jqtk0sdwocyZI3GOFWX3
         QHyQ==
X-Gm-Message-State: ACrzQf3MHMO9p6K32WOm4GyzzAbmrXZVLrb93V9MRMtS8hTq0NJz5x7R
        B/wwkaMqqbbDQWa3XwdxqnU=
X-Google-Smtp-Source: AMsMyM6AumnF7V3dI88as74fkN1Yrz4/EoGIN9LEacdDnxSUEH1g/NPsz/23u0cUaO8JNLPh+Po1Hw==
X-Received: by 2002:a05:600c:1d8f:b0:3b4:90c1:e23a with SMTP id p15-20020a05600c1d8f00b003b490c1e23amr6868640wms.122.1664371504885;
        Wed, 28 Sep 2022 06:25:04 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id i6-20020adfefc6000000b0022ccbc7efb5sm423572wrp.73.2022.09.28.06.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 06:25:04 -0700 (PDT)
Date:   Wed, 28 Sep 2022 13:25:02 +0000
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
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v10 09/27] rust: add `compiler_builtins` crate
Message-ID: <YzRLLrmYdMFX4LrB@liuwe-devbox-debian-v2>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-10-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-10-ojeda@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:40PM +0200, Miguel Ojeda wrote:
> Rust provides `compiler_builtins` as a port of LLVM's `compiler-rt`.
> Since we do not need the vast majority of them, we avoid the
> dependency by providing our own crate.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

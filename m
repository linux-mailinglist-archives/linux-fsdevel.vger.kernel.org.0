Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94DA5EDEB6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbiI1OXm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 10:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbiI1OXl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:23:41 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019EA98DB;
        Wed, 28 Sep 2022 07:23:38 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id z6so20112997wrq.1;
        Wed, 28 Sep 2022 07:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=mFcQzaNt7lB5NgLGuk0y5Jq2O1gMF6tf08IwQo9puOM=;
        b=T2af/lb28QQrBAAPDiBGB0qdywJ2uwmVMq/VHoQhEGeiLVBF46RNB/briKhQ3I/AR8
         tQ8fYjS9ZsKZp65H2/umnGtlCuEprgad93m52KM5VAQ7mcWSJr8ARpvKBkG6kwp46uAs
         GI8+N6zSn16s/nBAF1Rs9GcQY1m1gcJGcgKttRH5anl6EJafT0m4rIKlyGro7xFJeA3N
         hwF9nYhG1kcW3du4HEZwx8ytWL00rIcCPcXnnGo2djaMZoNizxzDywfnHpYg+VOZoq3s
         KgMSnhiCAuHxEJ4hwlVo7718rF76Q/6cBw5SM84MuGQPZLvnEzyvWOIAGs+fnf/ddjIZ
         Q1YQ==
X-Gm-Message-State: ACrzQf1MgU6Yk7J/C8edWfbK4rH0nY042POGrKN5/8t2jridjlzAJ2a+
        3F9TZwGnKzx3HwL0LSZ4AUY=
X-Google-Smtp-Source: AMsMyM4A35IvCHXOo7o0KiszcrKYBNlUbkmxsEcP8E5OgZYnXdM2PTBm8J0+c9svSjderpHlnmzrGA==
X-Received: by 2002:a5d:6e92:0:b0:22c:c09c:8f23 with SMTP id k18-20020a5d6e92000000b0022cc09c8f23mr5707080wrz.389.1664375016787;
        Wed, 28 Sep 2022 07:23:36 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id fc10-20020a05600c524a00b003b435c41103sm2900459wmb.0.2022.09.28.07.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:23:36 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:23:34 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Milan Landaverde <milan@mdaverde.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v10 26/27] samples: add first Rust examples
Message-ID: <YzRY5ioq36gVFGCl@liuwe-devbox-debian-v2>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-27-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-27-ojeda@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:57PM +0200, Miguel Ojeda wrote:
> The beginning of a set of Rust modules that showcase how Rust
> modules look like and how to use the abstracted kernel features.
> 
> It also includes an example of a Rust host program with
> several modules.
> 
> These samples also double as tests in the CI.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Finn Behrens <me@kloenk.de>
> Signed-off-by: Finn Behrens <me@kloenk.de>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Milan Landaverde <milan@mdaverde.com>
> Signed-off-by: Milan Landaverde <milan@mdaverde.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Wei Liu <wei.liu@kernel.org>

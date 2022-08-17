Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801B159780E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241507AbiHQUeZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbiHQUeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:34:24 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FF6A9263
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:34:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id m2so12958869pls.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=+BHAYzDqgDO1dphlleJav81q/W9nIBFp+VkYBEf8vLU=;
        b=jz3fLzw+fJu0xPnGx+//k5qikpJiVrmGS9ks5o3noNGsc8Uf1MVHQS773VBi7HxOoP
         MZ6Ip5ai3AKoAuZFpSBu4KsXfgeAKdCvm4aIDXUybYCujl6F8SW9xZaTic3jRc3H2wGA
         2kdkepAqif71HE0vPPrNQ6MJhpDbQ0B+3unjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+BHAYzDqgDO1dphlleJav81q/W9nIBFp+VkYBEf8vLU=;
        b=gezTdSTBFkIuzay8hZGaLtezDty4gES4gkQAFNZ9Blsid8mlp3azvFWRJVi6PqkCGL
         xQ0GFXGk215fRGCGrYmobOh716rSCGvlffIhN1ZrrkjsrWACRwpoesq1jVrt3NpdZhGH
         NWCPjZVMZSmZ6AAycBu7KaFCzGRkERpRLx/NAHAegc+wXlynjCR1GJxpQpCsqer/u/MJ
         023NcDCjp4IYjXjDHrAtdDPKI9CTE70Iq9Qh5M4Pba8NKevfypOdJ/KJvpHbvc5M9Tcw
         RJjOclmBORXZgM8kol7wD+sJFA/RiOF4fzQUAVRApXsDFU0YLoXID354I7CtLjy+JbuO
         Hfog==
X-Gm-Message-State: ACgBeo2ZDy2cGMq8pUTbQ2EzFlQzd/c7JIAV/G2S2aJlpNr0CYy7FwJN
        O3NoFVvZoOTUR0wP9fI48JuLSw==
X-Google-Smtp-Source: AA6agR5DUV06FMuvjpJ+csHMVx0eFv5uqzA4scevJawPGRalm+UHAttaTYitPkt7IE4XMPROHlrxwg==
X-Received: by 2002:a17:902:ce11:b0:172:6f2c:a910 with SMTP id k17-20020a170902ce1100b001726f2ca910mr16336467plg.156.1660768462179;
        Wed, 17 Aug 2022 13:34:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090aaa8f00b001ef9659d711sm1975601pjq.48.2022.08.17.13.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:34:21 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:34:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>,
        Wei Liu <wei.liu@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v9 06/27] rust: add C helpers
Message-ID: <202208171331.FAACB5AD8@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-7-ojeda@kernel.org>
 <202208171240.8B10053B9D@keescook>
 <CANiq72nR2eAeKrY6v=hnjUjvwfecMsSC6eXTwaei6ecnHjia8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nR2eAeKrY6v=hnjUjvwfecMsSC6eXTwaei6ecnHjia8g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 17, 2022 at 10:22:37PM +0200, Miguel Ojeda wrote:
> On Wed, Aug 17, 2022 at 9:44 PM Kees Cook <keescook@chromium.org> wrote:
> > Given the distaste for ever using BUG()[1], why does this helper exist?
> 
> We use it exclusively for the Rust panic handler, which does not
> return (we use fallible operations as much as possible, of course, but
> we need to provide a panic handler nevertheless).

Gotcha -- it's for the implicit situations (e.g. -C overflow-checks=on),
nothing is expected to explicitly call the Rust panic handler?

> Killing the entire machine is definitely too aggressive for some
> setups/situations, so at some point last year we discussed potential
> alternatives (e.g. `make_task_dead()` or similar) with, if I recall
> correctly, Greg. Maybe we want to make it configurable too. We are
> open to suggestions!

I suffer the same problems trying to fix C and the old "can never fail"
interfaces. Mainly we've just been systematically replacing such APIs
with APIs that return error codes, allowing the error to bubble back up.
(Which I know is exactly what you've already done with the allocator,
etc. Yay!)

-Kees

-- 
Kees Cook

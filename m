Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5032C6124E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Oct 2022 20:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiJ2SXf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 29 Oct 2022 14:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ2SXe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 29 Oct 2022 14:23:34 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42D52A954;
        Sat, 29 Oct 2022 11:23:33 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id r187so9289438oia.8;
        Sat, 29 Oct 2022 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gxoLAPS+9Ecu1s/8uDx34AXuA9lpWU9Z2smUFzhiANI=;
        b=FK30Xs8FfjGtUVZ701Q/u/E0K1xxm8c9h+UkHm2O3zOMPKAqIQn1h9Fmk1DzlhrNJY
         D7nWbR/fOZYEbLnPP7FF9oqz45BfN6sv37CKqyeFH55U2nsdbY0CjDWVTPjRpMyEmKIh
         Us53b1zCHyMg2DKt150e1V7XHIkZ3EumCqwi4vLSOlTGCXsIc1BPCim2stkACt/yxYPm
         YUHk86gUYe83QNj8MsHauRHwUBuMyApRY3sDucRtN5TxSY+LkX+yHn9IEe9wWkGe+7FG
         f5iO2owRwcStzOsTjw22iwgAfHfngVPKZdB/wf2LS16SruDIaHSC76qIoD3Y3cXkIMiE
         DmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxoLAPS+9Ecu1s/8uDx34AXuA9lpWU9Z2smUFzhiANI=;
        b=7KppWvzAf2WKhTjR5btObqvg51X3vqxhPf61kWKJAH4hEstorrp0SJOsqFAsaBqsUz
         z8wRZgm30TWs6xNB8j7ibrJoa7K2GAH0zG2ryyjxXgIOJI3N0X9tKRVmsnrYcrQGBcQ9
         eIXgRdJ0BnbSlpe6kkILRVc5NGNeTH38ofAMEoYXaYUVZzGcm7SsiD7J+Zkph+8VOwIN
         BkMDMSGkcy4Iu11i4GUIBQEjJbUs8ZGNQWniICDBz4ilRX3Wbekqu3eACYwLJA+Wi0ar
         ODkXfNGt0YpTsNcM/JCVu9prjrn3R8TwZwciNb4mbgF6otOcg+HCorZt3LT4ijY4bqG4
         oxpw==
X-Gm-Message-State: ACrzQf1Z69UtycEJ6vnuys+3Di4/NvocWaIrAOEzk2g4eZaQuFXU/VBk
        GT+YfgyECXnQSo86ij5QW9k=
X-Google-Smtp-Source: AMsMyM64g3+ESxXBhNt55ABceWhd+VO4/vMH3BZ88BwJouOpyU7NkhgGB2mYjf8nfDYsgaKxWigPdA==
X-Received: by 2002:aca:3d55:0:b0:355:1ced:909f with SMTP id k82-20020aca3d55000000b003551ced909fmr10680391oia.60.1667067813195;
        Sat, 29 Oct 2022 11:23:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o4-20020acabe04000000b0035494c1202csm712709oif.42.2022.10.29.11.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 11:23:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 29 Oct 2022 11:23:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Gary Guo <gary@garyguo.net>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v10 04/27] kallsyms: support "big" kernel symbols
Message-ID: <20221029182331.GA3324354@roeck-us.net>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-5-ojeda@kernel.org>
 <20221029174147.GA3322058@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029174147.GA3322058@roeck-us.net>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 29, 2022 at 10:41:49AM -0700, Guenter Roeck wrote:
> On Tue, Sep 27, 2022 at 03:14:35PM +0200, Miguel Ojeda wrote:
> > Rust symbols can become quite long due to namespacing introduced
> > by modules, types, traits, generics, etc.
> > 
> > Increasing to 255 is not enough in some cases, therefore
> > introduce longer lengths to the symbol table.
> > 
> > In order to avoid increasing all lengths to 2 bytes (since most
> > of them are small, including many Rust ones), use ULEB128 to
> > keep smaller symbols in 1 byte, with the rest in 2 bytes.
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> > Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> > Co-developed-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Gary Guo <gary@garyguo.net>
> > Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > Co-developed-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  kernel/kallsyms.c  | 26 ++++++++++++++++++++++----
> >  scripts/kallsyms.c | 29 ++++++++++++++++++++++++++---
> >  2 files changed, 48 insertions(+), 7 deletions(-)
> > 
> 
> This patch results in the following spurious build error.
> 
> Building powerpc:allnoconfig ... failed
> --------------
> Error log:
> Inconsistent kallsyms data
> Try make KALLSYMS_EXTRA_PASS=1 as a workaround

I should have added: KALLSYMS_EXTRA_PASS=1 does not help.

Guenter

> 
> Symbol file differences:
> 10c10
> < 00009720 g       .rodata	00000000 kallsyms_relative_base
> ---
> > 0000971c g       .rodata	00000000 kallsyms_relative_base
> 12,16c12,16
> < 00009724 g       .rodata	00000000 kallsyms_num_syms
> < 00009728 g       .rodata	00000000 kallsyms_names
> < 00022628 g       .rodata	00000000 kallsyms_markers
> < 000226c0 g       .rodata	00000000 kallsyms_token_table
> < 00022a2c g       .rodata	00000000 kallsyms_token_index
> ---
> > 00009720 g       .rodata	00000000 kallsyms_num_syms
> > 00009724 g       .rodata	00000000 kallsyms_names
> > 00022618 g       .rodata	00000000 kallsyms_markers
> > 000226b0 g       .rodata	00000000 kallsyms_token_table
> > 00022a1c g       .rodata	00000000 kallsyms_token_index
> 
> This is the only difference. There are no additional symbols.
> 
> Reverting this patch fixes the problem.
> 
> Guenter

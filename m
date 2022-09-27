Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39B0E5EC7BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 17:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiI0Pa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 11:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiI0Paz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:30:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51310A7ABE;
        Tue, 27 Sep 2022 08:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A103B81C5C;
        Tue, 27 Sep 2022 15:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40656C433D6;
        Tue, 27 Sep 2022 15:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664292651;
        bh=KkONLbw354gmM11QpeIodg4A6ac2eweBJJjS1Gdelbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0OG5AB4B++z0w2kxIKqmRVr/IDEaSEIyw4LjNzqXRFmy/sst6+MLtL3WFIwHcpZ7
         ApLzhyYZ5Lq0R6GEVVJP/TisYm6KB6o6/Ezofob6Q+BRB8WVksv3eo4vupUTLZoGuS
         Rsn1kwWHlzoOQ7R52pCIabivWdIvAnaOk5Wmeqls=
Date:   Tue, 27 Sep 2022 17:30:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Douglas Su <d0u9.su@outlook.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v10 23/27] Kbuild: add Rust support
Message-ID: <YzMXKOa3It5mcmR3@kroah.com>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-24-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927131518.30000-24-ojeda@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:54PM +0200, Miguel Ojeda wrote:
> Having most of the new files in place, we now enable Rust support
> in the build system, including `Kconfig` entries related to Rust,
> the Rust configuration printer and a few other bits.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Finn Behrens <me@kloenk.de>
> Signed-off-by: Finn Behrens <me@kloenk.de>
> Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Co-developed-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Boris-Chengbiao Zhou <bobo1239@web.de>
> Signed-off-by: Boris-Chengbiao Zhou <bobo1239@web.de>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Douglas Su <d0u9.su@outlook.com>
> Signed-off-by: Douglas Su <d0u9.su@outlook.com>
> Co-developed-by: Dariusz Sosnowski <dsosnowski@dsosnowski.pl>
> Signed-off-by: Dariusz Sosnowski <dsosnowski@dsosnowski.pl>
> Co-developed-by: Antonio Terceiro <antonio.terceiro@linaro.org>
> Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
> Co-developed-by: Daniel Xu <dxu@dxuuu.xyz>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> Co-developed-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
> Signed-off-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
> Co-developed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  .gitignore                     |   2 +
>  Makefile                       | 172 ++++++++++++++-
>  arch/Kconfig                   |   6 +
>  include/linux/compiler_types.h |   6 +-
>  init/Kconfig                   |  46 +++-
>  kernel/configs/rust.config     |   1 +
>  lib/Kconfig.debug              |  34 +++
>  rust/.gitignore                |   8 +
>  rust/Makefile                  | 381 +++++++++++++++++++++++++++++++++
>  rust/bindgen_parameters        |  21 ++
>  scripts/Kconfig.include        |   6 +-
>  scripts/Makefile               |   3 +
>  scripts/Makefile.build         |  60 ++++++
>  scripts/Makefile.debug         |   8 +
>  scripts/Makefile.host          |  34 ++-
>  scripts/Makefile.lib           |  12 ++
>  scripts/Makefile.modfinal      |   8 +-
>  scripts/cc-version.sh          |  12 +-
>  scripts/kconfig/confdata.c     |  75 +++++++
>  19 files changed, 869 insertions(+), 26 deletions(-)
>  create mode 100644 kernel/configs/rust.config
>  create mode 100644 rust/.gitignore
>  create mode 100644 rust/Makefile
>  create mode 100644 rust/bindgen_parameters

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

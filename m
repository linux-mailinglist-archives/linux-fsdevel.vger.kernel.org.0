Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CB25EC729
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 17:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiI0PD0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 11:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiI0PDY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:03:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D926E5102;
        Tue, 27 Sep 2022 08:03:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8865A619E8;
        Tue, 27 Sep 2022 15:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB9FC433D6;
        Tue, 27 Sep 2022 15:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664291000;
        bh=TjcSzBBanTXK9bISi1tMaoT2eQOdPKXGFS9vAez03hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5MdXlSLnohNkvwbt8HvoMYnsDggYtGIUy/LZqZPtE/McheiG102UQga24y6t+ghk
         TljYJTQJrRHlsAjUh64ai/leI345kroHUhkJyBMV8hoR1FhSzMlce4GzFrvu8heRBV
         Y30omur2J5ercolZSe+TGlTQPkB3feoQk5j/C2AM=
Date:   Tue, 27 Sep 2022 17:03:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v10 15/27] scripts: checkpatch: diagnose uses of `%pA` in
 the C side as errors
Message-ID: <YzMQtf1YSFX0GEWu@kroah.com>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-16-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-16-ojeda@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:46PM +0200, Miguel Ojeda wrote:
> The `%pA` format specifier is only intended to be used from Rust.
> 
> `checkpatch.pl` already gives a warning for invalid specificers:
> 
>     WARNING: Invalid vsprintf pointer extension '%pA'
> 
> This makes it an error and introduces an explanatory message:
> 
>     ERROR: Invalid vsprintf pointer extension '%pA' - '%pA' is only intended to be used from Rust code
> 
> Suggested-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Co-developed-by: Joe Perches <joe@perches.com>
> Signed-off-by: Joe Perches <joe@perches.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  scripts/checkpatch.pl | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

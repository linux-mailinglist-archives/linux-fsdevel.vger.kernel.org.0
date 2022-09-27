Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679425EC59B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 16:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiI0OLp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 10:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiI0OLm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:11:42 -0400
X-Greylist: delayed 357 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 07:11:40 PDT
Received: from hop.stappers.nl (hop.stappers.nl [IPv6:2a02:2308:0:14e::686f:7030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF32AED9C;
        Tue, 27 Sep 2022 07:11:40 -0700 (PDT)
Received: from gpm.stappers.nl (gpm.stappers.nl [82.168.249.201])
        by hop.stappers.nl (Postfix) with ESMTP id A32402000F;
        Tue, 27 Sep 2022 14:11:38 +0000 (UTC)
Received: by gpm.stappers.nl (Postfix, from userid 1000)
        id 536A4304049; Tue, 27 Sep 2022 16:11:38 +0200 (CEST)
Date:   Tue, 27 Sep 2022 16:11:38 +0200
From:   Geert Stappers <stappers@stappers.nl>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH v10 27/27] MAINTAINERS: Rust
Message-ID: <20220927141137.iovhhjufqdqcs6qn@gpm.stappers.nl>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-28-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220927131518.30000-28-ojeda@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:58PM +0200, Miguel Ojeda wrote:
> Miguel, Alex and Wedson will be maintaining the Rust support.
>
> Boqun, Gary and Björn will be reviewers.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  MAINTAINERS | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f5ca4aefd184..944dc265b64d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17758,6 +17758,24 @@ F:	include/rv/
>  F:	kernel/trace/rv/
>  F:	tools/verification/
>
> +RUST
> +M:	Miguel Ojeda <ojeda@kernel.org>
> +M:	Alex Gaynor <alex.gaynor@gmail.com>
> +M:	Wedson Almeida Filho <wedsonaf@google.com>
<screenshot from="response of a reply-to-all that I just did">
  ** Address not found **

  Your message wasn't delivered to wedsonaf@google.com because the
  address couldn't be found, or is unable to receive mail.

  Learn more here: https://support.google.com/mail/answer/6596

  The response was:

    The email account that you tried to reach does not exist. Please try
    double-checking the recipient's email address for typos or unnecessary
    spaces. Learn more at https://support.google.com/mail/answer/6596
</screenshot>

> +R:	Boqun Feng <boqun.feng@gmail.com>
> +R:	Gary Guo <gary@garyguo.net>
> +R:	Björn Roy Baron <bjorn3_gh@protonmail.com>
> +L:	rust-for-linux@vger.kernel.org
> +S:	Supported
> +W:	https://github.com/Rust-for-Linux/linux
> +B:	https://github.com/Rust-for-Linux/linux/issues
> +T:	git https://github.com/Rust-for-Linux/linux.git rust-next
> +F:	Documentation/rust/
> +F:	rust/
> +F:	samples/rust/
> +F:	scripts/*rust*
> +K:	\b(?i:rust)\b
> +
>  RXRPC SOCKETS (AF_RXRPC)
>  M:	David Howells <dhowells@redhat.com>
>  M:	Marc Dionne <marc.dionne@auristor.com>
> --
> 2.37.3
>

Groeten
Geert Stappers
--
Silence is hard to parse

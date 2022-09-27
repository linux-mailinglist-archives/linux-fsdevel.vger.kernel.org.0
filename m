Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7885A5EC725
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 17:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiI0PDI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 11:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiI0PDG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:03:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC22D8E13;
        Tue, 27 Sep 2022 08:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47E98B81BFB;
        Tue, 27 Sep 2022 15:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A38AC433C1;
        Tue, 27 Sep 2022 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664290982;
        bh=yZ1HtZd84+qNCSmptCOHlzte0cS64QkSd66+19rQPa8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERRJxriFlLQi6zF/sM87TxHlUKGq0qkzDMagdYQ4WVgq9F1cp6YbEPgRtJfl71R0R
         QPDic1KCK/Cmg4uo0KYcall7d+wMlqSxMRNe/wbsEKnObXDeoTzl1+xxMLAcl+YvDp
         Le0z282zBGJZlegkynfE4nv7+eBAbtkq8tx5Y5uM=
Date:   Tue, 27 Sep 2022 17:02:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v10 16/27] scripts: checkpatch: enable
 language-independent checks for Rust
Message-ID: <YzMQozmqYUr2b/wt@kroah.com>
References: <20220927131518.30000-1-ojeda@kernel.org>
 <20220927131518.30000-17-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927131518.30000-17-ojeda@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:14:47PM +0200, Miguel Ojeda wrote:
> Include Rust in the "source code files" category, so that
> the language-independent tests are checked for Rust too,
> and teach `checkpatch` about the comment style for Rust files.
> 
> This enables the malformed SPDX check, the misplaced SPDX license
> tag check, the long line checks, the lines without a newline check
> and the embedded filename check.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>
> Co-developed-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

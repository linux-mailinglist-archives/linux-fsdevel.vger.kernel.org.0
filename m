Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CC85977A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241540AbiHQUMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241485AbiHQUMl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:12:41 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AD9A61DF
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:12:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id a22so12382002pfg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=+WRGNlWofKlOiDjgaSTNb/H9kbNSywL6IxTX7zzIueA=;
        b=fMRhV1gD0LiWPslIdJd3Oay33CI1Qjzc9fxrxo1rMAcTxyGfF+9i+S4mdI5O7WkvEZ
         pi/Ze5jSG8mJRZ5c9znxeN8yUWNpDYVrR9pyvY6pVf4TLt8fffmT0CMXEqCcyLCBGZzT
         feSoTwBjHSuD+PY2QeZCOih3yziojt2d2o8bE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+WRGNlWofKlOiDjgaSTNb/H9kbNSywL6IxTX7zzIueA=;
        b=Ta81Sx41ks7df1eM5BWDAB9LUp60eoJ2DbMB+UGqM+sxLwZ4iGJrw8sPO0dGyZDUdd
         m5NQ0AtoQS6Xldcd+0kzRP2wfFhrUwaZ02cib2GwWaXWXXh53ZPBJTo+GyQ3REdsNeEu
         V8wggPIKrftoav5Sb4btQ1BzXGX75ZzvxHlhXCxIXeXzmKpgXJQA3o+8CQ5aGxEP4Adn
         dievooX62/rsN2VDbxAMZpk3pQ8nkOOivZErM5NcISyyYmWLTRfmSHjzrFZ/7PiM9fZ+
         w1Bbx+UazvEUrAStTC8ilxE75/1UisAGiX5BkjAMOOdDrE/yBZaStjxJX+gVe/WqMpJN
         pp3A==
X-Gm-Message-State: ACgBeo0mN0+JT0DVfO0deqtjJNGVg29iSDt+ntaJovyLklA/0ZjGK29V
        p+LgXT5BtqsiZCQwNPLu2UBjVDR6SJaKIQ==
X-Google-Smtp-Source: AA6agR6zH+/TwyGgpZzTC8h5baBczzUM6S76Zm6Lt7mPjCgTSRD1ONJNatmSLrsIE45J9d/eErae6g==
X-Received: by 2002:a63:1841:0:b0:429:8268:1fc with SMTP id 1-20020a631841000000b00429826801fcmr10651647pgy.78.1660767160381;
        Wed, 17 Aug 2022 13:12:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h18-20020aa796d2000000b0052d4afc4302sm11215205pfq.175.2022.08.17.13.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:12:39 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:12:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH v9 16/27] scripts: checkpatch: enable
 language-independent checks for Rust
Message-ID: <202208171312.1CB3606F0C@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-17-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-17-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:42:01PM +0200, Miguel Ojeda wrote:
> Include Rust in the "source code files" category, so that
> the language-independent tests are checked for Rust too,
> and teach `checkpatch` about the comment style for Rust files.
> 
> This enables the malformed SPDX check, the misplaced SPDX license
> tag check, the long line checks, the lines without a newline check
> and the embedded filename check.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE9A59780F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241902AbiHQU2w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241915AbiHQU2s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:28:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F0565572
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:28:43 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id jm11so10709222plb.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 13:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=3IdwoVVH/KyYebc3thCK0QbO3+GbhpIydetmBLF9D/I=;
        b=jSONM70T0iDAfNrUlJVTC0kSLGPrN42VzGrBfG+OQOHBUFYa/lexgC3zukZjRUN+RA
         Va4f3Cff4Myv7LFdueNazPDJm59DfkyitTRPdIqTg8fi8YS5oUyYMGFak9DEw7n0i+dV
         HBASyKpT4twWeav/khru+yHi/akhW25j65vzo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=3IdwoVVH/KyYebc3thCK0QbO3+GbhpIydetmBLF9D/I=;
        b=1y8qO+FD8VVMrUoNyvYVtFIwkdShRL71UkRS2ILVwl6D0k9ytHeqw1BZtw/rbb8v6k
         kLAGtRnnxLjQh50NtFTKkFR+zgx18MkTORRNMHxRGTeFraHq9da1M2Wy384sAGWjaIaK
         T7FvGBYosG8T/sndOdy1FxSf+j3B+8Rpm5kD+us5c79wIbFxBCr0sfOhqTXS/jUc+3pq
         TJPPwsipbjkqVcHz7DjbIyX2UbDE9Dqgy1ZpG5sif0kmfOgn+PuJmQdKH1QRXsok/mcG
         Oe1PlJsmQ57/7/1qhMkvo33WDg6vUUMd9jtRuE0NzAwACTKE2B4KcskXHWbj922TelR2
         5JDA==
X-Gm-Message-State: ACgBeo0b9AkfJcMJhvm6rS7a5fKMQn+V3FAoD/TwnXIKqpcZr9UQLXnE
        RFXF3dep2kDYiavfIQzRx94WjA==
X-Google-Smtp-Source: AA6agR5Zika9lSedq4f7QwsRgecAXUOsKIBN3mGuVnYiMhmG7lPo2eB1oM4cCxRF+GeLrPsJUjEuKA==
X-Received: by 2002:a17:90b:190b:b0:1fa:a374:f563 with SMTP id mp11-20020a17090b190b00b001faa374f563mr5431439pjb.52.1660768122915;
        Wed, 17 Aug 2022 13:28:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902ce8400b0016ee3d7220esm358508plg.24.2022.08.17.13.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:28:42 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:28:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH v9 27/27] MAINTAINERS: Rust
Message-ID: <202208171328.8C3541A@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-28-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220805154231.31257-28-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:42:12PM +0200, Miguel Ojeda wrote:
> Miguel, Alex and Wedson will be maintaining the Rust support.
> 
> Boqun, Gary and Björn will be reviewers.
> 
> Co-developed-by: Alex Gaynor <alex.gaynor@gmail.com>
> Signed-off-by: Alex Gaynor <alex.gaynor@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

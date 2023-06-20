Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B8C737384
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jun 2023 20:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjFTSIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jun 2023 14:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjFTSIr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:08:47 -0400
Received: from out-41.mta1.migadu.com (out-41.mta1.migadu.com [95.215.58.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D83DF1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jun 2023 11:08:46 -0700 (PDT)
Date:   Tue, 20 Jun 2023 14:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687284524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uieB0uDJdV3Z2GtXLTESpNEU2SaPfLYBzXkq3w1FWM4=;
        b=l9LNQKCRfl5hVxGylNeDu6+QvrufJx1VRN3rZ9aNaIZx+ebGT73VOxZXGQCCmrH1zf3UQ4
        /ZCqggGHY4tXz4lK5ZfhHEO8UgXc0MuyuiLKyj4QvMCbcQ4bklk72tfx6Hir6jzovBQWVo
        ztIqCXAuKSpqJRhecuoiRwPnw97z/Sc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "hch@infradead.org" <hch@infradead.org>, linux-mm@kvack.org,
        Kees Cook <keescook@chromium.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH 07/32] mm: Bring back vmalloc_exec
Message-ID: <20230620180839.oodfav5cz234pph7@moria.home.lan>
References: <20230509165657.1735798-1-kent.overstreet@linux.dev>
 <20230509165657.1735798-8-kent.overstreet@linux.dev>
 <ZJAdhBIvwFBOFQU/@FVFF77S0Q05N>
 <20230619104717.3jvy77y3quou46u3@moria.home.lan>
 <ZJBOVsFraksigfRF@FVFF77S0Q05N.cambridge.arm.com>
 <20230619191740.2qmlza3inwycljih@moria.home.lan>
 <5ef2246b-9fe5-4206-acf0-0ce1f4469e6c@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ef2246b-9fe5-4206-acf0-0ce1f4469e6c@app.fastmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 20, 2023 at 10:42:02AM -0700, Andy Lutomirski wrote:
> Code is either correct, and comes with an explanation as to how it is
> correct, or it doesn't go in.  Saying that something is like BPF is
> not an explanation as to how it's correct.  Saying that someone has
> not come up with the chain of events that causes a mere violation of
> architecture rules to actual incorrect execution is not an explanation
> as to how something is correct.

No, I'm saying your concerns are baseless and too vague to address.

> text_poke() by itself is *not* the proper API, as discussed.  It
> doesn't serialize adequately, even on x86.  We have text_poke_sync()
> for that.

Andy, I replied explaining the difference between text_poke() and
text_poke_sync(). It's clear you have no idea what you're talking about,
so I'm not going to be wasting my time on further communications with
you.

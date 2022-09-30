Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540615F121B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 21:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiI3TIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 15:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiI3TIp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 15:08:45 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774121D849C
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 12:08:44 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d10so5028337pfh.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 12:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Y0jkg0UfITvu715KQMSBhfyS1TFcoNUOpfI9/MT9+hU=;
        b=SJlmL8pGdRuQmveG772+ss+QQnvFj9fpBjKyuxdT8ajkZW/YPP75CX1SiJ2oC6jffJ
         V03m1cfV7AxqKe2biiwYMfcCmlvf/Zx8JQMxoYLyXOKWoO2Qn5v0wLompjH9pBdGmrIn
         vPj83g2YlWSfU9c5U3dQFT7SzmNyq82mXDNBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Y0jkg0UfITvu715KQMSBhfyS1TFcoNUOpfI9/MT9+hU=;
        b=npAbE9cWBsAH8TkaCMzNk/7gxqqdq62798mqhMBjCsupX5cMhzSmIWmDO2sawf/fVu
         7Idwv3twMMAgh8ltjAeFxEjxCtgZpi1nwdM32Y+W+1+XB8j0hamP4B4PzeGHqXuOzKVO
         /akGhtsGOUd7IY+8T+7rJh9Pvgv5L9/iAa1mMg1Kh0yxph7MRmclWwusgnLJT2W2A4M3
         fmXdoCvWOoRjdgXZrtKTrvWRO+n0dbJcT7XYFUle8jlKi3qZ1vlrsmMQiGeCGR5+DdJT
         hASK0JmO5E23mzDnGgPaMh1PLcM7WP0x6N8FCCHBFwZxvS2cipIe4CJyE7zml3YwS+q2
         /eJA==
X-Gm-Message-State: ACrzQf2LN/joUahVJ2sRFv1nHscyNqXtANyYu0OF10zb/YRlH16ii/qE
        CI+KU20TalRK3h8OHtrZ6vsa+Q==
X-Google-Smtp-Source: AMsMyM5WppkI2prI3B2ix7AQu6tolb6o8CcR43jgfg0hmGm+zuqvhTTbtPJRC4076JhRaT1VYU8gYQ==
X-Received: by 2002:a63:3c5:0:b0:43c:8455:d67d with SMTP id 188-20020a6303c5000000b0043c8455d67dmr8978718pgd.73.1664564923801;
        Fri, 30 Sep 2022 12:08:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l6-20020a170902d34600b0016c0c82e85csm2258000plk.75.2022.09.30.12.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 12:08:43 -0700 (PDT)
Date:   Fri, 30 Sep 2022 12:08:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [REGRESSION][PATCH] Revert "pstore: migrate to crypto acomp
 interface"
Message-ID: <202209301207.66D6069757@keescook>
References: <20220929215515.276486-1-gpiccoli@igalia.com>
 <202209291951.134BE2409@keescook>
 <56d85c70-80f6-aa73-ab10-20474244c7d7@igalia.com>
 <CAMj1kXFnoqj+cn-0dT8fg0kgLvVx+Q2Ex-4CUjSnA9yRprmC-w@mail.gmail.com>
 <101050d9-e3ec-8c21-5fb6-68442f51b39f@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <101050d9-e3ec-8c21-5fb6-68442f51b39f@igalia.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 30, 2022 at 03:31:17PM -0300, Guilherme G. Piccoli wrote:
> On 30/09/2022 12:51, Ard Biesheuvel wrote:
> > [...]
> > 
> > Does this help?
> > 
> > diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> > index b2fd3c20e7c2..c0b609d7d04e 100644
> > --- a/fs/pstore/platform.c
> > +++ b/fs/pstore/platform.c
> > @@ -292,7 +292,7 @@ static int pstore_compress(const void *in, void *out,
> >                 return ret;
> >         }
> > 
> > -       return outlen;
> > +       return creq->dlen;
> >  }
> > 
> >  static void allocate_buf_for_compression(void)
> > 
> 
> Thanks a lot Ard, this seems to be the fix! Tested with lz4/zstd/deflate
> in both ramoops/efi backends, and all worked fine. It makes sense,
> outlen was modified in the previous API and not in the acomp thing, so
> it was a good catch =)
> 
> 
> >> Heheh you're right! But for something like this (pstore/dmesg
> >> compression broke for the most backends), I'd be glad if we could fix it
> >> before the release.
> > 
> > Yeah better to revert - this was not a critical change anyway. But I
> > think the tweak above should fix things (it works for me here)
> 
> Agreed - in fact seems it was reverted already. More than that, I found
> yet another small issue in the acomp refactor, a memory leak - attached
> is a patch with the fix, feel free to integrate in your acomp refactor
> when re-submitting (I mean, feel free to just integrate the code, don't
> need to send it as a separate patch/fix).
> 
> I'm also working some fixes in implicit conversions in pstore that
> aren't great (unsigned -> int in many places), I'll send some stuff next
> week.

Awesome! Thank you both! I'll probably be busy for the next week with
the merge window, but after that I'll pull new stuff into -next for
pstore. I appreciate more people poking around in the code. :)

-- 
Kees Cook

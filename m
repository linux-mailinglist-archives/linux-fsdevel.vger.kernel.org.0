Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969EA59885E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 18:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbiHRQIl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 12:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233295AbiHRQIi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:08:38 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEDFAE77
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 09:08:33 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r22so1642156pgm.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Aug 2022 09:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dkzdwXAhukUGKkbvYtx/LFK6YpxxPi2tmHux6mvam40=;
        b=lbuKiul3DBDHslligdJbHEWQKKkH0d+m4Kn5XBM6DDmBF92h/JROOSP6+ssCj74oqq
         XRSqt0Ah+a2HtDEdIN+dWtjUXRoONv2mBPuHS7sKyca2pDFiNrme23UapxwvsDVDOeGh
         D2ROiXh0DSs1fKeCDkEXNccJf8SqW1CVUcPDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dkzdwXAhukUGKkbvYtx/LFK6YpxxPi2tmHux6mvam40=;
        b=ZNM15nkhZfIFupXjZ4F6j9ojC9Ca/yq/Ks3JEF5JctyPfvRbuSE+XnRzLfg+1AReuC
         s2gpOQn1lqGkXq+Uqe/l3Kpf4ItPmj5PpAzH+ZWS5rz4yDbereMP710wEp+BkOWl+lyd
         ZNzbPO9/P/g//q+6Z8uzn+Udw6uIzH7ir2v8yxvOAEiT0mDvaw47eyURd9F4FeGYuEAv
         c2RlADhlQWjk/RB8+rpzFqot7VqyoZJbYzGDjA13OATseFLndnrlwhzXE6ANoTDxlm70
         5sf5+KYVhJaJ4gqEPL3O523Kkdk0YpCFQiEnMoMY5Ty7agcToaz056xOfxkL6nNJPrKo
         E9LQ==
X-Gm-Message-State: ACgBeo2lVRBjkuNqWZ4r3lbGQJ6c4VFs7jg28wPYzDKY0brmldU6j2w7
        zyjIJx3lIdrSWx7QR06b6W1f/383/vVfpA==
X-Google-Smtp-Source: AA6agR6EfzgU3MEORDuRg5heJltFDloR0OCOaexnB6vev5J9Tj1uc/N52287ppIZ88AKFXYykHf5/Q==
X-Received: by 2002:a05:6a00:2393:b0:535:58e7:8f90 with SMTP id f19-20020a056a00239300b0053558e78f90mr3605157pfc.84.1660838913039;
        Thu, 18 Aug 2022 09:08:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ei23-20020a17090ae55700b001f7a76d6f28sm1707494pjb.18.2022.08.18.09.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:08:32 -0700 (PDT)
Date:   Thu, 18 Aug 2022 09:08:31 -0700
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
Message-ID: <202208180905.A6D2C6C00@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-7-ojeda@kernel.org>
 <202208171240.8B10053B9D@keescook>
 <CANiq72nR2eAeKrY6v=hnjUjvwfecMsSC6eXTwaei6ecnHjia8g@mail.gmail.com>
 <202208171331.FAACB5AD8@keescook>
 <CANiq72=6nzbMR1e=7HUAotPk-L00h0YO3-oYrtKy2BLcHVDTEw@mail.gmail.com>
 <202208171653.6BAB91F35@keescook>
 <CANiq72mqutW7cDjYQv4qOYOAV6uM8kUWenquQyiG-mEw4DURJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mqutW7cDjYQv4qOYOAV6uM8kUWenquQyiG-mEw4DURJA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 06:03:04PM +0200, Miguel Ojeda wrote:
> On Thu, Aug 18, 2022 at 1:56 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Perfect. It may be worth stating this explicitly with the helper. i.e.
> > "This is for handling any panic!() calls in core Rust, but should not
> > ever be used in the 'kernel' create; failures should be handled."
> 
> I am not sure we should say "ever", because there are sometimes
> situations where we statically know a situation is impossible. Of
> course, "impossible" in practice is possible -- even if it is due to a
> single-event upset.
> 
> For the "statically impossible" cases, we could simply trigger UB
> instead of panicking. However, while developing and debugging one
> would like to detect bugs as soon as possible. Moreover, in
> production, people may have use cases where killing the world is
> better as soon as anything "funny" is detected, no matter what.

Please, no UB. I will take a panic over UB any day. It'd be best to
handle things with some error path, but those are the rare exception.

> So we could make it configurable, so that "Rust statically impossible
> panics" can be defined as UB, `make_task_dead()` or a full `BUG()`.

C is riddled with UB and it's just terrible. Let's make sure we don't
continue that mistake. :)

> By the way, I should have mentioned the `unwrap()s` too, since they
> are pretty much explicit panics. We don't have any in v9 either, but
> we do have a couple dozens in the full code (in the 97% not submitted)
> in non-test or examples code. Many are of the "statically impossible"
> kind, but any that is not merits some discussion, which we can do as
> we upstream the different pieces.

The simple answer is that if an "impossible" situation can be recovered
from, it should error instead of panic. As long as that's the explicit
design goal, I think we're good. Yes there will be cases where it is
really and truly unrecoverable, but those will be rare and can be well
documented.

-- 
Kees Cook

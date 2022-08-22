Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38F659C9A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Aug 2022 22:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbiHVUJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Aug 2022 16:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiHVUJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Aug 2022 16:09:16 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75D04F1B6
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 13:09:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u24so6077795lji.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Aug 2022 13:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rNzR9QGqS5j6oh3cxSooKBs5Da2aEIBjVibuQ7PJyY4=;
        b=G/6rnW2WngFu3z8GJAnZAfCOkh68V/JUVcL67bXj8QU16wKXhMja1mBmCXbTmoik81
         fdRO9yziSI1qyn3ZnU+Tk/b2sF7XsdQ1NnwKRVBovYFK8jKlmTE25Tnqpl1OShRVgFuO
         55GLEFueyqTzyirsTbo9dhWM7XcEyTrXvQVeN7iSuin+N1GEYFmw/DH+NkSO6W3GV6HO
         R/542Kyg5z5z+fF28YqBPucnTKR8rFd39QVkbJ7+94RLIRv3/IdPNOPUYxR2rtFLJJo/
         akYDrVLMQ3gXaiXiwyvOoGY3I0ZKHhZmxqg1es9/wRFbkicvNSHP3X7Q6cUSaREYuQyd
         HxqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rNzR9QGqS5j6oh3cxSooKBs5Da2aEIBjVibuQ7PJyY4=;
        b=xdI6HnQo+a/bsOMIPwA5QBxGo8p7B0t875peg+S9OBnixxsv6XGRBXl+RSiQhCHHiD
         982tzBPm6N0JwJBVoWwQTfw+XnVw2wTE2mNBEiy3dmcD/qoudEgBQlcdAfTN1ikDLzFr
         TPnJ1yzN8BOPveUaIVU5hF2EAbegDmMPjv10TS+xe21JJXAh4a5drudoV3AavYVELrne
         fapL7e9/ZH+RBiyq9gGA8TwTVAiRnkhBHTzkiNWdBWqUgeRjzerQuUpgyO77g6Hyxhk0
         u3IhT0qWk8HoaBb8eyQuJSkMbYYSHVChyU/WxkGdr+v5RFf/lo62mr+dVg3m5z9f/Jlq
         dpHA==
X-Gm-Message-State: ACgBeo3cCVzgQWl0CbMT9cYdj8mcAcLEdpw0Wz8eb0n9faQF3hjAtFcw
        P0aXEJ+33HQcZYmzv+EDpYLI3Edc/4ykDSkKONaGQQ==
X-Google-Smtp-Source: AA6agR59okDv54Jbyi23A1nS9MzE8+afV+r+Jcam4JHKwd+90O+ezON9z+HSSTGcj+W/yIAHzcTIOm3wlGcNWGs75oc=
X-Received: by 2002:a05:651c:4d4:b0:261:cbe7:e62f with SMTP id
 e20-20020a05651c04d400b00261cbe7e62fmr2347049lji.295.1661198952956; Mon, 22
 Aug 2022 13:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-21-ojeda@kernel.org>
In-Reply-To: <20220805154231.31257-21-ojeda@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 Aug 2022 13:09:00 -0700
Message-ID: <CAKwvOdndYxQ+KgVhC8F3vWnHDT8pD3px8cKjinu-khn25_FSYw@mail.gmail.com>
Subject: Re: [PATCH v9 20/27] scripts: add `rust_is_available.sh`
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Finn Behrens <me@kloenk.de>, Miguel Cano <macanroj@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 5, 2022 at 8:46 AM Miguel Ojeda <ojeda@kernel.org> wrote:
>
> This script tests whether the Rust toolchain requirements are in place
> to enable Rust support.

With this, I get:

$ make LLVM=1 rustavailable
***
*** libclang (used by the Rust bindings generator 'bindgen')
*** version does not match Clang's. This may be a problem.
***   libclang version: 15.0.0
***   Clang version:    16.0.0
***
Rust is available!

because I'm using clang built from source from ToT.  Is this supposed
to mean that I can't use clang-16, clang-14, clang-13, clang-12, or
clang-11 (in the kernel we support clang-11+) in order to use rust?
I'm guessing that's going to hinder adoption.  Is there a way to
specify which libclang version bindgen should be using?

I have libclang built in my clang sources,
llvm-project/llvm/build/lib/libclang.so.  I also tried:

$ CLANG_PATH=/android0/llvm-project/llvm/build/lib/libclang.so.15 make
LLVM=1 -j72 rustavailable
$ CLANG_PATH=/android0/llvm-project/llvm/build/lib/libclang.so make
LLVM=1 -j72 rustavailable

-- 
Thanks,
~Nick Desaulniers

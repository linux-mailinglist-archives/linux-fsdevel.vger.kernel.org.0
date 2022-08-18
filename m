Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189735989CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Aug 2022 19:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344094AbiHRRGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Aug 2022 13:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345456AbiHRRD1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:03:27 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873CCCB5F1;
        Thu, 18 Aug 2022 10:01:37 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id c4so721873iof.3;
        Thu, 18 Aug 2022 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=T7igz+JHo+DrCDKUS4xWUJ3/Lp268Fiqe+ivN8o+tCA=;
        b=mSmp9rHtVwSbvQYUCcl1B6+4w12c4NZupPfwhitjKwp64SgVF4OpQZTM5OjLoTUTq/
         bvlbPn/LMeKbRiglU8JNMoyfa9evwumI8CLFupqetQdHEK6ASSyTUQKMARKS6+J8d41C
         syh/FDLqz69ZOMnbwXYSw27NnA/SdwWXPsCZG/OkbTJ3TeRryGQaM9pefDmG20OB855W
         Pg/ZEny4IK0cVtgltjxaukuxnPCqRSVwGGN3R+gsz1dnG13VOb8meRsL2IYZz+ic/ZYT
         3+DVKOsefTIeUcl4hA+wuKfu9fKsVZ5i0F7XDoWk47lyfxro942KIc/TnSD31+zljHZs
         2m+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=T7igz+JHo+DrCDKUS4xWUJ3/Lp268Fiqe+ivN8o+tCA=;
        b=ZiOJYSEqIf3HoypENj/fCoR7hClsGJda4huvMVs1yEbErtAQ7OylVNpp8b5Vxf0wlX
         kELR6LhttQ2icRsbEONYu+MV1LH6d8qq4vfPpJBx2SGNifDkgv+fbjiU3ypUvLBUya0c
         Xa3BTU1gwSZfwrc9oASN8vSru7lwmFsHLRmVkN4sFddieNLL8LVP1HbPSZTIiNekYRGm
         Dks9nU7aCnNSk0dGpTk1eXy2/HSIrvE/gOE1MRwWv3FhExSTyvJuqlERLN94yNMxBwBd
         ORkNdzONFGyfJ9k85qCf/Q+FTVRGax0evzlEBLePRySWTaveYEoHVxFn7z9i7CwLlk1t
         iqQw==
X-Gm-Message-State: ACgBeo39bUsoEvVV0rrIo7F0QjrD8DYf2p/a44+JqamBJSNuf7TJ/7i7
        wHa1+nNhGQAwJu6VnV0KRbzpbg8jkcnR5LC0g9Q=
X-Google-Smtp-Source: AA6agR5ue0JYy9T5byXdp26N17IarelQjKYAQisDC3hxB9tZlGD0vKInrJQ3a9Wk2MjOxtbHTGvUCzfa3vGBxwGqww0=
X-Received: by 2002:a05:6602:2a42:b0:678:84be:c9ec with SMTP id
 k2-20020a0566022a4200b0067884bec9ecmr1767428iov.64.1660842096984; Thu, 18 Aug
 2022 10:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220805154231.31257-1-ojeda@kernel.org> <20220805154231.31257-7-ojeda@kernel.org>
 <202208171240.8B10053B9D@keescook> <CANiq72nR2eAeKrY6v=hnjUjvwfecMsSC6eXTwaei6ecnHjia8g@mail.gmail.com>
 <202208171331.FAACB5AD8@keescook> <CANiq72=6nzbMR1e=7HUAotPk-L00h0YO3-oYrtKy2BLcHVDTEw@mail.gmail.com>
 <202208171653.6BAB91F35@keescook> <CANiq72mqutW7cDjYQv4qOYOAV6uM8kUWenquQyiG-mEw4DURJA@mail.gmail.com>
 <202208180905.A6D2C6C00@keescook>
In-Reply-To: <202208180905.A6D2C6C00@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 18 Aug 2022 19:01:25 +0200
Message-ID: <CANiq72=BbV-h6P1z7pSg7oMjXoMOuUjhaiB-sYGJu4uyE0BPKQ@mail.gmail.com>
Subject: Re: [PATCH v9 06/27] rust: add C helpers
To:     Kees Cook <keescook@chromium.org>
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
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 18, 2022 at 6:08 PM Kees Cook <keescook@chromium.org> wrote:
>
> Please, no UB. I will take a panic over UB any day. It'd be best to
> handle things with some error path, but those are the rare exception.
>
> C is riddled with UB and it's just terrible. Let's make sure we don't
> continue that mistake. :)

I definitely agree on avoiding UB :)

> The simple answer is that if an "impossible" situation can be recovered
> from, it should error instead of panic. As long as that's the explicit
> design goal, I think we're good. Yes there will be cases where it is
> really and truly unrecoverable, but those will be rare and can be well
> documented.

Yeah, that is the goal and we always take that into account, but there
are always tricky cases which is best to consider case-by-case.

Cheers,
Miguel

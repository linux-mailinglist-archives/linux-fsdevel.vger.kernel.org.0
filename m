Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1B15EC559
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 16:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiI0OCX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 10:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiI0OB5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:01:57 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C77AED8F;
        Tue, 27 Sep 2022 07:01:12 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r134so7785141iod.8;
        Tue, 27 Sep 2022 07:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=DyaVo3+lMzTcUfudleYugyX5eghJmiI4XJiWCxqbggY=;
        b=LHvf/mqnPOMJ9jL0cy3ik7mshxI0ktIgXgIZoGbE6+/5menga1hXjWEhRj3thykjNN
         sRWPJ1QHAGtJOAHY8uu3J1KEyWSoo5h/5Wfzh3VzCDHmwddRTwI/r+shjRPDZe63NXtz
         xOg9cMpBfPxLEM3CjTMDUZ+xL8OP6MJe8V0SPvic6/XvtQBRGHfzXXSvV8qRklW5DPjN
         /E6CZhL9ixRoUP+7fH0XSAU0Ur9A40X2dPhWAF0NvnpM6pLtlWYWVXbfJFD68kHAvHXf
         K57n4DCCeruRap/T2pjq2IvqrdBsPEcQAXBpo+W0sF/8xKkMtlQ/bKLv6l4kEey7ziTw
         WIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=DyaVo3+lMzTcUfudleYugyX5eghJmiI4XJiWCxqbggY=;
        b=DitJuluI12am1Vw2VGxPhxib0JoBIKddDhidoHE2xulPiCRJktWta5xvUnVZ0PxdrW
         B+X7sCt+2OzJKzzsFpBbUMTmNOrXi1O8AfdyIPuWemEEpWXbXS9IzA9vB6aHFcDDPkTa
         GkpixVTnvzH8jg2qLggwMX3NDvf+Xt+Y1cM4s2cSaqlbALXfkWQtTyOqPSRf0DobmqT4
         x2sJgRT9vSUsyU/cawtC0vZ/V33KzLENg54D4gi06ohV/zCuV6CbLwdXQhzZh3o3Ylmp
         UULL2vY809G40P/9Yy/RPyPhNqrPD64Cae+GgHKRWvpl58a/Dr5K/e4ffLEDlS+2KtW3
         yLtg==
X-Gm-Message-State: ACrzQf00MSgUIbkDQaWv9VzOo8D4SvmkBYrooXDDoH7zhYL6A9CPP7Ih
        /Ylvlhena5fe0uj77LKeBAkqH5Z6ShHk/ExLGo0=
X-Google-Smtp-Source: AMsMyM7ih95kfEqXr/sO68fs24aizZEEsCMT/+AVTJKPYG7G7n20Q70D7m5R6BLcryt+9rRao44muZd3E5XhQMAGlcQ=
X-Received: by 2002:a6b:6f11:0:b0:69f:db1b:f4a7 with SMTP id
 k17-20020a6b6f11000000b0069fdb1bf4a7mr11582661ioc.177.1664287271842; Tue, 27
 Sep 2022 07:01:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-11-ojeda@kernel.org>
 <YzL/FfwKoL5eBiWS@yadro.com>
In-Reply-To: <YzL/FfwKoL5eBiWS@yadro.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 27 Sep 2022 16:01:00 +0200
Message-ID: <CANiq72kV_R-_SkFdNRTr75jvk-HOUZ07WH6gU+d-nXaY41Czdg@mail.gmail.com>
Subject: Re: [PATCH v10 10/27] rust: add `macros` crate
To:     Konstantin Shelekhin <k.shelekhin@yadro.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Gary Guo <gary@garyguo.net>, Matthew Bakhtiari <dev@mtbk.me>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 27, 2022 at 3:48 PM Konstantin Shelekhin
<k.shelekhin@yadro.com> wrote:
>
> I remember that there was a switch from &u8 to &str on master branch a
> while ago. Why this patch was reverted? Strings are really better here.

It was not reverted; but it was merged right after v8. Then v9 was a
trimmed v8 and v10 is intended to resolve a few last nits from v9.

In other words, there are many changes (including the vast majority of
the `kernel` crate) that will come afterwards.

Please see the cover letter(s) for details.

Cheers,
Miguel

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137D25EC8A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 17:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiI0Pxv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 11:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiI0Px1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:53:27 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FFBDEFF7D;
        Tue, 27 Sep 2022 08:53:24 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r134so8070039iod.8;
        Tue, 27 Sep 2022 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tUHp2nHddiilENT+8Cae200wA2dTxcOTzzNtjUo2Ijw=;
        b=H8CRnUPOCIjgovWiquSsLuWyIJJ1m1yYV9n8LRjmBPqtPS/gT5N4I0Tu7+l69T2+T6
         QvMDeRjcyhE+C4PKcvAzR4+4oGBKRL/oqmflDu7gg9an4wL0irf+XVtuBNLSVEuLuy4t
         bdG6O8KOHICb2BbZgBEyBQ0bWhAAQxMbNk+yoF0tMuXd8+MKnTinQC0etp5KC8Zy9RfS
         YaMGSFmDwKS8GhaWYVELLJIw6efkA+zveMYo01833yWz7LdtwwiPRE/ScVzOJoCc+UOG
         rjKtaWWP3PylQhdeDEsvywUf6xFzcUP0BgLvY9x0ZQKrzcsCabYXpIPcEdvGz+3SwUE4
         Iw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tUHp2nHddiilENT+8Cae200wA2dTxcOTzzNtjUo2Ijw=;
        b=S8hXEICBH0l3IChqy1/AplTSB/fid1HDTAmFEH2nKSl5rGyw4Cna/aI4qpySOgwbK/
         QhoaKXU6c9nqubJsadLvS63kCAOAesO/+NsjkJAGjWuTgkbIvq0IRAqnGcNkkKIIf7l3
         r2xwnduoYZHHXpP9+cPtJ3CQ5VMu/66E455nlL7GFH++6t6geNGFSK6xobrWA8yYavsl
         fh/+ROoTupn4OFon61Du/hKSadGDfBEXOuhDCjE1xeKEqH7szeulVf3uXXmVdAyoYXGc
         xgKlgAGh5VNCVoinpXkTWRiplcV6zFbaGcOqR7ShN3qW+aSRs3Y+hcJ2C/8NC3an3RwN
         BZyw==
X-Gm-Message-State: ACrzQf1hMZtdkaKmZmPFmTD+GFyDWM1roIZdXkYXMp8K8SmWMKJ4QwM5
        fPUB9kam6eDL/9Jkp2bdoHaceDRltB7eix7FCmE=
X-Google-Smtp-Source: AMsMyM4zX7hRygDuErXpVsOgtg9pYghLaYPrwHXI3wKDVg0monRfyJcd0mKU8ygB3ifILSCT/B4YZcMPfqK5UKckPk4=
X-Received: by 2002:a05:6602:134f:b0:6a4:cd04:7842 with SMTP id
 i15-20020a056602134f00b006a4cd047842mr3620542iov.172.1664294003136; Tue, 27
 Sep 2022 08:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220927131518.30000-1-ojeda@kernel.org> <20220927131518.30000-28-ojeda@kernel.org>
 <20220927141137.iovhhjufqdqcs6qn@gpm.stappers.nl> <202209270818.5BA5AA62@keescook>
 <YzMX91Kq6FzOL9g/@kroah.com>
In-Reply-To: <YzMX91Kq6FzOL9g/@kroah.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 27 Sep 2022 17:53:12 +0200
Message-ID: <CANiq72kyW-8Gzeex4UCMqQPCrYyPQni=8ZrRO1dQsUwDmAPedw@mail.gmail.com>
Subject: Re: [PATCH v10 27/27] MAINTAINERS: Rust
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Stappers <stappers@stappers.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Maciej Falkowski <maciej.falkowski9@gmail.com>
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

On Tue, Sep 27, 2022 at 5:34 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> How about just fixing up the emails in these patches, which will keep us
> from having bouncing ones for those of us who do not use the .mailmap
> file.

Sorry about that...

One question: if somebody wants to keep the Signed-off-bys and/or Git
authorship information using the old email for the patches (except the
`MAINTAINERS` entry), is that OK? (e.g. maybe because they did most of
the work in their previous company).

Cc'ing Maciej since I got a bounce too: is it OK using your personal address?

Thanks!

Cheers,
Miguel

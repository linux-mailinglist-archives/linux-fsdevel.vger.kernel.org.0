Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88F207B4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 20:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406009AbgFXSP5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 14:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405077AbgFXSP4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:15:56 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8FBC0613ED
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 11:15:55 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g139so1776715lfd.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 11:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XkMPqFGg3Z9t3pKSW7EQdgR0p5ZS5h1HQ2kcYfNc4oY=;
        b=I4oYR4UFlrSkS+lsSplS1Wen1OyhGJ+Bm39JW32/eY0EXQdEn6PwTVYQ8ooareybhe
         CRMemJO1LvwuBzfIU1d38zDYPuiGpr0giXIyWx7kAEQi3yTvWtxgbIsunEjMLWpnhYgm
         DEgAt2QR2CcMBG818IO+fdcDgWT2/wW9NEcZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XkMPqFGg3Z9t3pKSW7EQdgR0p5ZS5h1HQ2kcYfNc4oY=;
        b=d5wyDDPfuSHQy5Sec+Q5ZpvhsWXPEhsSKDxOUk3KrzVG47RoFNXxVczBJHYpgVFNQK
         3eYMgxi7KdZg3pr70OQ3b/eFmGVizjdUlQAW9wryz1DAMAg62/xUzZWaF198IYiaWRx+
         /AWurDlpcLziET4oCNI5zAxnGwCygWU2hk5HtQfA/mZ0l1vpdDEevoCxvU8ik9jG3jf+
         uuilMSQKOq/PH/endEOQqfpHuXVFzBJ8JAclGrHTWXNiEe9fpt/LQVvJrsfnizEYReO/
         ghg7LHrHMfdtFHO5w0zg/airGwxowz8TNnCT4i2HJ5HpDLUVeNBDd2ItS/SfIQWuoYSE
         1PMw==
X-Gm-Message-State: AOAM533dh0y6DeEAAyiiqyUAQcDSfTYQ506QNtgenxht8oR/Ot64jSda
        RnYuaQeYRNF35f45f7oXLXxqKMd79+g=
X-Google-Smtp-Source: ABdhPJydrYBVwTE4/BmvUB69VTYmDAOWA/l+U6mm1FN79Y3+N9YKY5plE2i3HXRP3DQYne5NTdLbiw==
X-Received: by 2002:ac2:51a1:: with SMTP id f1mr16316823lfk.173.1593022553397;
        Wed, 24 Jun 2020 11:15:53 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id k6sm1634971lfm.89.2020.06.24.11.15.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 11:15:52 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id b25so16418ljp.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 11:15:52 -0700 (PDT)
X-Received: by 2002:a2e:9209:: with SMTP id k9mr4921683ljg.421.1593022551983;
 Wed, 24 Jun 2020 11:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
In-Reply-To: <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Jun 2020 11:15:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGNzGz=Pv5UZMWuTxg=3KbLBBPPQ2T7k+295UebgKJAg@mail.gmail.com>
Message-ID: <CAHk-=wiGNzGz=Pv5UZMWuTxg=3KbLBBPPQ2T7k+295UebgKJAg@mail.gmail.com>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 11:11 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So in *those* cases, we'd basically just do "oh, ok, we are supposed
> to use a kernel pointer" based on the setfs value.

The important part here si that we don't need to change any
interfaces, because we don't add that whole "carry the bit around with
the pointer".

I agree that that would be the nice clean interface _if_ we intended
for this to be something we care about. But we already _have_ that
interface in the "iter" code, I absolutely do not think we should
create a new one.

So that's why the (admittedly hacky) "just support the old model for
special cases" kind of approach. Make it really easy to convert some
very specific individual places that might care, and make it very
obvious what those places are.

Maybe in a year or two, there's only a couple such places, and we can
see if we can clean those up separately. But make it easy do the
transition to the new model by _not_ changing the basic logic for now.

See what I'm aiming for?

In particular, for architectures that haven't been modified, this
results in zero changes what-so-ever.

            Linus

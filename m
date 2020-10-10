Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30A0289D96
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Oct 2020 04:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgJJClI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 22:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729580AbgJJBhg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 21:37:36 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8EBC0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Oct 2020 18:37:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id u21so15710865eja.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2020 18:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TL4cwcC3oy9yGXrCPN5M4+HoSQktOSj4hTD8XUaFtsk=;
        b=QUiZW7sc85a+dF87QrbXxq2KTodKggKcduyYT3bL6iRpsp3sgK+dJqXe00Rkr1oRmE
         0Q8iGj6Eoh8nHgmhwmUz1o2eQQJjkWTB80i7gsGyB9/jzaKGM86w97n/T1/Qg4RgrKKx
         Q30PjASdGXDKOZ6VrsgGinXqAdW3g6MlMxMzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TL4cwcC3oy9yGXrCPN5M4+HoSQktOSj4hTD8XUaFtsk=;
        b=TLwBekETmCSn/fPkuN6Uit5FRTbAsZ9JJDKT6Xs24gFxj4TqzsfbK7z0U5mDeXH3u/
         YX+Z/aj9SmAoRy7mG+mpZxjw0ugztwCeB7uAle6F4xcvLpdX9JwKU5Y2e3edyojD1Isy
         uAGxKrCVbDwTAp+5VDkrQ5x/FQP4ZUQYMF7y4AbzSjmAu9m9Sj8N0CgdezQ48JJxiamW
         QqnHXvDnsu49FpOpbc1+2UyQHH1WXG57cmsl3pP2XxvslyO+XwZruVdxs8xxnRieefpj
         7aFrB6aKe2BYDnIAAOiyZ3opxcJ56t36ik81oTZcipnC6UwM9vYZoO8H7aKwXP1MmcWo
         21uw==
X-Gm-Message-State: AOAM533GPTpO3hsCU12RqoUWBicZRmTRK4Rmt4Qq8ZW1kRbhQrIQDrvB
        QNWOPiH6HgMdcyQnM82ue/lHq+1bTat9Fg==
X-Google-Smtp-Source: ABdhPJw9vmA2bs6Nfao62zuoSaClZAe95vTrNvfVJ7z0cDok0GkyOXHQM5tfujDncoOP2UQ7JY75kA==
X-Received: by 2002:a17:906:aad5:: with SMTP id kt21mr16958487ejb.5.1602293838142;
        Fri, 09 Oct 2020 18:37:18 -0700 (PDT)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id b25sm6848277eds.66.2020.10.09.18.37.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 18:37:17 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id y12so6688333wrp.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Oct 2020 18:37:17 -0700 (PDT)
X-Received: by 2002:a2e:9152:: with SMTP id q18mr5731594ljg.421.1602293368914;
 Fri, 09 Oct 2020 18:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200903142242.925828-1-hch@lst.de> <20200903142242.925828-6-hch@lst.de>
 <20201001223852.GA855@sol.localdomain> <20201001224051.GI3421308@ZenIV.linux.org.uk>
 <CAHk-=wgj=mKeN-EfV5tKwJNeHPLG0dybq+R5ZyGuc4WeUnqcmA@mail.gmail.com>
 <20201009220633.GA1122@sol.localdomain> <CAHk-=whcEzYjkqdpZciHh+iAdUttvfWZYoiHiF67XuTXB1YJLw@mail.gmail.com>
 <20201010011919.GC1122@sol.localdomain>
In-Reply-To: <20201010011919.GC1122@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 9 Oct 2020 18:29:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigvcmp-jcgoNCbx45W7j3=0jA320CfpskwuoEjefM7nQ@mail.gmail.com>
Message-ID: <CAHk-=wigvcmp-jcgoNCbx45W7j3=0jA320CfpskwuoEjefM7nQ@mail.gmail.com>
Subject: Re: [PATCH 05/14] fs: don't allow kernel reads and writes without
 iter ops
To:     Eric Biggers <ebiggers@kernel.org>,
        Alexander Viro <aviro@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 9, 2020 at 6:19 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> Okay, that makes more sense.  So the patchset from Matthew
> https://lkml.kernel.org/linux-fsdevel/20201003025534.21045-1-willy@infradead.org/T/#u
> isn't what you had in mind.

No.

That first patch makes sense - it's just the "ppos can be NULL" patch.

But as mentioned, NULL isn't "shorthand for zero". It's just "pipes
don't _have_ a pos, trying to pass in some explicit position is
crazy".

So no, the other patches in that set are a bit odd, I think.

SOME of them look potentially fine - the bpfilter one seems to be
valid, for example, because it's literally about reading/writing a
pipe. And maybe the sysctl one is similarly sensible - I didn't check
the context of that one.

But no, NULL shouldn't mean "start at position zero, and we don't care
about the result".

              Linus

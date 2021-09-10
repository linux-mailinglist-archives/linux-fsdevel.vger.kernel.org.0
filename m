Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3274071B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 21:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhIJTLs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 15:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhIJTLr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 15:11:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8BAC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 12:10:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t19so6007484lfe.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O+kk743scj4vQ3QtINkHDre6/4jEJJ4749GFq5mUTx4=;
        b=eKLWgpcpn9OANXNGYiqnFDT13PZcMsJeDEn9Rs2myjv61X5TE9VAPYJ84lduvNrUtK
         AHqewLaLF8mTpfd2orazz1Y+fJBfxtZfondH5rrQjdsZyqV0w/4TdJrDX8LjxW0q44t/
         ofLwcwjgnhW3kMy+wdI98byWSe/3UPzwO74AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O+kk743scj4vQ3QtINkHDre6/4jEJJ4749GFq5mUTx4=;
        b=I09bkvJMDztKe3qqRU5pCTrCvToqGSPsfzKS6nCVLPnZyrSdYLqixF704d8l1Pz+Sf
         11NQwQ/4sOSmveA3IxQIFrH14kXEXhigB5AiCtYxyKWZyUfaqqz2m+uXBWkVahPC7P7L
         D268ddRWFOWZ0ru/GOyrh68ACX410Uf3fvIkyM2ZuN0uDewxOB/LGuI9OardgpAFz/gg
         QvZYopD0NHFHzZq863m1snDMWpZX7Q8eRclXLMaBVYEyRAAOz7DaXuFpLx9rvc+JMj0U
         kj5L91MoHUU56js/4hqWcXVG3DFPb2ypavVN1XRIYK1vUDN146+1koXeMWht158DwPOv
         OR6g==
X-Gm-Message-State: AOAM531GLwn16mGuXKSLfuU92aYIMcg62XL5mt1JFEmGorwvzMhDC7Hd
        KfSS5PHiZQUl0HjHzBYYk5PbtKOOB4yXehBW3og=
X-Google-Smtp-Source: ABdhPJwTeZD/9jaQhacEbQuZmoFp+2CAGhGdQOh+5BkCEzi7jUum1JkSBRW4XEtuHvNOS7gjxff6Uw==
X-Received: by 2002:ac2:4103:: with SMTP id b3mr5054633lfi.685.1631301033830;
        Fri, 10 Sep 2021 12:10:33 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id g2sm634917lfu.139.2021.09.10.12.10.32
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 12:10:33 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id a4so6041125lfg.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 12:10:32 -0700 (PDT)
X-Received: by 2002:a05:6512:2611:: with SMTP id bt17mr5149905lfb.141.1631301032359;
 Fri, 10 Sep 2021 12:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk> <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk> <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
 <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk> <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
 <YTuOPAFvGpayTBpp@zeniv-ca.linux.org.uk> <CAHk-=wiPEZypYDnoDF7mRE=u1y6E_etmCTuOx3v2v6a_Wj=z3g@mail.gmail.com>
 <b1944570-0e72-fd64-a453-45f17e7c1e56@kernel.dk> <CAHk-=wjWQtXmtOK9nMdM68CKavejv=p-0B81WazbjxaD-e3JXw@mail.gmail.com>
 <YTuogsGTH5pQLKo7@zeniv-ca.linux.org.uk> <CAHk-=wg8O4NBTUr9GvNo=vnUmONUGYypN4dFr7QNEGUFcN=tBw@mail.gmail.com>
In-Reply-To: <CAHk-=wg8O4NBTUr9GvNo=vnUmONUGYypN4dFr7QNEGUFcN=tBw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Sep 2021 12:10:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJ_iDEQtDTjU-+QKgob1xnQzfqsn6Xm4FL+sn1Uqw-BQ@mail.gmail.com>
Message-ID: <CAHk-=wiJ_iDEQtDTjU-+QKgob1xnQzfqsn6Xm4FL+sn1Uqw-BQ@mail.gmail.com>
Subject: Re: [git pull] iov_iter fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 10, 2021 at 12:04 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So only 'struct iovec' and 'struct kvec' actually have the same format
> and can be used interchangeably.

That was very badly and confusingly phrased. They obviously don't
actually have the same format, and cannot be used interchangeably in
general.

But the pointer arithmetic works the same for those two union members,
so for that very specific case (and _only_ that) you can treat them as
equivalent and use them interchangeably.

Al clearly understood that, but I just wanted to clarify my phrasing
for anybody else reading this thread. Please don't use the iov/kvec
members interchangeably in general.

              Linus

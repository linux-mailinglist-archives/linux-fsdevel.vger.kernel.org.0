Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9D740701D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 18:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbhIJRAT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 13:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbhIJRAP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 13:00:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C064C061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 09:59:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c8so5375589lfi.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 09:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D8yFX4Q94YmYHxzL7n/3cToI7Z/3C43UpIFGo8WulAM=;
        b=FPixukG8c7JoNdjCS7rYkg5B9TVUHdRr6eniODRUP1lox3uZIaCEGMC3TLHcA0gyh4
         fly16EJvYc0rvyUzvddLJvWAOMdKr6vEJ3HlRM8BvQPHemiMBMYNmo3CsdKCNnl+i9y8
         c7kPiF3DaorkH9BGk8Oz3dj11zsUmilRI5aC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D8yFX4Q94YmYHxzL7n/3cToI7Z/3C43UpIFGo8WulAM=;
        b=pVhvSAnmWHe66Uwd7/lTOF3rJY/riylzvynGYtqZO2aEiq6MCKCMeL1ikN3MOPK6aX
         Ks9gIf1xDnWj4/M2yOr2Gl+u/6bCIiV/jQK4881W9EH6I7KXO+89+Qwf1HH6rSKh2GVc
         T6CqkHKucqzNARoSCIv/RJZVARtpHGHJOjqEnfKkWEmpCZrZwh1B34gszTGJmwC6O6sy
         E5ap/3XMc23UWz2kmP6qd82DfjbfxyyYUlfxMgPPYtABo/va3fRJCNwCZNXZbrbIJZV5
         vAIVz2CmuFcG59teFDvJoPEx678NQuzxhR8vkaQmNOckKQjUxtZeFr5JGHNlEd6EuD63
         pThw==
X-Gm-Message-State: AOAM5326+kH00qha5pCwno2yiImhc08bwoNBeZiAHE5xYl5XdAgW/Oqx
        KIEkn+PLlxppcpng1i4Oz0IzZcuRLLoBDvqU1nE=
X-Google-Smtp-Source: ABdhPJw50aL3zFyQpvgcmcFBcrKWjaIxqPQEA8srZYi/SPDWdVLUkJ1OdSCcn4uYPCvGCOPmfqR+0Q==
X-Received: by 2002:a19:4846:: with SMTP id v67mr4669783lfa.478.1631293142127;
        Fri, 10 Sep 2021 09:59:02 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id i12sm639252ljm.116.2021.09.10.09.59.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 09:59:01 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id k4so5349536lfj.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 09:59:00 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr4680811lfv.655.1631293140722;
 Fri, 10 Sep 2021 09:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk> <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
 <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk> <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
 <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk> <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk> <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
 <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk> <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
 <YTuOPAFvGpayTBpp@zeniv-ca.linux.org.uk>
In-Reply-To: <YTuOPAFvGpayTBpp@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Sep 2021 09:58:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPEZypYDnoDF7mRE=u1y6E_etmCTuOx3v2v6a_Wj=z3g@mail.gmail.com>
Message-ID: <CAHk-=wiPEZypYDnoDF7mRE=u1y6E_etmCTuOx3v2v6a_Wj=z3g@mail.gmail.com>
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

On Fri, Sep 10, 2021 at 9:56 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What's the point of all those contortions, anyway?  You only need it for
> iovec case; don't mix doing that and turning it into flavour-independent
> primitive.

Good point, making it specific to iovec only gets rid of a lot of
special cases and worries.

This is fairly specialized, no need to always cater to every possible case.

               Linus
